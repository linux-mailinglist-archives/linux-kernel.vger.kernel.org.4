Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87C84645F45
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 17:52:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbiLGQwL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 11:52:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbiLGQwI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 11:52:08 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAE9262E8F
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 08:52:07 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id z8-20020a17090abd8800b00219ed30ce47so1995360pjr.3
        for <linux-kernel@vger.kernel.org>; Wed, 07 Dec 2022 08:52:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cAb8R7PNVb593hzMcJSA8sWRMgGK0aDyiAEsqoUo5sc=;
        b=mZ7bchyvy+REMtoRx6/1zGsMisk4BRgRlWHNk0YI4YT1Kt1F8JtlYCH5hSWuB1VEMa
         DUqrR4Z+bVi9ZNGPKSgNRBb6ykmKK2kcM1K2RG05ykCHXZBKtpTBH7RLfxE6+ab3TNPx
         lwO1/CM0VdyK4XrY7QEpjc4dBx6ApyPTmigcnyNvyk9Kkv4FpTy5ZO7KBcPfKw72gXmq
         0NuPnSWU9i3Aeat+L2jyv34mqEkkOpbDQelj+I/jFUDZ6hbiroUSKcPD5Tm5ybF5UlGL
         RA5p+RE/10WHUH5TkVpnwfocfoCb8M5sagQ7LU1Z7z6u6mkb+Tn0KUFVfap6Q6vQ2omi
         GVNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cAb8R7PNVb593hzMcJSA8sWRMgGK0aDyiAEsqoUo5sc=;
        b=hun4v77zCByjZdCcNQroxj1x/u42n66WM2Bxx3HO4NSoja55ZIrI4bRRImyQBTfbrB
         lDi2eiGkfrc3KGIaT1JFlkmF+HvFUtFxh59FqIpRYN7A/W65g8NZpPxSGFjrHA44mp8/
         bFt1rdxGisQpb9AM2sjKwkswg5luuQPPyDqNpPH4cI8oHlXKfRz3ZbMeFxJHxTxT0Q12
         vDyy0dOTImquprDUgicJ/2jGSasDWE5PUTLuDDSK9NQ5EAxo+xV1uqGHkPP0yKJlka01
         DnimkhlmzBx2OnhjLt5DaLGNfyM3fBH8GTGoAIpxio6TSRbwwwm8pvNXWA4sPdgDqtpi
         QyyA==
X-Gm-Message-State: ANoB5pmk09hA2ci3P1nsVHyK6JF2XmeBHWc4ovUrOUuli7Y2g+w4MrAs
        NH7m9pkVD6ThlvW9oRgXPlYg6Q==
X-Google-Smtp-Source: AA0mqf5POIOwoNplfy01WJjnbpfgOvZPeclkhY4NZiRcadH52s3KqakjFIAZvhaBo4ZpJWM3AVc/fw==
X-Received: by 2002:a17:902:c7d1:b0:189:a3de:ea2d with SMTP id r17-20020a170902c7d100b00189a3deea2dmr1200663pla.2.1670431927057;
        Wed, 07 Dec 2022 08:52:07 -0800 (PST)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id r24-20020a170902be1800b00189ed861791sm3485956pls.266.2022.12.07.08.52.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Dec 2022 08:52:06 -0800 (PST)
Date:   Wed, 7 Dec 2022 16:52:03 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Like Xu <like.xu.linux@gmail.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: x86/pmu: Prevent zero period event from being
 repeatedly released
Message-ID: <Y5DEsyqgAebvbET0@google.com>
References: <20221207071506.15733-1-likexu@tencent.com>
 <20221207071506.15733-2-likexu@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221207071506.15733-2-likexu@tencent.com>
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

Please don't mix kernel and KVM-unit-tests patches in the same "series", for those
of us that have become dependent on b4, mixing patches for two separate repos
makes life miserable.

The best alternative I have come up with is to post the KVM patch(es), and then
provide a lore link in the KUT patch(es).  It means waiting a few minutes before
sending the KUT if you want to double check that you got the lore link right,
but I find that it's fairly easy to account for that in my workflow.

On Wed, Dec 07, 2022, Like Xu wrote:
> From: Like Xu <likexu@tencent.com>
> 
> The current vPMU can reuse the same pmc->perf_event for the same
> hardware event via pmc_pause/resume_counter(), but this optimization
> does not apply to a portion of the TSX events (e.g., "event=0x3c,in_tx=1,
> in_tx_cp=1"), where event->attr.sample_period is legally zero at creation,
> thus making the perf call to perf_event_period() meaningless (no need to
> adjust sample period in this case), and instead causing such reusable
> perf_events to be repeatedly released and created.
> 
> Avoid releasing zero sample_period events by checking is_sampling_event()
> to follow the previously enable/disable optimization.
> 
> Signed-off-by: Like Xu <likexu@tencent.com>
> ---
>  arch/x86/kvm/pmu.c | 3 ++-
>  arch/x86/kvm/pmu.h | 3 ++-
>  2 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
> index 684393c22105..eb594620dd75 100644
> --- a/arch/x86/kvm/pmu.c
> +++ b/arch/x86/kvm/pmu.c
> @@ -238,7 +238,8 @@ static bool pmc_resume_counter(struct kvm_pmc *pmc)
>  		return false;
>  
>  	/* recalibrate sample period and check if it's accepted by perf core */
> -	if (perf_event_period(pmc->perf_event,
> +	if (is_sampling_event(pmc->perf_event) &&
> +	    perf_event_period(pmc->perf_event,
>  			      get_sample_period(pmc, pmc->counter)))
>  		return false;
>  
> diff --git a/arch/x86/kvm/pmu.h b/arch/x86/kvm/pmu.h
> index 85ff3c0588ba..cdb91009701d 100644
> --- a/arch/x86/kvm/pmu.h
> +++ b/arch/x86/kvm/pmu.h
> @@ -140,7 +140,8 @@ static inline u64 get_sample_period(struct kvm_pmc *pmc, u64 counter_value)
>  
>  static inline void pmc_update_sample_period(struct kvm_pmc *pmc)
>  {
> -	if (!pmc->perf_event || pmc->is_paused)
> +	if (!pmc->perf_event || pmc->is_paused ||
> +	    !is_sampling_event(pmc->perf_event))
>  		return;
>  
>  	perf_event_period(pmc->perf_event,
> -- 
> 2.38.1
> 
