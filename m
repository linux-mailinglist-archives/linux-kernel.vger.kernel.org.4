Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ACC2692C9A
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 02:46:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbjBKBqg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 20:46:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbjBKBqd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 20:46:33 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E17E96ADD1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 17:46:32 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-507aac99fdfso66631067b3.11
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 17:46:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hkehzV3PgH5ghzIyq+2UQQQuaUD65ZdlOHTF9Rixj6U=;
        b=EiPQ4pAHrHy0B8yMqZ8yaO953edDmUSUzQj/xwAVtNYLDVQBdrP1aQyjZmq12LyB0o
         EQMYlzm0Esy/1xnxItCR2hr1ZOxRpoSJMdTb2h2MUAhEoTl/EmYqpiJYK3PssnuhbMOy
         G5CoXRTLEqmTXCJ2LCgAtHHzG2Ghij/qNtJ4lpWvIwMLHras06ZdUdHD6KCg2rTQVEEe
         pCVgSaRmHw3iav/061EaxrWaKtG5m9LrkyIa0nQqKTZpImolErRK8plBsl2kAvk3co0y
         uPxga+EwGqi4Vhpfuxef2EjKvWFseLoZAkZMoiVsP0WXFWWjCNGGk6Ung6GKU5H7DQvd
         UjJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hkehzV3PgH5ghzIyq+2UQQQuaUD65ZdlOHTF9Rixj6U=;
        b=tera9aWooCXdaSAQUDZ5aGEWeAd7OgGuc0knhVATrxwLovC5jgzFKpv1/Fml/BkKJS
         f+NC/IljoFYVZsveWLUkZiWhx017v6luZRZEqY68IenXQNUhBB940JmrI5hO0QeqIjkt
         q8qD9tV7BQDRB/1HIh2NbQ+Bs3SemBMcrw/sH6QF86uxn6toqmbNmPDkvWEQ2nEswOmx
         1I0PHaUCCBOPwIGVT8OBYni5+/xftEygYuhYo97t9XUkbJEdw+eOvq1af7all7wdVQi2
         VQ2D94o2MuPy31idXzXCUAUmKsrf13N+f1rBdlnnWfmaVliwf4G+990HCLFHI1hZxeIV
         u7AQ==
X-Gm-Message-State: AO0yUKVeSvzBZ8xkQbXKe4HjASC7zjbNJQnJ9/t4X28vyzGaFccfnE7C
        tHDzAB2X8rJFom3If+b1V/9LTmoBBMjM
X-Google-Smtp-Source: AK7set+TVmw4xTKjP8yaDn8Wq3iZ11L0Dey2bnrbR2VzWjmGIvbORcY5HqkmYFCZHbHWYP308yencXrs613h
X-Received: from vipin.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:479f])
 (user=vipinsh job=sendgmr) by 2002:a05:6902:1024:b0:8be:8c5f:9d55 with SMTP
 id x4-20020a056902102400b008be8c5f9d55mr178ybt.3.1676079992025; Fri, 10 Feb
 2023 17:46:32 -0800 (PST)
Date:   Fri, 10 Feb 2023 17:46:19 -0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.1.581.gbfd45094c4-goog
Message-ID: <20230211014626.3659152-1-vipinsh@google.com>
Subject: [Patch v3 0/7] Optimize clear dirty log
From:   Vipin Sharma <vipinsh@google.com>
To:     seanjc@google.com, pbonzini@redhat.com, bgardon@google.com,
        dmatlack@google.com
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vipin Sharma <vipinsh@google.com>
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

Hi,


This patch series has optimized control flow of clearing dirty log and
improved its performance by ~40% (2% more than v2).

It also got rid of many variants of the handle_changed_spte family of
functions and converged logic to one handle_changed_spte() function. It
also remove tdp_mmu_set_spte_no_[acc_track|dirty_log] and various
booleans for controlling them.

Thanks,
Vipin

v3:
- Tried to do better job at writing commit messages.
- Made kvm_tdp_mmu_clear_spte_bits() similar to the kvm_tdp_mmu_write_spte().
- clear_dirty_pt_masked() evaluates mask for the bit to be cleared outside the
  loop and use that for all of the SPTEs instead of calculating for each SPTE.
- Some naming changes based on the feedbacks.
- Split out the dead code clean from the optimization code.


v2: https://lore.kernel.org/lkml/20230203192822.106773-1-vipinsh@google.com/
- Clear dirty log and age gfn range does not go through
  handle_changed_spte, they handle their SPTE changes locally to improve
  their speed.
- Clear only specific bits atomically when updating SPTEs in clearing
  dirty log and aging gfn range functions.
- Removed tdp_mmu_set_spte_no_[acc_track|dirty_log] APIs.
- Converged all handle_changed_spte related functions to one place.

v1: https://lore.kernel.org/lkml/20230125213857.824959-1-vipinsh@google.com/


Vipin Sharma (7):
  KVM: x86/mmu: Add a helper function to check if an SPTE needs atomic
    write
  KVM: x86/mmu: Atomically clear SPTE dirty state in the clear-dirty-log
    flow
  KVM: x86/mmu: Remove "record_dirty_log" in __tdp_mmu_set_spte()
  KVM: x86/mmu: Optimize SPTE change for aging gfn range
  KVM: x86/mmu: Remove "record_acc_track" in __tdp_mmu_set_spte()
  KVM: x86/mmu: Remove handle_changed_spte_dirty_log()
  KVM: x86/mmu: Merge all handle_changed_pte* functions.

 arch/x86/kvm/mmu/tdp_iter.h |  48 ++++++---
 arch/x86/kvm/mmu/tdp_mmu.c  | 190 ++++++++++++------------------------
 2 files changed, 96 insertions(+), 142 deletions(-)

-- 
2.39.1.581.gbfd45094c4-goog

