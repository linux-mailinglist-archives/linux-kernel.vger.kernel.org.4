Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6738A5FF957
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Oct 2022 11:07:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbiJOJHe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Oct 2022 05:07:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbiJOJHc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Oct 2022 05:07:32 -0400
Received: from relay10.mail.gandi.net (relay10.mail.gandi.net [IPv6:2001:4b98:dc4:8::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84C671571B
        for <linux-kernel@vger.kernel.org>; Sat, 15 Oct 2022 02:07:29 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 96B19240005;
        Sat, 15 Oct 2022 09:07:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1665824847;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uilEODdv3PazkYXihcKS3EbN59FUcP/gU7kmYw1f/YQ=;
        b=TZWfRro9s4S64w92ossm9qh6lF0kyqWmPdLZiTpbuGX4gnF5utaNQpMpVU4TE94ocyFNjs
        BzLoKD9ya22hnZeidvXsmzwGLckFIyZEMOmIZ4unMWgZnufvSEEHiPhH/0AFNi7mjsbDnK
        4auovfBelhhIYl6dpMZ0C3BqHFYJF7oJGDdwla2mJixSUt0NqWNixs9LvWYmF3SSotWRb0
        n2LEJSNhadx0j+glpbsO/ewLTWN3w42/HAwwl5rsSgL+F+cAxZ8d3jYc9NKXje7eAJjcIA
        yhUPqaCznM3+udkxF5ssSrEez7yhUtLljCGyhTWgrrtKwu5GREijHZhC+roS2w==
Date:   Sat, 15 Oct 2022 11:07:24 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     yexingchen116@gmail.com
Cc:     richard@nod.at, vigneshr@ti.com, wsa+renesas@sang-engineering.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        ye xingchen <ye.xingchen@zte.com.cn>
Subject: Re: [PATCH linux-next] mtd: replace strcmp with sysfs_streq
Message-ID: <20221015110724.5c535807@xps-13>
In-Reply-To: <20221008074643.308969-1-ye.xingchen@zte.com.cn>
References: <20221008074643.308969-1-ye.xingchen@zte.com.cn>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
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

Hi yexingchen116@gmail.com,

yexingchen116@gmail.com wrote on Sat,  8 Oct 2022 07:46:43 +0000:

> From: ye xingchen <ye.xingchen@zte.com.cn>
>=20
> Replace the open-code with sysfs_streq().
>=20
> Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
> ---
>  drivers/mtd/parsers/cmdlinepart.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/mtd/parsers/cmdlinepart.c
> b/drivers/mtd/parsers/cmdlinepart.c
> index b34856def816..6a401e0b1b95 100644
> --- a/drivers/mtd/parsers/cmdlinepart.c
> +++ b/drivers/mtd/parsers/cmdlinepart.c
> @@ -154,7 +154,7 @@ static struct mtd_partition * newpart(char *s,
>  	}
> =20
>  	/* if slc is found use emulated SLC mode on this partition*/
> -	if (!strncmp(s, "slc", 3)) {
> +	if (sysfs_streq(s, "slc")) {

I'm sorry but, why this would be a use for sysfs_streq? The point of
this helper is to consider "\n" null, which is not relevant here. Or do
I miss something?

>  		add_flags |=3D MTD_SLC_ON_MLC_EMULATION;
>  		s +=3D 3;
>  	}


Thanks,
Miqu=C3=A8l
