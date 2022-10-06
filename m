Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D03C5F717D
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 01:01:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230202AbiJFXBY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 19:01:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231733AbiJFXBQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 19:01:16 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4D1EFF8F9
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 16:01:15 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id o9-20020a17090a0a0900b0020ad4e758b3so3140495pjo.4
        for <linux-kernel@vger.kernel.org>; Thu, 06 Oct 2022 16:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cGJ0aXb4+6SLJXuBysL8NC2xxbfShZ/UoZmW53mcBQY=;
        b=3OwzcldRJKjmccwp3k4qQk2ikxSeiRctYo/pRTDlhgsDnHVGqDF8Bdp3LBLimlB5Cu
         SXyWm4Dxd0j/A+6YvO92wRVh779SFZbYurko2j7d2VSL1gqCDwXOVXltm6d+SBChEDlC
         eEzyhZoVLVc5+461nJUPHG46ZUr+x/ux0uwShYT+WyOoOrrSo+jUwEt1ZvGWLs4dRQAH
         dLOSwn7VnLgCzzamyccn3c31j7TAh++h5Uoc4z9/AjlUvY/EOo9lLYXTQfImumIdid3N
         G74TuIat5Sun9TQmXRiZQ5chGFj+FEf9raiVQOH27Lvq2hZkCUEj5LNjN5zlcvRxZKFJ
         UYJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cGJ0aXb4+6SLJXuBysL8NC2xxbfShZ/UoZmW53mcBQY=;
        b=0T4XmKtxIQRNF41v+wDG6q0u/vlwmoMidDVmtgtIDAf5ObqqTza79yzzVNSkf4AcHb
         vJEuPicB2H48jh6ZH0wPM6zQAIAturYgKqwbpYpUZrhFr1c8m+CQJc6Mc9nE70Z9SwKd
         0ZF8rmiwm2AJ4YtFjUSfjBpVhD1KMveBktqGNIT7mqX3NKa+j5N/c5zJs7asnavgaRBz
         7PRVx5+T+TrErq3rMYXXTBpBleqpsJcozTPQGisA+sjarnQPSFd4UNVD7+xIhcVqAScf
         5ooL5hDt0EG87VCx/O7hX7vUjmlFC5rlx22+k8p8q1Tn404CIhrlhS4XGxE9J/qeNE3e
         Y/KA==
X-Gm-Message-State: ACrzQf2XYsot6Ac+FxxzLiZG8S6t30D49CQyhMWFfeun+QmS7gpal4JI
        KnBIn9VmIgTjUKWSLmqseTL2a7GAzOxDJA==
X-Google-Smtp-Source: AMsMyM4V+aOL609DtBHKVFtR70u5RAzhg1viS1+xBjDUxh36dGV/8dI0hx2MEhKQvzg73DEfruHB2g==
X-Received: by 2002:a17:90b:314b:b0:203:41c:2dbb with SMTP id ip11-20020a17090b314b00b00203041c2dbbmr2027298pjb.18.1665097275204;
        Thu, 06 Oct 2022 16:01:15 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([66.220.2.162])
        by smtp.gmail.com with ESMTPSA id bc8-20020a656d88000000b0043a1c0a0ab1sm257309pgb.83.2022.10.06.16.01.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 16:01:14 -0700 (PDT)
From:   Atish Patra <atishp@rivosinc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atishp@rivosinc.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Daniel Kiper <daniel.kiper@oracle.com>,
        Fu Wei <tekkamanninja@gmail.com>,
        Leif Lindholm <quic_llindhol@quicinc.com>,
        Nikita Ermakov <arei@altlinux.org>,
        Atish Patra <atishp@atishpatra.org>,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        Julian Andres Klode <julian.klode@canonical.com>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: [v4 PATCH 2/3] RISC-V: Update image header
Date:   Thu,  6 Oct 2022 16:00:50 -0700
Message-Id: <20221006230051.185850-3-atishp@rivosinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221006230051.185850-1-atishp@rivosinc.com>
References: <20221006230051.185850-1-atishp@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the RISC-V Linux kernel image headers as per the current header.

Reference:
<Linux kernel source>/Documentation/riscv/boot-image-header.rst

474efecb65dc: ("riscv: modify the Image header to improve compatibility with the ARM64 header")

Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 include/grub/riscv32/linux.h | 15 ++++++++-------
 include/grub/riscv64/linux.h | 21 +++++++++++++--------
 2 files changed, 21 insertions(+), 15 deletions(-)

diff --git a/include/grub/riscv32/linux.h b/include/grub/riscv32/linux.h
index 512b777c8a41..de0dbdcd1be5 100644
--- a/include/grub/riscv32/linux.h
+++ b/include/grub/riscv32/linux.h
@@ -19,20 +19,21 @@
 #ifndef GRUB_RISCV32_LINUX_HEADER
 #define GRUB_RISCV32_LINUX_HEADER 1
 
-#define GRUB_LINUX_RISCV_MAGIC_SIGNATURE 0x52534356 /* 'RSCV' */
+#define GRUB_LINUX_RISCV_MAGIC_SIGNATURE 0x05435352 /* 'RSC\0x5' */
 
-/* From linux/Documentation/riscv/booting.txt */
+/* From linux/Documentation/riscv/boot-image-header.rst */
 struct linux_riscv_kernel_header
 {
   grub_uint32_t code0;		/* Executable code */
   grub_uint32_t code1;		/* Executable code */
-  grub_uint64_t text_offset;	/* Image load offset */
-  grub_uint64_t res0;		/* reserved */
-  grub_uint64_t res1;		/* reserved */
+  grub_uint64_t text_offset;	/* Image load offset, little endian */
+  grub_uint64_t image_size;	/* Effective Image size, little endian */
+  grub_uint64_t flags;		/* kernel flags, little endian */
+  grub_uint32_t version;	/* Version of this header */
+  grub_uint32_t res1;		/* reserved */
   grub_uint64_t res2;		/* reserved */
   grub_uint64_t res3;		/* reserved */
-  grub_uint64_t res4;		/* reserved */
-  grub_uint32_t magic;		/* Magic number, little endian, "RSCV" */
+  grub_uint32_t magic;		/* Magic number, little endian, "RSC\x05" */
   grub_uint32_t hdr_offset;	/* Offset of PE/COFF header */
 };
 
diff --git a/include/grub/riscv64/linux.h b/include/grub/riscv64/linux.h
index 3630c30fbf1a..ea77f8718222 100644
--- a/include/grub/riscv64/linux.h
+++ b/include/grub/riscv64/linux.h
@@ -19,23 +19,28 @@
 #ifndef GRUB_RISCV64_LINUX_HEADER
 #define GRUB_RISCV64_LINUX_HEADER 1
 
-#define GRUB_LINUX_RISCV_MAGIC_SIGNATURE 0x52534356 /* 'RSCV' */
+#include <grub/efi/pe32.h>
+
+#define GRUB_LINUX_RISCV_MAGIC_SIGNATURE 0x05435352 /* 'RSC\0x5' */
 
 #define GRUB_EFI_PE_MAGIC	0x5A4D
 
-/* From linux/Documentation/riscv/booting.txt */
+/* From linux/Documentation/riscv/boot-image-header.rst */
 struct linux_riscv_kernel_header
 {
   grub_uint32_t code0;		/* Executable code */
   grub_uint32_t code1;		/* Executable code */
-  grub_uint64_t text_offset;	/* Image load offset */
-  grub_uint64_t res0;		/* reserved */
-  grub_uint64_t res1;		/* reserved */
+  grub_uint64_t text_offset;	/* Image load offset, little endian */
+  grub_uint64_t image_size;	/* Effective Image size, little endian */
+  grub_uint64_t flags;		/* kernel flags, little endian */
+  grub_uint32_t version;	/* Version of this header */
+  grub_uint32_t res1;		/* reserved */
   grub_uint64_t res2;		/* reserved */
-  grub_uint64_t res3;		/* reserved */
-  grub_uint64_t res4;		/* reserved */
-  grub_uint32_t magic;		/* Magic number, little endian, "RSCV" */
+  grub_uint64_t magic;		/* magic (RISC-V specifc, deprecated)*/
+  grub_uint32_t magic2;		/* Magic number 2 (to match the ARM64 'magic' field pos) */
   grub_uint32_t hdr_offset;	/* Offset of PE/COFF header */
+
+  struct grub_coff_image_header coff_image_header;
 };
 
 #define linux_arch_kernel_header linux_riscv_kernel_header
-- 
2.25.1

