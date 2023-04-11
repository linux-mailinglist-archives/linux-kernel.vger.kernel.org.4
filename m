Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28AF86DCFCA
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 04:42:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbjDKCmL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 22:42:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbjDKCmJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 22:42:09 -0400
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A338226AE
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 19:42:07 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R911e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0Vfq6ma2_1681180924;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0Vfq6ma2_1681180924)
          by smtp.aliyun-inc.com;
          Tue, 11 Apr 2023 10:42:05 +0800
Message-ID: <1681180912.9817035-2-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH] virtio_pci: Wait for legacy device to be reset
Date:   Tue, 11 Apr 2023 10:41:52 +0800
From:   Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To:     Angus Chen <angus.chen@jaguarmicro.com>
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org,
        Angus Chen <angus.chen@jaguarmicro.com>, mst@redhat.com,
        jasowang@redhat.com
References: <20230411013833.1305-1-angus.chen@jaguarmicro.com>
In-Reply-To: <20230411013833.1305-1-angus.chen@jaguarmicro.com>
X-Spam-Status: No, score=-8.0 required=5.0 tests=ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Apr 2023 09:38:32 +0800, Angus Chen <angus.chen@jaguarmicro.com> wrote:
> We read the status of device after reset,
> It is not guaranteed that the device be reseted successfully.
> We can use a while loop to make sure that,like the modern device did.
> The spec is not request it ,but it work.
>
> Signed-off-by: Angus Chen <angus.chen@jaguarmicro.com>

LGTM

Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>


> ---
>  drivers/virtio/virtio_pci_legacy.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/virtio/virtio_pci_legacy.c b/drivers/virtio/virtio_pci_legacy.c
> index 2257f1b3d8ae..f2d241563e4f 100644
> --- a/drivers/virtio/virtio_pci_legacy.c
> +++ b/drivers/virtio/virtio_pci_legacy.c
> @@ -14,6 +14,7 @@
>   *  Michael S. Tsirkin <mst@redhat.com>
>   */
>
> +#include <linux/delay.h>
>  #include "linux/virtio_pci_legacy.h"
>  #include "virtio_pci_common.h"
>
> @@ -97,7 +98,8 @@ static void vp_reset(struct virtio_device *vdev)
>  	vp_legacy_set_status(&vp_dev->ldev, 0);
>  	/* Flush out the status write, and flush in device writes,
>  	 * including MSi-X interrupts, if any. */
> -	vp_legacy_get_status(&vp_dev->ldev);
> +	while (vp_legacy_get_status(&vp_dev->ldev))
> +		msleep(1);
>  	/* Flush pending VQ/configuration callbacks. */
>  	vp_synchronize_vectors(vdev);
>  }
> --
> 2.25.1
>
