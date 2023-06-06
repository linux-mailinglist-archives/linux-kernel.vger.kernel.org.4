Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7484C72423A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 14:35:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237415AbjFFMew (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 08:34:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232900AbjFFMeu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 08:34:50 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B87A710CA
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 05:34:49 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-3094910b150so6175554f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 05:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1686054888; x=1688646888;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yq9OyV3mwmC73gp+6x0dBZhacfbP8G3diQ395jfv3ok=;
        b=xAuP23Wcm3hJ5u8RuGjA2DSAbeDrzRgabDjApm4qSM07TMhu6FLYH9iwZaoDInpmDC
         TdKoIkrHFaKFCu/85WvOwVL05y8FXi+YjCkz7OWcaDH/jvP1QAWUOY7a6/mXTEMaL0SZ
         pmNyYSMzavQxZBW+Gu6os8YyhBxvHab43kmPrSZbmb9GbKLOa1uok9LUHfn+zf+Bq79l
         bppDiuPf6YpINhHfIyYOk1WxQmjamzyVf/qudYH/8tLeVwSy0H26zzF6l76oA8cEXPln
         uXreK18yVq7HxjizfNBE2Lpz4x6JlqtRcgHQXGrCiAo/KlJjEweNm78mMEz2baajP+Sn
         dm7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686054888; x=1688646888;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yq9OyV3mwmC73gp+6x0dBZhacfbP8G3diQ395jfv3ok=;
        b=RLuPeJqMEf4zhFiVPo/PVmdUDVHZsnXIixBRwJlBrXZfBQ+zh5KuVn03uqTDllTiZt
         v8GhwldMH+K+1zw+tBla4yCJ6j/dWv877C1h/mKbpxLlDjgK4shOmtrxmNay6loeI3Vs
         tykk1GZCX7fgQrfU+HmG5LqhRKMlrjGz591SRY0aXCJLmi/Sx+y0b6JkLmXBzuC2fl17
         m1w7+qHbvXIuQcriXm82xrRBubcj7Iu/2DJ5+bNIKPIYxT7Dc4yoJ1lDOF+Q6Cr27xGg
         cUWSgDRciGPYPmKrVqVwPt9oO7LnclmjuQIDEurtjQenq/w+19qG+7g1YisGL60KfvRQ
         RE5A==
X-Gm-Message-State: AC+VfDx0vEXZhdlbcm4tqJFriw1mCVbbIjSKfdh0xRAXvBxUe/CxyanW
        kawWMpXMkOWktw57jdQevoRKbmXax28wPBHceiU=
X-Google-Smtp-Source: ACHHUZ67BAHFCKRSpo8M5O911pekcPA9VZ39wl/9TcZcQKJ9eaNwpGlyHE+DRD1KIAuIueM7CGQNVA==
X-Received: by 2002:a5d:650e:0:b0:307:9da1:c9d8 with SMTP id x14-20020a5d650e000000b003079da1c9d8mr1661958wru.4.1686054888256;
        Tue, 06 Jun 2023 05:34:48 -0700 (PDT)
Received: from localhost.localdomain (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id n24-20020a7bc5d8000000b003f17848673fsm13979481wmk.27.2023.06.06.05.34.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jun 2023 05:34:48 -0700 (PDT)
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Ard Biesheuvel <ardb@kernel.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Alexandre Ghiti <alexghiti@rivosinc.com>,
        Zong Li <zong.li@sifive.com>
Subject: [PATCH v3 2/5] riscv: Dump out kernel offset information on panic
Date:   Tue,  6 Jun 2023 14:32:39 +0200
Message-Id: <20230606123242.20804-3-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230606123242.20804-1-alexghiti@rivosinc.com>
References: <20230606123242.20804-1-alexghiti@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dump out the KASLR virtual kernel offset when panic to help debug kernel.

Signed-off-by: Zong Li <zong.li@sifive.com>
Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 arch/riscv/kernel/setup.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
index 36b026057503..ae5c4c2971ca 100644
--- a/arch/riscv/kernel/setup.c
+++ b/arch/riscv/kernel/setup.c
@@ -20,6 +20,7 @@
 #include <linux/smp.h>
 #include <linux/efi.h>
 #include <linux/crash_dump.h>
+#include <linux/panic_notifier.h>
 
 #include <asm/alternative.h>
 #include <asm/cacheflush.h>
@@ -329,3 +330,27 @@ void free_initmem(void)
 
 	free_initmem_default(POISON_FREE_INITMEM);
 }
+
+static int dump_kernel_offset(struct notifier_block *self,
+			      unsigned long v, void *p)
+{
+	pr_emerg("Kernel Offset: 0x%lx from 0x%lx\n",
+		 kernel_map.virt_offset,
+		 KERNEL_LINK_ADDR);
+
+	return 0;
+}
+
+static struct notifier_block kernel_offset_notifier = {
+	.notifier_call = dump_kernel_offset
+};
+
+static int __init register_kernel_offset_dumper(void)
+{
+	if (IS_ENABLED(CONFIG_RANDOMIZE_BASE))
+		atomic_notifier_chain_register(&panic_notifier_list,
+					       &kernel_offset_notifier);
+
+	return 0;
+}
+device_initcall(register_kernel_offset_dumper);
-- 
2.39.2

