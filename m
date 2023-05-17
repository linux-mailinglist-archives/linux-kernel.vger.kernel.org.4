Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E1D0705C73
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 03:32:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230403AbjEQBcx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 21:32:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjEQBcv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 21:32:51 -0400
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89B0C3A80;
        Tue, 16 May 2023 18:32:50 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0ViqT6U4_1684287167;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0ViqT6U4_1684287167)
          by smtp.aliyun-inc.com;
          Wed, 17 May 2023 09:32:48 +0800
Message-ID: <1684287159.5055063-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH v1] virtio_pci: Optimize virtio_pci_device structure size
Date:   Wed, 17 May 2023 09:32:39 +0800
From:   Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To:     Feng Liu <feliu@nvidia.com>
Cc:     Jason Wang <jasowang@redhat.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Bodong Wang <bodong@nvidia.com>, Feng Liu <feliu@nvidia.com>,
        Jiri Pirko <jiri@nvidia.com>,
        <virtualization@lists.linux-foundation.org>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230516135446.16266-1-feliu@nvidia.com>
In-Reply-To: <20230516135446.16266-1-feliu@nvidia.com>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 May 2023 09:54:46 -0400, Feng Liu <feliu@nvidia.com> wrote:
> Improve the size of the virtio_pci_device structure, which is commonly
> used to represent a virtio PCI device. A given virtio PCI device can
> either of legacy type or modern type, with the
> struct virtio_pci_legacy_device occupying 32 bytes and the
> struct virtio_pci_modern_device occupying 88 bytes. Make them a union,
> thereby save 32 bytes of memory as shown by the pahole tool. This
> improvement is particularly beneficial when dealing with numerous
> devices, as it helps conserve memory resources.
>
> Before the modification, pahole tool reported the following:
> struct virtio_pci_device {
> [...]
>         struct virtio_pci_legacy_device ldev;            /*   824    32 */
>         /* --- cacheline 13 boundary (832 bytes) was 24 bytes ago --- */
>         struct virtio_pci_modern_device mdev;            /*   856    88 */
>
>         /* XXX last struct has 4 bytes of padding */
> [...]
>         /* size: 1056, cachelines: 17, members: 19 */
> [...]
> };
>
> After the modification, pahole tool reported the following:
> struct virtio_pci_device {
> [...]
>         union {
>                 struct virtio_pci_legacy_device ldev;    /*   824    32 */
>                 struct virtio_pci_modern_device mdev;    /*   824    88 */
>         };                                               /*   824    88 */
> [...]
> 	/* size: 1024, cachelines: 16, members: 18 */
> [...]
> };
>
> Signed-off-by: Feng Liu <feliu@nvidia.com>
> Reviewed-by: Jiri Pirko <jiri@nvidia.com>

Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

Thanks.

> ---
>  drivers/virtio/virtio_pci_common.h | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/virtio/virtio_pci_common.h b/drivers/virtio/virtio_pci_common.h
> index 23112d84218f..4b773bd7c58c 100644
> --- a/drivers/virtio/virtio_pci_common.h
> +++ b/drivers/virtio/virtio_pci_common.h
> @@ -45,9 +45,10 @@ struct virtio_pci_vq_info {
>  struct virtio_pci_device {
>  	struct virtio_device vdev;
>  	struct pci_dev *pci_dev;
> -	struct virtio_pci_legacy_device ldev;
> -	struct virtio_pci_modern_device mdev;
> -
> +	union {
> +		struct virtio_pci_legacy_device ldev;
> +		struct virtio_pci_modern_device mdev;
> +	};
>  	bool is_legacy;
>
>  	/* Where to read and clear interrupt */
> --
> 2.37.1 (Apple Git-137.1)
>
