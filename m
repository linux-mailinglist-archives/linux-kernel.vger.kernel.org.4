Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AACAF618621
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 18:26:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231404AbiKCR0M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 13:26:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231587AbiKCR0I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 13:26:08 -0400
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90A0A10B43;
        Thu,  3 Nov 2022 10:26:06 -0700 (PDT)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-13c569e5ff5so2943233fac.6;
        Thu, 03 Nov 2022 10:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=E6Cpl3fvbLkWRzzTEA9QdVS9rP/z6sRfyD7jzgji/A8=;
        b=SQTkKmsqMJ1MNANRwBDOLAcaYQhaZ6VUfYfkJxgk5495ezO3HQjNCmjXPbCNeQKGAO
         dftEvThHVNgbwVNFlZppfHd8VcD5Kzs/bQ4b/V5GAGaruAWSKQBLigRQoit1Ngjt8Z6J
         bC9PysfkTgLrn1sgh3JxZGvK/FSarkUc+MLBVVhTSoSToNpWceumpRnXCMB+2nsrt/zz
         hR5hLU/1fbDOVHaBdSczZd45gMS9pCbryQmECwdLZevyPcLc+9XSyyh51EVW+qA0JWcS
         DV9TkllAiX8CzcTmc5mabp+Z5NOQwrsMLM5R0QllpLb3EdQJGKe2WIebpxgiUiTZlM2g
         a8qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E6Cpl3fvbLkWRzzTEA9QdVS9rP/z6sRfyD7jzgji/A8=;
        b=xn/u0FdrugIxhxJNLBHUjMpfUu9GQrQjmXbta9zT1DJBQ1UFVSauHfHGUDAurRqOW7
         a8NwZ65utbhuvXcr/Ldc8N387/mdGqoRWYJYU9/ZEyMJAPLgPkoNPLwL8AVPzAjuevtH
         sNIgAdbBQ2lCh10rD0/U3VVT6p5w9VEqgQd1rnp4QQoItA1vubOdGh8Im0yAMKbjh5RO
         eorQQMSoUvdlSIZswveQoHmu431CrNL1CedYesEJlGHgsnGTwSxFFm5BrbaMoUlfvU2E
         FQ5+ZcSvpDNdC3eUgN3zE91CzDrP75OERDfPFaDfy/SVrZqHvKOVa70gorcUf3S3oy04
         0sEA==
X-Gm-Message-State: ACrzQf2+pi/tqtgypNZSzOyvTJaUUBB778avxsgMGokO6Hzb/608huOe
        ruA1q/oZ+3zy7Xu9PHdnwXTaQgWC6ARgNBNPFBynKB2z
X-Google-Smtp-Source: AMsMyM6TwzCTphsIjJLVtCSLKffmCM19QG9EYJcjOl5QfIO5O2xMuzycuxRIoN9LZoUtxFMAs7048lwPAhPM5oc0xqY=
X-Received: by 2002:a05:6871:89:b0:131:6362:e26f with SMTP id
 u9-20020a056871008900b001316362e26fmr18844118oaa.144.1667496365810; Thu, 03
 Nov 2022 10:26:05 -0700 (PDT)
MIME-Version: 1.0
References: <20221103050538.1930758-1-git@johnthomson.fastmail.com.au>
 <20221103050538.1930758-4-git@johnthomson.fastmail.com.au> <26ebbed1-0fe9-4af9-8466-65f841d0b382@app.fastmail.com>
In-Reply-To: <26ebbed1-0fe9-4af9-8466-65f841d0b382@app.fastmail.com>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Thu, 3 Nov 2022 18:25:54 +0100
Message-ID: <CAMhs-H9VW=6fPNAjBukmBkFFnLYCekE_QJV_ewE_H1vOGrb+Xw@mail.gmail.com>
Subject: Re: [RFC PATCH 3/3] mips: ralink: mt7621: do not use kzalloc too early
To:     John Thomson <lists@johnthomson.fastmail.com.au>
Cc:     =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
        John Crispin <john@phrozen.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John,

Thanks for the patches!

On Thu, Nov 3, 2022 at 12:15 PM John Thomson
<lists@johnthomson.fastmail.com.au> wrote:
>
> On Thu, 3 Nov 2022, at 05:05, John Thomson wrote:
> > Following commit 6edf2576a6cc ("mm/slub: enable debugging memory wasting
> > of kmalloc") mt7621 failed to boot very early, without showing any
> > console messages.
> > This exposed the pre-existing bug of mt7621.c using kzalloc before normal
> > memory management was available.
> > Prior to this slub change, there existed the unintended protection against
> > "kmem_cache *s" being NULL as slab_pre_alloc_hook() happened to
> > return NULL and bailed out of slab_alloc_node().
> > This allowed mt7621 prom_soc_init to fail in the soc_dev_init kzalloc,
> > but continue booting without this soc device.
> >
> > Console output from a DEBUG_ZBOOT vmlinuz kernel loading,
> > with mm/slub modified to warn on kmem_cache zero or null:
> >
> > zimage at:     80B842A0 810B4BC0
> > Uncompressing Linux at load address 80001000
> > Copy device tree to address  80B80EE0
> > Now, booting the kernel...
> >
> > [    0.000000] Linux version 6.1.0-rc3+ (john@john)
> > (mipsel-buildroot-linux-gnu-gcc.br_real (Buildroot
> > 2021.11-4428-g6b6741b) 12.2.0, GNU ld (GNU Binutils) 2.39) #73 SMP Wed
> >      Nov  2 05:10:01 AEST 2022
> > [    0.000000] ------------[ cut here ]------------
> > [    0.000000] WARNING: CPU: 0 PID: 0 at mm/slub.c:3416
> > kmem_cache_alloc+0x5a4/0x5e8
> > [    0.000000] Modules linked in:
> > [    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted 6.1.0-rc3+ #73
> > [    0.000000] Stack : 810fff78 80084d98 00000000 00000004 00000000
> > 00000000 80889d04 80c90000
> > [    0.000000]         80920000 807bd328 8089d368 80923bd3 00000000
> > 00000001 80889cb0 00000000
> > [    0.000000]         00000000 00000000 807bd328 8084bcb1 00000002
> > 00000002 00000001 6d6f4320
> > [    0.000000]         00000000 80c97d3d 80c97d68 fffffffc 807bd328
> > 00000000 00000000 00000000
> > [    0.000000]         00000000 a0000000 80910000 8110a0b4 00000000
> > 00000020 80010000 80010000
> > [    0.000000]         ...
> > [    0.000000] Call Trace:
> > [    0.000000] [<80008260>] show_stack+0x28/0xf0
> > [    0.000000] [<8070c958>] dump_stack_lvl+0x60/0x80
> > [    0.000000] [<8002e184>] __warn+0xc4/0xf8
> > [    0.000000] [<8002e210>] warn_slowpath_fmt+0x58/0xa4
> > [    0.000000] [<801c0fac>] kmem_cache_alloc+0x5a4/0x5e8
> > [    0.000000] [<8092856c>] prom_soc_init+0x1fc/0x2b4
> > [    0.000000] [<80928060>] prom_init+0x44/0xf0
> > [    0.000000] [<80929214>] setup_arch+0x4c/0x6a8
> > [    0.000000] [<809257e0>] start_kernel+0x88/0x7c0
> > [    0.000000]
> > [    0.000000] ---[ end trace 0000000000000000 ]---
> > [    0.000000] SoC Type: MediaTek MT7621 ver:1 eco:3
> > [    0.000000] printk: bootconsole [early0] enabled

Last version I tested on my gnubee PC1 mt7621 board was v6.0 and all
was booting properly.

> >
> > This early kzalloc was introduced in commit 71b9b5e0130d ("MIPS: ralink:
> > mt7621: introduce 'soc_device' initialization")
> >
> > Link:
> > https://lore.kernel.org/linux-mm/becf2ac3-2a90-4f3a-96d9-a70f67c66e4a@app.fastmail.com/
> > Signed-off-by: John Thomson <git@johnthomson.fastmail.com.au>
> > ---
> >  arch/mips/ralink/mt7621.c | 14 +++++++++-----
> >  1 file changed, 9 insertions(+), 5 deletions(-)
> >
> > diff --git a/arch/mips/ralink/mt7621.c b/arch/mips/ralink/mt7621.c
> > index f2443b833bc3..836965021d5c 100644
> > --- a/arch/mips/ralink/mt7621.c
> > +++ b/arch/mips/ralink/mt7621.c
> > @@ -25,6 +25,7 @@
> >  #define MT7621_MEM_TEST_PATTERN         0xaa5555aa
> >
> >  static u32 detect_magic __initdata;
> > +struct ralink_soc_info *soc_info_ptr;
> >
> >  int pcibios_root_bridge_prepare(struct pci_host_bridge *bridge)
> >  {
> > @@ -147,27 +148,30 @@ static const char __init *mt7621_get_soc_revision(void)
> >               return "E1";
> >  }
> >
> > -static void soc_dev_init(struct ralink_soc_info *soc_info)
> > +static int __init mt7621_soc_dev_init(void)
> >  {
> >       struct soc_device *soc_dev;
> >       struct soc_device_attribute *soc_dev_attr;
> >
> >       soc_dev_attr = kzalloc(sizeof(*soc_dev_attr), GFP_KERNEL);
> >       if (!soc_dev_attr)
> > -             return;
> > +             return -ENOMEM;
> >
> >       soc_dev_attr->soc_id = "mt7621";
> >       soc_dev_attr->family = "Ralink";
> >       soc_dev_attr->revision = mt7621_get_soc_revision();
> >
> > -     soc_dev_attr->data = soc_info;
> > +     soc_dev_attr->data = soc_info_ptr;
> >
> >       soc_dev = soc_device_register(soc_dev_attr);
> >       if (IS_ERR(soc_dev)) {
> >               kfree(soc_dev_attr);
> > -             return;
> > +             return PTR_ERR(soc_dev);
> >       }
> > +
> > +     return 0;
> >  }
> > +device_initcall(mt7621_soc_dev_init);
> >
> >  void __init prom_soc_init(struct ralink_soc_info *soc_info)
> >  {
> > @@ -209,7 +213,7 @@ void __init prom_soc_init(struct ralink_soc_info *soc_info)
> >
> >       soc_info->mem_detect = mt7621_memory_detect;
> >
> > -     soc_dev_init(soc_info);
> > +     soc_info_ptr = soc_info;
> >
> >       if (!register_cps_smp_ops())
> >               return;
> > --
> > 2.37.2

I was trying to quicky add all of them to my trew using b4 with [0]
but I am getting a DNS error with that URL...

So, I am a bit busy this week but hopefully next week I'll try to make
time to test all of your changes. Let me test all your changes and
come back to you again.

[0]: https://lore.kernel.org/lkml/20221103050538.1930758-1-git@johnthomson.fastmail.com.au/T/#m75e858f83a3e2e26ca84295d2d09040e14128e71

>
> I backported this to kernel 5.10 as a test
> without it, there was no /sys/bus/soc
> with it, the drivers/staging/mt7621-pci-phy/pci-mt7621-phy.c driver
> panicked in soc_device_match_attr
> This was fixed with an added sentinel element in the quirk table:
> --- a/drivers/staging/mt7621-pci-phy/pci-mt7621-phy.c
> +++ b/drivers/staging/mt7621-pci-phy/pci-mt7621-phy.c
> @@ -293,7 +293,8 @@ static struct phy *mt7621_pcie_phy_of_xlate(struct device *d
> ev,
>  }
>
>  static const struct soc_device_attribute mt7621_pci_quirks_match[] = {
> -       { .soc_id = "mt7621", .revision = "E2" }
> +       { .soc_id = "mt7621", .revision = "E2" },
> +       { /* sentinel */ }
>  };
>
>  static const struct regmap_config mt7621_pci_phy_regmap_config = {
>
> There is the same quirk table to kernel 5.15 in drivers/staging/mt7621-pci/pci-mt7621.c
> Should I add commits for these for the stable kernels?
>
> In master, these files are now
> drivers/pci/controller/pcie-mt7621.c
> drivers/phy/ralink/phy-mt7621-pci.c
>
> Should I add sentinels to the soc_device_attribute quirk tables in all of these files?

I guess we should add sentinel in all related files. Please CC me with
your series if you send any patch before I come back to you after
testing.

>
> Cheers,
> --
>   John Thomson

Thanks,
    Sergio Paracuellos
