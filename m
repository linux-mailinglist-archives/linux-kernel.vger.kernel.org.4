Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B9655FD33F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 04:29:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbiJMC3Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 22:29:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbiJMC3X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 22:29:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B589811C6CE
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 19:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665628160;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iDiMIcuyeX7LC8mKPvxUszNsXHrwyk0NdQeY660GwNM=;
        b=JlUjJHB1z/cQ6HDp7M/0xSlh5ycJ5tuVvl48jzIgKwjExEJHKF6EMDerah1o7DQl/neSDp
        2Sf1gyYKDIjdPoZnpd1h0Lyij2Kg9Tl7adW1ZQL2/6Ts02ZhFxixlIYr2R/hiJpX6MHodQ
        qeijG+/A8RHBZ32UHMMhetGl6wYlRck=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-321-J01K6zSzP1-jWv-B_zXABg-1; Wed, 12 Oct 2022 22:29:19 -0400
X-MC-Unique: J01K6zSzP1-jWv-B_zXABg-1
Received: by mail-oo1-f72.google.com with SMTP id o2-20020a4a3842000000b004808060499dso335687oof.5
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 19:29:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iDiMIcuyeX7LC8mKPvxUszNsXHrwyk0NdQeY660GwNM=;
        b=i+l5fcYI4GZPY+dOa6Rbmr64R+eFuPC5wI/mAjKnhtb1o1qSWeqn/0NaRf4FUZLZEx
         36lMWLDM0yOt/FH4ml06Vdiz7AmqUjhA6QBaNOkeuuUBgQiEBkEG41lNi/24mPFDxQWj
         yeY/sCRVK0fv54SmZ8S6KTN+ogyHaPHWiLXipFzDySV7+STS9R0dcodWQ07sOS4fmMOu
         F5qfbaZK/+QYajXOuO3y797/lLMnSg2hTOLw0I6FUUwduEXAhUPJDRIHDGi4L4LFv2TL
         dRLUvXK8ejen1iaLIl6IPdX+iN5zbH2jFaV3PkKLtU7FB8ksWtgN3ajFojBMcAwyWZyH
         GDeg==
X-Gm-Message-State: ACrzQf2kHkGgg2tT7nUAzZs5zO5meK+PbMVlMtXdJ5SDwKgL4d4+4KzE
        9+NHrQTSzY5nQNqR+LP43OHGL1z2TILBvDWqxdrBbnuhQhMA3lW9WDgDSxPNz7G3vdsuOIrAEiJ
        ARg69iXXGGZswzpXTMBnB+1neYU2CwiEdG4p5nZ/F
X-Received: by 2002:a05:6870:eca8:b0:132:df46:5c66 with SMTP id eo40-20020a056870eca800b00132df465c66mr3922637oab.280.1665628158849;
        Wed, 12 Oct 2022 19:29:18 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6V1/do6f40qJ94o460ugmsH/1enc58fr6Vdw55XrpsZhcRMldKBcRC1wnZgdZg9G9QO27GAwwNEnFzHJw4FWk=
X-Received: by 2002:a05:6870:eca8:b0:132:df46:5c66 with SMTP id
 eo40-20020a056870eca800b00132df465c66mr3922631oab.280.1665628158639; Wed, 12
 Oct 2022 19:29:18 -0700 (PDT)
MIME-Version: 1.0
References: <20221012220312.308522-1-mst@redhat.com>
In-Reply-To: <20221012220312.308522-1-mst@redhat.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Thu, 13 Oct 2022 10:29:07 +0800
Message-ID: <CACGkMEuYUwvYVQ71WwEAt+nA7WWcfYWYBwoiZYF4kir7_dKuqg@mail.gmail.com>
Subject: Re: [PATCH] virtio_pci: use irq to detect interrupt support
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Angus Chen <angus.chen@jaguarmicro.com>,
        virtualization@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 13, 2022 at 6:04 AM Michael S. Tsirkin <mst@redhat.com> wrote:
>
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
>         The correct way to check for "no irq" doesn't use NO_IRQ at all, it just does
>                 if (dev->irq) ...
> so let's just check irq and be done with it.
>
> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> Reported-by: Michael Ellerman <mpe@ellerman.id.au>
> Fixes: 71491c54eafa ("virtio_pci: don't try to use intxif pin is zero")
> Cc: "Angus Chen" <angus.chen@jaguarmicro.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Acked-by: Jason Wang <jasowang@redhat.com>

> ---
>
> Build tested only - very late here. Angus any chance you could
> help test this? Thanks!
>
>  drivers/virtio/virtio_pci_common.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
> index 4df77eeb4d16..a6c86f916dbd 100644
> --- a/drivers/virtio/virtio_pci_common.c
> +++ b/drivers/virtio/virtio_pci_common.c
> @@ -409,8 +409,8 @@ int vp_find_vqs(struct virtio_device *vdev, unsigned int nvqs,
>         err = vp_find_vqs_msix(vdev, nvqs, vqs, callbacks, names, false, ctx, desc);
>         if (!err)
>                 return 0;
> -       /* Is there an interrupt pin? If not give up. */
> -       if (!(to_vp_device(vdev)->pci_dev->pin))
> +       /* Is there an interrupt? If not give up. */
> +       if (!(to_vp_device(vdev)->pci_dev->irq))
>                 return err;
>         /* Finally fall back to regular interrupts. */
>         return vp_find_vqs_intx(vdev, nvqs, vqs, callbacks, names, ctx);
> --
> MST
>

