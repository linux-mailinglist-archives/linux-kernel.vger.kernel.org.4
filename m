Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5823370C2AE
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 17:46:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234501AbjEVPqo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 11:46:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229937AbjEVPql (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 11:46:41 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6419FE6
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 08:46:40 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 91999E0002;
        Mon, 22 May 2023 15:46:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1684770398;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pI3C+U+LkZPRCdvh2AIdDV8xoT+44ar4D3GHeccQWGE=;
        b=R0Y6n1ahYUWbNzKwBGmqnlzlF56R36DVZ3Tlr43VOrtBopOXtyLb73IAmRUhb33prQ2gCw
        zYffta3tMUR1YUC+zZFWOHrh0btAKAWSHQnodwcUiPgDro1Wb5jIcy//1yHNqVoj3pS6pJ
        2ev55puOO5JuQD6Ux/fcTp/xGflgYH2Ldg13KoQl6erk+QzIN+4FrusEpf38h/8OFdeOei
        0C5DDZwizqT9vw4nHtOFnBaiZNwLvTR/enE14oawhnpX68VqG27hPc5mOqaj6c6pWUFapT
        OTnGDopFLF5tU93o7gLn1Rxoi32Nnm/9aTVVDYaQvKiA4Ba0+HXpwNk7L3m25A==
Date:   Mon, 22 May 2023 17:46:35 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        =?UTF-8?B?TWljaGHFgiBLxJlwaWXFhA==?= <kernel@kempniu.pl>,
        Arnd Bergmann <arnd@arndb.de>, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mtdchar: mark bits of ioctl handler noinline
Message-ID: <20230522174635.7acfb42c@xps-13>
In-Reply-To: <20230417205654.1982368-1-arnd@kernel.org>
References: <20230417205654.1982368-1-arnd@kernel.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

arnd@kernel.org wrote on Mon, 17 Apr 2023 22:56:50 +0200:

> From: Arnd Bergmann <arnd@arndb.de>
>=20
> The addition of the mtdchar_read_ioctl() function caused the stack usage
> of mtdchar_ioctl() to grow beyond the warning limit on 32-bit architectur=
es
> with gcc-13:
>=20
> drivers/mtd/mtdchar.c: In function 'mtdchar_ioctl':
> drivers/mtd/mtdchar.c:1229:1: error: the frame size of 1488 bytes is larg=
er than 1024 bytes [-Werror=3Dframe-larger-than=3D]
>=20
> Mark both the read and write portions as noinline_for_stack to ensure
> they don't get inlined and use separate stack slots to reduce the
> maximum usage, both in the mtdchar_ioctl() and combined with any
> of its callees.
>=20
> Fixes: 095bb6e44eb1 ("mtdchar: add MEMREAD ioctl")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

I am about to take this as part of my next fixes PR, should we Cc:
stable? What is the current policy wrt gcc version issues?

> ---
>  drivers/mtd/mtdchar.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/mtd/mtdchar.c b/drivers/mtd/mtdchar.c
> index 01f1c6792df9..8dc4f5c493fc 100644
> --- a/drivers/mtd/mtdchar.c
> +++ b/drivers/mtd/mtdchar.c
> @@ -590,8 +590,8 @@ static void adjust_oob_length(struct mtd_info *mtd, u=
int64_t start,
>  			    (end_page - start_page + 1) * oob_per_page);
>  }
> =20
> -static int mtdchar_write_ioctl(struct mtd_info *mtd,
> -		struct mtd_write_req __user *argp)
> +static noinline_for_stack int
> +mtdchar_write_ioctl(struct mtd_info *mtd, struct mtd_write_req __user *a=
rgp)
>  {
>  	struct mtd_info *master =3D mtd_get_master(mtd);
>  	struct mtd_write_req req;
> @@ -688,8 +688,8 @@ static int mtdchar_write_ioctl(struct mtd_info *mtd,
>  	return ret;
>  }
> =20
> -static int mtdchar_read_ioctl(struct mtd_info *mtd,
> -		struct mtd_read_req __user *argp)
> +static noinline_for_stack int
> +mtdchar_read_ioctl(struct mtd_info *mtd, struct mtd_read_req __user *arg=
p)
>  {
>  	struct mtd_info *master =3D mtd_get_master(mtd);
>  	struct mtd_read_req req;


Thanks,
Miqu=C3=A8l
