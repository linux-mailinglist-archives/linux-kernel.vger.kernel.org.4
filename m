Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4C13709EA1
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 19:56:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbjESR4y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 13:56:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjESR4u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 13:56:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0133F9
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 10:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684518967;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IaiViEvH0tonKl7XtHkSt8uNpoZYk0/1JT6fmXoL+d4=;
        b=QADnnHkloA0E5zXvX3wxCfo0wCtEOROJxwS/MtupIFGFsr814AXi7u51r9fzTIQf2buw3N
        +2nsa9eNE0I2mQb+fWafntByd6QD0bJF0rnYw1ZohzacPJmxCwDYt9qPkm9nrED1ges//5
        TTJU1iLuU26HVfYEevw2k0Gb/AQ49CI=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-66-M4hetq8XOsCe8ED18lXfmw-1; Fri, 19 May 2023 13:56:05 -0400
X-MC-Unique: M4hetq8XOsCe8ED18lXfmw-1
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-50bd07fbd97so4336804a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 10:56:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684518964; x=1687110964;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IaiViEvH0tonKl7XtHkSt8uNpoZYk0/1JT6fmXoL+d4=;
        b=NCGSZygPO2mzXr4EHuqjIGuJjPmFCYoyGdQKEpOULJpNoFk21MVS8hT36oBE8dOcfM
         n/X586lQwdOX1es/SWgAZ7iXQcfaQX9uzub63RiYnPEDhaedhMPfpjt+qvx035PDjtuu
         YybPc/60IDC7tWsdLfivgcITTx5o90BGJ2uyU250P5eSjC/Ckxazhc7B4Tg5YmuF4T02
         ZP9g0h+pYft7ybkUpgEyVS+czppgDTeymRAeFVHbKUkQ09doCKtQyjmQ2BPgXSVY/FmP
         cwTXQ6GNryizRz5SUZo7I1quWlYyllzt5d2sCNFuJaK/OEA9uHBYblw+gO6ImnMl/fEf
         /knA==
X-Gm-Message-State: AC+VfDyRrltjcxFpZaa0tNWMvXfohuREQwNdTYd1jfdJ9X9gVHu3qImP
        Y8VmaBoG95Y7M6N6+1Gv8IEW7UlAenE5bsDjpI8c/SCtiHPQM1JHo2eBh0kkzWlnnDOmbhYgc/Q
        AkiuPnwjIeKGzpE7D84Q+65EJ
X-Received: by 2002:aa7:ccc6:0:b0:510:6ccf:84aa with SMTP id y6-20020aa7ccc6000000b005106ccf84aamr3089615edt.32.1684518964419;
        Fri, 19 May 2023 10:56:04 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ69Vc6aQEl7/0ZW+HUyj0N66ZekDVZpQxzHB5X4JxnafXUOAL+lppa4Lcq8lCYMhIm2+I1wPg==
X-Received: by 2002:aa7:ccc6:0:b0:510:6ccf:84aa with SMTP id y6-20020aa7ccc6000000b005106ccf84aamr3089599edt.32.1684518964134;
        Fri, 19 May 2023 10:56:04 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:9af8:e5f5:7516:fa89? ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
        by smtp.googlemail.com with ESMTPSA id c14-20020a056402100e00b0050bdd7fafd8sm8121edu.29.2023.05.19.10.56.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 May 2023 10:56:03 -0700 (PDT)
Message-ID: <21c6e223-d482-b272-68c9-c442ea834777@redhat.com>
Date:   Fri, 19 May 2023 19:56:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v3] KVM: VMX: add MSR_IA32_TSX_CTRL into msrs_to_save
Content-Language: en-US
To:     Mingwei Zhang <mizhang@google.com>,
        Sean Christopherson <seanjc@google.com>
Cc:     "H. Peter Anvin" <hpa@zytor.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jim Mattson <jmattson@google.com>
References: <20230509032348.1153070-1-mizhang@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20230509032348.1153070-1-mizhang@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/9/23 05:23, Mingwei Zhang wrote:
> Add MSR_IA32_TSX_CTRL into msrs_to_save[] to explicitly tell userspace to
> save/restore the register value during migration. Missing this may cause
> userspace that relies on KVM ioctl(KVM_GET_MSR_INDEX_LIST) fail to port the
> value to the target VM.
> 
> In addition, there is no need to add MSR_IA32_TSX_CTRL when
> ARCH_CAP_TSX_CTRL_MSR is not supported in kvm_get_arch_capabilities(). So
> add the checking in kvm_probe_msr_to_save().
> 
> Fixes: c11f83e0626b ("KVM: vmx: implement MSR_IA32_TSX_CTRL disable RTM functionality")
> Reported-by: Jim Mattson <jmattson@google.com>
> Signed-off-by: Mingwei Zhang <mizhang@google.com>
> ---
>   arch/x86/kvm/x86.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 237c483b1230..c8accbd6c861 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -1431,7 +1431,7 @@ static const u32 msrs_to_save_base[] = {
>   #endif
>   	MSR_IA32_TSC, MSR_IA32_CR_PAT, MSR_VM_HSAVE_PA,
>   	MSR_IA32_FEAT_CTL, MSR_IA32_BNDCFGS, MSR_TSC_AUX,
> -	MSR_IA32_SPEC_CTRL,
> +	MSR_IA32_SPEC_CTRL, MSR_IA32_TSX_CTRL,
>   	MSR_IA32_RTIT_CTL, MSR_IA32_RTIT_STATUS, MSR_IA32_RTIT_CR3_MATCH,
>   	MSR_IA32_RTIT_OUTPUT_BASE, MSR_IA32_RTIT_OUTPUT_MASK,
>   	MSR_IA32_RTIT_ADDR0_A, MSR_IA32_RTIT_ADDR0_B,
> @@ -7077,6 +7077,10 @@ static void kvm_probe_msr_to_save(u32 msr_index)
>   		if (!kvm_cpu_cap_has(X86_FEATURE_XFD))
>   			return;
>   		break;
> +	case MSR_IA32_TSX_CTRL:
> +		if (!(kvm_get_arch_capabilities() & ARCH_CAP_TSX_CTRL_MSR))
> +			return;
> +		break;
>   	default:
>   		break;
>   	}

Queued, thanks.

Paolo

