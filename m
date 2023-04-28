Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92AA46F174A
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 14:09:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345964AbjD1MJi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 08:09:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345520AbjD1MJh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 08:09:37 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4FC6FA
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 05:09:35 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3f173af665fso65081445e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 05:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1682683774; x=1685275774;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=8f00XptuJ3vBIkeMg3m5pPyF6yCS6hEBZQCfqkTlaCQ=;
        b=vtRYYyBzLwgzPKD+/TAPmiPYgrpCQvFhoiH7TWKY2TH4KN6cSMUsAeD74S4EEKiBwY
         M8OU9wAlBCjnPXl54GsBRAPBEaobk9PixBizafP5UJQ+lDRfc3sPjTnQcQ2ey8MWit3u
         hQSSTKKYS91gZzC+bJMvnHxIyMiAwRYCzWLWrY/y173aTycm7S+ng3LB6uP705SYbx1E
         yyoe3U1fRpuwy0ykEN3g7lTtMbVG/hlbI2s7g7zucTHQAvkt5wIKP9KxmNorx1N1FV25
         y/RPDeUx/aCa8MU3/+IOGOGenhDHjFFJjDjIJGT0gMVqEnnzjiCYxr7ovwbAiJ+I1oUm
         HwEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682683774; x=1685275774;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8f00XptuJ3vBIkeMg3m5pPyF6yCS6hEBZQCfqkTlaCQ=;
        b=gLsOiKHlDSt2W/3nSzXwcL30+Ma4S6/M1Ggeq3ajQ333GS7ijEwLDynUS+CRE445CR
         or7SHfGqCWkJdYWZ/SBTwWN+9lZCZapuRt1wdHF88bZx12lAZUlr7Rb7psTRb+ipRyT1
         V3FI8Z9TPZaVYe82VfS+PYZTPxKR6K7vdXH4diN7ChppDrrO2lePTeFOxCHh20/zf0RF
         nc3CTsQK/CH8dWG67/cIPnYJegbiZcwYtExDtx9RC09rYyBkigpxkB1KavNwgNsEoEJd
         Ybfn5obyFaUibHgETI5v8+/S6jBgL/gMHo0qzh1vCweMy2obswxi0nYa2ReOuE9QP3Gj
         z0KA==
X-Gm-Message-State: AC+VfDwhSsOn5/RkKtnz64Nt/xQNsCOZy9EFVCzQbvb9hZ4mOEhGTxbO
        dtO2NY1FZ2LuGVJtBX2Abz+0sA==
X-Google-Smtp-Source: ACHHUZ5jIOJ0Vu7n+dpHeXbkHOwpf6iHzOnRRgEmQLZqEfJG857eUY1WUGCFqG84VuUcyF7T68x7Bw==
X-Received: by 2002:a05:600c:2104:b0:3f1:6f44:ff3a with SMTP id u4-20020a05600c210400b003f16f44ff3amr3958884wml.13.1682683774216;
        Fri, 28 Apr 2023 05:09:34 -0700 (PDT)
Received: from alex-rivos.home (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id m18-20020a7bcb92000000b003f24f245f57sm15405684wmi.42.2023.04.28.05.09.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Apr 2023 05:09:33 -0700 (PDT)
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH -fixes] riscv: Move .rela.dyn to the init sections
Date:   Fri, 28 Apr 2023 14:09:32 +0200
Message-Id: <20230428120932.22735-1-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.37.2
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

The recent introduction of relocatable kernels prepared the move of
.rela.dyn to the init section, but actually forgot to do so, so do it
here.

Before this patch: "Freeing unused kernel image (initmem) memory: 2592K"
After this patch:  "Freeing unused kernel image (initmem) memory: 6288K"

The difference corresponds to the size of the .rela.dyn section:
"[42] .rela.dyn         RELA             ffffffff8197e798  0127f798
       000000000039c660  0000000000000018   A      47     0     8"

Fixes: 559d1e45a16d ("riscv: Use --emit-relocs in order to move .rela.dyn in init")
Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 arch/riscv/kernel/vmlinux.lds.S | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/riscv/kernel/vmlinux.lds.S b/arch/riscv/kernel/vmlinux.lds.S
index 305877d85e96..f03b5697f8e0 100644
--- a/arch/riscv/kernel/vmlinux.lds.S
+++ b/arch/riscv/kernel/vmlinux.lds.S
@@ -104,6 +104,12 @@ SECTIONS
 		*(.rel.dyn*)
 	}
 
+	.rela.dyn : ALIGN(8) {
+		__rela_dyn_start = .;
+		*(.rela .rela*)
+		__rela_dyn_end = .;
+	}
+
 	__init_data_end = .;
 
 	. = ALIGN(8);
@@ -130,12 +136,6 @@ SECTIONS
 		*(.sdata*)
 	}
 
-	.rela.dyn : ALIGN(8) {
-		__rela_dyn_start = .;
-		*(.rela .rela*)
-		__rela_dyn_end = .;
-	}
-
 	.got : { *(.got*) }
 
 #ifdef CONFIG_RELOCATABLE
-- 
2.37.2

