Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81F036E5A74
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 09:30:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230389AbjDRHaL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 03:30:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230093AbjDRHaJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 03:30:09 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 958A23C0D;
        Tue, 18 Apr 2023 00:30:07 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id m39-20020a05600c3b2700b003f170e75bd3so407760wms.1;
        Tue, 18 Apr 2023 00:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681803005; x=1684395005;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yOJRGSqkhaY3rQWlxd3RmTgIRfKZ5fa+Xd7KjcydsNM=;
        b=TVgKWILagxML1a75tWb7Ep3iMUAZJMzToSyBJtw/YksyvAR6Da4M4TW71v1HT5c0dj
         WfxWcMEwhm9VVvcV0Z1eWo+3tavRBfUTf2uFsmRhUrfJUwCPrR/QnhMEYZLHrnV5Ko7v
         3F6LJ+QYvzBVlCFe+7QV4Qi8DRwPJFiZ1tddzMzq274lgStRJjfwvPae9jbnXDTJsaDa
         x39W5x9jhcmcLFQTT42CiW3WXhN4+j6VTzCbMKA5MiS7Pi+jsmwKcbmKKppi2C3HyZdm
         4ZpiwMUdUA7H69R+jp43jJqdQvInc9d8hOoZEeXpP0Z8Dogg2I+rJTlvBCyh1SxZKSXl
         D1Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681803005; x=1684395005;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yOJRGSqkhaY3rQWlxd3RmTgIRfKZ5fa+Xd7KjcydsNM=;
        b=JR5Va3BOiw75/00zNA9Z5FtuUHlJ8tFpJhYif3L1jyurEmrn5N3rRbjS7cFc0sxZ0Y
         fVSXH5fnhUP9FeVaWJ2ybtpHX2PKQKWXUWMQ2dqWxFiTLnpkWzCTgM37uZNXE2pNnSol
         IIM5+ymsB0WvMMecgL8EJ3l67aATz2PfvWVWIXyGJE2jkRxid/4m/yyTyZxEQBQVeoXd
         A+/XVkpRvxBKpsN5jtYE36cRb6qn1sghFcTxbbsS4KckVOgNDpfU7MlZ5gwL/IEYrjf0
         KhYT8NH4jjGJExRap4I6m7NvhILCV/Y/mZl5SjvRoWClu0+HFQTMMbMieaaJsn24sie2
         Pd0w==
X-Gm-Message-State: AAQBX9cXq7uJMtIVvG8+qOMGNtb2+wUHiMvr+OdjB00UOG4nWFC+Saln
        1/UerTJKJf23wN77GHVpqzg=
X-Google-Smtp-Source: AKy350Y/TrEPOE+CjJuBbXWpjuo8DS3MAVJfP4BYilpIghd/5fCeKzhPLL4CLcwoPVRYCTpzetEojw==
X-Received: by 2002:a7b:c012:0:b0:3ed:2e02:1c02 with SMTP id c18-20020a7bc012000000b003ed2e021c02mr12102114wmb.23.1681803005357;
        Tue, 18 Apr 2023 00:30:05 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id r4-20020adfda44000000b002f598008d50sm12276459wrl.34.2023.04.18.00.30.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 00:30:04 -0700 (PDT)
Date:   Tue, 18 Apr 2023 10:30:01 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-sh@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH RESEND] sh: sq: Use the bitmap API when applicable
Message-ID: <14788dbc-c2a6-4d1d-8ae3-1be53b0daf17@kili.mountain>
References: <071e9f32c19a007f4922903282c9121898641400.1681671848.git.christophe.jaillet@wanadoo.fr>
 <b5fea49d68e1e2a702b0050f73582526e205cfa2.camel@physik.fu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b5fea49d68e1e2a702b0050f73582526e205cfa2.camel@physik.fu-berlin.de>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 18, 2023 at 08:36:40AM +0200, John Paul Adrian Glaubitz wrote:
> Hi Christophe!
> 
> Thanks for your patch. The changes look good to me. However, I have
> one question, see below.
> 
> On Sun, 2023-04-16 at 21:05 +0200, Christophe JAILLET wrote:
> > Using the bitmap API is less verbose than hand writing them.
> > It also improves the semantic.
> > 
> > Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> > ---
> > This is a resend of [1].
> > 
> > Now cross-compile tested with CONFIG_CPU_SUBTYPE_SH7770=y
> > 
> > [1]: https://lore.kernel.org/all/521788e22ad8f7a5058c154f068b061525321841.1656142814.git.christophe.jaillet@wanadoo.fr/
> > ---
> >  arch/sh/kernel/cpu/sh4/sq.c | 7 +++----
> >  1 file changed, 3 insertions(+), 4 deletions(-)
> > 
> > diff --git a/arch/sh/kernel/cpu/sh4/sq.c b/arch/sh/kernel/cpu/sh4/sq.c
> > index 27f2e3da5aa2..d289e99dc118 100644
> > --- a/arch/sh/kernel/cpu/sh4/sq.c
> > +++ b/arch/sh/kernel/cpu/sh4/sq.c
> > @@ -372,7 +372,6 @@ static struct subsys_interface sq_interface = {
> >  static int __init sq_api_init(void)
> >  {
> >  	unsigned int nr_pages = 0x04000000 >> PAGE_SHIFT;
> > -	unsigned int size = (nr_pages + (BITS_PER_LONG - 1)) / BITS_PER_LONG;
> >  	int ret = -ENOMEM;
> >  
> >  	printk(KERN_NOTICE "sq: Registering store queue API.\n");
> > @@ -382,7 +381,7 @@ static int __init sq_api_init(void)
> >  	if (unlikely(!sq_cache))
> >  		return ret;
> >  
> > -	sq_bitmap = kzalloc(size, GFP_KERNEL);
> > +	sq_bitmap = bitmap_zalloc(nr_pages, GFP_KERNEL);
> >  	if (unlikely(!sq_bitmap))
> >  		goto out;
> > 
> 
> I have look through other patches where k{z,c,m}alloc() were replaced with
> bitmap_zalloc() and I noticed that in the other cases such as [1], kcalloc()
> was used instead of kzalloc() in our cases with the element size set to
> sizeof(long) while kzalloc() is using an element size equal to a byte.
> 
> Wouldn't that mean that the current code in sq is allocating a buffer that is
> too small by a factor of 1/sizeof(long) or am I missing something?

Yes.  You are correct.  The original code is buggy.

size is the number of longs we need so kzalloc() is allocating a too
small buffer.  It should be kzalloc(size * sizeof(long), ... etc as you
say.

I have some unpublished Smatch stuff which tries to track "variable x
is in terms of bit units or byte units etc."  I will try to make a
static checker rule for this.

regards,
dan carpenter
