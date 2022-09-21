Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F27C5E5458
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 22:16:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230488AbiIUUQS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 16:16:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230380AbiIUUQO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 16:16:14 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D642A9CCF4
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 13:16:11 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id m188-20020a633fc5000000b00434dccacd4aso4020851pga.10
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 13:16:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date;
        bh=85AbQQlrxSyNOvkklUzdnLL8SyGBcXrNMjiPdjNbViM=;
        b=GRc1XP6pFfXy+MKZXSkWMWzT1GELN5Jwabnv/SNslVgH962Xpspgo2fYtTGD0wD1yO
         EyDnc2Iv8VL1SoB8JGww4seaGNzIiBGtGJqoEhn0/65bfykOoJr1AqSl9cwPSjHF4gBG
         9BT3JzcOSNTQYZ+EulPuwyqOdBLoRsUsD0iWuGQLzB3RslV8e1ku2UbmzEOs4ddC6jbo
         kwM2kdb7P0yFMuASjfoCnlNLOHjHhlEkAvncZI346xaZBoDAHc9Sefwl3j/AnJ3rxFs1
         eLY6FCz8ZRiHCXxP4cRVO6OWSGPra020qJUeYughUtf5Pko4ioaDFSo1epv/kfT1VBAQ
         a1gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date;
        bh=85AbQQlrxSyNOvkklUzdnLL8SyGBcXrNMjiPdjNbViM=;
        b=JK7KvuAk51luiUhMRjycdkCPA/IS+HfuQcM8cIX4ZGj9q6DuO0aScVke7gzyhEK8/v
         C+QJJgh+/6GXXat1htqcg4zTGBHTpQCdFpyDRTmhX+7PCzEpTEOCHaNRj0ZIoHCfKw07
         XYJUgrNZ5e2yF7HEht/OI56H/eCTyfm0cGg7CvoVbFMZo8/LnrF4YU7ms3QgzNtcpAFM
         z/1s8e4dHQu5aiItkcuSAvvFjjS6CTXHA2LLzNRDsjIIkRtf+jk/C9p/EdmXbcn74j14
         Fv8BjbVbewV9GSGxqY7/LgNduvxzkHveXQeDMQUVYzQHJ/ypgZ/Woj8KDKdTKIK3stgj
         hRZg==
X-Gm-Message-State: ACrzQf2x8zzGJjciBesRmOF4dR/QzY46dy5iEIbuTH+pNTSyieVugKLz
        2UxMo8yyRUHirGqsFjxKwcuZitau8Yo=
X-Google-Smtp-Source: AMsMyM5I2QA6CA+YVRl4Wf7yGB3m1KxYD3Hht8hY5ewEgA+2X6rfKd57lWaEKou7/sOuvb39Yu776+rxPGY=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:2402:b0:52c:81cf:8df2 with SMTP id
 z2-20020a056a00240200b0052c81cf8df2mr30477098pfh.40.1663791370910; Wed, 21
 Sep 2022 13:16:10 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Wed, 21 Sep 2022 20:16:04 +0000
In-Reply-To: <20220921201607.3156750-1-seanjc@google.com>
Mime-Version: 1.0
References: <20220921201607.3156750-1-seanjc@google.com>
X-Mailer: git-send-email 2.37.3.968.ga6b4b080e4-goog
Message-ID: <20220921201607.3156750-2-seanjc@google.com>
Subject: [PATCH 1/4] x86/hyperv: Move VMCB enlightenment definitions to hyperv-tlfs.h
From:   Sean Christopherson <seanjc@google.com>
To:     "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     linux-hyperv@vger.kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

Move Hyper-V's VMCB enlightenment definitions to the TLFS header; the
definitions come directly from the TLFS[*], not from KVM.

No functional change intended.

[*] https://learn.microsoft.com/en-us/virtualization/hyper-v-on-windows/tlfs/datatypes/hv_svm_enlightened_vmcb_fields

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/hyperv-tlfs.h | 22 +++++++++++++++++++
 arch/x86/kvm/svm/hyperv.h          | 35 ------------------------------
 arch/x86/kvm/svm/svm_onhyperv.h    |  3 ++-
 3 files changed, 24 insertions(+), 36 deletions(-)
 delete mode 100644 arch/x86/kvm/svm/hyperv.h

diff --git a/arch/x86/include/asm/hyperv-tlfs.h b/arch/x86/include/asm/hyperv-tlfs.h
index 0a9407dc0859..4c4f81daf5a2 100644
--- a/arch/x86/include/asm/hyperv-tlfs.h
+++ b/arch/x86/include/asm/hyperv-tlfs.h
@@ -584,6 +584,28 @@ struct hv_enlightened_vmcs {
 
 #define HV_VMX_ENLIGHTENED_CLEAN_FIELD_ALL			0xFFFF
 
+/*
+ * Hyper-V uses the software reserved 32 bytes in VMCB control area to expose
+ * SVM enlightenments to guests.
+ */
+struct hv_enlightenments {
+	struct __packed hv_enlightenments_control {
+		u32 nested_flush_hypercall:1;
+		u32 msr_bitmap:1;
+		u32 enlightened_npt_tlb: 1;
+		u32 reserved:29;
+	} __packed hv_enlightenments_control;
+	u32 hv_vp_id;
+	u64 hv_vm_id;
+	u64 partition_assist_page;
+	u64 reserved;
+} __packed;
+
+/*
+ * Hyper-V uses the software reserved clean bit in VMCB.
+ */
+#define VMCB_HV_NESTED_ENLIGHTENMENTS		31
+
 struct hv_partition_assist_pg {
 	u32 tlb_lock_count;
 };
diff --git a/arch/x86/kvm/svm/hyperv.h b/arch/x86/kvm/svm/hyperv.h
deleted file mode 100644
index 7d6d97968fb9..000000000000
--- a/arch/x86/kvm/svm/hyperv.h
+++ /dev/null
@@ -1,35 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- * Common Hyper-V on KVM and KVM on Hyper-V definitions (SVM).
- */
-
-#ifndef __ARCH_X86_KVM_SVM_HYPERV_H__
-#define __ARCH_X86_KVM_SVM_HYPERV_H__
-
-#include <asm/mshyperv.h>
-
-#include "../hyperv.h"
-
-/*
- * Hyper-V uses the software reserved 32 bytes in VMCB
- * control area to expose SVM enlightenments to guests.
- */
-struct hv_enlightenments {
-	struct __packed hv_enlightenments_control {
-		u32 nested_flush_hypercall:1;
-		u32 msr_bitmap:1;
-		u32 enlightened_npt_tlb: 1;
-		u32 reserved:29;
-	} __packed hv_enlightenments_control;
-	u32 hv_vp_id;
-	u64 hv_vm_id;
-	u64 partition_assist_page;
-	u64 reserved;
-} __packed;
-
-/*
- * Hyper-V uses the software reserved clean bit in VMCB
- */
-#define VMCB_HV_NESTED_ENLIGHTENMENTS VMCB_SW
-
-#endif /* __ARCH_X86_KVM_SVM_HYPERV_H__ */
diff --git a/arch/x86/kvm/svm/svm_onhyperv.h b/arch/x86/kvm/svm/svm_onhyperv.h
index e2fc59380465..8d02654ad6f8 100644
--- a/arch/x86/kvm/svm/svm_onhyperv.h
+++ b/arch/x86/kvm/svm/svm_onhyperv.h
@@ -8,8 +8,9 @@
 
 #if IS_ENABLED(CONFIG_HYPERV)
 
+#include <asm/mshyperv.h>
+
 #include "kvm_onhyperv.h"
-#include "svm/hyperv.h"
 
 static struct kvm_x86_ops svm_x86_ops;
 
-- 
2.37.3.968.ga6b4b080e4-goog

