Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A8BF74AD50
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 10:48:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231959AbjGGIse convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 7 Jul 2023 04:48:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229880AbjGGIsd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 04:48:33 -0400
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 572AA1FCE;
        Fri,  7 Jul 2023 01:48:32 -0700 (PDT)
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-579e212668fso24039457b3.1;
        Fri, 07 Jul 2023 01:48:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688719711; x=1691311711;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UCjUGV07FKqJRJNlA4G4onJMKF03LC7j5lp+ed7DPLQ=;
        b=buxO8ROv/oeLAZlyu2w792WaxDSEJvvjxjT0d6OExg/Kty1uHfdsqFXbgTWiPqnqJY
         qZHPxyGph3EkA1Jm6Y81yPE8FrxP8GAgX1t6yogd7zix3YdFIT95N6adpZ8BgHdh0b9N
         /+2pkpM0r+E32/Qa0Dyhls5QqPi4vW38fvBgjLtH752Co7Eq1ZIeoLT6gmBAftI8Tr5g
         Wn3JipvUDSZ6/CCUdAe12fDf1Hot91SF/rpvJ92ZZkcAETMfWDsHVehXH1i+PyH9tPAQ
         jVq/VH6EPQN4AjQ87Ot3nIXChzHR+zmN7ljQJx6Yy4kovh3/RR9bewtR6Sh9Wki68b0t
         ZoZQ==
X-Gm-Message-State: ABy/qLaWaIQAza2slYz2yPGSBP3z42bmt6GxhRckq22FMZgaGEa3o5oZ
        OyKVuZbacOrEbIGLiJdclunWbSUNh1QfAg==
X-Google-Smtp-Source: APBJJlGquqiQDe0ek++We7XvM6VdUiH8QYsjDErvhPQhHCcFeo5pa5ohDi7QWyzdq3IKA8tiitVNzw==
X-Received: by 2002:a81:8493:0:b0:56c:e260:e2d5 with SMTP id u141-20020a818493000000b0056ce260e2d5mr6140684ywf.7.1688719711334;
        Fri, 07 Jul 2023 01:48:31 -0700 (PDT)
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com. [209.85.219.181])
        by smtp.gmail.com with ESMTPSA id x5-20020a818705000000b0056d31a089e9sm918449ywf.126.2023.07.07.01.48.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Jul 2023 01:48:31 -0700 (PDT)
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-bad0c4f6f50so2395000276.1;
        Fri, 07 Jul 2023 01:48:31 -0700 (PDT)
X-Received: by 2002:a25:1942:0:b0:bc8:42db:2c07 with SMTP id
 63-20020a251942000000b00bc842db2c07mr3102080ybz.25.1688719710839; Fri, 07 Jul
 2023 01:48:30 -0700 (PDT)
MIME-Version: 1.0
References: <fbfea3ad-d327-4ad5-ac9c-648c7ca3fe1f@roeck-us.net>
 <CAMuHMdUfXdCf_CQuWXpP72MzKFYvXg3Ud1VN_3Bd0RHxfLhVeQ@mail.gmail.com>
 <7b2c0d812280afaefee0c70a9aea00a0fcf84e3a.camel@physik.fu-berlin.de> <CAMuHMdWLdJPC6oQ0P4_DVbPXrVjg=PMjTUdX4MD4+tmc3BW9sg@mail.gmail.com>
In-Reply-To: <CAMuHMdWLdJPC6oQ0P4_DVbPXrVjg=PMjTUdX4MD4+tmc3BW9sg@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 7 Jul 2023 10:48:18 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUzk8GuaqK6rBLaskVb=8Lsqe5hZ-=N=zqfWcxay-Euew@mail.gmail.com>
Message-ID: <CAMuHMdUzk8GuaqK6rBLaskVb=8Lsqe5hZ-=N=zqfWcxay-Euew@mail.gmail.com>
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

On Fri, Jul 7, 2023 at 9:14 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> On Thu, Jul 6, 2023 at 6:39 PM John Paul Adrian Glaubitz
> <glaubitz@physik.fu-berlin.de> wrote:
> > On Thu, 2023-07-06 at 17:39 +0200, Geert Uytterhoeven wrote:
> > > Which sh4 platforms in particular?
> > >
> > > I booted a kernel with this patch on rts7751r2d (QEMU) and landisk
> > > (physical) two days ago.
> >
> > I gave it a try with the command line Guenter suggested and indeed the kernel locks
> > up right here with the patch applied and boots fine without it:
> >
> > Creating 4 MTD partitions on "physmap-flash":
> > 0x000000000000-0x000000040000 : "U-Boot"
> > 0x000000040000-0x000000080000 : "Environment"
> > 0x000000080000-0x000000240000 : "Kernel"
> > 0x000000240000-0x000001000000 : "Flash_FS"
> > 8139too: 8139too Fast Ethernet driver 0.9.28
> > 8139too 0000:00:01.0: This (id 10ec:8139 rev 20) is an enhanced 8139C+ chip, use 8139cp
> > sm501-usb sm501-usb: SM501 OHCI
> > sm501-usb sm501-usb: new USB bus registered, assigned bus number 1
> > sm501-usb sm501-usb: irq 116, io mem 0x13e40000
> > usb usb1: New USB device found, idVendor=1d6b, idProduct=0001, bcdDevice= 6.04
> > usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> > usb usb1: Product: SM501 OHCI
> > usb usb1: Manufacturer: Linux 6.4.0-12069-gc17414a273b8 ohci_hcd
> > usb usb1: SerialNumber: sm501-usb
> > hub 1-0:1.0: USB hub found
> > hub 1-0:1.0: 2 ports detected
> > usbcore: registered new interface driver usb-storage
> > rtc-r9701 spi0.0: cannot read RTC register
> > usbcore: registered new interface driver usbhid
> > usbhid: USB HID core driver
> > NET: Registered PF_PACKET protocol family
> > heartbeat: version 0.1.2 loaded
> > ata1: found unknown device (class 0)
> > (stops here)
> >
> > Using rts7751r2dplus_defconfig and the following command line:
> >
> > qemu-system-sh4 -M r2d -kernel vmlinuz-6.5-rc1 -hda debian_sid_sh4_standard.qcow2 -no-reboot -device rtl8139,netdev=net0 -netdev user,id=net0 -append "root=/dev/sda1 console=ttySC1,115200
> > earlycon=scif,mmio16,0xffe80000 noiotrap" -serial null -serial stdio -nographic -monitor null
> >
> > And using this old qcow2 image:
> >
> > > https://people.debian.org/~aurel32/qemu/sh4/debian_sid_sh4_standard.qcow2
> >
> > Maybe it's a configuration issue if it works for you?
>
> I am not using rts7751r2dplus_defconfig, but my own[*] config,
> which boots fine into initrd userspace.
>
> I can reproduce the issue with rts7751r2dplus_defconfig, but I may
> not be able to look into it today...

Disabling CONFIG_USB_OHCI_HCD fixes the hang.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
