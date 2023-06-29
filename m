Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4130741E6A
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 04:40:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231361AbjF2Ckh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 22:40:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231616AbjF2Ck0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 22:40:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A034D2682
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 19:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688006373;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mlNgGDntwJwFJFcJw5ZHEd+1mXug8P2rWNXrlhXtw8g=;
        b=OviCNHKe1OkE1LQoZv2xxZgzborYyqUWLYWrDaypvxJIWu/1R96O3xDWB/sVeJzBSyVakL
        6lqXjxtBFg5cnKvmqyT9xZc+pSdnfeWmMnSvE+prdRhO5euLJfEN4WKDCm4ccFSLYoHAdg
        CcNC+TZVyeuCRWmY0f8EdMgbUC3mXls=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-427-7HtxYaFNMF65cFey1Is0QA-1; Wed, 28 Jun 2023 22:39:30 -0400
X-MC-Unique: 7HtxYaFNMF65cFey1Is0QA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EEDB2185A792;
        Thu, 29 Jun 2023 02:39:29 +0000 (UTC)
Received: from ovpn-8-18.pek2.redhat.com (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C7EA440C206F;
        Thu, 29 Jun 2023 02:39:21 +0000 (UTC)
Date:   Thu, 29 Jun 2023 10:39:16 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Andreas Hindborg <nmi@metaspace.dk>
Cc:     Hans Holmberg <Hans.Holmberg@wdc.com>,
        Aravind Ramesh <Aravind.Ramesh@wdc.com>,
        Jens Axboe <axboe@kernel.dk>,
        "open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Matias Bjorling <Matias.Bjorling@wdc.com>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        open list <linux-kernel@vger.kernel.org>,
        Damien Le Moal <dlemoal@kernel.org>, gost.dev@samsung.com,
        Minwoo Im <minwoo.im.dev@gmail.com>, ming.lei@redhat.com
Subject: Re: [PATCH v4 3/4] ublk: enable zoned storage support
Message-ID: <ZJzu1ECR3Cp+IW+5@ovpn-8-18.pek2.redhat.com>
References: <20230628190649.11233-1-nmi@metaspace.dk>
 <20230628190649.11233-4-nmi@metaspace.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230628190649.11233-4-nmi@metaspace.dk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 28, 2023 at 09:06:48PM +0200, Andreas Hindborg wrote:
> From: Andreas Hindborg <a.hindborg@samsung.com>
> 
> Add zoned storage support to ublk: report_zones and operations:
>  - REQ_OP_ZONE_OPEN
>  - REQ_OP_ZONE_CLOSE
>  - REQ_OP_ZONE_FINISH
>  - REQ_OP_ZONE_RESET
> 
> Note: This commit changes the ublk kernel module name from `ublk_drv.ko` to
> `ublk.ko` in order to link multiple translation units into the module.
> 
> Signed-off-by: Andreas Hindborg <a.hindborg@samsung.com>
> ---
>  MAINTAINERS                    |   1 +
>  drivers/block/Kconfig          |   4 +
>  drivers/block/Makefile         |   4 +-
>  drivers/block/ublk_drv-zoned.c | 144 +++++++++++++++++++++++++++++++++
>  drivers/block/ublk_drv.c       |  64 +++++++++++++--
>  drivers/block/ublk_drv.h       |  15 ++++
>  include/uapi/linux/ublk_cmd.h  |  14 ++++
>  7 files changed, 239 insertions(+), 7 deletions(-)
>  create mode 100644 drivers/block/ublk_drv-zoned.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index ace71c90751c..db8a8deb5926 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -21555,6 +21555,7 @@ S:	Maintained
>  F:	Documentation/block/ublk.rst
>  F:	drivers/block/ublk_drv.c
>  F:	drivers/block/ublk_drv.h
> +F:	drivers/block/ublk_drv-zoned.c
>  F:	include/uapi/linux/ublk_cmd.h
>  
>  UCLINUX (M68KNOMMU AND COLDFIRE)
> diff --git a/drivers/block/Kconfig b/drivers/block/Kconfig
> index 5b9d4aaebb81..c58dfd035557 100644
> --- a/drivers/block/Kconfig
> +++ b/drivers/block/Kconfig
> @@ -402,6 +402,10 @@ config BLKDEV_UBLK_LEGACY_OPCODES
>  	  suggested to enable N if your application(ublk server) switches to
>  	  ioctl command encoding.
>  
> +config BLK_DEV_UBLK_ZONED
> +	def_bool y
> +	depends on BLK_DEV_UBLK && BLK_DEV_ZONED
> +
>  source "drivers/block/rnbd/Kconfig"
>  
>  endif # BLK_DEV
> diff --git a/drivers/block/Makefile b/drivers/block/Makefile
> index 101612cba303..bc1649e20ec2 100644
> --- a/drivers/block/Makefile
> +++ b/drivers/block/Makefile
> @@ -37,6 +37,8 @@ obj-$(CONFIG_BLK_DEV_RNBD)	+= rnbd/
>  
>  obj-$(CONFIG_BLK_DEV_NULL_BLK)	+= null_blk/
>  
> -obj-$(CONFIG_BLK_DEV_UBLK)			+= ublk_drv.o
> +obj-$(CONFIG_BLK_DEV_UBLK)		+= ublk.o
> +ublk-$(CONFIG_BLK_DEV_UBLK)		+= ublk_drv.o
> +ublk-$(CONFIG_BLK_DEV_UBLK_ZONED)	+= ublk_drv-zoned.o
>  
>  swim_mod-y	:= swim.o swim_asm.o
> diff --git a/drivers/block/ublk_drv-zoned.c b/drivers/block/ublk_drv-zoned.c
> new file mode 100644
> index 000000000000..ea86bf4b3681
> --- /dev/null
> +++ b/drivers/block/ublk_drv-zoned.c
> @@ -0,0 +1,144 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright 2023 Andreas Hindborg <a.hindborg@samsung.com>
> + */
> +#include <linux/blkzoned.h>
> +#include <linux/ublk_cmd.h>
> +#include <linux/vmalloc.h>
> +
> +#include "ublk_drv.h"
> +
> +void ublk_set_nr_zones(struct ublk_device *ub)
> +{
> +	const struct ublk_param_basic *p = &ub->params.basic;
> +
> +	if (ub->dev_info.flags & UBLK_F_ZONED && p->chunk_sectors)
> +		ub->ub_disk->nr_zones = p->dev_sectors / p->chunk_sectors;
> +}
> +
> +void ublk_dev_param_zoned_apply(struct ublk_device *ub)
> +{
> +	const struct ublk_param_zoned *p = &ub->params.zoned;
> +
> +	if (ub->dev_info.flags & UBLK_F_ZONED) {
> +		disk_set_max_active_zones(ub->ub_disk, p->max_active_zones);
> +		disk_set_max_open_zones(ub->ub_disk, p->max_open_zones);
> +	}
> +}
> +
> +int ublk_revalidate_disk_zones(struct gendisk *disk)
> +{
> +	return blk_revalidate_disk_zones(disk, NULL);
> +}
> +
> +/* Based on virtblk_alloc_report_buffer */
> +static void *ublk_alloc_report_buffer(struct ublk_device *ublk,
> +				      unsigned int nr_zones,
> +				      unsigned int zone_sectors, size_t *buflen)
> +{
> +	struct request_queue *q = ublk->ub_disk->queue;
> +	size_t bufsize;
> +	void *buf;
> +
> +	nr_zones = min_t(unsigned int, nr_zones,
> +			 get_capacity(ublk->ub_disk) >> ilog2(zone_sectors));
> +
> +	bufsize = nr_zones * sizeof(struct blk_zone);
> +	bufsize =
> +		min_t(size_t, bufsize, queue_max_hw_sectors(q) << SECTOR_SHIFT);
> +	bufsize = min_t(size_t, bufsize, queue_max_segments(q) << PAGE_SHIFT);

This means 'blk_zone'(includes any sub-field type) is reused as part of ublk's UAPI,
and it is smart, please document it around UBLK_IO_OP_REPORT_ZONES's definition.

> +
> +	while (bufsize >= sizeof(struct blk_zone)) {
> +		buf = __vmalloc(bufsize, GFP_KERNEL | __GFP_NORETRY);
> +		if (buf) {
> +			*buflen = bufsize;
> +			return buf;
> +		}
> +		bufsize >>= 1;
> +	}
> +
> +	bufsize = 0;
> +	return NULL;
> +}
> +
> +int ublk_report_zones(struct gendisk *disk, sector_t sector,
> +		      unsigned int nr_zones, report_zones_cb cb, void *data)
> +{
> +	struct ublk_device *ub = disk->private_data;
> +	unsigned int zone_size_sectors = disk->queue->limits.chunk_sectors;
> +	unsigned int first_zone = sector >> ilog2(zone_size_sectors);
> +	unsigned int done_zones = 0;
> +	unsigned int max_zones_per_request;
> +	struct blk_zone *buffer;
> +	size_t buffer_length;
> +
> +	if (!(ub->dev_info.flags & UBLK_F_ZONED))
> +		return -EOPNOTSUPP;
> +
> +	nr_zones = min_t(unsigned int, ub->ub_disk->nr_zones - first_zone,
> +			 nr_zones);
> +
> +	buffer = ublk_alloc_report_buffer(ub, nr_zones, zone_size_sectors,
> +					  &buffer_length);
> +	if (!buffer)
> +		return -ENOMEM;
> +
> +	max_zones_per_request = buffer_length / sizeof(struct blk_zone);
> +
> +	while (done_zones < nr_zones) {
> +		unsigned int remaining_zones = nr_zones - done_zones;
> +		unsigned int zones_in_request = min_t(
> +			unsigned int, remaining_zones, max_zones_per_request);
> +		int err = 0;
> +		struct request *req;
> +		struct ublk_rq_data *pdu;
> +		blk_status_t status;
> +
> +		memset(buffer, 0, buffer_length);
> +
> +		req = blk_mq_alloc_request(disk->queue, REQ_OP_DRV_IN, 0);
> +		if (IS_ERR(req))
> +			return PTR_ERR(req);
> +
> +		pdu = blk_mq_rq_to_pdu(req);
> +		pdu->operation = UBLK_IO_OP_REPORT_ZONES;
> +		pdu->sector = sector;
> +		pdu->nr_sectors = remaining_zones * zone_size_sectors;
> +
> +		err = blk_rq_map_kern(disk->queue, req, buffer, buffer_length,
> +					GFP_KERNEL);
> +		if (err) {
> +			blk_mq_free_request(req);
> +			kvfree(buffer);
> +			return err;
> +		}
> +
> +		status = blk_execute_rq(req, 0);
> +		err = blk_status_to_errno(status);
> +		blk_mq_free_request(req);
> +		if (err) {
> +			kvfree(buffer);
> +			return err;
> +		}
> +
> +		for (unsigned int i = 0; i < zones_in_request; i++) {
> +			struct blk_zone *zone = buffer + i;
> +
> +			err = cb(zone, i, data);
> +			if (err)
> +				return err;
> +
> +			done_zones++;
> +			sector += zone_size_sectors;
> +
> +			/* A zero length zone means don't ask for more zones */
> +			if (!zone->len) {

This way is part of UAPI UBLK_IO_OP_REPORT_ZONES, please document it
around UBLK_IO_OP_REPORT_ZONES.

> +				kvfree(buffer);
> +				return done_zones;
> +			}
> +		}
> +	}
> +
> +	kvfree(buffer);
> +	return done_zones;
> +}
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index e519dc0d9fe7..88fa39853c61 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -57,12 +57,13 @@
>  		| UBLK_F_USER_RECOVERY_REISSUE \
>  		| UBLK_F_UNPRIVILEGED_DEV \
>  		| UBLK_F_CMD_IOCTL_ENCODE \
> -		| UBLK_F_USER_COPY)
> +		| UBLK_F_USER_COPY \
> +		| UBLK_F_ZONED)
>  
>  /* All UBLK_PARAM_TYPE_* should be included here */
> -#define UBLK_PARAM_TYPE_ALL (UBLK_PARAM_TYPE_BASIC | \
> -		UBLK_PARAM_TYPE_DISCARD | UBLK_PARAM_TYPE_DEVT)
> -
> +#define UBLK_PARAM_TYPE_ALL                                \
> +	(UBLK_PARAM_TYPE_BASIC | UBLK_PARAM_TYPE_DISCARD | \
> +	 UBLK_PARAM_TYPE_DEVT | UBLK_PARAM_TYPE_ZONED)
>  
>  struct ublk_uring_cmd_pdu {
>  	struct ublk_queue *ubq;
> @@ -209,6 +210,9 @@ static void ublk_dev_param_basic_apply(struct ublk_device *ub)
>  		set_disk_ro(ub->ub_disk, true);
>  
>  	set_capacity(ub->ub_disk, p->dev_sectors);
> +
> +	if (IS_ENABLED(CONFIG_BLK_DEV_ZONED))
> +		ublk_set_nr_zones(ub);
>  }
>  
>  static void ublk_dev_param_discard_apply(struct ublk_device *ub)
> @@ -269,6 +273,9 @@ static int ublk_apply_params(struct ublk_device *ub)
>  	if (ub->params.types & UBLK_PARAM_TYPE_DISCARD)
>  		ublk_dev_param_discard_apply(ub);
>  
> +	if (IS_ENABLED(CONFIG_BLK_DEV_ZONED) && (ub->params.types & UBLK_PARAM_TYPE_ZONED))
> +		ublk_dev_param_zoned_apply(ub);
> +
>  	return 0;
>  }
>  
> @@ -439,6 +446,7 @@ static const struct block_device_operations ub_fops = {
>  	.owner =	THIS_MODULE,
>  	.open =		ublk_open,
>  	.free_disk =	ublk_free_disk,
> +	.report_zones =	ublk_report_zones,
>  };
>  
>  #define UBLK_MAX_PIN_PAGES	32
> @@ -553,7 +561,8 @@ static inline bool ublk_need_map_req(const struct request *req)
>  
>  static inline bool ublk_need_unmap_req(const struct request *req)
>  {
> -	return ublk_rq_has_data(req) && req_op(req) == REQ_OP_READ;
> +	return ublk_rq_has_data(req) &&
> +	       (req_op(req) == REQ_OP_READ || req_op(req) == REQ_OP_DRV_IN);
>  }
>  
>  static int ublk_map_io(const struct ublk_queue *ubq, const struct request *req,
> @@ -637,6 +646,7 @@ static blk_status_t ublk_setup_iod(struct ublk_queue *ubq, struct request *req)
>  {
>  	struct ublksrv_io_desc *iod = ublk_get_iod(ubq, req->tag);
>  	struct ublk_io *io = &ubq->ios[req->tag];
> +	struct ublk_rq_data *pdu = blk_mq_rq_to_pdu(req);
>  	u32 ublk_op;
>  
>  	switch (req_op(req)) {
> @@ -655,6 +665,35 @@ static blk_status_t ublk_setup_iod(struct ublk_queue *ubq, struct request *req)
>  	case REQ_OP_WRITE_ZEROES:
>  		ublk_op = UBLK_IO_OP_WRITE_ZEROES;
>  		break;
> +	case REQ_OP_ZONE_OPEN:
> +		ublk_op = UBLK_IO_OP_ZONE_OPEN;
> +		break;
> +	case REQ_OP_ZONE_CLOSE:
> +		ublk_op = UBLK_IO_OP_ZONE_CLOSE;
> +		break;
> +	case REQ_OP_ZONE_FINISH:
> +		ublk_op = UBLK_IO_OP_ZONE_FINISH;
> +		break;
> +	case REQ_OP_ZONE_RESET:
> +		ublk_op = UBLK_IO_OP_ZONE_RESET;
> +		break;
> +	case REQ_OP_DRV_IN:
> +		ublk_op = pdu->operation;
> +		switch (ublk_op) {
> +		case UBLK_IO_OP_REPORT_ZONES:
> +			iod->op_flags = ublk_op | ublk_req_build_flags(req);
> +			iod->nr_sectors = pdu->nr_sectors;
> +			iod->start_sector = pdu->sector;
> +			iod->addr = io->addr;

As Damien commented, zone append needs to be moved into this patch,
so zoned depends on user copy feature, and you can simply fail to
add device if user copy isn't enabled.

So the above 'iod->addr = io->addr' can be removed.

> +			return BLK_STS_OK;
> +		default:
> +			return BLK_STS_IOERR;
> +		}
> +	case REQ_OP_ZONE_APPEND:
> +	case REQ_OP_ZONE_RESET_ALL:
> +	case REQ_OP_DRV_OUT:
> +		/* We do not support zone append or reset_all yet */
> +		fallthrough;
>  	default:
>  		return BLK_STS_IOERR;
>  	}
> @@ -708,7 +747,8 @@ static inline void __ublk_complete_rq(struct request *req)
>  	 *
>  	 * Both the two needn't unmap.
>  	 */
> -	if (req_op(req) != REQ_OP_READ && req_op(req) != REQ_OP_WRITE)
> +	if (req_op(req) != REQ_OP_READ && req_op(req) != REQ_OP_WRITE &&
> +	    req_op(req) != REQ_OP_DRV_IN)
>  		goto exit;
>  
>  	/* for READ request, writing data in iod->addr to rq buffers */
> @@ -1835,6 +1875,15 @@ static int ublk_ctrl_start_dev(struct ublk_device *ub, struct io_uring_cmd *cmd)
>  	if (ub->nr_privileged_daemon != ub->nr_queues_ready)
>  		set_bit(GD_SUPPRESS_PART_SCAN, &disk->state);
>  
> +	if (IS_ENABLED(CONFIG_BLK_DEV_ZONED) &&
> +	    ub->dev_info.flags & UBLK_F_ZONED) {
> +		disk_set_zoned(disk, BLK_ZONED_HM);
> +		blk_queue_required_elevator_features(disk->queue, ELEVATOR_F_ZBD_SEQ_WRITE);
> +		ret = ublk_revalidate_disk_zones(disk);
> +		if (ret)
> +			goto out_put_disk;
> +	}
> +
>  	get_device(&ub->cdev_dev);
>  	ub->dev_info.state = UBLK_S_DEV_LIVE;
>  	ret = add_disk(disk);
> @@ -1997,6 +2046,9 @@ static int ublk_ctrl_add_dev(struct io_uring_cmd *cmd)
>  	if (ub->dev_info.flags & UBLK_F_USER_COPY)
>  		ub->dev_info.flags &= ~UBLK_F_NEED_GET_DATA;
>  
> +	if (!IS_ENABLED(CONFIG_BLK_DEV_ZONED))
> +		ub->dev_info.flags &= ~UBLK_F_ZONED;
> +
>  	/* We are not ready to support zero copy */
>  	ub->dev_info.flags &= ~UBLK_F_SUPPORT_ZERO_COPY;
>  
> diff --git a/drivers/block/ublk_drv.h b/drivers/block/ublk_drv.h
> index f81e62256456..7242430fd6b9 100644
> --- a/drivers/block/ublk_drv.h
> +++ b/drivers/block/ublk_drv.h
> @@ -50,6 +50,21 @@ struct ublk_rq_data {
>  	struct llist_node node;
>  
>  	struct kref ref;
> +	enum ublk_op operation;
> +	__u64 sector;
> +	__u32 nr_sectors;
>  };
>  
> +void ublk_set_nr_zones(struct ublk_device *ub);
> +void ublk_dev_param_zoned_apply(struct ublk_device *ub);
> +int ublk_revalidate_disk_zones(struct gendisk *disk);
> +
> +#ifdef CONFIG_BLK_DEV_UBLK_ZONED
> +int ublk_report_zones(struct gendisk *disk, sector_t sector,
> +		      unsigned int nr_zones, report_zones_cb cb,
> +		      void *data);
> +#else
> +#define ublk_report_zones NULL
> +#endif
> +
>  #endif
> diff --git a/include/uapi/linux/ublk_cmd.h b/include/uapi/linux/ublk_cmd.h
> index 471b3b983045..436525afffe8 100644
> --- a/include/uapi/linux/ublk_cmd.h
> +++ b/include/uapi/linux/ublk_cmd.h
> @@ -176,6 +176,11 @@
>  /* Copy between request and user buffer by pread()/pwrite() */
>  #define UBLK_F_USER_COPY	(1UL << 7)
>  
> +/*
> + * Enable zoned device support
> + */
> +#define UBLK_F_ZONED (1ULL << 8)
> +
>  /* device state */
>  #define UBLK_S_DEV_DEAD	0
>  #define UBLK_S_DEV_LIVE	1
> @@ -242,6 +247,7 @@ enum ublk_op {
>  	UBLK_IO_OP_ZONE_APPEND = 13,
>  	UBLK_IO_OP_ZONE_RESET = 15,
>  	__UBLK_IO_OP_DRV_IN_START = 32,
> +	UBLK_IO_OP_REPORT_ZONES = __UBLK_IO_OP_DRV_IN_START,
>  	__UBLK_IO_OP_DRV_IN_END = 96,
>  	__UBLK_IO_OP_DRV_OUT_START = __UBLK_IO_OP_DRV_IN_END,
>  	__UBLK_IO_OP_DRV_OUT_END = 160,
> @@ -342,6 +348,12 @@ struct ublk_param_devt {
>  	__u32   disk_minor;
>  };
>  
> +struct ublk_param_zoned {
> +	__u32	max_open_zones;
> +	__u32	max_active_zones;
> +	__u8	reserved[24];
> +};

Maybe you can simply borrow virtio_blk_zoned_characteristics definition
here, and make several reserved words.

But that is fine, given six u32 should be flexible enough compared with
virtio_blk_zoned_characteristics.


Thanks,
Ming

