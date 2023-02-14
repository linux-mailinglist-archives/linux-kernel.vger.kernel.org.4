Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEB49696B6B
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 18:28:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232985AbjBNR2A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 12:28:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233000AbjBNR14 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 12:27:56 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33F6317CC1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 09:27:54 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id g9so10674705pfo.5
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 09:27:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=4z/tD1lWs3iqZhTLhoCdz9qidIMqh/iqk3ouPbYGchw=;
        b=Ys1x9uEKNmx/xFXtuBky5R7Pot5G5/ZB5NHSiX9Bho0s9k5YLk4wx+ZpSMP+I5KiAr
         8Dml4HdVk4F/JAibrLkif6ueAnnS6FBztP4o3wd2Wao5PfyIoNxZFPq+kreVvXNIyLO2
         TbAgZU2P8n6BYV1hcN4UKYDA4kjEKE6mWT3lw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4z/tD1lWs3iqZhTLhoCdz9qidIMqh/iqk3ouPbYGchw=;
        b=zuy9tm+weuBK90fmTb89pyvm4dCv4lNZSeL7KgSvde1S124zpxKdUAAc4x89DdAhZt
         jctXQ9uSHE6pYPshbpw2bQhuJBUrAlBazCvpL8TFXpInZys7rEGleXoE9N5eFWVA4i1H
         fxvPtUOsQHS7onxxJd7zcwzm35ldbt79bslRESXoiE3z5s8qfKjU9SmDsn8ti0X8QkJA
         NcbfQoFNli5O/n3MIljNOJXIoVWMAzHNpMLtwF3nxY4ZzB/2qTcWgdr5akRYB26A3mP3
         +KhaeElxkFiN8XP4ncbnpw95cmKWbvo498tU9ziCGRZkKcabkkNtSchoabxR8oOf/Rrw
         KvXg==
X-Gm-Message-State: AO0yUKVMUjMibw66xU3jpfVbcfa9Dl430Lg51gCRTYRU048dOhe4N8wU
        cxicpHp2KXdWidPdgJLk4g/gZg==
X-Google-Smtp-Source: AK7set+DsC+4BbHcXcFv0KKcntwhdI7NVFQqT87ovOltDjEphAAcDPL60hNtFjP0y7pHEStkb0s/Bg==
X-Received: by 2002:aa7:9f12:0:b0:5a8:515a:eb9f with SMTP id g18-20020aa79f12000000b005a8515aeb9fmr2416399pfr.2.1676395673638;
        Tue, 14 Feb 2023 09:27:53 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id f5-20020aa78b05000000b005a8512c9988sm10345490pfd.93.2023.02.14.09.27.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 09:27:53 -0800 (PST)
Message-ID: <63ebc499.a70a0220.9ac51.29ea@mx.google.com>
X-Google-Original-Message-ID: <202302140916.@keescook>
Date:   Tue, 14 Feb 2023 09:27:52 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Halbuer <halbuer@sra.uni-hannover.de>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Mel Gorman <mgorman@techsingularity.net>
Subject: Re: [PATCH] mm: reduce lock contention of pcp buffer refill
References: <20230201162549.68384-1-halbuer@sra.uni-hannover.de>
 <20230202152501.297639031e96baad35cdab17@linux-foundation.org>
 <70fc9040-f976-0314-46e8-d9ddad82ccf5@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <70fc9040-f976-0314-46e8-d9ddad82ccf5@suse.cz>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 08, 2023 at 11:45:14AM +0100, Vlastimil Babka wrote:
> But I wonder also what kernel hardening folks think here - are the hardened
> kernels usually built with DEBUG_VM or debug_pagealloc enabled, or would you
> like to hook some other kernel option for keeping the checks on page/alloc
> free active? And should those checks be done on every alloc/free, including
> pcplist cached allocations?

What we're depending on for heap-related (i.e. both page allocator and
slab) hardening currently is:

- CONFIG_SLAB_FREELIST_HARDENED
	- pointer obfuscation (SLUB) -- freelist_ptr(), set_freepointer()
	- pool membership verification (SLUB and SLAB) -- cache_from_obj()
	- consecutive double free detection (SLUB and SLAB) -- __free_one()
- allocation order randomization
	- CONFIG_SLAB_FREELIST_RANDOM (SLUB and SLAB)
	- CONFIG_SHUFFLE_PAGE_ALLOCATOR (page allocator)
- memory wiping (both slab and page allocator)
	- init_on_alloc / CONFIG_INIT_ON_ALLOC_DEFAULT_ON
	- init_on_free / CONFIG_INIT_ON_FREE_DEFAULT_ON

I'd be nice to gain slab redzone verification, but that seems expensive
enough that anyone interested in that level of hardening has likely
turned on full KASAN.

-- 
Kees Cook
