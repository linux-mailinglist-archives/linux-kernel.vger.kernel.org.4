Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CC1A6FF7F0
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 19:02:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238682AbjEKRB7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 13:01:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238771AbjEKRB4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 13:01:56 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3A66B3
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 10:01:48 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1aaf70676b6so63172035ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 10:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683824508; x=1686416508;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UKRsLL7kNvDroaLyrSRYU4DWIMyOnhELN3sSuXXaYCw=;
        b=Ty701zaQ1O4E399AdK72ImGSMYCz9q+3WiRXQgKA+1W0+3aTflaknqlI3jM94oQXlS
         iA5WQsfGiwkRe0UagRwLLK4DAZII5krsUpBO4oFq6AE+gBwGHdhyLSyQ8dKUa9hh/43i
         nJJebk+wL2VCpf9fE2t8sQUBlcDpiYdQoVdR0BV5l1OI4zcHq2vQfrbgJhiPtD+Y0aXK
         v9TfsA1ZCmllXyroxNH6ilkRU66/sMBwB3BLmVEVaIb15Jgl9soi/dEaBJf5ANePbnpD
         HAihUbzICcvKkz9NDD6eZhAat9VkI4Kp8GbSrmmjI8JjiyPZRj48IAlZRHDE6XCG8r2g
         QbnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683824508; x=1686416508;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UKRsLL7kNvDroaLyrSRYU4DWIMyOnhELN3sSuXXaYCw=;
        b=AXYH0MWE9MtLMYWmz2HROoFF1ihSiXG3Ln3zbrczBOgPmTb5xDsgJb3Llu3XBVKK2g
         L0NAgYDJMFMsxAS27EpC6QZcbDw2kjHxxQI8rbsHbxamHrbckkrlaJENYl/ah0Li0j8V
         JNAanMSe4VlR4FIMeGNGz/laafOsomWEp2/eI6Ltxwb73D+9EqkyEvvdnJDxIDNaLdUu
         KoDk7S4HKm3MDOzT18/sLnhSop2PLrgSOIlYLAWgpBDKlQHzdtRpM9EeD3IJxiQMlQwJ
         wZvLTYZnuZaHx9rI4mu+24JV2hHso3pMTKlree3QgsVaNzmXNIUCRXhLpeqEg39uP2Dy
         5Fdw==
X-Gm-Message-State: AC+VfDz/GsKaJOPVFD3oKKWFB26fJoXoGjzv4LTWV5CWaUZb3WNmbELj
        UBc9Zfd5Whbk1XfezepslQ2gHUV/gGE=
X-Google-Smtp-Source: ACHHUZ4HQ8nm3POZqJ0DmhNQPity9dUWPiwy5DrVMia0WSQEfmrcqGF0baIfP6K8PEO1PMzoifNcOw==
X-Received: by 2002:a17:902:7e84:b0:1a6:f755:a4a0 with SMTP id z4-20020a1709027e8400b001a6f755a4a0mr19604683pla.58.1683824508009;
        Thu, 11 May 2023 10:01:48 -0700 (PDT)
Received: from ubuntu777.domain.name (36-228-94-72.dynamic-ip.hinet.net. [36.228.94.72])
        by smtp.gmail.com with ESMTPSA id r7-20020a170902be0700b001ab0083c6c9sm6156240pls.261.2023.05.11.10.01.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 10:01:47 -0700 (PDT)
From:   Min-Hua Chen <minhuadotchen@gmail.com>
To:     Vineet Gupta <vgupta@kernel.org>
Cc:     Min-Hua Chen <minhuadotchen@gmail.com>,
        linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] ARC: rename 16KSTACKS to DEBUG_STACKS
Date:   Fri, 12 May 2023 01:01:39 +0800
Message-Id: <20230511170139.343434-3-minhuadotchen@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230511170139.343434-1-minhuadotchen@gmail.com>
References: <20230511170139.343434-1-minhuadotchen@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename 16KSTACKS to DEBUG_STACKS.

arch/arc/Kconfig.debug says that the default stack size is 8KB
and it will become 16KB stack if 16KSTACKS is set.

However, the stack size is based on PAGE_SIZE, and it is
configurable by CONFIG_ARC_PAGE_SIZE_16K or CONFIG_ARC_PAGE_SIZE_4K.

See arch/arc/include/uapi/asm/page.h:
/* PAGE_SHIFT determines the page size */
\#if defined(CONFIG_ARC_PAGE_SIZE_16K)
\#define PAGE_SHIFT 14
\#elif defined(CONFIG_ARC_PAGE_SIZE_4K)
\#define PAGE_SHIFT 12
\#else
\#define PAGE_SHIFT 13
\#endif

See arch/arc/include/asm/thread_info.h:
\#ifdef CONFIG_DEBUG_STACKS
\#define THREAD_SIZE_ORDER 1
\#else
\#define THREAD_SIZE_ORDER 0
\#endif

\#define THREAD_SIZE     (PAGE_SIZE << THREAD_SIZE_ORDER)
\#define THREAD_SHIFT	(PAGE_SHIFT + THREAD_SIZE_ORDER)

To make CONFIG_16KSTACKS less confusing, rename it to DEBUG_STACKS
(as it is defined in Kconfig.debug) and modify the Kconfig
description. No functional changes intended.

Signed-off-by: Min-Hua Chen <minhuadotchen@gmail.com>
---
 arch/arc/Kconfig.debug             | 7 ++++---
 arch/arc/include/asm/thread_info.h | 2 +-
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/arc/Kconfig.debug b/arch/arc/Kconfig.debug
index 45add86decd5..9a1e140605c4 100644
--- a/arch/arc/Kconfig.debug
+++ b/arch/arc/Kconfig.debug
@@ -1,10 +1,11 @@
 # SPDX-License-Identifier: GPL-2.0
 
-config 16KSTACKS
-	bool "Use 16Kb for kernel stacks instead of 8Kb"
+config DEBUG_STACKS
+	bool "Use double sized kernel stacks"
 	help
-	  If you say Y here the kernel will use a  16Kb stacksize for the
+	  If you say Y here the kernel will use a double sized stack for the
 	  kernel stack attached to each process/thread. The default is 8K.
+	  (depends on CONFIG_ARC_PAGE_SIZE_16K or CONFIG_ARC_PAGE_SIZE_4K)
 	  This increases the resident kernel footprint and will cause less
 	  threads to run on the system and also increase the pressure
 	  on the VM subsystem for higher order allocations.
diff --git a/arch/arc/include/asm/thread_info.h b/arch/arc/include/asm/thread_info.h
index 9f9dd021501c..a7358d1225a6 100644
--- a/arch/arc/include/asm/thread_info.h
+++ b/arch/arc/include/asm/thread_info.h
@@ -15,7 +15,7 @@
 
 #include <asm/page.h>
 
-#ifdef CONFIG_16KSTACKS
+#ifdef CONFIG_DEBUG_STACKS
 #define THREAD_SIZE_ORDER 1
 #else
 #define THREAD_SIZE_ORDER 0
-- 
2.34.1

