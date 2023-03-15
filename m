Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E1A26BBD02
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 20:11:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232776AbjCOTLk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 15:11:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232746AbjCOTLf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 15:11:35 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6EF4838A5
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 12:11:34 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 206-20020a2504d7000000b00b3511d10748so15090514ybe.20
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 12:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678907494;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=NrTG/RNvnmx6+qCUMITlqkHzZaqBZaogZoP5BHuvk2o=;
        b=Ln4oqm3uMTtO1Ycn3E5ZXBvER2L0XR0Mog6BKVGC+G7ETMrCmliz22b5QbVcYzWucf
         157OT8hIWXk1CwHAkYlJAm0E7I7okipnOsdZei5Syhx8/i6x9JyYUbUB6ZBHhdWxk2zb
         AZolc+nyJTHsoX6yGj5fQbX8hxqpvG79kHIQ6uai6mN+ClyxejQR/Qvhmk60e5N0TDL5
         xMKRyAgS7Ob9o9EC+3QSPWFqmxyXssn5LMyqBBtg9qHG+A+Z3IC3RuajXDco0U1MUkjA
         LywmmAgrnbZdxT8Vcv4PeWh7NifgbSFSw9vo4rxDo2p7Hb/YEtj5Y6kz+t6gqGIUgIyt
         RkCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678907494;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NrTG/RNvnmx6+qCUMITlqkHzZaqBZaogZoP5BHuvk2o=;
        b=iexT2Q3aSOBp0ckZN5qBEYaCLR0VMtwn4Afm1LqyrA4/ZpzT3XDK62XT22K5MsXdUL
         fUWT9H0SkHtotfmlH8MMRgpMWSLclTGIzsAzkIMao0FW5lLhevVyTOB3pbFkmLEiTrOR
         Bti7OMm9FxTfDCV5FnDOSQ50MfRvl+JG/1A3bS4lGe0dnJGjDYfh4tBpIUwWL563ETZ1
         m3rUZdzBQ/GE33w2Br+zPIqBd/hq8SZTFWNzi7iePfXdnLkGch3T3XQiK9qO2umdNdSa
         r5jQflQv6gn7PjFeGuPCyDjY3btmpRbyiUD8pXj3rBoZo+8M4NOsuOd5feZb4RMv4qCs
         xy1Q==
X-Gm-Message-State: AO0yUKVd+AbuQ2gsaPYZcbkmy4ztqUN0Bht6lli+Rpcj9dguFKG50OQn
        e4Sb3hHbzeYTr39X5RT1LV/3UewNOEU=
X-Google-Smtp-Source: AK7set9L9eMBtTsJBCZzCkxPA4so99AyclhxgsIBkWeEvMjkC8pq4EmQ+TV0Wv8rl6Tt4hvQEQIdBmYJ+QU=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:8c84:0:b0:b23:4649:7ef3 with SMTP id
 m4-20020a258c84000000b00b2346497ef3mr13951296ybl.4.1678907494054; Wed, 15 Mar
 2023 12:11:34 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Wed, 15 Mar 2023 12:11:28 -0700
In-Reply-To: <20230315191128.1407655-1-seanjc@google.com>
Mime-Version: 1.0
References: <20230315191128.1407655-1-seanjc@google.com>
X-Mailer: git-send-email 2.40.0.rc2.332.ga46443480c-goog
Message-ID: <20230315191128.1407655-3-seanjc@google.com>
Subject: [PATCH 2/2] KVM: SVM: Drop unprotected-by-braces variable declaration
 in case-statement
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Emanuele Giuseppe Esposito <eesposit@redhat.com>
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

Remove the intermediate "guest_flush_l1d" boolean to fix a build error on
clang due to the variable being declared inside a case-statement without
curly braces to create a proper code block.

Fixes: cfc1f129df06 ("kvm: svm: Add IA32_FLUSH_CMD guest support")
Cc: Emanuele Giuseppe Esposito <eesposit@redhat.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/svm.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 2780254d4362..70183d2271b5 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -2970,9 +2970,8 @@ static int svm_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr)
 					 PRED_CMD_IBPB, X86_FEATURE_IBPB);
 		break;
 	case MSR_IA32_FLUSH_CMD:
-		bool guest_flush_l1d = guest_cpuid_has(vcpu,
-						       X86_FEATURE_FLUSH_L1D);
-		r = svm_set_msr_ia32_cmd(vcpu, msr, guest_flush_l1d,
+		r = svm_set_msr_ia32_cmd(vcpu, msr,
+					 guest_cpuid_has(vcpu, X86_FEATURE_FLUSH_L1D),
 					 L1D_FLUSH, X86_FEATURE_FLUSH_L1D);
 		break;
 	case MSR_AMD64_VIRT_SPEC_CTRL:
-- 
2.40.0.rc2.332.ga46443480c-goog

