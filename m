Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3439E741E7A
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 04:47:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230082AbjF2CrQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 22:47:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjF2CrN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 22:47:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 323AF194
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 19:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688006784;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rVLdsWOmQBxqARi/qW7wtOC+NsUkxgphMkG6gapsdHg=;
        b=K6xBq7KL4V2zLT/9O7j5V/d0LGgVXt5W0B3Cvvb0mvx8Rcuera7QZWBpiV0iif1knglGxH
        G1pwmWIuUCwjdotdo0TSZfYMcbNIfniit0FzFG7Zvlg6RkQAzuM1sThm2TGVl2g8GVQqK4
        rz4YgsD6Q7en14HuYKI+8v9E6f4fhr8=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-408-o-CNUUy4M7S-6Ra2N-pdhw-1; Wed, 28 Jun 2023 22:46:21 -0400
X-MC-Unique: o-CNUUy4M7S-6Ra2N-pdhw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 459DE3810D3B;
        Thu, 29 Jun 2023 02:46:20 +0000 (UTC)
Received: from ovpn-8-18.pek2.redhat.com (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8B7D140BB4D;
        Thu, 29 Jun 2023 02:46:13 +0000 (UTC)
Date:   Thu, 29 Jun 2023 10:46:08 +0800
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
Subject: Re: [PATCH v4 4/4] ublk: add zone append
Message-ID: <ZJzwcG2gIxXh8HbE@ovpn-8-18.pek2.redhat.com>
References: <20230628190649.11233-1-nmi@metaspace.dk>
 <20230628190649.11233-5-nmi@metaspace.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230628190649.11233-5-nmi@metaspace.dk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 28, 2023 at 09:06:49PM +0200, Andreas Hindborg wrote:
> From: Andreas Hindborg <a.hindborg@samsung.com>
> 
> Add zone append feature to ublk. This feature uses the `addr` field of `struct
> ublksrv_io_cmd`. Therefore ublk must be used with the user copy
> feature (UBLK_F_USER_COPY) for zone append to be available. Without this
> feature, ublk will fail zone append requests.

Given zone append is a must, please fail to add device in case of zoned
and !user_copy, then we can make fast IO code path clean.

> 
> Suggested-by: Ming Lei <ming.lei@redhat.com>
> Signed-off-by: Andreas Hindborg <a.hindborg@samsung.com>
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

I guess the above line change isn't necessary?


Thanks, 
Ming

