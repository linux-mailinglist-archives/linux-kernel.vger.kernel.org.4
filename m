Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E0E76475ED
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 20:05:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230044AbiLHTFI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 14:05:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiLHTEd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 14:04:33 -0500
Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [IPv6:2a01:e0c:1:1599::10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69FC39E479
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 11:04:18 -0800 (PST)
Received: from sopl295-1.home (unknown [IPv6:2a01:cb19:8d70:d500:6d47:7868:523:4848])
        (Authenticated sender: robert.jarzmik@free.fr)
        by smtp1-g21.free.fr (Postfix) with ESMTPSA id D76F3B00539;
        Thu,  8 Dec 2022 20:04:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
        s=smtp-20201208; t=1670526254;
        bh=iwmUCqNvez/sBNbZco4atcZtBLGp04PAWI4ReNtX7DM=;
        h=References:From:To:Cc:Subject:Date:In-reply-to:From;
        b=fBPjrED7yqLODhwUboEeGob4khRc7r+Q4LbikUhyLLzaHwRbit9tD13oWwNPdK1mC
         JVlat2KMaRHcJZLQo2NY07aZ0zs9pu5r+6WunZKGSdieN53RZL2c/63fVQfjBSAon9
         zHLQqrA9CqG7gTLvk+cKO+zcBp9Nn6P2ME2u4h6Joq/NCwbVpgw93gnUO3lNWt5vPG
         zov4COXLvsyOHPy0VpdsVx6l441MZizKkwSrZv7UaREisKeB8Ml65xnqf+mMBBO4IX
         n7Cev4e0PC3qE0CSdx50vufbSlBOcRMvVQ+D0tY7XWKXcDBdBnk+x0TZN3twLH/YmD
         d/rrRXWjYK+zQ==
References: <Y5B4QeNMNboJ42n4@probook> <Y5CxBzy47Gjn/V5a@lunn.ch>
 <Y5C0F/o4JS5MwkkJ@shell.armlinux.org.uk> <Y5DDCmXnamC6Zikx@probook>
 <Y5DbKNI3e+tFA++1@shell.armlinux.org.uk> <Y5IulKoRctcrWBzl@probook>
User-agent: mu4e 1.8.11; emacs 28.1
From:   Robert Jarzmik <robert.jarzmik@free.fr>
To:     Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Cc:     "Russell King (Oracle)" <linux@armlinux.org.uk>,
        Andrew Lunn <andrew@lunn.ch>,
        linux-arm-kernel@lists.infradead.org,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Daniel Mack <daniel@zonque.org>, linux-kernel@vger.kernel.org
Subject: Re: PXA25x: GPIO driver fails probe due to resource conflict with
 pinctrl driver
Date:   Thu, 08 Dec 2022 19:46:26 +0100
In-reply-to: <Y5IulKoRctcrWBzl@probook>
Message-ID: <m2wn71emze.fsf@sopl295-1.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net> writes:

> Without further code changes this wouldn't be sufficient,=20
> because the
> pinctrl driver also touches the GPIO direction registers at=20
> offset
> 0x0c-0x14.

Historically, this problem was adressed by a "hack" if I remember=20
correctly, as the
registers do overlap (on pxa27x at least, but I think on pxa25x as=20
well) :
- GAFR (alternate functions) and GPDR (input or output) are=20
  "pinctrl"
- GPSR, GPCR, GPLR are "gpio" registers
- the memory map (physical) at 0x40e0 0000 is as Jonathan wrote :
  - 3 u32 GPLR (gpio)
  - 3 u32 GPDR (pinctrl)
  - 3 u32 GPSR (gpio)
  - 3 u32 GPCR (gpio)

The "hack" was that one driver was mapping the area _without_=20
claiming it (this
is part from memory, I didn't check in the code today). The gpio=20
was probably
the claiming one, while the pinctrl was the "only using one".

As of today, I should have a look what was changed, but I'm pretty=20
sure in all
pxa2xx architecture there is an overlap, as for these ancient=20
platforms the
pinctrl wasn't yet separated from the gpio IC.

The only was out so far I can see from my head would be to declare=20
multiple
very small IO ranges :
- pinctrl pxa25x : 0x40e0 000c (12 bytes), 0x40e0 0054 (32 bytes)
- pinctrl pxa25x : 0x40e0 000c (12 bytes), 0x40e0 0054 (32 bytes),=20
  0x40e0 010c (4 bytes)
- gpio : from 0x40e0 0000 to 0x40e0 0070 included, without the=20
  pinctrl ones

As a general guide, in gpio-pxa.c, you have the table in=20
[1]. Think GPDR and GAFR as
pinctrl, and all the other ones as gpio. Ah and yes, the GAFR ones=20
are missing in this
table.

One last think : in a pre device-tree world, when we didn't had=20
yet the pxa pinctrl
driver, the gpio driver was directly playing with the GPDR=20
registers, fun old times.

Cheers.

--
Robert

[1]
/*
 * We handle the GPIOs by banks, each bank covers up to 32 GPIOs=20
 with
 * one set of registers. The register offsets are organized below:
 *
 *           GPLR    GPDR    GPSR    GPCR    GRER    GFER    GEDR
 * BANK 0 - 0x0000  0x000C  0x0018  0x0024  0x0030  0x003C  0x0048
 * BANK 1 - 0x0004  0x0010  0x001C  0x0028  0x0034  0x0040  0x004C
 * BANK 2 - 0x0008  0x0014  0x0020  0x002C  0x0038  0x0044  0x0050
 *
 * BANK 3 - 0x0100  0x010C  0x0118  0x0124  0x0130  0x013C  0x0148
 * BANK 4 - 0x0104  0x0110  0x011C  0x0128  0x0134  0x0140  0x014C
 * BANK 5 - 0x0108  0x0114  0x0120  0x012C  0x0138  0x0144  0x0150
 *
 * BANK 6 - 0x0200  0x020C  0x0218  0x0224  0x0230  0x023C  0x0248
 *
 * NOTE:
 *   BANK 3 is only available on PXA27x and later processors.
 *   BANK 4 and 5 are only available on PXA935, PXA1928
 *   BANK 6 is only available on PXA1928
 */

