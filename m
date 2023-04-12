Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12F906DFD14
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 19:55:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbjDLRzC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 13:55:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230004AbjDLRyz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 13:54:55 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87F2CE45
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 10:54:54 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1a273b3b466so137365ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 10:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681322094; x=1683914094;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=KzjQyPk8ItloD0n11E/8AENdtb3dyPJg1fPMRZLAN5Q=;
        b=mobXcbVlLT8tTfyGzA//t5dhW+n7PAMhBLJdr6MsF4thikk+w9JRNzjt/sNEFbfvif
         WzEZNi8yT0IV4CWlWSeuVnVCn5FrlDYcqDRfQ9Drh4igJOGU70EPnixZOIppLtPPuzQK
         73w4IfICCDDax77WX54qme+vgYqRVvTmQbM9FUA7qs8taN36maVynqBUkkfMvRm3rqi3
         eOVdDwh8Vbq2hoZNA4HIHX3aRSVBj53vDco8YNZuGkba3dOUUqcnlLojtOv4mtpFyT50
         LhLKHciOjo6E47/RAUS6uJ7bN69hC19ZxSkx5Ec1AtpYBDlo1IXZco5l5QqThOsfaTYc
         0+vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681322094; x=1683914094;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KzjQyPk8ItloD0n11E/8AENdtb3dyPJg1fPMRZLAN5Q=;
        b=QA/U1uhnZ20oqInznyJlsjtCN8PyQSpmkeB5lttJXSwI/mVe/1cvlWdahnqZmQM6fY
         7y1z6Wguv6zHB5snOIllRQAwimGr/IykA5JCIBPgSUJoc24Kpbf1UVGvafoeRH4xpHSU
         z2oJwAnv65XHoaEymOif6t/ArkFboue0qYBODv4jSr7U+PPorWKvFXbG6iGKFMy8JihS
         rLs7uBb4nRMuQV7n7m7Pn6jEHeV95LWVNDIfMcBoMXIunP5M50DP/ziXHO3X+CfuceEk
         FGcYRofDjBFGqq3PXA9c1Kaidkji4e0wCuJ17/cIWcBchcF3wr9ySQkkss8qd3GyjXDN
         B7Nw==
X-Gm-Message-State: AAQBX9fN9VsAWTkkmnaiShBvxWjLtqvz+OX540LYRWs+WauKblw8e0Rk
        vbEtwo40VZI9/x0ipXbHpQRjrkg83+kVA3obP0ZBIA==
X-Google-Smtp-Source: AKy350bhDki0PDMoioLTk5kHyac9ucwOJGU23Q/RGh3Ai6Y5Qw8nbEgU/ftHkBUZGzdk/rgmuCcIsw==
X-Received: by 2002:a17:903:1351:b0:1a5:2e85:94a1 with SMTP id jl17-20020a170903135100b001a52e8594a1mr701496plb.14.1681322093749;
        Wed, 12 Apr 2023 10:54:53 -0700 (PDT)
Received: from [2620:0:1008:11:7e3f:e20c:7479:83ea] ([2620:0:1008:11:7e3f:e20c:7479:83ea])
        by smtp.gmail.com with ESMTPSA id w7-20020a170902904700b0019fcece6847sm11896383plz.227.2023.04.12.10.54.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 10:54:53 -0700 (PDT)
Date:   Wed, 12 Apr 2023 10:54:52 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
To:     Pasha Tatashin <pasha.tatashin@soleen.com>
cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, mike.kravetz@oracle.com,
        muchun.song@linux.dev, souravpanda@google.com
Subject: Re: [PATCH] mm: hugetlb_vmemmap: provide stronger vmemmap allocaction
 gurantees
In-Reply-To: <20230412152337.1203254-1-pasha.tatashin@soleen.com>
Message-ID: <63736432-5cef-f67c-c809-cc19b236a7f4@google.com>
References: <20230412152337.1203254-1-pasha.tatashin@soleen.com>
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

On Wed, 12 Apr 2023, Pasha Tatashin wrote:

> HugeTLB pages have a struct page optimizations where struct pages for tail
> pages are freed. However, when HugeTLB pages are destroyed, the memory for
> struct pages (vmemmap) need to be allocated again.
> 
> Currently, __GFP_NORETRY flag is used to allocate the memory for vmemmap,
> but given that this flag makes very little effort to actually reclaim
> memory the returning of huge pages back to the system can be problem. Lets
> use __GFP_RETRY_MAYFAIL instead. This flag is also performs graceful
> reclaim without causing ooms, but at least it may perform a few retries,
> and will fail only when there is genuinely little amount of unused memory
> in the system.
> 

Thanks Pasha, this definitely makes sense.  We want to free the hugetlb 
page back to the system so it would be a shame to have to strand it in the 
hugetlb pool because we can't allocate the tail pages (we want to free 
more memory than we're allocating).

> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> Suggested-by: David Rientjes <rientjes@google.com>
> ---
>  mm/hugetlb_vmemmap.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
> index a559037cce00..c4226d2af7cc 100644
> --- a/mm/hugetlb_vmemmap.c
> +++ b/mm/hugetlb_vmemmap.c
> @@ -475,9 +475,12 @@ int hugetlb_vmemmap_restore(const struct hstate *h, struct page *head)
>  	 * the range is mapped to the page which @vmemmap_reuse is mapped to.
>  	 * When a HugeTLB page is freed to the buddy allocator, previously
>  	 * discarded vmemmap pages must be allocated and remapping.
> +	 *
> +	 * Use __GFP_RETRY_MAYFAIL to fail only when there is genuinely little
> +	 * unused memory in the system.
>  	 */
>  	ret = vmemmap_remap_alloc(vmemmap_start, vmemmap_end, vmemmap_reuse,
> -				  GFP_KERNEL | __GFP_NORETRY | __GFP_THISNODE);
> +				  GFP_KERNEL | __GFP_RETRY_MAYFAIL | __GFP_THISNODE);
>  	if (!ret) {
>  		ClearHPageVmemmapOptimized(head);
>  		static_branch_dec(&hugetlb_optimize_vmemmap_key);

The behavior of __GFP_RETRY_MAYFAIL is different for high-order memory (at 
least larger than PAGE_ALLOC_COSTLY_ORDER).  The order that we're 
allocating would depend on the implementation of alloc_vmemmap_page_list() 
so likely best to move the gfp mask to that function.
