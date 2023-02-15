Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FF006975E4
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 06:36:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbjBOFgN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 00:36:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbjBOFgL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 00:36:11 -0500
Received: from xry111.site (xry111.site [IPv6:2001:470:683e::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D1612A9A5
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 21:36:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
        s=default; t=1676439367;
        bh=rVyZAFFRh7e/R88WQ0bLxVMue6cqCoIBHLnwDLoBYqA=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=dX/daGUGivN0y6yEX4yhthTptihmU5h3T7aaehDQeiSKw2GGfJqGQYB82/OxMJT2j
         qy6PltM1z8OFV5nr/7ZWzTKJmh2q8qIYH8kjx6BaLgYZP1Daf/f9Ki02muxgSQpYyv
         AEmEygft9BGUG8eS6TAM4t0VNREO7hMwLCOdzpuE=
Received: from [IPv6:240e:456:1020:352:6860:35c9:52f4:b84b] (unknown [IPv6:240e:456:1020:352:6860:35c9:52f4:b84b])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-384) server-digest SHA384)
        (Client did not present a certificate)
        (Authenticated sender: xry111@xry111.site)
        by xry111.site (Postfix) with ESMTPSA id 95DAA667C4;
        Wed, 15 Feb 2023 00:36:02 -0500 (EST)
Message-ID: <511d385675ea7a846ff791974c6ae7feeeec2589.camel@xry111.site>
Subject: Re: "kernel ade access" oops on LoongArch
From:   Xi Ruoyao <xry111@xry111.site>
To:     Youling Tang <tangyouling@loongson.cn>
Cc:     loongarch@lists.linux.dev, Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>, linux-kernel@vger.kernel.org
Date:   Wed, 15 Feb 2023 13:35:56 +0800
In-Reply-To: <2e902dfa-cb84-7ef0-6b50-02b16354a139@loongson.cn>
References: <1e6f4d35946e4e2e7c7f5dcc7b69d5e609de8184.camel@xry111.site>
         <2e902dfa-cb84-7ef0-6b50-02b16354a139@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2023-02-15 at 12:52 +0800, Youling Tang wrote:
> ../stdlib/stdlib.h:141:8: error: =E2=80=98_Float32=E2=80=99 does not name=
 a type
> =C2=A0=C2=A0 141 | extern _Float32 strtof32 (const char *__restrict __npt=
r,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 ^~~~~~~~

This is because Glibc expects GCC 13 to support _Float32, but early GCC
13 snapshots did not.

> /usr/bin/ld: /home/loongson/build_glibc/libc.a(dl-reloc-static-pie.o):
> in function `_dl_relocate_static_pie':
> /home/loongson/glibc/elf/dl-reloc-static-pie.c:44: undefined reference
> to `_DYNAMIC'

Oh, this one is my fault.  The check for compiler static PIE support was
not written correctly.  I'll fix it for Glibc later, but now you can
update GCC to the latest git master to proceed.
--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University
