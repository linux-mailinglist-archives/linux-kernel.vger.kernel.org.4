Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC2F0626026
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 18:10:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234364AbiKKRKI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 12:10:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234319AbiKKRJq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 12:09:46 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00981BE2B
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 09:09:21 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id e129so4849040pgc.9
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 09:09:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8np7/G7bsyFXWgIxYekl7kPxfItn8rFnlB5cNNDFqN4=;
        b=Vk1KDeaImsSydqONneD4SKhmcDiZUj2sLkG+UGXR5C18BKD9dc7eov9JlfcjpRveW/
         GNIHwtiJ1+nQx310I5JwbrcGfdgVkVXyI1PtwfjTPZWc2FoLj3tmRsmmNfSgck/qEy9g
         gKAEUutfqR699uAbQvSToUczY09dl3waMFGCiuaSsfjsRuuyJNWJccRA+O1k1FCqov9/
         xFNi2xvq9+rAiVHmgFvjYTIZG14qNGciPN8QVxQPJx/wNh4Phk2iUcdVF9O/6/AMdGUw
         6g2wmIckWDf8qhGutH8CNzy5bmj6IcVH+FF/yadUQHyth3btUtc5esxNUlxUdSJccoT/
         /p5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8np7/G7bsyFXWgIxYekl7kPxfItn8rFnlB5cNNDFqN4=;
        b=Rn8oH4aA7nrI62HErD6x8pbOGtyZyx1lTMGuayusCml49fWmDSC0RKXZ6W2KTSE3og
         7sfW4ogSmOgTzNCnvVcBxKzdiZybsIiZRCnjhJ3Bknskk2rHI240SihRLlfDIgIRULwf
         e7mcliomotCV7oEmNtzx5CWWjEe4IEzeNPQlbLKBIUwQY9LPTXomNGmjf94Vb0Sp2WY9
         4MMcgSZWsny9xaJChy+TP4DDL5OVgNyRceg+gsmdJknmcuxzevpp3GOD9Ucp0SI1xGNC
         Si9x15XpnIh/7ykpYq9dhbbeB4TDvEoT6QlLHzXd+dFE+ZoTJnO4as+7PHabBxvl5icT
         fgUQ==
X-Gm-Message-State: ANoB5pl+wkaeICJHccaA2OyoSi51ylx6RXwj8p+Nyoe5vdvbxwhbuv37
        mhCdnsdu3Q2uUraugw48QmQ=
X-Google-Smtp-Source: AA0mqf6bOc6eswnSV3TfmcRFzmPhTL6Ee1KbWpaBaOGQLlUb9Jl61D3zc4K3ORXo+CB6cVL5uBgJAg==
X-Received: by 2002:a63:5115:0:b0:46f:a989:ad72 with SMTP id f21-20020a635115000000b0046fa989ad72mr2401863pgb.430.1668186561335;
        Fri, 11 Nov 2022 09:09:21 -0800 (PST)
Received: from google.com ([2620:15c:211:201:dab:6951:19b1:b46b])
        by smtp.gmail.com with ESMTPSA id o28-20020aa7979c000000b0056babe4fb8asm931672pfp.49.2022.11.11.09.09.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Nov 2022 09:09:20 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Fri, 11 Nov 2022 09:09:19 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Nitin Gupta <ngupta@vflare.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCHv4 2/9] zsmalloc: turn zspage order into runtime variable
Message-ID: <Y26BvxM1CeqnaLI3@google.com>
References: <20221031054108.541190-1-senozhatsky@chromium.org>
 <20221031054108.541190-3-senozhatsky@chromium.org>
 <Y210OrSgrqWPr0DT@google.com>
 <Y24mEiy0pt2qSCqr@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y24mEiy0pt2qSCqr@google.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 11, 2022 at 07:38:10PM +0900, Sergey Senozhatsky wrote:
< snip >

> [..]
> > >  enum fullness_group {
> > >  	ZS_EMPTY,
> > > @@ -230,12 +221,15 @@ struct link_free {
> > >  struct zs_pool {
> > >  	const char *name;
> > >  
> > > -	struct size_class *size_class[ZS_SIZE_CLASSES];
> > > +	struct size_class **size_class;
> > >  	struct kmem_cache *handle_cachep;
> > >  	struct kmem_cache *zspage_cachep;
> > >  
> > >  	atomic_long_t pages_allocated;
> > >  
> > > +	u32 num_size_classes;
> > > +	u32 min_alloc_size;
> > 
> > Please use int.
> 
> OK. Any reason why we don't want u32? I thought that
> s16/u16/s32/u32/etc. is the new normal.

Oh, I didn't know the new normal.

# ag u32 mm/ | wc -l 
65

Then, I'd like to use int to be consistent with others.

> 
> > From this patch, I couldn't figure why we need
> > variable in the pool. Let's have the change in the patch where
> > you really need to have the usecase.
> 
> Let me take a look.
> 
> > > -static int get_pages_per_zspage(int class_size)
> > > +static int get_pages_per_zspage(u32 class_size, u32 num_pages)
> > 
> > Let's just use int instead of u32
> > 
> > Why do you need num_pages argument instead of using 1UL << ZS_DEFAULT_PAGE_ORDER?
> > It looks like static value.
> 
> It is static right now, but in the a couple of patches it'll change to
> dynamic.

Then, plase have the change in the patch you will use to review easier.
