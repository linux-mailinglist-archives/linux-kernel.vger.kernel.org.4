Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 343FD5F74E8
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 09:52:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbiJGHwr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 03:52:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiJGHwq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 03:52:46 -0400
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::222])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F4056A3F7A
        for <linux-kernel@vger.kernel.org>; Fri,  7 Oct 2022 00:52:42 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 9E70940014;
        Fri,  7 Oct 2022 07:52:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1665129159;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=n4D06XYdYARjTiZ9opyHKO6UcPGIvGaFyKS4ti1VcvU=;
        b=joJDP4bAb69hrb+tvi3QAJ1neH3YYUCFMglGy3qZpl25XIJUShF1/H7bTU0GJC7v9h4XyE
        TcMWM0649mevdECWIvi+pyJm2IgmXqwNjsuQnppRE3bTzRPeR4Sj1eprJ3FsNjbQiwnHhe
        5y6hNszlqo8w9cGqPr0PgIX3+o/xpJAJXMZlMh9yxsMAaGIr5CEOMMgGnBqw6ppWUPJxHA
        qe2izwGjplEnWqHvMrXS69ic2/zkrhSOheJ3cRAtNURRBwFt2/+kzVCMMGlUMsqeHHC6ZH
        oMv79bMkkgmq/WKm39k8PV5HzmCKhtHhLFrRoHG+7ngq8va1tPMHSx55vPUbqA==
Date:   Fri, 7 Oct 2022 09:52:36 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Joe Perches <joe@perches.com>
Cc:     Ray Zhang <sgzhang@google.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] mtd: mtdoops: change printk() to counterpart pr_
 functions
Message-ID: <20221007095236.37113034@xps-13>
In-Reply-To: <070d253e718c1a6d72fb52c1d2f02ec461d825a1.camel@perches.com>
References: <20221007065042.700761-1-sgzhang@google.com>
        <20221007065042.700761-2-sgzhang@google.com>
        <070d253e718c1a6d72fb52c1d2f02ec461d825a1.camel@perches.com>
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

Hi Joe, Ray,

joe@perches.com wrote on Fri, 07 Oct 2022 00:09:26 -0700:

> On Fri, 2022-10-07 at 06:50 +0000, Ray Zhang wrote:
> > To comply with latest kernel code requirement, change printk() to
> > counterpart pr_ functions in mtdoops driver:
> > - change printk(INFO) to pr_info()
> > - change printk(DEBUG) to pr_debug() =20
>=20
> There is a different behavior with printk(KERN_DEBUG to pr_debug(
> as pr_debug is a no-op unless dynamic debugging is enabled or
> DEBUG is defined.

I didn't know about this difference. I was expecting printk(KERN_DEBUG)
to behave the same as pr_debug/dev_dbg.

> And even with dynamic_debug, the output is default disabled unless
> DEBUG is defined.
>=20
> As is, printk(KERN_DEBUG is emitted unless the console level is low.
>=20
> > diff --git a/drivers/mtd/mtdoops.c b/drivers/mtd/mtdoops.c =20
> []
> > @@ -120,8 +120,8 @@ static void mtdoops_inc_counter(struct mtdoops_cont=
ext *cxt)
> >  		return;
> >  	}
> > =20
> > -	printk(KERN_DEBUG "mtdoops: ready %d, %d (no erase)\n",
> > -	       cxt->nextpage, cxt->nextcount);
> > +	pr_debug("mtdoops: ready %d, %d (no erase)\n",
> > +		 cxt->nextpage, cxt->nextcount);

But honestly in this driver I feel fine changing the printk(KERN_DEBUG)
into pr_debug().

Ray, maybe you can adapt your commit log to mention the difference?

Thanks,
Miqu=C3=A8l
