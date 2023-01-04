Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE79B65D5AF
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 15:31:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235017AbjADObZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 09:31:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235207AbjADObP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 09:31:15 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8065CC7
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 06:31:13 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id cp9-20020a17090afb8900b00226a934e0e5so1181560pjb.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jan 2023 06:31:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5/XJG2NgUgahwG/C5s2mJj+3LrHS+xAXkiEzTuBwSRs=;
        b=QqXodgCDwuVKUISeF3ZkfxaA9MsnxxjHjpuMCSWcn876ipUVIO2fnC0UECQP96UbbR
         YIwfGWbdCQQgZ0llgMufxX4nb9OclTDJjppSYqC6Iv2FxMHSv+FTY16KoAE5hqUNHEEL
         ZWopJYbYJm4zMRzoVFs1/5eo0SrdLG7zuIz6srt0Opg/nkp2KPBd7IN1f7GL0pGPuVlZ
         e7z33VZh+kku9wqc3xtyYMOsuyg1WnhH1d5mVARJRsyZ6Lzz6seQSAq0Brd4srOXmxSg
         lqrwWhRFTv7YYmodlndIItCNc36dWO7m275KSKzZDn/kSAKQ+mIIe3Aeh45ZoeldoDMt
         shzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5/XJG2NgUgahwG/C5s2mJj+3LrHS+xAXkiEzTuBwSRs=;
        b=zNwKx8jQlrIIqSgym9gpVybu8oh8AX0zJL1u6wcIq5C82KZGLpMrue6irVJg9Qyim1
         Ynyazsb+hw87Kz9vBcfR3q0hcAQG70T51ZdGigmFA81KB6vi+jXtkSlgRnu9TaP1Pcao
         WU2RNBpaOxrShEUMVMa9y0vlMWx6O2p4KU1M9Dzg5n7XT4W6VxXF8UWMw79T/7Ip+X9/
         JjlQSivVO2gMsZjEJyjDtMVF+bYFKcCdfcv03dPMbCWrA+d4GriwKGK2bxGgjFhGzlBk
         0PZ3I8ni7Ce4wHqceEyWF3bXCEtgsJA3ssv1HeSnVM7otYC/1w3ZWt2dnhelpU48R/G1
         38HQ==
X-Gm-Message-State: AFqh2kplkwmlJs3MPpuHkHAomGYa+pF9i4UJ2rCYWWUAkmA+gJoWxgs+
        UAR07iCvwSC678ot/BmjtFbuAw==
X-Google-Smtp-Source: AMrXdXttLSJRebBGBvcOEgZBpEsufIIBrF3ucpY0qN/nHcQw1ZTcOGIM6L0jkgiVcmBAg69NPLPCwA==
X-Received: by 2002:a17:90a:9912:b0:219:f970:5119 with SMTP id b18-20020a17090a991200b00219f9705119mr3851370pjp.1.1672842673086;
        Wed, 04 Jan 2023 06:31:13 -0800 (PST)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id z15-20020a17090a66cf00b00223ed94759csm23072183pjl.39.2023.01.04.06.31.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jan 2023 06:31:12 -0800 (PST)
Date:   Wed, 4 Jan 2023 14:31:09 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Aaron Lewis <aaronlewis@google.com>,
        Yu Zhang <yu.c.zhang@linux.intel.com>
Subject: Re: [PATCH v2 3/4] KVM: nVMX: Don't muck with allowed sec exec
 controls on CPUID changes
Message-ID: <Y7WNrZ9NaDHOxwuG@google.com>
References: <20221213062306.667649-1-seanjc@google.com>
 <20221213062306.667649-4-seanjc@google.com>
 <70872206-7a75-0a19-3df5-a97207e710fa@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <70872206-7a75-0a19-3df5-a97207e710fa@redhat.com>
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

On Fri, Dec 23, 2022, Paolo Bonzini wrote:
> On 12/13/22 07:23, Sean Christopherson wrote:
> > Don't modify the set of allowed secondary execution controls, i.e. the
> > virtual MSR_IA32_VMX_PROCBASED_CTLS2, in response to guest CPUID changes.
> > To avoid breaking old userspace that never sets the VMX MSRs, i.e. relies
> > on KVM to provide a consistent vCPU model, keep the existing behavior if
> > userspace has never written MSR_IA32_VMX_PROCBASED_CTLS2.
> > 
> > KVM should not modify the VMX capabilities presented to L1 based on CPUID
> > as doing so may discard explicit settings provided by userspace.  E.g. if
> > userspace does KVM_SET_MSRS => KVM_SET_CPUID and disables a feature in
> > the VMX MSRs but not CPUID (to prevent exposing the feature to L2), then
> > stuffing the VMX MSRs during KVM_SET_CPUID will expose the feature to L2
> > against userspace's wishes.
> 
> The commit message doesn't explain *why* KVM_SET_CPUID would be done before
> KVM_SET_MSRS.

I assume you mean why KVM_SET_MSRS would be done before KVM_SET_CPUID2?

This patch is mostly paranoia, AFAIK there is no userspace that is negatively
affected by KVM's manipulations.  The only case I can think of is if userspace
wanted to emulate dynamic CPUID updates, e.g. set an MSR filter to intercept writes
to MISC_ENABLES to update MONITOR/MWAIT support, but that behavior isn't allowed
since commit feb627e8d6f6 ("KVM: x86: Forbid KVM_SET_CPUID{,2} after KVM_RUN").

There are scenarios where userspace might do KVM_SET_MSRS before KVM_SET_CPUID,
e.g. QEMU's reuse of a vCPU for CPU hotplug, but in those cases I would expect
userspace to follow up with another KVM_SET_MSRS.
