Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA57173D4A4
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 23:42:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbjFYVmS convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 25 Jun 2023 17:42:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjFYVmP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 17:42:15 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2577BA
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 14:42:13 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-264-__5NTeNUOTOunLze3S7Sqw-1; Sun, 25 Jun 2023 22:42:09 +0100
X-MC-Unique: __5NTeNUOTOunLze3S7Sqw-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sun, 25 Jun
 2023 22:42:08 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Sun, 25 Jun 2023 22:42:08 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Evan Green' <evan@rivosinc.com>,
        Palmer Dabbelt <palmer@rivosinc.com>
CC:     Simon Hosie <shosie@rivosinc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Andy Chiu <andy.chiu@sifive.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        Guo Ren <guoren@kernel.org>,
        "Heiko Stuebner" <heiko.stuebner@vrull.eu>,
        Jisheng Zhang <jszhang@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Ley Foon Tan <leyfoon.tan@starfivetech.com>,
        Li Zhengyu <lizhengyu3@huawei.com>,
        "Masahiro Yamada" <masahiroy@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        "Paul Walmsley" <paul.walmsley@sifive.com>,
        Sia Jee Heng <jeeheng.sia@starfivetech.com>,
        Sunil V L <sunilvl@ventanamicro.com>,
        Xianting Tian <xianting.tian@linux.alibaba.com>,
        Yangyu Chen <cyy@cyyself.name>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>
Subject: RE: [PATCH 1/2] RISC-V: Probe for unaligned access speed
Thread-Topic: [PATCH 1/2] RISC-V: Probe for unaligned access speed
Thread-Index: AQHZpiD8K74IXZi1x0Sk5pxi8WFXO6+cDCdw
Date:   Sun, 25 Jun 2023 21:42:07 +0000
Message-ID: <88d0b61ca01d4c1a87a17d3c34baa2a6@AcuMS.aculab.com>
References: <20230623222016.3742145-1-evan@rivosinc.com>
 <20230623222016.3742145-2-evan@rivosinc.com>
In-Reply-To: <20230623222016.3742145-2-evan@rivosinc.com>
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
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Evan Green
> Sent: 23 June 2023 23:20
> 
> Rather than deferring misaligned access speed determinations to a vendor
> function, let's probe them and find out how fast they are. If we
> determine that a misaligned word access is faster than N byte accesses,
> mark the hardware's misaligned access as "fast".
> 
> Fix the documentation as well to reflect this bar. Previously the only
> SoC that returned "fast" was the THead C906. The change to the
> documentation is more a clarification, since the C906 is fast in the
> sense of the corrected documentation.
> 
> Signed-off-by: Evan Green <evan@rivosinc.com>
> ---
...
> diff --git a/Documentation/riscv/hwprobe.rst b/Documentation/riscv/hwprobe.rst
> index 19165ebd82ba..710325751766 100644
> --- a/Documentation/riscv/hwprobe.rst
> +++ b/Documentation/riscv/hwprobe.rst
> @@ -88,12 +88,12 @@ The following keys are defined:
>      always extremely slow.
> 
>    * :c:macro:`RISCV_HWPROBE_MISALIGNED_SLOW`: Misaligned accesses are supported
> -    in hardware, but are slower than the cooresponding aligned accesses
> -    sequences.
> +    in hardware, but are slower than N byte accesses, where N is the native
> +    word size.
> 
>    * :c:macro:`RISCV_HWPROBE_MISALIGNED_FAST`: Misaligned accesses are supported
> -    in hardware and are faster than the cooresponding aligned accesses
> -    sequences.
> +    in hardware and are faster than N byte accesses, where N is the native
> +    word size.

I think I'd just say 'faster/slower than using byte accesses' (ie no N).

There are two obvious FAST cases:
1) the misaligned access takes an extra clock - worth aligning copies.
2) the misaligned access is pretty much as fast as an aligned one.

Even if you find it hard to distinguish them you should probably
allow for them both.

x86 (on Intel (non-atom) cpu) is definitely in the latter camp.
Misaligned copies are measurable slower - but not enough to
ever worry about.
I think that misaligned transfers get spilt into 8 byte accesses
(pretty irrelevant in the kernel) and then accesses that cross
cache line boundaries are split on the boundary.
With pipelined writes and two reads/clock it doesn't often
make a measurable difference.
That is definitely what I see for uncached accesses to PCIe space.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

