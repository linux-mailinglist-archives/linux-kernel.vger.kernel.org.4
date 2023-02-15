Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21CD9697847
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 09:35:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233682AbjBOIfz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 03:35:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231318AbjBOIfx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 03:35:53 -0500
Received: from xry111.site (xry111.site [89.208.246.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFF571714
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 00:35:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
        s=default; t=1676450152;
        bh=aeCaZTywnvyPpOh5hq1MIC1AtZSHOdv/UnWhSsc1LKA=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=GiTybQpWJuIjq/Yerv3jiq8E26VeQwDQky1vGf7yVsddNMVDUCcJ4LYgaSGcWs3aq
         K89mMIWYWP42P8NEtpgpB1rMB3xkKei4csWbdUbZPaK68Bfl9ZpFhBousXyOUA4JFV
         sTHp93mZBTjvc/9i3Ka3DJ9SsYENMgU7MpImVqJ8=
Received: from [IPv6:240e:456:1020:352:6860:35c9:52f4:b84b] (unknown [IPv6:240e:456:1020:352:6860:35c9:52f4:b84b])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-384))
        (Client did not present a certificate)
        (Authenticated sender: xry111@xry111.site)
        by xry111.site (Postfix) with ESMTPSA id 67BB865F24;
        Wed, 15 Feb 2023 03:35:46 -0500 (EST)
Message-ID: <21b0e60dac8bedf9e389645ec103aa4241b35f8d.camel@xry111.site>
Subject: Re: "kernel ade access" oops on LoongArch
From:   Xi Ruoyao <xry111@xry111.site>
To:     Youling Tang <tangyouling@loongson.cn>
Cc:     Jinyang He <hejinyang@loongson.cn>, loongarch@lists.linux.dev,
        Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>, linux-kernel@vger.kernel.org
Date:   Wed, 15 Feb 2023 16:35:43 +0800
In-Reply-To: <74fb1e24-36c0-c642-5bab-3646ba7790df@loongson.cn>
References: <1e6f4d35946e4e2e7c7f5dcc7b69d5e609de8184.camel@xry111.site>
         <2e902dfa-cb84-7ef0-6b50-02b16354a139@loongson.cn>
         <511d385675ea7a846ff791974c6ae7feeeec2589.camel@xry111.site>
         <9a70e89c-0f3b-0660-501e-3292e410cfd8@loongson.cn>
         <5403e5eb-5792-7d6f-df74-ca3fab82ecd5@loongson.cn>
         <818419c03037bda833a5b281588a4b331c34ae8c.camel@xry111.site>
         <74fb1e24-36c0-c642-5bab-3646ba7790df@loongson.cn>
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

On Wed, 2023-02-15 at 16:25 +0800, Youling Tang wrote:
> Can you modify the kernel as follows and test it, so as to avoid
> possible relationship with the exception table data link position and
> alignment rules (or use EXCEPTION_TABLE(12))?
>=20
> --- a/arch/loongarch/kernel/vmlinux.lds.S
> +++ b/arch/loongarch/kernel/vmlinux.lds.S
> @@ -4,7 +4,6 @@
> =C2=A0 #include <asm/thread_info.h>
>=20
> =C2=A0 #define PAGE_SIZE _PAGE_SIZE
> -#define RO_EXCEPTION_TABLE_ALIGN=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 4
>=20
> =C2=A0 /*
> =C2=A0=C2=A0 * Put .bss..swapper_pg_dir as the first thing in .bss. This =
will
> @@ -54,6 +53,8 @@ SECTIONS
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 . =3D ALIGN(PECOFF_SEGME=
NT_ALIGN);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 _etext =3D .;
>=20
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 EXCEPTION_TABLE(16)
> +

It seems the kernel refuses to boot after the change, but I'm not
completely sure: I'm 5 km away from the board and operating it via ssh
so maybe it's a reboot failure or network failure.  I'll report again in
the evening.

--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University
