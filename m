Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D85C462CF7F
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 01:24:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234398AbiKQAYC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 19:24:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234170AbiKQAYA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 19:24:00 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBE5B61BBB
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 16:23:58 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id b1-20020a17090a10c100b0020da29fa5e5so227314pje.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 16:23:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=f1KDr+rH3XIqQLVQCEwig1RrLbtV2JH7CIwItqPq0uE=;
        b=Sb0CLlnDvxGcJjdPFEdXu3sQ7ExS0J2DsrUa96MG+x30pOPo41C8wX8lnkjEvFu692
         o3pvJ4nlLGDjV9D5+o/Xc1NHyPs2MuqEv5vvIqZ+sqZzIL/ssXgFKRuEh3ykOWsb8Aof
         8NuSb0SC0FoNWARBXd8nIP1nNXh5DasKaX+CcaBKFNHtvZl56/253TE6fwjP5JoMpiim
         gUPzWrrXnAvNi8nnM084PxpxGvTGH19Xn+GRoqghoBS14moljDfd44Cr3RqglOvym254
         gzMKd+B+aCWjFP6TQW5RMTEuFyf2CyJjQHrsUsqBJWG2Qn401exrcaqrEcOx43Ax6pEw
         +BbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f1KDr+rH3XIqQLVQCEwig1RrLbtV2JH7CIwItqPq0uE=;
        b=PHLgzBinkcVhsyCqQGNVoBNxpwUc26rTiZeag3/erwEKzfmzehITTf0OYG7Oj84soy
         JoM50KXzT+baHF/Dgk+w+0pJEDJbtGd2UuvpqffCL2/GB3ulUqS7gGoM+6OYgo7tFv3k
         BQrHGb/iwGK7Ue8dX40kHuVzeDR7xYj2cCiRlmi+5j7LCOmjhE1kb5JDIe0hDx2BLM9U
         jCjhQVXNzfNky0Hg43ww53N4nWyGiYUm4EGhO/MqviYLEXpL7gQ19LjJUnAVhlDQAoHG
         SkCdPLC/yay7DNs+yfj/FeTDrtv0tWAapQXVShgXtFQoiqeaWov/AUnhGUtJkbUIqrSA
         EWrA==
X-Gm-Message-State: ANoB5pmMp+V3iDMWBeQ7fDbhq9z7oW85j1aH3INDtFTFqe3sfw7C1bxx
        rUPNkW4BiA9hdh4xdAq4qI7iQ9JCnfI=
X-Google-Smtp-Source: AA0mqf413lvrUg1TdHwZHTgN7XZflJ1bKJMT3jX1WCVJjGcPVxVBe4WRIWEnFUWoG+XWNbACIBeMBtLtEhE=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90b:a17:b0:213:2708:8dc3 with SMTP id
 gg23-20020a17090b0a1700b0021327088dc3mr636229pjb.2.1668644638088; Wed, 16 Nov
 2022 16:23:58 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Thu, 17 Nov 2022 00:23:49 +0000
In-Reply-To: <20221117002350.2178351-1-seanjc@google.com>
Mime-Version: 1.0
References: <20221117002350.2178351-1-seanjc@google.com>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
Message-ID: <20221117002350.2178351-2-seanjc@google.com>
Subject: [PATCH 1/2] KVM: arm64: selftests: Disable single-step with correct
 KVM define
From:   Sean Christopherson <seanjc@google.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Oliver Upton <oliver.upton@linux.dev>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org,
        Reiji Watanabe <reijiw@google.com>,
        Sean Christopherson <seanjc@google.com>
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

Disable single-step by setting debug.control to KVM_GUESTDBG_ENABLE,
not to SINGLE_STEP_DISABLE.  The latter is an arbitrary test enum that
just happens to have the same value as KVM_GUESTDBG_ENABLE, and so
effectively disables single-step debug.

No functional change intended.

Cc: Reiji Watanabe <reijiw@google.com>
Fixes: b18e4d4aebdd ("KVM: arm64: selftests: Add a test case for KVM_GUESTDBG_SINGLESTEP")
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/aarch64/debug-exceptions.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/aarch64/debug-exceptions.c b/tools/testing/selftests/kvm/aarch64/debug-exceptions.c
index 947bd201435c..91f55b45dfc7 100644
--- a/tools/testing/selftests/kvm/aarch64/debug-exceptions.c
+++ b/tools/testing/selftests/kvm/aarch64/debug-exceptions.c
@@ -369,7 +369,7 @@ void test_single_step_from_userspace(int test_cnt)
 						KVM_GUESTDBG_SINGLESTEP;
 				ss_enable = true;
 			} else {
-				debug.control = SINGLE_STEP_DISABLE;
+				debug.control = KVM_GUESTDBG_ENABLE;
 				ss_enable = false;
 			}
 
-- 
2.38.1.431.g37b22c650d-goog

