Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A73FD66B011
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Jan 2023 10:06:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229758AbjAOJGn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Jan 2023 04:06:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230118AbjAOJGk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jan 2023 04:06:40 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B71EB455
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jan 2023 01:05:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673773549;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SgGQvfVNgJuj9/GzR9Kg0QVkCdAd9T5sROwhixs1ZQs=;
        b=IsdV8GZsLm3Hyw2XUyLUu334BBsCQlC4qYQcvTR7JwStjx9C/r2ag4WCZ1Ju8x7bleisl1
        Km4E3vZPLh6pXWiYUBSWo5QQ7jQVK36KQJmvS00BtY/FeUTfMA/VAhHOTYXhDOVGO6Q3jd
        +NElTyJaGz0EsnPYaH1bneL5PKaHzbc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-462-Coq5AnWjNHySFV5INHhA0Q-1; Sun, 15 Jan 2023 04:05:47 -0500
X-MC-Unique: Coq5AnWjNHySFV5INHhA0Q-1
Received: by mail-wm1-f71.google.com with SMTP id k38-20020a05600c1ca600b003da1c24f23cso5003390wms.8
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jan 2023 01:05:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SgGQvfVNgJuj9/GzR9Kg0QVkCdAd9T5sROwhixs1ZQs=;
        b=Pf7apNoTI9mAAokDYvOeNJmozCOpFnXN0mJAyKWJxwWzsnqqTaClfrxmEI84FxvsJb
         WRlXtQMRsDLKnyiOC+VELCjAIieNxT/G4FpQDoVMtzk+Mikhl5+ymUJeQ2HL1bdtz+0Z
         FJzWijvUAHhT4/3LojWslRWfHmNrtsoKfKj24aI62V3WzcGhhqz5yUDulbacnbfAd72Y
         px8+eY0jZ/HzovcGiPdVvxMROvejgh3HZikYgJfWknE/nd1hHWsbWEPXml4eucqLlnCd
         +eNV6FvRLMUqb/CCYUnsm+msyLQvKtAZxpuTxUI/S0QNxefVgnaS2gFzom2b1jRg3uQE
         1ewQ==
X-Gm-Message-State: AFqh2kpJ5RkJfCL6Vjv5hIUfbCq+9fUqf2+b4FuL9rPY70raNKBn2L5e
        o6zMNP4kxEoSyQw/wIeCd/M28EfBT9pPWPBvJLH34EwW26TOd8fcqHsxByfRGzB60FalgYPNdPE
        khigr68hU+RVskjQEl5UF7tpl
X-Received: by 2002:a05:600c:4f48:b0:3c6:f7ff:6f87 with SMTP id m8-20020a05600c4f4800b003c6f7ff6f87mr64595626wmq.11.1673773546717;
        Sun, 15 Jan 2023 01:05:46 -0800 (PST)
X-Google-Smtp-Source: AMrXdXvG0UTe3PnFsXLNSWaN/0Y8lIxlhLDD8rQaPYwl7/ETxnfRiEClOA1ADPWsTTif+A21ALm0Qw==
X-Received: by 2002:a05:600c:4f48:b0:3c6:f7ff:6f87 with SMTP id m8-20020a05600c4f4800b003c6f7ff6f87mr64595609wmq.11.1673773546510;
        Sun, 15 Jan 2023 01:05:46 -0800 (PST)
Received: from starship ([89.237.103.62])
        by smtp.gmail.com with ESMTPSA id w12-20020a05600c474c00b003d1e1f421bfsm13685107wmo.10.2023.01.15.01.05.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Jan 2023 01:05:45 -0800 (PST)
Message-ID: <49b74c43e4d6ba065b48f4a7c82759e28b4acc0f.camel@redhat.com>
Subject: Re: [PATCH v2 00/11] SVM: vNMI (with my fixes)
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     kvm@vger.kernel.org
Cc:     Sandipan Das <sandipan.das@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Daniel Sneddon <daniel.sneddon@linux.intel.com>,
        Jiaxi Chen <jiaxi.chen@linux.intel.com>,
        Babu Moger <babu.moger@amd.com>, linux-kernel@vger.kernel.org,
        Jing Liu <jing2.liu@intel.com>,
        Wyes Karny <wyes.karny@amd.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Sean Christopherson <seanjc@google.com>
Date:   Sun, 15 Jan 2023 11:05:43 +0200
In-Reply-To: <20221129193717.513824-1-mlevitsk@redhat.com>
References: <20221129193717.513824-1-mlevitsk@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-11-29 at 21:37 +0200, Maxim Levitsky wrote:
> Hi!
> 
> This is the vNMI patch series based on Santosh Shukla's vNMI patch series.
> 
> In this version of this patch series I addressed most of the review feedback
> added some more refactoring and also I think fixed the issue with migration.
> 
> I only tested this on a machine which doesn't have vNMI, so this does need
> some testing to ensure that nothing is broken.
> 
> Best regards,
>        Maxim Levitsky
> 
> Maxim Levitsky (9):
>   KVM: nSVM: don't sync back tlb_ctl on nested VM exit
>   KVM: nSVM: clean up the copying of V_INTR bits from vmcb02 to vmcb12
>   KVM: nSVM: explicitly raise KVM_REQ_EVENT on nested VM exit if L1
>     doesn't intercept interrupts
>   KVM: SVM: drop the SVM specific H_FLAGS
>   KVM: x86: emulator: stop using raw host flags
>   KVM: SVM: add wrappers to enable/disable IRET interception
>   KVM: x86: add a delayed hardware NMI injection interface
>   KVM: SVM: implement support for vNMI
>   KVM: nSVM: implement support for nested VNMI
> 
> Santosh Shukla (2):
>   x86/cpu: Add CPUID feature bit for VNMI
>   KVM: SVM: Add VNMI bit definition
> 
>  arch/x86/include/asm/cpufeatures.h |   1 +
>  arch/x86/include/asm/kvm-x86-ops.h |   2 +
>  arch/x86/include/asm/kvm_host.h    |  24 +++--
>  arch/x86/include/asm/svm.h         |   7 ++
>  arch/x86/kvm/emulate.c             |  11 +--
>  arch/x86/kvm/kvm_emulate.h         |   7 +-
>  arch/x86/kvm/smm.c                 |   2 -
>  arch/x86/kvm/svm/nested.c          | 102 ++++++++++++++++---
>  arch/x86/kvm/svm/svm.c             | 154 ++++++++++++++++++++++-------
>  arch/x86/kvm/svm/svm.h             |  41 +++++++-
>  arch/x86/kvm/x86.c                 |  50 ++++++++--
>  11 files changed, 318 insertions(+), 83 deletions(-)
> 
> -- 
> 2.26.3
> 
> 
Another kind ping on this patch series.

Best regards,
	Maxim Levitsky

