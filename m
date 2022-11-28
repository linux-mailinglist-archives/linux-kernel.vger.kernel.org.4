Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC6D163B508
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 23:57:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234127AbiK1W5o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 17:57:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234170AbiK1W5l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 17:57:41 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 154895FFC
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 14:57:40 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id z15-20020a17090ab10f00b002191921e2b8so7084528pjq.9
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 14:57:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gXhwSxojV5UHmEXnG+NjQonyC7d2xsSa33CbqUiiJq8=;
        b=hSgB7JFSmngItrugOHdUlailuZnAVkCG/RxcBkttbi0qOQbfqb1JQVgT3HGuVAA/6l
         dgdXNjlRRGN8cOdjYLqYlsQv1Qh6Z19T7KuQgSBDOfaelHgOj5qTIivcGWQsw48UULd5
         k2y592jUfHHKNAR5mPbMv0eYchbUSKzmeN2SexwsIxPSf4WAZF49qV8rT8y5QZlN52FG
         x7Ud/wHiBtjtQI5jHsbPFzL59FZrK/8YzNbjeuRe/OwLeQ7fztF9Fq8hanw8Yz0TxZ/u
         8YApiLvf0BKyliIDb+878EaSR/xv57Rwmz2U+/0skYVSU/713B2Uq8aK9tLUH4GUs42B
         F7aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gXhwSxojV5UHmEXnG+NjQonyC7d2xsSa33CbqUiiJq8=;
        b=i4ziLSN9O1+UebbSEGZk7zODgl16o7En9wy2pDCsifSD3TVOiiz9UB8c1ziUPTWXLh
         bV4p0Q0ma95yHnRO0ELwNmfJUKzUrhiQRBTow8FEEaAAwSs0jWct8AIzahjZbjMliVcD
         uTBoZsnlvzSYg+qOXG16PLLpao9j3Ueu6G9BJXPdRbNVTawAqcuniwfDnRQ0augbbqKj
         sOT0n2Oa21A6bCyzAVtLCVWBxAsj7X2fAyelT6ObcqnJsmiBEMi17VD8QcL92ht3GRvD
         sB+dTCDGmcR0Hor0eZNWZ/Lc10h/+sbmfy9X643JpJqEJ90XZ1NOv1UiT3xL/QV1U/b/
         ON/w==
X-Gm-Message-State: ANoB5pm8XMqsyy+QXOrYp4mMn1Wg8QnLTgNfoJDRRB6MonPlYypZZNCM
        CH4wuCYUpIbrOox8RX9xvyIH00Oap6I=
X-Google-Smtp-Source: AA0mqf6OxYoq4QZgSR4NK6Gu+wimhPcjbY8GPo1++NR3HWSzbaqXlnNBkdZuP/t5ABVh/u9wDfciTmrSVdk=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90b:358:b0:219:46b8:998 with SMTP id
 fh24-20020a17090b035800b0021946b80998mr348719pjb.2.1669676259318; Mon, 28 Nov
 2022 14:57:39 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Mon, 28 Nov 2022 22:57:31 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.38.1.584.g0f3c55d4c2-goog
Message-ID: <20221128225735.3291648-1-seanjc@google.com>
Subject: [PATCH v2 0/4] KVM: selftests: AMX test fix and cleanups
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lei Wang <lei4.wang@intel.com>,
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

Fix a bug in the AMX test introduced by moving to kvm_cpu_has() for
X86_FEATURE_XFD, and clean up the related code.  The fix and cleanups
all revolve around ARCH_REQ_XCOMP_GUEST_PERM impacting the output of
KVM_GET_SUPPORTED_CPUID, and thus causing problems for selftest's
caching of KVM's supported CPUID.

Lei Wang, I adjusted your Author and SOB tags to drop the comma, which I
think? violates that "use your real name" rule, and use formatting from
patches you've sent in the past[*].  Let me know if that's ok (or not).

[*] https://lore.kernel.org/all/20220424101557.134102-9-lei4.wang@intel.com

Lei Wang (1):
  KVM: selftests: Move XFD CPUID checking out of
    __vm_xsave_require_permission()

Sean Christopherson (3):
  KVM: selftests: Move __vm_xsave_require_permission() below CPUID
    helpers
  KVM: selftests: Disallow "get supported CPUID" before
    REQ_XCOMP_GUEST_PERM
  KVM: selftests: Do kvm_cpu_has() checks before creating VM+vCPU

 .../selftests/kvm/lib/x86_64/processor.c      | 84 ++++++++++---------
 tools/testing/selftests/kvm/x86_64/amx_test.c | 11 ++-
 2 files changed, 52 insertions(+), 43 deletions(-)


base-commit: 519c2002cd92bdc37c8412ca22cb9c7e7bc48c48
-- 
2.38.1.584.g0f3c55d4c2-goog

