Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4763629C1D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 15:28:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbiKOO21 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 09:28:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238102AbiKOO2N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 09:28:13 -0500
Received: from xry111.site (xry111.site [89.208.246.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28BC62CE3B
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 06:28:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
        s=default; t=1668522482;
        bh=CeyaCZ4ZqESTcFuuIbk+8CdMbl4qa+2NQGZoRczkRVI=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=ZgxDus/XA3Zgnzv4ht07ANinJ+SQtjX1m6Ev/Jn0fF2NAkZHvFEen2OtnjUZ1qoYw
         dJ6IKt0oTRWBEKQewWrsX5scbgQZDlFUiXrxnBEEKUJgCis6GnZS32izTShC0A2kiC
         mcgdfwSXtAsI4dlPCnqT1oN7EYXNsZ56HtBVxoeI=
Received: from localhost.localdomain (xry111.site [IPv6:2001:470:683e::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-384) server-digest SHA384)
        (Client did not present a certificate)
        (Authenticated sender: xry111@xry111.site)
        by xry111.site (Postfix) with ESMTPSA id 4BE5D66876;
        Tue, 15 Nov 2022 09:28:01 -0500 (EST)
Message-ID: <7e606e2c3df5d727a6c69b74a803d9f2c8e717b0.camel@xry111.site>
Subject: Re: [PATCH] LoongArch: Makefile: use "grep -E" instead of "egrep"
From:   Xi Ruoyao <xry111@xry111.site>
To:     Tiezhu Yang <yangtiezhu@loongson.cn>,
        Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>
Cc:     loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
Date:   Tue, 15 Nov 2022 22:27:59 +0800
In-Reply-To: <1668506549-28261-1-git-send-email-yangtiezhu@loongson.cn>
References: <1668506549-28261-1-git-send-email-yangtiezhu@loongson.cn>
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

On Tue, 2022-11-15 at 18:02 +0800, Tiezhu Yang wrote:
> The latest version of grep claims the egrep is now obsolete so the
> build
> now contains warnings that look like:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0egrep: warning: egrep is =
obsolescent; using grep -E
> fix this up by moving the LoongArch Makefile to use "grep -E" instead.

For future reference: this warning message is imprecise because on some
non-POSIX platforms grep does not support -E (see "Limitations of Usual
Tools" in autoconf info page).

However (1) we are already using -w, which is not guaranteed to be
supported as well; (2) I don't think anyone will build LoongArch kernel
on such an old non-POSIX system.

So LGTM.

> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> ---
> =C2=A0arch/loongarch/Makefile | 2 +-
> =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/arch/loongarch/Makefile b/arch/loongarch/Makefile
> index a0fc1f9..5232d8c 100644
> --- a/arch/loongarch/Makefile
> +++ b/arch/loongarch/Makefile
> @@ -97,7 +97,7 @@ KBUILD_LDFLAGS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0+=3D -m $(ld-emul)
> =C2=A0
> =C2=A0ifdef CONFIG_LOONGARCH
> =C2=A0CHECKFLAGS +=3D $(shell $(CC) $(KBUILD_CFLAGS) -dM -E -x c /dev/nul=
l |
> \
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0egrep -vw '__GNUC_(MINOR_|PATC=
HLEVEL_)?_' | \
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0grep -E -vw '__GNUC_(MINOR_|PA=
TCHLEVEL_)?_' | \
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0sed -e "s/^\#define /-D'/=
" -e "s/ /'=3D'/" -e "s/$$/'/" -e
> 's/\$$/&&/g')
> =C2=A0endif
> =C2=A0

--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University
