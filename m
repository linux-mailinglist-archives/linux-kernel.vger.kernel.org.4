Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ED4A6FCDC1
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 20:25:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234747AbjEISZS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 14:25:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234606AbjEISZP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 14:25:15 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A67081738
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 11:25:14 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-52c30fbccd4so5665406a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 May 2023 11:25:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1683656714; x=1686248714;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nQsI7h047J9FHkjLVaXj4pH2wY6fQ46ZjPRlcK756GA=;
        b=IeSl81BoOzHrMaM71UWd43qvo4LpjjbcRojb0PFFREcu+EAplF8fFu6fEGBkIcnROT
         Wf7umgahqyJegB8VHPl61sHJ30b2c+X6EhBJFgE8dFYp2v+yct0tS/wo4KuNedFCVUhK
         G331wHGJkHJe1FWse6mD3SRvz5ewJBw0tKLRlHqrFtahcLcLXqYkuc9s5UxAJlCYro1x
         C+/cYASlnMnKQYcQkyDbfnVTX0ngOPCQtFuQ1zNiOocaVSoet0dTsBswBypa0OxCPyxt
         Z0w2CCrbZkGrLaik8Y+yYGz08Mpws/io/c2gYZA3dZ9rb6rXdBWa3yu99JRt7AvU3Een
         X1qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683656714; x=1686248714;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nQsI7h047J9FHkjLVaXj4pH2wY6fQ46ZjPRlcK756GA=;
        b=Vbk0a+475k7qddx1IE2S/1NPoyCdKNHi/6alueRzIxiqWT/CwzCWP4nlMS9WSmKS1n
         ofJhmVJ+j9c+1ZtyhcEoiDbGxtM/zInJ7a7vLApPy92CP9f0oYQbP1DJSHXKvSm40ZJd
         jdeaYv3eNcjB2wpdzMUyYwguWo3tzOVe3wVDVwXSqJkqvGmw/jsMjYjmW0ySxmCXek0P
         +Aax+jQuyYySnaH1qzgZlXcp/Jgb8Nb0k8KIVwoRowv92BTBDBWDXVY+U3Ks3P0iYKr2
         vhfpCH7wmihPCyJC2VB9mlMZRwWCuGBChIg4FQHvO0w2wV6qfqwokVNl9Tvh3DAtFFFo
         9uVg==
X-Gm-Message-State: AC+VfDympw3ax1BNkTLAPNNQkjiPHWBcl7GybL2uinvBOTnqmhEOdTbJ
        kYuvO8ZzhibPXxtX6YwAwdlXmQ==
X-Google-Smtp-Source: ACHHUZ4bPA7+HJDF8p8EUdGuXAjSzxnfS5SkECRtZUqMSM2tkTOQALtX2I6a7jlXMuannRQs5jwBfQ==
X-Received: by 2002:a05:6a21:7897:b0:100:4b1c:4528 with SMTP id bf23-20020a056a21789700b001004b1c4528mr11560461pzc.60.1683656714132;
        Tue, 09 May 2023 11:25:14 -0700 (PDT)
Received: from evan.ba.rivosinc.com ([66.220.2.162])
        by smtp.gmail.com with ESMTPSA id q12-20020a63cc4c000000b0051eff0a70d7sm1633559pgi.94.2023.05.09.11.25.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 May 2023 11:25:13 -0700 (PDT)
From:   Evan Green <evan@rivosinc.com>
To:     Palmer Dabbelt <palmer@rivosinc.com>
Cc:     Evan Green <evan@rivosinc.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <apatel@ventanamicro.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Heiko Stuebner <heiko.stuebner@vrull.eu>,
        Jisheng Zhang <jszhang@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Sunil V L <sunilvl@ventanamicro.com>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: [PATCH v2 1/3] RISC-V: Add Zba, Zbs extension probing
Date:   Tue,  9 May 2023 11:25:01 -0700
Message-Id: <20230509182504.2997252-2-evan@rivosinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230509182504.2997252-1-evan@rivosinc.com>
References: <20230509182504.2997252-1-evan@rivosinc.com>
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

Add the Zba address bit manipulation extension and Zbs single bit
instructions extension into those the kernel is aware of and maintains
in its riscv_isa bitmap.

Signed-off-by: Evan Green <evan@rivosinc.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Reviewed-by: Palmer Dabbelt <palmer@rivosinc.com>

---

Changes in v2:
 - Add Zbs as well

 arch/riscv/include/asm/hwcap.h | 2 ++
 arch/riscv/kernel/cpu.c        | 2 ++
 arch/riscv/kernel/cpufeature.c | 2 ++
 3 files changed, 6 insertions(+)

diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
index e0c40a4c63d5..6b2e8ff4638c 100644
--- a/arch/riscv/include/asm/hwcap.h
+++ b/arch/riscv/include/asm/hwcap.h
@@ -46,6 +46,8 @@
 #define RISCV_ISA_EXT_ZICBOZ		34
 #define RISCV_ISA_EXT_SMAIA		35
 #define RISCV_ISA_EXT_SSAIA		36
+#define RISCV_ISA_EXT_ZBA		37
+#define RISCV_ISA_EXT_ZBS		38
 
 #define RISCV_ISA_EXT_MAX		64
 #define RISCV_ISA_EXT_NAME_LEN_MAX	32
diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
index c96aa56cf1c7..bd294364390d 100644
--- a/arch/riscv/kernel/cpu.c
+++ b/arch/riscv/kernel/cpu.c
@@ -184,7 +184,9 @@ static struct riscv_isa_ext_data isa_ext_arr[] = {
 	__RISCV_ISA_EXT_DATA(zicbom, RISCV_ISA_EXT_ZICBOM),
 	__RISCV_ISA_EXT_DATA(zicboz, RISCV_ISA_EXT_ZICBOZ),
 	__RISCV_ISA_EXT_DATA(zihintpause, RISCV_ISA_EXT_ZIHINTPAUSE),
+	__RISCV_ISA_EXT_DATA(zba, RISCV_ISA_EXT_ZBA),
 	__RISCV_ISA_EXT_DATA(zbb, RISCV_ISA_EXT_ZBB),
+	__RISCV_ISA_EXT_DATA(zbs, RISCV_ISA_EXT_ZBS),
 	__RISCV_ISA_EXT_DATA(smaia, RISCV_ISA_EXT_SMAIA),
 	__RISCV_ISA_EXT_DATA(ssaia, RISCV_ISA_EXT_SSAIA),
 	__RISCV_ISA_EXT_DATA(sscofpmf, RISCV_ISA_EXT_SSCOFPMF),
diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index b1d6b7e4b829..a1954c83638f 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -236,7 +236,9 @@ void __init riscv_fill_hwcap(void)
 				SET_ISA_EXT_MAP("svinval", RISCV_ISA_EXT_SVINVAL);
 				SET_ISA_EXT_MAP("svnapot", RISCV_ISA_EXT_SVNAPOT);
 				SET_ISA_EXT_MAP("svpbmt", RISCV_ISA_EXT_SVPBMT);
+				SET_ISA_EXT_MAP("zba", RISCV_ISA_EXT_ZBA);
 				SET_ISA_EXT_MAP("zbb", RISCV_ISA_EXT_ZBB);
+				SET_ISA_EXT_MAP("zbs", RISCV_ISA_EXT_ZBS);
 				SET_ISA_EXT_MAP("zicbom", RISCV_ISA_EXT_ZICBOM);
 				SET_ISA_EXT_MAP("zicboz", RISCV_ISA_EXT_ZICBOZ);
 				SET_ISA_EXT_MAP("zihintpause", RISCV_ISA_EXT_ZIHINTPAUSE);
-- 
2.25.1

