Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56B6D74629B
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 20:39:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230432AbjGCSjF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 14:39:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231443AbjGCSjD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 14:39:03 -0400
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75C1D137
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 11:39:01 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-1b059dd7c0cso4893946fac.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jul 2023 11:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1688409541; x=1691001541;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sQGLILnEm5o54v5mjoZuL1G4hwG+jcIWjoHZArQ7sfk=;
        b=TjYUycTB4yuvx5ehjMW5FUH2ojidBdmp5i/WiVqXu+7LfXtLH9WYMJfpxHuBo3pWMD
         WY6uw+rpIJyWJqXuqv5pPjrgnMvsxBc8QD/twEyWAKNCSJsEHh27WAqC6ireChp6/cxz
         8AaKaWKpyMjoWxbAXuDtkYLDH6Quef8XphzXY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688409541; x=1691001541;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sQGLILnEm5o54v5mjoZuL1G4hwG+jcIWjoHZArQ7sfk=;
        b=ezvk+0341RT7dRNWfr3620HwnSwkIEJfwPxoKD5CrXMNSw1JAAn1CKnUr0A9fleTMB
         KTcb6GnmaJtlVU7Hmyt6II82Z7/JCw05e6JD1Cc+csLSv8gZ/f4TQeTRlin45Tz/vD4h
         LHuN2ItohoqpvvM4pTvDZAwJ7M0XWYcGOqOr3ES6Yf0R96M0oq6MEGiGwQ/5XAnEw49T
         JrzuJ+abZYyRpQN4k2a7v4SrpRH68xzjyvU0BGHfo2W+obwMY3uN/cVBQSiThfHGs5JB
         hfFiQwiV3BVV4Hln5PFuxatS6WljF39LOkFIQo2jnYIEuScWPpleITytXH+C19DTEiv/
         gUkA==
X-Gm-Message-State: ABy/qLaoSep7CnUQoXGufFeIxnWfP+DH2C9Ut/T2JrJLcbiBG6SJ/aQV
        gjthsarqpXdlj0yVVBs+UFGt4w==
X-Google-Smtp-Source: APBJJlGzQQ+aH4qGk5swZiGJO2jJp4bAEzIR9cOZM+LgHCchTn/+W51ZdhmJ8ULaSS4QVRHPIt49OQ==
X-Received: by 2002:a05:6870:ac0c:b0:1b0:6e5b:21d6 with SMTP id kw12-20020a056870ac0c00b001b06e5b21d6mr14898753oab.38.1688409540823;
        Mon, 03 Jul 2023 11:39:00 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id m17-20020a17090ade1100b00263987a50fcsm4614022pjv.22.2023.07.03.11.39.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jul 2023 11:39:00 -0700 (PDT)
Date:   Mon, 3 Jul 2023 11:38:59 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Julian Pidancet <julian.pidancet@oracle.com>
Cc:     David Rientjes <rientjes@google.com>,
        Christoph Lameter <cl@linux.com>,
        "Lameter, Christopher" <cl@os.amperecomputing.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        Rafael Aquini <aquini@redhat.com>
Subject: Re: [PATCH v2] mm/slub: disable slab merging in the default
 configuration
Message-ID: <202307031137.87508EB@keescook>
References: <20230629221910.359711-1-julian.pidancet@oracle.com>
 <38083ed2-333b-e245-44e4-2f355e4f9249@google.com>
 <CTSGWINSM18Q.3HQ1DN27GNA1R@imme>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CTSGWINSM18Q.3HQ1DN27GNA1R@imme>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 03, 2023 at 12:33:25PM +0200, Julian Pidancet wrote:
> On Mon Jul 3, 2023 at 02:09, David Rientjes wrote:
> > I think we need more data beyond just kernbench.  Christoph's point about 
> > different page sizes is interesting.  In the above results, I don't know 
> > the page orders for the various slab caches that this workload will 
> > stress.  I think the memory overhead data may be different depending on 
> > how slab_max_order is being used, if at all.
> >
> > We should be able to run this through a variety of different benchmarks 
> > and measure peak slab usage at the same time for due diligence.  I support 
> > the change in the default, I would just prefer to know what the 
> > implications of it is.
> >
> > Is it possible to collect data for other microbenchmarks and real-world 
> > workloads?  And perhaps also with different page sizes where this will 
> > impact memory overhead more?  I can help running more workloads once we 
> > have the next set of data.
> >
> 
> David,
> 
> I agree about the need to perform those tests on hardware using larger
> pages. I will collect data if I have the chance to get my hands on one
> of these systems.
> 
> Do you have specific tests or workload in mind ? Compiling the kernel
> with files sitting on an XFS partition is not exhaustive but it is the
> only test I could think of that is both easy to set up and can be 
> reproduced while keeping external interferences as little as possible.

I think it is a sufficiently complicated heap allocation workload (and
real-world). I'd prefer we get this change landed in -next after -rc1 so
we can see if there are any regressions reported by the 0day and other
CI performance tests.

-Kees

-- 
Kees Cook
