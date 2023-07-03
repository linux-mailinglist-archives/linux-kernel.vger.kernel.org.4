Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42614745320
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 02:09:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229899AbjGCAJQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jul 2023 20:09:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjGCAJO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jul 2023 20:09:14 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD64A1B7
        for <linux-kernel@vger.kernel.org>; Sun,  2 Jul 2023 17:09:13 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1b52875b8d9so272145ad.0
        for <linux-kernel@vger.kernel.org>; Sun, 02 Jul 2023 17:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688342953; x=1690934953;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jb4GeIrc9P/pQH3ByeVCMb+DRHFR85yXe4TsMAD4d3Q=;
        b=LJzCZsVl+EExK5eipuc9pcTlYtaOz/i9LD/+MjFdKqmWqQe6VAuwSEF4/oLsgbeqju
         eSYgtvU5XdoBMgID2GYvrRFwsWFbQ/6qwYJyYnXU8aF2ExRDbabXa/rwF2mEgNyLgUah
         QdJzxH7yCAQqWL+s8ntnRNQ5wB6UtdiD6N6zgkjJ6OhS4NvbAnYMED9VD4Mu4VQlMS+i
         HdWpc+w6i9FfJ1lLZcy4oGIrhO4tZsoprkkc0ZKaPS23aFoeo6phmExzXoacByLUbsCo
         2tJx/V428/q45ZxL/NJnvNxohz++6zRqGvzP9Wdq94xguI3H7BbBDaEx1/6IN02gOW5X
         8F2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688342953; x=1690934953;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jb4GeIrc9P/pQH3ByeVCMb+DRHFR85yXe4TsMAD4d3Q=;
        b=RFHGIdVveclGGOpk6yLml6Vr1GMhyAa0haBJejtGRxxB6sjJlMbvSXTTM/9FHWkwLC
         bdjRf8iebQXKn1rirlrxC2fjYaea1udMP9ywZWVXZDENyuqP6Abjjo60MIW9xulIuToz
         DJcsWUeBLfiKGlvttRlP2d7LH8f4GlnmuI1hvTbzUCm9vO+4QXxHBcTDaAPmmOYhZN15
         6KPiay7i5Y8BQavs2pbaQ8dvjX7QXa4M57OFVCHFeIRhBhfLSkSHR8yJ3kX91o48wvEu
         9A9ztfiudwVUYWqUsYXoeKQs4TaiKla2ZcZBMeQCprHD93njkrb/YCAmKlwohrHDLlL3
         BrsQ==
X-Gm-Message-State: ABy/qLYXvOVFCjU6bkmDib+dgcw5oNTzMPnSPIY8/j6P1ESwzQ728F/q
        OqIfyyfOYszURGCPwez+4SkH7w==
X-Google-Smtp-Source: APBJJlH23TcE4Z/nu6BSjuwfnnS+VU9MtqskrHpVVc3C77p3DlfwT/7nBIf1hrTcH1RevkMg/h8/aQ==
X-Received: by 2002:a17:902:da8f:b0:1b8:9044:91d3 with SMTP id j15-20020a170902da8f00b001b8904491d3mr134115plx.18.1688342953045;
        Sun, 02 Jul 2023 17:09:13 -0700 (PDT)
Received: from [2620:0:1008:15:f9d4:d371:9d50:fcd6] ([2620:0:1008:15:f9d4:d371:9d50:fcd6])
        by smtp.gmail.com with ESMTPSA id p15-20020a63e64f000000b0051b0e564963sm13911327pgj.49.2023.07.02.17.09.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Jul 2023 17:09:12 -0700 (PDT)
Date:   Sun, 2 Jul 2023 17:09:11 -0700 (PDT)
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
In-Reply-To: <20230629221910.359711-1-julian.pidancet@oracle.com>
Message-ID: <38083ed2-333b-e245-44e4-2f355e4f9249@google.com>
References: <20230629221910.359711-1-julian.pidancet@oracle.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="2003067076-267791279-1688342952=:3716371"
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--2003067076-267791279-1688342952=:3716371
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Fri, 30 Jun 2023, Julian Pidancet wrote:

> Make CONFIG_SLAB_MERGE_DEFAULT default to n unless CONFIG_SLUB_TINY is
> enabled. Benefits of slab merging is limited on systems that are not
> memory constrained: the memory overhead is low and evidence of its
> effect on cache hotness is hard to come by.
> 
> On the other hand, distinguishing allocations into different slabs will
> make attacks that rely on "heap spraying" more difficult to carry out
> with success.
> 
> Take sides with security in the default kernel configuration over
> questionnable performance benefits/memory efficiency.
> 
> A timed kernel compilation test, on x86 with 4K pages, conducted 10
> times with slab_merge, and the same test then conducted with
> slab_nomerge on the same hardware in a similar state do not show any
> sign of performance hit one way or another:
> 
>       | slab_merge       | slab_nomerge     |
> ------+------------------+------------------|
> Time  |  588.080 ± 0.799 |  587.308 ± 1.411 |
> Min   |          586.267 |          584.640 |
> Max   |          589.248 |          590.091 |
> 
> Peaks in slab usage during the test workload reveal a memory overhead
> of 2.2 MiB when using slab_nomerge. Slab usage overhead after a fresh boot
> amounts to 2.3 MiB:
> 
> Slab Usage         | slab_merge | slab_nomerge |
> -------------------+------------+--------------|
> After fresh boot   |   79908 kB |     82284 kB |
> During test (peak) |  127940 kB |    130204 kB |
> 
> Signed-off-by: Julian Pidancet <julian.pidancet@oracle.com>
> Reviewed-by: Kees Cook <keescook@chromium.org>

Thanks for continuing to work on this.

I think we need more data beyond just kernbench.  Christoph's point about 
different page sizes is interesting.  In the above results, I don't know 
the page orders for the various slab caches that this workload will 
stress.  I think the memory overhead data may be different depending on 
how slab_max_order is being used, if at all.

We should be able to run this through a variety of different benchmarks 
and measure peak slab usage at the same time for due diligence.  I support 
the change in the default, I would just prefer to know what the 
implications of it is.

Is it possible to collect data for other microbenchmarks and real-world 
workloads?  And perhaps also with different page sizes where this will 
impact memory overhead more?  I can help running more workloads once we 
have the next set of data.

> ---
> 
> v2:
>   - Re-run benchmark to minimize variance in results due to CPU
>     frequency scaling.
>   - Record slab usage after boot and peaks during tests workload.
>   - Include benchmark results in commit message.
>   - Fix typo: s/MEGE/MERGE/.
>   - Specify that "overhead" refers to memory overhead in SLUB doc.
> 
> v1:
>   - Link: https://lore.kernel.org/linux-mm/20230627132131.214475-1-julian.pidancet@oracle.com/
> 
>  .../admin-guide/kernel-parameters.txt         | 29 ++++++++++---------
>  Documentation/mm/slub.rst                     |  7 +++--
>  mm/Kconfig                                    |  6 ++--
>  3 files changed, 22 insertions(+), 20 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index c5e7bb4babf0..7e78471a96b7 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -5652,21 +5652,22 @@
>  
>  	slram=		[HW,MTD]
>  
> -	slab_merge	[MM]
> -			Enable merging of slabs with similar size when the
> -			kernel is built without CONFIG_SLAB_MERGE_DEFAULT.
> -
>  	slab_nomerge	[MM]
> -			Disable merging of slabs with similar size. May be
> -			necessary if there is some reason to distinguish
> -			allocs to different slabs, especially in hardened
> -			environments where the risk of heap overflows and
> -			layout control by attackers can usually be
> -			frustrated by disabling merging. This will reduce
> -			most of the exposure of a heap attack to a single
> -			cache (risks via metadata attacks are mostly
> -			unchanged). Debug options disable merging on their
> -			own.
> +			Disable merging of slabs with similar size when
> +			the kernel is built with CONFIG_SLAB_MERGE_DEFAULT.
> +			Allocations of the same size made in distinct
> +			caches will be placed in separate slabs. In
> +			hardened environment, the risk of heap overflows
> +			and layout control by attackers can usually be
> +			frustrated by disabling merging.
> +
> +	slab_merge	[MM]
> +			Enable merging of slabs with similar size. May be
> +			necessary to reduce overhead or increase cache
> +			hotness of objects, at the cost of increased
> +			exposure in case of a heap attack to a single
> +			cache. (risks via metadata attacks are mostly
> +			unchanged).
>  			For more information see Documentation/mm/slub.rst.
>  
>  	slab_max_order=	[MM, SLAB]
> diff --git a/Documentation/mm/slub.rst b/Documentation/mm/slub.rst
> index be75971532f5..0e2ce82177c0 100644
> --- a/Documentation/mm/slub.rst
> +++ b/Documentation/mm/slub.rst
> @@ -122,9 +122,10 @@ used on the wrong slab.
>  Slab merging
>  ============
>  
> -If no debug options are specified then SLUB may merge similar slabs together
> -in order to reduce overhead and increase cache hotness of objects.
> -``slabinfo -a`` displays which slabs were merged together.
> +If the kernel is built with ``CONFIG_SLAB_MERGE_DEFAULT`` or if ``slab_merge``
> +is specified on the kernel command line, then SLUB may merge similar slabs
> +together in order to reduce memory overhead and increase cache hotness of
> +objects.  ``slabinfo -a`` displays which slabs were merged together.
>  

Suggest mentioning that one of the primary goals of slab cache merging is 
to reduce cache footprint.

>  Slab validation
>  ===============
--2003067076-267791279-1688342952=:3716371--
