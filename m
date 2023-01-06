Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2598765F8D9
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 02:14:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235327AbjAFBOi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 20:14:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236819AbjAFBNj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 20:13:39 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E50A672D16
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 17:13:36 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id l15-20020a170903244f00b001927c3a0055so134122pls.6
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jan 2023 17:13:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=hanAIN1FDjCqq9DaKdKzw+37XL7mO/LpW1Uuz4oItLY=;
        b=BpE+M+imcFeJplZu6dyhWUzUUaWyR/Fm2UvwG0pbVeRkfy5RLyiWL7CS7gsyVQvwak
         AcFRlBLd8Gi2GEMc1kCZJWHd9kqUKRARrK4J1HATMCTvfK1QDVOyWznFi4TVkwxf7TVr
         PU5DMNU7EfG1NIBLp0Tz4MDNCxp2FVDVb05J4IHw4+DFw4BtwSDAnPvSkXQtKBFIaxsT
         6Jip/PQAxFu1MwNACIkF21o4oDgTD46unsSfN9CjVcHMk/SRJnJ3orggDzTAN0B+9/Le
         r1eP58berdKr1IhYEyG10vPjuzo15J9f6id/gcomZ4yrADSVYphwDpUxND5F+GuDLx0X
         Z9Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hanAIN1FDjCqq9DaKdKzw+37XL7mO/LpW1Uuz4oItLY=;
        b=7mhefcaA11aCJ6I7R6D3UCh9Al6Ddqi9Jqmuu9Fkxfoc2Sr9UCMnShw1HrAeAW2ej7
         kstODZS7aAPe9/EjWaHVtzwIfpoKIFEP44Z2YQy2j7vroCw34ePe1zm2tI0+PYyEDTk2
         aej8i5vz/6Ym1F8M4HxbWvkbLR3dX4fRH6Pcv/PyZ6X8LEMuuNNZo6Zm4BqBQrawg+VT
         WkFeoLQo9aiRWqul9j3qMtE1/FAzSbq2ejlM1TSabvx553EBygcQSesCfWPZ86fiAH7r
         XO9D2xzNxivQnI1Rnwc5qo+XISwaESTeuw8uJ16YXP3otAJhFhB5G0rZlwCZ8I59HMai
         nrhg==
X-Gm-Message-State: AFqh2kpPQXKSR1qP5sdrgkhpXdUm2kMoL2QKNBiK8FaUxrsllD/QQ6C6
        dP+4UzYWolMgPzOa97BgtHefgXvW5WE=
X-Google-Smtp-Source: AMrXdXug5uzFbFp03CGZxhwh+qTEFZM/nw0QQbAl4oU2OUntE7PxWXR8Zcu08nZtctMPkvty7n5fySEy0F4=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90a:a013:b0:223:3448:eb18 with SMTP id
 q19-20020a17090aa01300b002233448eb18mr4464943pjp.41.1672967616474; Thu, 05
 Jan 2023 17:13:36 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri,  6 Jan 2023 01:12:46 +0000
In-Reply-To: <20230106011306.85230-1-seanjc@google.com>
Mime-Version: 1.0
References: <20230106011306.85230-1-seanjc@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20230106011306.85230-14-seanjc@google.com>
Subject: [PATCH v5 13/33] KVM: SVM: Fix x2APIC Logical ID calculation for avic_kick_target_vcpus_fast
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Li RongQing <lirongqing@baidu.com>,
        Greg Edwards <gedwards@ddn.com>
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

From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

For X2APIC ID in cluster mode, the logical ID is bit [15:0].

Fixes: 603ccef42ce9 ("KVM: x86: SVM: fix avic_kick_target_vcpus_fast")
Cc: Maxim Levitsky <mlevitsk@redhat.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/avic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
index f2db0021c45f..0f67fd34ef99 100644
--- a/arch/x86/kvm/svm/avic.c
+++ b/arch/x86/kvm/svm/avic.c
@@ -356,7 +356,7 @@ static int avic_kick_target_vcpus_fast(struct kvm *kvm, struct kvm_lapic *source
 
 		if (apic_x2apic_mode(source)) {
 			/* 16 bit dest mask, 16 bit cluster id */
-			bitmap = dest & 0xFFFF0000;
+			bitmap = dest & 0xFFFF;
 			cluster = (dest >> 16) << 4;
 		} else if (kvm_lapic_get_reg(source, APIC_DFR) == APIC_DFR_FLAT) {
 			/* 8 bit dest mask*/
-- 
2.39.0.314.g84b9a713c41-goog

