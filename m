Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D79B464AE2F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 04:30:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234175AbiLMDah (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 22:30:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiLMDaf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 22:30:35 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6330F1B9C0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 19:30:34 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-3ceb4c331faso153405777b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 19:30:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fvHSXXCkeu3/4sx+gtxDD1f9+Q7yHtx6Qc7Gq8TcTlk=;
        b=LLRdDTGJMdrQ+p+GUnDsrf1yDPoRSSppeKjQs4nboSb+avGRmawlspUOhOBG45/Oyc
         Y716L2oH9GnjWvtIhq7tQlvtAnPF5QUESJd/UyMZ3SF1NcBmFdEoRa6/UTyjYEb7oYHT
         08KZOXU3p/P3Famupq2pckKrUL6+9bANZ166gzgFvEotOsNUJSTQZe1IUe/yL/xdXccJ
         1Qi7bVajLliCxxq8uzKbZxczNBCDyOtI1M6bSv9GDhFCjQ/kufDbk3Wt4phE36kgW870
         5AVp7S9JPiWbqOwB61ImhJiUOKRzzcboJbFhd7FJezjy3zGlHw/e+FAjspljmpyRvvW1
         5fkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fvHSXXCkeu3/4sx+gtxDD1f9+Q7yHtx6Qc7Gq8TcTlk=;
        b=nMhnq3RdqlRjlN3UgsJWZTtiMJ3Uvzsk+Yb5wGZYCr5mCN+m0jEqNR7Cf80pqdbT6R
         qnJWc8dC1VDnUP7rbm3ANv/XPQdVmxPPiYgJ3PTxFhnWgbu8PMbk3CkOu+N4JEA39Sfl
         Md+55FtLcC9KExHqMCdzCrsambyaopifQDib9i24gGUr9gwDD8dnWnoXbzSnBGcCpUA2
         PFRUnYf4OTaw3/PPz+pxMFO/OtJEudRsXolkc1wqNzaAID9DREGwIEM/4ZsfYQuRnEa6
         PbecO/9WXsatfQnqqNjU/k5inbb7yRQYEIm/N5icWzXylI1Vly47uNg2fHfc5xdRAK7o
         WuFQ==
X-Gm-Message-State: ANoB5pkcGIVkOkKd5xUwYcj1M6WyUrmMbpRhGvNlaaUoJBMwZdX89RVA
        6ZyiNKNVTPW8GQ7kyKrsTr8lgMkiqeE=
X-Google-Smtp-Source: AA0mqf7WZkWhOp4xReQE+hoO2FppB9Dpsyv3a/YVfDmXeNw9+aBoYg6nPEnSRG4nKBDA9RC1ub3rwu1vP8g=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a81:998a:0:b0:3dd:49a2:837b with SMTP id
 q132-20020a81998a000000b003dd49a2837bmr30831405ywg.241.1670902233643; Mon, 12
 Dec 2022 19:30:33 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Tue, 13 Dec 2022 03:30:25 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.0.rc1.256.g54fd8350bd-goog
Message-ID: <20221213033030.83345-1-seanjc@google.com>
Subject: [PATCH 0/5] KVM: x86/mmu: TDP MMU fixes for 6.2
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Robert Hoo <robert.hu@linux.intel.com>,
        Greg Thelen <gthelen@google.com>,
        David Matlack <dmatlack@google.com>,
        Ben Gardon <bgardon@google.com>,
        Mingwei Zhang <mizhang@google.com>
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

Fix three fatal TDP MMU bugs introduced in 6.2, harden related code,
and clean up kvm_tdp_mmu_map() to eliminate the need for gotos.

Sean Christopherson (5):
  KVM: x86/mmu: Don't attempt to map leaf if target TDP MMU SPTE is
    frozen
  KVM: x86/mmu: Map TDP MMU leaf SPTE iff target level is reached
  KVM: x86/mmu: Re-check under lock that TDP MMU SP hugepage is
    disallowed
  KVM: x86/mmu: Don't install TDP MMU SPTE if SP has unexpected level
  KVM: x86/mmu: Move kvm_tdp_mmu_map()'s prolog and epilog to its caller

 arch/x86/kvm/mmu/mmu.c          |  9 +++++++-
 arch/x86/kvm/mmu/mmu_internal.h |  1 -
 arch/x86/kvm/mmu/tdp_mmu.c      | 39 +++++++++++++++------------------
 3 files changed, 26 insertions(+), 23 deletions(-)


base-commit: 51229fd7872f82af07498aef5c79ad51baf81ea0
-- 
2.39.0.rc1.256.g54fd8350bd-goog

