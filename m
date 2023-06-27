Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B162740403
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 21:32:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbjF0TcV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 15:32:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbjF0TcU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 15:32:20 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D32B61BC3
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 12:32:17 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1b52875b8d9so33585ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 12:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687894337; x=1690486337;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ck21h6YvUFdrodIGjj6YsU+OWYBVIflql5oiEYBppsM=;
        b=SLlivscbvsR1PVQf5GVSNkbJ2yyQ76xW2h8F30oXjhTUb4nMDmTr7nvn0j9cDaRm0r
         DhW92Y68Ihi9JRL8OJ1OG0HY/EwZjhPPUicsv4v7vsW4/BV38ukoNsM5XcclyqoYQZD7
         Va67Z7ErZMtA2svIeftPoqkaPmQ6Vn7Y+kAXnricFTcFNAM119XeFqEETW9uJ/czqSai
         iuupc+e+x8ZLEbNLbxrxsX6vGXvwLiKoEoG9l4v5qWc2+pwYppsPVvsxACNDuPe8jhGu
         l9bSrQh2JzUdXPV71x3+YHM7N4DTRL8RJ/VTaGMeFQYsHP6y48oj3fyyEWKUfFxBfJtW
         viNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687894337; x=1690486337;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ck21h6YvUFdrodIGjj6YsU+OWYBVIflql5oiEYBppsM=;
        b=dRiCoIPbz9MS7tywxQ9QyKjnp0MBpt/hyBbLyfbvsfpgDxl4DqDVDnubvRQKAqZ++V
         c8Sys4pF6+7vImbk9atQAgzofmd1OKb2I5rCt5usJ3bW9aBBSSZ4Qiq+SMIv4iQuoUs/
         DBVAtiN73v/RY66Jmh2LUURvSyNgECM+U/L/H6+DocnmJS7naaGRqRg9rkAW8bEXEWwJ
         KoB8G7lDP3RBg4/K3OPqvOirnOpcAGr9xEJVu+NLZa9+Os+Cmj0Bqp9l7pzNmst9+pia
         Mpbv1HxJNCwlHI2plFu5+PN+nqmrTMilyA5rl7zRfzIViHpxmRndX+w+stWIQ6p7LZeP
         qvHA==
X-Gm-Message-State: AC+VfDx3QM+Z14VC7Y+F3WhrUAdNb8NnBNzhuzUgTgx2QRvWstE5VOjH
        cSYhAaBRJBbf6hRqnX2S2yrnRNq4XUYhj+rKCugZqQ==
X-Google-Smtp-Source: ACHHUZ6arFC51dXDUj/BzIkIsYYKV1kMOuQaZX0aowuibpY/Cz1H30KX128wSJWTPXqV6huFvB/TDw==
X-Received: by 2002:a17:902:ec91:b0:1b0:ceb:d67f with SMTP id x17-20020a170902ec9100b001b00cebd67fmr33959plg.8.1687894337073;
        Tue, 27 Jun 2023 12:32:17 -0700 (PDT)
Received: from [2620:0:1008:15:ab4c:7287:2273:1bd0] ([2620:0:1008:15:ab4c:7287:2273:1bd0])
        by smtp.gmail.com with ESMTPSA id iw4-20020a170903044400b001b80104446fsm4192320plb.20.2023.06.27.12.32.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jun 2023 12:32:16 -0700 (PDT)
Date:   Tue, 27 Jun 2023 12:32:15 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
To:     Julian Pidancet <julian.pidancet@oracle.com>
cc:     Christoph Lameter <cl@linux.com>,
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
Subject: Re: [PATCH] mm/slub: disable slab merging in the default
 configuration
In-Reply-To: <20230627132131.214475-1-julian.pidancet@oracle.com>
Message-ID: <48bd9819-3571-6b53-f1ad-ec013be742c0@google.com>
References: <20230627132131.214475-1-julian.pidancet@oracle.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="2003067076-1055337799-1687894336=:2486373"
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

--2003067076-1055337799-1687894336=:2486373
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Tue, 27 Jun 2023, Julian Pidancet wrote:

> Make CONFIG_SLAB_MERGE_DEFAULT default to n unless CONFIG_SLUB_TINY is
> enabled. Benefits of slab merging is limited on systems that are not
> memory constrained: the overhead is negligible and evidence of its
> effect on cache hotness is hard to come by.
> 

I don't have an objection to this, I think it makes sense.

When you say overhead here, I assume you're referring to memory footprint?  
Did you happen to have some system-wide numbers for what that looks like 
when running some benchmarks, or even what the slab usage looks like after 
a fresh boot?

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
> 

I think this data should be in the changelog itself, as well as any 
numbers to share on the memory footprint differences.

>  .../admin-guide/kernel-parameters.txt         | 29 ++++++++++---------
>  Documentation/mm/slub.rst                     |  5 ++--
>  mm/Kconfig                                    |  6 ++--
>  3 files changed, 21 insertions(+), 19 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 9e5bab29685f..5fbf6ed3c62e 100644
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
> index be75971532f5..e2549f4a98dd 100644
> --- a/Documentation/mm/slub.rst
> +++ b/Documentation/mm/slub.rst
> @@ -122,8 +122,9 @@ used on the wrong slab.
>  Slab merging
>  ============
>  
> -If no debug options are specified then SLUB may merge similar slabs together
> -in order to reduce overhead and increase cache hotness of objects.
> +If the kernel is built with ``CONFIG_SLAB_MEGE_DEFAULT`` or if ``slab_merge``

s/MEGE/MERGE/

> +is specified on the kernel command line, then SLUB may merge similar slabs
> +together in order to reduce overhead and increase cache hotness of objects.

Specify that this is memory overhead?

>  ``slabinfo -a`` displays which slabs were merged together.
>  
>  Slab validation
> diff --git a/mm/Kconfig b/mm/Kconfig
> index 7672a22647b4..05b0304302d4 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -255,7 +255,7 @@ config SLUB_TINY
>  
>  config SLAB_MERGE_DEFAULT
>  	bool "Allow slab caches to be merged"
> -	default y
> +	default n
>  	depends on SLAB || SLUB
>  	help
>  	  For reduced kernel memory fragmentation, slab caches can be
> @@ -264,8 +264,8 @@ config SLAB_MERGE_DEFAULT
>  	  overwrite objects from merged caches (and more easily control
>  	  cache layout), which makes such heap attacks easier to exploit
>  	  by attackers. By keeping caches unmerged, these kinds of exploits
> -	  can usually only damage objects in the same cache. To disable
> -	  merging at runtime, "slab_nomerge" can be passed on the kernel
> +	  can usually only damage objects in the same cache. To enable
> +	  merging at runtime, "slab_merge" can be passed on the kernel
>  	  command line.
>  
>  config SLAB_FREELIST_RANDOM
> -- 
> 2.40.1
> 
> 
--2003067076-1055337799-1687894336=:2486373--
