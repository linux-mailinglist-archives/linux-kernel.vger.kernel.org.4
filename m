Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F19F55FCBB3
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 21:46:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbiJLTqI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 15:46:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiJLTqE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 15:46:04 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97DA44E874
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 12:46:03 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id r18so16357102pgr.12
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 12:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Im0nQichbXcRvcg6wP4SlKYnzCnTVIm76mkhOYwoF9Q=;
        b=MZ2yXpsFBNdXEPxh5idgAGtQA0FBXt825rbGwIczGvKP7RQjAs98r/iL6u4KRv5AKg
         XoPaiIzhZS6QEXJk+ZlSjnQ/2oxk6qvRA9HndwGbjHihZCfzb3NHGL4QSjTRbfQXVzXq
         yLKk1aKLn2a+IXh6TTlGMcQ68clHBK6gvtLivxG/hRJivRskK55l2JUR+7psmjn7cuxu
         9dTpfEWafUDioThskQt0gC+YPejkqI5BBYpq8IPnANzdAMBCjKSdvH8v3DHltrcIR+vf
         zpYMD5eVySUz2Wd1p7Qpan5qL/Kt6XlgnNn1mqDTww/ZrlIYoxFV67p6AgFglPLe1uFf
         JuKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Im0nQichbXcRvcg6wP4SlKYnzCnTVIm76mkhOYwoF9Q=;
        b=HKGvWlp17HxUMGC8owaY7lBZXevKyrRePTqyvSkSFyDkrFrqSdQmVVp+RenCEcUzQ0
         UASYJwg3yFknX/8WT3z5yTGichDqm00E7JcNacc5pemTtnZYHHNyF89TJhCWE5fIe+iB
         WuIqltxyXAbxLJT15K+vu3sBCvTcCEEmPhy1K0o9WgIv7/Hl6PiT7uPWewGYhsaxK0JK
         LIE66EX3e1II2btwxPB+rFdQPZOAGWPhtT/Mp4cPCJ1BQHlWXM4PhHeEcriDvlxm9fWk
         6FEFKXvxW6q3MDa2wF5ZY0uoGhfI1JItFJFnUgAaXSCTdKH4739zVzQC25rf/VETCmWS
         zTwA==
X-Gm-Message-State: ACrzQf3NDxzTz9/EcH569Y2WTM74m6ZSF47p1M2A/TOwUE7a7M3IIRDi
        D50voz+AgBVjFZ8f2DNd92EFNuhVL5ZXag==
X-Google-Smtp-Source: AMsMyM5bXXVoNbq0NM25A8vuy0XmQoix/gWpgC8wpoPA17PXzcDitRFnafvn66WBmiUkX20jHYXifQ==
X-Received: by 2002:a63:2cd2:0:b0:41c:5901:67d8 with SMTP id s201-20020a632cd2000000b0041c590167d8mr26923302pgs.365.1665603962918;
        Wed, 12 Oct 2022 12:46:02 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id p4-20020a625b04000000b0054097cb2da6sm270166pfb.38.2022.10.12.12.46.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 12:46:02 -0700 (PDT)
Date:   Wed, 12 Oct 2022 19:45:58 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     isaku.yamahata@intel.com
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
        isaku.yamahata@gmail.com, Kai Huang <kai.huang@intel.com>,
        Chao Gao <chao.gao@intel.com>,
        Atish Patra <atishp@atishpatra.org>,
        Shaokun Zhang <zhangshaokun@hisilicon.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Huang Ying <ying.huang@intel.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v5 05/30] KVM: Provide more information in kernel log if
 hardware enabling fails
Message-ID: <Y0cZdmySTNEUo6Ji@google.com>
References: <cover.1663869838.git.isaku.yamahata@intel.com>
 <c7855171bb693746e17beeb149534d0b37fea6a0.1663869838.git.isaku.yamahata@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c7855171bb693746e17beeb149534d0b37fea6a0.1663869838.git.isaku.yamahata@intel.com>
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

On Thu, Sep 22, 2022, isaku.yamahata@intel.com wrote:
> From: Isaku Yamahata <isaku.yamahata@intel.com>
> 
> Provide the name of the calling function to hardware_enable_nolock() and
> include it in the error message to provide additional information on
> exactly what path failed.

Changelog doesn't match the code.

> Opportunistically bump the pr_info() to pr_warn(), failure to enable
> virtualization support is warn-worthy as _something_ is wrong with the
> system.
> 
> Suggested-by: Chao Gao <chao.gao@intel.com>
> Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
> ---
>  virt/kvm/kvm_main.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index 4243a9541543..4f19c47aab1c 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -5006,7 +5006,8 @@ static void hardware_enable_nolock(void *junk)
>  	if (r) {
>  		cpumask_clear_cpu(cpu, cpus_hardware_enabled);
>  		atomic_inc(&hardware_enable_failed);
> -		pr_info("kvm: enabling virtualization on CPU%d failed\n", cpu);
> +		pr_warn("kvm: enabling virtualization on CPU%d failed during %pSb\n",
> +			cpu, __builtin_return_address(0));

I vote to drop this patch.  Trying to capture the caller is just a poor man's
version of WARN, and at the end of this series KVM should be at a point where KVM
can WARN when hardware enabling indicates a potentially fatal issue.

Specifically, kvm_arch_add_vm() shouldn't WARN since x86 can fail due a misbehaving
userspace.  kvm_arch_online_cpu() on the other hand can and should WARN since
failure in that case means hardware enabling succeeded on other CPUs, and in the x86
case, that KVM is actively running VMs.
