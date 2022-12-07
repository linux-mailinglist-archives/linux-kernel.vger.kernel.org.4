Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E152D645002
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 01:10:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229452AbiLGAKE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 19:10:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbiLGAKC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 19:10:02 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E4E82F386
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 16:10:02 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id 38-20020a630b26000000b004773803dda1so13246452pgl.17
        for <linux-kernel@vger.kernel.org>; Tue, 06 Dec 2022 16:10:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lFyjvE+/usZ3mHWbZDkMlHN2qIDbnx/TDXsa9Xl7diU=;
        b=dRgE7CandgE839OqfBwtAVB5NMh/v3rnYdKjFozZHdPbpdwNQpIj+Z5ey1WMfdACTo
         YqrFJX8ZLeDx2dAovWK1rk+CC28V5xnr7L+rvAv2Is6ewS7EOgvZL5tyzvDZA8Gxpr/N
         9+QMcZwI17keGuCRIRzna/hTpBdqqdnIeo6ouvvm1QNoiZ1i7gv/NjJoB0GXD2VmPTQu
         JQuGO/1UAP4fK0EMYjMnyKey8Gkxfx2O6dkOddHm0/Be10T9dofh48yqXyChvOMMGqOk
         VVqym7N9fi/A7BSsOLLEl6oTExwoGpgF8Vi0Gb0M0OCQP7fvoqHjOGpOh4avxIk2m3iS
         eOKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lFyjvE+/usZ3mHWbZDkMlHN2qIDbnx/TDXsa9Xl7diU=;
        b=rZpL7ngB9pE6MLv3B/1HNx1y7xtT8bmICv/KEL1OQrwzvEfzAsTrFO3aXwQcWVbKQ6
         gy/POWmK4Kxn1dWp7w7btKJKyQ6sm6wcoGZws4/CiUBpKWRQ2ilqAJBhARlN6cZbqXnX
         Pu75zUCWFLwRaoL3AKAIFK9oVtLOa/kUYkrhskOpFpbzkkGlnaWqEcdDCSe3zxWSlc5r
         7aHsQonc+OgeoDflTIUTdbuIbjAtuwIP2Z0kv+h9bFrWqpSfkmBGnP57QLUyCR2EZAPU
         wDeNcNWdDGi94Jxj1gXPg5N8nOY0pWQ7uobCBwhU9TZ8K60PeAn7PVF8q9cl8da3CWso
         OH7g==
X-Gm-Message-State: ANoB5pk7uXYt+yBLiYyiIG9ksRA0iI8sbXVFOV4mLeMtP8hiRLqcldR8
        EywEFgR9QC1Q8LtkC5q+csLRi3KXW80=
X-Google-Smtp-Source: AA0mqf4cNsZWl1zzyodMeMpedAkAZqTR2t/dWfgEz4iIHZJvBatP9uhywFio0ZWjCQq3WwoJMdE9i8IqHko=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a62:168f:0:b0:574:80c6:7106 with SMTP id
 137-20020a62168f000000b0057480c67106mr61852303pfw.23.1670371801577; Tue, 06
 Dec 2022 16:10:01 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Wed,  7 Dec 2022 00:09:59 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.0.rc1.256.g54fd8350bd-goog
Message-ID: <20221207000959.2035098-1-seanjc@google.com>
Subject: [PATCH] KVM: x86: Add proper ReST tables for userspace MSR exits/flags
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add ReST formatting to the set of userspace MSR exits/flags so that the
resulting HTML docs generate a table instead of malformed gunk.  This
also fixes a warning that was introduced by a recent cleanup of the
relevant documentation (yay copy+paste).

 >> Documentation/virt/kvm/api.rst:7287: WARNING: Block quote ends
    without a blank line; unexpected unindent.

Fixes: 1ae099540e8c ("KVM: x86: Allow deflecting unknown MSR accesses to user space")
Fixes: 1f158147181b ("KVM: x86: Clean up KVM_CAP_X86_USER_SPACE_MSR documentation")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 Documentation/virt/kvm/api.rst | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index c618fae44ad7..778c6460d1de 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -6455,9 +6455,11 @@ The "reason" field specifies why the MSR interception occurred. Userspace will
 only receive MSR exits when a particular reason was requested during through
 ENABLE_CAP. Currently valid exit reasons are:
 
-	KVM_MSR_EXIT_REASON_UNKNOWN - access to MSR that is unknown to KVM
-	KVM_MSR_EXIT_REASON_INVAL - access to invalid MSRs or reserved bits
-	KVM_MSR_EXIT_REASON_FILTER - access blocked by KVM_X86_SET_MSR_FILTER
+============================ ========================================
+ KVM_MSR_EXIT_REASON_UNKNOWN access to MSR that is unknown to KVM
+ KVM_MSR_EXIT_REASON_INVAL   access to invalid MSRs or reserved bits
+ KVM_MSR_EXIT_REASON_FILTER  access blocked by KVM_X86_SET_MSR_FILTER
+============================ ========================================
 
 For KVM_EXIT_X86_RDMSR, the "index" field tells userspace which MSR the guest
 wants to read. To respond to this request with a successful read, userspace
@@ -7256,11 +7258,13 @@ to inform a user that an MSR was not emulated/virtualized by KVM.
 
 The valid mask flags are:
 
-	KVM_MSR_EXIT_REASON_UNKNOWN - intercept accesses to unknown (to KVM) MSRs
-	KVM_MSR_EXIT_REASON_INVAL   - intercept accesses that are architecturally
-                                invalid according to the vCPU model and/or mode
-	KVM_MSR_EXIT_REASON_FILTER  - intercept accesses that are denied by userspace
-                                via KVM_X86_SET_MSR_FILTER
+============================ ===============================================
+ KVM_MSR_EXIT_REASON_UNKNOWN intercept accesses to unknown (to KVM) MSRs
+ KVM_MSR_EXIT_REASON_INVAL   intercept accesses that are architecturally
+                             invalid according to the vCPU model and/or mode
+ KVM_MSR_EXIT_REASON_FILTER  intercept accesses that are denied by userspace
+                             via KVM_X86_SET_MSR_FILTER
+============================ ===============================================
 
 7.22 KVM_CAP_X86_BUS_LOCK_EXIT
 -------------------------------

base-commit: 3d7af7c5e000c68581429d533ed63414e4a48e6d
-- 
2.39.0.rc1.256.g54fd8350bd-goog

