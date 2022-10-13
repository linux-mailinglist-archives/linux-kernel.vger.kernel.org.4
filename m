Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C18815FE3F5
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 23:13:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230070AbiJMVNY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 17:13:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229969AbiJMVNM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 17:13:12 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30459192B99
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 14:12:52 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id u9-20020a17090341c900b0017f8514cf61so1966956ple.16
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 14:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uc8kmmFZoUXqBTWy4jGsXZWgvRttVIt6U3EgjEmEwRI=;
        b=G/kNW6cLiqJ/v9Od1bnKW68lrKo88d/zdCSp6txQE7w/+YvpLfpj6f9TCnNHIYWph+
         TaPXLjRugOqs4htlRkaN1cJ0T3TwMZpkb079IXz/ysiXBOCciuMdQ5L0LFxbKzeEVdA+
         2WJwiWCFD/CI8QvPvbSbX6oLKhoFz073GMOB0bZrS8zik0+XRLhvix4nj89uVMjEYKmv
         J9Lh9rcHypVfUzL+7Npa3bqEWkzo0rkEI1e20AKt5EDK5OZeCHQRLO6IXg7AWxTP6fNP
         Xw/GTONzLvgCZSInFFAsctUYIFeDRH3mrv07KKGP2rbBmzaw7SHOFRuPJXJk7bzLC4du
         ZQgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uc8kmmFZoUXqBTWy4jGsXZWgvRttVIt6U3EgjEmEwRI=;
        b=qSe4S6wYwmbivhiP8nUC/GO7wVyRvLpSXgT/8jHJ0U0m7X1ykUHdcZD0xVZ/gjuNCk
         epNoNpLiY1MVelRA3yll/Bz6EFN97mruIJ3l2XreQBZITJl44BpSnrQ5ukgSbsPCR2xa
         47pXL6+82Zft/eEOZhIVoAiHBITJA1u2+sfi369FltcIhgvqiwAwX+eKg0zyqLmhBmMr
         VZUkVuYvHlAXavXyCkP2vCp7B0nkw0J0HIDY9WacjhMBxEHKeU9AfEbwKVTTkG/sfodX
         2q+8tPU7JJeNKklJiRD+jFopJb2fXFnH3HlZ28pFmkzGCwvgjccVBnifYCwyHIGMA8aB
         C3qg==
X-Gm-Message-State: ACrzQf2YNqEBaUxuOnLFaxZJ5DUv2zrx28HgCTZUucVF6B0iyEA+ro3V
        M954H9Ie4N/TdEdGrQqTyTA5t4alIDU=
X-Google-Smtp-Source: AMsMyM6lfBV+A6iTM7o+iwJYvIz2bHF1gq60ZCkj5I0cee9Gh6Ot9beWiHpM8SrReoW+X7Val4T2yNQn6zo=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90b:4c4f:b0:20d:4f5d:6b7c with SMTP id
 np15-20020a17090b4c4f00b0020d4f5d6b7cmr13508911pjb.77.1665695559312; Thu, 13
 Oct 2022 14:12:39 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Thu, 13 Oct 2022 21:12:18 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.38.0.413.g74048e4d9e-goog
Message-ID: <20221013211234.1318131-1-seanjc@google.com>
Subject: [PATCH v2 00/16] KVM: x86: gfn_to_pfn_cache fixes and cleanups
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Michal Luczaj <mhal@rbox.co>,
        David Woodhouse <dwmw2@infradead.org>
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

The highlights are two fixes for bugs where "destroying" and "initializing"
a gfn=>pfn cache while it is being accessed results in various forms of
badness, e.g. re-initialization of an in-use lock, consuming a NULL pointer,
potential memory corruption, etc...

Everything else is cleanup to make the gpc APIs easier to use and harder
to use incorrectly.

David, patch 3 (KVM: x86: Always use non-compat vcpu_runstate_info size...)
in particular needs your eyeballs.  I'm pretty sure it's ok, but
confirmation from someone that actually uses KVM XEN would be nice.

v2:
 - Fix active vs. valid race by rejecting refresh() if the cache is
   currently invalid.
 - Tweak shortlogs to be "KVM" only.  Even though x86 is the only user
   of the caches, I think it makes sense to tag the changes as "full"
   KVM for future readers.
 - Add back the selftest (from the RFC) that triggers the race conditions.
 - Always use non-compat size for checking+refreshing runstate_info and
   make @len truly immutable.
 - Drop unmap() for the moment.  I started adding code to prevent "bad"
   usage, but without any user I couldn't figure out exactly what
   restrictions need to be in place.
 - Do more cleanup.

v1: https://lore.kernel.org/all/20220921020140.3240092-1-mhal@rbox.co

Michal Luczaj (9):
  KVM: Initialize gfn_to_pfn_cache locks in dedicated helper
  KVM: Shorten gfn_to_pfn_cache function names
  KVM: x86: Remove unused argument in gpc_unmap_khva()
  KVM: Store immutable gfn_to_pfn_cache properties
  KVM: Store gfn_to_pfn_cache length as an immutable property
  KVM: Use gfn_to_pfn_cache's immutable "kvm" in kvm_gpc_check()
  KVM: Clean up hva_to_pfn_retry()
  KVM: Use gfn_to_pfn_cache's immutable "kvm" in kvm_gpc_refresh()
  KVM: selftests: Add tests in xen_shinfo_test to detect lock races

Sean Christopherson (7):
  KVM: Reject attempts to consume or refresh inactive gfn_to_pfn_cache
  KVM: x86: Always use non-compat vcpu_runstate_info size for gfn=>pfn
    cache
  KVM: Drop KVM's API to allow temprorarily unmapping gfn=>pfn cache
  KVM: Do not partially reinitialize gfn=>pfn cache during activation
  KVM: Drop @gpa from exported gfn=>pfn cache check() and refresh()
    helpers
  KVM: Skip unnecessary "unmap" if gpc is already valid during refresh
  KVM: selftests: Mark "guest_saw_irq" as volatile in xen_shinfo_test

 arch/x86/kvm/x86.c                            |  24 +--
 arch/x86/kvm/xen.c                            |  84 ++++-----
 include/linux/kvm_host.h                      |  73 ++++----
 include/linux/kvm_types.h                     |   2 +
 .../selftests/kvm/x86_64/xen_shinfo_test.c    | 142 ++++++++++++++-
 virt/kvm/pfncache.c                           | 170 ++++++++++--------
 6 files changed, 320 insertions(+), 175 deletions(-)


base-commit: e18d6152ff0f41b7f01f9817372022df04e0d354
-- 
2.38.0.413.g74048e4d9e-goog

