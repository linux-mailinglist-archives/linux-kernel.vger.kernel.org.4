Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5833C6748A3
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 02:10:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbjATBKH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 20:10:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229851AbjATBKF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 20:10:05 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 511A2A317B
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 17:09:58 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id u1-20020a17090a450100b0022936a63a21so7599260pjg.4
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 17:09:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FU7lzPxzbK9iqs16nfhIa9lTSM80vnhPj6bAK+nAk7c=;
        b=QEFII+iGf+EwT9N3S6reBjWYQwUwZ0UlHCNWPeN4qSMHL2YKiygXmsbBYSzw8K4VIZ
         kcx/7dt8v35WBLV3KwUnzhpnQOWkDNoTZmyVhFLGAfkH9uTOeCCj9yxP+LjPm45AZEVA
         Fvaznvfygk8NmnhFNF6NzXqr41M/Pq4w4SzqJDCpG/g9Yja09h80oAgur84W5YJyzYFJ
         vui3HYFcGBQE52NaWogUPjs5mv/BO6F1Yx7uVXJiP1FADiTL5CBE3xkjCkPnPzMQGA20
         MDzzkfGTKMmshexVEvi+lV7DPh4SojLyzPTki+g2jQG81onAqHTQoWntE9ccJlK6H6ps
         aneg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FU7lzPxzbK9iqs16nfhIa9lTSM80vnhPj6bAK+nAk7c=;
        b=B3wgvPfD+IwO3zVkreeLs6kVloqQzPl5k+4AIUhSSUTL54iXOG7yFA9blGKQH2FKvB
         On8oLgN77geRsO72Bluv0R1MHiyQJqUlasSlThnTHs/ZMXAzkmBIU6CUv4QXzTGR4+Ka
         xjwa7XXNm+tldYjygmO0CkodQh7GE0Yh3ApGcaO8W6kU8S8MvAuxKqZJCWFPqHo74PWB
         /MOurb0j/MPzYYrF/aCVnuMuHb+MTLyvEdk9VyZ7tFkFERi7lhT8T7J3rS48QZNp2qDa
         C+L3gSB7Khgr2LOWPwwlsou/cduGDy6/hda2CCsMT56bODiZn3TQqf8whGiX5yusLVlq
         Srpg==
X-Gm-Message-State: AFqh2krdSy8FT71uYq0yanE9Q/qg7SXLCKDzNVpbJ4dtH9UuQWuWhzpl
        Mk1fxkjM+SyCPEBo7v6J+Bbt/A==
X-Google-Smtp-Source: AMrXdXsmpR29lRz9a1bf9Z+Pd6p7UryM869yunlRddakBXhuD8l2CrCabr0ppRTDTPX+MNG3+0OTkQ==
X-Received: by 2002:a05:6a20:6911:b0:b8:e33c:f160 with SMTP id q17-20020a056a20691100b000b8e33cf160mr12174pzj.0.1674176997634;
        Thu, 19 Jan 2023 17:09:57 -0800 (PST)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id x186-20020a6263c3000000b0058dbb5b44edsm7545034pfb.178.2023.01.19.17.09.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 17:09:57 -0800 (PST)
Date:   Fri, 20 Jan 2023 01:09:53 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Like Xu <like.xu.linux@gmail.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/8] KVM: x86/pmu: Rewrite reprogram_counters() to
 improve performance
Message-ID: <Y8np4caG5QeeNjat@google.com>
References: <20221111102645.82001-1-likexu@tencent.com>
 <20221111102645.82001-4-likexu@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221111102645.82001-4-likexu@tencent.com>
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

On Fri, Nov 11, 2022, Like Xu wrote:
> From: Like Xu <likexu@tencent.com>
> 
> A valid pmc is always tested before using pmu->reprogram_pmi. Eliminate
> this part of the redundancy by setting the counter's bitmask directly,
> and in addition, trigger KVM_REQ_PMU only once to save more cpu cycles.
> 
> Signed-off-by: Like Xu <likexu@tencent.com>
> ---
>  arch/x86/kvm/pmu.h           | 11 +++++++++++
>  arch/x86/kvm/vmx/pmu_intel.c | 12 ------------
>  2 files changed, 11 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/x86/kvm/pmu.h b/arch/x86/kvm/pmu.h
> index 2b5376ba66ea..be552c8217a0 100644
> --- a/arch/x86/kvm/pmu.h
> +++ b/arch/x86/kvm/pmu.h
> @@ -189,6 +189,17 @@ static inline void kvm_pmu_request_counter_reprogam(struct kvm_pmc *pmc)
>  	kvm_make_request(KVM_REQ_PMU, pmc->vcpu);
>  }
>  
> +static inline void reprogram_counters(struct kvm_pmu *pmu, u64 diff)
> +{
> +	int bit;
> +
> +	if (diff) {

Prefer this, it's slightly cleaner:

	if (!diff)
		return;

> +		for_each_set_bit(bit, (unsigned long *)&diff, X86_PMC_IDX_MAX)
> +			__set_bit(bit, pmu->reprogram_pmi);

Needs to use the atomic set_bit().
