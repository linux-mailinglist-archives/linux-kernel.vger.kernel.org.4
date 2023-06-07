Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE6F2725130
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 02:43:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240016AbjFGAnS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 20:43:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234392AbjFGAnP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 20:43:15 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DB1210F8
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 17:43:14 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id d9443c01a7336-1b02730e417so61833385ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 17:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686098594; x=1688690594;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bybaLCqc8JhYOjYuGlDyJbEWcYLH95lMWslyp/Hs2bM=;
        b=nJkBLmOj4a6aLchvs36B1oOkZHiCMfyj+WFJhicNmT3QUToiwNmFaZ4DdxDWqqjh//
         pk/OUQ0FsRd53spBKsNdM8daS7QoMHlbt1aCKFoniacZkrXxJtiVGaHI6084FpHd6Cd+
         //VLGDr3QQxwLShIfVhQo+NNLqeJYvRvhETap63v4CkUw/wa4WtNuv7tGEx7rJN3LhRh
         XdQKnGTNQSB/yrO1DA0hd7nurfw4PcnAGeWNQYC35KawB4gMRVnfnGVtcF6nHcB75DPA
         uHvmVHmK4MUpMYBjkLlPOcLKJnVOGc+9r8KGbtyfdi7NZs2FuEuj+x+FZ32MbB/gFT9J
         Rk7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686098594; x=1688690594;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bybaLCqc8JhYOjYuGlDyJbEWcYLH95lMWslyp/Hs2bM=;
        b=haNaAwsurGcW1IdiHy7pBe8dBDF8NER2aQESejT9EiE2KWrkHm6MedJJxG1BsM+05I
         Cm3F3R8CN9NSeIUNTEj2/RCzf6ntDvWlb+i6oImn2RtFbtG+Pb8RLWZotjoHlDFzS03A
         PtzK7SC8j6PN0vMZbMblJYtRv/3US8Ae9j4O8222azUg0eEB6pPz+yfVbI6z7sB8FKEy
         9EsdJKzDD/opBjW3TPnifHAGyq6eaL9hTMnRMrDDR/i6ZFHOwhFxK9i6lAQeLtP6gg4N
         Q7+uoA5TpvZW/k7FLzEmEcyggsitjfiuL5jeeCk3wd9t0IZyLXKqRHekMPvOWClCb/tk
         8Pjw==
X-Gm-Message-State: AC+VfDw2C+NM0JhNLbyKygLy4nFP+Xd3SXMA82aKF2GMbbEAXkZRjK0Y
        YRA/2GGvuMkPo9uwWg/Ss2fyfBCp4B8=
X-Google-Smtp-Source: ACHHUZ5icomASxlkXyL4d7DqqftAUkZdSrOTBL2+Wz+86UQDPbfBgZAGyQSkTxX3pMepA2PV/5UGH9LCVjI=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:903:26d3:b0:1ae:7604:d65c with SMTP id
 jg19-20020a17090326d300b001ae7604d65cmr1130371plb.0.1686098593932; Tue, 06
 Jun 2023 17:43:13 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Tue,  6 Jun 2023 17:43:08 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Message-ID: <20230607004311.1420507-1-seanjc@google.com>
Subject: [PATCH 0/2] KVM: x86: Snapshot host MSR_IA32_ARCH_CAPABILITIES
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chao Gao <chao.gao@intel.com>,
        Xiaoyao Li <xiaoyao.li@intel.com>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
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

Snapshot the host's MSR_IA32_ARCH_CAPABILITIES to avoid repeated RDMSRs
at runtime, and cleanup the pseudo-cache vmx_fb_clear_ctrl_available.

Sean Christopherson (2):
  KVM: x86: Snapshot host's MSR_IA32_ARCH_CAPABILITIES
  KVM: VMX: Drop unnecessary vmx_fb_clear_ctrl_available "cache"

 arch/x86/kvm/vmx/vmx.c | 33 ++++++---------------------------
 arch/x86/kvm/x86.c     | 13 +++++++------
 arch/x86/kvm/x86.h     |  1 +
 3 files changed, 14 insertions(+), 33 deletions(-)


base-commit: 02f1b0b736606f9870595b3089d9c124f9da8be9
-- 
2.41.0.162.gfafddb0af9-goog

