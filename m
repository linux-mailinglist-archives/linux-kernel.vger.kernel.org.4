Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C8626BD9D0
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 21:06:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230129AbjCPUGQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 16:06:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbjCPUGK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 16:06:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DA722ED79
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 13:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678997083;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=c1YkkUw1xzN0H+t6nmIolgNOdss2FtKa4Y35b1ItNLc=;
        b=TDnwVldpXtkbPq+E0UuSFSIvtVfQkSqBvFS68qy0aKkW9PALxdDkuIQHy9u4mvTc656zug
        ZcQxCLHguSv4Tl/wz0X+wTzxKMi4BD5aAgL5qUCoEltVrvQqMtWcB2XzBAq7a+KeyTOk0e
        LgiUUbsXTURfK7Q8/53AKP8Ea11u6FA=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-587-Wzs1_gFFOVOYhT8vbBUNwA-1; Thu, 16 Mar 2023 16:04:42 -0400
X-MC-Unique: Wzs1_gFFOVOYhT8vbBUNwA-1
Received: by mail-lj1-f198.google.com with SMTP id i16-20020a2e9410000000b00298a5717749so752689ljh.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 13:04:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678997081;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c1YkkUw1xzN0H+t6nmIolgNOdss2FtKa4Y35b1ItNLc=;
        b=Ul5QIydeRTLdGPfUAkyBbvY+VwvfPcKbblN0Z92iXOIj+G8AZUVqUEwcAfeEupnO3f
         z7Vfilwoa3iqibNqXjWW96RaG7BJpiSqc8WWY3ym8+/nz73DtiDBzD68AQR5P/5s+P1h
         nbrAEdqWmCH25/DRYD4T09GxdzyKo/rZ9mZe9d4SDcolzl51R3Yg0eBPKdPIBPgBp8ur
         X6Bjniu8/YeRj+oNaDRfy6CzuIz9/9Ki/Y5T1RaYvmSQTmJrwWHmUhuuVzuVnijIckvr
         LPu4ffK4HSgz4nP9TzKTGcAUxZnw/2ErdzCOAPCJBHnA3KYHNt4O61FKX5/mrxztAYco
         IR9g==
X-Gm-Message-State: AO0yUKVs+dmt2jij34eUoObDb18kIIGzBN0MtYwP4b8ui4FnNhiYAd5D
        SeTKByfBN7U1sHKEIpe2GTC64jP1IHnMepNVt5G0kwYXQkdyq9Ic8f/yf/aweKyG2m0sj1mHo4H
        cgZxVZkHYh9yuIMMKV5On/OVtfjUIM3SQurx1Ctwp
X-Received: by 2002:ac2:5119:0:b0:4e8:48a4:371a with SMTP id q25-20020ac25119000000b004e848a4371amr204717lfb.4.1678997080746;
        Thu, 16 Mar 2023 13:04:40 -0700 (PDT)
X-Google-Smtp-Source: AK7set/ESVGatyLU1t8OLqy9yNGj+IlxtLWd6JqntB21b/PRHmA660AZF2JZUMxcn0NnbCSm0lqZ/1lTRpwWO6P5k80=
X-Received: by 2002:ac2:5119:0:b0:4e8:48a4:371a with SMTP id
 q25-20020ac25119000000b004e848a4371amr204710lfb.4.1678997080433; Thu, 16 Mar
 2023 13:04:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230316143122.2377354-1-kherbst@redhat.com> <20230316195037.GA1849341@bhelgaas>
In-Reply-To: <20230316195037.GA1849341@bhelgaas>
From:   Karol Herbst <kherbst@redhat.com>
Date:   Thu, 16 Mar 2023 21:04:28 +0100
Message-ID: <CACO55ttHaRCe7zZM1YWm_0EKRmy5YSDyP=Edy=VRbeU-gf-iMg@mail.gmail.com>
Subject: Re: [PATCH] PCI: stop spamming info in quirk_nvidia_hda
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Lukas Wunner <lukas@wunner.de>, linux-pci@vger.kernel.org,
        nouveau@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 16, 2023 at 8:57=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.org> =
wrote:
>
> On Thu, Mar 16, 2023 at 03:31:22PM +0100, Karol Herbst wrote:
> > Users kept complaining about those messages and it's a little spammy on
> > prime systems so turn it into a debug print.
>
> What is a "prime system"?
>

Laptops with a iGPU + Nvidia Setup. That tech is usually marketed as
"Nvidia Optimus" and people in the open source world made "prime" out
of that, mostly in the context of "prime offloading".

> I'm a little surprised that users would really care about the message.
> But I do see comments like these:
> https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1836308/comments/15
> https://bugs.launchpad.net/ubuntu/+source/linux/+bug/2002206
> that suggest the message happens frequently, maybe if we're resuming
> the controller after runtime suspend?
>

Yes, that happens every time the discrete Nvidia GPU gets runtime resumed.

> Maybe this should be a pci_info_once() sort of thing?  I think there's
> some value in knowing that we're changing the BIOS configuration
> outside the purview of a driver, since I assume BIOS had some reason
> for hiding the HDA controller.
>

fair point. Most of the bugs happen on the first runtime resume
already, so if that one is good, it's unlikely the system will hit a
bug later on.

> > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > Cc: Lukas Wunner <lukas@wunner.de>
> > Cc: linux-pci@vger.kernel.org
> > Cc: nouveau@lists.freedesktop.org
> > Fixes: b516ea586d71 ("PCI: Enable NVIDIA HDA controllers")
> > Signed-off-by: Karol Herbst <kherbst@redhat.com>
> > ---
> >  drivers/pci/quirks.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> > index 44cab813bf951..b10c77bbe4716 100644
> > --- a/drivers/pci/quirks.c
> > +++ b/drivers/pci/quirks.c
> > @@ -5549,7 +5549,7 @@ static void quirk_nvidia_hda(struct pci_dev *gpu)
> >       if (val & BIT(25))
> >               return;
> >
> > -     pci_info(gpu, "Enabling HDA controller\n");
> > +     pci_dbg(gpu, "Enabling HDA controller\n");
> >       pci_write_config_dword(gpu, 0x488, val | BIT(25));
> >
> >       /* The GPU becomes a multi-function device when the HDA is enable=
d */
> > --
> > 2.39.2
> >
>

