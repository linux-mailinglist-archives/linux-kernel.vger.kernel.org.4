Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F10535E5455
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 22:16:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230452AbiIUUQN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 16:16:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230380AbiIUUQK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 16:16:10 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E63219CCC0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 13:16:09 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-3452b545544so60678277b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 13:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date;
        bh=vLHoGgGgKd0nKtlS5SvsC3lThWwHGSJ6o+HlyGIWUF8=;
        b=iuXJ7tU8hUTGo2FUA1kDmUbIOpd8YpdVHQPjo1f8yafypSPWX9ISMRkbp9vV9RsGNn
         GuAu74iSBG0R0Q3YhCGcblTElMWLAQSE6b8GGEiKACBvd/b9tXvPWYfaVjqEaX5PytK9
         wWc7IN6i4jzM20SuoM9/MbhyZebQw1IjS6VIhO0AmOJIZzDqmnomaPRLcYpBsRw4P37B
         5p2Ev9BGQTlAusWf3B6npH4yGu9d7SpKloBkGEANL/yJRIcccJ/8Qija+yddJmFsJlUB
         ly9TvR+pHUOrwPqVbaaGVpxEit84x+FsvOQVchTa+S32OSUkQwQnglxhrsjsYUEhv1yq
         /mWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date;
        bh=vLHoGgGgKd0nKtlS5SvsC3lThWwHGSJ6o+HlyGIWUF8=;
        b=STVrxXqZfkV3+g+1PdRAGmr09M2lsGjY0rQC7gGbEEPM32AQuK1huQOMZ10yZ0UxpY
         OnLoAiQT3AUq9hyMjPxMPS94NYfbpdnEaEB9cn3xDK9QkTkga6MWF1Mpb3qmCR21of/V
         Ac0P1D4La3KWY9qGW+9mmjDz7v1/xkbjtiFgZoWDaGPoU7/V/9cy5vWTeoLi3Qg9AGG+
         0xHAxZpMCER7Idf6aIfRD5n1nr0+XfoxIusZNOrP8OIfEEjxReDynxe2q/CKlB1uzn6R
         3MCySepDfCYKlFexITj0it5nv5iEAB1MFHxpbFllFpMNC6eVCt1c3A9zjedcRImWWtkz
         Hrqg==
X-Gm-Message-State: ACrzQf3C5b1JLV2U1XUD5l87UzR01qI3VIg5OgB3kf1g93mu62ZHYRc8
        CfTEVAOKXOtBpNjdYCaffSDiIb8hY7U=
X-Google-Smtp-Source: AMsMyM576OJSYMonI7hTDuG9fbnRJf1JvOLyfEiUQke37YXN1OwBP9sfPzCMGrRqJ8XmW62ygkCsnk2TSvs=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:ccd7:0:b0:6a9:72d6:a1c1 with SMTP id
 l206-20020a25ccd7000000b006a972d6a1c1mr104997ybf.390.1663791369170; Wed, 21
 Sep 2022 13:16:09 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Wed, 21 Sep 2022 20:16:03 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.3.968.ga6b4b080e4-goog
Message-ID: <20220921201607.3156750-1-seanjc@google.com>
Subject: [PATCH 0/4] x86/hyperv: KVM: VMCB enlightenment cleanups
From:   Sean Christopherson <seanjc@google.com>
To:     "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     linux-hyperv@vger.kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

Hyper-V folks, if the changes look ok I'd like to take this through the
KVM tree as Vitaly has an in-progress KVM series[*] that conflicts mightily
with these changes.

The main goal of this series it to clean up KVM's ugly casting of the
VMCB's software reserved field to the Hyper-V enlightenments struct,
e.g. replace a bunch of code that does:

	(struct hv_enlightenments *)vmcb->control.reserved_sw;

with:

	&vmcb->control.hv_enlightenments;

That cleanup is complicated slightly due the Hyper-V enlightenments
being "KVM private", versus the VMCB struct being "public", but that
itself is also a "bug".  The enlightenments come directly from the TLFS,
i.e. aren't KVM internal.  Moving the definition to hyperv-tlfs.h where
it belongs has the happy side effect of making the struct visible to
asm/svm.h.

Compile tested only, but the resulting kvm-amd.ko binary is identical
before and after the series.

[*] https://lore.kernel.org/all/20220921152436.3673454-1-vkuznets@redhat.com

Sean Christopherson (4):
  x86/hyperv: Move VMCB enlightenment definitions to hyperv-tlfs.h
  KVM: selftests: Move "struct hv_enlightenments" to x86_64/svm.h
  KVM: SVM: Add a proper field for Hyper-V VMCB enlightenments
  x86/hyperv: KVM: Rename "hv_enlightenments" to
    "hv_vmcb_enlightenments"

 arch/x86/include/asm/hyperv-tlfs.h            | 22 ++++++++++++
 arch/x86/include/asm/svm.h                    |  7 +++-
 arch/x86/kvm/svm/hyperv.h                     | 35 -------------------
 arch/x86/kvm/svm/nested.c                     |  9 +++--
 arch/x86/kvm/svm/svm.h                        |  5 ++-
 arch/x86/kvm/svm/svm_onhyperv.c               |  4 +--
 arch/x86/kvm/svm/svm_onhyperv.h               | 18 +++++-----
 .../selftests/kvm/include/x86_64/svm.h        | 22 +++++++++++-
 .../selftests/kvm/x86_64/hyperv_svm_test.c    | 21 +----------
 9 files changed, 69 insertions(+), 74 deletions(-)
 delete mode 100644 arch/x86/kvm/svm/hyperv.h


base-commit: 372d07084593dc7a399bf9bee815711b1fb1bcf2
-- 
2.37.3.968.ga6b4b080e4-goog

