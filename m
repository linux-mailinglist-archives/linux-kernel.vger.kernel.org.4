Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2E82750C99
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 17:33:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233025AbjGLPdf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 11:33:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232761AbjGLPde (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 11:33:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6553F1BDC
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 08:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689175961;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MH9sfzmOuDAulh4b28JZ9NftR6SDDBQoLaeXxIyG/jE=;
        b=CUMcjlnGAecBmKih7sYVPgIm0PJO5D3fKHixZbIRrp6pFh+LtPctHsEOBnir0JIxjcnL7j
        lKARbj7o39TTzzX+9WxhIbISDJLD3c7nUUqQR1yTQfSB9urgkqzt6El1CYNyU24rUW/zLh
        5ngKJsR0CasSfkIWJzVIVprRl79o+uU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-589-b--IA7CZMjSxyAPAfsZhNQ-1; Wed, 12 Jul 2023 11:32:35 -0400
X-MC-Unique: b--IA7CZMjSxyAPAfsZhNQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 663C6185A7A2;
        Wed, 12 Jul 2023 15:32:34 +0000 (UTC)
Received: from ovpn-8-25.pek2.redhat.com (ovpn-8-25.pek2.redhat.com [10.72.8.25])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D61FF1454142;
        Wed, 12 Jul 2023 15:32:24 +0000 (UTC)
Date:   Wed, 12 Jul 2023 23:32:17 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Andreas Hindborg <nmi@metaspace.dk>
Cc:     Hans Holmberg <Hans.Holmberg@wdc.com>,
        Jens Axboe <axboe@kernel.dk>,
        Matias Bjorling <Matias.Bjorling@wdc.com>,
        "open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>, gost.dev@samsung.com,
        open list <linux-kernel@vger.kernel.org>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Aravind Ramesh <Aravind.Ramesh@wdc.com>,
        Damien Le Moal <dlemoal@kernel.org>,
        Minwoo Im <minwoo.im.dev@gmail.com>,
        Johannes Thumshirn <jth@kernel.org>, ming.lei@redhat.com
Subject: Re: [PATCH v8 2/2] ublk: enable zoned storage support
Message-ID: <ZK7HgY9Wt4OT1fjX@ovpn-8-25.pek2.redhat.com>
References: <20230711072353.200873-1-nmi@metaspace.dk>
 <20230711072353.200873-3-nmi@metaspace.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230711072353.200873-3-nmi@metaspace.dk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 11, 2023 at 09:23:53AM +0200, Andreas Hindborg wrote:
> From: Andreas Hindborg <a.hindborg@samsung.com>
> 
> Add zoned storage support to ublk: report_zones and operations:
>  - REQ_OP_ZONE_OPEN
>  - REQ_OP_ZONE_CLOSE
>  - REQ_OP_ZONE_FINISH
>  - REQ_OP_ZONE_RESET
>  - REQ_OP_ZONE_APPEND
> 
> The zone append feature uses the `addr` field of `struct ublksrv_io_cmd` to
> communicate ALBA back to the kernel. Therefore ublk must be used with the
> user copy feature (UBLK_F_USER_COPY) for zoned storage support to be
> available. Without this feature, ublk will not allow zoned storage support.

Without one userspace implementation, it is hard to verify the kernel
change, so I write one zoned target example based on libublk-rs by
taking one day.

https://github.com/ming1/libublk-rs.git [1]

It is one zoned-ramdisk example, and should be easy to
add persistence zoned. All zoned commands are covered, except for
REQ_OP_ZONE_RESET_ALL.

How to create ublk-zoned:

	cargo run --example zoned -- add -1 1024   #1024MB

So far it passes all blktests/zbd tests for external zoned device.

'mkfs.btrfs -O zoned' & mount & git clone linux_kernel in this btrfs
works.

So this patchset gets verified now, so far so good.

[1] not publish to crates.io yet, still need some cleanup

> 
> Signed-off-by: Andreas Hindborg <a.hindborg@samsung.com>
> ---
>  drivers/block/ublk_drv.c      | 314 ++++++++++++++++++++++++++++++++--
>  include/uapi/linux/ublk_cmd.h |  36 +++-
>  2 files changed, 331 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index 8d271901efac..a57be961b708 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -56,16 +56,21 @@
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
> +#define UBLK_PARAM_TYPE_ALL                                \
> +	(UBLK_PARAM_TYPE_BASIC | UBLK_PARAM_TYPE_DISCARD | \
> +	 UBLK_PARAM_TYPE_DEVT | UBLK_PARAM_TYPE_ZONED)
>  
>  struct ublk_rq_data {
>  	struct llist_node node;
>  
>  	struct kref ref;
> +	__u64 sector;
> +	__u32 operation;
> +	__u32 nr_sectors;
>  };
>  
>  struct ublk_uring_cmd_pdu {
> @@ -110,6 +115,11 @@ struct ublk_uring_cmd_pdu {
>   */
>  #define UBLK_IO_FLAG_NEED_GET_DATA 0x08
>  
> +/*
> + * Set when IO is Zone Append
> + */
> +#define UBLK_IO_FLAG_ZONE_APPEND 0x10
> +
>  struct ublk_io {
>  	/* userspace buffer address from io cmd */
>  	__u64	addr;
> @@ -190,6 +200,198 @@ static inline bool ublk_dev_is_user_copy(const struct ublk_device *ub)
>  	return ub->dev_info.flags & UBLK_F_USER_COPY;
>  }
>  
> +static inline bool ublk_dev_is_zoned(const struct ublk_device *ub)
> +{
> +	return ub->dev_info.flags & UBLK_F_ZONED;
> +}
> +
> +static inline bool ublk_queue_is_zoned(struct ublk_queue *ubq)
> +{
> +	return ubq->flags & UBLK_F_ZONED;
> +}
> +
> +#ifdef CONFIG_BLK_DEV_ZONED
> +
> +static int ublk_get_nr_zones(const struct ublk_device *ub)
> +{
> +	const struct ublk_param_basic *p = &ub->params.basic;
> +
> +	/* Zone size is a power of 2 */
> +	return p->dev_sectors >> ilog2(p->chunk_sectors);
> +}
> +
> +static int ublk_revalidate_disk_zones(struct ublk_device *ub)
> +{
> +	return blk_revalidate_disk_zones(ub->ub_disk, NULL);
> +}
> +
> +static int ublk_dev_param_zoned_validate(const struct ublk_device *ub)
> +{
> +	const struct ublk_param_zoned *p = &ub->params.zoned;
> +	int nr_zones;
> +
> +	if (!ublk_dev_is_zoned(ub))
> +		return -EINVAL;
> +
> +	if (!p->max_zone_append_sectors)
> +		return -EINVAL;
> +
> +	nr_zones = ublk_get_nr_zones(ub);
> +
> +	if (p->max_active_zones > nr_zones)
> +		return -EINVAL;
> +
> +	if (p->max_open_zones > nr_zones)
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
> +static int ublk_dev_param_zoned_apply(struct ublk_device *ub)
> +{
> +	const struct ublk_param_zoned *p = &ub->params.zoned;
> +
> +	disk_set_zoned(ub->ub_disk, BLK_ZONED_HM);
> +	blk_queue_required_elevator_features(ub->ub_disk->queue,
> +					     ELEVATOR_F_ZBD_SEQ_WRITE);
> +	disk_set_max_active_zones(ub->ub_disk, p->max_active_zones);
> +	disk_set_max_open_zones(ub->ub_disk, p->max_open_zones);
> +	blk_queue_max_zone_append_sectors(ub->ub_disk->queue, p->max_zone_append_sectors);
> +
> +	ub->ub_disk->nr_zones = ublk_get_nr_zones(ub);
> +
> +	return 0;
> +}
> +
> +/* Based on virtblk_alloc_report_buffer */
> +static void *ublk_alloc_report_buffer(struct ublk_device *ublk,
> +				      unsigned int nr_zones, size_t *buflen)
> +{
> +	struct request_queue *q = ublk->ub_disk->queue;
> +	size_t bufsize;
> +	void *buf;
> +
> +	nr_zones = min_t(unsigned int, nr_zones,
> +			 ublk->ub_disk->nr_zones);
> +
> +	bufsize = nr_zones * sizeof(struct blk_zone);
> +	bufsize =
> +		min_t(size_t, bufsize, queue_max_hw_sectors(q) << SECTOR_SHIFT);
> +	bufsize = min_t(size_t, bufsize, queue_max_segments(q) << PAGE_SHIFT);

'bufsize' shouldn't related with queue_max_segments() given we don't
enable segment limit yet.

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
> +	*buflen = 0;
> +	return NULL;
> +}
> +
> +static int ublk_report_zones(struct gendisk *disk, sector_t sector,
> +		      unsigned int nr_zones, report_zones_cb cb, void *data)
> +{
> +	struct ublk_device *ub = disk->private_data;
> +	unsigned int zone_size_sectors = disk->queue->limits.chunk_sectors;
> +	unsigned int first_zone = sector >> ilog2(zone_size_sectors);
> +	unsigned int done_zones = 0;
> +	unsigned int max_zones_per_request;
> +	int ret;
> +	struct blk_zone *buffer;
> +	size_t buffer_length;
> +
> +	nr_zones = min_t(unsigned int, ub->ub_disk->nr_zones - first_zone,
> +			 nr_zones);
> +
> +	buffer = ublk_alloc_report_buffer(ub, nr_zones, &buffer_length);
> +	if (!buffer)
> +		return -ENOMEM;
> +
> +	max_zones_per_request = buffer_length / sizeof(struct blk_zone);
> +
> +	while (done_zones < nr_zones) {
> +		unsigned int remaining_zones = nr_zones - done_zones;
> +		unsigned int zones_in_request =
> +			min_t(unsigned int, remaining_zones, max_zones_per_request);
> +		struct request *req;
> +		struct ublk_rq_data *pdu;
> +		blk_status_t status;
> +
> +		memset(buffer, 0, buffer_length);
> +
> +		req = blk_mq_alloc_request(disk->queue, REQ_OP_DRV_IN, 0);
> +		if (IS_ERR(req)) {
> +			ret = PTR_ERR(req);
> +			goto out;
> +		}
> +
> +		pdu = blk_mq_rq_to_pdu(req);
> +		pdu->operation = UBLK_IO_OP_REPORT_ZONES;
> +		pdu->sector = sector;
> +		pdu->nr_sectors = remaining_zones * zone_size_sectors;

pdu->nr_sectors will be set to ublksrv_io_desc->nr_sectors as part of
UAPI, I feel it is hard to understand to pass 'remaining_zones * zone_size_sectors',
probably it is fine to re-define as buffer size or requested
nr_blk_zone, or other ideas?

> +
> +		ret = blk_rq_map_kern(disk->queue, req, buffer, buffer_length,
> +					GFP_KERNEL);
> +		if (ret) {
> +			blk_mq_free_request(req);
> +			goto out;
> +		}
> +
> +		status = blk_execute_rq(req, 0);
> +		ret = blk_status_to_errno(status);
> +		blk_mq_free_request(req);
> +		if (ret)
> +			goto out;
> +
> +		for (unsigned int i = 0; i < zones_in_request; i++) {
> +			struct blk_zone *zone = buffer + i;
> +
> +			/* A zero length zone means no more zones in this response */
> +			if (!zone->len)
> +				break;
> +
> +			ret = cb(zone, i, data);
> +			if (ret)
> +				goto out;
> +
> +			done_zones++;
> +			sector += zone_size_sectors;
> +
> +		}
> +	}
> +
> +	ret = done_zones;
> +
> +out:
> +	kvfree(buffer);
> +	return ret;
> +}
> +
> +#else
> +
> +#define ublk_report_zones (NULL)
> +
> +static int ublk_dev_param_zoned_validate(const struct ublk_device *ub)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
> +static int ublk_dev_param_zoned_apply(struct ublk_device *ub)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
> +static int ublk_revalidate_disk_zones(struct ublk_device *ub)
> +{
> +	return 0;
> +}
> +
> +#endif
> +
>  static inline void __ublk_complete_rq(struct request *req);
>  static void ublk_complete_rq(struct kref *ref);
>  
> @@ -232,7 +434,7 @@ static inline unsigned ublk_pos_to_tag(loff_t pos)
>  		UBLK_TAG_BITS_MASK;
>  }
>  
> -static void ublk_dev_param_basic_apply(struct ublk_device *ub)
> +static int ublk_dev_param_basic_apply(struct ublk_device *ub)
>  {
>  	struct request_queue *q = ub->ub_disk->queue;
>  	const struct ublk_param_basic *p = &ub->params.basic;
> @@ -257,6 +459,8 @@ static void ublk_dev_param_basic_apply(struct ublk_device *ub)
>  		set_disk_ro(ub->ub_disk, true);
>  
>  	set_capacity(ub->ub_disk, p->dev_sectors);
> +
> +	return 0;
>  }
>  
>  static void ublk_dev_param_discard_apply(struct ublk_device *ub)
> @@ -286,6 +490,9 @@ static int ublk_validate_params(const struct ublk_device *ub)
>  
>  		if (p->max_sectors > (ub->dev_info.max_io_buf_bytes >> 9))
>  			return -EINVAL;
> +
> +		if (ublk_dev_is_zoned(ub) && !p->chunk_sectors)
> +			return -EINVAL;
>  	} else
>  		return -EINVAL;
>  
> @@ -304,19 +511,31 @@ static int ublk_validate_params(const struct ublk_device *ub)
>  	if (ub->params.types & UBLK_PARAM_TYPE_DEVT)
>  		return -EINVAL;
>  
> +	if (ub->params.types & UBLK_PARAM_TYPE_ZONED)
> +		return ublk_dev_param_zoned_validate(ub);
> +	else if (ublk_dev_is_zoned(ub))
> +		return -EINVAL;
> +
>  	return 0;
>  }
>  
>  static int ublk_apply_params(struct ublk_device *ub)
>  {
> +	int ret;
> +
>  	if (!(ub->params.types & UBLK_PARAM_TYPE_BASIC))
>  		return -EINVAL;
>  
> -	ublk_dev_param_basic_apply(ub);
> +	ret = ublk_dev_param_basic_apply(ub);
> +	if (ret)
> +		return ret;
>  
>  	if (ub->params.types & UBLK_PARAM_TYPE_DISCARD)
>  		ublk_dev_param_discard_apply(ub);
>  
> +	if (ub->params.types & UBLK_PARAM_TYPE_ZONED)
> +		return ublk_dev_param_zoned_apply(ub);
> +
>  	return 0;
>  }
>  
> @@ -487,6 +706,7 @@ static const struct block_device_operations ub_fops = {
>  	.owner =	THIS_MODULE,
>  	.open =		ublk_open,
>  	.free_disk =	ublk_free_disk,
> +	.report_zones =	ublk_report_zones,
>  };
>  
>  #define UBLK_MAX_PIN_PAGES	32
> @@ -601,7 +821,8 @@ static inline bool ublk_need_map_req(const struct request *req)
>  
>  static inline bool ublk_need_unmap_req(const struct request *req)
>  {
> -	return ublk_rq_has_data(req) && req_op(req) == REQ_OP_READ;
> +	return ublk_rq_has_data(req) &&
> +	       (req_op(req) == REQ_OP_READ || req_op(req) == REQ_OP_DRV_IN);
>  }
>  
>  static int ublk_map_io(const struct ublk_queue *ubq, const struct request *req,
> @@ -685,8 +906,14 @@ static blk_status_t ublk_setup_iod(struct ublk_queue *ubq, struct request *req)
>  {
>  	struct ublksrv_io_desc *iod = ublk_get_iod(ubq, req->tag);
>  	struct ublk_io *io = &ubq->ios[req->tag];
> +	struct ublk_rq_data *pdu = blk_mq_rq_to_pdu(req);
> +	enum req_op op = req_op(req);
>  	u32 ublk_op;
>  
> +	if (!ublk_queue_is_zoned(ubq) &&
> +	    (op_is_zone_mgmt(op) || op == REQ_OP_ZONE_APPEND))
> +		return -EIO;
> +
>  	switch (req_op(req)) {
>  	case REQ_OP_READ:
>  		ublk_op = UBLK_IO_OP_READ;
> @@ -703,6 +930,37 @@ static blk_status_t ublk_setup_iod(struct ublk_queue *ubq, struct request *req)
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
> +			return BLK_STS_OK;
> +		default:
> +			return BLK_STS_IOERR;
> +		}
> +	case REQ_OP_ZONE_APPEND:
> +		ublk_op = UBLK_IO_OP_ZONE_APPEND;
> +		io->flags |= UBLK_IO_FLAG_ZONE_APPEND;
> +		break;
> +	case REQ_OP_ZONE_RESET_ALL:
> +	case REQ_OP_DRV_OUT:
> +		/* We do not support reset_all and drv_out */
> +		return BLK_STS_NOTSUPP;

I'd suggest to move all zoned handling & the above check into one helper,
such as:

	default:
		if (ublk_queue_is_zoned())
			return ublk_zoned_setup_iod();

Then zoned check can be avoided for other generic OPs, and zoned patch
conflict could be avoided usually.

Anyway, this version looks much better, and I think we are close to
go.

Thanks,
Ming

