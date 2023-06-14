Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55FD471F795
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 03:15:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233263AbjFBBP0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 21:15:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233250AbjFBBPW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 21:15:22 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B15E9195
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 18:15:21 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-ba8337ade1cso2064059276.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jun 2023 18:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685668521; x=1688260521;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0tlzbGXwY0mpJeijrUSkgUG6k3pOYpSjtTcL5wAkHcw=;
        b=RFiNfGYRqxpzHS/rqpX2OkiuJOxtydzugc22q7Nm4RhSlapGiF5FGII5Q26nABlhrx
         rbNh+IA7n7rZjl1nwMmh7QCEKe9sWmX+t8dpIK3F9QFNG9e+zu5KBmr72+hRNDKgwdlz
         a9LvCUFcC/FXIkPYxcfBkPLSE46KR/Q3NtVqc1tFWZGGd4AUvu6ogQbOqHlju3DpG7MM
         Q90DSCchF7KgvTcaNOB49whFZNtkgeZYLhcaUWjwyoHha+DUlSDuMZ7HQ5vCEJYBDEaW
         tGa66bh6kSZpfN91b62iNdfNvgPbTwbJUl1LUgp72pWoNzcj5x3SqPLRu4bwbJoikNB5
         IjUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685668521; x=1688260521;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0tlzbGXwY0mpJeijrUSkgUG6k3pOYpSjtTcL5wAkHcw=;
        b=dNFT9PkcUoNRUXvc0QWf9j1aQIdCkiJaHIxyo6z9S4Pr4jDzBWeVgInUfWMPbbWFE/
         Y1GtckPE99aubicWbJ8YQUUiCfPGCTJVpX/+Ivd+8TxwU3cj1CQeI3T9UImkEtfiMs2K
         KH4WFSXfFJTU0HWnGCEMVJLQhjBt5Hy1fYmGk9PFsMSnq+3OHfvrlbO/oDQiSUwjic+R
         Eexg4k+adSjT2amef9QdVyZRFFyXWiGZIaWNZAHvvyvaIEma/Bga0HqWfdcc6Wk8NCMO
         nNOT2mGcIFIx79l+llZ1uvzcAQVBJRad230PMQBQLWutiS+USSqHa6FqBlYXaS7Lmpp/
         muMQ==
X-Gm-Message-State: AC+VfDyLxXgmD4CIwq4uUUUjmXJzo8Z5fEejQLCR8U/EeeDQ+EzgCrvl
        mHmGkvsxp9icOM01SRVDowFJwuG2eoQ=
X-Google-Smtp-Source: ACHHUZ70r1XuZdxCzYEo97jE4Pq2ClCaqlRSWQ16NIAneWSWU2zks99oGnXCTMaI7e8vddHx1xnNDMWld4Y=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:102f:b0:bb1:3606:6a29 with SMTP id
 x15-20020a056902102f00b00bb136066a29mr755797ybt.3.1685668521018; Thu, 01 Jun
 2023 18:15:21 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Thu,  1 Jun 2023 18:15:15 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.rc2.161.g9c6817b8e7-goog
Message-ID: <20230602011518.787006-1-seanjc@google.com>
Subject: [PATCH 0/3] KVM: x86: Use "standard" mmu_notifier hook for APIC page
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jason Gunthorpe <jgg@nvidia.com>,
        Alistair Popple <apopple@nvidia.com>,
        Robin Murphy <robin.murphy@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert VMX's handling of mmu_notifier invalidations of the APIC-access page
from invalidate_range() to KVM's standard invalidate_range_{start,end}().

KVM (ab)uses invalidate_range() to fudge around not stalling vCPUs until
relevant in-flight invalidations complete.  Abusing invalidate_range() works,
but it requires one-off code in KVM, sets a bad precedent in KVM, and is
blocking improvements to mmu_notifier's definition of invalidate_range()
due to KVM's usage diverging wildly from the original intent of notifying
IOMMUs of changes to shared page tables.

Clean up the mess by hooking x86's implementation of kvm_unmap_gfn_range()
and stalling vCPUs by re-requesting KVM_REQ_APIC_PAGE_RELOAD until the
invalidation completes.

Sean Christopherson (3):
  KVM: VMX: Retry APIC-access page reload if invalidation is in-progress
  KVM: x86: Use standard mmu_notifier invalidate hooks for APIC access
    page
  KVM: x86/mmu: Trigger APIC-access page reload iff vendor code cares

 arch/x86/kvm/mmu/mmu.c   |  4 ++++
 arch/x86/kvm/vmx/vmx.c   | 50 ++++++++++++++++++++++++++++++++++++----
 arch/x86/kvm/x86.c       | 14 -----------
 include/linux/kvm_host.h |  3 ---
 virt/kvm/kvm_main.c      | 18 ---------------
 5 files changed, 49 insertions(+), 40 deletions(-)


base-commit: 39428f6ea9eace95011681628717062ff7f5eb5f
-- 
2.41.0.rc2.161.g9c6817b8e7-goog

