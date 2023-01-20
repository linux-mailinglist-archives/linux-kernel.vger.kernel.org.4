Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0118F6747F1
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 01:22:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbjATAWK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 19:22:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjATAWI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 19:22:08 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06846A25AF
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 16:22:08 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id x10-20020a170902ec8a00b001949f64986bso2194152plg.12
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 16:22:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=qarnVoHxegfok8suMZ60X44vyBHlDgZBsxgjOTntVDE=;
        b=KlmUSp1OC3PpDJEn1SVEY78+DTBFYmtA1+or/ba+WYKrsIHiwUpV+7X2hKcevvdi/R
         mF0TF+lISdXtS1cnctG+9V5LnsQB9lpabufpuXofrlCjYD4rRlkETrTG+t+UAmAhhfLW
         nhwPADwW2Kcpfl3r9wKDT8Kr8EEr5jMiUb0dHftyU4iH4biYDgxHfeN6nOBkQkaBcJad
         Qdi+o3PVYfY0eLzVkzBspfl2RRlcu7xcm8LFidTDsGcISO/KHWsbzQmmFYFziUOE3E02
         OTtuBZHrf8gVMxr5SiEjhPbckhqINBG7ycOxxXlyiAkgkmRjtm1JKyuyryh2E3Mp4zNo
         NBsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qarnVoHxegfok8suMZ60X44vyBHlDgZBsxgjOTntVDE=;
        b=CJN1toJq8BI5vKPucK1XIqdS4Km4mdMRSfUwKisC0zoXiBIvgg/awTsAj/FNdoVDLN
         aBRWedCk5w7/3OAfYFNBLC3QHskf973dYHIHQ2LHsGWqvoo/btQYpJbNddynIdtThmXP
         mPHvSOUfsihcFAYJTyr1B44tNvzPNJSXUQk/OFY6hwbQSgo0WkFZhY8zwUZB9nSGg9hj
         Z8D6jSMoIgVIqUPNTTAj+RUScICQwQTD6t66QQDgVOJ7X+mVDPbX8Qgo0bMpj6R3OJfP
         r+HFKdPR3IE4lv2yVWQH+m0cFKwqz93kYBFvIS/gBysk+jViBgwLu6xEY0fB9mCeU8NQ
         9fRg==
X-Gm-Message-State: AFqh2kojqooLdb0SpS3A7JIVIy3xeYSSV+7KE99Mpg3yu9SwS+UN4qi8
        YQy+FYjfZebOF6wJ4XJ5GQ6sD45MeU4=
X-Google-Smtp-Source: AMrXdXv47XnxB0jwg9M0LmgLWRNBoiSUYcORHiSwxAYpO41x8F9GoJL4+CoaEujKl2iqvQZJq1w8PEBuhnQ=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90b:e8b:b0:226:9980:67f3 with SMTP id
 fv11-20020a17090b0e8b00b00226998067f3mr5263pjb.1.1674174127279; Thu, 19 Jan
 2023 16:22:07 -0800 (PST)
Date:   Fri, 20 Jan 2023 00:19:44 +0000
In-Reply-To: <20230107011025.565472-1-seanjc@google.com>
Mime-Version: 1.0
References: <20230107011025.565472-1-seanjc@google.com>
X-Mailer: git-send-email 2.39.0.246.g2a6d74b583-goog
Message-ID: <167416431629.2493805.137458085197602659.b4-ty@google.com>
Subject: Re: [PATCH 0/6] KVM: x86: x2APIC reserved bits/regs fixes
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Marc Orr <marcorr@google.com>, Ben Gardon <bgardon@google.com>,
        Venkatesh Srinivas <venkateshs@chromium.org>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 07 Jan 2023 01:10:19 +0000, Sean Christopherson wrote:
> Fixes for edge cases where KVM mishandles reserved bits/regs checks when
> the vCPU is in x2APIC mode.
> 
> The first two patches were previously posted[*], but both patches were
> broken (as posted against upstream), hence I took full credit for doing
> the work and changed Marc to a reporter.
> 
> [...]

Applied to kvm-x86 apic, thanks past me!

[1/6] KVM: x86: Inject #GP if WRMSR sets reserved bits in APIC Self-IPI
      https://github.com/kvm-x86/linux/commit/aeee623ea411
[2/6] KVM: x86: Inject #GP on x2APIC WRMSR that sets reserved bits 63:32
      https://github.com/kvm-x86/linux/commit/a927a2508121
[3/6] KVM: x86: Mark x2APIC DFR reg as non-existent for x2APIC
      https://github.com/kvm-x86/linux/commit/6d4719e1b5a2
[4/6] KVM: x86: Split out logic to generate "readable" APIC regs mask to helper
      https://github.com/kvm-x86/linux/commit/1088d5e5cf70
[5/6] KVM: VMX: Always intercept accesses to unsupported "extended" x2APIC regs
      https://github.com/kvm-x86/linux/commit/cbb3f75487a9
[6/6] KVM: VMX: Intercept reads to invalid and write-only x2APIC registers
      https://github.com/kvm-x86/linux/commit/7b205379c53d

--
https://github.com/kvm-x86/linux/tree/next
https://github.com/kvm-x86/linux/tree/fixes
