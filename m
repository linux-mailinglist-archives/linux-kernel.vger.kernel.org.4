Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F4245FD2A5
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 03:35:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229748AbiJMBfD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 21:35:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiJMBfA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 21:35:00 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79AD21EEDB
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 18:34:55 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4MnsWs0jPLz4x1G;
        Thu, 13 Oct 2022 12:34:48 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1665624889;
        bh=gPvZV0BQTqsExtsBFxdu6MEGId7gZqkpuYWwZgOnkLI=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=Z/pK7aMbtmhvewWXZLFngbCigBpfnFHxarsryaRvqZrDhRAU6Xsk7ghQAZT04h2TV
         Yen2hAUBHVNi7qQdPcGcEbPl2VQrv5qD14t36IbzM9c2IFUMoOB4tAW/TSm5cJCdrv
         E/sJk8jrbbGQD5HJ+kEHZyaWqzJW4bVF8dRmPy0Wx/ja68JAay8PGpFjoS/KHq9NB7
         AXsZVs7yDXGBTL5+lDZVeExy99WRm1TnN3pNHCRwdEMk+oJ0MGxbLazZpYjZ8fcZPj
         N+yD+YBeVfl9znpUIyLEQiLFCJJr7o1530ch0cw+xGgrGwFfSBPD1JO2RQ/rhKk9ku
         gzB+qM7iXgdow==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Angus Chen <angus.chen@jaguarmicro.com>,
        Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH] virtio_pci: use irq to detect interrupt support
In-Reply-To: <20221012220312.308522-1-mst@redhat.com>
References: <20221012220312.308522-1-mst@redhat.com>
Date:   Thu, 13 Oct 2022 12:34:45 +1100
Message-ID: <877d14mrpm.fsf@mpe.ellerman.id.au>
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
> However Linus said:
> 	The correct way to check for "no irq" doesn't use NO_IRQ at all, it just does
> 		if (dev->irq) ...
> so let's just check irq and be done with it.
>
> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> Reported-by: Michael Ellerman <mpe@ellerman.id.au>
> Fixes: 71491c54eafa ("virtio_pci: don't try to use intxif pin is zero")
> Cc: "Angus Chen" <angus.chen@jaguarmicro.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>
> Build tested only - very late here. Angus any chance you could
> help test this? Thanks!

This works for me on powerpc.

Tested-by: Michael Ellerman <mpe@ellerman.id.au>

cheers

> diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
> index 4df77eeb4d16..a6c86f916dbd 100644
> --- a/drivers/virtio/virtio_pci_common.c
> +++ b/drivers/virtio/virtio_pci_common.c
> @@ -409,8 +409,8 @@ int vp_find_vqs(struct virtio_device *vdev, unsigned int nvqs,
>  	err = vp_find_vqs_msix(vdev, nvqs, vqs, callbacks, names, false, ctx, desc);
>  	if (!err)
>  		return 0;
> -	/* Is there an interrupt pin? If not give up. */
> -	if (!(to_vp_device(vdev)->pci_dev->pin))
> +	/* Is there an interrupt? If not give up. */
> +	if (!(to_vp_device(vdev)->pci_dev->irq))
>  		return err;
>  	/* Finally fall back to regular interrupts. */
>  	return vp_find_vqs_intx(vdev, nvqs, vqs, callbacks, names, ctx);
> -- 
> MST
