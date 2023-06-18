Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CA97734476
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Jun 2023 02:09:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231934AbjFRAJR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jun 2023 20:09:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230330AbjFRAJP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 20:09:15 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F9A9170E
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jun 2023 17:09:14 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id d9443c01a7336-1b5035b777aso9119225ad.1
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jun 2023 17:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687046953; x=1689638953;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=VS80TIN3Apx7Lv9ngje3zYu1jx02+rpCr9yV1s94q+g=;
        b=qsV0MFwzdd4/C7i0HHJ9CBkbmMVR7hwOd2cmA+0KzTHzNh9ELEVms5TTB/4dzHUDyy
         gGGdEsHTFl85eB0vuIJz6s3e58HYKqZmv2eJfSw+XXEzHrnK15RPIln+eN/w3Mzlec61
         nqju5F/mk+3B7UGborz8J3MyzvFeWabttyLOn3D+a0ziu6+Xt2aVdnvkedR5h4IlvrhX
         Y3FuKXEauGt+lxIdBa18cGzxxXjmubFYp/Y+G3XWoTZOCVdaFMpsjXlNOe1u6FIM6l0U
         DxJKRaifxq5yPP+xvMAo0t85Tci89KUCc436mq+go+r+m0TnblxwU7rIG/1LtDaTjYR9
         hoBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687046953; x=1689638953;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VS80TIN3Apx7Lv9ngje3zYu1jx02+rpCr9yV1s94q+g=;
        b=jSYLplYCRRDBNjdJ2NIMx3QhF+B+00xTU1grsJaEgwEel4FxNqGx6M6Qko60OaL3gz
         OKoMXujHIFxYbY3MCwI70alcLsinm6by87orKLxEyQZqDOEOMX+HzYJEAMHVTw7FWSrq
         gZSbbOcEWvhMOO7Z8T7A9h34vq5VWSvDgWYMmNAeFbPER/jRgKFI+Jz3z9F54pwHg7Zq
         iyEg84iKtDZ7o+gl985HNQH98l9URECOQbkTUap+cyqFKj7B8nKPsRfYGua6UtCHDM9R
         +70iF7bkOT8D6w0DxEIsk87Dsf7uHbc51CQpzYA1CJ1sS62aQIMmTSyr1v4bH8ycAT8Y
         zADg==
X-Gm-Message-State: AC+VfDwr/aQi06rX7Z5B5P+Gl8qzQkljiNuLWSWEa/oftIOv1CL2WIXz
        A7HHsTMTkjTy62kC9n0FNSodSoFrb1CY
X-Google-Smtp-Source: ACHHUZ7FUaWe91QusDNXC7G8USu5P3g7Xm5fFQ3geWg+aIW+9MIzFHs89tza+DkgLMXcq6FDjqk2LCkqQA35
X-Received: from mizhang-super.c.googlers.com ([34.105.13.176]) (user=mizhang
 job=sendgmr) by 2002:a63:ed06:0:b0:546:a389:b815 with SMTP id
 d6-20020a63ed06000000b00546a389b815mr385438pgi.1.1687046953388; Sat, 17 Jun
 2023 17:09:13 -0700 (PDT)
Reply-To: Mingwei Zhang <mizhang@google.com>
Date:   Sun, 18 Jun 2023 00:08:51 +0000
In-Reply-To: <20230618000856.1714902-1-mizhang@google.com>
Mime-Version: 1.0
References: <20230618000856.1714902-1-mizhang@google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Message-ID: <20230618000856.1714902-2-mizhang@google.com>
Subject: [PATCH 1/6] KVM: Documentation: Add the missing guest_mode in kvm_mmu_page_role
From:   Mingwei Zhang <mizhang@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Mingwei Zhang <mizhang@google.com>,
        Jim Mattson <jmattson@google.com>,
        David Matlack <dmatlack@google.com>,
        Ben Gardon <bgardon@google.com>
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

Add the missing guest_mode in kvm_mmu_page_role description. guest_mode
tells KVM whether a shadow page is used for the L1 or an L2. Update the
missing field in documentation.

Signed-off-by: Mingwei Zhang <mizhang@google.com>
---
 Documentation/virt/kvm/x86/mmu.rst | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/virt/kvm/x86/mmu.rst b/Documentation/virt/kvm/x86/mmu.rst
index 8364afa228ec..561efa8ec7d7 100644
--- a/Documentation/virt/kvm/x86/mmu.rst
+++ b/Documentation/virt/kvm/x86/mmu.rst
@@ -202,6 +202,8 @@ Shadow pages contain the following information:
     Is 1 if the MMU instance cannot use A/D bits.  EPT did not have A/D
     bits before Haswell; shadow EPT page tables also cannot use A/D bits
     if the L1 hypervisor does not enable them.
+  role.guest_mode:
+    Indicates the shadow page is created for a nested guest.
   role.passthrough:
     The page is not backed by a guest page table, but its first entry
     points to one.  This is set if NPT uses 5-level page tables (host
-- 
2.41.0.162.gfafddb0af9-goog

