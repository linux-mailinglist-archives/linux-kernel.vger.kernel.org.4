Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EC976E8915
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 06:25:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233189AbjDTEZM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 00:25:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230102AbjDTEZI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 00:25:08 -0400
Received: from xry111.site (xry111.site [IPv6:2001:470:683e::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 240DF3595
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 21:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
        s=default; t=1681964704;
        bh=aEPfD0trpMn7W25y1e2mB2PhdQNis7pBZZFMp4rqK4A=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=QbiTd7RS0MITH1klrYTy2x7SHsCY8/Yw+Mew8fpbrlUrpVk6imGJyEUkoLsKgwRjz
         eTXc6BTl4inoRsPLdWk4qwmCo5adgx793jbidRv6/cAFDbaD/4HplWRpaEZhXe4JeZ
         Stdu5tGsxO8vXEs00/zikw95wDnlQCGcCSHGD9ag=
Received: from [IPv6:240e:358:116f:3d00:dc73:854d:832e:2] (unknown [IPv6:240e:358:116f:3d00:dc73:854d:832e:2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-384) server-digest SHA384)
        (Client did not present a certificate)
        (Authenticated sender: xry111@xry111.site)
        by xry111.site (Postfix) with ESMTPSA id 40B24663E3;
        Thu, 20 Apr 2023 00:24:59 -0400 (EDT)
Message-ID: <51051bd7e42378cdf465494389ab76a30ca3acf2.camel@xry111.site>
Subject: Re: [PATCH 1/2] LoongArch: Add pad structure members for explicit
 alignment
From:   Xi Ruoyao <xry111@xry111.site>
To:     Qing Zhang <zhangqing@loongson.cn>,
        WANG Xuerui <kernel@xen0n.name>,
        Huacai Chen <chenhuacai@kernel.org>
Cc:     Jiaxun Yang <jiaxun.yang@flygoat.com>, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org
Date:   Thu, 20 Apr 2023 12:24:55 +0800
In-Reply-To: <111c1e81-dfae-4388-9fc6-a3f247641398@loongson.cn>
References: <20230418091348.9239-1-zhangqing@loongson.cn>
         <a7fa32c3af68083855e7690f67824d060d5c6135.camel@xry111.site>
         <899085c1-7a74-8bab-1429-1b6e9e4c2c30@xen0n.name>
         <48bc7236-638d-9086-daaf-62eacea80dd2@xen0n.name>
         <111c1e81-dfae-4388-9fc6-a3f247641398@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.0 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2023-04-20 at 10:14 +0800, Qing Zhang wrote:
> > > Ah right. This is UAPI so without *very* concrete and convicing reaso=
n=20
> > > why the change is not going to impact any potential users, it's gonna=
=20
> > > be a presumed NAK. In other words you must demonstrate (1) why it's=
=20
> > > absolutely necessary to make the change and (2) that it's impossible=
=20
> > > to impact anyone, before any such changes can even be considered.
> > Please ignore all of this. The memory layout is actually the same after=
=20
> > the change due to the padding, I was somehow thinking in big-endian a=
=20
> > few hours ago.

No.  The problem is not related to big endian or little endian.=20
Changing the type of this field *can* turn valid user code into
undefined behavior.  `printf(PRIu16 "\n", ptr->dbg_info);` is an
undefined behavior if ptr->dbg_info is a int16_t, because the standard
says so, not because the machine may be big endian.

It is a rare case where the ABI is backward-compatible but the API is
incompatible.

Why not just insert "int16_t pad1[3];" after dbg_info?

> > (The commit message didn't help either, I think both=20
> > Ruoyao and me got into the habitual thinking that changes like this are=
=20
> > most likely just churn without real benefits, after *not* seeing the
> > rationale in the commit message which was kinda expected.)
> > >=20
>=20
> This patch does not change the size of the structure. The structure
> itself is implicitly aligned. We changed it to explicit alignment for
> the convenience of hw_break_get/set (using membuf.left) to calculate the
> offset and prevent breaks. Count overflow.
>=20
> With pad explicit alignment, after membuf_write(&to, &info,=20
> sizeof(info)); to.left=3D200-8 bytes,
> Thus,
> membuf_store(&to, addr);
> membuf_store(&to, mask);
> membuf_store(&to, ctrl);
> membuf_zero(&to, sizeof(u32));
> After that, to.left is decremented by 24 bytes each time,
> so the number of breakpoints will not overflow.
>=20
> The user support code has not been submitted to the upstream, so
> the current uapi change has no effect.

The problem is once we put a header into the UAPI directory and make a
Linux kernel release, people may start to use it (maybe in a way we
don't expected).

--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University
