Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE661741C51
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 01:17:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231547AbjF1XRd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 19:17:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231752AbjF1XR2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 19:17:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A1CB2708;
        Wed, 28 Jun 2023 16:17:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1D5126146F;
        Wed, 28 Jun 2023 23:17:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46F26C433C8;
        Wed, 28 Jun 2023 23:17:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687994246;
        bh=uzlUpX0E4wshH0A6HmIqnN+/L0oJuxdHYf109D/DgVs=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=tsTAN0cC4EgSY7XQd1XjBE1vk8yPbvN2BXGOWkud9NQ5zV/PLvCz1cy+uFW8B9zkx
         sTdtNSK/WdTmbht2yZphFguGIgBwe1LFmB6yqfUBakLVMCtRkKcvVp175IARFPFwGu
         W/CbHwmSoy/mEfu1TUVc1XtqBHDFFXkRQ24ODgttY1Evpxp2wbmOISdx/Ktooh7sdZ
         pwZVbxn4ZKgdjlmiLFbL6vyJibdi/iLEfOG2YBk8bwCA6tmIdSJkbJ0Pw18p7zvPWm
         Wds5+8MOVqei8wA6qAVcjYPMQN7SKU3N6IT/uoZNCez09MAWMA09i8khTjyW01LhUX
         HIpMwVnJ4zAcg==
Message-ID: <9411fb6a-7a87-d740-c624-7c853d2fd3c5@kernel.org>
Date:   Thu, 29 Jun 2023 08:17:24 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v4 4/4] ublk: add zone append
Content-Language: en-US
To:     Andreas Hindborg <nmi@metaspace.dk>, Ming Lei <ming.lei@redhat.com>
Cc:     Hans Holmberg <Hans.Holmberg@wdc.com>,
        Aravind Ramesh <Aravind.Ramesh@wdc.com>,
        Jens Axboe <axboe@kernel.dk>,
        "open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Matias Bjorling <Matias.Bjorling@wdc.com>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        open list <linux-kernel@vger.kernel.org>, gost.dev@samsung.com,
        Minwoo Im <minwoo.im.dev@gmail.com>
References: <20230628190649.11233-1-nmi@metaspace.dk>
 <20230628190649.11233-5-nmi@metaspace.dk>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230628190649.11233-5-nmi@metaspace.dk>
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

On 6/29/23 04:06, Andreas Hindborg wrote:
> From: Andreas Hindborg <a.hindborg@samsung.com>
> 
> Add zone append feature to ublk. This feature uses the `addr` field of `struct
> ublksrv_io_cmd`. Therefore ublk must be used with the user copy
> feature (UBLK_F_USER_COPY) for zone append to be available. Without this
> feature, ublk will fail zone append requests.
> 
> Suggested-by: Ming Lei <ming.lei@redhat.com>
> Signed-off-by: Andreas Hindborg <a.hindborg@samsung.com>

This needs to be squashed in patch 3.

> ---
>  drivers/block/ublk_drv-zoned.c | 11 +++++++++
>  drivers/block/ublk_drv.c       | 43 ++++++++++++++++++++++++++++++----
>  drivers/block/ublk_drv.h       |  1 +
>  include/uapi/linux/ublk_cmd.h  |  3 ++-
>  4 files changed, 52 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/block/ublk_drv-zoned.c b/drivers/block/ublk_drv-zoned.c
> index ea86bf4b3681..007e8fc7ff25 100644
> --- a/drivers/block/ublk_drv-zoned.c
> +++ b/drivers/block/ublk_drv-zoned.c
> @@ -16,6 +16,16 @@ void ublk_set_nr_zones(struct ublk_device *ub)
>  		ub->ub_disk->nr_zones = p->dev_sectors / p->chunk_sectors;
>  }
>  
> +int ublk_dev_param_zoned_validate(const struct ublk_device *ub)
> +{
> +	const struct ublk_param_zoned *p = &ub->params.zoned;
> +
> +	if (! p->max_zone_append_sectors)
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
>  void ublk_dev_param_zoned_apply(struct ublk_device *ub)
>  {
>  	const struct ublk_param_zoned *p = &ub->params.zoned;
> @@ -23,6 +33,7 @@ void ublk_dev_param_zoned_apply(struct ublk_device *ub)
>  	if (ub->dev_info.flags & UBLK_F_ZONED) {
>  		disk_set_max_active_zones(ub->ub_disk, p->max_active_zones);
>  		disk_set_max_open_zones(ub->ub_disk, p->max_open_zones);
> +		blk_queue_max_zone_append_sectors(ub->ub_disk->queue, p->max_zone_append_sectors);
>  	}
>  }
>  
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index 88fa39853c61..6a949669b47e 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -107,6 +107,11 @@ struct ublk_uring_cmd_pdu {
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
> @@ -230,6 +235,8 @@ static void ublk_dev_param_discard_apply(struct ublk_device *ub)
>  
>  static int ublk_validate_params(const struct ublk_device *ub)
>  {
> +	int ret = 0;
> +
>  	/* basic param is the only one which must be set */
>  	if (ub->params.types & UBLK_PARAM_TYPE_BASIC) {
>  		const struct ublk_param_basic *p = &ub->params.basic;
> @@ -260,6 +267,13 @@ static int ublk_validate_params(const struct ublk_device *ub)
>  	if (ub->params.types & UBLK_PARAM_TYPE_DEVT)
>  		return -EINVAL;
>  
> +	if (IS_ENABLED(CONFIG_BLK_DEV_ZONED) &&
> +	    (ub->params.types & UBLK_PARAM_TYPE_ZONED)) {
> +		ret = ublk_dev_param_zoned_validate(ub);
> +		if (ret)
> +			return ret;
> +	}
> +
>  	return 0;
>  }
>  
> @@ -690,6 +704,11 @@ static blk_status_t ublk_setup_iod(struct ublk_queue *ubq, struct request *req)
>  			return BLK_STS_IOERR;
>  		}
>  	case REQ_OP_ZONE_APPEND:
> +		if (!(ubq->dev->dev_info.flags & UBLK_F_USER_COPY))
> +			return BLK_STS_IOERR;
> +		ublk_op = UBLK_IO_OP_ZONE_APPEND;
> +		io->flags |= UBLK_IO_FLAG_ZONE_APPEND;
> +		break;
>  	case REQ_OP_ZONE_RESET_ALL:
>  	case REQ_OP_DRV_OUT:
>  		/* We do not support zone append or reset_all yet */
> @@ -1112,6 +1131,12 @@ static void ublk_commit_completion(struct ublk_device *ub,
>  	/* find the io request and complete */
>  	req = blk_mq_tag_to_rq(ub->tag_set.tags[qid], tag);
>  
> +	if (IS_ENABLED(CONFIG_BLK_DEV_ZONED)) {
> +		if (io->flags & UBLK_IO_FLAG_ZONE_APPEND)
> +			req->__sector = ub_cmd->addr;
> +		io->flags &= ~UBLK_IO_FLAG_ZONE_APPEND;
> +	}
> +
>  	if (req && likely(!blk_should_fake_timeout(req->q)))
>  		ublk_put_req_ref(ubq, req);
>  }
> @@ -1411,7 +1436,8 @@ static int __ublk_ch_uring_cmd(struct io_uring_cmd *cmd,
>  			^ (_IOC_NR(cmd_op) == UBLK_IO_NEED_GET_DATA))
>  		goto out;
>  
> -	if (ublk_support_user_copy(ubq) && ub_cmd->addr) {
> +	if (ublk_support_user_copy(ubq) &&
> +	    !(io->flags & UBLK_IO_FLAG_ZONE_APPEND) && ub_cmd->addr) {
>  		ret = -EINVAL;
>  		goto out;
>  	}
> @@ -1534,11 +1560,14 @@ static inline bool ublk_check_ubuf_dir(const struct request *req,
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
> @@ -1867,6 +1896,12 @@ static int ublk_ctrl_start_dev(struct ublk_device *ub, struct io_uring_cmd *cmd)
>  	ub->dev_info.ublksrv_pid = ublksrv_pid;
>  	ub->ub_disk = disk;
>  
> +	ub->dev_info.state = UBLK_S_DEV_LIVE;
> +	if (IS_ENABLED(CONFIG_BLK_DEV_ZONED) &&
> +	    ub->dev_info.flags & UBLK_F_ZONED) {
> +		disk_set_zoned(disk, BLK_ZONED_HM);
> +	}
> +
>  	ret = ublk_apply_params(ub);
>  	if (ret)
>  		goto out_put_disk;
> @@ -1877,7 +1912,6 @@ static int ublk_ctrl_start_dev(struct ublk_device *ub, struct io_uring_cmd *cmd)
>  
>  	if (IS_ENABLED(CONFIG_BLK_DEV_ZONED) &&
>  	    ub->dev_info.flags & UBLK_F_ZONED) {
> -		disk_set_zoned(disk, BLK_ZONED_HM);
>  		blk_queue_required_elevator_features(disk->queue, ELEVATOR_F_ZBD_SEQ_WRITE);
>  		ret = ublk_revalidate_disk_zones(disk);
>  		if (ret)
> @@ -1885,7 +1919,6 @@ static int ublk_ctrl_start_dev(struct ublk_device *ub, struct io_uring_cmd *cmd)
>  	}
>  
>  	get_device(&ub->cdev_dev);
> -	ub->dev_info.state = UBLK_S_DEV_LIVE;
>  	ret = add_disk(disk);
>  	if (ret) {
>  		/*
> diff --git a/drivers/block/ublk_drv.h b/drivers/block/ublk_drv.h
> index 7242430fd6b9..f55e1c25531d 100644
> --- a/drivers/block/ublk_drv.h
> +++ b/drivers/block/ublk_drv.h
> @@ -56,6 +56,7 @@ struct ublk_rq_data {
>  };
>  
>  void ublk_set_nr_zones(struct ublk_device *ub);
> +int ublk_dev_param_zoned_validate(const struct ublk_device *ub);
>  void ublk_dev_param_zoned_apply(struct ublk_device *ub);
>  int ublk_revalidate_disk_zones(struct gendisk *disk);
>  
> diff --git a/include/uapi/linux/ublk_cmd.h b/include/uapi/linux/ublk_cmd.h
> index 436525afffe8..4b6ad0b28598 100644
> --- a/include/uapi/linux/ublk_cmd.h
> +++ b/include/uapi/linux/ublk_cmd.h
> @@ -351,7 +351,8 @@ struct ublk_param_devt {
>  struct ublk_param_zoned {
>  	__u32	max_open_zones;
>  	__u32	max_active_zones;
> -	__u8	reserved[24];
> +	__u32   max_zone_append_sectors;
> +	__u8	reserved[20];
>  };
>  
>  struct ublk_params {

-- 
Damien Le Moal
Western Digital Research

