Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A939747A79
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 01:42:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231345AbjGDXmM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 19:42:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231478AbjGDXmK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 19:42:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5456110E3;
        Tue,  4 Jul 2023 16:42:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BC86761405;
        Tue,  4 Jul 2023 23:42:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D175FC433C8;
        Tue,  4 Jul 2023 23:42:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688514126;
        bh=LoHznziOQK3TLwWQaWYiVaNHPc+5OCtZ+BNPgM1zTvE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ZSW1eRXo/PFaA+Ani9IuYf+FJuJBk9Az9dsuzdoQTCP2h+trJCB2c7UtRUjvaLfn/
         G95wqe/ds9g6Zhb6rF4voVNA9RrL9vV/BqTUNVrQY7EI1xBLIoWyIpAzEjODvDYi+y
         FxZ67mFlZVDQLmGCl0WQP6Dpivb2WkDvaqPwcUCpaPiqdOMso6G4s9kpQgQg1YNfCU
         RCrGC7vi8KbmbwvPsG+ySXJVQpC/gL9Xw2wg7k9Wa0RPfPoafE8HWxSGYSNQE5DwHV
         70crdDOaPwdl+CyQt+JDS0A1/dbmUCJyLvaVxXQE77fFpcr3TS/2LhGkw0B51sDU0z
         9UEthwcoq2Fqw==
Message-ID: <b5dbd5e0-417d-e33b-baf0-b6109882bc3a@kernel.org>
Date:   Wed, 5 Jul 2023 08:42:04 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v5 2/5] ublk: move types to shared header file
Content-Language: en-US
To:     Andreas Hindborg <nmi@metaspace.dk>, Ming Lei <ming.lei@redhat.com>
Cc:     open list <linux-kernel@vger.kernel.org>,
        Matias Bjorling <Matias.Bjorling@wdc.com>,
        Hans Holmberg <Hans.Holmberg@wdc.com>,
        Jens Axboe <axboe@kernel.dk>,
        Minwoo Im <minwoo.im.dev@gmail.com>,
        Aravind Ramesh <Aravind.Ramesh@wdc.com>, gost.dev@samsung.com,
        "open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Andreas Hindborg <a.hindborg@samsung.com>
References: <20230704165209.514591-1-nmi@metaspace.dk>
 <20230704165209.514591-3-nmi@metaspace.dk>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230704165209.514591-3-nmi@metaspace.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/5/23 01:52, Andreas Hindborg wrote:
> From: Andreas Hindborg <a.hindborg@samsung.com>
> 
> This change is in preparation for ublk zoned storage support.
> 
> Signed-off-by: Andreas Hindborg <a.hindborg@samsung.com>

A couple of nits below. Otherwise looks OK to me.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

That said, your patch 5 still adds ublk-zoned.c, which Christoph commented that
this may not be needed given that zone support does not add that much code.
Without introducing this new file, this patch, as well as patch 3 would not be
needed and patch 5 would be simplified a little.

If you really prefer (or Ming does) having the zone code separated, I would
suggest moving the ublk driver under its own "ublk" directory under
drivers/block/ (similarly to nullblk). That would simplify the Kconfig too.

> ---
>  MAINTAINERS              |   1 +
>  drivers/block/ublk_drv.c |  92 +---------------------------------
>  drivers/block/ublk_drv.h | 103 +++++++++++++++++++++++++++++++++++++++
>  3 files changed, 105 insertions(+), 91 deletions(-)
>  create mode 100644 drivers/block/ublk_drv.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 27ef11624748..ace71c90751c 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -21554,6 +21554,7 @@ L:	linux-block@vger.kernel.org
>  S:	Maintained
>  F:	Documentation/block/ublk.rst
>  F:	drivers/block/ublk_drv.c
> +F:	drivers/block/ublk_drv.h
>  F:	include/uapi/linux/ublk_cmd.h
>  
>  UCLINUX (M68KNOMMU AND COLDFIRE)
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index 1c823750c95a..bca0c4e1cfd8 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -45,6 +45,7 @@
>  #include <linux/namei.h>
>  #include <linux/kref.h>
>  #include <uapi/linux/ublk_cmd.h>
> +#include "ublk_drv.h"
>  
>  #define UBLK_MINORS		(1U << MINORBITS)
>  
> @@ -62,63 +63,11 @@
>  #define UBLK_PARAM_TYPE_ALL (UBLK_PARAM_TYPE_BASIC | \
>  		UBLK_PARAM_TYPE_DISCARD | UBLK_PARAM_TYPE_DEVT)
>  
> -struct ublk_rq_data {
> -	struct llist_node node;
> -
> -	struct kref ref;
> -};
>  
>  struct ublk_uring_cmd_pdu {
>  	struct ublk_queue *ubq;
>  };
>  
> -/*
> - * io command is active: sqe cmd is received, and its cqe isn't done
> - *
> - * If the flag is set, the io command is owned by ublk driver, and waited
> - * for incoming blk-mq request from the ublk block device.
> - *
> - * If the flag is cleared, the io command will be completed, and owned by
> - * ublk server.
> - */
> -#define UBLK_IO_FLAG_ACTIVE	0x01
> -
> -/*
> - * IO command is completed via cqe, and it is being handled by ublksrv, and
> - * not committed yet
> - *
> - * Basically exclusively with UBLK_IO_FLAG_ACTIVE, so can be served for
> - * cross verification
> - */
> -#define UBLK_IO_FLAG_OWNED_BY_SRV 0x02
> -
> -/*
> - * IO command is aborted, so this flag is set in case of
> - * !UBLK_IO_FLAG_ACTIVE.
> - *
> - * After this flag is observed, any pending or new incoming request
> - * associated with this io command will be failed immediately
> - */
> -#define UBLK_IO_FLAG_ABORTED 0x04
> -
> -/*
> - * UBLK_IO_FLAG_NEED_GET_DATA is set because IO command requires
> - * get data buffer address from ublksrv.
> - *
> - * Then, bio data could be copied into this data buffer for a WRITE request
> - * after the IO command is issued again and UBLK_IO_FLAG_NEED_GET_DATA is unset.
> - */
> -#define UBLK_IO_FLAG_NEED_GET_DATA 0x08
> -
> -struct ublk_io {
> -	/* userspace buffer address from io cmd */
> -	__u64	addr;
> -	unsigned int flags;
> -	int res;
> -
> -	struct io_uring_cmd *cmd;
> -};
> -
>  struct ublk_queue {
>  	int q_id;
>  	int q_depth;
> @@ -140,45 +89,6 @@ struct ublk_queue {
>  
>  #define UBLK_DAEMON_MONITOR_PERIOD	(5 * HZ)
>  
> -struct ublk_device {
> -	struct gendisk		*ub_disk;
> -
> -	char	*__queues;
> -
> -	unsigned int	queue_size;
> -	struct ublksrv_ctrl_dev_info	dev_info;
> -
> -	struct blk_mq_tag_set	tag_set;
> -
> -	struct cdev		cdev;
> -	struct device		cdev_dev;
> -
> -#define UB_STATE_OPEN		0
> -#define UB_STATE_USED		1
> -#define UB_STATE_DELETED	2
> -	unsigned long		state;
> -	int			ub_number;
> -
> -	struct mutex		mutex;
> -
> -	spinlock_t		mm_lock;
> -	struct mm_struct	*mm;
> -
> -	struct ublk_params	params;
> -
> -	struct completion	completion;
> -	unsigned int		nr_queues_ready;
> -	unsigned int		nr_privileged_daemon;
> -
> -	/*
> -	 * Our ubq->daemon may be killed without any notification, so
> -	 * monitor each queue's daemon periodically
> -	 */
> -	struct delayed_work	monitor_work;
> -	struct work_struct	quiesce_work;
> -	struct work_struct	stop_work;
> -};
> -
>  /* header of ublk_params */
>  struct ublk_params_header {
>  	__u32	len;
> diff --git a/drivers/block/ublk_drv.h b/drivers/block/ublk_drv.h
> new file mode 100644
> index 000000000000..2a4ab721d513
> --- /dev/null
> +++ b/drivers/block/ublk_drv.h
> @@ -0,0 +1,103 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +#ifndef _UBLK_DRV_H
> +#define _UBLK_DRV_H

Nit: I think you can drop the leading "_".

> +
> +#include <uapi/linux/ublk_cmd.h>
> +#include <linux/blk-mq.h>
> +#include <linux/cdev.h>
> +
> +/*
> + * io command is active: sqe cmd is received, and its cqe isn't done
> + *
> + * If the flag is set, the io command is owned by ublk driver, and waited
> + * for incoming blk-mq request from the ublk block device.
> + *
> + * If the flag is cleared, the io command will be completed, and owned by
> + * ublk server.
> + */
> +#define UBLK_IO_FLAG_ACTIVE	0x01
> +
> +/*
> + * IO command is completed via cqe, and it is being handled by ublksrv, and
> + * not committed yet
> + *
> + * Basically exclusively with UBLK_IO_FLAG_ACTIVE, so can be served for
> + * cross verification
> + */
> +#define UBLK_IO_FLAG_OWNED_BY_SRV 0x02
> +
> +/*
> + * IO command is aborted, so this flag is set in case of
> + * !UBLK_IO_FLAG_ACTIVE.
> + *
> + * After this flag is observed, any pending or new incoming request
> + * associated with this io command will be failed immediately
> + */
> +#define UBLK_IO_FLAG_ABORTED 0x04
> +
> +/*
> + * UBLK_IO_FLAG_NEED_GET_DATA is set because IO command requires
> + * get data buffer address from ublksrv.
> + *
> + * Then, bio data could be copied into this data buffer for a WRITE request
> + * after the IO command is issued again and UBLK_IO_FLAG_NEED_GET_DATA is unset.
> + */
> +#define UBLK_IO_FLAG_NEED_GET_DATA 0x08
> +
> +

Nit: extra blank line not needed.

> +struct ublk_device {
> +	struct gendisk		*ub_disk;
> +
> +	char	*__queues;
> +
> +	unsigned int	queue_size;
> +	struct ublksrv_ctrl_dev_info	dev_info;
> +
> +	struct blk_mq_tag_set	tag_set;
> +
> +	struct cdev		cdev;
> +	struct device		cdev_dev;
> +
> +#define UB_STATE_OPEN		0
> +#define UB_STATE_USED		1
> +#define UB_STATE_DELETED	2
> +	unsigned long		state;
> +	int			ub_number;
> +
> +	struct mutex		mutex;
> +
> +	spinlock_t		mm_lock;
> +	struct mm_struct	*mm;
> +
> +	struct ublk_params	params;
> +
> +	struct completion	completion;
> +	unsigned int		nr_queues_ready;
> +	unsigned int		nr_privileged_daemon;
> +
> +	/*
> +	 * Our ubq->daemon may be killed without any notification, so
> +	 * monitor each queue's daemon periodically
> +	 */
> +	struct delayed_work	monitor_work;
> +	struct work_struct	quiesce_work;
> +	struct work_struct	stop_work;
> +};
> +
> +struct ublk_rq_data {
> +	struct llist_node node;
> +
> +	struct kref ref;
> +};
> +
> +struct ublk_io {
> +	/* userspace buffer address from io cmd */
> +	__u64 addr;
> +	unsigned int flags;
> +	int res;
> +
> +	struct io_uring_cmd *cmd;
> +};
> +
> +#endif

-- 
Damien Le Moal
Western Digital Research

