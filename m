Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AC695BEED6
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 22:59:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229503AbiITU7u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 16:59:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230063AbiITU7q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 16:59:46 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B9C912D2A
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 13:59:43 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id u10-20020a056a00098a00b00543b3eb6416so2331530pfg.15
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 13:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date;
        bh=/mUlHs82UOzIllHYJ5jIVcxP1CA10uKBuFo6uVYNJkc=;
        b=NUdjViAR7oQJ8kCjowWLI5s1VbXQX5wuS/rlbmmqfferKuP+lIWLWHgcvznDtIFfXB
         MvjZeDAfFS8ZnaQAUndlE2383UOZQxtZcGxJbBwaEyeMKjLPTfxt5HUwdhajpO+nD15x
         beup+quytYtVaFaEyZ8/Hk8sW17qNODKadAV+vH0GgmLduU5SIMbY3SpBi3D9/wSSBfo
         GNOe+dWJmBqVwvsIsRMEmyEBOtGiMcZwKizs2AryTFmiWYe59vDhQSRtS2r4ippPPjcA
         UtYK5wNvc5dm6CdzmXR5pZ2hximckvOYlx1NsU/zYn3y9yuFCkcu25PpeE8Wd/bfREpm
         TQQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date;
        bh=/mUlHs82UOzIllHYJ5jIVcxP1CA10uKBuFo6uVYNJkc=;
        b=RBRKOVaSDE3wDSzHIacC3RKhErCHVhq0GvUADXAXs8oGbd+h8EWm54j/Y5bsylbw8T
         4rmJksSYKkzHu1pFPav8qMHdGkB3lvaLrcyvn8VfqBm/Zqu19K3WvxG2wYbWhZxmGsHJ
         OKk2kXO8cpfchglkG7f7qt5MTV+D9KsZzQPr9wSYgbqN8LZ8b+MMPlsysf3kFz2QQVDe
         T4zrjCxExfUlatknwB/ysD0UpP7OUOZhHXsTUWdkMxfEUV5i6CmJl4wboNNBTN9PAnMa
         mWBajvSEV4eLb7iPROP+sH6Z0svG5+hetHMc7zQI1GLM23A9fFn9XwWkgW3POWTiGJlh
         1vDg==
X-Gm-Message-State: ACrzQf3mtt7KWK1gl/xkf3lmXX2lE/U8zcQoasqx853YiJanNbfnFsTr
        Fd+md/WJkhhaewzI6tjdUQ6nbFhnRKIE1g==
X-Google-Smtp-Source: AMsMyM4KP5V0XimRK/cLAv1LAHrix23dKbHVd7SRZb339mSl3sjgIFgQic4ozarcTQyLECmULynSaIkeB0Y+fQ==
X-Received: from loggerhead.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:29a])
 (user=jmattson job=sendgmr) by 2002:a05:6a00:c7:b0:552:3cb5:8260 with SMTP id
 e7-20020a056a0000c700b005523cb58260mr2534535pfj.75.1663707582574; Tue, 20 Sep
 2022 13:59:42 -0700 (PDT)
Date:   Tue, 20 Sep 2022 13:59:19 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.3.968.ga6b4b080e4-goog
Message-ID: <20220920205922.1564814-1-jmattson@google.com>
Subject: [PATCH v2 0/3] KVM: EFER.LMSLE cleanup
From:   Jim Mattson <jmattson@google.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>,
        Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Jim Mattson <jmattson@google.com>
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

KVM has never properly virtualized EFER.LMSLE. However, when the
"nested" module parameter is set, KVM lets the guest set EFER.LMSLE.
Ostensibly, this is so that SLES11 Xen 4.0 will boot as a nested
hypervisor.

KVM passes EFER.LMSLE to the hardware through the VMCB, so
the setting works most of the time, but the KVM instruction emulator
completely ignores the bit, so incorrect guest behavior is almost
certainly assured.

With Zen3, AMD has abandoned EFER.LMSLE. KVM still allows it, though, as
long as "nested" is set. However, since the hardware doesn't support it,
the next VMRUN after the emulated WRMSR will fail with "invalid VMCB."

To clean things up, revert the hack that allowed a KVM guest to set
EFER.LMSLE, and enumerate CPUID.80000008H:EDX.EferLmsleUnsupported[bit
20] in KVM_GET_SUPPORTED_CPUID on SVM hosts.

Jim Mattson (3):
  Revert "KVM: SVM: Allow EFER.LMSLE to be set with nested svm"
  x86/cpufeatures: Introduce X86_FEATURE_NO_LMSLE
  KVM: SVM: Unconditionally enumerate EferLmsleUnsupported

 arch/x86/include/asm/cpufeatures.h | 1 +
 arch/x86/include/asm/msr-index.h   | 2 --
 arch/x86/kvm/svm/svm.c             | 3 ++-
 3 files changed, 3 insertions(+), 3 deletions(-)

v1 -> v2: Make no attempt to preserve existing behavior [Sean, Borislav]

-- 
2.37.3.968.ga6b4b080e4-goog

