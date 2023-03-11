Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FC216B604B
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 20:44:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbjCKTo0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 14:44:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjCKToY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 14:44:24 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 776E71EBE0;
        Sat, 11 Mar 2023 11:44:23 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id i10so8941893plr.9;
        Sat, 11 Mar 2023 11:44:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678563863;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ya1Vlp5dsrx7FwoAqbduboNWYkir2aqNP6SWcpnXsME=;
        b=oryAAl9LBJSdr2Rrn7fpw6+igiYsUpt7eZMXU2HuX1nTtisBXg6PrX8KKAaw4rEMY6
         ZTqEd6VP5ZKW5Jj5x/njU7bICQ4ox60uboWE++WnpgiI58+zyHTfqVCMxn3WCE8Z/73j
         UQGw9YwCiMiWiBpc0wvNVnJkbjbKpS3zpv0zu9+uCjtfy2mJ7Tl5UGwBxxgK1HI0noHu
         TIfn3yKtuOCuIEcY0COZ2ScC4Ty7El/wINdYODXeelbAJ+jg3XKFBodrF8cUcfvOrQSe
         LWVORC26g4V4ue+G2qqpLZJvQQjDPU++cQSHWZVnXNhC0nhsiuOhhGceNQZYBshOTQy/
         Jpsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678563863;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ya1Vlp5dsrx7FwoAqbduboNWYkir2aqNP6SWcpnXsME=;
        b=mpzppcWF7DfcDXEOVRavzWm0/Z/4jxcjKhYS+Um4wDIRd34lYJ5wJftGfKWeHhHsVX
         fjRCZtGPsg5kH03VNKFZ6kaW0DmTsm9QxSJIQHNtXnefPK7E9hp9lhdq4YTxAuiWnI1i
         REXkwQ+YO1G8MBShSGbe6FvLquYY2xE8Y9wUt2NE7iwBOiR+S88e/sSd3l24znQFltZc
         MqRttHtgxrqgBsWEJBv/UwzgsXySiHugE2QWyf+sQwNV4NzhygP4WcOBLLsb8P+1kert
         oY2e/jpacB638DB/ElE/s9RMQESBTVwiLZHYw/Ija9EkFFPmlwOE+HHOe9jTOE92ojAl
         /1Sw==
X-Gm-Message-State: AO0yUKVQCMrovc7OtE1GZiZyn5vDIgA7+ryR0yh7Q7HF9HPGImlzQSiU
        nksR/2e6V28OrGcXxtF0PqdLQ4Tru00fCPySGmZJNu2Pjq0=
X-Google-Smtp-Source: AK7set9ivIxeVmrkmT/ihglFs2A2BZWx28uaZs9LbCO88OCGb6I30L9nsYLks2OtvZXUhwiDFwH4EK/JHT/IXb9svdE=
X-Received: by 2002:a17:902:fb4e:b0:19f:3a0f:cccf with SMTP id
 lf14-20020a170902fb4e00b0019f3a0fcccfmr187207plb.3.1678563862901; Sat, 11 Mar
 2023 11:44:22 -0800 (PST)
MIME-Version: 1.0
References: <20230310121306.4632-1-noltari@gmail.com> <da5d150e-a2db-573d-e231-b4fd9fdaf63b@gmail.com>
In-Reply-To: <da5d150e-a2db-573d-e231-b4fd9fdaf63b@gmail.com>
From:   Jonas Gorski <jonas.gorski@gmail.com>
Date:   Sat, 11 Mar 2023 20:44:11 +0100
Message-ID: <CAOiHx=njCvfVju9BAe7gTzMq0vybQF-gy4SRZrhEJFULGLhC7w@mail.gmail.com>
Subject: Re: [PATCH] mips: bmips: BCM6358: disable arch_sync_dma_for_cpu_all()
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     =?UTF-8?B?w4FsdmFybyBGZXJuw6FuZGV6IFJvamFz?= <noltari@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com, tsbogend@alpha.franken.de,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,LOTS_OF_MONEY,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 11 Mar 2023 at 18:32, Florian Fainelli <f.fainelli@gmail.com> wrote=
:
>
>
>
> On 3/10/2023 4:13 AM, =C3=81lvaro Fern=C3=A1ndez Rojas wrote:
> > arch_sync_dma_for_cpu_all() causes kernel panics on BCM6358 with EHCI/O=
HCI:
> > [    3.881739] usb 1-1: new high-speed USB device number 2 using ehci-p=
latform
> > [    3.895011] Reserved instruction in kernel code[#1]:
> > [    3.900113] CPU: 0 PID: 1 Comm: init Not tainted 5.10.16 #0
> > [    3.905829] $ 0   : 00000000 10008700 00000000 77d94060
> > [    3.911238] $ 4   : 7fd1f088 00000000 81431cac 81431ca0
> > [    3.916641] $ 8   : 00000000 ffffefff 8075cd34 00000000
> > [    3.922043] $12   : 806f8d40 f3e812b7 00000000 000d9aaa
> > [    3.927446] $16   : 7fd1f068 7fd1f080 7ff559b8 81428470
> > [    3.932848] $20   : 00000000 00000000 55590000 77d70000
> > [    3.938251] $24   : 00000018 00000010
> > [    3.943655] $28   : 81430000 81431e60 81431f28 800157fc
> > [    3.949058] Hi    : 00000000
> > [    3.952013] Lo    : 00000000
> > [    3.955019] epc   : 80015808 setup_sigcontext+0x54/0x24c
> > [    3.960464] ra    : 800157fc setup_sigcontext+0x48/0x24c
> > [    3.965913] Status: 10008703       KERNEL EXL IE
> > [    3.970216] Cause : 00800028 (ExcCode 0a)
> > [    3.974340] PrId  : 0002a010 (Broadcom BMIPS4350)
> > [    3.979170] Modules linked in: ohci_platform ohci_hcd fsl_mph_dr_of =
ehci_platform ehci_fsl ehci_hcd gpio_button_hotplug usbcore nls_base usb_co=
mmon
> > [    3.992907] Process init (pid: 1, threadinfo=3D(ptrval), task=3D(ptr=
val), tls=3D77e22ec8)
> > [    4.000776] Stack : 81431ef4 7fd1f080 81431f28 81428470 7fd1f068 814=
31edc 7ff559b8 81428470
> > [    4.009467]         81431f28 7fd1f080 55590000 77d70000 77d5498c 800=
15c70 806f0000 8063ae74
> > [    4.018149]         08100002 81431f28 0000000a 08100002 81431f28 000=
0000a 77d6b418 00000003
> > [    4.026831]         ffffffff 80016414 80080734 81431ecc 81431ecc 000=
00001 00000000 04000000
> > [    4.035512]         77d54874 00000000 00000000 00000000 00000000 000=
00012 00000002 00000000
> > [    4.044196]         ...
> > [    4.046706] Call Trace:
> > [    4.049238] [<80015808>] setup_sigcontext+0x54/0x24c
> > [    4.054356] [<80015c70>] setup_frame+0xdc/0x124
> > [    4.059015] [<80016414>] do_notify_resume+0x1dc/0x288
> > [    4.064207] [<80011b50>] work_notifysig+0x10/0x18
> > [    4.069036]
> > [    4.070538] Code: 8fc300b4  00001025  26240008 <ac820000> ac830004  =
3c048063  0c0228aa  24846a00  26240010
> > [    4.080686]
> > [    4.082517] ---[ end trace 22a8edb41f5f983b ]---
> > [    4.087374] Kernel panic - not syncing: Fatal exception
> > [    4.092753] Rebooting in 1 seconds..
>
> Did you pinpoint which specific instruction within
> arch_sync_dma_for_cpu_all() is causing the reserved instruction exception=
?

It's setup_sigcontext(), not arch_sync_dma_for_cpu_all() that's
causing the exception ;-)

Hand decoding the Code gives me

lw $1, 0xb4($fp)
or $v0, 0, 0
addiu $a0, $s1, 8
sw $v0, 0($a0) <- the code in brackets, so I guess EPC?
sw $v1, 4($a0)

which I assume is this part:

err |=3D __put_user(regs->cp0_epc, &sc->sc_pc);

(0xb4 is the offset of cp0_epc, 0x8 the offset of sc_pc)

One thing I see is that we do the RAC flush for BMIPS3300, 4350 and
4380, but only initialize it for 3300 [1], but leave it at whatever
state the bootloader did for the other ones. Maybe it has some invalid
config in (that particuar?) 6358 that triggers issues later on after a
flush? E.g. the flush puts it in an error state, and the next time
something triggers a prefetch(write?) (by trying to access userspace)
it generates an error exception.

Just spit balling though.

[1] https://elixir.bootlin.com/linux/latest/source/arch/mips/kernel/smp-bmi=
ps.c#L587

Jonas
