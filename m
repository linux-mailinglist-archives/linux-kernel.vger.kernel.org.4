Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 837DC68B760
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 09:30:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbjBFIaf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 03:30:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229969AbjBFIac (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 03:30:32 -0500
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27D051A49F
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 00:30:30 -0800 (PST)
Received: (Authenticated sender: herve.codina@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 75D241C0012;
        Mon,  6 Feb 2023 08:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1675672229;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OMj5Fs+cE7htz9baKVtZ700BYz9yyPIfXJqXxrqoEi4=;
        b=SNEwGb9Pn9HOlCtzKReMZNxO+N3A3DzDLn4rSE1lREh4Z5ybrWudDu+Qeky0Bnj4EJQe46
        7LspwC0yNko51n52GuRycvGg0NFbqR6NVdIciW1TCZSp9pAEB4WEwLI8yWOskN+S/11UDx
        SFruYQ/YqOC80gNV39hVpAIySvDCpN5lmU3KKTtdxJFqEAbzgk0pLUKX0EjSzUQ6dLN2h7
        JNhHlbNDcnyzA0uGh0uc9HA4AdkyrEd5S2wEGY8ElYRqBLM0KA6DSYYq4oXPtbFS69U4Bx
        yK4gs3Z8mfOUhhK1RegMGagcHvfQS7CPz0O6OjP0BuoMaF5kxlQnNwNaYL4TYg==
Date:   Mon, 6 Feb 2023 09:30:26 +0100
From:   Herve Codina <herve.codina@bootlin.com>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH] ASoC: codecs: Fix unsigned comparison with less than
 zero
Message-ID: <20230206093026.6236eea2@bootlin.com>
In-Reply-To: <20230206075518.84169-1-jiapeng.chong@linux.alibaba.com>
References: <20230206075518.84169-1-jiapeng.chong@linux.alibaba.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.36; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  6 Feb 2023 15:55:18 +0800
Jiapeng Chong <jiapeng.chong@linux.alibaba.com> wrote:

> The val is defined as unsigned int type, if(val<0) is redundant, so
> delete it.
>=20
> sound/soc/codecs/idt821034.c:449 idt821034_kctrl_gain_put() warn: unsigne=
d 'val' is never less than zero.
>=20
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=3D3947
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>  sound/soc/codecs/idt821034.c | 2 --
>  1 file changed, 2 deletions(-)
>=20
> diff --git a/sound/soc/codecs/idt821034.c b/sound/soc/codecs/idt821034.c
> index 5d01787b1c1f..2cc7b9166e69 100644
> --- a/sound/soc/codecs/idt821034.c
> +++ b/sound/soc/codecs/idt821034.c
> @@ -446,8 +446,6 @@ static int idt821034_kctrl_gain_put(struct snd_kcontr=
ol *kcontrol,
>  	u8 ch;
> =20
>  	val =3D ucontrol->value.integer.value[0];
> -	if (val < 0)
> -		return -EINVAL;
>  	if (val > max - min)
>  		return -EINVAL;
> =20

Acked-by: Herve Codina <herve.codina@bootlin.com>

Thanks,
Herv=C3=A9

--=20
Herv=C3=A9 Codina, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
