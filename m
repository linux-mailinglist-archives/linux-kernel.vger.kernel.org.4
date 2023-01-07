Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7499A660B43
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 02:10:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236784AbjAGBKe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 20:10:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230201AbjAGBKb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 20:10:31 -0500
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CA89848CA
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jan 2023 17:10:29 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id g32-20020a635660000000b00478c21b8095so1716749pgm.10
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jan 2023 17:10:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tmPQz2zK/dB2NTddZcwOldRAv/bdux625ajDDkMbuHk=;
        b=iVjG2Dn6BJBzk+IgWmNfLGDv0w9EAWaRFXsphtRQSAQogeDcidQWbOJOEL9duYesJ/
         KWgDMbu4JmoKcdGX+lRkcZJI8sj5+OehlPoaXX6DRMHhzmH9xOL6cKV66kWdbv5/RJS5
         elAJ6VyypAiWCYbthqFbOqweSBkK8T0gZ69W1CdMqAWKyt+rLgVh5fVUQBARpb7rKn2F
         WO1PHNNDA15lrQB112fSwfFiJkFSpOJwTindRe9H/IW+GBwq9u8H7AbOxrz2Qva4AgqY
         3v3FDloHFh8hNU0yeDR8x48dZJ6AYiDSKqOytKmScNhcEErtpbP0Y3cH6mT8S6F3eF/b
         BOew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tmPQz2zK/dB2NTddZcwOldRAv/bdux625ajDDkMbuHk=;
        b=PR2GtLNfqTEHT7F9RVzEDVBW8IrIdl+Bih2lTTH83IJAKZ/Q5azE7k20sT7etXgLr+
         i5AoxvBGqljWGQ1LzXTOshqm+rLIvOyVoxIDGORpoj3lmVZhKKzlYwS2KtYtFxTwCfno
         H3o2xLM6kkjm80Z40cedZIlXumrZWk9tJ9Iy0mjtwOGbthS4ipUGT7OMdmD4p+VknlLn
         G6nCSOdUcvHaLfLa2K2+Mm6bJjeTXvmduKmWLMNphorMjWYNIn+XMXG2zR37tNEc74Ik
         Dd2pD3rSjBtPbxvtC8qGaYbsghoYdYNRpCQfFJwer2sB9URHmZDl2W/kzWT8D5c0wIZN
         gXBw==
X-Gm-Message-State: AFqh2krrmSxKYIvV1BVHElRJX4FlTVZlNjfh/EoGyK0lWrGWRL4EOeo2
        jcHZWUXAktyo46Wz/KDy8iA9dT7lKdk=
X-Google-Smtp-Source: AMrXdXvRVHpxwEEN5RXKAlZYEIIXS8jSzNKi7FvtbYzveRApruWdfU8rwk3IieX2SOretClEBwElb0hZoGs=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:4394:b0:585:ff31:600 with SMTP id
 bt20-20020a056a00439400b00585ff310600mr108443pfb.51.1673053828686; Fri, 06
 Jan 2023 17:10:28 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Sat,  7 Jan 2023 01:10:19 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20230107011025.565472-1-seanjc@google.com>
Subject: [PATCH 0/6] KVM: x86: x2APIC reserved bits/regs fixes
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Marc Orr <marcorr@google.com>, Ben Gardon <bgardon@google.com>,
        Venkatesh Srinivas <venkateshs@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes for edge cases where KVM mishandles reserved bits/regs checks when
the vCPU is in x2APIC mode.

The first two patches were previously posted[*], but both patches were
broken (as posted against upstream), hence I took full credit for doing
the work and changed Marc to a reporter.

The VMX APICv fixes are for bugs found when writing tests.  *sigh*
I didn't Cc those to stable as the odds of breaking something when touching
the MSR bitmaps seemed higher than someone caring about a 10 year old bug.

AMD x2AVIC support may or may not suffer similar interception bugs, but I
don't have hardware to test and this already snowballed further than
expected...

[*] https://lore.kernel.org/kvm/20220525173933.1611076-1-venkateshs@chromium.org

Sean Christopherson (6):
  KVM: x86: Inject #GP if WRMSR sets reserved bits in APIC Self-IPI
  KVM: x86: Inject #GP on x2APIC WRMSR that sets reserved bits 63:32
  KVM: x86: Mark x2APIC DFR reg as non-existent for x2APIC
  KVM: x86: Split out logic to generate "readable" APIC regs mask to
    helper
  KVM: VMX: Always intercept accesses to unsupported "extended" x2APIC
    regs
  KVM: VMX: Intercept reads to invalid and write-only x2APIC registers

 arch/x86/kvm/lapic.c   | 55 ++++++++++++++++++++++++++----------------
 arch/x86/kvm/lapic.h   |  2 ++
 arch/x86/kvm/vmx/vmx.c | 40 +++++++++++++++---------------
 3 files changed, 57 insertions(+), 40 deletions(-)


base-commit: 91dc252b0dbb6879e4067f614df1e397fec532a1
-- 
2.39.0.314.g84b9a713c41-goog

