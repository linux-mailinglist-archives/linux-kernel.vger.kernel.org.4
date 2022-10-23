Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37CEF60908F
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Oct 2022 02:42:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbiJWAmf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Oct 2022 20:42:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbiJWAmd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 20:42:33 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40C6B7990F
        for <linux-kernel@vger.kernel.org>; Sat, 22 Oct 2022 17:42:32 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id p127so7374098oih.9
        for <linux-kernel@vger.kernel.org>; Sat, 22 Oct 2022 17:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=cPzp800k6N3WRemPfpaZ33nVr+8Go0OaG+uQGTl/BQU=;
        b=X1vMU61XOedcPtVdFWIjziSbsAT/xPSngCFd0Z75xqxrx1ic+/UBYxYFLt4NFPB4so
         jNcLFwxO3SlcEtvzYatCILSRMyYPtqB+YCythMzc+yyEwBwX3Z7qrVMxGUta6wytJbWB
         m+d9Ust5Xz5zU4CJnQqVhSYx2xSJm+ftrT/8olCTMdL7xwHdHCcoWHQCSoVBk1gy+zia
         mi6isN7tqZO7S2grC2VvXOqcjCa7maGd/LwUf6TJRmikuSRafcKt1UNrrjycMsjEiDTv
         3/YxQCfss9LAtQ25E4fZC7Ai35RvwhMhwnOVT/3n9Kt+p8MUr2ZyzQclI0BoYbOMNd07
         GeRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cPzp800k6N3WRemPfpaZ33nVr+8Go0OaG+uQGTl/BQU=;
        b=BzemhSnLj3t8oi+UHdB071HDVGqJaPHbmMgkU1AutAarsaow808skCmhYqk16aXA9S
         9PA6d8SwgdOMsdyyKvvkXCZ8u+/l6gKD32Iz3nSjy4++G9X+Twwa/YklvKTOCO+Ofelj
         5s6ikGhgVP7xheuRnsS1nEiaWnW3JA5qcGkluWY3PDIREY3a4/D8rp8wx/T0U6pdLrOw
         9iJltB5uTr+LQJLn+f3UiMrGc8OlKQbaJd2eKsYsavU3E/8D5gRc1n/s6JbyIr9RyPb9
         Px4qKnEryX0dnnnNdku+2WKI4nhV2xPAqziz1H/RfdA1ZoOZSkFeC4v4kywHCuwLLxkC
         Q6CQ==
X-Gm-Message-State: ACrzQf0jR1wLel1jLxgy89UVV+HiiGV7gIYQ6ff92c4c2EJHDEmZEm6D
        2zYEzhi977FUroHEvHAT7EgOmA==
X-Google-Smtp-Source: AMsMyM5TcnvLBBT6TzSF/PgJ7PGT2QBS5WCEWyT2wyaIJ22WXqjCfDckhdvo9U68sRoCfiBKYh/Fmw==
X-Received: by 2002:a05:6808:2387:b0:355:2641:aff5 with SMTP id bp7-20020a056808238700b003552641aff5mr13463007oib.44.1666485751483;
        Sat, 22 Oct 2022 17:42:31 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id a4-20020a544e04000000b003539686cb7bsm1758171oiy.53.2022.10.22.17.42.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Oct 2022 17:42:30 -0700 (PDT)
Date:   Sat, 22 Oct 2022 17:42:18 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Peter Zijlstra <peterz@infradead.org>
cc:     Will Deacon <will@kernel.org>, x86@kernel.org, willy@infradead.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        aarcange@redhat.com, kirill.shutemov@linux.intel.com,
        jroedel@suse.de, ubizjak@gmail.com
Subject: Re: [PATCH 07/13] mm/gup: Fix the lockless PMD access
In-Reply-To: <20221022114424.906110403@infradead.org>
Message-ID: <796cff9b-8eb8-8c53-9127-318d30618952@google.com>
References: <20221022111403.531902164@infradead.org> <20221022114424.906110403@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 22 Oct 2022, Peter Zijlstra wrote:

> On architectures where the PTE/PMD is larger than the native word size
> (i386-PAE for example), READ_ONCE() can do the wrong thing. Use
> pmdp_get_lockless() just like we use ptep_get_lockless().

I thought that was something Will Deacon put a lot of effort
into handling around 5.8 and 5.9: see "strong prevailing wind" in
include/asm-generic/rwonce.h, formerly in include/linux/compiler.h.

Was it too optimistic?  Did the wind drop?

I'm interested in the answer, but I've certainly no objection
to making this all more obviously robust - thanks.

Hugh

> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  kernel/events/core.c |    2 +-
>  mm/gup.c             |    2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -7186,7 +7186,7 @@ static u64 perf_get_pgtable_size(struct
>  		return pud_leaf_size(pud);
>  
>  	pmdp = pmd_offset_lockless(pudp, pud, addr);
> -	pmd = READ_ONCE(*pmdp);
> +	pmd = pmdp_get_lockless(pmdp);
>  	if (!pmd_present(pmd))
>  		return 0;
>  
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -2507,7 +2507,7 @@ static int gup_pmd_range(pud_t *pudp, pu
>  
>  	pmdp = pmd_offset_lockless(pudp, pud, addr);
>  	do {
> -		pmd_t pmd = READ_ONCE(*pmdp);
> +		pmd_t pmd = pmdp_get_lockless(pmdp);
>  
>  		next = pmd_addr_end(addr, end);
>  		if (!pmd_present(pmd))
