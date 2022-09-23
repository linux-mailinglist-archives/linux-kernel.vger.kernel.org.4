Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B6395E71B8
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 04:03:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230237AbiIWCDk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 22:03:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232225AbiIWCDh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 22:03:37 -0400
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F92D118B37;
        Thu, 22 Sep 2022 19:03:36 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R951e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=ziyangzhang@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0VQUivRf_1663898613;
Received: from 30.97.56.82(mailfrom:ZiyangZhang@linux.alibaba.com fp:SMTPD_---0VQUivRf_1663898613)
          by smtp.aliyun-inc.com;
          Fri, 23 Sep 2022 10:03:34 +0800
Message-ID: <caf0bfbf-18d2-e936-4bbd-3e728a567de5@linux.alibaba.com>
Date:   Fri, 23 Sep 2022 10:03:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.0
Subject: Re: [PATCH V5 6/7] ublk_drv: allow new process to open ublk chardev
 with recovery feature enabled
Content-Language: en-US
To:     ming.lei@redhat.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220922061734.21625-1-ZiyangZhang@linux.alibaba.com>
 <20220922061734.21625-7-ZiyangZhang@linux.alibaba.com>
From:   Ziyang Zhang <ZiyangZhang@linux.alibaba.com>
In-Reply-To: <20220922061734.21625-7-ZiyangZhang@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-11.8 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/9/22 14:17, ZiyangZhang wrote:
> With recovery feature enabled, if ublk chardev is ready to be released
> and quiesce_work has been scheduled, we:
> (1) reinit all ubqs, including:
>     (a) put the task_struct and reset ->ubq_daemon to NULL.
>     (b) reset all ublk_io.
> (2) reset ub->mm to NULL.
> Then ublk chardev is released and new process can open it.
> 
> RECOVER_DEV is introduced as a new ctrl-cmd for recovery feature.
> After the chardev is opened and all ubqs are ready, user should send
> RECOVER_DEV to:
> (1) wait until all new ubq_daemons getting ready.
> (2) update ublksrv_pid
> (3) unquiesce the request queue and expect incoming ublk_queue_rq()
> (4) convert ub's state to UBLK_S_DEV_LIVE
> (5) reschedule monitor_work
> 
> Signed-off-by: ZiyangZhang <ZiyangZhang@linux.alibaba.com>
> ---
>  drivers/block/ublk_drv.c      | 67 +++++++++++++++++++++++++++++++++++
>  include/uapi/linux/ublk_cmd.h |  1 +
>  2 files changed, 68 insertions(+)
> 
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index 3977869d2bc4..ac8bf497567f 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -898,10 +898,40 @@ static int ublk_ch_open(struct inode *inode, struct file *filp)
>  	return 0;
>  }
>  
> +static void ublk_queue_reinit(struct ublk_device *ub, struct ublk_queue *ubq)
> +{
> +	int i;
> +
> +	/* old daemon is PF_EXITING, put it now */
> +	if (ubq->ubq_daemon) {
> +		put_task_struct(ubq->ubq_daemon);
> +		/* We have to reset it to NULL, otherwise ub won't accept new FETCH_REQ */
> +		ubq->ubq_daemon = NULL;
> +	}
> +
> +	for (i = 0; i < ubq->q_depth; i++) {
> +		struct ublk_io *io = &ubq->ios[i];
> +
> +		/* forget everything now and be ready for new FETCH_REQ */
> +		io->flags = 0;
> +		io->cmd = NULL;
> +		io->addr = 0;
> +	}
> +	ubq->nr_io_ready = 0;
> +}
> +
>  static int ublk_ch_release(struct inode *inode, struct file *filp)
>  {
>  	struct ublk_device *ub = filp->private_data;
> +	int i;
>  
> +	pr_devel("%s: reinit queues for dev id %d.\n", __func__, ub->dev_info.dev_id);
> +	for (i = 0; i < ub->dev_info.nr_hw_queues; i++)
> +		ublk_queue_reinit(ub, ublk_get_queue(ub, i));
> +	/* set to NULL, otherwise new ubq_daemon cannot mmap the io_cmd_buf */
> +	ub->mm = NULL;
> +	ub->nr_queues_ready = 0;
> +	init_completion(&ub->completion);
>  	clear_bit(UB_STATE_OPEN, &ub->state);
>  	return 0;
>  }

This one is not correct. I will figure out how to correctly
put_task_struct(ubq->ubq_daemon) with recovery feature enabled.
