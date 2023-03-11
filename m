Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01B086B56FB
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 01:47:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229945AbjCKAq3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 19:46:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbjCKAq0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 19:46:26 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9973810CEAF
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 16:46:24 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id a10-20020a056a000c8a00b005fc6b117942so3620991pfv.2
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 16:46:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678495584;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=e9RojlZ2eL/0VXIqGaaoxFK7jlplkq7U0XdDBwSj9b0=;
        b=JB4PASMRRmBkJfWFVik95c10a0nFWHxJMxeSDIyWskBg1vNNXKiJJcqABpo2y60OQ7
         h5i/BrzTISduqrtNislgZQ7HQQSIR469ahJc6DGzNpo+0ZhXvhr45jUuM5LX8aKmUhAh
         TZbZfNH5h3H4+9SQMivU5BwRnoAy9/6zmbeBSQe97fjqCa338jJwLiJ3Bsbi08QncREq
         8/M0iDvvjtHsrEEL7no0qzAj+oJIUPnN+0G6zxtiY1UrejZd0uUcwwve63W+QXvcAvF4
         PWbAqzv8LygI2Rh4p2ngvIM1UFJTAeQZXh5aILnCnAQdJwzPiqPET1zI5jaUZ3iMnHAJ
         qIcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678495584;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e9RojlZ2eL/0VXIqGaaoxFK7jlplkq7U0XdDBwSj9b0=;
        b=SK61BOeTQS6YANR+SdM7luZOFImGMI26Sv04dV41BlGfl4VTXtu7+d0AiPh/N7br0H
         m5lezq36fpYh0gn2EPKkLxpDjqonrULnawKRhWLSdj+yeDJHNUAAnRQZiEb1e9f64bjB
         5pjckpn+lIsLNEJGfwV6BPN8ZHoFjJIItMKpmu98RULzaC84AaWurSPs5xYvydjuSObA
         nLFTw/6K9ozWc4TvkvrRPvdrOqDZCQa7N33WYi4QhOTq/7T0LuflDEDqpZxW3kY+8rHU
         cbo35egcwcyTwH7gLBp0AJ2JsIq3ppGmnrz2MM6/RB5nLdOvLp8EFOFJbJCpaDviklqo
         ahcw==
X-Gm-Message-State: AO0yUKUHne7nK6q2zjyUKW2uqfo9F+3rYXnLC0rSgh7XpM2ykT8TyL07
        jLiafx3UddmtjIfuoph11pvGLOD2ipI=
X-Google-Smtp-Source: AK7set9k5FJ5x2cGUuCVUtFIe6AKIb2HNsSgwAS+Cp/2j2PpVT1yAsMCYwhOE5/lzwV4r1vmLT0pjSezYAw=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:9a45:b0:19a:b98f:46a0 with SMTP id
 x5-20020a1709029a4500b0019ab98f46a0mr1605288plv.0.1678495584165; Fri, 10 Mar
 2023 16:46:24 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 10 Mar 2023 16:45:58 -0800
In-Reply-To: <20230311004618.920745-1-seanjc@google.com>
Mime-Version: 1.0
References: <20230311004618.920745-1-seanjc@google.com>
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
Message-ID: <20230311004618.920745-2-seanjc@google.com>
Subject: [PATCH v3 01/21] KVM: x86: Rename kvm_init_msr_list() to clarify it
 inits multiple lists
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xiaoyao Li <xiaoyao.li@intel.com>,
        Like Xu <like.xu.linux@gmail.com>,
        Yu Zhang <yu.c.zhang@linux.intel.com>
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

Rename kvm_init_msr_list() to kvm_init_msr_lists() to clarify that it
initializes multiple lists: MSRs to save, emulated MSRs, and feature MSRs.

No functional change intended.

Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/x86.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index f706621c35b8..7b91f73a837d 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -7071,7 +7071,7 @@ static void kvm_probe_msr_to_save(u32 msr_index)
 	msrs_to_save[num_msrs_to_save++] = msr_index;
 }
 
-static void kvm_init_msr_list(void)
+static void kvm_init_msr_lists(void)
 {
 	unsigned i;
 
@@ -9450,7 +9450,7 @@ static int __kvm_x86_vendor_init(struct kvm_x86_init_ops *ops)
 		kvm_caps.max_guest_tsc_khz = max;
 	}
 	kvm_caps.default_tsc_scaling_ratio = 1ULL << kvm_caps.tsc_scaling_ratio_frac_bits;
-	kvm_init_msr_list();
+	kvm_init_msr_lists();
 	return 0;
 
 out_unwind_ops:
-- 
2.40.0.rc1.284.g88254d51c5-goog

