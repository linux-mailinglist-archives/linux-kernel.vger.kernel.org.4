Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 750F5648B66
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Dec 2022 00:33:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbiLIXdG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 18:33:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229805AbiLIXcw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 18:32:52 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE7C719013
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 15:32:50 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id w23so6442389ply.12
        for <linux-kernel@vger.kernel.org>; Fri, 09 Dec 2022 15:32:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PsjUrCmjp7FmfYD7hjJ6UzqwulgZQ2pA63rcF+O/yBo=;
        b=Ti2GtzRFVhzwFT8R0jufd/vN6tWgWCDbrR7wEDRxx9m15VuNR+vaasVa2n5wlFkJpM
         Ji2421AVLAN95r+FVdxbg75f7IAOv5hvQjm5DqWWdIAVAU2W9FeuhTMIsu/Sr2ZYGl0v
         KccVHs5xn5lWQfbRDQZy+IWlgHG+csxFOEg9EsxyWt74hfG837eYjJF5cVabo3O19t1z
         Rz1PXsOwhqn5okePOSVRwD/SnO03sUg/PCagS05CiNAIQwKDL5gYx9uIorJfDEJQ3XRD
         z2uxyN8o6nNK31DfX6M1/EgBKJBJqdEHOGDVmaYIaeD4Wy7HB2arc5Qk2D/ephqonQm7
         DyiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PsjUrCmjp7FmfYD7hjJ6UzqwulgZQ2pA63rcF+O/yBo=;
        b=hiOolClJ962eZ6GOdmV7Oc1FL/9j4KnmmLcNUJT1LvXAv0Efu86BbjTh/rOBD8uUPg
         LwvDYvgQjVc6Wi3DfycUvOfeBdIoBmx782KHKMVf/B70vrJm2QH9dN3SzFsU9Y0KR7Ph
         wYJs6XlHWMVZdinGCTxCbJ8qMaRDhU7s601xzDaTABBUYfmQHOEGUDCGkniU0GCasFHV
         hfT/pFxR+bZq53rP7DmLX/i4RJZxVMkmMVeYL39vdYRNzlmQsxWb+BA8bFHLBbpIwTV5
         zX2+EZoaD+3Wll6Z2TtQxIssUzvqTX3AoYVIi84uLuTSUYM2bVgjA6tRymIFirLgsDSv
         4kog==
X-Gm-Message-State: ANoB5pnI0HFsbtG7xd0fpLibn/H2+Gvf66k3cbGnT+wg/VML8/vNoOsm
        eBaJR5Ggm6gjWLZl0PooQb1ibw==
X-Google-Smtp-Source: AA0mqf72DJjFJLGEPCa02gwKQFAHIboEU/IT1dqI6LNDIjnRRH0RVxjhXBJ9DLQ0hsKbOAgWTPDu8A==
X-Received: by 2002:a17:902:ab0c:b0:189:d8fb:1523 with SMTP id ik12-20020a170902ab0c00b00189d8fb1523mr7514266plb.36.1670628770079;
        Fri, 09 Dec 2022 15:32:50 -0800 (PST)
Received: from google.com (223.103.125.34.bc.googleusercontent.com. [34.125.103.223])
        by smtp.gmail.com with ESMTPSA id i4-20020a170902e48400b001891b01addfsm1793358ple.274.2022.12.09.15.32.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Dec 2022 15:32:49 -0800 (PST)
Date:   Fri, 9 Dec 2022 15:32:45 -0800
From:   David Matlack <dmatlack@google.com>
To:     Ben Gardon <bgardon@google.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Peter Xu <peterx@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Vipin Sharma <vipinsh@google.com>
Subject: Re: [PATCH 3/7] KVM: x86/MMU: Move gfn_to_rmap() to rmap.c
Message-ID: <Y5PFnQBfjSCOVLTL@google.com>
References: <20221206173601.549281-1-bgardon@google.com>
 <20221206173601.549281-4-bgardon@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221206173601.549281-4-bgardon@google.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 06, 2022 at 05:35:57PM +0000, Ben Gardon wrote:
> Move gfn_to_rmap() to rmap.c. While the function is not part of
> manipulating the rmap, it is the main way that the MMU gets pointers to
> the rmaps.
> 
> No functional change intended.
> 
> Signed-off-by: Ben Gardon <bgardon@google.com>
> ---
[...]
> diff --git a/arch/x86/kvm/mmu/rmap.c b/arch/x86/kvm/mmu/rmap.c
> index c3bad366b627..272e89147d96 100644
> --- a/arch/x86/kvm/mmu/rmap.c
> +++ b/arch/x86/kvm/mmu/rmap.c
> @@ -200,3 +200,11 @@ u64 *rmap_get_next(struct rmap_iterator *iter)
>  	return sptep;
>  }
>  
> +struct kvm_rmap_head *gfn_to_rmap(gfn_t gfn, int level,
> +				  const struct kvm_memory_slot *slot)
> +{
> +	unsigned long idx;
> +
> +	idx = gfn_to_index(gfn, slot->base_gfn, level);
> +	return &slot->arch.rmap[level - PG_LEVEL_4K][idx];
> +}

Optional: Since this is such a short function maybe just make it a
static inline in rmap.h?
