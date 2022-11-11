Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DEF262587C
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 11:38:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233600AbiKKKiS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 05:38:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233096AbiKKKiQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 05:38:16 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA3A512605
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 02:38:15 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id y4so3953630plb.2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 02:38:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WDAe46mocv8N19iUrpVAVRFXORmPxnlQIO/wxgYUTno=;
        b=FrAUhA4rAeuVcuLA/U9mmmOErKic7EKby5f9WqhnY49RBIBvSl6wi0k9EsT2MWpAsf
         Y/mPpF4p1/2+X5nBq580SGeo7HCGsnKW9FTZXlhybSKLv5m8EByjVlbEXJQEbO3Mi2d8
         rdiVUha2xJT+zYkfMj9qsT/cOiSRC5pTJAjVc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WDAe46mocv8N19iUrpVAVRFXORmPxnlQIO/wxgYUTno=;
        b=HH9ggbAcsOXWFktaA3iJcWCubUGAkJouK1ntsenkWPiOTNZ+VYvIQLnxzzlAJCGpqW
         AX3tyCqg+6v7JK+3//Vh6Tg0OgeOv9s40b25rxRYWqsLPkHRQpBwUStRnexrKoPRmAjZ
         3/gfcmXr80MR/LAvyq56Bo7vGL1fzvI4LeiIl0Mcx18AUtfySbz25OdyUKGUKemSgOCq
         szDtKxk36Zgv19VbklpzHNquy2YJLwbc839Bbuesdny1amQazCDiomJdmRrQ2BWPwpqb
         +fFqUVnYBqjMVeSB+9JKIpHaHM78Z7Ka0CCQ5QjO99d1qCFdIGTIBubEBfxTig9FJrsb
         IOow==
X-Gm-Message-State: ANoB5pmdkkI0lR1o2gt+RcpmjOIDr/OJXgtraGkz6qXKbz2EiTA0jwzM
        b209vYce4oW6lZZxGUSkkNpniw==
X-Google-Smtp-Source: AA0mqf6GcDtWuq7A6v4bBbbht/rRQxdxBbsDvTtW7j1D9USVOdygPz0XjnNVRpkaQgPZt9texwKmfA==
X-Received: by 2002:a17:902:c3d1:b0:188:82fc:e284 with SMTP id j17-20020a170902c3d100b0018882fce284mr1927093plj.76.1668163095189;
        Fri, 11 Nov 2022 02:38:15 -0800 (PST)
Received: from google.com ([240f:75:7537:3187:8d55:c60d:579d:741c])
        by smtp.gmail.com with ESMTPSA id l16-20020a170903121000b00176b84eb29asm117500plh.301.2022.11.11.02.38.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Nov 2022 02:38:14 -0800 (PST)
Date:   Fri, 11 Nov 2022 19:38:10 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nitin Gupta <ngupta@vflare.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCHv4 2/9] zsmalloc: turn zspage order into runtime variable
Message-ID: <Y24mEiy0pt2qSCqr@google.com>
References: <20221031054108.541190-1-senozhatsky@chromium.org>
 <20221031054108.541190-3-senozhatsky@chromium.org>
 <Y210OrSgrqWPr0DT@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y210OrSgrqWPr0DT@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (22/11/10 13:59), Minchan Kim wrote:
[..]
> > +#define ZS_PAGE_ORDER_2		2
> > +#define ZS_PAGE_ORDER_4		4
> > +
> > +/*
> > + * A single 'zspage' is composed of up to 2^N discontiguous 0-order (single)
> > + * pages. ZS_MAX_PAGE_ORDER defines upper limit on N, ZS_MIN_PAGE_ORDER
> > + * defines lower limit on N. ZS_DEFAULT_PAGE_ORDER is recommended value.
> 
> It gives the impression:
> 
>    2^2 <= the page nubmer of zspage <= 2^4
> 
> I think that's not what you want to describe. How about?
> 
> A single 'zspage' is composed of up to 2^N discontiguous 0-order (single)
> pages and the N can be from ZS_MIN_PAGE_ORDER to ZS_MAX_PAGE_ORDER.

OK.

> > + */
> > +#define ZS_MIN_PAGE_ORDER	ZS_PAGE_ORDER_2
> > +#define ZS_MAX_PAGE_ORDER	ZS_PAGE_ORDER_4
> > +#define ZS_DEFAULT_PAGE_ORDER	ZS_PAGE_ORDER_2
> 
> #define ZS_MIN_PAGE_ORDER	2
> 
> We can use the number directly instead of another wrapping at least
> in this patch(Just in case: if you want to extent it later patch,
> please do it in the patch)

OK.

[..]
> > -#define MAX(a, b) ((a) >= (b) ? (a) : (b))
> > -/* ZS_MIN_ALLOC_SIZE must be multiple of ZS_ALIGN */
> > -#define ZS_MIN_ALLOC_SIZE \
> > -	MAX(32, (ZS_MAX_PAGES_PER_ZSPAGE << PAGE_SHIFT >> OBJ_INDEX_BITS))
> > +#define ZS_MIN_ALLOC_SIZE	32U
> 
> Let's have some comment here to say that's not the final vaule which
> is supposed to be pool->min_alloc_size.

OK.

[..]
> >  enum fullness_group {
> >  	ZS_EMPTY,
> > @@ -230,12 +221,15 @@ struct link_free {
> >  struct zs_pool {
> >  	const char *name;
> >  
> > -	struct size_class *size_class[ZS_SIZE_CLASSES];
> > +	struct size_class **size_class;
> >  	struct kmem_cache *handle_cachep;
> >  	struct kmem_cache *zspage_cachep;
> >  
> >  	atomic_long_t pages_allocated;
> >  
> > +	u32 num_size_classes;
> > +	u32 min_alloc_size;
> 
> Please use int.

OK. Any reason why we don't want u32? I thought that
s16/u16/s32/u32/etc. is the new normal.

> From this patch, I couldn't figure why we need
> variable in the pool. Let's have the change in the patch where
> you really need to have the usecase.

Let me take a look.

> > -static int get_pages_per_zspage(int class_size)
> > +static int get_pages_per_zspage(u32 class_size, u32 num_pages)
> 
> Let's just use int instead of u32
> 
> Why do you need num_pages argument instead of using 1UL << ZS_DEFAULT_PAGE_ORDER?
> It looks like static value.

It is static right now, but in the a couple of patches it'll change to
dynamic.
