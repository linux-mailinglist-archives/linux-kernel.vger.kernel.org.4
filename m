Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43BE7674844
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 01:47:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbjATArr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 19:47:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbjATArh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 19:47:37 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0B89A500D
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 16:47:31 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id g23so3929833plq.12
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 16:47:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NoHGlUpcw7fwmrYboht8UAM/6l0Jv9+yAkVcgRJe890=;
        b=gsp+jdex12Kyhunlsx6KsnMN9DliXdvBwclXTMhdcl766WoN7ToqsIgiAnsfGt78Ub
         4eTBjo9224GAr2S8/McQqfQlGAycLs84gxhcdZVTeYEF+3ALDyJ8eKQEqNIFY/oGth/9
         bZ6YYEhPM5uvvf7yveQGEoDMbtYqNE6hmmVFksCVS8seD0InWS5eJhhUS9QK9yTWPIjP
         xZS8PsMt8Z6ZnT7H0Yqro3hQMloPCnMyhHirp28BGxc47cXIocPgGqTbCwv/OpVMirPb
         ggBaTweZVen23DLAD/Nbp/MCouFHW7uw5KPNzSx4K4ph3NogRNFlU0a7Mk+wljUV+vdM
         4mdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NoHGlUpcw7fwmrYboht8UAM/6l0Jv9+yAkVcgRJe890=;
        b=M44Sp0xYlL41jkE8gzApDPrz3sZyEvf5t9LR2CqtyfncXinT0JcODxYJeoH4jnImAw
         5emQpl2m1B5tbwszZEQAmgz8YyIm1TpvKUXKawbvmGHKb1z7XnfpFih64b7dn3eFjw43
         6tYaE2sKlOJ2BA2dJAXWqvS6m+WuyYB6dqY55mVnbqVFF93zmjhLgUggHlZaSWxg2zkP
         SN0VeTH6WnaU6tqR8AXGoQ3JG8sb1MlR58QKmfoFwN1jMRLl7mJyUDMa5/+lJ3UNXSxd
         zINnaHboLYrV/YxIxpQpD99cvmf3Mc3wfSTXbdap8UBjv0ULDG0KMed/QW1fOUeBXTPu
         lOkA==
X-Gm-Message-State: AFqh2kqtgnLTnAbDEohVoq8H+ryEKph0okwaPmL37RsJidrRISaRVCKF
        n06yru4T2Og1uocUlK9ogEMTRQ==
X-Google-Smtp-Source: AMrXdXubtDrKN+ncI7zo1u/NAMPyHAa+Ul1Xi4orVbBGs2KXU+j3fEWJYwsOcVzmBGmBcH/6eckoWg==
X-Received: by 2002:a17:902:bc84:b0:194:6d3c:38a5 with SMTP id bb4-20020a170902bc8400b001946d3c38a5mr884plb.1.1674175651253;
        Thu, 19 Jan 2023 16:47:31 -0800 (PST)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id jg20-20020a17090326d400b00194799b084esm11429626plb.10.2023.01.19.16.47.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 16:47:30 -0800 (PST)
Date:   Fri, 20 Jan 2023 00:47:27 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Like Xu <like.xu.linux@gmail.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Subject: Re: [PATCH v3 1/3] KVM: x86/pmu: Disable guest PEBS on hybird cpu
 due to heterogeneity
Message-ID: <Y8nknyxfKl4p/0GY@google.com>
References: <20221109082802.27543-1-likexu@tencent.com>
 <20221109082802.27543-2-likexu@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221109082802.27543-2-likexu@tencent.com>
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

On Wed, Nov 09, 2022, Like Xu wrote:
> From: Like Xu <likexu@tencent.com>
> 
> From vPMU enabling perspective, KVM does not have proper support for
> hybird x86 core. The reported perf_capabilities value (e.g. the format
> of pebs record) depends on the type of cpu the kvm-intel module is init.
> When a vcpu of one pebs format migrates to a vcpu of another pebs format,
> the incorrect parsing of pebs records by guest can make profiling data
> analysis extremely problematic.
> 
> The safe way to fix this is to disable this part of the support until the
> guest recognizes that it is running on the hybird cpu, which is appropriate
> at the moment given that x86 hybrid architectures are not heavily touted
> in the data center market.
> 
> Signed-off-by: Like Xu <likexu@tencent.com>
> ---
>  arch/x86/kvm/vmx/capabilities.h | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kvm/vmx/capabilities.h b/arch/x86/kvm/vmx/capabilities.h
> index cd2ac9536c99..ea0498684048 100644
> --- a/arch/x86/kvm/vmx/capabilities.h
> +++ b/arch/x86/kvm/vmx/capabilities.h
> @@ -392,7 +392,9 @@ static inline bool vmx_pt_mode_is_host_guest(void)
>  
>  static inline bool vmx_pebs_supported(void)
>  {
> -	return boot_cpu_has(X86_FEATURE_PEBS) && kvm_pmu_cap.pebs_ept;
> +	return boot_cpu_has(X86_FEATURE_PEBS) &&
> +	       !boot_cpu_has(X86_FEATURE_HYBRID_CPU) &&
> +	       kvm_pmu_cap.pebs_ept;

I assume the patch I just posted[*] to disable the vPMU entirely is sufficient, or
do we need this as well in order to hide X86_FEATURE_DS and X86_FEATURE_DTES64?

[*] https://lore.kernel.org/all/20230120004051.2043777-1-seanjc@google.com
