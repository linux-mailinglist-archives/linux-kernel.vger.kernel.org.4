Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DC4174ABA5
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 09:14:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232196AbjGGHOq convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 7 Jul 2023 03:14:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229997AbjGGHOm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 03:14:42 -0400
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0350E1BF4;
        Fri,  7 Jul 2023 00:14:41 -0700 (PDT)
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-c4d1b491095so1671222276.0;
        Fri, 07 Jul 2023 00:14:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688714080; x=1691306080;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=43ZX5Bo4wDFUOW+pJFcaZnNObvBig5TGwYCIJg/W+ew=;
        b=PWDXIz9KdYiLeJbSB4AAL0yJ7CB38LbhAhVPlk8B3Z2hMVPKTU9EiKUm7sLDFeE2hd
         tzx+98+E4DonSc0d1x6kAm9Z8bGd6mRLl03PuYySmONeD7bWfSWJTlMESYp3xcHVAhsp
         7a1KPFvRGIp9IEz5yK7kp7yVMtVSd2T59VlFgzRrLB5UuGX66Ym0lFtNOcCBELdp1VTy
         Z6+IkWEPdXV20je0fH6iZubJ6YsnDdwKZIWjO4MKoQs/STa6zuxuGv4H0izlK9zV3NrU
         QC0df6hbU9W3h8qFyiiQLEkq2BPPqhGdVTleOFFmrwBmMRwrMPIx/ON++6l2WOCMSvkd
         QiQw==
X-Gm-Message-State: ABy/qLZ/sVFn3JDpIw0pyAxcTd5ak/+LHOgYGco0s+P26bFw84OhXlJT
        wNDJVPXf4UNguiXWG95zbsy36aQKWbAiYQ==
X-Google-Smtp-Source: APBJJlEzDPTKaEO2OK3U8eoAMppXNI82TIgkwRauxeOAQVA1/CYMdW/1ZI+T5p5Zk2yFRwerZezf6Q==
X-Received: by 2002:a25:5d09:0:b0:c41:1f50:2cba with SMTP id r9-20020a255d09000000b00c411f502cbamr4010086ybb.43.1688714079959;
        Fri, 07 Jul 2023 00:14:39 -0700 (PDT)
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com. [209.85.128.182])
        by smtp.gmail.com with ESMTPSA id j129-20020a252387000000b00bcf788d09e3sm803610ybj.34.2023.07.07.00.14.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Jul 2023 00:14:39 -0700 (PDT)
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-5701e8f2b79so19604997b3.0;
        Fri, 07 Jul 2023 00:14:39 -0700 (PDT)
X-Received: by 2002:a81:610a:0:b0:561:b85e:8d9e with SMTP id
 v10-20020a81610a000000b00561b85e8d9emr4221470ywb.15.1688714079079; Fri, 07
 Jul 2023 00:14:39 -0700 (PDT)
MIME-Version: 1.0
References: <fbfea3ad-d327-4ad5-ac9c-648c7ca3fe1f@roeck-us.net>
 <CAMuHMdUfXdCf_CQuWXpP72MzKFYvXg3Ud1VN_3Bd0RHxfLhVeQ@mail.gmail.com> <7b2c0d812280afaefee0c70a9aea00a0fcf84e3a.camel@physik.fu-berlin.de>
In-Reply-To: <7b2c0d812280afaefee0c70a9aea00a0fcf84e3a.camel@physik.fu-berlin.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 7 Jul 2023 09:14:26 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWLdJPC6oQ0P4_DVbPXrVjg=PMjTUdX4MD4+tmc3BW9sg@mail.gmail.com>
Message-ID: <CAMuHMdWLdJPC6oQ0P4_DVbPXrVjg=PMjTUdX4MD4+tmc3BW9sg@mail.gmail.com>
Subject: Re: [PATCH] sh: Avoid using IRQ0 on SH3 and SH4
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adrian,

On Thu, Jul 6, 2023 at 6:39 PM John Paul Adrian Glaubitz
<glaubitz@physik.fu-berlin.de> wrote:
> On Thu, 2023-07-06 at 17:39 +0200, Geert Uytterhoeven wrote:
> > Which sh4 platforms in particular?
> >
> > I booted a kernel with this patch on rts7751r2d (QEMU) and landisk
> > (physical) two days ago.
>
> I gave it a try with the command line Guenter suggested and indeed the kernel locks
> up right here with the patch applied and boots fine without it:
>
> Creating 4 MTD partitions on "physmap-flash":
> 0x000000000000-0x000000040000 : "U-Boot"
> 0x000000040000-0x000000080000 : "Environment"
> 0x000000080000-0x000000240000 : "Kernel"
> 0x000000240000-0x000001000000 : "Flash_FS"
> 8139too: 8139too Fast Ethernet driver 0.9.28
> 8139too 0000:00:01.0: This (id 10ec:8139 rev 20) is an enhanced 8139C+ chip, use 8139cp
> sm501-usb sm501-usb: SM501 OHCI
> sm501-usb sm501-usb: new USB bus registered, assigned bus number 1
> sm501-usb sm501-usb: irq 116, io mem 0x13e40000
> usb usb1: New USB device found, idVendor=1d6b, idProduct=0001, bcdDevice= 6.04
> usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> usb usb1: Product: SM501 OHCI
> usb usb1: Manufacturer: Linux 6.4.0-12069-gc17414a273b8 ohci_hcd
> usb usb1: SerialNumber: sm501-usb
> hub 1-0:1.0: USB hub found
> hub 1-0:1.0: 2 ports detected
> usbcore: registered new interface driver usb-storage
> rtc-r9701 spi0.0: cannot read RTC register
> usbcore: registered new interface driver usbhid
> usbhid: USB HID core driver
> NET: Registered PF_PACKET protocol family
> heartbeat: version 0.1.2 loaded
> ata1: found unknown device (class 0)
> (stops here)
>
> Using rts7751r2dplus_defconfig and the following command line:
>
> qemu-system-sh4 -M r2d -kernel vmlinuz-6.5-rc1 -hda debian_sid_sh4_standard.qcow2 -no-reboot -device rtl8139,netdev=net0 -netdev user,id=net0 -append "root=/dev/sda1 console=ttySC1,115200
> earlycon=scif,mmio16,0xffe80000 noiotrap" -serial null -serial stdio -nographic -monitor null
>
> And using this old qcow2 image:
>
> > https://people.debian.org/~aurel32/qemu/sh4/debian_sid_sh4_standard.qcow2
>
> Maybe it's a configuration issue if it works for you?

I am not using rts7751r2dplus_defconfig, but my own[*] config,
which boots fine into initrd userspace.

I can reproduce the issue with rts7751r2dplus_defconfig, but I may
not be able to look into it today...

[*] Actually sh4.miniconf from Rob Landley.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
