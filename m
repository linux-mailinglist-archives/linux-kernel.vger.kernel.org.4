Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C5BB706C83
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 17:20:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231890AbjEQPUn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 11:20:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbjEQPUl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 11:20:41 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7224C5;
        Wed, 17 May 2023 08:20:38 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id 3f1490d57ef6-ba878d5e75fso619834276.3;
        Wed, 17 May 2023 08:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684336838; x=1686928838;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QBfMdC7dgpW5IT+TT50gvQR/rI+ieZNttOanKMuk+kc=;
        b=SCdx4fQl6GdhblNQIXImhSGtqxe3y69ZeESbbFx1grVHhTOx8wTbc0CC8jDI1Lv8tz
         Q+9rHD7om32FOmvIU1NMAJmtVaDvNM69R3gxjx5QGOk3f8gfsjoza4zq2gl0nXnHBqhn
         h7udTk2iy/Tq/JeoRv58G81ZznMnod+43PzNy3Rf3NDFRLt44kEifRtNRW71Ir2rRAGP
         mCdFDOavHlTCFB5RDdY1YMHeYp7DTK1+w5Pqc23c7QUDQZXri5o4Y6f98v4gorEJgT22
         avA/hKUKe0h12Ygn6pHHCmOA5mlXwj91EN5aReyCg8s6r8hVVG46d0X+jOsTYc3JC0+Y
         IJ1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684336838; x=1686928838;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QBfMdC7dgpW5IT+TT50gvQR/rI+ieZNttOanKMuk+kc=;
        b=X0X7hWjQDUzjIlEIl6OM9/vQJCAzZnYkniHf5s3PVS9G3wFxcat1y5yJClDzN4EHlK
         NQF50VKMby0/fPfVliGUkPQyIWMjdKVVEymhN//DowUDirF2C6CEhxv8klj3w5ZHoOyh
         hBjBnPJXB6ZTdszyNiuezXR6DXLr6Q1bdnE5f31o7WkSuU8BN5g9+8GnkOMMbVMRKhif
         bN3KBVkSYegJNhyoNeAfTb+YAiYWlmk8OsXCHaBAzBJzy4+3FwZ+Rog0k6zCH62ifuRN
         B4LKPJ+JSMlfjmhez+B3gq94v4pUOmIlVH2TFzU1TLTjxdie4SPey2CxdOA9wzkpqjiD
         hnGg==
X-Gm-Message-State: AC+VfDymXncZQaMl/lO8A8U6QxnQMrUdeIC/xgddRuHb7mNq544RSYCP
        57w4gQ9Zq/UH9d0UA9O3BcSWp3MT7oc67mcsW+g=
X-Google-Smtp-Source: ACHHUZ7l2ExM2OnfQe6ZkuCKvRiMCUQkAopslmNQCnPLuoF0cEeehyzP0QIYudKuUWCbFDq2CMbr4lZDcRTj3PWwgPE=
X-Received: by 2002:a25:19c4:0:b0:ba2:6aea:2b2 with SMTP id
 187-20020a2519c4000000b00ba26aea02b2mr28175654ybz.39.1684336837607; Wed, 17
 May 2023 08:20:37 -0700 (PDT)
MIME-Version: 1.0
References: <CAAQoYRm3766SG7+VuwVzu_xH8aWihoKWMEp8xQGNgJ6oOtC9+g@mail.gmail.com>
 <CAAQoYRmXdMp7b2r+yCRUtGrbfQH-Cb8gMAVo7YscuQEM5kgajw@mail.gmail.com>
 <CAKR-sGdiLzZ7iVbLmz1uPwYoUXQZ2qGwmCBAq_-OKXfVT=Pj-A@mail.gmail.com>
 <d0543f48-6f0b-58e0-cc18-695a28c493fc@gmail.com> <CAKR-sGer0r0FxyOQQu7TxT0d2D981_1fQWxa_XghfyWKWSJVfQ@mail.gmail.com>
 <e16ae30a-f3ac-fbd9-b070-185997bcb89d@broadcom.com>
In-Reply-To: <e16ae30a-f3ac-fbd9-b070-185997bcb89d@broadcom.com>
From:   =?UTF-8?B?w4FsdmFybyBGZXJuw6FuZGV6IFJvamFz?= <noltari@gmail.com>
Date:   Wed, 17 May 2023 17:20:26 +0200
Message-ID: <CAKR-sGd3Uxxquv6hdhZsmNP_sSfnOaW0JZLB590RsmRcqUx+Tg@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: mtd: nand: Macronix: document new binding
To:     William Zhang <william.zhang@broadcom.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        liao jaime <jaimeliao.tw@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-mtd@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi William,

El mi=C3=A9, 17 may 2023 a las 7:30, William Zhang
(<william.zhang@broadcom.com>) escribi=C3=B3:
>
>
>
> On 05/16/2023 12:02 PM, =C3=81lvaro Fern=C3=A1ndez Rojas wrote:
> > Sure,
> >
> > Here you go:
> > [    0.000000] Linux version 5.15.111 (noltari@atlantis)
> > (mips-openwrt-linux-musl-gcc (OpenWrt GCC 12.3.0 r0+22899-466be0612a)
> > 12.3.0, GNU ld (GNU Binutils) 2.40.0) #0 SMP Tue May 16 14:33:20 2023
> > [    0.000000] CPU0 revision is: 0002a080 (Broadcom BMIPS4350)
> > [    0.000000] MIPS: machine is Sercomm H500-s vfes
> > [    0.000000] 128MB of RAM installed
> > [    0.000000] earlycon: bcm63xx_uart0 at MMIO 0x10000180 (options '115=
200n8')
> > [    0.000000] printk: bootconsole [bcm63xx_uart0] enabled
> > [    0.000000] Initrd not found or empty - disabling initrd
> > [    0.000000] Reserving 0KB of memory at 4194303KB for kdump
> > [    0.000000] Primary instruction cache 64kB, VIPT, 4-way, linesize 16=
 bytes.
> > [    0.000000] Primary data cache 32kB, 2-way, VIPT, cache aliases,
> > linesize 16 bytes
> > [    0.000000] Zone ranges:
> > [    0.000000]   Normal   [mem 0x0000000000000000-0x0000000007ffffff]
> > [    0.000000] Movable zone start for each node
> > [    0.000000] Early memory node ranges
> > [    0.000000]   node   0: [mem 0x0000000000000000-0x0000000007ffffff]
> > [    0.000000] Initmem setup node 0 [mem 0x0000000000000000-0x000000000=
7ffffff]
> > [    0.000000] percpu: Embedded 11 pages/cpu s13328 r8192 d23536 u45056
> > [    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 3=
2480
> > [    0.000000] Kernel command line: earlycon
> > [    0.000000] Dentry cache hash table entries: 16384 (order: 4, 65536
> > bytes, linear)
> > [    0.000000] Inode-cache hash table entries: 8192 (order: 3, 32768
> > bytes, linear)
> > [    0.000000] mem auto-init: stack:off, heap alloc:off, heap free:off
> > [    0.000000] Memory: 108656K/131072K available (6902K kernel code,
> > 613K rwdata, 1404K rodata, 11872K init, 215K bss, 22416K reserved, 0K
> > cma-reserved)
> > [    0.000000] SLUB: HWalign=3D64, Order=3D0-3, MinObjects=3D0, CPUs=3D=
2, Nodes=3D1
> > [    0.000000] rcu: Hierarchical RCU implementation.
> > [    0.000000]  Tracing variant of Tasks RCU enabled.
> > [    0.000000] rcu: RCU calculated value of scheduler-enlistment delay
> > is 10 jiffies.
> > [    0.000000] NR_IRQS: 256
> > [    0.000000] irq_bcm6345_l1: registered BCM6345 L1 intc (IRQs: 128)
> > [    0.000000] irq_bcm6345_l1:   CPU0 (irq =3D 2)
> > [    0.000000] irq_bcm6345_l1:   CPU1 (irq =3D 3)
> > [    0.000000] brcm,bcm63268 detected @ 400 MHz
> > [    0.000000] clocksource: MIPS: mask: 0xffffffff max_cycles:
> > 0xffffffff, max_idle_ns: 9556302233 ns
> > [    0.000002] sched_clock: 32 bits at 200MHz, resolution 5ns, wraps
> > every 10737418237ns
> > [    0.008292] Calibrating delay loop... 398.13 BogoMIPS (lpj=3D1990656=
)
> > [    0.074683] pid_max: default: 32768 minimum: 301
> > [    0.081788] Mount-cache hash table entries: 1024 (order: 0, 4096
> > bytes, linear)
> > [    0.089319] Mountpoint-cache hash table entries: 1024 (order: 0,
> > 4096 bytes, linear)
> > [    0.106094] rcu: Hierarchical SRCU implementation.
> > [    0.112665] smp: Bringing up secondary CPUs ...
> > [    0.119348] SMP: Booting CPU1...
> > [    8.330979] Primary instruction cache 64kB, VIPT, 4-way, linesize 16=
 bytes.
> > [    8.331017] Primary data cache 32kB, 2-way, VIPT, cache aliases,
> > linesize 16 bytes
> > [    8.331294] CPU1 revision is: 0002a080 (Broadcom BMIPS4350)
> > [    0.182819] Synchronize counters for CPU 1:
> > [    0.203500] SMP: CPU1 is running
> > [    0.203512] done.
> > [    0.213401] smp: Brought up 1 node, 2 CPUs
> > [    0.228870] clocksource: jiffies: mask: 0xffffffff max_cycles:
> > 0xffffffff, max_idle_ns: 19112604462750000 ns
> > [    0.239058] futex hash table entries: 512 (order: 3, 32768 bytes, li=
near)
> > [    0.246439] pinctrl core: initialized pinctrl subsystem
> > [    0.254917] NET: Registered PF_NETLINK/PF_ROUTE protocol family
> > [    0.312700] clocksource: Switched to clocksource MIPS
> > [    0.321061] NET: Registered PF_INET protocol family
> > [    0.326879] IP idents hash table entries: 2048 (order: 2, 16384
> > bytes, linear)
> > [    0.335972] tcp_listen_portaddr_hash hash table entries: 512
> > (order: 0, 6144 bytes, linear)
> > [    0.344721] Table-perturb hash table entries: 65536 (order: 6,
> > 262144 bytes, linear)
> > [    0.352721] TCP established hash table entries: 1024 (order: 0,
> > 4096 bytes, linear)
> > [    0.360622] TCP bind hash table entries: 1024 (order: 1, 8192 bytes,=
 linear)
> > [    0.368005] TCP: Hash tables configured (established 1024 bind 1024)
> > [    0.375074] UDP hash table entries: 256 (order: 1, 8192 bytes, linea=
r)
> > [    0.381862] UDP-Lite hash table entries: 256 (order: 1, 8192 bytes, =
linear)
> > [    0.389762] NET: Registered PF_UNIX/PF_LOCAL protocol family
> > [    0.395748] PCI: CLS 0 bytes, default 16
> > [    0.403410] workingset: timestamp_bits=3D14 max_order=3D15 bucket_or=
der=3D1
> > [    0.426490] squashfs: version 4.0 (2009/01/31) Phillip Lougher
> > [    0.432492] jffs2: version 2.2 (NAND) (SUMMARY) (LZMA) (RTIME)
> > (CMODE_PRIORITY) (c) 2001-2006 Red Hat, Inc.
> > [    0.459472] bcm63xx-power-controller 1000184c.power-controller:
> > registered 14 power domains
> > [    0.470267] 10000180.serial: ttyS0 at MMIO 0x10000180 (irq =3D 8,
> > base_baud =3D 1562500) is a bcm63xx_uart
> > [    0.479996] printk: console [ttyS0] enabled
> > [    0.479996] printk: console [ttyS0] enabled
> > [    0.488651] printk: bootconsole [bcm63xx_uart0] disabled
> > [    0.488651] printk: bootconsole [bcm63xx_uart0] disabled
> > [    0.533435] bcm2835-rng 10002880.rng: hwrng registered
> > [    0.606025] bcm6368_nand 10000200.nand: there is not valid maps for
> > state default
> > [    0.633977] nand: device found, Manufacturer ID: 0xc2, Chip ID: 0xf1
> > [    0.640506] nand: Macronix MX30LF1G18AC
> > [    0.644551] nand: 128 MiB, SLC, erase size: 128 KiB, page size:
> > 2048, OOB size: 64
> > [    0.652359] bcm6368_nand 10000200.nand: detected 128MiB total,
> > 128KiB blocks, 2KiB pages, 16B OOB, 8-bit, BCH-4
> > [    0.703373] Bad block table not found for chip 0
> > [    0.732040] Bad block table not found for chip 0
> > [    0.736842] Scanning device for bad blocks
> > [    0.832678] CPU 0 Unable to handle kernel paging request at virtual
> > address 00000014, epc =3D=3D 8009b300, ra =3D=3D 806cc650
> > [    0.843628] Oops[#1]:
> > [    0.845958] CPU: 0 PID: 88 Comm: hwrng Not tainted 5.15.111 #0
> > [    0.851959] $ 0   : 00000000 00000001 00000008 00000000
> > [    0.857358] $ 4   : 81808464 00000064 00000000 00000001
> > [    0.862753] $ 8   : 81810000 00001ff0 00001c00 815b8880
> > [    0.868146] $12   : 0000b79d 00000000 00000000 00009bb
> >
> > Please, tell me if you want me to add any debugging to the log.
> >
> > Best regards,
> > =C3=81lvaro.
> >
> > El mar, 16 may 2023 a las 20:58, Florian Fainelli
> > (<f.fainelli@gmail.com>) escribi=C3=B3:
> >>
> >> +William,
> >>
> >> On 5/16/23 11:55, =C3=81lvaro Fern=C3=A1ndez Rojas wrote:
> >>> Hi Jaime,
> >>>
> >>> I've reproduced the issue on a Comtrend VR-3032u (MX30LF1G08AA). Afte=
r
> >>> forcing it to check block protection (it's not supported on that
> >>> device), the NAND controller stops reading/writing anything.
> >>>
> >>> @Florian is it possible that low level ops (GET_FEATURES/SET_FEATURES=
)
> >>> aren't supported on BCM63268 NAND controllers and this is causing the
> >>> issue?
> >>
> >> Yes, this looks like what we have seen as well even with newer NAND
> >> controllers actually. Would it be possible to obtain a full log from
> >> either of you?
> >>
> >> William, is this something you have seen before as well?
> >>
> No, I haven't seen such issue before.  It is possible I didn't have this
>   Macronix parts in my board. If I can find a board with Macronix part,
> I will try it. But we don't use this feature and don't connect the PT
> pin in our reference board which means the PT feature is disabled in the
> nand part.
>
> Alvaro, Do you know if your 63268 board has PT pin connected or not?

No, I don't know if PT pin is connected.
I would have to open the case and check, but judging from the
following image I would say it's not connected:
https://openwrt.org/_media/media/sercomm/h500s/h500s-nand.jpg

> Can you check if the macronix's lock and unlock function being calling
> before the hang?   Or is it just get/set feature function getting called
> to determine PT is supported?   The get/set feature function should work
> as they are used by other pathes

No, the macronix's lock/unlock functions aren't called before the hang.
In fact, if I comment out the nand_get_features call and replace it
with ret =3D 1 it doesn't hang:
https://github.com/torvalds/linux/blob/f1fcbaa18b28dec10281551dfe6ed3a3ed80=
e3d6/drivers/mtd/nand/raw/nand_macronix.c#L229-L230

>
>
> >>>
> >>> Best regards,
> >>> =C3=81lvaro.
> >>>
> >>> El mi=C3=A9, 26 abr 2023 a las 9:24, liao jaime (<jaimeliao.tw@gmail.=
com>) escribi=C3=B3:
> >>>>
> >>>> Hi =C3=81lvaro
> >>>>
> >>>> In nand_scan_tail(), each manufacturer init function call will be ex=
ecute.
> >>>> In macronix_nand_init(), block protect will be execute after flash d=
etect.
> >>>> I have validate MX30LF1G18AC in Linux kernel v5.15.
> >>>> I didn't got situation "device hangs"  on my side.
> >>>> BP is to prevent incorrect operations.
> >>>> Please check the controller settings for tracing this issue.
> >>>>
> >>>> Thanks
> >>>> Jaime
> >>>>
> >>>>>
> >>>>> Hello YouChing and Jaime,
> >>>>>
> >>>>> I still didn't get any feedback from you (or Macronix) on this issu=
e.
> >>>>> Did you have time to look into it?
> >>>>>
> >>>>> Thanks,
> >>>>> =C3=81lvaro.
> >>>>>
> >>>>> El vie, 24 mar 2023 a las 18:04, =C3=81lvaro Fern=C3=A1ndez Rojas
> >>>>> (<noltari@gmail.com>) escribi=C3=B3:
> >>>>>>
> >>>>>> Hi Miqu=C3=A8l,
> >>>>>>
> >>>>>> 2023-03-24 15:36 GMT+01:00, Miquel Raynal <miquel.raynal@bootlin.c=
om>:
> >>>>>>> Hi =C3=81lvaro,
> >>>>>>>
> >>>>>>> + YouChing and Jaime from Macronix
> >>>>>>> TLDR for them: there is a misbehavior since Mason added block
> >>>>>>> protection support. Just checking if the blocks are protected see=
ms to
> >>>>>>> misconfigure the chip entirely, see below. Any hints?
> >>>>>>
> >>>>>> Could it be that the NAND is stuck expecting a read 0x00 command w=
hich
> >>>>>> isn=E2=80=99t sent after getting the features?
> >>>>>>
> >>>>>>>
> >>>>>>> noltari@gmail.com wrote on Fri, 24 Mar 2023 15:15:47 +0100:
> >>>>>>>
> >>>>>>>> Hi Miqu=C3=A8l,
> >>>>>>>>
> >>>>>>>> 2023-03-24 14:45 GMT+01:00, Miquel Raynal <miquel.raynal@bootlin=
.com>:
> >>>>>>>>> Hi =C3=81lvaro,
> >>>>>>>>>
> >>>>>>>>> noltari@gmail.com wrote on Fri, 24 Mar 2023 12:21:11 +0100:
> >>>>>>>>>
> >>>>>>>>>> El vie, 24 mar 2023 a las 11:49, Miquel Raynal
> >>>>>>>>>> (<miquel.raynal@bootlin.com>) escribi=C3=B3:
> >>>>>>>>>>>
> >>>>>>>>>>> Hi =C3=81lvaro,
> >>>>>>>>>>>
> >>>>>>>>>>> noltari@gmail.com wrote on Fri, 24 Mar 2023 11:31:17 +0100:
> >>>>>>>>>>>
> >>>>>>>>>>>> Hi Miqu=C3=A8l,
> >>>>>>>>>>>>
> >>>>>>>>>>>> El vie, 24 mar 2023 a las 10:40, Miquel Raynal
> >>>>>>>>>>>> (<miquel.raynal@bootlin.com>) escribi=C3=B3:
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> Hi =C3=81lvaro,
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> noltari@gmail.com wrote on Thu, 23 Mar 2023 13:45:09 +0100:
> >>>>>>>>>>>>>
> >>>>>>>>>>>>>> Add new "mxic,disable-block-protection" binding documentat=
ion.
> >>>>>>>>>>>>>> This binding allows disabling block protection support for
> >>>>>>>>>>>>>> those
> >>>>>>>>>>>>>> devices not
> >>>>>>>>>>>>>> supporting it.
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>> Signed-off-by: =C3=81lvaro Fern=C3=A1ndez Rojas <noltari@g=
mail.com>
> >>>>>>>>>>>>>> ---
> >>>>>>>>>>>>>>    Documentation/devicetree/bindings/mtd/nand-macronix.txt=
 | 3
> >>>>>>>>>>>>>> +++
> >>>>>>>>>>>>>>    1 file changed, 3 insertions(+)
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>> diff --git
> >>>>>>>>>>>>>> a/Documentation/devicetree/bindings/mtd/nand-macronix.txt
> >>>>>>>>>>>>>> b/Documentation/devicetree/bindings/mtd/nand-macronix.txt
> >>>>>>>>>>>>>> index ffab28a2c4d1..03f65ca32cd3 100644
> >>>>>>>>>>>>>> --- a/Documentation/devicetree/bindings/mtd/nand-macronix.=
txt
> >>>>>>>>>>>>>> +++ b/Documentation/devicetree/bindings/mtd/nand-macronix.=
txt
> >>>>>>>>>>>>>> @@ -16,6 +16,9 @@ in children nodes.
> >>>>>>>>>>>>>>    Required NAND chip properties in children mode:
> >>>>>>>>>>>>>>    - randomizer enable: should be "mxic,enable-randomizer-=
otp"
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>> +Optional NAND chip properties in children mode:
> >>>>>>>>>>>>>> +- block protection disable: should be
> >>>>>>>>>>>>>> "mxic,disable-block-protection"
> >>>>>>>>>>>>>> +
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> Besides the fact that nowadays we prefer to see binding
> >>>>>>>>>>>>> conversions
> >>>>>>>>>>>>> to
> >>>>>>>>>>>>> yaml before adding anything, I don't think this will fly.
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> I'm not sure exactly what "disable block protection" means,=
 we
> >>>>>>>>>>>>> already have similar properties like "lock" and
> >>>>>>>>>>>>> "secure-regions",
> >>>>>>>>>>>>> not
> >>>>>>>>>>>>> sure they will fit but I think it's worth checking.
> >>>>>>>>>>>>
> >>>>>>>>>>>> As explained in 2/2, commit 03a539c7a118 introduced a regres=
sion
> >>>>>>>>>>>> on
> >>>>>>>>>>>> Sercomm H500-s (BCM63268) OpenWrt devices with Macronix
> >>>>>>>>>>>> MX30LF1G18AC
> >>>>>>>>>>>> which hangs the device.
> >>>>>>>>>>>>
> >>>>>>>>>>>> This is the log with block protection disabled:
> >>>>>>>>>>>> [    0.495831] bcm6368_nand 10000200.nand: there is not vali=
d maps
> >>>>>>>>>>>> for
> >>>>>>>>>>>> state default
> >>>>>>>>>>>> [    0.504995] nand: device found, Manufacturer ID: 0xc2, Ch=
ip ID:
> >>>>>>>>>>>> 0xf1
> >>>>>>>>>>>> [    0.511526] nand: Macronix MX30LF1G18AC
> >>>>>>>>>>>> [    0.515586] nand: 128 MiB, SLC, erase size: 128 KiB, page=
 size:
> >>>>>>>>>>>> 2048, OOB size: 64
> >>>>>>>>>>>> [    0.523516] bcm6368_nand 10000200.nand: detected 128MiB t=
otal,
> >>>>>>>>>>>> 128KiB blocks, 2KiB pages, 16B OOB, 8-bit, BCH-4
> >>>>>>>>>>>> [    0.535912] Bad block table found at page 65472, version =
0x01
> >>>>>>>>>>>> [    0.544268] Bad block table found at page 65408, version =
0x01
> >>>>>>>>>>>> [    0.954329] 9 fixed-partitions partitions found on MTD de=
vice
> >>>>>>>>>>>> brcmnand.0
> >>>>>>>>>>>> ...
> >>>>>>>>>>>>
> >>>>>>>>>>>> This is the log with block protection enabled:
> >>>>>>>>>>>> [    0.495095] bcm6368_nand 10000200.nand: there is not vali=
d maps
> >>>>>>>>>>>> for
> >>>>>>>>>>>> state default
> >>>>>>>>>>>> [    0.504249] nand: device found, Manufacturer ID: 0xc2, Ch=
ip ID:
> >>>>>>>>>>>> 0xf1
> >>>>>>>>>>>> [    0.510772] nand: Macronix MX30LF1G18AC
> >>>>>>>>>>>> [    0.514874] nand: 128 MiB, SLC, erase size: 128 KiB, page=
 size:
> >>>>>>>>>>>> 2048, OOB size: 64
> >>>>>>>>>>>> [    0.522780] bcm6368_nand 10000200.nand: detected 128MiB t=
otal,
> >>>>>>>>>>>> 128KiB blocks, 2KiB pages, 16B OOB, 8-bit, BCH-4
> >>>>>>>>>>>> [    0.539687] Bad block table not found for chip 0
> >>>>>>>>>>>> [    0.550153] Bad block table not found for chip 0
> >>>>>>>>>>>> [    0.555069] Scanning device for bad blocks
> >>>>>>>>>>>> [    0.601213] CPU 1 Unable to handle kernel paging request =
at
> >>>>>>>>>>>> virtual
> >>>>>>>>>>>> address 10277f00, epc =3D=3D 8039ce70, ra =3D=3D 8016ad50
> >>>>>>>>>>>> *** Device hangs ***
> >>>>>>>>>>>>
> >>>>>>>>>>>> Enabling macronix_nand_block_protection_support() makes the =
device
> >>>>>>>>>>>> unable to detect the bad block table and hangs it when tryin=
g to
> >>>>>>>>>>>> scan
> >>>>>>>>>>>> for bad blocks.
> >>>>>>>>>>>
> >>>>>>>>>>> Please trace nand_macronix.c and look:
> >>>>>>>>>>> - are the get_features and set_features really supported by t=
he
> >>>>>>>>>>>     controller driver?
> >>>>>>>>>>
> >>>>>>>>>> This is what I could find by debugging:
> >>>>>>>>>> [    0.494993] bcm6368_nand 10000200.nand: there is not valid =
maps for
> >>>>>>>>>> state default
> >>>>>>>>>> [    0.505375] nand: device found, Manufacturer ID: 0xc2, Chip=
 ID:
> >>>>>>>>>> 0xf1
> >>>>>>>>>> [    0.512077] nand: Macronix MX30LF1G18AC
> >>>>>>>>>> [    0.515994] nand: 128 MiB, SLC, erase size: 128 KiB, page s=
ize:
> >>>>>>>>>> 2048, OOB size: 64
> >>>>>>>>>> [    0.523928] bcm6368_nand 10000200.nand: detected 128MiB tot=
al,
> >>>>>>>>>> 128KiB blocks, 2KiB pages, 16B OOB, 8-bit, BCH-4
> >>>>>>>>>> [    0.534415] bcm6368_nand 10000200.nand: ll_op cmd 0xa00ee
> >>>>>>>>>> [    0.539988] bcm6368_nand 10000200.nand: ll_op cmd 0x600a0
> >>>>>>>>>> [    0.545659] bcm6368_nand 10000200.nand: ll_op cmd 0x10000
> >>>>>>>>>> [    0.551214] bcm6368_nand 10000200.nand: NAND_CMD_GET_FEATUR=
ES =3D
> >>>>>>>>>> 0x00
> >>>>>>>>>> [    0.557843] bcm6368_nand 10000200.nand: ll_op cmd 0x10000
> >>>>>>>>>> [    0.563475] bcm6368_nand 10000200.nand: NAND_CMD_GET_FEATUR=
ES =3D
> >>>>>>>>>> 0x00
> >>>>>>>>>> [    0.569998] bcm6368_nand 10000200.nand: ll_op cmd 0x10000
> >>>>>>>>>> [    0.575653] bcm6368_nand 10000200.nand: NAND_CMD_GET_FEATUR=
ES =3D
> >>>>>>>>>> 0x00
> >>>>>>>>>> [    0.582246] bcm6368_nand 10000200.nand: ll_op cmd 0x8001000=
0
> >>>>>>>>>> [    0.588067] bcm6368_nand 10000200.nand: NAND_CMD_GET_FEATUR=
ES =3D
> >>>>>>>>>> 0x00
> >>>>>>>>>> [    0.594657] nand: nand_get_features: addr=3Da0 subfeature_p=
aram=3D[00
> >>>>>>>>>> 00 00 00] -> 0
> >>>>>>>>>> [    0.602341] macronix_nand_block_protection_support:
> >>>>>>>>>> ONFI_FEATURE_ADDR_MXIC_PROTECTION=3D0
> >>>>>>>>>> [    0.610548] macronix_nand_block_protection_support: !=3D
> >>>>>>>>>> MXIC_BLOCK_PROTECTION_ALL_LOCK
> >>>>>>>>>> [    0.624760] Bad block table not found for chip 0
> >>>>>>>>>> [    0.635542] Bad block table not found for chip 0
> >>>>>>>>>> [    0.640270] Scanning device for bad blocks
> >>>>>>>>>>
> >>>>>>>>>> I don't know how to tell if get_features / set_features is rea=
lly
> >>>>>>>>>> supported...
> >>>>>>>>>
> >>>>>>>>> Looks like your driver does not support exec_op but the core pr=
ovides a
> >>>>>>>>> get/set_feature implementation.
> >>>>>>>>
> >>>>>>>> According to Florian, low level should be supported on brcmnand
> >>>>>>>> controllers >=3D 4.0
> >>>>>>>> Also:
> >>>>>>>> https://github.com/nomis/bcm963xx_4.12L.06B_consumer/blob/e2f23d=
dbb20bf75689372b6e6a5a0dc613f6e313/shared/opensource/include/bcm963xx/63268=
_map_part.h#L1597
> >>>>>>>
> >>>>>>> Just to be sure, you're using a mainline controller driver, not t=
his
> >>>>>>> one?
> >>>>>>
> >>>>>> Yes, this was just to prove that the HW I=E2=80=99m using has get/=
set features support.
> >>>>>> I=E2=80=99m using OpenWrt, so it=E2=80=99s linux v5.15 driver.
> >>>>>>
> >>>>>>>
> >>>>>>>>>
> >>>>>>>>>>
> >>>>>>>>>>> - what is the state of the locking configuration in the chip =
when
> >>>>>>>>>>> you
> >>>>>>>>>>>     boot?
> >>>>>>>>>>
> >>>>>>>>>> Unlocked, I guess...
> >>>>>>>>>> How can I check that?
> >>>>>>>>>
> >>>>>>>>> It's in your dump, the chip returns 0, meaning it's all unlocke=
d,
> >>>>>>>>> apparently.
> >>>>>>>>
> >>>>>>>> Well, I can read/write the device if block protection isn=E2=80=
=99t disabled,
> >>>>>>>> so I guess we can confirm it=E2=80=99s unlocked=E2=80=A6
> >>>>>>>>
> >>>>>>>>>
> >>>>>>>>>>> - is there anything that locks the device by calling mxic_nan=
d_lock()
> >>>>>>>>>>> ?
> >>>>>>>>>
> >>>>>>>>> So nobody locks the device I guess? Did you add traces there?
> >>>>>>>>
> >>>>>>>> It doesn=E2=80=99t get to the point that it enabled the lock/unl=
ock functions
> >>>>>>>> since it fails when checking if feature is 0x38, so there=E2=80=
=99s no point
> >>>>>>>> in adding those traces=E2=80=A6
> >>>>>>>
> >>>>>>> Right, it returns before setting these I guess.
> >>>>>>>
> >>>>>>>>
> >>>>>>>>>
> >>>>>>>>>>> - finding no bbt is one thing, hanging is another, where is i=
t
> >>>>>>>>>>> hanging
> >>>>>>>>>>>     exactly? (offset in nand/ and line in the code)
> >>>>>>>>>>
> >>>>>>>>>> I've got no idea...
> >>>>>>>>>
> >>>>>>>>> You can use ftrace or just add printks a bit everywhere and try=
 to get
> >>>>>>>>> closer and closer.
> >>>>>>>>
> >>>>>>>> I think that after trying to get the feature it just start readi=
ng
> >>>>>>>> nonsense from the NAND and at some point it hangs due to that ga=
rbage=E2=80=A6
> >>>>>>>
> >>>>>>> It should refuse to mount the device somehow, but in no case the =
kernel
> >>>>>>> should hang.
> >>>>>>
> >>>>>> Yes, I think that this is a side effect (maybe a different bug som=
ewhere else).
> >>>>>>
> >>>>>>>
> >>>>>>>> Is it posible that the NAND starts behaving like this after gett=
ing
> >>>>>>>> the feature due to some specific config of my device?
> >>>>>>>>
> >>>>>>>>>
> >>>>>>>>> I looked at the patch, I don't see anything strange. Besides, I=
 have a
> >>>>>>>>> close enough datasheet and I don't see what could confuse the d=
evice.
> >>>>>>>>>
> >>>>>>>>> Are you really sure this patch is the problem? Is the WP pin wi=
red on
> >>>>>>>>> your design?
> >>>>>>>>
> >>>>>>>> There=E2=80=99s no WP pin in brcmnand controllers < 7.0
> >>>>>>>
> >>>>>>> What about the chip?
> >>>>>>
> >>>>>> Maybe it has a GPIO controlling that, but I don=E2=80=99t have tha=
t info=E2=80=A6
> >>>>>>
> >>>>>>>
> >>>>>>> Thanks,
> >>>>>>> Miqu=C3=A8l
> >>>>>>>
> >>
> >> --
> >> Florian
> >>

--
=C3=81lvaro
