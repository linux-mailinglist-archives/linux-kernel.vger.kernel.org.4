Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44FDB600F9C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 14:58:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230196AbiJQM6i convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 17 Oct 2022 08:58:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230210AbiJQM6c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 08:58:32 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C937C31EC0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 05:58:31 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-314-T0677u4MObuNSCaKuUVJww-1; Mon, 17 Oct 2022 13:58:27 +0100
X-MC-Unique: T0677u4MObuNSCaKuUVJww-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 17 Oct
 2022 13:58:25 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.042; Mon, 17 Oct 2022 13:58:25 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Huacai Chen' <chenhuacai@loongson.cn>,
        Huacai Chen <chenhuacai@kernel.org>
CC:     "loongarch@lists.linux.dev" <loongarch@lists.linux.dev>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH V2] LoongArch: Add unaligned access support
Thread-Topic: [PATCH V2] LoongArch: Add unaligned access support
Thread-Index: AQHY4c+4g3BwiNKgXk2nk+NWr+NpZK4SijAg
Date:   Mon, 17 Oct 2022 12:58:25 +0000
Message-ID: <b8792b1a71754d6eb88debe4d6c2c419@AcuMS.aculab.com>
References: <20221017022330.2383060-1-chenhuacai@loongson.cn>
In-Reply-To: <20221017022330.2383060-1-chenhuacai@loongson.cn>
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
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Huacai Chen
> Sent: 17 October 2022 03:24
> 
> Loongson-2 series (Loongson-2K500, Loongson-2K1000) don't support
> unaligned access in hardware, while Loongson-3 series (Loongson-3A5000,
> Loongson-3C5000) are configurable whether support unaligned access in
> hardware. This patch add unaligned access emulation for those LoongArch
> processors without hardware support.
> 
...
> +	/*
> +	 * This load never faults.
> +	 */
> +	__get_inst(&insn.word, pc, user);

On what basis does it never fault?
Any user access can fault.
If nothing else another thread of the process can unmap
the page.

> +	if (user && !access_ok(addr, 8))
> +		goto sigbus;

Surely that is technically wrong - a two or four byte
access is valid right at the end of valid user addreeses.

> +
> +	if (insn.reg2i12_format.opcode == ldd_op ||
> +		insn.reg2i14_format.opcode == ldptrd_op ||
> +		insn.reg3_format.opcode == ldxd_op) {
> +		res = unaligned_read(addr, &value, 8, 1);

That is the most horrid indentation of long lines I've
ever seen.
I'd also guess you can common up some of this code
by looking at the instruction field that include the
transfer width.

The long elsif list will generate horrid code.
But maybe since you've just taken a fault it really
doesn't matter.
Indeed just emulating in C using byte accesses
it probably fine.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

