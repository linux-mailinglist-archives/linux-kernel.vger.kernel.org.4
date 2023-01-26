Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A41367D5AE
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 20:50:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232688AbjAZTup (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 14:50:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232686AbjAZTul (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 14:50:41 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 697664FC06
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 11:50:35 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id d9so2811612pll.9
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 11:50:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UUvKx9totPqnePNsm+o+Df+E2nVvcP4SPqdwJ4LAruE=;
        b=tYTM15unzWTtR1t8u6g5HH2QlrZI0TTC+UkGRb9L0pzB9YB5zIuQAXELhRJb33FobU
         l4B+JbY+OFzkKkNvgBzbGsQZoYFUzFYTpuxXidKXwy2vtn/zrOle+j+RKzXn5HTdkpHO
         vaSe+rPLbmYqeQ8FEU5yMNUeOPcuTxnxLWhy4habFZZQ5WNUY2XZs5RCMLJKtdKFUjTu
         coU2pjHC2aeawT1pfZciaSH8lnyLTRALYqri5d5E8iwmz4pQh5ulWbmwWOKDOtqmC8KU
         ikFs9qZCQvA5vxIKGFkERXkeJFcIp+S0ey0s/bH0QFQ67gxsPmRMH9U+1X6nSgK2hRAN
         ONJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UUvKx9totPqnePNsm+o+Df+E2nVvcP4SPqdwJ4LAruE=;
        b=StxXUNvoTiWBXB3kDtaK9Y1tesJaetw+vI7NdX0DP3rfQ6corAyXPNPJbcUx/N/vJu
         1eKbbx7n9bSI771fptA1zhgJKvREAZ1AV3sJNV4Bl84x/SJxE7QXz6G6CqELeh85ch0V
         4/vdJqDp2ijysFzgKXlPfSmhZydgKO4qFjhQ492z9mU2oanY3re0P49UorfDQInfL/Jn
         N4vApZhw8Jy0BPKt9kXxSnB/FWzjVRag9oiuASRM36rqZGU6Y9buNN90YQVZoKhnAVRM
         tuINbX+DzlfSbefqz1I4kU1fp/y4JsiU/ROSPhLanPZy3yIZUfwt+epK0PIVhbXSgxfm
         ud/g==
X-Gm-Message-State: AO0yUKVotrgYxsz8tEYgco/bhBL1Rdr7orZGcaLFJgVWTV1JJMiV6ywZ
        MEW5qfkzLY++LNwNhhnBpeEbrA==
X-Google-Smtp-Source: AK7set8AiFhu+LCC9WPRp5yN14IXny544EmZy5V3SkTTa3S5ynSEQGbZky6lxKfZnc0VWSdyNv9xJw==
X-Received: by 2002:a05:6a20:4c08:b0:a4:efde:2ed8 with SMTP id fm8-20020a056a204c0800b000a4efde2ed8mr1164132pzb.0.1674762634726;
        Thu, 26 Jan 2023 11:50:34 -0800 (PST)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id w5-20020a170902d3c500b00194bf8cef44sm1339566plb.117.2023.01.26.11.50.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jan 2023 11:50:34 -0800 (PST)
Date:   Thu, 26 Jan 2023 19:50:30 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Yang Weijiang <weijiang.yang@intel.com>
Cc:     pbonzini@redhat.com, jmattson@google.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, like.xu.linux@gmail.com,
        kan.liang@linux.intel.com, wei.w.wang@intel.com,
        Zhang Yi Z <yi.z.zhang@linux.intel.com>
Subject: Re: [PATCH v2 03/15] KVM: x86: Refresh CPUID on writes to
 MSR_IA32_XSS
Message-ID: <Y9LZhsqxRjMjbK3s@google.com>
References: <20221125040604.5051-1-weijiang.yang@intel.com>
 <20221125040604.5051-4-weijiang.yang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221125040604.5051-4-weijiang.yang@intel.com>
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

On Thu, Nov 24, 2022, Yang Weijiang wrote:
> Updated CPUID.0xD.0x1, which reports the current required storage size
> of all features enabled via XCR0 | XSS, when the guest's XSS is modified.
> 
> Note, KVM does not yet support any XSS based features, i.e. supported_xss
> is guaranteed to be zero at this time.
> 
> Co-developed-by: Zhang Yi Z <yi.z.zhang@linux.intel.com>
> Signed-off-by: Zhang Yi Z <yi.z.zhang@linux.intel.com>
> Signed-off-by: Yang Weijiang <weijiang.yang@intel.com>
> ---
>  arch/x86/kvm/cpuid.c | 16 +++++++++++++---
>  arch/x86/kvm/x86.c   |  6 ++++--
>  2 files changed, 17 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
> index 6b5912578edd..85e3df6217af 100644
> --- a/arch/x86/kvm/cpuid.c
> +++ b/arch/x86/kvm/cpuid.c
> @@ -272,9 +272,19 @@ static void __kvm_update_cpuid_runtime(struct kvm_vcpu *vcpu, struct kvm_cpuid_e
>  		best->ebx = xstate_required_size(vcpu->arch.xcr0, false);
>  
>  	best = cpuid_entry2_find(entries, nent, 0xD, 1);
> -	if (best && (cpuid_entry_has(best, X86_FEATURE_XSAVES) ||
> -		     cpuid_entry_has(best, X86_FEATURE_XSAVEC)))
> -		best->ebx = xstate_required_size(vcpu->arch.xcr0, true);
> +	if (best) {
> +		if (cpuid_entry_has(best, X86_FEATURE_XSAVES) ||
> +		    cpuid_entry_has(best, X86_FEATURE_XSAVEC))  {
> +			u64 xstate = vcpu->arch.xcr0 | vcpu->arch.ia32_xss;
> +
> +			best->ebx = xstate_required_size(xstate, true);
> +		}
> +
> +		if (!cpuid_entry_has(best, X86_FEATURE_XSAVES)) {
> +			best->ecx = 0;
> +			best->edx = 0;

ECX and EDX should be left alone, it is userspace's responsibility to provide a
sane CPUID model.  E.g. KVM doesn't clear EBX or EDX in CPUID.0xD.0x1 when XSAVE
is unsupported.

> +		}
> +	}
>  
>  	best = __kvm_find_kvm_cpuid_features(vcpu, entries, nent);
>  	if (kvm_hlt_in_guest(vcpu->kvm) && best &&
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 16726b44061b..888a153e32bc 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -3685,8 +3685,10 @@ int kvm_set_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
>  		 */
>  		if (data & ~kvm_caps.supported_xss)
>  			return 1;
> -		vcpu->arch.ia32_xss = data;
> -		kvm_update_cpuid_runtime(vcpu);
> +		if (vcpu->arch.ia32_xss != data) {
> +			vcpu->arch.ia32_xss = data;
> +			kvm_update_cpuid_runtime(vcpu);
> +		}
>  		break;
>  	case MSR_SMI_COUNT:
>  		if (!msr_info->host_initiated)
> -- 
> 2.27.0
> 
