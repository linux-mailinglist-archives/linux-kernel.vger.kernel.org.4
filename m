Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 539D860BB52
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 22:55:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232111AbiJXUzo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 16:55:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233306AbiJXUzX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 16:55:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51B95254353
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 12:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666638039;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Co+mZwrA6BtWICFuluqHpcYHUEFY3CVy1+yDBlYoNG0=;
        b=Q479hDStkpcI9RDfyNllK/cMRaOjc3NUIFuDF+FAc0TSFCnxT0SwsaaTNKg2B5/V7/QtJo
        8PD35LxGPLkbqE3xUsuRWwVE4SBcSpVbmmzSmRi4mYyu49DX8AP1C8OBMSLds3/LQvInE4
        OiL0d6a3L518ERDTeZRjn3vWboedjCE=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-148-RTQ_oMKVP72m1fEpNNDXFA-1; Mon, 24 Oct 2022 09:33:53 -0400
X-MC-Unique: RTQ_oMKVP72m1fEpNNDXFA-1
Received: by mail-qv1-f70.google.com with SMTP id q17-20020a056214019100b004b1d3c9f3acso5241157qvr.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 06:33:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Co+mZwrA6BtWICFuluqHpcYHUEFY3CVy1+yDBlYoNG0=;
        b=mY8D+SO3+MUniwpVPNNkfv3RYhWZxLk6VGee1Uh4fm+LfgB7cUqQvFMhf9j/G1TBpx
         1O/Xrv4oxJWKpX1SZC2azToPVMNyhLQYko8LSGmmiSb597bObs72WXClrfouS9Ahvhfk
         zjf8kKT5d4qmqHtdbbFHIEFP8kJXwzDO7BJZ8USi/vJXcUwJeufv4LRL9Sg7lGWf9oOK
         g2q73/N66VvlEr9XsmfArNu6OUwqsYQBN7aM8FtgdORTIk1+oVqtZCtKZxBwWhUExaSb
         RXzk3eBs1TJgftJP8LXLYPaWJdm+d3JOkGafMeKBJxU1oxSBRbmh/+FcUVi6ZXzvL+Cw
         WCfA==
X-Gm-Message-State: ACrzQf2faRdaLyV6bkZopy7gzM92aoUymQzUkmx54TZpIxDTG0TNI9Vz
        KzNriWI8UKHLahH5AFG9LebGALJAPYnazIdPPLmkwqNOcESb0GflpKq7wxSbdMXf1ru8lUSk2SA
        dO3rbcfV+h6Kfj5CnQzA+X6pJ
X-Received: by 2002:a05:620a:2991:b0:6ee:92ee:5165 with SMTP id r17-20020a05620a299100b006ee92ee5165mr23277314qkp.177.1666618432976;
        Mon, 24 Oct 2022 06:33:52 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6Yg9OJr5t+PzjIlFe7DyeWZYWlKJigBrJ2zA777WAfcBRrHdX5Mzg+wwVEGTHNrqihr8BU8g==
X-Received: by 2002:a05:620a:2991:b0:6ee:92ee:5165 with SMTP id r17-20020a05620a299100b006ee92ee5165mr23277283qkp.177.1666618432728;
        Mon, 24 Oct 2022 06:33:52 -0700 (PDT)
Received: from sgarzare-redhat (host-87-11-6-34.retail.telecomitalia.it. [87.11.6.34])
        by smtp.gmail.com with ESMTPSA id ay11-20020a05620a178b00b006ee96d82188sm13005230qkb.1.2022.10.24.06.33.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 06:33:52 -0700 (PDT)
Date:   Mon, 24 Oct 2022 15:33:46 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Rafael Mendonca <rafaelmendsr@gmail.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Jens Axboe <axboe@kernel.dk>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Suwan Kim <suwan.kim027@gmail.com>,
        virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] virtio_blk: Fix signedness bug in virtblk_prep_rq()
Message-ID: <20221024133346.whuejusy333o3vqd@sgarzare-redhat>
References: <20221021204126.927603-1-rafaelmendsr@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20221021204126.927603-1-rafaelmendsr@gmail.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 21, 2022 at 05:41:26PM -0300, Rafael Mendonca wrote:
>The virtblk_map_data() function returns negative error codes, however, the
>'nents' field of vbr->sg_table is an unsigned int, which causes the error
>handling not to work correctly.
>
>Fixes: 0e9911fa768f ("virtio-blk: support mq_ops->queue_rqs()")
>Signed-off-by: Rafael Mendonca <rafaelmendsr@gmail.com>
>---
> drivers/block/virtio_blk.c | 6 ++++--
> 1 file changed, 4 insertions(+), 2 deletions(-)

Good catch!

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
>index 19da5defd734..291f705e61a8 100644
>--- a/drivers/block/virtio_blk.c
>+++ b/drivers/block/virtio_blk.c
>@@ -321,16 +321,18 @@ static blk_status_t virtblk_prep_rq(struct blk_mq_hw_ctx *hctx,
> 					struct virtblk_req *vbr)
> {
> 	blk_status_t status;
>+	int num;
>
> 	status = virtblk_setup_cmd(vblk->vdev, req, vbr);
> 	if (unlikely(status))
> 		return status;
>
>-	vbr->sg_table.nents = virtblk_map_data(hctx, req, vbr);
>-	if (unlikely(vbr->sg_table.nents < 0)) {
>+	num = virtblk_map_data(hctx, req, vbr);
>+	if (unlikely(num < 0)) {
> 		virtblk_cleanup_cmd(req);
> 		return BLK_STS_RESOURCE;
> 	}
>+	vbr->sg_table.nents = num;
>
> 	blk_mq_start_request(req);
>
>-- 
>2.34.1
>

