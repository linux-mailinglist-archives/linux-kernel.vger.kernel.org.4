Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F7C374A2C1
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 19:04:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232373AbjGFRET (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 13:04:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232077AbjGFRER (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 13:04:17 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82412171D;
        Thu,  6 Jul 2023 10:04:16 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id 3f1490d57ef6-c581c758ad8so992274276.1;
        Thu, 06 Jul 2023 10:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688663055; x=1691255055;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OyVK+HWFyHpDagzJPlL/j2QN2G1znQeN5v1WZlWzVvg=;
        b=Z7qoNlsSOsWG4m1MYqTqgktbR3t6YnplSRjSNkqD054KQ3Pxi1xjbE7FtSVf51L+C5
         rLvW629zKPt+oDCZQeXyaqOO4xIaeirSVbvv7uhFwvGERU5ENL3hG4JErF6WCIhEMMEx
         /7Yi6TEXYwREnrZbnasmZf3yZF+Oh/iozdJkdhm4TzbU6seadZqgzPN3YvzwHQqqlrKs
         M7TTRKiwKSVL7v8kemqz2s8YMnL5x5jff0WivxYOfGpYTlnt5jhT/C7CHrv6UMo8FxxZ
         DcKzWvA8Qr27ezMlVknpLxLbSHDUQ6oO5t+qjo4+DCrkigB/kwkWwmc1+ONfS86G71MD
         zzlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688663055; x=1691255055;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OyVK+HWFyHpDagzJPlL/j2QN2G1znQeN5v1WZlWzVvg=;
        b=EOML57RDeBL5Li7v3HdTmM55XI0ESxs33DQGk2algfWok08Qw8WRNtxvKPFgQCwnL6
         0vl1O3BLyknVirHD7qwWYvQCPtTFtyWpacK6xEZGifTiUhK7qnur3zuwav9ixvla+Y5M
         TdGX5diAOtNHTuhBAGKD2ZdHWukE7FEAyitCdJ2ZATvHSFWOlD46WomekPkAGySWq6tm
         FdRSHtYPYnrfJHBj7Qvlsq55wZ0FdYTUrjRKHkVVbmE7EYyiaXGjx1uk1M+hmZ3w1F+k
         AAWjRgiAP2LQYTB3xZNa1iKghxmJ43zS5YRTebIAri/RtLYeJkS2SXAMQIcxadDU7qmW
         Np2Q==
X-Gm-Message-State: ABy/qLY5lgoHfaemUttrYGCfobGXp/BTGSPkA9WKxAp6VuTtlFZFCPfW
        zI+aeuUoA+A21ply/xST+w3RHvSRy6s=
X-Google-Smtp-Source: APBJJlGEGvpI+T34xGTcgc7yjlZ4W3KEV7jG9db5Aj3Cmq9+/eRPLD5kpBZqRQ2ImbEgEgWOK6F0Jg==
X-Received: by 2002:a5b:c85:0:b0:c61:e44d:c08e with SMTP id i5-20020a5b0c85000000b00c61e44dc08emr2267273ybq.19.1688663055550;
        Thu, 06 Jul 2023 10:04:15 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 132-20020a25048a000000b00bef51467958sm434274ybe.38.2023.07.06.10.04.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Jul 2023 10:04:15 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <c63b387a-e670-fed1-86df-83bff46789a1@roeck-us.net>
Date:   Thu, 6 Jul 2023 10:04:13 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Content-Language: en-US
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Sergey Shtylyov <s.shtylyov@omp.ru>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <fbfea3ad-d327-4ad5-ac9c-648c7ca3fe1f@roeck-us.net>
 <CAMuHMdUfXdCf_CQuWXpP72MzKFYvXg3Ud1VN_3Bd0RHxfLhVeQ@mail.gmail.com>
 <7b2c0d812280afaefee0c70a9aea00a0fcf84e3a.camel@physik.fu-berlin.de>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH] sh: Avoid using IRQ0 on SH3 and SH4
In-Reply-To: <7b2c0d812280afaefee0c70a9aea00a0fcf84e3a.camel@physik.fu-berlin.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/6/23 09:38, John Paul Adrian Glaubitz wrote:
> Hi Geert!
> 
> On Thu, 2023-07-06 at 17:39 +0200, Geert Uytterhoeven wrote:
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
>> https://people.debian.org/~aurel32/qemu/sh4/debian_sid_sh4_standard.qcow2
> 
> Maybe it's a configuration issue if it works for you?
> 

I tried rts7751r2dplus_defconfig with no modifications and the following minimized
qemu command line.

qemu-system-sh4 -M r2d -kernel arch/sh/boot/zImage -serial null -serial stdio -nographic -monitor null

This hangs after "heartbeat: version 0.1.2 loaded", so it doesn't
even get to the point where it would try to load a root file system.
After reverting this patch, I get
---[ end Kernel panic - not syncing: VFS: Unable to mount root fs on unknown-block(0,0) ]---
as expected.

I tried with qemu version 6.2, 7.1, 7.2, and 8.0.

Guenter



