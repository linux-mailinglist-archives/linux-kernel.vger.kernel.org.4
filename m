Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36D87748295
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 12:54:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232242AbjGEKyq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 06:54:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231682AbjGEKyo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 06:54:44 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5810B18B
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 03:54:42 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-51d946d2634so7859590a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jul 2023 03:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20221208.gappssmtp.com; s=20221208; t=1688554481; x=1691146481;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=836U1ncNWnnbbFv6Lbmn9bhPGFpngTvn+a4DofbrEMA=;
        b=yzCkyk8Dv6B5YuQMPqNVIszW1sTgXbusV4HIiIyHUuwzJv3O0z6/0wsq093wZotjBg
         E7jaAij+YLBrc5uRZutdiObSVtEDkE3T+/49cYGma6s72SzUORCsXZxNwJRLT4gvI06I
         fJAqQ8kbdNSZw91klUiFogZAfBxZuoomD1nU75RaE7DpxO49iIEVWDwzVSarmiqw7rKJ
         Ji+xhhR26vQXow5NfWoz347beHQKXq5SOoEffpW0gzrG5QHdCSlQVJQ2FZsjcTzZGWnn
         qJIYM1STfz+2ue3s0IbiUfn7NQxZcJ3s/r0x7HCjqmeibqKBvYws75rSBrfZsm8+DIEF
         +e1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688554481; x=1691146481;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=836U1ncNWnnbbFv6Lbmn9bhPGFpngTvn+a4DofbrEMA=;
        b=Xzrnmptv+B2T1DaWiwcqeeRvlxA/sb5N/arMryU04xU83Oo+Nv6zVcBB9UOYQhSNyn
         Gut2Oot0u3dSn/XN0I0d9pt2MzBCPIJha1KI9Fn3v0zlCCIDbiO9dFuBwGoD38UN+DQG
         Iz2VfK1bwL8TWrAFMnT/4K/Nq5G+3l3KB1Z0US9TOANg/SB6yWBf5vgC03ya6hTjDgiO
         UVmsUXJrFWm8xRymWccN6mAHujkVLkue1qS4LmFqZHCjOfdg8NaKQZRDGjexiPMpbywP
         iXvR+okqYx7GclIs9qoTuprle5MAqEt9Fi0h6aE9QP3s/+Kau3Lzdupbxy1nw2twzEYe
         iLMA==
X-Gm-Message-State: ABy/qLYrioJmRmbowMcRXeLVI1eAKckE7PyZfmqrVpTuzXzWI9CYZqQz
        aYKqyz04dPNl5Xte/nekSsLxkc7wTXHK2UKaMKM=
X-Google-Smtp-Source: APBJJlHIKmDtZd4qNT6fHFE4sE2GNLPsihbinAxZ7hQfL5VA7OC5Cg9Uow4Bn8sz6N8BRmmRhMW4EA==
X-Received: by 2002:aa7:d958:0:b0:51d:f3a6:5eef with SMTP id l24-20020aa7d958000000b0051df3a65eefmr12292082eds.36.1688554480673;
        Wed, 05 Jul 2023 03:54:40 -0700 (PDT)
Received: from localhost ([79.142.230.34])
        by smtp.gmail.com with ESMTPSA id v1-20020a056402184100b0050488d1d376sm12982957edy.0.2023.07.05.03.54.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jul 2023 03:54:40 -0700 (PDT)
References: <20230704165209.514591-1-nmi@metaspace.dk>
 <20230704165209.514591-3-nmi@metaspace.dk>
 <b5dbd5e0-417d-e33b-baf0-b6109882bc3a@kernel.org>
User-agent: mu4e 1.10.4; emacs 28.2.50
From:   "Andreas Hindborg (Samsung)" <nmi@metaspace.dk>
To:     Damien Le Moal <dlemoal@kernel.org>
Cc:     Ming Lei <ming.lei@redhat.com>,
        open list <linux-kernel@vger.kernel.org>,
        Matias Bjorling <Matias.Bjorling@wdc.com>,
        Hans Holmberg <Hans.Holmberg@wdc.com>,
        Jens Axboe <axboe@kernel.dk>,
        Minwoo Im <minwoo.im.dev@gmail.com>,
        Aravind Ramesh <Aravind.Ramesh@wdc.com>, gost.dev@samsung.com,
        "open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v5 2/5] ublk: move types to shared header file
Date:   Wed, 05 Jul 2023 12:50:28 +0200
In-reply-to: <b5dbd5e0-417d-e33b-baf0-b6109882bc3a@kernel.org>
Message-ID: <875y6yd3wz.fsf@metaspace.dk>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Damien Le Moal <dlemoal@kernel.org> writes:

> On 7/5/23 01:52, Andreas Hindborg wrote:
>> From: Andreas Hindborg <a.hindborg@samsung.com>
>> 
>> This change is in preparation for ublk zoned storage support.
>> 
>> Signed-off-by: Andreas Hindborg <a.hindborg@samsung.com>
>
> A couple of nits below. Otherwise looks OK to me.
>
> Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
>
> That said, your patch 5 still adds ublk-zoned.c, which Christoph commented that
> this may not be needed given that zone support does not add that much code.
> Without introducing this new file, this patch, as well as patch 3 would not be
> needed and patch 5 would be simplified a little.
>
> If you really prefer (or Ming does) having the zone code separated, I would
> suggest moving the ublk driver under its own "ublk" directory under
> drivers/block/ (similarly to nullblk). That would simplify the Kconfig too.

I am fine either way. I don't think Ming commented on this. It seems
both you and Christoph prefer just the 1 translation unit, so I might as
well change it back to that.

BR Andreas

>
>> ---
>>  MAINTAINERS              |   1 +
>>  drivers/block/ublk_drv.c |  92 +---------------------------------
>>  drivers/block/ublk_drv.h | 103 +++++++++++++++++++++++++++++++++++++++
>>  3 files changed, 105 insertions(+), 91 deletions(-)
>>  create mode 100644 drivers/block/ublk_drv.h
>> 
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 27ef11624748..ace71c90751c 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -21554,6 +21554,7 @@ L:	linux-block@vger.kernel.org
>>  S:	Maintained
>>  F:	Documentation/block/ublk.rst
>>  F:	drivers/block/ublk_drv.c
>> +F:	drivers/block/ublk_drv.h
>>  F:	include/uapi/linux/ublk_cmd.h
>>  
>>  UCLINUX (M68KNOMMU AND COLDFIRE)
>> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
>> index 1c823750c95a..bca0c4e1cfd8 100644
>> --- a/drivers/block/ublk_drv.c
>> +++ b/drivers/block/ublk_drv.c
>> @@ -45,6 +45,7 @@
>>  #include <linux/namei.h>
>>  #include <linux/kref.h>
>>  #include <uapi/linux/ublk_cmd.h>
>> +#include "ublk_drv.h"
>>  
>>  #define UBLK_MINORS		(1U << MINORBITS)
>>  
>> @@ -62,63 +63,11 @@
>>  #define UBLK_PARAM_TYPE_ALL (UBLK_PARAM_TYPE_BASIC | \
>>  		UBLK_PARAM_TYPE_DISCARD | UBLK_PARAM_TYPE_DEVT)
>>  
>> -struct ublk_rq_data {
>> -	struct llist_node node;
>> -
>> -	struct kref ref;
>> -};
>>  
>>  struct ublk_uring_cmd_pdu {
>>  	struct ublk_queue *ubq;
>>  };
>>  
>> -/*
>> - * io command is active: sqe cmd is received, and its cqe isn't done
>> - *
>> - * If the flag is set, the io command is owned by ublk driver, and waited
>> - * for incoming blk-mq request from the ublk block device.
>> - *
>> - * If the flag is cleared, the io command will be completed, and owned by
>> - * ublk server.
>> - */
>> -#define UBLK_IO_FLAG_ACTIVE	0x01
>> -
>> -/*
>> - * IO command is completed via cqe, and it is being handled by ublksrv, and
>> - * not committed yet
>> - *
>> - * Basically exclusively with UBLK_IO_FLAG_ACTIVE, so can be served for
>> - * cross verification
>> - */
>> -#define UBLK_IO_FLAG_OWNED_BY_SRV 0x02
>> -
>> -/*
>> - * IO command is aborted, so this flag is set in case of
>> - * !UBLK_IO_FLAG_ACTIVE.
>> - *
>> - * After this flag is observed, any pending or new incoming request
>> - * associated with this io command will be failed immediately
>> - */
>> -#define UBLK_IO_FLAG_ABORTED 0x04
>> -
>> -/*
>> - * UBLK_IO_FLAG_NEED_GET_DATA is set because IO command requires
>> - * get data buffer address from ublksrv.
>> - *
>> - * Then, bio data could be copied into this data buffer for a WRITE request
>> - * after the IO command is issued again and UBLK_IO_FLAG_NEED_GET_DATA is unset.
>> - */
>> -#define UBLK_IO_FLAG_NEED_GET_DATA 0x08
>> -
>> -struct ublk_io {
>> -	/* userspace buffer address from io cmd */
>> -	__u64	addr;
>> -	unsigned int flags;
>> -	int res;
>> -
>> -	struct io_uring_cmd *cmd;
>> -};
>> -
>>  struct ublk_queue {
>>  	int q_id;
>>  	int q_depth;
>> @@ -140,45 +89,6 @@ struct ublk_queue {
>>  
>>  #define UBLK_DAEMON_MONITOR_PERIOD	(5 * HZ)
>>  
>> -struct ublk_device {
>> -	struct gendisk		*ub_disk;
>> -
>> -	char	*__queues;
>> -
>> -	unsigned int	queue_size;
>> -	struct ublksrv_ctrl_dev_info	dev_info;
>> -
>> -	struct blk_mq_tag_set	tag_set;
>> -
>> -	struct cdev		cdev;
>> -	struct device		cdev_dev;
>> -
>> -#define UB_STATE_OPEN		0
>> -#define UB_STATE_USED		1
>> -#define UB_STATE_DELETED	2
>> -	unsigned long		state;
>> -	int			ub_number;
>> -
>> -	struct mutex		mutex;
>> -
>> -	spinlock_t		mm_lock;
>> -	struct mm_struct	*mm;
>> -
>> -	struct ublk_params	params;
>> -
>> -	struct completion	completion;
>> -	unsigned int		nr_queues_ready;
>> -	unsigned int		nr_privileged_daemon;
>> -
>> -	/*
>> -	 * Our ubq->daemon may be killed without any notification, so
>> -	 * monitor each queue's daemon periodically
>> -	 */
>> -	struct delayed_work	monitor_work;
>> -	struct work_struct	quiesce_work;
>> -	struct work_struct	stop_work;
>> -};
>> -
>>  /* header of ublk_params */
>>  struct ublk_params_header {
>>  	__u32	len;
>> diff --git a/drivers/block/ublk_drv.h b/drivers/block/ublk_drv.h
>> new file mode 100644
>> index 000000000000..2a4ab721d513
>> --- /dev/null
>> +++ b/drivers/block/ublk_drv.h
>> @@ -0,0 +1,103 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +
>> +#ifndef _UBLK_DRV_H
>> +#define _UBLK_DRV_H
>
> Nit: I think you can drop the leading "_".
>
>> +
>> +#include <uapi/linux/ublk_cmd.h>
>> +#include <linux/blk-mq.h>
>> +#include <linux/cdev.h>
>> +
>> +/*
>> + * io command is active: sqe cmd is received, and its cqe isn't done
>> + *
>> + * If the flag is set, the io command is owned by ublk driver, and waited
>> + * for incoming blk-mq request from the ublk block device.
>> + *
>> + * If the flag is cleared, the io command will be completed, and owned by
>> + * ublk server.
>> + */
>> +#define UBLK_IO_FLAG_ACTIVE	0x01
>> +
>> +/*
>> + * IO command is completed via cqe, and it is being handled by ublksrv, and
>> + * not committed yet
>> + *
>> + * Basically exclusively with UBLK_IO_FLAG_ACTIVE, so can be served for
>> + * cross verification
>> + */
>> +#define UBLK_IO_FLAG_OWNED_BY_SRV 0x02
>> +
>> +/*
>> + * IO command is aborted, so this flag is set in case of
>> + * !UBLK_IO_FLAG_ACTIVE.
>> + *
>> + * After this flag is observed, any pending or new incoming request
>> + * associated with this io command will be failed immediately
>> + */
>> +#define UBLK_IO_FLAG_ABORTED 0x04
>> +
>> +/*
>> + * UBLK_IO_FLAG_NEED_GET_DATA is set because IO command requires
>> + * get data buffer address from ublksrv.
>> + *
>> + * Then, bio data could be copied into this data buffer for a WRITE request
>> + * after the IO command is issued again and UBLK_IO_FLAG_NEED_GET_DATA is unset.
>> + */
>> +#define UBLK_IO_FLAG_NEED_GET_DATA 0x08
>> +
>> +
>
> Nit: extra blank line not needed.
>
>> +struct ublk_device {
>> +	struct gendisk		*ub_disk;
>> +
>> +	char	*__queues;
>> +
>> +	unsigned int	queue_size;
>> +	struct ublksrv_ctrl_dev_info	dev_info;
>> +
>> +	struct blk_mq_tag_set	tag_set;
>> +
>> +	struct cdev		cdev;
>> +	struct device		cdev_dev;
>> +
>> +#define UB_STATE_OPEN		0
>> +#define UB_STATE_USED		1
>> +#define UB_STATE_DELETED	2
>> +	unsigned long		state;
>> +	int			ub_number;
>> +
>> +	struct mutex		mutex;
>> +
>> +	spinlock_t		mm_lock;
>> +	struct mm_struct	*mm;
>> +
>> +	struct ublk_params	params;
>> +
>> +	struct completion	completion;
>> +	unsigned int		nr_queues_ready;
>> +	unsigned int		nr_privileged_daemon;
>> +
>> +	/*
>> +	 * Our ubq->daemon may be killed without any notification, so
>> +	 * monitor each queue's daemon periodically
>> +	 */
>> +	struct delayed_work	monitor_work;
>> +	struct work_struct	quiesce_work;
>> +	struct work_struct	stop_work;
>> +};
>> +
>> +struct ublk_rq_data {
>> +	struct llist_node node;
>> +
>> +	struct kref ref;
>> +};
>> +
>> +struct ublk_io {
>> +	/* userspace buffer address from io cmd */
>> +	__u64 addr;
>> +	unsigned int flags;
>> +	int res;
>> +
>> +	struct io_uring_cmd *cmd;
>> +};
>> +
>> +#endif

