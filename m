Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31BE9613C3D
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 18:37:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229961AbiJaRhx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 13:37:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiJaRhv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 13:37:51 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42B4810B6B
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 10:37:50 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id u8-20020a17090a5e4800b002106dcdd4a0so16585107pji.1
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 10:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eXOqG6a7ktSvSUcrZmfqzm1DYXeD0En6fjRVv1PFnR0=;
        b=lWIvmxaf7s/pWH/4jXVTvXdwOqf6Ozb5/gbiz1nn1TdsuQXYA7pL9f9dUj1sIpR3gQ
         YYO/r/sY+7DcQOFtlr3bVX/TNTf+mvcghDrHnXB6r2DbFzzbrTA9j6O2vjxGKXh4cOY1
         zVYCiVNJYfIj4nD8K4dohGPF1VEAURrJFuw6QpsCOX6zSqraGeGcavFs+9jzA7oWEv2/
         zsSHKXqJUPuGAJTPJ8r7/8t9XX56qO7xLlMlRxxsgP/mA6eApTD6ott8IK85nG2udWYE
         xtREt0xOHftPQCmLEqsmtp9ynySJIGnlh10+yh4jS7sf+Ue6W/q5FLcu32Jst6QY/36E
         hADQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eXOqG6a7ktSvSUcrZmfqzm1DYXeD0En6fjRVv1PFnR0=;
        b=pstZX7NO5cLnzxeY7K0piSiCd2IMW0WkydsVZ/CfYNGm7+Q0GCN3k/JtMEy0FG0z3K
         cBgZEYVnO7qHueFI3O8nQn+nVNdKYvtZ5WVJQoltXHbm0UcDXcDP0Lo/8A9PL2+6fJOO
         TfTrr0F2E4vk++szwQOQJbJcjgIQoBP+NMI83An29MmkWJr0jUm6Dyz/0XBsqTj4y9cu
         2ysNEtz3rniWPShmU7tBTykzlvuVUkGSD2QsA2oHm3lNQjan9zg5oSkSRPG/1HQ2Rgct
         OhypX1KyY6qGkQ9MYyx0pEkhwHsCcG9cqrLZEunboDqb+aPIfV4UjyuwB9XeBmsmlbVL
         pamA==
X-Gm-Message-State: ACrzQf37+QZ/SPsJqjajTYVbKCr+913KIWy0l0Mo877I5/slRgrpWrFQ
        rNuwQm0Ef7Q/ZhJMMqG4k1WJnw==
X-Google-Smtp-Source: AMsMyM4ANTa7ozXITuyP4Cey0NtRHvTDIiz2i0pQXjUXFKTVUVdlFSlgwVMKbp4pEn7astowYHPZ6A==
X-Received: by 2002:a17:902:c944:b0:186:a7d7:c3b with SMTP id i4-20020a170902c94400b00186a7d70c3bmr15415238pla.55.1667237869679;
        Mon, 31 Oct 2022 10:37:49 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id a7-20020a624d07000000b0053e468a78a8sm4882824pfb.158.2022.10.31.10.37.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 10:37:49 -0700 (PDT)
Date:   Mon, 31 Oct 2022 17:37:46 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        jmattson@google.com, jpoimboe@kernel.org
Subject: Re: [PATCH 1/7] KVM: VMX: remove regs argument of __vmx_vcpu_run
Message-ID: <Y2AH6sevOvD/GnKV@google.com>
References: <20221028230723.3254250-1-pbonzini@redhat.com>
 <20221028230723.3254250-2-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221028230723.3254250-2-pbonzini@redhat.com>
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

On Fri, Oct 28, 2022, Paolo Bonzini wrote:
> Registers are reachable through vcpu_vmx, no need to pass
> a separate pointer to the regs[] array.
> 
> No functional change intended.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  arch/x86/kernel/asm-offsets.c |  1 +
>  arch/x86/kvm/vmx/nested.c     |  3 +-
>  arch/x86/kvm/vmx/vmenter.S    | 58 +++++++++++++++--------------------
>  arch/x86/kvm/vmx/vmx.c        |  3 +-
>  arch/x86/kvm/vmx/vmx.h        |  3 +-
>  5 files changed, 29 insertions(+), 39 deletions(-)
> 
> diff --git a/arch/x86/kernel/asm-offsets.c b/arch/x86/kernel/asm-offsets.c
> index cb50589a7102..90da275ad223 100644
> --- a/arch/x86/kernel/asm-offsets.c
> +++ b/arch/x86/kernel/asm-offsets.c
> @@ -111,6 +111,7 @@ static void __used common(void)
>  
>  	if (IS_ENABLED(CONFIG_KVM_INTEL)) {
>  		BLANK();
> +		OFFSET(VMX_vcpu_arch_regs, vcpu_vmx, vcpu.arch.regs);

Is there an asm-offsets-like solution that doesn't require exposing vcpu_vmx
outside of KVM?  We (Google) want to explore loading multiple instances of KVM,
i.e. loading multiple versions of kvm.ko at the same time, to allow intra-host
migration between versions of KVM to upgrade/rollback KVM without changing the
kernel (RFC coming soon-ish).  IIRC, asm-offsets is the only place where I haven't
been able to figure out a simple way to avoid exposing KVM's internal structures
outside of KVM (so that the structures can change across KVM instances without
breaking kernel code).
