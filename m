Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3945659319
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 00:18:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229499AbiL2XSQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 18:18:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234079AbiL2XSN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 18:18:13 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBEB616582
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 15:18:12 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id k137so8727858pfd.8
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 15:18:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vWTQqj9fLeMGJngGnyZxH0IxP2qo9acI3FCjYeqg6Bs=;
        b=ID2SKEAfdHOaLFW3OT0zldsRVWOZF0Z1I0WzWXpBQr7JuHGQSbzVTFFPY89Xh95zl2
         ThArPmQ76At+xqL5aXRjf7cgMMTxwst1N6F+BF+63BVZCnZyzzFaeVEiPOa2OgufWVj5
         8LdqzblM6Hg/q2sxNN1+RY0hT09x/IKcYnYKzTlq3buUIlY1uA50hYhzByrNgnrSAu80
         7MkO+5KG4cRSnZVDDgwo0lJZspb98WgHx3iS6Im1ZRTjKlpiSMj6KR4LHLKhMd5sMwmg
         onyLOuaG9u1kHp6UxJAmAI7R0pj25xnkVLgVK1bylTomQRuwgiS2AlO0JCrDYnByfsQG
         Zggw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vWTQqj9fLeMGJngGnyZxH0IxP2qo9acI3FCjYeqg6Bs=;
        b=gmoa5HtL8b6SRSbSi9Odb+ZgqTEQDa1FN7yhiC8eU53xo2Ljh3qc7wN3dfK8ZS4bSe
         nh8TdBTRNimTxIiMH0JgEk2We+EyXJw75kx8wrxuly1NMU7PuVRdwSAY6nizyllesKUB
         Js1acMcxxZiZLBq/AUrUYPwmck3N93TqYP8UVQhcLkG594OTEjY5ZUtJhJ55vcS/60Mk
         TDATgE1E9ZlCXfUXmJeCLm/zKlMdiXodndVGDofI+s/PkC8y4uSgti2rutjJgenOC8jw
         uXv2P5koa6GPJQMgi5k27t+bLcFiDWrNSVLU7ilxCN2tWkb69HbqKRBQrHB3dLbT2dtU
         +jyQ==
X-Gm-Message-State: AFqh2kpK74Bf/7eVgO1jlZHiRp6slMRNo1OMtYckFzELTVlrMfcgouc/
        X8ZwdG4rCBvkGRud/N+kQ/tp3g==
X-Google-Smtp-Source: AMrXdXsD/4SlRAUBscl3FIEh3HuaboDmSyPc2XyDxIXuLC/dPSOSigcbjVHn9BM3WqBcq4wxBt9ohA==
X-Received: by 2002:a62:1791:0:b0:578:8533:9573 with SMTP id 139-20020a621791000000b0057885339573mr26006122pfx.22.1672355892200;
        Thu, 29 Dec 2022 15:18:12 -0800 (PST)
Received: from google.com (223.103.125.34.bc.googleusercontent.com. [34.125.103.223])
        by smtp.gmail.com with ESMTPSA id y65-20020a623244000000b00574db8ca00fsm12510101pfy.185.2022.12.29.15.18.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Dec 2022 15:18:11 -0800 (PST)
Date:   Thu, 29 Dec 2022 15:18:07 -0800
From:   David Matlack <dmatlack@google.com>
To:     Vipin Sharma <vipinsh@google.com>
Cc:     seanjc@google.com, pbonzini@redhat.com, bgardon@google.com,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [Patch v3 8/9] KVM: x86/mmu: Make split_shadow_page_cache NUMA
 aware
Message-ID: <Y64gLzMJ5Ap2VmDs@google.com>
References: <20221222023457.1764-1-vipinsh@google.com>
 <20221222023457.1764-9-vipinsh@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221222023457.1764-9-vipinsh@google.com>
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

On Wed, Dec 21, 2022 at 06:34:56PM -0800, Vipin Sharma wrote:
> Make split_shadow_page_cache NUMA aware and allocate page table's pages
> during the split based on the underlying physical page's NUMA node.
> 
> Signed-off-by: Vipin Sharma <vipinsh@google.com>
> ---
>  arch/x86/include/asm/kvm_host.h |  2 +-
>  arch/x86/kvm/mmu/mmu.c          | 50 ++++++++++++++++++---------------
>  2 files changed, 29 insertions(+), 23 deletions(-)
> 
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> index b1f319ad6f89..7b3f36ae37a4 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -1410,7 +1410,7 @@ struct kvm_arch {
>  	 *
>  	 * Protected by kvm->slots_lock.
>  	 */
> -	struct kvm_mmu_memory_cache split_shadow_page_cache;
> +	struct kvm_mmu_memory_cache split_shadow_page_cache[MAX_NUMNODES];
>  	struct kvm_mmu_memory_cache split_page_header_cache;
>  
>  	/*
> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index 511c6ef265ee..7454bfc49a51 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -6126,7 +6126,7 @@ static void kvm_mmu_invalidate_zap_pages_in_memslot(struct kvm *kvm,
>  int kvm_mmu_init_vm(struct kvm *kvm)
>  {
>  	struct kvm_page_track_notifier_node *node = &kvm->arch.mmu_sp_tracker;
> -	int r;
> +	int r, nid;
>  
>  	INIT_LIST_HEAD(&kvm->arch.active_mmu_pages);
>  	INIT_LIST_HEAD(&kvm->arch.possible_nx_huge_pages);
> @@ -6145,8 +6145,9 @@ int kvm_mmu_init_vm(struct kvm *kvm)
>  	INIT_KVM_MMU_MEMORY_CACHE(&kvm->arch.split_page_header_cache,
>  				  mmu_page_header_cache, NUMA_NO_NODE);
>  
> -	INIT_KVM_MMU_MEMORY_CACHE(&kvm->arch.split_shadow_page_cache,
> -				  NULL, NUMA_NO_NODE);
> +	for_each_node(nid)
> +		INIT_KVM_MMU_MEMORY_CACHE(&kvm->arch.split_shadow_page_cache[nid],
> +					  NULL, NUMA_NO_NODE);
                                                ^^^^^^^^^^^^
						Should this be nid?
