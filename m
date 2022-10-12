Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5196A5FC66E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 15:29:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230016AbiJLN3U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 09:29:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230017AbiJLN3J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 09:29:09 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63B3ACE9B1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 06:29:06 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4MnYQS4HWKz4xGt;
        Thu, 13 Oct 2022 00:29:04 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1665581344;
        bh=PWX6k4sapyUbB0Ldwc1YFfAGSS69spKkUKEhbPr0Uu4=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=px5TNFZIthNvIxpiD5l6mE50E38LOu+L6ZD8Tu18htqxz4dPD1Pneda7aNIkUutXM
         6y2P0GtECJpuv+4mHpxkR4pZNaVi723kzwe0wqDVeAwEg/lZL1uc5O7LJ6U6aahdn7
         ziEwEnhxkqyHWuBttGWL47E5RtpU3v64rK3IQUqBRiKHKA3WxsvKs0NBwFB/DRo2nP
         XHkyQy9fiEQ+9rTDfvVw1ybqrTcubR+mU8G3KNHrXWakSgvGzrlIwLamL+nU9dDfap
         90h7DDOaThuio8+oSWexlqJ5LTLZnL9bZF4EV+AKujNH0AGQYBsmXBjYwA9X30KWwN
         pkT2uxxaxsVGA==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org
Cc:     Angus Chen <angus.chen@jaguarmicro.com>,
        Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH] virtio_pci: read interrupt pin directly
In-Reply-To: <20221012110736.285161-1-mst@redhat.com>
References: <20221012110736.285161-1-mst@redhat.com>
Date:   Thu, 13 Oct 2022 00:29:04 +1100
Message-ID: <87leplmaqn.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Michael S. Tsirkin" <mst@redhat.com> writes:
> commit 71491c54eafa ("virtio_pci: don't try to use intxif pin is zero")
> breaks virtio_pci on powerpc, when running as a qemu guest.
>
> vp_find_vqs() bails out because pci_dev->pin == 0.
>
> But pci_dev->irq is populated correctly, so vp_find_vqs_intx() would
> succeed if we called it - which is what the code used to do.
>
> This seems to happen because pci_dev->pin is not populated in
> pci_assign_irq().
>
> Which is absolutely a bug in the relevant PCI code, but it
> may also affect other platforms that use of_irq_parse_and_map_pci().
>
> Work around the issue in virtio for now, and let's try to fix
> all affected pci systems and then we can revert this.
>
> Reported-by: Michael Ellerman <mpe@ellerman.id.au>
> Fixes: 71491c54eafa ("virtio_pci: don't try to use intxif pin is zero")
> Cc: "Angus Chen" <angus.chen@jaguarmicro.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  drivers/virtio/virtio_pci_common.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
> index 4df77eeb4d16..6155ea4e7e4b 100644
> --- a/drivers/virtio/virtio_pci_common.c
> +++ b/drivers/virtio/virtio_pci_common.c
> @@ -400,6 +400,7 @@ int vp_find_vqs(struct virtio_device *vdev, unsigned int nvqs,
>  		struct irq_affinity *desc)
>  {
>  	int err;
> +	u8 pin = 0;
>  
>  	/* Try MSI-X with one vector per queue. */
>  	err = vp_find_vqs_msix(vdev, nvqs, vqs, callbacks, names, true, ctx, desc);
> @@ -409,8 +410,13 @@ int vp_find_vqs(struct virtio_device *vdev, unsigned int nvqs,
>  	err = vp_find_vqs_msix(vdev, nvqs, vqs, callbacks, names, false, ctx, desc);
>  	if (!err)
>  		return 0;
> -	/* Is there an interrupt pin? If not give up. */
> -	if (!(to_vp_device(vdev)->pci_dev->pin))
> +	/*
> +	 * Is there an interrupt pin? If not give up.
> +	 * NB: It would seem to be better to use pci_dev->pin - unfortunately
> +	 * not all platforms populate it.
> +	 */
> +	pci_read_config_byte(dev, PCI_INTERRUPT_PIN, &pin);
> +	if (!pin)
>  		return err;
>  	/* Finally fall back to regular interrupts. */
>  	return vp_find_vqs_intx(vdev, nvqs, vqs, callbacks, names, ctx);

Needs the delta below in order to compile.

But with that it fixes the issue for me.

Tested-by: Michael Ellerman <mpe@ellerman.id.au>

cheers


diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
index 6155ea4e7e4b..cae134e2573f 100644
--- a/drivers/virtio/virtio_pci_common.c
+++ b/drivers/virtio/virtio_pci_common.c
@@ -415,7 +415,7 @@ int vp_find_vqs(struct virtio_device *vdev, unsigned int nvqs,
 	 * NB: It would seem to be better to use pci_dev->pin - unfortunately
 	 * not all platforms populate it.
 	 */
-	pci_read_config_byte(dev, PCI_INTERRUPT_PIN, &pin);
+	pci_read_config_byte(to_vp_device(vdev)->pci_dev, PCI_INTERRUPT_PIN, &pin);
 	if (!pin)
 		return err;
 	/* Finally fall back to regular interrupts. */
