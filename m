Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 029CD5EEA27
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 01:37:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233812AbiI1Xg7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 19:36:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233638AbiI1Xg4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 19:36:56 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C945FEFF40
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 16:36:54 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id z16-20020a17090a015000b00205e74e7402so1638356pje.8
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 16:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date;
        bh=2pXCrSXWl1T4eX1bVR4OHLDGtpZ9ki0sWDT+FbUrrU8=;
        b=b+9vn0zTKNR2FojgWlts3uoe/JXZN2JH1KJjrm0TZRBrRuIXf5FDv29xkQBUtG3n+j
         XpP7L1IsksHQj6mCNmyYd4MmcvLYD4wgZfZt4ZzNWZpjOLu0lfD9h1eX5ifx7rVLlUOw
         zqsURMqdQVsKTv0pkJdciO9ACPAcWhlvrHefVXME5RhIO1XgceAYz9ec7C+EFGiRBxlR
         h26zbVdWE77aD9Mwy3sgUr3+ORSWMw2vLR+0duXGgAcbwSGTdpIzuOp0509LaEmurTB9
         xyL7BfQxQ8CTuTXPh6RS29X1rsdDaSrolyGKDZam/H79Ct4omhtCF4am61ScSPVSBTBW
         g2Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date;
        bh=2pXCrSXWl1T4eX1bVR4OHLDGtpZ9ki0sWDT+FbUrrU8=;
        b=GOc0n2fvs1tPjwPOGoLkLWRK36078lerV2j7S7TKVPYmLzA1DTYjd1vz8Y719rJWXE
         zuKuf/d/sH2gSt9HG9C2pJW7JM+ZXeu6KJAVVsfuX13M5cSzGmvT29aJDdnnu2hrfeQq
         eK97ZMwMhZ5rb7T1lrIY559Ku5H3z7p6fu4VvjCYTV3Wka+pEhs9RymjeLtXgMoGg4qk
         WgHsDkaMABGaJRZVrIlFdI9tFcbUgGbKZCFAjnflAucsY0AWGU4rFUQQ+k2m7y//jzLN
         MOodUEgVaBvBF7st05qgsF/PKr8h/j/zdHf2gqnTDcrmq3FVGUcjTyMfdLfmvvo2MBAh
         guDw==
X-Gm-Message-State: ACrzQf3V8YzAcqhik5AbtNlPAYKhwRCXvEuZDDVzL3QBxBTygF0B4S9b
        W3MCjJBDHnbGwQP6xGZyKpGvJp+5vwE=
X-Google-Smtp-Source: AMsMyM4m1kvBj79SpCMVIWeOzwVKAmDgr9al369YFf9ecOKFtWXFeDu5iqUC3jBWHQNYG2DKFWb3uPHkL7I=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:13a5:b0:542:4a6d:9a1e with SMTP id
 t37-20020a056a0013a500b005424a6d9a1emr497304pfg.43.1664408214406; Wed, 28 Sep
 2022 16:36:54 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Wed, 28 Sep 2022 23:36:45 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.3.998.g577e59143f-goog
Message-ID: <20220928233652.783504-1-seanjc@google.com>
Subject: [PATCH v2 0/7] KVM: selftests: Fix "fix hypercall test" build errors
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Cc:     Tom Rix <trix@redhat.com>, kvm@vger.kernel.org,
        llvm@lists.linux.dev, linux-kernel@vger.kernel.org,
        Andrew Jones <andrew.jones@linux.dev>,
        Anup Patel <anup@brainfault.org>,
        Atish Patra <atishp@atishpatra.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Sean Christopherson <seanjc@google.com>,
        Oliver Upton <oliver.upton@linux.dev>,
        Jim Mattson <jmattson@google.com>
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

After a toolchain upgrade, the x86 fix_hypercall_test started throwing
warnings due to -Werror=array-bounds rightly complaining that the test is
generating an out-of-bounds array access.

The "obvious" fix is to replace the memcpy() with a memcmp() and compare
only the exact size of the hypercall instruction.  That worked, until I
fiddled with the code a bit more and suddenly the test started jumping into
the weeds due to gcc generating a call to the external memcmp() through the
PLT, which isn't supported in the selftests.

To fix that mess, which has been a pitfall for quite some time, provide
implementations of memcmp(), memcpy(), and memset() to effectively override
the compiler built-ins.  My thought is to start with the helpers that are
most likely to be used in guest code, and then add more as needed.

v2:
 - Revert a patch that avoided memset(). [Jim]
 - Collect reviews. [Oliver]
 - Rename kvm_string.c => string_overrides.c. [David]
 - Tweak the "fix hypercall" test to verify that the original opcode
   is preserved exactly. [Oliver]
 - Further dedup code in the "fix hypercall" test.

v1: https://lore.kernel.org/all/20220908233134.3523339-1-seanjc@google.com

Sean Christopherson (7):
  KVM: selftests: Implement memcmp(), memcpy(), and memset() for guest
    use
  KVM: selftests: Compare insn opcodes directly in fix_hypercall_test
  KVM: selftests: Remove unnecessary register shuffling in
    fix_hypercall_test
  KVM: selftests: Hardcode VMCALL/VMMCALL opcodes in "fix hypercall"
    test
  KVM: selftests: Explicitly verify KVM doesn't patch hypercall if
    quirk==off
  KVM: selftests: Dedup subtests of fix_hypercall_test
  Revert "KVM: selftests: Fix nested SVM tests when built with clang"

 tools/testing/selftests/kvm/Makefile          |  11 +-
 .../selftests/kvm/lib/string_override.c       |  39 +++++
 tools/testing/selftests/kvm/lib/x86_64/svm.c  |  14 +-
 .../selftests/kvm/x86_64/fix_hypercall_test.c | 134 +++++++-----------
 4 files changed, 103 insertions(+), 95 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/lib/string_override.c


base-commit: c59fb127583869350256656b7ed848c398bef879
-- 
2.37.3.998.g577e59143f-goog

