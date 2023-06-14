Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2B1172ECEE
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 22:30:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234635AbjFMUan (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 16:30:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232580AbjFMUal (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 16:30:41 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26AC5E6C
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 13:30:41 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id 41be03b00d2f7-543a89d0387so2545041a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 13:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686688240; x=1689280240;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+Rpn40+f4Bdf6IBKYbjZfc4eEK05I3gCfm7ge6XmBs0=;
        b=b8ZDd8iUuYxcXuTOdwxoMFCIW1w8TM1A9HYO3S9l1PT3dSoKaMOFAVNnn1Nti6i76K
         iAmnnItQAZYKEBIM1BNi5nfvn7iHNDbnfTIpbnrmFmx7Z9gY1TzVoMEQz39gkC/DZTCI
         QAH7zUuHynhwLCaaelZAac8gKLUi4nxCys75U3WDuU4Zijk6rRl3eaqnqzApyds+YnoL
         ytU8meRMztZkyUAoUgfA9zZvC5nVVFkNakVvom+WzjJf28qfpFvI12huXCZqgHPTSVo+
         c4U4BIae/f62nN7Rq7rNhT1bqrBT9eDsNTDOJaJRITjtHYeGActlfv0PwEKhKcnQfEGR
         KcQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686688240; x=1689280240;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+Rpn40+f4Bdf6IBKYbjZfc4eEK05I3gCfm7ge6XmBs0=;
        b=RGB7f4oh6DqipBI3xmasyK+U+8PRNDh/l0pCx9FarpOzgBFepOuWHUXbNPCV/FEwoO
         67Xs0h7EPRK66ZaBBKyNW5HTcrg+L6HZDCT1UJGo9DS5ldtfX3wEPXc9R1tTln3ITuQh
         7+kXZqN+0C/fIah1U2PiAs0Dloftx1wrG3tl5NN+xroLBqlTsBiJNwE+AfzE2riSY100
         IwfY1MP5U8x/EFBKrl6UOegHSfEtpSiy7tkoughZQ/QdRg8h20SfqaavvTnC5Qo9+Nvk
         4dmFwwHa3D0P6tqwfL/CKIQlmaCieZ5uCvVNCxw02HxKWaySPBPVRKn2UCbAM7lPex94
         KpiQ==
X-Gm-Message-State: AC+VfDz81v5TnCC8KX9yZDLSU8M2szv80MNSRvjRT7x9mxxrJZIvXyVf
        z/XT515v0TZpD4goAx5eBEoHjJwdmZI=
X-Google-Smtp-Source: ACHHUZ7Lm7mKbYBEoARo06WCBXZ+FzBsaZNyQTmHvXI7Ln+BXBoJtD8ZyVmuvdGjCDjnvW39prN9DwIEoPQ=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a65:4088:0:b0:540:3370:217a with SMTP id
 t8-20020a654088000000b005403370217amr2031536pgp.5.1686688240543; Tue, 13 Jun
 2023 13:30:40 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Tue, 13 Jun 2023 13:30:34 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Message-ID: <20230613203037.1968489-1-seanjc@google.com>
Subject: [PATCH 0/3] KVM: x86: CR0 vs. KVM_SET_SREGS and !URG
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzbot+5feef0b9ee9c8e9e5689@syzkaller.appspotmail.com,
        Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix a longstanding bug where KVM doesn't check the incoming CR0 provided
by userspace via KVM_SET_SREGS, and then fix a VMX specific bug that let
the missing CR0 check escalate from "just" a failed VM-Entry, to a "KVM is
all kinds of confused and generates a WARN" issue.

Expand the set_sregs_test selftest to provide basic CR0 coverage

Sean Christopherson (3):
  KVM: x86: Disallow KVM_SET_SREGS{2} if incoming CR0 is invalid
  KVM: VMX: Don't fudge CR0 and CR4 for restricted L2 guest
  KVM: selftests: Expand x86's sregs test to cover illegal CR0 values

 arch/x86/include/asm/kvm-x86-ops.h            |  1 +
 arch/x86/include/asm/kvm_host.h               |  3 +-
 arch/x86/kvm/svm/svm.c                        |  6 ++
 arch/x86/kvm/vmx/vmx.c                        | 41 ++++++++---
 arch/x86/kvm/x86.c                            | 34 +++++----
 .../selftests/kvm/x86_64/set_sregs_test.c     | 70 +++++++++++--------
 6 files changed, 100 insertions(+), 55 deletions(-)


base-commit: 24ff4c08e5bbdd7399d45f940f10fed030dfadda
-- 
2.41.0.162.gfafddb0af9-goog

