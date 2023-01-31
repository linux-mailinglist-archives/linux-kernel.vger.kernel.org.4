Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DEB7683219
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 17:02:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231137AbjAaQCT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 11:02:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230267AbjAaQCR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 11:02:17 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBB985140B
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 08:02:08 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id e6so7306590plg.12
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 08:02:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qolkKFUWF1fSIOK1T3Eb09EPST5XmPMDbV9tDFNFExo=;
        b=jWnk1TOM6LONcmHCt2iwS2FTGiUVyhcrd5IpPf7TYQhlOKo6WBzLAns2wMLbQKY9f9
         CUvVEnd+x4W3Wyksza/ixN1WtO2uzqz55zGDyvot7M/9/HDKGscvfmKdOGtURPo9HDnt
         6vhmN4Fh+IgoG8e4Rx/unRp4tB9F2x1ZiVSl1EFGe79gN5jaLVowThk4XBjj9lpCVYob
         gqz8F+yLkjnnXIBZUDTotPqgQByeR7zNHI9eldQ5X8OhZX3lbFNgP1I8JENUpSm2KmRx
         rm2HiC+Cob/A8iIQh1f0+xwlAkDVpFNF7HhhJyKdbrhxEGYMHeXmu9AEEF1NDEJXd06L
         v3RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qolkKFUWF1fSIOK1T3Eb09EPST5XmPMDbV9tDFNFExo=;
        b=6QKVmI7i4MYGd+y9cWwZ9G1gw6Y9wfxxwXLqVRq0Qc5kv0rZyfNgHOmjOKb6acBL9e
         xDAZFdRYBE2Hge0TgRD9v97NcftxdtYlt7H8ywxphGVOx8HN+yp0l9pm2rHalfMGb2m/
         myOX+r4Nsy8EzVkz+w1jLBO63ngzpyyuSCp4OfyPffDArdHgK1p0VygC3lUHvYGfO15/
         guMUCsjqT8Bx/wym7obvlfZVXOhf8YWWYQ1SLE148zFuh+/pKRdEvPPVwDQdbXJgRO/F
         fKbpPOwP4AT7anTY8TBsOhH7CTRyItT6Cmp17TATE48UuMstTSZmY1V7osoWkMflUZD9
         HS/g==
X-Gm-Message-State: AO0yUKXxWvJO7HVXg/TTO4kAFe5wjK4GvfdpJwk2Xk7JHzso1C3f2tdp
        VUzHZALXtNPdnnpVg37PfhagfQ==
X-Google-Smtp-Source: AK7set+KL+QXJKcsXfji2x/PfH7A3BpcIIHPo1gbiHQ83HR6xcjyD+XYz5o6CplbFB72OmNmakpHyw==
X-Received: by 2002:a05:6a20:6d15:b0:a4:efde:2ed8 with SMTP id fv21-20020a056a206d1500b000a4efde2ed8mr1491710pzb.0.1675180927925;
        Tue, 31 Jan 2023 08:02:07 -0800 (PST)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id cw10-20020a056a00450a00b0057a9b146592sm9565264pfb.186.2023.01.31.08.02.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Jan 2023 08:02:07 -0800 (PST)
Date:   Tue, 31 Jan 2023 16:02:03 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Like Xu <like.xu.linux@gmail.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jianfeng Gao <jianfeng.gao@intel.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2] KVM: x86/pmu: Disable all vPMU features support on
 Intel hybrid CPUs
Message-ID: <Y9k7eyfmXjqW9lYF@google.com>
References: <20230131085031.88939-1-likexu@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230131085031.88939-1-likexu@tencent.com>
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

On Tue, Jan 31, 2023, Like Xu wrote:
> From: Like Xu <likexu@tencent.com>
> 
> Disable KVM support for virtualizing PMUs on hosts with hybrid PMUs until
> KVM gains a sane way to enumeration the hybrid vPMU to userspace and/or
> gains a mechanism to let userspace opt-in to the dangers of exposing a
> hybrid vPMU to KVM guests.
> 
> Virtualizing a hybrid PMU, or at least part of a hybrid PMU, is possible,
> but it requires userspace to pin vCPUs to pCPUs to prevent migrating a
> vCPU between a big core and a little core, requires the VMM to accurately
> enumerate the topology to the guest (if exposing a hybrid CPU to the
> guest), and also requires the VMM to accurately enumerate the vPMU
> capabilities to the guest.
> 
> The last point is especially problematic, as KVM doesn't control which
> pCPU it runs on when enumerating KVM's vPMU capabilities to userspace.
> For now, simply disable vPMU support on hybrid CPUs to avoid inducing
> seemingly random #GPs in guests.
> 
> Reported-by: Jianfeng Gao <jianfeng.gao@intel.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Suggested-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Like Xu <likexu@tencent.com>
> ---
> v1: https://lore.kernel.org/all/20230120004051.2043777-1-seanjc@google.com/
>  arch/x86/kvm/pmu.h | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kvm/pmu.h b/arch/x86/kvm/pmu.h
> index 79988dafb15b..6a3995657e1e 100644
> --- a/arch/x86/kvm/pmu.h
> +++ b/arch/x86/kvm/pmu.h
> @@ -166,9 +166,11 @@ static inline void kvm_init_pmu_capability(const struct kvm_pmu_ops *pmu_ops)
>  
>  	 /*
>  	  * For Intel, only support guest architectural pmu
> -	  * on a host with architectural pmu.
> +	  * on a non-hybrid host with architectural pmu.
>  	  */
> -	if ((is_intel && !kvm_pmu_cap.version) || !kvm_pmu_cap.num_counters_gp)
> +	if (!kvm_pmu_cap.num_counters_gp ||
> +	    (is_intel && (!kvm_pmu_cap.version ||
> +			  boot_cpu_has(X86_FEATURE_HYBRID_CPU))))

Why do this here instead of in perf_get_x86_pmu_capability()[*]?  The issue isn't
restricted to Intel CPUs, it just so happens that Intel is the only x86 vendor
that has shipped hybrid CPUs/PMUs.  Similarly, it's entirely possible to create a
hybrid CPU with a fully homogeneous PMU.  IMO KVM should rely on the PMU's is_hybrid()
and not the generic X86_FEATURE_HYBRID_CPU flag.

[*] https://lore.kernel.org/all/20230120004051.2043777-1-seanjc@google.com
