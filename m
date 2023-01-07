Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 049E5660B4D
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 02:11:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236878AbjAGBKq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 20:10:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236389AbjAGBKf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 20:10:35 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE44D848D0
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jan 2023 17:10:30 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id h7-20020a17090a710700b00225b277a376so1325589pjk.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jan 2023 17:10:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=LV2RtCx7AgI4jwo15Fa/1V+X8I2HVQFzUwPIYOqkwuM=;
        b=RB0P+AiM7Ro6qxXSPF3+Sp9LanhO69duwhhSSgPfbLzQX1hAhPZ9YyOopGd1vMiuX6
         67K3IfOePjx3hVXxgft+SzLK8wCmCzQTIhgeHB+BQVfqf94kiS+zvq2waY9ztBvTRV83
         BiwVZQwxeLB0WKivldbm+ZhsPF/dqhdTxWuaPck9nML4vD5wsTqENEULq2yxCpoitrVh
         QkXEIWaquzKahVnoedYm/fQ6GJwAdSFD4CoNcX73oywhUb3z1ETpDva+ItRqAiMeqvqQ
         cgLx23h6rc6sssovy3wdMbZXXKIR6oj8rmNJkN0Q+mrnOtgILXUXZ2+V95MYcnaUYILB
         34Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LV2RtCx7AgI4jwo15Fa/1V+X8I2HVQFzUwPIYOqkwuM=;
        b=gBxnn6zb4GzQFDJNQbY2KICcqw1eRLkoBpuLrHavo1b+flLF8D2rOIwk5LXJCgfUW1
         21XSgGMTospK7bTG4lH5ugkAhN3ED4IKYivaZHJImsX0VHpLW9eFfEIClguB3mRquQog
         7K4qb7Egcj/KLSLL4ke4BrfSo7bdagrOvcJHDyvRrx3e74cOipPpjBb0zhEhn2V1jMaI
         /oAeYn7/h/j1YVACzK7C43cXVtJS3f2soBtL62/g/+gO3oy9+fwh3Kr+1qcyO+SNrhG7
         2Nrtv+1BqHYAHxfvfk7inq57eg1AA/+Y1jZnpLlnJ87LmE6raNP0uHfV/AK3QbKOBOdi
         lCPw==
X-Gm-Message-State: AFqh2kqv3EYbZqlqBWwLgpTPpVyk9c+105nNT2UbfNh2A8LfLa5ZLr0E
        u3s65/xZzkbSlQbFO1pIbM2ixDMWnUo=
X-Google-Smtp-Source: AMrXdXsyXZUOj1a/2/DniWCHXzsM4PEJ3Kwwp5WBDrvDVi3eDp1/faIIPIhPetyQes+WaMJb8b6ximeom1A=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:2487:b0:57a:a199:902f with SMTP id
 c7-20020a056a00248700b0057aa199902fmr4031049pfv.52.1673053830336; Fri, 06 Jan
 2023 17:10:30 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Sat,  7 Jan 2023 01:10:20 +0000
In-Reply-To: <20230107011025.565472-1-seanjc@google.com>
Mime-Version: 1.0
References: <20230107011025.565472-1-seanjc@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20230107011025.565472-2-seanjc@google.com>
Subject: [PATCH 1/6] KVM: x86: Inject #GP if WRMSR sets reserved bits in APIC Self-IPI
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Marc Orr <marcorr@google.com>, Ben Gardon <bgardon@google.com>,
        Venkatesh Srinivas <venkateshs@chromium.org>
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

Inject a #GP if the guest attempts to set reserved bits in the x2APIC-only
Self-IPI register.  Bits 7:0 hold the vector, all other bits are reserved.

Reported-by: Marc Orr <marcorr@google.com>
Cc: Ben Gardon <bgardon@google.com>
Cc: Venkatesh Srinivas <venkateshs@chromium.org>
Cc: stable@vger.kernel.org
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/lapic.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index 80f92cbc4029..f77da92c6ea6 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -2315,10 +2315,14 @@ static int kvm_lapic_reg_write(struct kvm_lapic *apic, u32 reg, u32 val)
 		break;
 
 	case APIC_SELF_IPI:
-		if (apic_x2apic_mode(apic))
-			kvm_apic_send_ipi(apic, APIC_DEST_SELF | (val & APIC_VECTOR_MASK), 0);
-		else
+		/*
+		 * Self-IPI exists only when x2APIC is enabled.  Bits 7:0 hold
+		 * the vector, everything else is reserved.
+		 */
+		if (!apic_x2apic_mode(apic) || (val & ~APIC_VECTOR_MASK))
 			ret = 1;
+		else
+			kvm_apic_send_ipi(apic, APIC_DEST_SELF | val, 0);
 		break;
 	default:
 		ret = 1;
-- 
2.39.0.314.g84b9a713c41-goog

