Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A69C6740B75
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 10:28:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232663AbjF1I2g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 04:28:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234390AbjF1IZ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 04:25:59 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E87935A0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 01:18:21 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id d75a77b69052e-3ff22072856so51404011cf.3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 01:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=g-ecc-u-tokyo-ac-jp.20221208.gappssmtp.com; s=20221208; t=1687940300; x=1690532300;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YaAvVHVt7cghRwFLnQgjFZ0g8XBe2b92w1gFr9dUG3Q=;
        b=ockouywpe573UKZeZiqzB8g+/lbnY+HTuqRKOh7cRdnihQ/6t0r3v6p/kzAprorjHD
         dmo/6La8YoCEcGhrNgI2IFMhGK0BDSuOQbZR4B5qiLsVxE1JIefzjnoalqu+o0tk1y6M
         D4jnMk8GBEXmp1jOZmrKNI1zqNCLkjT5NqyG3EjHJvDq/syUCGwHNbHDDIfoJBr+mavg
         PCWR8rXMlBtkOZylCTMgDtXxlsc/KK1fUP7WfBXYFP60kZx+PcUlaUvj/QGHR+cMxomK
         DNOKddgP+VgJZwRB7pQKm7IYJQpPxznw6pVhDp3bSO+bM/WXjLOXb4heog8tsNzD6jfj
         Oj1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687940300; x=1690532300;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YaAvVHVt7cghRwFLnQgjFZ0g8XBe2b92w1gFr9dUG3Q=;
        b=GEbNHWIa8WdbMzWYHhySeTWpJlQ63uI/kglMzh3Bcca3e0EZhYQjojPqpuLfKT26Jk
         eXFD7elQrlYNLHLGIQSM7GPLARLNgXJuxD6Izuq7B/1hqPBmrMjHlmhYgJPiM5f96jfL
         SV1ZnqtqJ9xhYfsj7ppq+KWsI63S34vkGMge4gvM/KYOMxns3eBTZNZK+dSgVBis0ONf
         RBew0RX6BJvZyk4NIQsQU3TtE9juazNSWEhriX9HkPyxwRLY092MqUYV265+MyJII5H3
         1GlZ+kzhpDesZxChSPpDRNgziyedQrDKMEySGUFxSwtihTU5z7U8UYwc1TVcbaNw/10+
         LsNg==
X-Gm-Message-State: AC+VfDzlcbGkF5ihY9rcSBNl0AXMJQ/otsIyg9FJlwCwTCALpShW2T9C
        +y9jFNZ6Fr5DSEM4sJddbyQ3ck78X//oTPjDSgYpzV8y
X-Google-Smtp-Source: ACHHUZ5CMH5/HFG+qo5JZyhLGoo9OcY9mI+7JUgKxp/odXJZ7O2JLk9F+U6WXu9CPVXbQ7H/fcAnog==
X-Received: by 2002:a05:6a20:7daa:b0:127:32d9:78f0 with SMTP id v42-20020a056a207daa00b0012732d978f0mr7946880pzj.47.1687936343100;
        Wed, 28 Jun 2023 00:12:23 -0700 (PDT)
Received: from ishii-desktop.. ([133.11.45.41])
        by smtp.gmail.com with ESMTPSA id e13-20020a62aa0d000000b0067526282193sm4884941pff.157.2023.06.28.00.12.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 00:12:22 -0700 (PDT)
From:   Reima Ishii <ishiir@g.ecc.u-tokyo.ac.jp>
Cc:     ishiir@g.ecc.u-tokyo.ac.jp, shina@ecc.u-tokyo.ac.jp,
        Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] KVM: nVMX: Prevent vmlaunch with EPTP pointing outside assigned memory area
Date:   Wed, 28 Jun 2023 16:12:17 +0900
Message-Id: <20230628071217.71126-1-ishiir@g.ecc.u-tokyo.ac.jp>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In nested virtualization, if L1 sets an EPTP in VMCS12 that points
beyond the assigned memory area and initiates a vmlaunch to L2, the
existing KVM code handles the vmlaunch, and passes the VMCS
consistency check. However, due to EPTP pointing outside accessible
memory from the vCPU in mmu_check_root(), it attempts to trigger a
triple fault.

As a result, the nested_vmx_triple_fault() and nested_vmx_vmexit() are
called before the actual vmlaunch to L2 occurs. Despite the vmlaunch
not actually being executed in L2, KVM attempts a vmexit to L1,
resulting in a warning in nested_vmx_vmexit() due to the
nested_run_pending flag.

This commit resolves the issue by modifying the nested_vmx_check_eptp()
to return false when EPTP points outside the assigned memory area.
This effectively prevents a vmlaunch with such an EPTP, thus avoiding
the unnecessary warning.

Signed-off-by: Reima Ishii <ishiir@g.ecc.u-tokyo.ac.jp>
---
 arch/x86/kvm/vmx/nested.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index e35cf0bd0df9..721f98a5dc24 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -2727,6 +2727,10 @@ static bool nested_vmx_check_eptp(struct kvm_vcpu *vcpu, u64 new_eptp)
 			return false;
 	}
 
+	/* Check if EPTP points to an assigned memory area */
+	if (!kvm_vcpu_is_visible_gfn(vcpu, new_eptp >> PAGE_SHIFT))
+		return false;
+
 	return true;
 }
 
-- 
2.34.1

