Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 361597419F5
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 23:00:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231848AbjF1U7j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 16:59:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231687AbjF1U7h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 16:59:37 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FCE619B0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 13:59:36 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-666e916b880so163557b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 13:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1687985975; x=1690577975;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=p5EAwO68zepmlB4DZ7YeQCN7tx9mqPakWLHiXEndXTk=;
        b=lqW3ouyNx7hW2mqTtqZkWWLZkqi91e+OzqynvHrRmoI+fFXMrHqi7+vOlxnIV/s3RB
         jfaDcgTVeM2rtOKSDntGBOqnjK1QK0I9bWtkAyJPAS67ACxO8MdHkkDm1/TMHV4ZiOlU
         Jzso/vrdbQt9Q3QjyeWHNBVwjD2c7FPLrT7bQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687985975; x=1690577975;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p5EAwO68zepmlB4DZ7YeQCN7tx9mqPakWLHiXEndXTk=;
        b=S+BvS1ZF9RqkkVCOqwUXzXWCBqV83VXDYZSQ9OJRq+69COG36deccZ0IlHKUQIrtMU
         cbALaOMpzFjcExmkCpv6gkd2h+ZRV53FVJzw9WumxFfhQpOihArl5sJ5D+aBnYHaRO3B
         tgS6orNFDv6zOTLCdU2+n6KCwouWZ1LzaMgqrtHLsGIA+wwIUTx2xdm6VVO6Jy40RUaH
         Kkcxh1g9jo28QHCg6k/Z8PTxWkWJ73H7Nck6Ctix4tkZE7h8DDAocWowUBMKO/dRJCGb
         qaB9bPgCvigwMkrfGRKwnO0hI3Q+Hu9LF63sgJD+BFYa+kvdYpgKOISkwdTBI09j8pLr
         iWOw==
X-Gm-Message-State: AC+VfDy+lR1Ks7tBj5P+Pm9rCd2zPrOKmC7ycATiInqWemqSRavTlC4p
        dfdZH+jaEzl+uWN7u9uXffxisg==
X-Google-Smtp-Source: ACHHUZ4b34bw7rZc9L7px3h6EUsiEBtUzLuZldpOt5NSLbXfKgtYiPS99hwUcfBulL/R+vof/etEuQ==
X-Received: by 2002:a05:6a00:3a14:b0:668:82fe:16e2 with SMTP id fj20-20020a056a003a1400b0066882fe16e2mr22096409pfb.16.1687985975628;
        Wed, 28 Jun 2023 13:59:35 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id u23-20020aa78497000000b0067aa2a70179sm4146384pfn.46.2023.06.28.13.59.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 13:59:34 -0700 (PDT)
Date:   Wed, 28 Jun 2023 13:59:34 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Julian Pidancet <julian.pidancet@oracle.com>
Cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        Rafael Aquini <aquini@redhat.com>
Subject: Re: [PATCH] mm/slub: disable slab merging in the default
 configuration
Message-ID: <202306281358.E6E6C2759@keescook>
References: <20230627132131.214475-1-julian.pidancet@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230627132131.214475-1-julian.pidancet@oracle.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 27, 2023 at 03:21:31PM +0200, Julian Pidancet wrote:
> Make CONFIG_SLAB_MERGE_DEFAULT default to n unless CONFIG_SLUB_TINY is
> enabled. Benefits of slab merging is limited on systems that are not
> memory constrained: the overhead is negligible and evidence of its
> effect on cache hotness is hard to come by.
> 
> On the other hand, distinguishing allocations into different slabs will
> make attacks that rely on "heap spraying" more difficult to carry out
> with success.
> 
> Take sides with security in the default kernel configuration over
> questionnable performance benefits/memory efficiency.
> 
> Signed-off-by: Julian Pidancet <julian.pidancet@oracle.com>
> ---
> In an attempt to assess the performance impact of disabling slab
> merging, a timed linux kernel compilation test has been conducted first
> using slab_merge, then using slab_nomerge. Both tests started in an
> identical state.  Commodity hardware was used: a laptop with an AMD Ryzen
> 5 3500U CPU, and 16GiB of RAM. The kernel source files were placed on
> an XFS partition because of the extensive use of slab caches in XFS.
> 
> The results are as follows:
> 
>       | slab_merge       | slab_nomerge     |
> ------+------------------+------------------|
> Time  | 489.074 ± 10.334 | 489.975 ± 10.350 |
> Min   |          459.688 |          460.554 |
> Max   |          493.126 |          494.282 |
> 
> The benchmark favors the configuration where merging is disabled, but the
> difference is only ~0.18%, well under statistical significance.

As mentioned, please include these kinds of perf notes in the commit
log; it's useful to see later. :)

Regardless, yes, please. I have been running slab_nomerge on all my
systems for years and years now.

With the typo fixed and commit log updated, please consider this:

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

-- 
Kees Cook
