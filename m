Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BC9D69F50A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 14:01:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231931AbjBVNBE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 08:01:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231511AbjBVNBB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 08:01:01 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 533E63B22E
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 05:01:00 -0800 (PST)
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id B1E7F3F176
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 13:00:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1677070857;
        bh=C4QlkJoMBe7Zb07BzaU2hfX0+/7r6YQ7RN1cp6tdTkI=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=kMMsKQnQoQ2yi9tzYr9mIRXnH+oyTJBJ7vtk1L8TfGmMKqU8qFE1CciHGbjDUcI51
         f3xMfSDQg8lVb8Rha02QEr0UcOfC4cN71q4LzxSA4QHIbSaP0LriYjbDjsg0eyiCWD
         ON9z6tCGODDosTd8tn020h/VYXgduXJjE755lz1qTEsxCDwWCtRYxhxsiullU9KqAb
         xBVOWaBLeGlMipyxj6wUHEPLxhCllOsCOsHh5Zm8nlbTAC26A51hxic9ORu2mQGLKD
         JSaN7IHarwCgYNZQSR0We0MSvvc7widcRJGcOlmi9d8P4OSgq8FI5mnKnK3jtmCDZ1
         9pZdKspz5lb0Q==
Received: by mail-pf1-f199.google.com with SMTP id h1-20020a62de01000000b005d943b97706so131275pfg.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 05:00:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C4QlkJoMBe7Zb07BzaU2hfX0+/7r6YQ7RN1cp6tdTkI=;
        b=7G4BaG3mL7oEaf+at6dz8rUegIyQss9Mo3I26dlk6ZHDjMlddgj0g/8LjzCN6TFdg8
         eOEEHPFiko4vUAMRYd0GCqQYSAcZlKQC0beza4AUEHOCOOzvRJs5eRRj4f7UajUcbocb
         n9YTtaTzchh9/b/Lj154wrwXDocjg3iwAdjOormesv8hi7dfJ5mOdtEXMhwGRVpkoNjc
         kK02u+WhcC061gC90ycQv2GkUyRyv/5e4alrMU6rjTwgJRBONzOizykNeVPYeootBC0O
         VlWLIngkTlkjX89ifYY8+RmK+Ak4G1nzDXbv1v4KBzWgddEWg4NBNJsM+kZoCI3JnVIw
         Ei8w==
X-Gm-Message-State: AO0yUKXTDzBlCctPejO7QDfWQcqodUNvNFeHDrhFZYoaYVRJzGzjvrw/
        1psL/N7AflGDJCZOs3w64fgOr5+wBt/j10FOf+CsEwmWz1OSChUaFn8H2wf34hqeYziow7xuQ92
        TVFkMJ62HL/6oi3nKgS5EMBLUwW14VVJxHoInPljmZfXAdasKhxTuKuJPFw==
X-Received: by 2002:a17:90b:1f87:b0:237:1892:2548 with SMTP id so7-20020a17090b1f8700b0023718922548mr1309660pjb.44.1677070852631;
        Wed, 22 Feb 2023 05:00:52 -0800 (PST)
X-Google-Smtp-Source: AK7set+Hcu3PpBDVIEJrAMyn16xRp5IGRD9MfaoCbBE14JFRfyGRE20r++e6YnhsvorwYnP3mjsyR4szgSwPyCZs8Pg=
X-Received: by 2002:a17:90b:1f87:b0:237:1892:2548 with SMTP id
 so7-20020a17090b1f8700b0023718922548mr1309649pjb.44.1677070852230; Wed, 22
 Feb 2023 05:00:52 -0800 (PST)
MIME-Version: 1.0
References: <20230221023849.1906728-1-kai.heng.feng@canonical.com>
 <20230221023849.1906728-2-kai.heng.feng@canonical.com> <86136114-a451-c485-ade2-cfa79d5124e1@gmail.com>
In-Reply-To: <86136114-a451-c485-ade2-cfa79d5124e1@gmail.com>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Wed, 22 Feb 2023 21:00:41 +0800
Message-ID: <CAAd53p4L3eUWH183RJAfcQ1vDrwuMJ4pL--w9OgAJzg0ghnpwA@mail.gmail.com>
Subject: Re: [PATCH v8 RESEND 1/6] r8169: Disable ASPM L1.1 on 8168h
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     nic_swsd@realtek.com, bhelgaas@google.com, koba.ko@canonical.com,
        acelan.kao@canonical.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com,
        sathyanarayanan.kuppuswamy@linux.intel.com, vidyas@nvidia.com,
        rafael.j.wysocki@intel.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 21, 2023 at 7:09 PM Heiner Kallweit <hkallweit1@gmail.com> wrote:
>
> On 21.02.2023 03:38, Kai-Heng Feng wrote:
> > ASPM L1/L1.1 gets enabled based on [0], but ASPM L1.1 was actually
> > disabled too [1].
> >
> > So also disable L1.1 for better compatibility.
> >
> > [0] https://bugs.launchpad.net/bugs/1942830
> > [1] https://git.launchpad.net/~canonical-kernel/ubuntu/+source/linux-oem/+git/focal/commit/?id=c9b3736de48fd419d6699045d59a0dd1041da014
> >
> These references are about problems with L1.2 (which is disabled
> per default in mainline). They don't allow any statement about whether
> L1.1 is problematic too (and under which circumstances).
> At least on my system with RTL8168h there's no problem with L1.1
> when running iperf.

There are some systems have performance issue with L1.1 too.
But since the series will disable chip-side ASPM during NAPI poll,
maybe we can keep both L1.1 and L1.2 enabled?

Kai-Heng

>
> > Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> > ---
> > v8:
> >  - New patch.
> >
> >  drivers/net/ethernet/realtek/r8169_main.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> >
> > diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
> > index 45147a1016bec..1c949822661ae 100644
> > --- a/drivers/net/ethernet/realtek/r8169_main.c
> > +++ b/drivers/net/ethernet/realtek/r8169_main.c
> > @@ -5224,13 +5224,13 @@ static int rtl_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
> >
> >       /* Disable ASPM L1 as that cause random device stop working
> >        * problems as well as full system hangs for some PCIe devices users.
> > -      * Chips from RTL8168h partially have issues with L1.2, but seem
> > -      * to work fine with L1 and L1.1.
> > +      * Chips from RTL8168h partially have issues with L1.1 and L1.2, but
> > +      * seem to work fine with L1.
> >        */
> >       if (rtl_aspm_is_safe(tp))
> >               rc = 0;
> >       else if (tp->mac_version >= RTL_GIGA_MAC_VER_46)
> > -             rc = pci_disable_link_state(pdev, PCIE_LINK_STATE_L1_2);
> > +             rc = pci_disable_link_state(pdev, PCIE_LINK_STATE_L1_1 | PCIE_LINK_STATE_L1_2);
> >       else
> >               rc = pci_disable_link_state(pdev, PCIE_LINK_STATE_L1);
> >       tp->aspm_manageable = !rc;
>
