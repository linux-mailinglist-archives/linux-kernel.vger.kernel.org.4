Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F628708D3E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 03:19:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231189AbjESBTg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 21:19:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230312AbjESBTb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 21:19:31 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DCC910D2
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 18:19:29 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id 98e67ed59e1d1-24e3b69bc99so2141066a91.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 18:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684459169; x=1687051169;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TQS98FLuUxt8kfip9Nk8O1hVfeuWAt0sl7+06c/6tso=;
        b=OGPd3mn4AXIrc1RRZIu250DTtUsK1KYvi8EfuJPLZrZrm+XTM1dOslqaOYntJ4QlnF
         P1XUdOXQFW2q48KVb2YvQI1UOuJ6zvUuQNOwxGx4Ltcqz+zGeskAKaAjKOirPNTB39HS
         jBq/1Yq0YsewgO7yu5hZy+p7qvRI04QhhT2rY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684459169; x=1687051169;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TQS98FLuUxt8kfip9Nk8O1hVfeuWAt0sl7+06c/6tso=;
        b=jm0WZkGR4kCIDVqtYYcRvjZNzFymvygfrZkA1gZJB+f4L/31iVTggM73ISSAlC5WXe
         UyAI2Vf/NA9GCS6242ewS+2O+RF1OovwD8eOrtGViy7Oj+TLgJKeiuAWcZUx36t8YmmM
         p2Q/WyezVmGHyGHi+2zy8Ra7NKYMz/Ol3V70E189+54CpZ/aWD3hQzo/d2ebo+h34SYo
         CGmDPmSJBkJO0ectkqvSQsoOmTVOIvg0Oh18PhYW9wV86hIsJnrgCtnFmoWr1lScjfFq
         S907P3vSYGlJ21+hIZSkqWpsgjy2xRRWpfSGNtQBnu6nL3c43HFQjUj3rH+5YciMzzej
         Q3yA==
X-Gm-Message-State: AC+VfDzc8lGExZj3dX0PC8ji41GVSOzyICHUGVean5glYzlrfnzSonby
        928LhotuuHDb8JjHrBrhsV817A==
X-Google-Smtp-Source: ACHHUZ61pfxccHt/KzXaf0wYbWk/1Tu3oFrft5OWJaPA3VQ8PQiXauBnEJkKqfgy+TrBmMg73D6nkg==
X-Received: by 2002:a17:90b:3ecc:b0:246:85ec:d816 with SMTP id rm12-20020a17090b3ecc00b0024685ecd816mr538354pjb.3.1684459168766;
        Thu, 18 May 2023 18:19:28 -0700 (PDT)
Received: from localhost (183.43.230.35.bc.googleusercontent.com. [35.230.43.183])
        by smtp.gmail.com with UTF8SMTPSA id a19-20020a17090acb9300b0025356cce0e4sm279592pju.24.2023.05.18.18.19.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 May 2023 18:19:28 -0700 (PDT)
From:   jeffxu@chromium.org
To:     dave.hansen@intel.com, luto@kernel.org, jorgelo@chromium.org,
        keescook@chromium.org, groeck@chromium.org, jannh@google.com,
        sroettger@google.com
Cc:     akpm@linux-foundation.org, jeffxu@google.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, linux-hardening@vger.kernel.org
Subject: [PATCH v1 2/6] PKEY: Add arch_check_pkey_enforce_api()
Date:   Fri, 19 May 2023 01:19:10 +0000
Message-ID: <20230519011915.846407-3-jeffxu@chromium.org>
X-Mailer: git-send-email 2.40.1.698.g37aff9b760-goog
In-Reply-To: <20230519011915.846407-1-jeffxu@chromium.org>
References: <20230519011915.846407-1-jeffxu@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jeff Xu <jeffxu@google.com>

This patch adds an architecture-independent function,
arch_check_pkey_enforce_api(), that checks whether the calling thread
has write access to the PKRU for a given range of memory. If the
memory range is protected by PKEY_ENFORCE_API, then the thread must
have write access to the PKRU in order to make changes to the memory
mapping (such as mprotect/munmap).

This function is used by the kernel to enforce the
PKEY_ENFORCE_API flag.

Signed-off-by: Jeff Xu<jeffxu@google.com>
---
 arch/powerpc/include/asm/pkeys.h |  8 +++++
 arch/x86/include/asm/pkeys.h     | 50 ++++++++++++++++++++++++++++++++
 include/linux/pkeys.h            |  9 ++++++
 3 files changed, 67 insertions(+)

diff --git a/arch/powerpc/include/asm/pkeys.h b/arch/powerpc/include/asm/pkeys.h
index 943333ac0fee..24c481e5e95b 100644
--- a/arch/powerpc/include/asm/pkeys.h
+++ b/arch/powerpc/include/asm/pkeys.h
@@ -177,5 +177,13 @@ static inline bool arch_check_pkey_alloc_flags(unsigned long flags)
 	return true;
 }
 
+static inline int arch_check_pkey_enforce_api(struct mm_struct *mm,
+					      unsigned long start,
+					      unsigned long end)
+{
+	/* Allow by default */
+	return 0;
+}
+
 extern void pkey_mm_init(struct mm_struct *mm);
 #endif /*_ASM_POWERPC_KEYS_H */
diff --git a/arch/x86/include/asm/pkeys.h b/arch/x86/include/asm/pkeys.h
index ecadf04a8251..8b94ffc4ca32 100644
--- a/arch/x86/include/asm/pkeys.h
+++ b/arch/x86/include/asm/pkeys.h
@@ -161,4 +161,54 @@ static inline bool arch_check_pkey_alloc_flags(unsigned long flags)
 
 	return true;
 }
+
+static inline int __arch_check_vma_pkey_for_write(struct vm_area_struct *vma)
+{
+	int pkey = vma_pkey(vma);
+
+	if (mm_pkey_enforce_api(vma->vm_mm, pkey)) {
+		if (!__pkru_allows_write(read_pkru(), pkey))
+			return -EACCES;
+	}
+
+	return 0;
+}
+
+/*
+ * arch_check_pkey_enforce_api is used by the kernel to enforce
+ * PKEY_ENFORCE_API flag.
+ * It checks whether the calling thread  has write access to the PKRU
+ * for a given range of memory. If the  memory range is protected by
+ * PKEY_ENFORCE_API, then the thread must  have write access to the
+ * PKRU in order to make changes to the memory  mapping, such as
+ * mprotect/munmap.
+ */
+static inline int arch_check_pkey_enforce_api(struct mm_struct *mm,
+					      unsigned long start,
+					      unsigned long end)
+{
+	int error;
+	struct vm_area_struct *vma;
+
+	if (!arch_pkeys_enabled())
+		return 0;
+
+	while (true) {
+		vma = find_vma_intersection(mm, start, end);
+		if (!vma)
+			break;
+
+		error = __arch_check_vma_pkey_for_write(vma);
+		if (error)
+			return error;
+
+		if (vma->vm_end >= end)
+			break;
+
+		start = vma->vm_end;
+	}
+
+	return 0;
+}
+
 #endif /*_ASM_X86_PKEYS_H */
diff --git a/include/linux/pkeys.h b/include/linux/pkeys.h
index 81a482c3e051..7b00689e1c24 100644
--- a/include/linux/pkeys.h
+++ b/include/linux/pkeys.h
@@ -53,6 +53,15 @@ static inline bool arch_check_pkey_alloc_flags(unsigned long flags)
 		return false;
 	return true;
 }
+
+static inline int arch_check_pkey_enforce_api(struct mm_struct *mm,
+					      unsigned long start,
+					      unsigned long end)
+{
+	// Allow by default.
+	return 0;
+}
+
 #endif /* ! CONFIG_ARCH_HAS_PKEYS */
 
 #endif /* _LINUX_PKEYS_H */
-- 
2.40.1.606.ga4b1b128d6-goog

