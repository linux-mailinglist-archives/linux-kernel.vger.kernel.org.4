Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 045D0600882
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 10:14:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbiJQIO3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 04:14:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230154AbiJQIOT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 04:14:19 -0400
Received: from xry111.site (xry111.site [89.208.246.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7EF65C9E9
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 01:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
        s=default; t=1665994439;
        bh=aUH/XHGaJbH5Gior3HdfSfhEBDSg2UQ+BopOfkKJaP8=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=CT60EdmAYb4CCgDZrqx+T7ZRav7AUSN35MF5alxZR2b2HlSI4ihvy0zfwhZCEMSGc
         3DtqUl/lEABUu5OwyQP06g866G9jB0xi8Ii0zWFJ0R5CxrvUDWK81Dnq/lUA7vSVLR
         AMIbSF4UI3rufVN1gfk2aDlJtvqZkT71i/dHDoIc=
Received: from [IPv6:240e:358:1124:a900:dc73:854d:832e:3] (unknown [IPv6:240e:358:1124:a900:dc73:854d:832e:3])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-384) server-digest SHA384)
        (Client did not present a certificate)
        (Authenticated sender: xry111@xry111.site)
        by xry111.site (Postfix) with ESMTPSA id 3EF7565A8B;
        Mon, 17 Oct 2022 04:13:53 -0400 (EDT)
Message-ID: <514ccb3b1a2fbd37f238f169eef0f40c89d3e3dd.camel@xry111.site>
Subject: Re: [PATCH] LoongArch: Add unaligned access support
From:   Xi Ruoyao <xry111@xry111.site>
To:     Arnd Bergmann <arnd@arndb.de>, Huacai Chen <chenhuacai@kernel.org>
Cc:     Huacai Chen <chenhuacai@loongson.cn>, loongarch@lists.linux.dev,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        guoren <guoren@kernel.org>, WANG Xuerui <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-kernel@vger.kernel.org
Date:   Mon, 17 Oct 2022 16:13:47 +0800
In-Reply-To: <b97afda4-143c-46d2-a6af-dd6a700472ec@app.fastmail.com>
References: <20221016133418.2122777-1-chenhuacai@loongson.cn>
         <506fe4e5-a203-48e6-84a6-f70133be15dd@app.fastmail.com>
         <CAAhV-H7UJDgtY4NfF7-5+TbNEbec7XOpvS87H=fPad4KK0KLaw@mail.gmail.com>
         <b97afda4-143c-46d2-a6af-dd6a700472ec@app.fastmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.0 
MIME-Version: 1.0
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_SUSPICIOUS_NTLD,
        PDS_OTHER_BAD_TLD,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-10-17 at 09:38 +0200, Arnd Bergmann wrote:

> > Some unaligned accesses are observed from the kernel network stack, it
> > seems related to whether the packet aligns to IP header or MAC header.
>=20
> This is usually a bug in the device driver. It's a fairly common bug
> since the network driver has to ensure the alignment is correct, but
> it's usually fixable, and fixing it results in better performance on
> machines that support unaligned access as well.

Or, maybe a GCC bug is causing -mstrict-align not implemented correctly.

> > And, gcc has a -mstrict-align parameter, if without this, there are
> > unaligned instructions.
>=20
> Does this default to strict or non-strict mode? Usually gcc does not
> allow to turn this off on architectures that have no hardware support
> for unaligned access.

On LoongArch the unaligned access support is optional.  An
implementation is allowed to implement it or not.  The software can
determine if it's supported by a CPUCFG instruction.

I think -march=3Dla264 will turn off strict align, but it's not added into
GCC yet.

The GCC default is -mno-strict-align.  I expressed my concern about this
decision when I reviewed the GCC port, but at last they just kept the
decision.  But the kernel already sets -mstrict-align in CFLAGS anyway.

--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University
