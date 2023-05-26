Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 698807130A3
	for <lists+linux-kernel@lfdr.de>; Sat, 27 May 2023 01:51:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230376AbjEZXu4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 19:50:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231341AbjEZXuw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 19:50:52 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAAC183
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 16:50:51 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-565a66a5d84so17911637b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 16:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685145051; x=1687737051;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GrrbCTNmuoStmkrRuA8nAkDHAJuHJg+G1Ouxa5BEv0E=;
        b=mTELTflySAQiCs9/L8ypvXX/eTvO6pIM2XukZz0HRry6ElpVfxuvF3c5N068qIlCAk
         k9AwIdmbQMpqPeMRBvZZrTdMrkC9Z7Vu0RCDajLwkIiIUp3HgRvBSggzqGb/HZAY7ovb
         bLRpUxscmxUk737WD9naghz/xT0aukmgjM9ooxoCqHhDcv5S+M+1VlxM9blNYxTHThdx
         oWi5spgRGEmKEet0XuSz26RRSwWMS/ame/liPHy7UP6yNZYoSBp1Sd3yznXvwglCFW1z
         35S9pH9rfzByljMOnIy9ZkQsaM7E6zOGuJg9DGSp7ZWeuUXnUpd11aQMyeUjsYaLwU8v
         yOwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685145051; x=1687737051;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GrrbCTNmuoStmkrRuA8nAkDHAJuHJg+G1Ouxa5BEv0E=;
        b=H20K4iJJgCkXaDCLQqnQESXv+qRiAGOi+cvaVUbPNo+QwlWqs9gaAFQV2C4fFEfRV5
         cbAy4KPL7Q4LRos4Rt+MmRTa2ZlMJwXjAvoSL+fz63HXahKT7iAFhEZS0lEzfGfwVMGQ
         dmho431c5HwQDbEqvkP4u9I7zNrhk1PyUNhRcRUb/j5AmKop+4RFZC+wIbz9uJks6IA2
         2puK4njp+Dy8Cd/eA2psMJNAmoaCa6fwf5GYlmcTu4MrQW1VCmf5tQ+s0wheX2IZCfsK
         SamtAZxnNSJXLyUfQQilNAmVuz/mJxM8IgfnaTtHnaRpIAFGzAymaAQ4VvDbDnJk0lWE
         V9FQ==
X-Gm-Message-State: AC+VfDwLka6OA8sY1tbM8pdOxzB8T4QN6FAKFN7i9i6kK0xTbau2PrHt
        ks0soJKKR46slEMxvF+1giiR2tHQlg8=
X-Google-Smtp-Source: ACHHUZ7jwct2wpyWq7yunLwSh70YAsCdVUzujKPG4lOkNzlIVbE7aRs+7mCaFuepIiYMflTyG3QxO3elvYk=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a81:4050:0:b0:561:8ff6:fb5b with SMTP id
 m16-20020a814050000000b005618ff6fb5bmr1955724ywn.10.1685145051003; Fri, 26
 May 2023 16:50:51 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 26 May 2023 16:50:45 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Message-ID: <20230526235048.2842761-1-seanjc@google.com>
Subject: [PATCH v2 0/3] KVM: x86: Out-of-bounds access in kvm_recalculate_phys_map()
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

v2 of Michal's fix for a TOCTOU bug in kvm_recalculate_phys_map().   Not
fully tested (will do that next week), though I did confirm the reworked
selftest can hit the bug.  Posting a bit prematurely as I have a long weekend
and I don't want Michal to do any duplicate work.

In Michal's words...

kvm_recalculate_apic_map() creates the APIC map iterating over the list of
vCPUs twice. First to find the max APIC ID and allocate a max-sized buffer,
then again, calling kvm_recalculate_phys_map() for each vCPU. This opens a
race window: value of max APIC ID can increase _after_ the buffer was
allocated.

Michal Luczaj (1):
  KVM: selftests: Add test for race in kvm_recalculate_apic_map()

Sean Christopherson (2):
  KVM: x86: Bail from kvm_recalculate_phys_map() if x2APIC ID is
    out-of-bounds
  KVM: x86: Retry APIC optimized map recalc if vCPU is added/enabled

 arch/x86/kvm/lapic.c                          | 49 ++++++++++--
 tools/testing/selftests/kvm/Makefile          |  1 +
 .../kvm/x86_64/recalc_apic_map_race.c         | 76 +++++++++++++++++++
 3 files changed, 120 insertions(+), 6 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/x86_64/recalc_apic_map_race.c


base-commit: 39428f6ea9eace95011681628717062ff7f5eb5f
-- 
2.41.0.rc0.172.g3f132b7071-goog

