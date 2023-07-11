Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 101F074F032
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 15:32:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232082AbjGKNcg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 09:32:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbjGKNce (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 09:32:34 -0400
Received: from xry111.site (xry111.site [89.208.246.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CD5CE6C
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 06:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
        s=default; t=1689082352;
        bh=VC99mbHi4AmfAoiUCA8Y/mu2KyCyRbtpGMBesSFehV8=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=HoA7CsT1lVhUWuNRJBPiVYZjP/ouAsdDBcUtop5f1RKE5K4tafMAuur15O36Otun2
         E9CFIKJb28YZ7uVgrv52WBxecSGMitHbwSjY6KezRmR2UQVaay196vVxLkbl+yB/24
         awaWu4iDHTjrSONzXNhcXgHbwImPVmYpBZFvUf0Y=
Received: from [192.168.124.11] (unknown [113.140.11.5])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-384))
        (Client did not present a certificate)
        (Authenticated sender: xry111@xry111.site)
        by xry111.site (Postfix) with ESMTPSA id 0C35566455;
        Tue, 11 Jul 2023 09:32:30 -0400 (EDT)
Message-ID: <d8e2e93e6cf07846621b15104ce89b430ee8426f.camel@xry111.site>
Subject: Re: [PATCH v2] LOONGARCH: Make CONFIG_CMDLINE work with
 CONFIG_CMDLINE_EXTEND and CONFIG_CMDLINE_BOOTLOADER
From:   Xi Ruoyao <xry111@xry111.site>
To:     Dong Zhihong <donmor3000@hotmail.com>, chenhuacai@kernel.org,
        kernel@xen0n.name
Cc:     ardb@kernel.org, tangyouling@loongson.cn, zhoubinbin@loongson.cn,
        yangtiezhu@loongson.cn, tglx@linutronix.de,
        loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
Date:   Tue, 11 Jul 2023 21:32:29 +0800
In-Reply-To: <MEYP282MB2597022C264B501FE1B9C40AD931A@MEYP282MB2597.AUSP282.PROD.OUTLOOK.COM>
References: <MEYP282MB2597022C264B501FE1B9C40AD931A@MEYP282MB2597.AUSP282.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use "LoongArch" instead of "LOONGARCH".  "LOONGARCH" should only show up
in macro names, enum value names, etc.

On Tue, 2023-07-11 at 21:27 +0800, Dong Zhihong wrote:
> This patch tends to make CONFIG_CMDLINE work with CONFIG_CMDLINE_EXTEND

As Markus already told you, submitting-patches.rst says:

"Describe your changes in imperative mood, e.g. "make xyzzy do frotz"
instead of "[This patch] makes xyzzy do frotz" or "[I] changed xyzzy
to do frotz", as if you are giving orders to the codebase to change
its behaviour."

i. e. "Make CONFIG_CMDLINE work with ...".

> and CONFIG_CMDLINE_BOOTLOADER. The touched function is bootcmdline_init()=
`.
> There's already code handling CONFIG_CMDLINE_FORCE, which replaces
> `boot_command_line` with CONFIG_CMDLINE and immediately`goto out`. It'd b=
e
> similar way to handle CONFIG_CMDLINE_EXTEND and CONFIG_CMDLINE_BOOTLOADER=
,
> so I added some code after OF_FLATTREE part to handle them.
>=20
> Signed-off-by: Dong Zhihong <donmor3000@hotmail.com>
> ---
>=20
> v2 -> v1:Reworded the commit message so it's more imperative (Markus);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Added `goto out` to FDT p=
art (Huacai)
>=20
> =C2=A0arch/loongarch/kernel/setup.c | 17 +++++++++++++++++
> =C2=A01 file changed, 17 insertions(+)
>=20
> diff --git a/arch/loongarch/kernel/setup.c b/arch/loongarch/kernel/setup.=
c
> index 78a00359bde3..3cafda1a409e 100644
> --- a/arch/loongarch/kernel/setup.c
> +++ b/arch/loongarch/kernel/setup.c
> @@ -332,7 +332,24 @@ static void __init bootcmdline_init(char **cmdline_p=
)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0str=
lcat(boot_command_line, " ", COMMAND_LINE_SIZE);
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0strlcat(boot_command_line, init_command_line, COMMA=
ND_LINE_SIZE);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0goto out;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> +#endif
> +
> +#ifdef CONFIG_CMDLINE
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/*
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * If CONFIG_CMDLINE_BOOTLOADE=
R is enabled then we use thei built-in
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * command line if no command =
line given, or we append given command
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * line to the built-in one if=
 CONFIG_CMDLINE_EXTEND is enabled.
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (IS_ENABLED(CONFIG_CMDLINE_=
EXTEND)) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0strscpy(boot_command_line, CONFIG_CMDLINE, COMMAND_LINE_S=
IZE);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0strlcat(boot_command_line, " ", COMMAND_LINE_SIZE);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0strlcat(boot_command_line, init_command_line, COMMAND_LIN=
E_SIZE);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (IS_ENABLED(CONFIG_CMDLINE_=
BOOTLOADER) && !boot_command_line[0])
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0strscpy(boot_command_line, CONFIG_CMDLINE, COMMAND_LINE_S=
IZE);
> =C2=A0#endif
> =C2=A0
> =C2=A0out:

--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University
