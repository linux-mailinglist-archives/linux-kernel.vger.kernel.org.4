Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4377574A24F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 18:39:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231508AbjGFQjM convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 6 Jul 2023 12:39:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231315AbjGFQjL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 12:39:11 -0400
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F4251730;
        Thu,  6 Jul 2023 09:39:09 -0700 (PDT)
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.95)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1qHS0P-001GI4-MW; Thu, 06 Jul 2023 18:38:57 +0200
Received: from p57bd990e.dip0.t-ipconnect.de ([87.189.153.14] helo=suse-laptop.fritz.box)
          by inpost2.zedat.fu-berlin.de (Exim 4.95)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1qHS0P-000n6b-Ew; Thu, 06 Jul 2023 18:38:57 +0200
Message-ID: <7b2c0d812280afaefee0c70a9aea00a0fcf84e3a.camel@physik.fu-berlin.de>
Subject: Re: [PATCH] sh: Avoid using IRQ0 on SH3 and SH4
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     Sergey Shtylyov <s.shtylyov@omp.ru>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 06 Jul 2023 18:38:55 +0200
In-Reply-To: <CAMuHMdUfXdCf_CQuWXpP72MzKFYvXg3Ud1VN_3Bd0RHxfLhVeQ@mail.gmail.com>
References: <fbfea3ad-d327-4ad5-ac9c-648c7ca3fe1f@roeck-us.net>
         <CAMuHMdUfXdCf_CQuWXpP72MzKFYvXg3Ud1VN_3Bd0RHxfLhVeQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.48.3 
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 87.189.153.14
X-ZEDAT-Hint: PO
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert!

On Thu, 2023-07-06 at 17:39 +0200, Geert Uytterhoeven wrote:
> Which sh4 platforms in particular?
> 
> I booted a kernel with this patch on rts7751r2d (QEMU) and landisk
> (physical) two days ago.

I gave it a try with the command line Guenter suggested and indeed the kernel locks
up right here with the patch applied and boots fine without it:

Creating 4 MTD partitions on "physmap-flash":
0x000000000000-0x000000040000 : "U-Boot"
0x000000040000-0x000000080000 : "Environment"
0x000000080000-0x000000240000 : "Kernel"
0x000000240000-0x000001000000 : "Flash_FS"
8139too: 8139too Fast Ethernet driver 0.9.28
8139too 0000:00:01.0: This (id 10ec:8139 rev 20) is an enhanced 8139C+ chip, use 8139cp
sm501-usb sm501-usb: SM501 OHCI
sm501-usb sm501-usb: new USB bus registered, assigned bus number 1
sm501-usb sm501-usb: irq 116, io mem 0x13e40000
usb usb1: New USB device found, idVendor=1d6b, idProduct=0001, bcdDevice= 6.04
usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
usb usb1: Product: SM501 OHCI
usb usb1: Manufacturer: Linux 6.4.0-12069-gc17414a273b8 ohci_hcd
usb usb1: SerialNumber: sm501-usb
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
usbcore: registered new interface driver usb-storage
rtc-r9701 spi0.0: cannot read RTC register
usbcore: registered new interface driver usbhid
usbhid: USB HID core driver
NET: Registered PF_PACKET protocol family
heartbeat: version 0.1.2 loaded
ata1: found unknown device (class 0)
(stops here)

Using rts7751r2dplus_defconfig and the following command line:

qemu-system-sh4 -M r2d -kernel vmlinuz-6.5-rc1 -hda debian_sid_sh4_standard.qcow2 -no-reboot -device rtl8139,netdev=net0 -netdev user,id=net0 -append "root=/dev/sda1 console=ttySC1,115200
earlycon=scif,mmio16,0xffe80000 noiotrap" -serial null -serial stdio -nographic -monitor null

And using this old qcow2 image:

> https://people.debian.org/~aurel32/qemu/sh4/debian_sid_sh4_standard.qcow2

Maybe it's a configuration issue if it works for you?

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
