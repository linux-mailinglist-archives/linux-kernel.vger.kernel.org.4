Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D835C68CB0A
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 01:22:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230223AbjBGAWR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 19:22:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230208AbjBGAWF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 19:22:05 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E19D32E60
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 16:22:03 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id mm21-20020a17090b359500b00230aa18342bso1921985pjb.4
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 16:22:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=Z+LmZZRuX+KyZW/71ICS7KxhCfKW5CHjrLQNU61de+A=;
        b=l/9qGaSnf0c5yPSH7xrquOODy/3TnXfj8KaD3epHTviVTmOJYgWndznufP1aYLuuOJ
         YcbUl1G15s146UHSB3syejf9+slsLGXulYhLZl94LQQTvZtL6CaIknehSmbIgdn4cuG8
         KGf7Vkd1FQsk0Am3KInurKzNKnym94ZGoLzBolWTHVLKIaNveW2X9CjCTvidppbeAyyn
         YGN6dcxtuwBK5mRxnzrYu7GaEsHS91pz6AbfHdH4R0ek8afC+JCp0vWT7q+aprQRY/4k
         swb0UaCOdiztOvS54BhVN7lOq3Fw1VssYVcgxbKPjJIE87zu4m65o4HxiuQ0GwnuqPAJ
         obUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z+LmZZRuX+KyZW/71ICS7KxhCfKW5CHjrLQNU61de+A=;
        b=ijba8I79UcAW7c3B2ue/VECLW6PDmJBJMdsMtDVzzNkR4HC27UGydn/k9s3nkFfh8j
         z+5wEnlgDJY+ED4YFtkliehYj4b02H9S/DNQVt2vP+uMImAPHSbY4fFN+qPt4wveUYYl
         GQwOOY1Rl1PGDtbMjU0trpLSJOv2sYpzwwdybmIu2beNv1nshyMnA3KT8y9+EIblxuxW
         9taL6hbwuxShWFLrGjBPgBspEOpZ1zQnjEwhe9sxQ8qT6dNQccIqFLq06fEmDKhelFIu
         ws+SMOCjChFIAhw3chxqj8eUeJdJRgD7hV/h9See8AOVAAqfA1SgtBhkZEEqcV8xtj37
         tDww==
X-Gm-Message-State: AO0yUKXMMlylBRYw0o5TFKv0o6tBeftq2/GJmIQCFXvxOzOeqc88DhLm
        k1n5J7uHve1tIOvHD0UlKX5VnG+A6RY=
X-Google-Smtp-Source: AK7set+a49kwgE2Gq18gJWSmXwig5Y6bm6XhOCGLCUFhuXgeoq2FvJZfOy6P0wExL/IzHZ/6K+LDfxRA0wY=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:903:2309:b0:199:292f:dbc7 with SMTP id
 d9-20020a170903230900b00199292fdbc7mr225078plh.1.1675729323330; Mon, 06 Feb
 2023 16:22:03 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Tue,  7 Feb 2023 00:21:56 +0000
In-Reply-To: <20230207002156.521736-1-seanjc@google.com>
Mime-Version: 1.0
References: <20230207002156.521736-1-seanjc@google.com>
X-Mailer: git-send-email 2.39.1.519.gcb327c4b5f-goog
Message-ID: <20230207002156.521736-4-seanjc@google.com>
Subject: [PATCH v2 3/3] KVM: SVM: WARN if GATag generation drops VM or vCPU ID information
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
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

WARN if generating a GATag given a VM ID and vCPU ID doesn't yield the
same IDs when pulling the IDs back out of the tag.  Don't bother adding
error handling to callers, this is very much a paranoid sanity check as
KVM fully controls the VM ID and is supposed to reject too-big vCPU IDs.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/avic.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
index 326341a22153..cfc8ab773025 100644
--- a/arch/x86/kvm/svm/avic.c
+++ b/arch/x86/kvm/svm/avic.c
@@ -43,12 +43,21 @@
 #define AVIC_VM_ID_SHIFT		HWEIGHT32(AVIC_PHYSICAL_MAX_INDEX_MASK)
 #define AVIC_VM_ID_MASK			(GENMASK(31, AVIC_VM_ID_SHIFT) >> AVIC_VM_ID_SHIFT)
 
-#define AVIC_GATAG(x, y)		(((x & AVIC_VM_ID_MASK) << AVIC_VM_ID_SHIFT) | \
-						(y & AVIC_VCPU_ID_MASK))
 #define AVIC_GATAG_TO_VMID(x)		((x >> AVIC_VM_ID_SHIFT) & AVIC_VM_ID_MASK)
 #define AVIC_GATAG_TO_VCPUID(x)		(x & AVIC_VCPU_ID_MASK)
 
-static_assert(AVIC_GATAG(AVIC_VM_ID_MASK, AVIC_VCPU_ID_MASK) == -1u);
+#define __AVIC_GATAG(vm_id, vcpu_id)	((((vm_id) & AVIC_VM_ID_MASK) << AVIC_VM_ID_SHIFT) | \
+					 ((vcpu_id) & AVIC_VCPU_ID_MASK))
+#define AVIC_GATAG(vm_id, vcpu_id)					\
+({									\
+	u32 ga_tag = __AVIC_GATAG(vm_id, vcpu_id);			\
+									\
+	WARN_ON_ONCE(AVIC_GATAG_TO_VCPUID(ga_tag) != (vcpu_id));	\
+	WARN_ON_ONCE(AVIC_GATAG_TO_VMID(ga_tag) != (vm_id));		\
+	ga_tag;								\
+})
+
+static_assert(__AVIC_GATAG(AVIC_VM_ID_MASK, AVIC_VCPU_ID_MASK) == -1u);
 
 static bool force_avic;
 module_param_unsafe(force_avic, bool, 0444);
-- 
2.39.1.519.gcb327c4b5f-goog

