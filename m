Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C5776DC7F0
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 16:38:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229840AbjDJOiN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 10:38:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229748AbjDJOiM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 10:38:12 -0400
Received: from xry111.site (xry111.site [89.208.246.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDF4A2D70
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 07:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
        s=default; t=1681137491;
        bh=he6UU8yYdaTIql9YV8y79tAkMBS2BT8Bu40h6/N3/Zw=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=nKObKDzrur0ahiZcC/8m24MvI8iuzzJtZrcsd38bT/ivqJJ9neg4fX3WCmaGx4S1u
         QQCCuZrDNUi6311xdYDpSeUGN7O8LogRURLzUu+E6s6Cw4miG6knYC6syLYzKNMSey
         nth0/bKAobvVTNKyF35swi4G3/p9J+wSgaDS95QE=
Received: from [IPv6:240e:358:1117:7c00:dc73:854d:832e:5] (unknown [IPv6:240e:358:1117:7c00:dc73:854d:832e:5])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-384) server-digest SHA384)
        (Client did not present a certificate)
        (Authenticated sender: xry111@xry111.site)
        by xry111.site (Postfix) with ESMTPSA id D136A65A39;
        Mon, 10 Apr 2023 10:38:06 -0400 (EDT)
Message-ID: <f568fd917bb8789fcef4206e256ef045176605e2.camel@xry111.site>
Subject: Re: [PATCH] LoongArch: Improve memory ops
From:   Xi Ruoyao <xry111@xry111.site>
To:     Rui Wang <wangrui@loongson.cn>
Cc:     Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org, loongson-kernel@lists.loongnix.cn
Date:   Mon, 10 Apr 2023 22:37:56 +0800
In-Reply-To: <CAHirt9jXQcvSQPEFgW6B-qeakcRXGFfd1eYCw2g23Fmu4bbS8g@mail.gmail.com>
References: <20230410115734.93365-1-wangrui@loongson.cn>
         <c90c442fe029bfb9c4487284366800b8781954e1.camel@xry111.site>
         <CAHirt9jXQcvSQPEFgW6B-qeakcRXGFfd1eYCw2g23Fmu4bbS8g@mail.gmail.com>
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

On Mon, 2023-04-10 at 22:19 +0800, Rui Wang wrote:
> On Mon, Apr 10, 2023 at 8:20=E2=80=AFPM Xi Ruoyao <xry111@xry111.site> wr=
ote:
> >=20
> > On Mon, 2023-04-10 at 19:57 +0800, WANG rui wrote:
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* align up address */
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 andi=C2=A0=C2=A0=C2=A0 t1, a0, =
7
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sub.d=C2=A0=C2=A0 a0, a0, t1
> >=20
> > bstrins.d a0, zero, 2, 0
> >=20
> > Likewise for other aligning operations if the temporary is not used.
>=20
> I think we're on the same page. I had previously tested this on the
> user-space version[1], but it's not a performance-critical area.

The point is "if you can reduce one instruction and one register usage
with no harm, why not do it?" :)

AFAIK bstrins.d should be available on all 64-bit LoongArch CPUs.


--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University
