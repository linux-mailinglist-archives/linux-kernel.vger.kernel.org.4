Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DD5E74A80A
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 02:19:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230435AbjGGATe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 20:19:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbjGGATd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 20:19:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3678B1737;
        Thu,  6 Jul 2023 17:19:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ADADC61476;
        Fri,  7 Jul 2023 00:19:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 962FFC433C8;
        Fri,  7 Jul 2023 00:19:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688689170;
        bh=OmX4TS+yT80y7wzac9qlnxmJoRm6Kp8xMY2W086QTU4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=H+VuyiCINt5HgnCUZiX5zfSWYRdhqvEH7YVuXSa8QZd5ngBbTOYGwyeBohMgNYlnS
         tHVoagJyUoxn1Vmwadk+J+VG7g0s5HPZJLY1fXBAvQqaCn+uSWMW4P2QU76qORh0MT
         KoznUaJ7i6v3RdtVvJDk5a3EZlh2rjsiwtbCFQ+J+xjxi0D+s05RF5LYmJXuCDy/ys
         9/e3kGUSDPQgj8J0R5LGNIXQwIeSYDyW7i+EYGVBa2MjfXWRx33GHK6Vu9Fb2uFRfg
         nNCc8I8/+8t/+lSo0P50S5I3s6ndfYi1vI1EYt+gkKWEsc+Ob4d9MK68+BIz58dqrp
         v1yj78+flb5Cw==
Message-ID: <8b26ec7d-2f01-0fc8-b1fb-05c115268741@kernel.org>
Date:   Fri, 7 Jul 2023 09:19:27 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v6 3/3] ublk: enable zoned storage support
Content-Language: en-US
To:     Andreas Hindborg <nmi@metaspace.dk>, Ming Lei <ming.lei@redhat.com>
Cc:     open list <linux-kernel@vger.kernel.org>,
        "open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Minwoo Im <minwoo.im.dev@gmail.com>,
        Matias Bjorling <Matias.Bjorling@wdc.com>,
        gost.dev@samsung.com, Jens Axboe <axboe@kernel.dk>,
        Aravind Ramesh <Aravind.Ramesh@wdc.com>,
        Johannes Thumshirn <jth@kernel.org>,
        Hans Holmberg <Hans.Holmberg@wdc.com>,
        Christoph Hellwig <hch@infradead.org>
References: <20230706130930.64283-1-nmi@metaspace.dk>
 <20230706130930.64283-4-nmi@metaspace.dk>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230706130930.64283-4-nmi@metaspace.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/6/23 22:09, Andreas Hindborg wrote:
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
> 
> Signed-off-by: Andreas Hindborg <a.hindborg@samsung.com>
> ---
>  drivers/block/Kconfig         |   4 +
>  drivers/block/ublk_drv.c      | 341 ++++++++++++++++++++++++++++++++--
>  include/uapi/linux/ublk_cmd.h |  30 +++
>  3 files changed, 363 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/block/Kconfig b/drivers/block/Kconfig
> index 5b9d4aaebb81..3f7bedae8511 100644
> --- a/drivers/block/Kconfig
> +++ b/drivers/block/Kconfig
> @@ -373,6 +373,7 @@ config BLK_DEV_RBD
>  config BLK_DEV_UBLK
>  	tristate "Userspace block driver (Experimental)"
>  	select IO_URING
> +	select BLK_DEV_UBLK_ZONED if BLK_DEV_ZONED

You are not adding a new file anymore. So I do not see the point of
this. You can directly use "#if[n]def CONFIG_BLK_DEV_ZONED".

>  	help
>  	  io_uring based userspace block driver. Together with ublk server, ublk
>  	  has been working well, but interface with userspace or command data
> @@ -402,6 +403,9 @@ config BLKDEV_UBLK_LEGACY_OPCODES
>  	  suggested to enable N if your application(ublk server) switches to
>  	  ioctl command encoding.
>  
> +config BLK_DEV_UBLK_ZONED
> +	bool

See above. Not needed.

> +
>  source "drivers/block/rnbd/Kconfig"
>  
>  endif # BLK_DEV
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index 8d271901efac..a5adcfc976a5 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -56,22 +56,28 @@
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
> +	__u32 operation;
> +	__u64 sector;
> +	__u32 nr_sectors;
>  };
>  
>  struct ublk_uring_cmd_pdu {
>  	struct ublk_queue *ubq;
>  };
>  
> +
>  /*
>   * io command is active: sqe cmd is received, and its cqe isn't done
>   *
> @@ -110,6 +116,11 @@ struct ublk_uring_cmd_pdu {
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
> @@ -184,6 +195,31 @@ struct ublk_params_header {
>  	__u32	len;
>  	__u32	types;
>  };

A blank line here would be nice.

> +static inline int ublk_dev_params_zoned(const struct ublk_device *ub)
> +{
> +	return ub->params.types & UBLK_PARAM_TYPE_ZONED;
> +}
> +
> +static inline bool ublk_dev_is_zoned(const struct ublk_device *ub)
> +{
> +	return ub->dev_info.flags & UBLK_F_ZONED;
> +}
> +
> +static int ublk_set_nr_zones(struct ublk_device *ub);
> +static int ublk_dev_param_zoned_validate(const struct ublk_device *ub);
> +static int ublk_dev_param_zoned_apply(struct ublk_device *ub);
> +static int ublk_revalidate_disk_zones(struct ublk_device *ub);
> +
> +#ifndef CONFIG_BLK_DEV_UBLK_ZONED
> +
> +#define ublk_report_zones (NULL)
> +
> +#else
> +
> +static int ublk_report_zones(struct gendisk *disk, sector_t sector,
> +		      unsigned int nr_zones, report_zones_cb cb, void *data);
> +
> +#endif
>  
>  static inline bool ublk_dev_is_user_copy(const struct ublk_device *ub)
>  {
> @@ -232,7 +268,7 @@ static inline unsigned ublk_pos_to_tag(loff_t pos)
>  		UBLK_TAG_BITS_MASK;
>  }
>  
> -static void ublk_dev_param_basic_apply(struct ublk_device *ub)
> +static int ublk_dev_param_basic_apply(struct ublk_device *ub)
>  {
>  	struct request_queue *q = ub->ub_disk->queue;
>  	const struct ublk_param_basic *p = &ub->params.basic;
> @@ -257,6 +293,11 @@ static void ublk_dev_param_basic_apply(struct ublk_device *ub)
>  		set_disk_ro(ub->ub_disk, true);
>  
>  	set_capacity(ub->ub_disk, p->dev_sectors);
> +
> +	if (ublk_dev_is_zoned(ub))
> +		return ublk_set_nr_zones(ub);
> +
> +	return 0;
>  }
>  
>  static void ublk_dev_param_discard_apply(struct ublk_device *ub)
> @@ -286,6 +327,9 @@ static int ublk_validate_params(const struct ublk_device *ub)
>  
>  		if (p->max_sectors > (ub->dev_info.max_io_buf_bytes >> 9))
>  			return -EINVAL;
> +
> +		if (ublk_dev_is_zoned(ub) && !p->chunk_sectors)
> +			return -EINVAL;
>  	} else
>  		return -EINVAL;
>  
> @@ -304,19 +348,26 @@ static int ublk_validate_params(const struct ublk_device *ub)
>  	if (ub->params.types & UBLK_PARAM_TYPE_DEVT)
>  		return -EINVAL;
>  
> -	return 0;
> +	return ublk_dev_param_zoned_validate(ub);
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
> +	if (ublk_dev_params_zoned(ub))
> +		return ublk_dev_param_zoned_apply(ub);
> +
>  	return 0;
>  }
>  
> @@ -487,6 +538,7 @@ static const struct block_device_operations ub_fops = {
>  	.owner =	THIS_MODULE,
>  	.open =		ublk_open,
>  	.free_disk =	ublk_free_disk,
> +	.report_zones =	ublk_report_zones,
>  };
>  
>  #define UBLK_MAX_PIN_PAGES	32
> @@ -601,7 +653,8 @@ static inline bool ublk_need_map_req(const struct request *req)
>  
>  static inline bool ublk_need_unmap_req(const struct request *req)
>  {
> -	return ublk_rq_has_data(req) && req_op(req) == REQ_OP_READ;
> +	return ublk_rq_has_data(req) &&
> +	       (req_op(req) == REQ_OP_READ || req_op(req) == REQ_OP_DRV_IN);
>  }
>  
>  static int ublk_map_io(const struct ublk_queue *ubq, const struct request *req,
> @@ -685,6 +738,7 @@ static blk_status_t ublk_setup_iod(struct ublk_queue *ubq, struct request *req)
>  {
>  	struct ublksrv_io_desc *iod = ublk_get_iod(ubq, req->tag);
>  	struct ublk_io *io = &ubq->ios[req->tag];
> +	struct ublk_rq_data *pdu = blk_mq_rq_to_pdu(req);
>  	u32 ublk_op;
>  
>  	switch (req_op(req)) {
> @@ -703,6 +757,37 @@ static blk_status_t ublk_setup_iod(struct ublk_queue *ubq, struct request *req)
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
> +		fallthrough;

It would be nice to check that zone operations are attempted only on
zoned drives. Something like:

	if (!ublk_dev_is_zoned(ub) &&
	    (op_is_zone_mgmt(op) || op == REQ_OP_ZONE_APPEND))
		return -EIO;

before the switch-case maybe ?

>  	default:
>  		return BLK_STS_IOERR;
>  	}
> @@ -756,7 +841,8 @@ static inline void __ublk_complete_rq(struct request *req)
>  	 *
>  	 * Both the two needn't unmap.
>  	 */
> -	if (req_op(req) != REQ_OP_READ && req_op(req) != REQ_OP_WRITE)
> +	if (req_op(req) != REQ_OP_READ && req_op(req) != REQ_OP_WRITE &&
> +	    req_op(req) != REQ_OP_DRV_IN)
>  		goto exit;
>  
>  	/* for READ request, writing data in iod->addr to rq buffers */
> @@ -1120,6 +1206,11 @@ static void ublk_commit_completion(struct ublk_device *ub,
>  	/* find the io request and complete */
>  	req = blk_mq_tag_to_rq(ub->tag_set.tags[qid], tag);
>  
> +	if (io->flags & UBLK_IO_FLAG_ZONE_APPEND) {
> +		req->__sector = ub_cmd->addr;
> +		io->flags &= ~UBLK_IO_FLAG_ZONE_APPEND;
> +	}
> +
>  	if (req && likely(!blk_should_fake_timeout(req->q)))
>  		ublk_put_req_ref(ubq, req);
>  }
> @@ -1419,7 +1510,8 @@ static int __ublk_ch_uring_cmd(struct io_uring_cmd *cmd,
>  			^ (_IOC_NR(cmd_op) == UBLK_IO_NEED_GET_DATA))
>  		goto out;
>  
> -	if (ublk_support_user_copy(ubq) && ub_cmd->addr) {
> +	if (ublk_support_user_copy(ubq) &&
> +	    !(io->flags & UBLK_IO_FLAG_ZONE_APPEND) && ub_cmd->addr) {
>  		ret = -EINVAL;
>  		goto out;
>  	}
> @@ -1542,11 +1634,14 @@ static inline bool ublk_check_ubuf_dir(const struct request *req,
>  		int ubuf_dir)
>  {
>  	/* copy ubuf to request pages */
> -	if (req_op(req) == REQ_OP_READ && ubuf_dir == ITER_SOURCE)
> +	if ((req_op(req) == REQ_OP_READ || req_op(req) == REQ_OP_DRV_IN) &&
> +	    ubuf_dir == ITER_SOURCE)
>  		return true;
>  
>  	/* copy request pages to ubuf */
> -	if (req_op(req) == REQ_OP_WRITE && ubuf_dir == ITER_DEST)
> +	if ((req_op(req) == REQ_OP_WRITE ||
> +	     req_op(req) == REQ_OP_ZONE_APPEND) &&
> +	    ubuf_dir == ITER_DEST)
>  		return true;
>  
>  	return false;
> @@ -1883,8 +1978,12 @@ static int ublk_ctrl_start_dev(struct ublk_device *ub, struct io_uring_cmd *cmd)
>  	if (ub->nr_privileged_daemon != ub->nr_queues_ready)
>  		set_bit(GD_SUPPRESS_PART_SCAN, &disk->state);
>  
> -	get_device(&ub->cdev_dev);

Why move this ? Isn't it better to do the revalidate while holding a ref
on the device to avoid racies with remove ?

>  	ub->dev_info.state = UBLK_S_DEV_LIVE;
> +	ret = ublk_revalidate_disk_zones(ub);
> +	if (ret)
> +		goto out_put_disk;

No need to clear the LIVE flag ?

> +
> +	get_device(&ub->cdev_dev);
>  	ret = add_disk(disk);
>  	if (ret) {
>  		/*
> @@ -2045,6 +2144,13 @@ static int ublk_ctrl_add_dev(struct io_uring_cmd *cmd)
>  	if (ublk_dev_is_user_copy(ub))
>  		ub->dev_info.flags &= ~UBLK_F_NEED_GET_DATA;
>  
> +	/* Zoned storage support requires user copy feature */
> +	if (ublk_dev_is_zoned(ub) &&
> +	    (!IS_ENABLED(CONFIG_BLK_DEV_UBLK_ZONED) || !ublk_dev_is_user_copy(ub))) {

See top comment. Use CONFIG_BLK_DEV_ZONED directly.

> +		ret = -EINVAL;
> +		goto out_free_dev_number;
> +	}
> +
>  	/* We are not ready to support zero copy */
>  	ub->dev_info.flags &= ~UBLK_F_SUPPORT_ZERO_COPY;
>  
> @@ -2629,3 +2735,214 @@ MODULE_PARM_DESC(ublks_max, "max number of ublk devices allowed to add(default:
>  
>  MODULE_AUTHOR("Ming Lei <ming.lei@redhat.com>");
>  MODULE_LICENSE("GPL");
> +
> +#ifdef CONFIG_BLK_DEV_UBLK_ZONED

Why put these at the end ? Code after the MODULE_XXX() macros is rather
unusual. If you move all this at the top, you can likely avoid the
forward declarations as well.

> +
> +static int get_nr_zones(const struct ublk_device *ub)

ublk_get_nr_zones() ?

> +{
> +	const struct ublk_param_basic *p = &ub->params.basic;
> +
> +	if (!p->chunk_sectors)
> +		return 0;
> +
> +	/* Zone size is a power of 2 */
> +	return p->dev_sectors >> ilog2(p->chunk_sectors);
> +}
> +
> +static int ublk_set_nr_zones(struct ublk_device *ub)
> +{
> +	ub->ub_disk->nr_zones = get_nr_zones(ub);
> +	if (!ub->ub_disk->nr_zones)
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
> +static int ublk_revalidate_disk_zones(struct ublk_device *ub)
> +{
> +	if (ublk_dev_is_zoned(ub))

Nit: This if could be moved to the caller site.

> +		return blk_revalidate_disk_zones(ub->ub_disk, NULL);
> +
> +	return 0;
> +}
> +
> +static int ublk_dev_param_zoned_validate(const struct ublk_device *ub)
> +{
> +	const struct ublk_param_zoned *p = &ub->params.zoned;
> +	int nr_zones;
> +
> +	if (ublk_dev_is_zoned(ub) && !ublk_dev_params_zoned(ub))
> +		return -EINVAL;
> +
> +	if (!ublk_dev_is_zoned(ub) && ublk_dev_params_zoned(ub))
> +		return -EINVAL;
> +
> +	if (!ublk_dev_params_zoned(ub))
> +		return 0;
> +
> +	if (!p->max_zone_append_sectors)
> +		return -EINVAL;
> +
> +	nr_zones = get_nr_zones(ub);
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
> +	return 0;

Make the function void if there is no error return.

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
> +	if (!ublk_dev_is_zoned(ub))
> +		return -EOPNOTSUPP;

See comment above. This shoud be checked when the command is received,
together with all other zoned operations.

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

Nit: if this happens while you already got some zones in the report
(that is, not on the first iteration), then you could return these zones
instead of an error. But not a big deal.

> +			goto out;
> +		}
> +
> +		pdu = blk_mq_rq_to_pdu(req);
> +		pdu->operation = UBLK_IO_OP_REPORT_ZONES;
> +		pdu->sector = sector;
> +		pdu->nr_sectors = remaining_zones * zone_size_sectors;
> +
> +		ret = blk_rq_map_kern(disk->queue, req, buffer, buffer_length,
> +					GFP_KERNEL);
> +		if (ret) {
> +			blk_mq_free_request(req);

Same here.

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
> +static int ublk_set_nr_zones(struct ublk_device *ub)
> +{
> +	return 0;
> +}
> +
> +static int ublk_dev_param_zoned_validate(const struct ublk_device *ub)
> +{
> +	if (ublk_dev_params_zoned(ub))
> +		return -EINVAL;
> +	return 0;
> +}
> +
> +static int ublk_dev_param_zoned_apply(struct ublk_device *ub)
> +{
> +	if (ublk_dev_params_zoned(ub))
> +		return -EINVAL;

The caller site calls this only if ublk_dev_params_zoned() is true. So
this should be an unconditional return -ENOTSUPP I think.

> +	return 0;
> +}
> +
> +static int ublk_revalidate_disk_zones(struct ublk_device *ub)
> +{
> +	return 0;
> +}
> +
> +#endif
> diff --git a/include/uapi/linux/ublk_cmd.h b/include/uapi/linux/ublk_cmd.h
> index 2ebb8d5d827a..234c194f0a82 100644
> --- a/include/uapi/linux/ublk_cmd.h
> +++ b/include/uapi/linux/ublk_cmd.h
> @@ -176,6 +176,12 @@
>  /* Copy between request and user buffer by pread()/pwrite() */
>  #define UBLK_F_USER_COPY	(1UL << 7)
>  
> +/*
> + * User space sets this flag when setting up the device to request zoned storage support. Kernel may
> + * deny the request by returning an error.
> + */
> +#define UBLK_F_ZONED (1ULL << 8)
> +
>  /* device state */
>  #define UBLK_S_DEV_DEAD	0
>  #define UBLK_S_DEV_LIVE	1
> @@ -235,6 +241,11 @@ struct ublksrv_ctrl_dev_info {
>  #define		UBLK_IO_OP_DISCARD		3
>  #define		UBLK_IO_OP_WRITE_SAME		4
>  #define		UBLK_IO_OP_WRITE_ZEROES		5
> +#define		UBLK_IO_OP_ZONE_OPEN		10
> +#define		UBLK_IO_OP_ZONE_CLOSE		11
> +#define		UBLK_IO_OP_ZONE_FINISH		12
> +#define		UBLK_IO_OP_ZONE_APPEND		13
> +#define		UBLK_IO_OP_ZONE_RESET		15
>  /*
>   * Passthrough (driver private) operation codes range between
>   * __UBLK_IO_OP_DRV_IN_START and __UBLK_IO_OP_DRV_IN_END for REQ_OP_DRV_IN type
> @@ -242,6 +253,16 @@ struct ublksrv_ctrl_dev_info {
>   * __UBLK_IO_OP_DRV_OUT_END for REQ_OP_DRV_OUT type operations.
>   */
>  #define		__UBLK_IO_OP_DRV_IN_START	32
> +/*
> + * Construct a zone report. The report request is carried in `struct
> + * ublksrv_io_desc`. The `start_sector` field must be the first sector of a zone
> + * and shall indicate the first zone of the report. The `nr_sectors` shall
> + * indicate how many zones should be reported (divide by zone size to get number
> + * of zones in the report) and must be an integer multiple of the zone size. The
> + * report shall be delivered as a `struct blk_zone` array. To report fewer zones
> + * than requested, zero the last entry of the returned array.
> + */
> +#define		UBLK_IO_OP_REPORT_ZONES		__UBLK_IO_OP_DRV_IN_START
>  #define		__UBLK_IO_OP_DRV_IN_END		96
>  #define		__UBLK_IO_OP_DRV_OUT_START	__UBLK_IO_OP_DRV_IN_END
>  #define		__UBLK_IO_OP_DRV_OUT_END	160
> @@ -341,6 +362,13 @@ struct ublk_param_devt {
>  	__u32   disk_minor;
>  };
>  
> +struct ublk_param_zoned {
> +	__u32	max_open_zones;
> +	__u32	max_active_zones;
> +	__u32	max_zone_append_sectors;
> +	__u8	reserved[20];
> +};
> +
>  struct ublk_params {
>  	/*
>  	 * Total length of parameters, userspace has to set 'len' for both
> @@ -352,11 +380,13 @@ struct ublk_params {
>  #define UBLK_PARAM_TYPE_BASIC           (1 << 0)
>  #define UBLK_PARAM_TYPE_DISCARD         (1 << 1)
>  #define UBLK_PARAM_TYPE_DEVT            (1 << 2)
> +#define UBLK_PARAM_TYPE_ZONED           (1 << 3)
>  	__u32	types;			/* types of parameter included */
>  
>  	struct ublk_param_basic		basic;
>  	struct ublk_param_discard	discard;
>  	struct ublk_param_devt		devt;
> +	struct ublk_param_zoned	zoned;
>  };
>  
>  #endif

-- 
Damien Le Moal
Western Digital Research

