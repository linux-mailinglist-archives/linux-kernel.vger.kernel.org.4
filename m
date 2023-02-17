Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C6AD69B32A
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 20:31:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbjBQTbd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 14:31:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjBQTbZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 14:31:25 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1349B5DE14
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 11:31:21 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id m21-20020a05600c3b1500b003e1f5f2a29cso1734742wms.4
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 11:31:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=grsecurity.net; s=grsec;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h3qVJ0bF2LOwR9FYE4JKJYonbraLFt3EzjvQr+HEt5I=;
        b=dDJnTYwngnWaEMzbUx4jZ16owZ0sQuT5enltrUeDwvsRnZTa0ZqUFeznb/4baviObx
         t+mRuQUNzNKeXtRe6pvoANi8rM4kQ1odHY5y1ACKAT+zWtZg1GxPJ9SsvSdrd2Bs3cVo
         kDmttHlvLfsqIbJnP3hg9dd7/QuOc/Kuz/qnGqK0bFNL7941EHNQvJmPy7y1fs9wHlTX
         5QvSWkqXB3S5gJWtQpNUDA0cb2n4FIAKZhGtB9j0JrS/VVVCORkenW0VV/qAPT08cQKC
         BVPZn/LC+cnMNSfeAJCYI1xsgmJz3h24QGAileaI9c17I7NU66LYjfXA3IYX49EWP0LI
         Jzmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h3qVJ0bF2LOwR9FYE4JKJYonbraLFt3EzjvQr+HEt5I=;
        b=5i/t2971i3MRS22L03ptfSCfzbE9x2cTo6o+XHWV3Byf1cwYkMxFRJyN6KE+bUkDuo
         dVe6CLk5rZtwCptWX8OairbLYiJR/OYe2uin3/vH6PQVkq8Hs3uC41uFALADsp1gpaeE
         c7ufBrq5rqzvjupHqd+sMMhPzm810ubSAWTr6o4C2EAzPWfu1ZIMJkLpAAPFaTpBeGMv
         wHDgpsyJwqIaKu7FBQXYINoPdw6RGIg9LnjNmFhMH5afUQKbEIdGvC7dPLoUd/QxXmkz
         kRdH7mKcI4HNv2IALdWGbo0c0DpL1u5jG+E6rjXLgOIhXjsK6xAsOZjDsy2vn3drMKgJ
         nT1g==
X-Gm-Message-State: AO0yUKXdLSiFYanBMJcxDj9kUQU6t/gqxYwU10QmrIGE+e/KA1EjUuNy
        sWnjthksz868/pkugQu3kNqbYg==
X-Google-Smtp-Source: AK7set9FnlK5idA3iZnITZZN8lHm8p4XAS8BntZScEnhgNS2QLM37gJ5WgbduUThKUAlYlTQOqBLSg==
X-Received: by 2002:a05:600c:180a:b0:3db:1434:c51a with SMTP id n10-20020a05600c180a00b003db1434c51amr1329698wmp.40.1676662279691;
        Fri, 17 Feb 2023 11:31:19 -0800 (PST)
Received: from nuc.fritz.box (p200300f6af465a00bfa0a0965e5e0d85.dip0.t-ipconnect.de. [2003:f6:af46:5a00:bfa0:a096:5e5e:d85])
        by smtp.gmail.com with ESMTPSA id u9-20020a05600c4d0900b003e1f2e43a1csm5393618wmp.48.2023.02.17.11.31.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Feb 2023 11:31:19 -0800 (PST)
From:   Mathias Krause <minipli@grsecurity.net>
To:     kvm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Mathias Krause <minipli@grsecurity.net>
Subject: [PATCH v2 1/2] KVM: x86: Shrink struct kvm_pmu
Date:   Fri, 17 Feb 2023 20:33:35 +0100
Message-Id: <20230217193336.15278-2-minipli@grsecurity.net>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230217193336.15278-1-minipli@grsecurity.net>
References: <20230217193336.15278-1-minipli@grsecurity.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the 'version' member to the beginning of the structure to reuse an
existing hole instead of introducing another one.

This allows us to save 8 bytes for 64 bit builds.

Signed-off-by: Mathias Krause <minipli@grsecurity.net>
---
 arch/x86/include/asm/kvm_host.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 6aaae18f1854..43329c60a6b5 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -516,6 +516,7 @@ struct kvm_pmc {
 #define KVM_PMC_MAX_FIXED	3
 #define KVM_AMD_PMC_MAX_GENERIC	6
 struct kvm_pmu {
+	u8 version;
 	unsigned nr_arch_gp_counters;
 	unsigned nr_arch_fixed_counters;
 	unsigned available_event_types;
@@ -528,7 +529,6 @@ struct kvm_pmu {
 	u64 global_ovf_ctrl_mask;
 	u64 reserved_bits;
 	u64 raw_event_mask;
-	u8 version;
 	struct kvm_pmc gp_counters[KVM_INTEL_PMC_MAX_GENERIC];
 	struct kvm_pmc fixed_counters[KVM_PMC_MAX_FIXED];
 	struct irq_work irq_work;
-- 
2.39.1

