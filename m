Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FA185BCC73
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 15:04:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbiISNDy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 09:03:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbiISNDg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 09:03:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB6FF2315B
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 06:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663592614;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CkDJXq7D9p4QucT5wyBaOZNb9Da5b1c3Du7UH8P2FVg=;
        b=cWHR8t4Xwv6cX7r6muCMEkGZW8J0okHp3CSL7fZ6IjyAi89CJlY/lH4c/2m1u1kT40Dwxh
        oDFQvdutGEzd1ygHqbXgoD/tJ1nUgD9f+2jkCxONPFm3bZtPBx9hZ8m+A0j7rHxweyegTb
        vv9nuYwGwAX6oL6RKGgxq+xdeRc8UWg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-265-HGUsi31uOPeT9V9wO1d57w-1; Mon, 19 Sep 2022 09:03:33 -0400
X-MC-Unique: HGUsi31uOPeT9V9wO1d57w-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 10EDB101A528;
        Mon, 19 Sep 2022 13:03:33 +0000 (UTC)
Received: from T590 (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 17F62492B04;
        Mon, 19 Sep 2022 13:03:28 +0000 (UTC)
Date:   Mon, 19 Sep 2022 21:03:23 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     ZiyangZhang <ZiyangZhang@linux.alibaba.com>
Cc:     axboe@kernel.dk, xiaoguang.wang@linux.alibaba.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        joseph.qi@linux.alibaba.com
Subject: Re: [PATCH V3 6/7] ublk_drv: add START_USER_RECOVERY and
 END_USER_RECOVERY support
Message-ID: <Yyhom5s4AxK+wSu4@T590>
References: <20220913041707.197334-1-ZiyangZhang@linux.alibaba.com>
 <20220913041707.197334-7-ZiyangZhang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220913041707.197334-7-ZiyangZhang@linux.alibaba.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 13, 2022 at 12:17:06PM +0800, ZiyangZhang wrote:
> START_USER_RECOVERY and END_USER_RECOVERY are two new control commands
> to support user recovery feature.
> 
> After a crash, user should send START_USER_RECOVERY, it will:
> (1) check if (a)current ublk_device is UBLK_S_DEV_QUIESCED which was
>     set by quiesce_work and (b)the file struct is released.
> (2) reinit all ubqs, including:
>     (a) put the task_struct and reset ->ubq_daemon to NULL.
>     (b) reset all ublk_io.
> (3) reset ub->mm to NULL.
> 
> Then, user should start a new process and send FETCH_REQ on each
> ubq_daemon.
> 
> Finally, user should send END_USER_RECOVERY, it will:
> (1) wait for all new ubq_daemons getting ready.
> (2) update ublksrv_pid
> (3) unquiesce the request queue and expect incoming ublk_queue_rq()
> (4) convert ub's state to UBLK_S_DEV_LIVE
> 
> Note: we can handle STOP_DEV between START_USER_RECOVERY and
> END_USER_RECOVERY. This is helpful to users who cannot start new process
> after sending START_USER_RECOVERY ctrl-cmd.
> 
> Signed-off-by: ZiyangZhang <ZiyangZhang@linux.alibaba.com>
> ---
>  drivers/block/ublk_drv.c | 116 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 116 insertions(+)
> 
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index 4409a130d0b6..3a3af80ee938 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -1961,6 +1961,116 @@ static int ublk_ctrl_set_params(struct io_uring_cmd *cmd)
>  	return ret;
>  }
>  
> +static void ublk_queue_reinit(struct ublk_device *ub, struct ublk_queue *ubq)
> +{
> +	int i;
> +
> +	WARN_ON_ONCE(!(ubq->ubq_daemon && ubq_daemon_is_dying(ubq)));
> +	/* All old ioucmds have to be completed */
> +	WARN_ON_ONCE(ubq->nr_io_ready);
> +	pr_devel("%s: prepare for recovering qid %d\n", __func__, ubq->q_id);
> +	/* old daemon is PF_EXITING, put it now */
> +	put_task_struct(ubq->ubq_daemon);
> +	/* We have to reset it to NULL, otherwise ub won't accept new FETCH_REQ */
> +	ubq->ubq_daemon = NULL;
> +
> +	for (i = 0; i < ubq->q_depth; i++) {
> +		struct ublk_io *io = &ubq->ios[i];
> +
> +		/* forget everything now and be ready for new FETCH_REQ */
> +		io->flags = 0;
> +		io->cmd = NULL;
> +		io->addr = 0;
> +	}
> +}
> +
> +static int ublk_ctrl_start_recovery(struct io_uring_cmd *cmd)
> +{
> +	struct ublksrv_ctrl_cmd *header = (struct ublksrv_ctrl_cmd *)cmd->cmd;
> +	struct ublk_device *ub;
> +	int ret = -EINVAL;
> +	int i;
> +
> +	ub = ublk_get_device_from_id(header->dev_id);
> +	if (!ub)
> +		return ret;
> +
> +	mutex_lock(&ub->mutex);
> +	if (!ublk_can_use_recovery(ub))
> +		goto out_unlock;
> +	/*
> +	 * START_RECOVERY is only allowd after:
> +	 *
> +	 * (1) UB_STATE_OPEN is not set, which means the dying process is exited
> +	 *     and related io_uring ctx is freed so file struct of /dev/ublkcX is
> +	 *     released.
> +	 *
> +	 * (2) UBLK_S_DEV_QUIESCED is set, which means the quiesce_work:
> +	 *     (a)has quiesced request queue
> +	 *     (b)has requeued every inflight rqs whose io_flags is ACTIVE
> +	 *     (c)has requeued/aborted every inflight rqs whose io_flags is NOT ACTIVE
> +	 *     (d)has completed/camceled all ioucmds owned by ther dying process
> +	 */
> +	if (test_bit(UB_STATE_OPEN, &ub->state) ||
> +			ub->dev_info.state != UBLK_S_DEV_QUIESCED) {
> +		ret = -EBUSY;
> +		goto out_unlock;
> +	}
> +	pr_devel("%s: start recovery for dev id %d.\n", __func__, header->dev_id);
> +	for (i = 0; i < ub->dev_info.nr_hw_queues; i++)
> +		ublk_queue_reinit(ub, ublk_get_queue(ub, i));
> +	/* set to NULL, otherwise new ubq_daemon cannot mmap the io_cmd_buf */
> +	ub->mm = NULL;
> +	ub->nr_queues_ready = 0;

I am wondering why you don't move the above(queue reinit, clearing ub->mm)
into ublk_ch_release(), and looks it is more clean to clear this stuff
there. Meantime I guess one control command might be enough for user
recovery.


Thanks, 
Ming

