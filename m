Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55EA36DC7EC
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 16:37:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbjDJOgz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 10:36:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229861AbjDJOgu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 10:36:50 -0400
Received: from xry111.site (xry111.site [IPv6:2001:470:683e::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE6CD6EBA
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 07:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
        s=default; t=1681137405;
        bh=7Ou+Ia0snPVjCODygIjKbRhpJiBd7TgzfRo2LeXCpN4=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=dYhgOa377ymqvloqAJ/dBdaDbatV1kYqiNLnYBpeTr77mS01SVWX1PFiFeqH4Ic1J
         6qbj3mTsyQ65sA+PuPFxWGo0mroRTEApyDTGO0dMYXELPHMXGJ8ysoMV+OWMy40oAd
         XOmHzjkNFu6GCtM84K4/Tk94SA09kTgCfGnR2tRo=
Received: from [IPv6:240e:358:1117:7c00:dc73:854d:832e:5] (unknown [IPv6:240e:358:1117:7c00:dc73:854d:832e:5])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-384) server-digest SHA384)
        (Client did not present a certificate)
        (Authenticated sender: xry111@xry111.site)
        by xry111.site (Postfix) with ESMTPSA id 7DF4165A30;
        Mon, 10 Apr 2023 10:36:40 -0400 (EDT)
Message-ID: <8aeb6d8dc4cbe8c992b69d75d8953d59b71a2c38.camel@xry111.site>
Subject: Re: [PATCH] LoongArch: Improve memory ops
From:   Xi Ruoyao <xry111@xry111.site>
To:     Rui Wang <wangrui@loongson.cn>
Cc:     Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org, loongson-kernel@lists.loongnix.cn
Date:   Mon, 10 Apr 2023 22:36:26 +0800
In-Reply-To: <CAHirt9ib2LPXMbxb+UCJB1MsBnUuWNLb5+uyqcR5Wiw2fsJi6w@mail.gmail.com>
References: <20230410115734.93365-1-wangrui@loongson.cn>
         <b80e083baa49f0443abee66eb888fac920f66e79.camel@xry111.site>
         <CAHirt9ib2LPXMbxb+UCJB1MsBnUuWNLb5+uyqcR5Wiw2fsJi6w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.0 
MIME-Version: 1.0
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2023-04-10 at 22:22 +0800, Rui Wang wrote:
> On Mon, Apr 10, 2023 at 8:54=E2=80=AFPM Xi Ruoyao <xry111@xry111.site> wr=
ote:
> > Regarding these functions: we have -ffreestanding which is
> > preventing
> > the compiler from optimizing for e.g. "memcpy(a, b, 8);" into a
> > simple
> > ld.d/st.d pair.=C2=A0 A explicit compiler built-in usage like
> >=20
> > =C2=A0 #define memcpy(a, b, c) __builtin_memcpy(a, b, c)
> >=20
> > would allow the compiler to do such kind of optimization.=C2=A0=C2=A0 W=
ill
> > this
> > improve the performance?
>=20
> That's a good question. IIUC, the current compiler generates
> inefficient code for constant-length memcpy, which may sacrifice
> performance for compatibility, as not all hardware supports unaligned
> memory access. We need a runtime CPU feature dispatch mechanism
> similar to alternatives to improve the compiler. This is indeed a
> problem that needs to be addressed.

Hmm, yep, GCC does not take the advantage of -mstrict-align expanding
memcpy etc.  I'll add it into my TODO list for GCC 14.


--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University
