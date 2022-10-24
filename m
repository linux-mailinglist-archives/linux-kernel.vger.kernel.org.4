Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3954260A1E4
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 13:35:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230297AbiJXLfc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 07:35:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230041AbiJXLfC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 07:35:02 -0400
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B23A664F9
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 04:34:19 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VSyOrxW_1666611231;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0VSyOrxW_1666611231)
          by smtp.aliyun-inc.com;
          Mon, 24 Oct 2022 19:33:52 +0800
Message-ID: <1666611221.6163745-2-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH 2/2] virtio_ring: use helper function is_power_of_2()
Date:   Mon, 24 Oct 2022 19:33:41 +0800
From:   Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To:     shaoqin.huang@intel.com
Cc:     linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, mst@redhat.com,
        jasowang@redhat.com
References: <20221021062734.228881-1-shaoqin.huang@intel.com>
 <20221021062734.228881-3-shaoqin.huang@intel.com>
In-Reply-To: <20221021062734.228881-3-shaoqin.huang@intel.com>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Oct 2022 23:27:34 -0700, shaoqin.huang@intel.com wrote:
> From: Shaoqin Huang <shaoqin.huang@intel.com>
>
> Use helper function is_power_of_2() to check if num is power of two.
> Minor readability improvement.
>
> Signed-off-by: Shaoqin Huang <shaoqin.huang@intel.com>
Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>  drivers/virtio/virtio_ring.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 2e7689bb933b..723c4e29e1d3 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -1052,7 +1052,7 @@ static int vring_alloc_queue_split(struct vring_virtqueue_split *vring_split,
>  	dma_addr_t dma_addr;
>
>  	/* We assume num is a power of 2. */
> -	if (num & (num - 1)) {
> +	if (!is_power_of_2(num)) {
>  		dev_warn(&vdev->dev, "Bad virtqueue length %u\n", num);
>  		return -EINVAL;
>  	}
> --
> 2.34.1
>
> _______________________________________________
> Virtualization mailing list
> Virtualization@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/virtualization
