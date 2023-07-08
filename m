Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66DDA74BF30
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jul 2023 22:52:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbjGHUwT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jul 2023 16:52:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjGHUwS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jul 2023 16:52:18 -0400
Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 215D0A4;
        Sat,  8 Jul 2023 13:52:16 -0700 (PDT)
Received: from [192.168.1.103] (178.176.79.158) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.986.14; Sat, 8 Jul 2023
 23:52:08 +0300
Subject: Re: [PATCH] sh: Avoid using IRQ0 on SH3 and SH4
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Guenter Roeck <linux@roeck-us.net>
CC:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, <linux-sh@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <fbfea3ad-d327-4ad5-ac9c-648c7ca3fe1f@roeck-us.net>
 <CAMuHMdUfXdCf_CQuWXpP72MzKFYvXg3Ud1VN_3Bd0RHxfLhVeQ@mail.gmail.com>
 <7b2c0d812280afaefee0c70a9aea00a0fcf84e3a.camel@physik.fu-berlin.de>
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
Message-ID: <cd1caa5d-fbd8-c3fe-29e9-b848ddd5634c@omp.ru>
Date:   Sat, 8 Jul 2023 23:52:07 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <7b2c0d812280afaefee0c70a9aea00a0fcf84e3a.camel@physik.fu-berlin.de>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [178.176.79.158]
X-ClientProxiedBy: msexch01.omp.ru (10.188.4.12) To msexch01.omp.ru
 (10.188.4.12)
X-KSE-ServerInfo: msexch01.omp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 5.9.59, Database issued on: 07/08/2023 20:39:41
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 59
X-KSE-AntiSpam-Info: Lua profiles 178491 [Jul 07 2023]
X-KSE-AntiSpam-Info: Version: 5.9.59.0
X-KSE-AntiSpam-Info: Envelope from: s.shtylyov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 520 520 ccb018a655251011855942a2571029252d3d69a2
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: {relay has no DNS name}
X-KSE-AntiSpam-Info: {SMTP from is not routable}
X-KSE-AntiSpam-Info: {Found in DNSBL: 178.176.79.158 in (user)
 b.barracudacentral.org}
X-KSE-AntiSpam-Info: {Found in DNSBL: 178.176.79.158 in (user)
 dbl.spamhaus.org}
X-KSE-AntiSpam-Info: 178.176.79.158:7.7.1,7.4.1,7.7.3;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;omp.ru:7.1.1
X-KSE-AntiSpam-Info: {iprep_blacklist}
X-KSE-AntiSpam-Info: ApMailHostAddress: 178.176.79.158
X-KSE-AntiSpam-Info: {DNS response errors}
X-KSE-AntiSpam-Info: Rate: 59
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=temperror header.from=omp.ru;spf=temperror
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 07/08/2023 20:44:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 7/8/2023 6:08:00 PM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/6/23 7:38 PM, John Paul Adrian Glaubitz wrote:
[...]

>> Which sh4 platforms in particular?
>>
>> I booted a kernel with this patch on rts7751r2d (QEMU) and landisk
>> (physical) two days ago.
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

   I guess it was irq 100 before my patch. What if you undo the following
part of my patch?

Index: linux/arch/sh/include/mach-common/mach/r2d.h
===================================================================
--- linux.orig/arch/sh/include/mach-common/mach/r2d.h
+++ linux/arch/sh/include/mach-common/mach/r2d.h
@@ -47,7 +47,7 @@
 
 #define IRLCNTR1	(PA_BCR + 0)	/* Interrupt Control Register1 */
 
-#define R2D_FPGA_IRQ_BASE	100
+#define R2D_FPGA_IRQ_BASE	(100 + 16)
 
 #define IRQ_VOYAGER		(R2D_FPGA_IRQ_BASE + 0)
 #define IRQ_EXT			(R2D_FPGA_IRQ_BASE + 1)

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
[...]

> Adrian

MBR, Sergey
