Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BC987323E3
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 01:50:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240260AbjFOXuH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 19:50:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230300AbjFOXuF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 19:50:05 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20DBA1BC
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 16:50:04 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-565ba5667d5so2794077b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 16:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686873003; x=1689465003;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=BVHQIxab1B8Q6sBR2ncD9z6ENdWBS+1tCZhMgiwQgtk=;
        b=kurxN4irhqBdN0T/MPFrP39SsDxkJdbc8xk9VfoW3LwKO6VXZSeXsldeCu7VIEU5Y6
         RscKoAmyJpguXMAOkru/HJD0OvVbE2984ptLblggB2SeI1qxe1xflVsmBkvsACz9I7yt
         i9AkS8q2nBURoyohuTDJaoXOGHR0/GOeQkFKlp4LcfC6u/Q9BrLcMyICi33QDCRk2Tlv
         9Law9NTgi2XwLV98UJXES2nK0DBzSNsiis2easEWgUQKbaR9toNZ91Tj6b7luKR2CSh1
         E6illDOUqSM4C35/kgrdd6EvYXRuyJ7XmA2ahx2JoY7kGkAlfjm3smdwjrxDYy269f84
         zY8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686873003; x=1689465003;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BVHQIxab1B8Q6sBR2ncD9z6ENdWBS+1tCZhMgiwQgtk=;
        b=bsx9ft7uhMkLMDFe4x1J1QZf2WiS+wbjz+ZvIuqhz82N5O+2jFTzheyaspkxN7F7nU
         LW0mnJiJHh/Sjxkrtw/CdexpHdWtPA+cskOHNTxsZFTfRE5a8rI4lZ+uTP+wAnZvPR7s
         TGc3x+CRRfXzixjuS5Qe2cLk1UMxrvKG6F4g6AqBTAjTlBssLbdakfWo6zVno+as0Wj/
         iDekzTuYkiCOkHmbVkJYgJwNf4iXZriYOIrZF5NaIFhwFc7NpV9U7hPHDxhor+2F5aor
         XytgMnZ/8hHqsSWY3rWLSxeKOfNOF9O0EM+Z3LZmJ4IVM8Kn1I/ZrjRrbj+icA5ZglK4
         z7iA==
X-Gm-Message-State: AC+VfDzs+47SA/aPhB3DJOsBFnvcD6uL2YHIYnclD7P/Xrr8MQ9Ejnnd
        ty1W5BtLpJgY6E7FCEM6Ogcmx5tVbbk=
X-Google-Smtp-Source: ACHHUZ48r+dDDTW+GuCdN2KwJGDNfZ/I/06RJXfF2BGU6fSswoRKG3LCwv3D/ZyF5H5wwGc42vxIBCtCcRI=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a81:bd05:0:b0:565:e903:6ad9 with SMTP id
 b5-20020a81bd05000000b00565e9036ad9mr86727ywi.9.1686873003375; Thu, 15 Jun
 2023 16:50:03 -0700 (PDT)
Date:   Thu, 15 Jun 2023 16:50:01 -0700
In-Reply-To: <20230511040857.6094-10-weijiang.yang@intel.com>
Mime-Version: 1.0
References: <20230511040857.6094-1-weijiang.yang@intel.com> <20230511040857.6094-10-weijiang.yang@intel.com>
Message-ID: <ZIujqYFd3xR2oPwi@google.com>
Subject: Re: [PATCH v3 09/21] KVM:x86: Load guest FPU state when accessing
 xsaves-managed MSRs
From:   Sean Christopherson <seanjc@google.com>
To:     Yang Weijiang <weijiang.yang@intel.com>
Cc:     pbonzini@redhat.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        rppt@kernel.org, binbin.wu@linux.intel.com,
        rick.p.edgecombe@intel.com, john.allen@amd.com,
        Sean Christopherson <sean.j.christopherson@intel.com>
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 11, 2023, Yang Weijiang wrote:
> From: Sean Christopherson <sean.j.christopherson@intel.com>
> 
> Load the guest's FPU state if userspace is accessing MSRs whose values are
> managed by XSAVES. Two MSR access helpers, i.e., kvm_{get,set}_xsave_msr(),
> are introduced by a later patch to facilitate access to this kind of MSRs.
> 
> If new feature MSRs supported in XSS are passed through to the guest they
> are saved and restored by {XSAVES|XRSTORS} to/from guest's FPU state at
> vm-entry/exit.
> 
> Because the modified code is also used for the KVM_GET_MSRS device ioctl(),
> explicitly check @vcpu is non-null before attempting to load guest state.
> The XSS supporting MSRs cannot be retrieved via the device ioctl() without
> loading guest FPU state (which doesn't exist).
> 
> Note that guest_cpuid_has() is not queried as host userspace is allowed
> to access MSRs that have not been exposed to the guest, e.g. it might do
> KVM_SET_MSRS prior to KVM_SET_CPUID2.
> 
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> Co-developed-by: Yang Weijiang <weijiang.yang@intel.com>
> Signed-off-by: Yang Weijiang <weijiang.yang@intel.com>
> ---
>  arch/x86/kvm/x86.c | 29 ++++++++++++++++++++++++++++-
>  1 file changed, 28 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index d2975ca96ac5..7788646bbf1f 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -130,6 +130,9 @@ static int __set_sregs2(struct kvm_vcpu *vcpu, struct kvm_sregs2 *sregs2);
>  static void __get_sregs2(struct kvm_vcpu *vcpu, struct kvm_sregs2 *sregs2);
>  
>  static DEFINE_MUTEX(vendor_module_lock);
> +static void kvm_load_guest_fpu(struct kvm_vcpu *vcpu);
> +static void kvm_put_guest_fpu(struct kvm_vcpu *vcpu);
> +
>  struct kvm_x86_ops kvm_x86_ops __read_mostly;
>  
>  #define KVM_X86_OP(func)					     \
> @@ -4336,6 +4339,21 @@ int kvm_get_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
>  }
>  EXPORT_SYMBOL_GPL(kvm_get_msr_common);
>  
> +static const u32 xsave_msrs[] = {

Can you change this to "xstate_msrs"?


> +	MSR_IA32_U_CET, MSR_IA32_PL3_SSP,
> +};
> +
> +static bool is_xsaves_msr(u32 index)

And then is_xstate_msr().  The intent to is check if an MSR is managed as part of
the xstate, not if the MSR is somehow related to XSAVE itself.
