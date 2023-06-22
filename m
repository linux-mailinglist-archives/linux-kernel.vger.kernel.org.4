Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86BD773AB61
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 23:15:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230452AbjFVVPq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 17:15:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231334AbjFVVPi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 17:15:38 -0400
Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B364F1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 14:15:35 -0700 (PDT)
Received: from relay7-d.mail.gandi.net (unknown [IPv6:2001:4b98:dc4:8::227])
        by mslow1.mail.gandi.net (Postfix) with ESMTP id 4AD30C0226
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 21:03:45 +0000 (UTC)
X-GND-Sasl: miquel.raynal@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1687467741;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Kj+dlKjeE1HfsgeOJRrfqs43BHfThE4k0H3BZX195EU=;
        b=ALMm54kKlsoAxrAjYQff4Ab0BklcIdnMkXohS2aMwFuaLrEquECzsa993/I4EUy/8ocnYB
        zKATuuxnBj3C2OPGBNY6FOQ63pcMExlyFZAN331Ydunqk7uVZjUE/3zU4Y2uIXhxy/kQOa
        pVVeh6WdREDFDDQINjteR9mhSnGTtsXU5EX8Q+bgr9Nv4xRGBXdgz86oIE5elztSZXx/cG
        szSuCGlUcDujIK/+zbWZb+ubZolgovu/nH4log6DDQfkVRgLvgAkMwwt3RwUdzUBBpfVvi
        wGj0IrEmwx/WVvdSmJG+aa9bj6oAg06h/lOHGLKQ9f4NogUQzfZmCisCYuqF7w==
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id D388D20004;
        Thu, 22 Jun 2023 21:02:19 +0000 (UTC)
Date:   Thu, 22 Jun 2023 23:02:17 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Yang Rong <yangrong@vivo.com>
Cc:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org (open list:MEMORY TECHNOLOGY DEVICES
        (MTD)), linux-kernel@vger.kernel.org (open list),
        opensource.kernel@vivo.com, luhongfei@vivo.com
Subject: Re: [PATCH] drivers: mtd: Fix potential memory leak in
 mtd_check_of_node
Message-ID: <20230622230217.793fe0c5@xps-13>
In-Reply-To: <20230621024517.1155-1-yangrong@vivo.com>
References: <20230621024517.1155-1-yangrong@vivo.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

yangrong@vivo.com wrote on Wed, 21 Jun 2023 10:43:22 +0800:

> The for_each_child_of_node API internally increases the reference count
> for each child node traversed. If a break statement is encountered inside
> the loop, it leaves one reference unbalanced leading to a memory leak.
>=20
> The function mtd_check_of_node in drivers/mtd/mtdcore.c uses such a loop
> and a break statement without a corresponding of_node_put.
>=20
> This patch fixes the potential memory leak by adding a call to
> of_node_put before the break statement inside the for_each_child_of_node
> loop in the function mtd_check_of_node.

I wanted to take this patch but it failed to apply cleanly. Please now
wait for -rc1 and send an updated v2.
=20
>=20
> Signed-off-by: Yang Rong <yangrong@vivo.com>
> ---
>  drivers/mtd/mtdcore.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/mtd/mtdcore.c b/drivers/mtd/mtdcore.c
> index e00b12aa5ec9..b02cb8b1a38d 100644
> --- a/drivers/mtd/mtdcore.c
> +++ b/drivers/mtd/mtdcore.c
> @@ -591,6 +591,7 @@ static void mtd_check_of_node(struct mtd_info *mtd)
>                 if (plen =3D=3D mtd_name_len &&
>                     !strncmp(mtd->name, pname + offset, plen)) {
>                         mtd_set_of_node(mtd, mtd_dn);
> +                       of_node_put(mtd_dn);
>                         break;
>                 }
>         }
> --
> 2.35.3
>=20
>=20
> ________________________________
> =E6=9C=AC=E9=82=AE=E4=BB=B6=E5=8F=8A=E5=85=B6=E9=99=84=E4=BB=B6=E5=86=85=
=E5=AE=B9=E5=8F=AF=E8=83=BD=E5=90=AB=E6=9C=89=E6=9C=BA=E5=AF=86=E5=92=8C/=
=E6=88=96=E9=9A=90=E7=A7=81=E4=BF=A1=E6=81=AF=EF=BC=8C=E4=BB=85=E4=BE=9B=E6=
=8C=87=E5=AE=9A=E4=B8=AA=E4=BA=BA=E6=88=96=E6=9C=BA=E6=9E=84=E4=BD=BF=E7=94=
=A8=E3=80=82=E8=8B=A5=E6=82=A8=E9=9D=9E=E5=8F=91=E4=BB=B6=E4=BA=BA=E6=8C=87=
=E5=AE=9A=E6=94=B6=E4=BB=B6=E4=BA=BA=E6=88=96=E5=85=B6=E4=BB=A3=E7=90=86=E4=
=BA=BA=EF=BC=8C=E8=AF=B7=E5=8B=BF=E4=BD=BF=E7=94=A8=E3=80=81=E4=BC=A0=E6=92=
=AD=E3=80=81=E5=A4=8D=E5=88=B6=E6=88=96=E5=AD=98=E5=82=A8=E6=AD=A4=E9=82=AE=
=E4=BB=B6=E4=B9=8B=E4=BB=BB=E4=BD=95=E5=86=85=E5=AE=B9=E6=88=96=E5=85=B6=E9=
=99=84=E4=BB=B6=E3=80=82=E5=A6=82=E6=82=A8=E8=AF=AF=E6=94=B6=E6=9C=AC=E9=82=
=AE=E4=BB=B6=EF=BC=8C=E8=AF=B7=E5=8D=B3=E4=BB=A5=E5=9B=9E=E5=A4=8D=E6=88=96=
=E7=94=B5=E8=AF=9D=E6=96=B9=E5=BC=8F=E9=80=9A=E7=9F=A5=E5=8F=91=E4=BB=B6=E4=
=BA=BA=EF=BC=8C=E5=B9=B6=E5=B0=86=E5=8E=9F=E5=A7=8B=E9=82=AE=E4=BB=B6=E3=80=
=81=E9=99=84=E4=BB=B6=E5=8F=8A=E5=85=B6=E6=89=80=E6=9C=89=E5=A4=8D=E6=9C=AC=
=E5=88=A0=E9=99=A4=E3=80=82=E8=B0=A2=E8=B0=A2=E3=80=82
> The contents of this message and any attachments may contain confidential=
 and/or privileged information and are intended exclusively for the address=
ee(s). If you are not the intended recipient of this message or their agent=
, please note that any use, dissemination, copying, or storage of this mess=
age or its attachments is not allowed. If you receive this message in error=
, please notify the sender by reply the message or phone and delete this me=
ssage, any attachments and any copies immediately.
> Thank you


Thanks,
Miqu=C3=A8l
