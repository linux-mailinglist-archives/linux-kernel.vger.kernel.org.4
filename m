Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC7F969BA53
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Feb 2023 15:01:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbjBROBN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Feb 2023 09:01:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjBROBL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Feb 2023 09:01:11 -0500
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6322B13D5A
        for <linux-kernel@vger.kernel.org>; Sat, 18 Feb 2023 06:01:06 -0800 (PST)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id A2CBB1C0E0B; Sat, 18 Feb 2023 15:01:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
        t=1676728864;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZL4K6X2FSJVi8K7B6El5/6cZqmRtEMln+zNt3IAzswI=;
        b=rOQzod7Gclru3+7WueD54igIGxqdfFn07BNOjZFq7sBSxj71HL907NMtg5tClfFg5P+99K
        hm98E8F+0c1tt9R8mj0xqn0ZO/upvwpOntYr+BFKPXfJBDQkPmDYVk+sArlslvCd37Ci38
        /L4vxujPb7GyQdeobXKTv7V00bcJ6l4=
Date:   Sat, 18 Feb 2023 15:01:03 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Sia Jee Heng <jeeheng.sia@starfivetech.com>
Cc:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, leyfoon.tan@starfivetech.com,
        mason.huo@starfivetech.com
Subject: Re: [PATCH 3/3] RISC-V: Add arch functions to support
 hibernation/suspend-to-disk
Message-ID: <Y/DaH0vjMsln4Ghr@duo.ucw.cz>
References: <20230106060535.104321-1-jeeheng.sia@starfivetech.com>
 <20230106060535.104321-4-jeeheng.sia@starfivetech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="IqFhkKEgSBAYZtOE"
Content-Disposition: inline
In-Reply-To: <20230106060535.104321-4-jeeheng.sia@starfivetech.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--IqFhkKEgSBAYZtOE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> @@ -21,6 +21,11 @@ struct suspend_context {
>  #endif
>  };
> =20
> +/* This parameter will be assigned to 0 during resume and will be used by
> + * hibernation core for the subsequent resume sequence
> + */
> +extern int in_suspend;

"/*" should be on separate line. (This occurs multiple times.)

> +ENTRY(core_restore_code)
> +	/* switch to temp page table */
> +	csrw satp, s1
> +	sfence.vma
> +	beqz	s4, done
> +loop:
> +	/* The below code will restore the hibernated image. */
> +	ld	a1, HIBERN_PBE_ADDR(s4)
> +	ld	a0, HIBERN_PBE_ORIG(s4)
> +
> +	lui     a4, 0x1
> +	add     a4, a4, a0

Do you have enough registers to move a4 =3D 0x1 assignment before the
loop:?

> +static int __init riscv_hibernate__init(void)
> +{
> +	hibernate_cpu_context =3D kcalloc(1, sizeof(struct suspend_context), GF=
P_KERNEL);
> +

kzalloc?

> +	if (WARN_ON(!hibernate_cpu_context))
> +		return -ENOMEM;
> +
> +	return 0;
> +}
> +
> +early_initcall(riscv_hibernate__init);

Does this really need to be done early?

Best regards,
								Pavel
--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--IqFhkKEgSBAYZtOE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCY/DaHwAKCRAw5/Bqldv6
8pCeAKCtimnpUoABKl6hy7nwxKtdyFuhZACgi6PwWGe/AwJqB4ECjFEjbteesHg=
=/hSf
-----END PGP SIGNATURE-----

--IqFhkKEgSBAYZtOE--
