Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 950E4720C5C
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Jun 2023 01:33:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236474AbjFBXdF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 19:33:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236355AbjFBXdC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 19:33:02 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0983419A
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 16:33:02 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id 98e67ed59e1d1-2563e180afbso2236218a91.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jun 2023 16:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685748781; x=1688340781;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pCXZg6Oy+xN3Rwd1UhaJwVcBe7/5FpW0ylkWc9yUkQ4=;
        b=mF+odgoW4j0afExDuvV2tZNpOSgkQfDbLprpsACWGOwKqTp4owjgSSVv4cYoJkeWHW
         wb5F6yXH9IdsrqzKbhYgq9SP9omcK0ec/Wido+wwB4VxEXsCET1JMNzF2XMAYOVm/vMl
         9gkgsBBgNKdTW8MafvBpy5ONYklAuYeBp+9ac8V6JidZ/lJafyXyVTuG390GP3Ob7w27
         9UBho+52AVMQVh5xk1eHyRW6A6vHmoq3owTPOnkrkk1ZZI5c54Hey3infc6xY2yondu3
         kP4Xu3623yf3ifnboLeneoB/Zjbk3q0DFAI8Mf1BqNanritoajLFyTfGlgeSteGROuu2
         8EfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685748781; x=1688340781;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pCXZg6Oy+xN3Rwd1UhaJwVcBe7/5FpW0ylkWc9yUkQ4=;
        b=D20zOORB/6pSN1Ppslho2LCnFgRzVcreCAa1UhZmI1pvAbfhvXgcg+8aoyxJieksTY
         SaVwCs9Q1i7gZhsCOaH8xlBlqGFaNfC+krJU4iMGUTHava7VBaxAfqp+iOmF8JMkBxV2
         RDY0n94F1lnirRufPlrrr+LmBWNhyHXEdx38vlaY+Y1PFYiFw0sRx/B1cPzO5yjNKIwp
         tBFudKSZmr4jJaDX8hSUE3ye2KkG/u2r8GrOA0nEa1SuEKnIqKMuAKNgCtFxuFpIoZtY
         TKeO06UgQGo41nLdOsqsM6guA/5kjOwNaOsksD/cuBcjk7FRiakexKx3z+/oWy7o87Er
         lxuQ==
X-Gm-Message-State: AC+VfDwpOzVJoWJUo1w/uqJVwytYCUO0pyVwFFrG622FHV2tqiiL4NdW
        jnXN5VPSDoRQonEQy95xExghBkhh5Fs=
X-Google-Smtp-Source: ACHHUZ7PcT3/sOp+3IgCYwQqCc312Je4AFDiSB2M6u9f789rq7CA5mFCfVQ3gbhtGjmEOOuxN14OFeor2nA=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90b:e82:b0:256:4689:e358 with SMTP id
 fv2-20020a17090b0e8200b002564689e358mr305476pjb.1.1685748781499; Fri, 02 Jun
 2023 16:33:01 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri,  2 Jun 2023 16:32:47 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.rc2.161.g9c6817b8e7-goog
Message-ID: <20230602233250.1014316-1-seanjc@google.com>
Subject: [PATCH v3 0/3]  KVM: x86: Out-of-bounds access in kvm_recalculate_phys_map()
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Michal Luczaj <mhal@rbox.co>
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

In Michal's words...

kvm_recalculate_apic_map() creates the APIC map iterating over the list of
vCPUs twice. First to find the max APIC ID and allocate a max-sized buffer,
then again, calling kvm_recalculate_phys_map() for each vCPU. This opens a
race window: value of max APIC ID can increase _after_ the buffer was
allocated.

v3:
 - s/race/test for the new test file
 - Use kvm_vm_free() instead of kvm_vm_release() in the test
 - Fix a few typos in the test

v2: https://lore.kernel.org/all/20230526235048.2842761-1-seanjc@google.com

v1: https://lore.kernel.org/all/20230525183347.2562472-1-mhal@rbox.co

Michal Luczaj (1):
  KVM: selftests: Add test for race in kvm_recalculate_apic_map()

Sean Christopherson (2):
  KVM: x86: Bail from kvm_recalculate_phys_map() if x2APIC ID is
    out-of-bounds
  KVM: x86: Retry APIC optimized map recalc if vCPU is added/enabled

 arch/x86/kvm/lapic.c                          | 49 ++++++++++--
 tools/testing/selftests/kvm/Makefile          |  1 +
 .../kvm/x86_64/recalc_apic_map_test.c         | 74 +++++++++++++++++++
 3 files changed, 118 insertions(+), 6 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/x86_64/recalc_apic_map_test.c


base-commit: 39428f6ea9eace95011681628717062ff7f5eb5f
-- 
2.41.0.rc2.161.g9c6817b8e7-goog

