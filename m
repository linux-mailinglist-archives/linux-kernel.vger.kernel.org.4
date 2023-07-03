Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16C827463EC
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 22:18:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbjGCUSI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 16:18:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230299AbjGCUR4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 16:17:56 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F74DE70
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 13:17:55 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1b82afd519fso381885ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jul 2023 13:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688415474; x=1691007474;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=M1oX1CfdxJh2QCcl3/DLFnwZiVfUuA9OMZRWZ3EO/94=;
        b=xSLVADKndPZ0kY+x4ESRJlpoZAVzR4TY3YjkqLF1Hk/DhmnHaBsKsRR5MAsprR8yTg
         kDJTc0gIXXIXAJ/Ulo+S23CUqdNHby/32ubaUn30tcZOs3uhjyQPWFoEOxnEuC/juxJV
         zo30mDnfTmv4xELZ3I05WiIGyAUhGo92NTwDNdXqlewgrvNqKWIeGk83RYWLvVlyzUry
         RB6N4FowyeKXfBeqTnFA1Fzui6ZsSR+KehYXra9P13eVoIg81VdDNYRRgGoW6dlj9uPY
         B3OjbSylm2ySCim1uOBfw0mBWsOVkWJfwYC4sg1AzlEIIxAjZcOvita9Q0/EKbIJQIt1
         X/tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688415474; x=1691007474;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M1oX1CfdxJh2QCcl3/DLFnwZiVfUuA9OMZRWZ3EO/94=;
        b=S4NzZfvYGXEdwh8PaH2DhjOsMuIO7a0un9x90wrMaLLJ6Raux3rO5vq4/5PRcLvdaQ
         UIGoYd+uDCBu28iLUlo7dwKwjOR06m+u/MQBi2+LPFOBdLeJhEyReeOreWKa5Jh5HMnN
         5WLJvnAzLV+R5n+UGabBd238R8L+ntpMQpYqYUxUOo/BBjaW4b3T9E4EQ8saICQ16HIu
         neIE2lC3kxiwoDiAkdMeNXZ+GYXMSu3jylJGicCqxnvObb0dDwT2mv+1EJBsT8ZDxGIK
         0/RntEHaTBael4RdOKdmVw+y/0U+UxVBytlo3gddylgmhz5VG5nnKqbny9Je3dcgFWvA
         LTfw==
X-Gm-Message-State: ABy/qLalAxxRP0yP9JO3bQ3J7HUMODCUcPvxygrwf+5ET1GfcyjHkijP
        Y1DwL639Oxh/6YULBIyN+hfc+gkKlcbIvBD+5LknMA==
X-Google-Smtp-Source: APBJJlHQXopX54fvX7CKUl1nWzeJsezc2kAAc7nqyiwzFaW+CH27dFqDPk6GxjU2uLlr/lONGgf7xQ==
X-Received: by 2002:a17:903:22cf:b0:1b3:db56:9ca9 with SMTP id y15-20020a17090322cf00b001b3db569ca9mr24700plg.2.1688415474481;
        Mon, 03 Jul 2023 13:17:54 -0700 (PDT)
Received: from [2620:0:1008:15:17fc:1b56:71df:89b7] ([2620:0:1008:15:17fc:1b56:71df:89b7])
        by smtp.gmail.com with ESMTPSA id q14-20020a170902dace00b001b893b689a0sm2600392plx.84.2023.07.03.13.17.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jul 2023 13:17:54 -0700 (PDT)
Date:   Mon, 3 Jul 2023 13:17:53 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
To:     Julian Pidancet <julian.pidancet@oracle.com>
cc:     Christoph Lameter <cl@linux.com>,
        "Lameter, Christopher" <cl@os.amperecomputing.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Rafael Aquini <aquini@redhat.com>
Subject: Re: [PATCH v2] mm/slub: disable slab merging in the default
 configuration
In-Reply-To: <CTSGWINSM18Q.3HQ1DN27GNA1R@imme>
Message-ID: <8813897d-4a52-37a0-fe44-a9157716be9b@google.com>
References: <20230629221910.359711-1-julian.pidancet@oracle.com> <38083ed2-333b-e245-44e4-2f355e4f9249@google.com> <CTSGWINSM18Q.3HQ1DN27GNA1R@imme>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Jul 2023, Julian Pidancet wrote:

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

Thanks.  I think arm64 should suffice for things like 64KB pages that 
Christoph was referring to.

We also may want to play around with slub_min_order on the kernel command 
line since that will inflate the size of slab pages and we may see some 
different results because of the increased page size.

> Do you have specific tests or workload in mind ? Compiling the kernel
> with files sitting on an XFS partition is not exhaustive but it is the
> only test I could think of that is both easy to set up and can be 
> reproduced while keeping external interferences as little as possible.
> 

The ones that Binder, cc'd, used to evaluate SLAB vs SLUB memory overhead:

hackbench
netperf
redis
specjbb2015
unixbench
will-it-scale

And Vlastimil had also suggested a few XFS specific benchmarks.

I can try to help run benchmarks that you're not able to run or if you 
can't get your hands on an arm64 system.

Additionally, I wouldn't consider this to be super urgent: slab cache 
merging has been this way for several years, we have some time to do an 
assessment of the implications of changing an important aspect of kernel 
memory allocation that will affect everybody.  I agree with the patch if 
we can make it work, I'd just like to study the effect of it more fully 
beyond some kernbench runs.
