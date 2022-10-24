Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B471460A1E1
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 13:35:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230387AbiJXLfM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 07:35:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230365AbiJXLem (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 07:34:42 -0400
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DF076C744
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 04:33:53 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R971e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VSyvVWN_1666611213;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0VSyvVWN_1666611213)
          by smtp.aliyun-inc.com;
          Mon, 24 Oct 2022 19:33:34 +0800
Message-ID: <1666611190.2063382-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH 1/2] virtio_pci: use helper function is_power_of_2()
Date:   Mon, 24 Oct 2022 19:33:10 +0800
From:   Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To:     shaoqin.huang@intel.com
Cc:     linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, mst@redhat.com,
        jasowang@redhat.com
References: <20221021062734.228881-1-shaoqin.huang@intel.com>
 <20221021062734.228881-2-shaoqin.huang@intel.com>
In-Reply-To: <20221021062734.228881-2-shaoqin.huang@intel.com>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Oct 2022 23:27:33 -0700, shaoqin.huang@intel.com wrote:
> From: Shaoqin Huang <shaoqin.huang@intel.com>
>
> Use helper function is_power_of_2() to check if num is power of two.
> Minor readability improvement.
>
> Signed-off-by: Shaoqin Huang <shaoqin.huang@intel.com>

Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

> ---
>  drivers/virtio/virtio_pci_modern.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
> index c3b9f2761849..207294bd7b9d 100644
> --- a/drivers/virtio/virtio_pci_modern.c
> +++ b/drivers/virtio/virtio_pci_modern.c
> @@ -310,7 +310,7 @@ static struct virtqueue *setup_vq(struct virtio_pci_device *vp_dev,
>  	if (!num || vp_modern_get_queue_enable(mdev, index))
>  		return ERR_PTR(-ENOENT);
>
> -	if (num & (num - 1)) {
> +	if (!is_power_of_2(num)) {
>  		dev_warn(&vp_dev->pci_dev->dev, "bad queue size %u", num);
>  		return ERR_PTR(-EINVAL);
>  	}
> --
> 2.34.1
>
> _______________________________________________
> Virtualization mailing list
> Virtualization@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/virtualization
