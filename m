Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 170565F8A88
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Oct 2022 12:17:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229976AbiJIKR1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Oct 2022 06:17:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230002AbiJIKRQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Oct 2022 06:17:16 -0400
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 527DA2CE0C
        for <linux-kernel@vger.kernel.org>; Sun,  9 Oct 2022 03:17:15 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 4ED1760003;
        Sun,  9 Oct 2022 10:17:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1665310634;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EJbLySeJ2z0oLQnlb4jRyOMMn4QDACjqzur2LSX6plA=;
        b=e8GYXYi6DqNrSikRmR9wFPZudo6rG+g63ExcWLTFxUPbEwFEfSXvLNiTmYMnNL56jyZhos
        e03vGjIvuZaHvQHKIari555v279PtvGdbTiA3daaan0cIQhl6Ef/afLLjNOsEkCrbSD7aX
        kZAL7cvqlj0qD7hhTWWLtW70ISoR6X6eqCTkdw1n4hudswYE/1SDKLV7ac94el2XjTxaVT
        rm+f/N/4f8HLsm1BZyLXgnvTgi6hvxB5D4MH8OUVPhUvVEt9wqRzBb1xVfCfop0a5mq2qr
        WqLKwy5DG/f37uRkNO5nI7057tzmgAodgA6RzXd1DHSA5mdz3MZNdVCHSY59jg==
Date:   Sun, 9 Oct 2022 12:17:10 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Joe Perches <joe@perches.com>
Cc:     Ray Zhang <sgzhang@google.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/3] mtd: mtdoops: change printk() to counterpart pr_
 functions
Message-ID: <20221009121710.2ebf951c@xps-13>
In-Reply-To: <0d4febb49ddbae9cd99606a89573a7c832ed0965.camel@perches.com>
References: <20221007215027.918507-1-sgzhang@google.com>
        <20221007215027.918507-2-sgzhang@google.com>
        <0d4febb49ddbae9cd99606a89573a7c832ed0965.camel@perches.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joe,

joe@perches.com wrote on Sat, 08 Oct 2022 00:25:07 -0700:

> On Fri, 2022-10-07 at 21:50 +0000, Ray Zhang wrote:
> > To comply with latest kernel code requirement, change printk() to
> > counterpart pr_ functions in mtdoops driver:
> > - change printk(INFO) to pr_info()
> > - change printk(DEBUG) to pr_debug()
> > - change printk(WARNING) to pr_warn()
> > - change printk(ERR) to pr_err()
> >=20
> > Note that only if dynamic debugging is enabled or DEBUG is defined,
> > printk(KERN_DEBUG) and pr_debug() are equivalent; Otherwise pr_debug()
> > is no-op, causing different behavior. =20
>=20
> Another thing possible is to add
>=20
> #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>=20
> before any #include

Good point.

> > diff --git a/drivers/mtd/mtdoops.c b/drivers/mtd/mtdoops.c =20
> []
> > @@ -93,9 +93,9 @@ static int mtdoops_erase_block(struct mtdoops_context=
 *cxt, int offset)
> > =20
> >  	ret =3D mtd_erase(mtd, &erase);
> >  	if (ret) {
> > -		printk(KERN_WARNING "mtdoops: erase of region [0x%llx, 0x%llx] on \"=
%s\" failed\n",
> > -		       (unsigned long long)erase.addr,
> > -		       (unsigned long long)erase.len, mtddev);
> > +		pr_warn("mtdoops: erase of region [0x%llx, 0x%llx] on \"%s\" failed\=
n",
> > +			(unsigned long long)erase.addr,
> > +			(unsigned long long)erase.len, mtddev); =20
>=20
> And remove the "mtdoops: " prefixes from all the output formats
>=20
> 		pr_warn("erase of region [0x%llx, 0x%llx] on \"%s\" failed\n",
> 			(unsigned long long)erase.addr,
> 			(unsigned long long)erase.len, mtddev);
>=20
> > @@ -120,8 +120,8 @@ static void mtdoops_inc_counter(struct mtdoops_cont=
ext *cxt)
> >  		return;
> >  	}
> > =20
> > -	printk(KERN_DEBUG "mtdoops: ready %d, %d (no erase)\n",
> > -	       cxt->nextpage, cxt->nextcount);
> > +	pr_debug("mtdoops: ready %d, %d (no erase)\n",
> > +		 cxt->nextpage, cxt->nextcount); =20
>=20
> 	pr_debug("ready %d, %d (no erase)\n", cxt->nextpage, cxt->nextcount);
>=20
> etc...
>=20


Thanks,
Miqu=C3=A8l
