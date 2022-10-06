Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ADD65F5E0A
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 02:52:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229918AbiJFAvy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 20:51:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbiJFAvm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 20:51:42 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FC454331B
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 17:51:35 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id j25-20020aa78d19000000b00561f966ae13so251802pfe.14
        for <linux-kernel@vger.kernel.org>; Wed, 05 Oct 2022 17:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=RgqORs+iZiHuiK4jt5s3dsauOVZm6CsCgSWJtdsZN8o=;
        b=FxoDzY8XpT60khM5OBGeJ/D5kPXbNfUM4qcx/QTvfmOQXe/vch3V0rTv2Iw9WB8Wxy
         QB45BylluYWq5qpsrVeK2N1XB4KEZYPGISN1pbovBZn4zDjJuSbWdr8qdNF9tTWqni2B
         sbCamdHMqgan5+c7T+Dvq/fmqEzqquDmmyC3MRwVHpmKX/zyib7eQslFP1yMyYV3hwN+
         lwI2xjgDZto+Z/MjkiYyr3JukcLqef/To/eLc+uP7/O1URB+RZEemhoNpVUBAE5R5RM0
         UlJlUCptd4G0OOqKPpCv3MKbwP3tUbS0vhlYJa+P0LvSfXsxyChKzLc06ggE5IqdSyfZ
         /HfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RgqORs+iZiHuiK4jt5s3dsauOVZm6CsCgSWJtdsZN8o=;
        b=cTqmDqgu2WEUyx56On2h4GQyatFrw/dUVFsePbrVUM6XZirsQ4ZgtBP0jAoOxsCOfQ
         DR/uPRx79A2KSVAydG9N92cuWcW/kVTWlLRcOF6d4iz+2WRv/BKN0gOw9DMT+n4Xofrw
         P26zPSPux/DYTHJrtRa5l5qICkdqnb3LKoSH440yqF3pJznvAKySgRZ5z6HqN4Ga2sqt
         FDLnietNSv86DZTJx6UpdVj8IzzVwdApwBs86Y75uilOo1ylgREd3nZrBptWh11btngh
         WnjudJEdgmLLotywkqZJevz4oyp4em1uTuRKnk7o02Kge2oihTp7dUmlNd93UQdoxD4b
         gfbA==
X-Gm-Message-State: ACrzQf3/+gSQhzTskuPM5ezv8bNHMTkhZt7MaT+Hi/Y0OvzuUfF9KP3J
        dWO7WgQaLtSeQ42qrZZ2IhJlPweDcYQ=
X-Google-Smtp-Source: AMsMyM5Y8ZUJYm2GCo4nEB94UeSd03qSWycjsUKsOL3g8CtGhjzUgZWDKUOskY9v66RS2DxVT+kC0rIDAoQ=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90a:aa96:b0:205:bb67:a85f with SMTP id
 l22-20020a17090aaa9600b00205bb67a85fmr2370445pjq.202.1665017494809; Wed, 05
 Oct 2022 17:51:34 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Thu,  6 Oct 2022 00:51:17 +0000
In-Reply-To: <20221006005125.680782-1-seanjc@google.com>
Mime-Version: 1.0
References: <20221006005125.680782-1-seanjc@google.com>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
Message-ID: <20221006005125.680782-5-seanjc@google.com>
Subject: [PATCH 04/12] KVM: selftests: Use X86_PROPERTY_MAX_KVM_LEAF in CPUID test
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
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

Use X86_PROPERTY_MAX_KVM_LEAF to replace the equivalent open coded check
on KVM's maximum paravirt CPUID leaf.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/x86_64/cpuid_test.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86_64/cpuid_test.c b/tools/testing/selftests/kvm/x86_64/cpuid_test.c
index a6aeee2e62e4..2fc3ad9c887e 100644
--- a/tools/testing/selftests/kvm/x86_64/cpuid_test.c
+++ b/tools/testing/selftests/kvm/x86_64/cpuid_test.c
@@ -43,15 +43,6 @@ static void test_guest_cpuids(struct kvm_cpuid2 *guest_cpuid)
 
 }
 
-static void test_cpuid_40000000(struct kvm_cpuid2 *guest_cpuid)
-{
-	u32 eax, ebx, ecx, edx;
-
-	cpuid(0x40000000, &eax, &ebx, &ecx, &edx);
-
-	GUEST_ASSERT(eax == 0x40000001);
-}
-
 static void guest_main(struct kvm_cpuid2 *guest_cpuid)
 {
 	GUEST_SYNC(1);
@@ -60,7 +51,7 @@ static void guest_main(struct kvm_cpuid2 *guest_cpuid)
 
 	GUEST_SYNC(2);
 
-	test_cpuid_40000000(guest_cpuid);
+	GUEST_ASSERT(this_cpu_property(X86_PROPERTY_MAX_KVM_LEAF) == 0x40000001);
 
 	GUEST_DONE();
 }
-- 
2.38.0.rc1.362.ged0d419d3c-goog

