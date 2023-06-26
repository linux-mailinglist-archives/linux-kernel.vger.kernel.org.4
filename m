Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A598873DB5A
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 11:27:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229657AbjFZJ1l convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 26 Jun 2023 05:27:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbjFZJ1R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 05:27:17 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58CB0173C
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 02:24:41 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-254-bXN7M5eWPfeft9XssNQwlg-1; Mon, 26 Jun 2023 10:24:38 +0100
X-MC-Unique: bXN7M5eWPfeft9XssNQwlg-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Mon, 26 Jun
 2023 10:24:36 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Mon, 26 Jun 2023 10:24:36 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Yangyu Chen' <cyy@cyyself.name>,
        "evan@rivosinc.com" <evan@rivosinc.com>
CC:     "ajones@ventanamicro.com" <ajones@ventanamicro.com>,
        "alexghiti@rivosinc.com" <alexghiti@rivosinc.com>,
        "andy.chiu@sifive.com" <andy.chiu@sifive.com>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "apatel@ventanamicro.com" <apatel@ventanamicro.com>,
        "conor.dooley@microchip.com" <conor.dooley@microchip.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "greentime.hu@sifive.com" <greentime.hu@sifive.com>,
        "guoren@kernel.org" <guoren@kernel.org>,
        "heiko.stuebner@vrull.eu" <heiko.stuebner@vrull.eu>,
        "heiko@sntech.de" <heiko@sntech.de>,
        "jeeheng.sia@starfivetech.com" <jeeheng.sia@starfivetech.com>,
        "jszhang@kernel.org" <jszhang@kernel.org>,
        "leyfoon.tan@starfivetech.com" <leyfoon.tan@starfivetech.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "lizhengyu3@huawei.com" <lizhengyu3@huawei.com>,
        "masahiroy@kernel.org" <masahiroy@kernel.org>,
        "palmer@dabbelt.com" <palmer@dabbelt.com>,
        "palmer@rivosinc.com" <palmer@rivosinc.com>,
        "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "samuel@sholland.org" <samuel@sholland.org>,
        "shosie@rivosinc.com" <shosie@rivosinc.com>,
        "sunilvl@ventanamicro.com" <sunilvl@ventanamicro.com>,
        "xianting.tian@linux.alibaba.com" <xianting.tian@linux.alibaba.com>
Subject: RE: [PATCH 0/2] RISC-V: Probe for misaligned access speed
Thread-Topic: [PATCH 0/2] RISC-V: Probe for misaligned access speed
Thread-Index: AQHZpoXPPuZN4PqkvUikwrb+zgw4aa+c0l/Q
Date:   Mon, 26 Jun 2023 09:24:36 +0000
Message-ID: <253bad9e83cd4890b29dd89a3d5a1937@AcuMS.aculab.com>
References: <20230623222016.3742145-1-evan@rivosinc.com>
 <tencent_817CE182DEDA938E03B848314821098D4408@qq.com>
In-Reply-To: <tencent_817CE182DEDA938E03B848314821098D4408@qq.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yangyu Chen
> Sent: 24 June 2023 11:22
> 
> Hi,
> 
> Thanks for doing this.
> 
> On 6/24/23 6:20 AM, Evan Green wrote:
> > I don't have a machine where misaligned accesses are slow, but I'd be
> > interested to see the results of booting this series if someone did.
> 
> I have tested your patches on a 100MHz BigCore rocket-chip with opensbi running on FPGA with
> 72bit(64bit+ECC) DDR3 1600MHz memory. As the rocket-chip did not support misaligned memory access,
> every misaligned memory access will trap and emulated by SBI.
> 
> Here is the result:
...
> ~ # dmesg | grep Unaligned
> [    0.210140] cpu1: Unaligned word copy 0 MB/s, byte copy 38 MB/s, misaligned accesses are slow
> [    0.410715] cpu0: Unaligned word copy 0 MB/s, byte copy 35 MB/s, misaligned accesses are slow

How many misaligned cycles are in the test loop?
If emulated ones are that slow you pretty much only need to test one.

Also it is pretty clear that you really don't want to be emulating them.
If the emulation is hidden from the kernel that really doesn't help at all.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

