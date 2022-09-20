Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE9D35BDC02
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 07:05:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230062AbiITFFT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 01:05:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbiITFFO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 01:05:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 290AC4507D
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 22:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663650312;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yrNHPcnH5pHhLlVaGnkT/SYSCwxMBWkCRYx1m0ScmSo=;
        b=D+55Fm17uPlsA6HVqCV5xkvivbPH+arp7O0MWcg6N7OwI+U0hYoc5Uchho4k4gHGOe+OR+
        Bp6vMAUvdEBOY8pfiWnMxzH5mGCpBLLBPY/sOa329y9EkauNjBDB+BY69OGzdKz+uFn9To
        8qXa+0lHO5UUfzcXTcU+0/ZfO8DL0+s=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-516-m6s6kvc5Nhi1ZeJec1vpmA-1; Tue, 20 Sep 2022 01:05:06 -0400
X-MC-Unique: m6s6kvc5Nhi1ZeJec1vpmA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D8C81185A78B;
        Tue, 20 Sep 2022 05:05:05 +0000 (UTC)
Received: from T590 (ovpn-8-20.pek2.redhat.com [10.72.8.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E31B740C6EC2;
        Tue, 20 Sep 2022 05:05:00 +0000 (UTC)
Date:   Tue, 20 Sep 2022 13:04:53 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     ZiyangZhang <ZiyangZhang@linux.alibaba.com>
Cc:     axboe@kernel.dk, xiaoguang.wang@linux.alibaba.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        joseph.qi@linux.alibaba.com
Subject: Re: [PATCH V3 3/7] ublk_drv: define macros for recovery feature and
 check them
Message-ID: <YylJ9Qu5k5S5ZcJs@T590>
References: <20220913041707.197334-1-ZiyangZhang@linux.alibaba.com>
 <20220913041707.197334-4-ZiyangZhang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220913041707.197334-4-ZiyangZhang@linux.alibaba.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 13, 2022 at 12:17:03PM +0800, ZiyangZhang wrote:
> Define some macros for recovery feature. Especially define a new state:
> UBLK_S_DEV_QUIESCED which implies that ublk_device is quiesced
> and is ready for recovery. This state can be observed by userspace.
> 
> UBLK_F_USER_RECOVERY implies that:
> (1) ublk_drv enables recovery feature. It won't let monitor_work to
>     automatically abort rqs and release the device.
> (2) With a dying ubq_daemon, ublk_drv ends(aborts) rqs issued to
>     userspace(ublksrv) before crash.
> (3) With a dying ubq_daemon, in task work and ublk_queue_rq(),
>     ublk_drv requeues rqs.
> 
> UBLK_F_USER_RECOVERY_REISSUE implies that:
> (1) everything UBLK_F_USER_RECOVERY implies except
> (2) With a dying ubq_daemon, ublk_drv requeues rqs issued to
>     userspace(ublksrv) before crash.
> 
> UBLK_F_USER_RECOVERY_REISSUE is designed for backends which:
> (1) tolerates double-writes because ublk_drv may issue the same rq
>     twice.
> (2) does not let frontend users get I/O error. such as read-only FS
>     and VM backend.
> 
> Signed-off-by: ZiyangZhang <ZiyangZhang@linux.alibaba.com>
> ---
>  drivers/block/ublk_drv.c      | 45 ++++++++++++++++++++++++++++++++++-
>  include/uapi/linux/ublk_cmd.h |  7 ++++++
>  2 files changed, 51 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index 0c6db0978ed0..23337bd7c105 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -49,7 +49,9 @@
>  /* All UBLK_F_* have to be included into UBLK_F_ALL */
>  #define UBLK_F_ALL (UBLK_F_SUPPORT_ZERO_COPY \
>  		| UBLK_F_URING_CMD_COMP_IN_TASK \
> -		| UBLK_F_NEED_GET_DATA)
> +		| UBLK_F_NEED_GET_DATA \
> +		| UBLK_F_USER_RECOVERY \
> +		| UBLK_F_USER_RECOVERY_REISSUE)
>  
>  /* All UBLK_PARAM_TYPE_* should be included here */
>  #define UBLK_PARAM_TYPE_ALL (UBLK_PARAM_TYPE_BASIC | UBLK_PARAM_TYPE_DISCARD)
> @@ -323,6 +325,47 @@ static inline int ublk_queue_cmd_buf_size(struct ublk_device *ub, int q_id)
>  			PAGE_SIZE);
>  }
>  
> +static inline bool ublk_queue_can_use_recovery(
> +		struct ublk_queue *ubq)
> +{
> +	if (ubq->flags & UBLK_F_USER_RECOVERY)
> +		return true;
> +	return false;
> +}
> +
> +static inline void ublk_disable_recovery(struct ublk_device *ub)
> +{
> +	int i;
> +
> +	for (i = 0; i < ub->dev_info.nr_hw_queues; i++) {
> +		struct ublk_queue *ubq = ublk_get_queue(ub, i);
> +
> +		ubq->flags &= ~UBLK_F_USER_RECOVERY;
> +	}
> +}

Flags is supposed to not changed, especially ublk_disable_recovery
isn't necessary with my suggestion in the following link:

https://lore.kernel.org/linux-block/YylEjEply6y+bs0B@T590/T/#u


> +
> +static inline bool ublk_can_use_recovery(struct ublk_device *ub)
> +{
> +	int i;
> +
> +	for (i = 0; i < ub->dev_info.nr_hw_queues; i++) {
> +		struct ublk_queue *ubq = ublk_get_queue(ub, i);
> +
> +		if (!ublk_queue_can_use_recovery(ubq))
> +			return false;
> +	}
> +	return true;
> +}

The above is too tricky, why can't check ub->dev_info &
UBLK_F_USER_RECOVERY directly?

> +
> +static inline bool ublk_queue_can_use_recovery_reissue(
> +		struct ublk_queue *ubq)
> +{
> +	if (ublk_queue_can_use_recovery(ubq) &&
> +			(ubq->flags & UBLK_F_USER_RECOVERY_REISSUE))
> +		return true;
> +	return false;
> +}
> +
>  static void ublk_free_disk(struct gendisk *disk)
>  {
>  	struct ublk_device *ub = disk->private_data;
> diff --git a/include/uapi/linux/ublk_cmd.h b/include/uapi/linux/ublk_cmd.h
> index 677edaab2b66..87204c39f1ee 100644
> --- a/include/uapi/linux/ublk_cmd.h
> +++ b/include/uapi/linux/ublk_cmd.h
> @@ -17,6 +17,8 @@
>  #define	UBLK_CMD_STOP_DEV	0x07
>  #define	UBLK_CMD_SET_PARAMS	0x08
>  #define	UBLK_CMD_GET_PARAMS	0x09
> +#define	UBLK_CMD_START_USER_RECOVERY	0x10
> +#define UBLK_CMD_END_USER_RECOVERY	0x11
>  
>  /*
>   * IO commands, issued by ublk server, and handled by ublk driver.
> @@ -74,9 +76,14 @@
>   */
>  #define UBLK_F_NEED_GET_DATA (1UL << 2)
>  
> +#define UBLK_F_USER_RECOVERY	(1UL << 3)
> +
> +#define UBLK_F_USER_RECOVERY_REISSUE	(1UL << 4)

The above are two features. I'd suggest to add UBLK_F_USER_RECOVERY
and its implementation first, then add one delta patch for supporting
the new feature of UBLK_F_USER_RECOVERY_REISSUE.

Not only it is more helpful for reviewing, but also easier to understand
the two's difference.


thanks,
Ming

