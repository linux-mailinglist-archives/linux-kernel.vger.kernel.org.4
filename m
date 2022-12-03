Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 095466413E6
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Dec 2022 04:05:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231909AbiLCDFq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 22:05:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230321AbiLCDFo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 22:05:44 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52FBEF7A0F
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 19:05:43 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id e7-20020a17090a77c700b00216928a3917so9974138pjs.4
        for <linux-kernel@vger.kernel.org>; Fri, 02 Dec 2022 19:05:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=to:from:cc:content-transfer-encoding:mime-version:references
         :in-reply-to:message-id:date:subject:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0od2UA8BjfVP9H3ox8w77ADIivJIw8By1NOK2zw+FrE=;
        b=KE60HFRJtajGozkhN1G07j7c4EziYG6716Pa6R9qKsnbLrhO3hCPHcTangQUHJQ3GY
         X2rbnjn7S4+RLLyhk83PlpuLOfyJhKoBVtlxnkZuvLLT1Dy0XXbzHJO+Zb1syJAyiJwK
         1HzKJ8H9/hEF3GYwFmyWk0Q0HJt299gtgQDCfvuWmd4WQ04k7q85X+2UiGbQp6C3N8eC
         JB+LwQRi4zg/FQlDJbAjSfuyM8ImcVmPJAoCvFAWZxvGbIfyu5saspnbFUHqAR9GovKz
         bu7+YMpT1y/VmhmBNOg6RXvDyiXtw3R2OK3M9Gt60B1+AIpI/MivGoMygnXM/C8pBqnw
         RD8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:cc:content-transfer-encoding:mime-version:references
         :in-reply-to:message-id:date:subject:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0od2UA8BjfVP9H3ox8w77ADIivJIw8By1NOK2zw+FrE=;
        b=SRkvaeDkWIqmxEBGDcrcxclXkRQIoipcOqDP2pguIwIm8tv2/BHxZ4VuiuPqtolrnu
         3pFzlRMg3ugj0LORK/zNrBkBTG4ATEZ/5912Y8dRz5DdBCd8RVBs+rq6+54iWXNqHgiV
         ZiOtlYJ6PJCJ3t5tX1Gz72oCf0cu7jwVtKegN/8kFpEZRzHXINXg7IJpa/oKN7thLT3L
         IXghDrd/hZIm70VDaaLu7mzCd91YeRrmkLpkEoQh4d6LTpe4oXwng1b2YADYtHVFKekF
         nvYkEya3mP5oi0yP2+AxEDpv7P9GRWBnHkNvb05J+55K9mLcRpPhk3kLsm3MkjFzcIJI
         Z+sQ==
X-Gm-Message-State: ANoB5pmy35SsGKAzTFr8GBwolSolQ7BpPbLRmwx1er61fFuLN9gKEXIL
        iHdoheZnvhIsjiAJyNeumm/Mfw==
X-Google-Smtp-Source: AA0mqf7I3UiJ8c0sc3B4EdMW1XbN/zXhNbb6fQTziUJ0tB9x01rO25QtP9NFuONupmrWTY1OWyBuOA==
X-Received: by 2002:a17:90a:be02:b0:219:8199:ef57 with SMTP id a2-20020a17090abe0200b002198199ef57mr9335059pjs.129.1670036742753;
        Fri, 02 Dec 2022 19:05:42 -0800 (PST)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id y2-20020a17090264c200b001873aa85e1fsm6182904pli.305.2022.12.02.19.05.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 19:05:42 -0800 (PST)
Subject: [PATCH 1/5] mm: Add a leading 0 to the VM_FAULT_* types
Date:   Fri,  2 Dec 2022 19:03:52 -0800
Message-Id: <20221203030356.3917-2-palmer@rivosinc.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221203030356.3917-1-palmer@rivosinc.com>
References: <20221203030356.3917-1-palmer@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc:     Palmer Dabbelt <palmer@rivosinc.com>
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
           linux-s390@vger.kernel.org, linux-arm-kernel@lists.infradead.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The next patch will add enough codes to need another character, this
adds the 0 to all the existing codes to keep alignment.

Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
---
 include/linux/mm_types.h | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 500e536796ca..758eb70829cb 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -862,24 +862,24 @@ typedef __bitwise unsigned int vm_fault_t;
  *				in DAX)
  * @VM_FAULT_COMPLETED:		->fault completed, meanwhile mmap lock released
  * @VM_FAULT_HINDEX_MASK:	mask HINDEX value
- *
+ * @VM_FAULT_ARCH_*:		Architecture-specific VM fault codes.
  */
 enum vm_fault_reason {
-	VM_FAULT_OOM            = (__force vm_fault_t)0x000001,
-	VM_FAULT_SIGBUS         = (__force vm_fault_t)0x000002,
-	VM_FAULT_MAJOR          = (__force vm_fault_t)0x000004,
-	VM_FAULT_WRITE          = (__force vm_fault_t)0x000008,
-	VM_FAULT_HWPOISON       = (__force vm_fault_t)0x000010,
-	VM_FAULT_HWPOISON_LARGE = (__force vm_fault_t)0x000020,
-	VM_FAULT_SIGSEGV        = (__force vm_fault_t)0x000040,
-	VM_FAULT_NOPAGE         = (__force vm_fault_t)0x000100,
-	VM_FAULT_LOCKED         = (__force vm_fault_t)0x000200,
-	VM_FAULT_RETRY          = (__force vm_fault_t)0x000400,
-	VM_FAULT_FALLBACK       = (__force vm_fault_t)0x000800,
-	VM_FAULT_DONE_COW       = (__force vm_fault_t)0x001000,
-	VM_FAULT_NEEDDSYNC      = (__force vm_fault_t)0x002000,
-	VM_FAULT_COMPLETED      = (__force vm_fault_t)0x004000,
-	VM_FAULT_HINDEX_MASK    = (__force vm_fault_t)0x0f0000,
+	VM_FAULT_OOM            = (__force vm_fault_t)0x0000001,
+	VM_FAULT_SIGBUS         = (__force vm_fault_t)0x0000002,
+	VM_FAULT_MAJOR          = (__force vm_fault_t)0x0000004,
+	VM_FAULT_WRITE          = (__force vm_fault_t)0x0000008,
+	VM_FAULT_HWPOISON       = (__force vm_fault_t)0x0000010,
+	VM_FAULT_HWPOISON_LARGE = (__force vm_fault_t)0x0000020,
+	VM_FAULT_SIGSEGV        = (__force vm_fault_t)0x0000040,
+	VM_FAULT_NOPAGE         = (__force vm_fault_t)0x0000100,
+	VM_FAULT_LOCKED         = (__force vm_fault_t)0x0000200,
+	VM_FAULT_RETRY          = (__force vm_fault_t)0x0000400,
+	VM_FAULT_FALLBACK       = (__force vm_fault_t)0x0000800,
+	VM_FAULT_DONE_COW       = (__force vm_fault_t)0x0001000,
+	VM_FAULT_NEEDDSYNC      = (__force vm_fault_t)0x0002000,
+	VM_FAULT_COMPLETED      = (__force vm_fault_t)0x0004000,
+	VM_FAULT_HINDEX_MASK    = (__force vm_fault_t)0x00f0000,
 };
 
 /* Encode hstate index for a hwpoisoned large page */
-- 
2.38.1

