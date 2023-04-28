Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 054CA6F1E8E
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 21:06:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346595AbjD1TGZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 15:06:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbjD1TGW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 15:06:22 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F06D82109
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 12:06:20 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1a67bcde3a7so3167525ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 12:06:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1682708780; x=1685300780;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sje7w9+fB+EH+MGgG1/UMH/D2qIYNdlPqE6SA4WS6wE=;
        b=pVZ8HJMgQ3+xH35RV27J8SoRUhfsr98Jkc7MmLi6Bgcfx+F6nTPr35spG+gI0r8vME
         7n5sAbd8B17cb2joGxEXMQOU/5+4UGqAgpsR5DH/ha+9kFGodY7MhwFoZ7LdIPC3YwCk
         MaFcWYCrH21MaVVGd1CQmwInR0iQSeQPuAfEkilVt+X/bRn2BuRvpPsbxY5vFfgxxN6L
         xkAEpscd1A4oH/sLbHch/BYMh9e8vc00OA8w4kRnQ0h8k/t6kufFuf4gsX7SkEF8srUp
         TL4c3hfx0Qw+k/rGR5dKZ+uAB9J12TaSu9C7daravYg/Ddo2LLF1AsdL+BPSRWCNrCM6
         g/kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682708780; x=1685300780;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sje7w9+fB+EH+MGgG1/UMH/D2qIYNdlPqE6SA4WS6wE=;
        b=P72D2vKAMuVBfd8IWLRY47i8KRAjoL8xGxVKnq1nbVxiA8R5esVJtxoFlf0KbRa/JF
         43ah4h6BhtJA/0LJuc1BYWnvHN21w10VAeuijj2eG+KOwLqJNWIuaDZ3Bq1cuo3dTZ8U
         2L1psKMP7wz07+5inaKj/yscbsSxhnQV63lOu7W5Y/bqMf+8HTU8pXfR70zUSYatpXJq
         kny54oVd47iT0Z9OpHDIGOfhA2XGQOK0M7NBnJ11Crv7iJOSgQAP07+Rc9o9zCugGpoY
         KHV69nzlL+fhd0nQDwNEsEB/nfuFiOWvxvVx/wc3FEdk2NKaVgtWIR2oQf+PwHH7DTq8
         q+yg==
X-Gm-Message-State: AC+VfDwSfasKwbFi5Q7xNtccm+01iAINFyHLlZzJSfLLgwd9RpuCDzbi
        ibGEF+T9o14z+QOT5r4D40gP2g==
X-Google-Smtp-Source: ACHHUZ7QWo75WIrdyvyPauWX13WT4/nosdMHz5KIWESIS91E35ZRIbR5lIwAnVKK/fFCxGXw2g3xmQ==
X-Received: by 2002:a17:902:7208:b0:1a5:1b94:e63d with SMTP id ba8-20020a170902720800b001a51b94e63dmr5691012plb.65.1682708780417;
        Fri, 28 Apr 2023 12:06:20 -0700 (PDT)
Received: from evan.ba.rivosinc.com ([66.220.2.162])
        by smtp.gmail.com with ESMTPSA id w15-20020a170902d70f00b001a6c58e95d7sm13580733ply.269.2023.04.28.12.06.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Apr 2023 12:06:20 -0700 (PDT)
From:   Evan Green <evan@rivosinc.com>
To:     Palmer Dabbelt <palmer@rivosinc.com>
Cc:     Evan Green <evan@rivosinc.com>, Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Jones <ajones@ventanamicro.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Dao Lu <daolu@rivosinc.com>,
        Heiko Stuebner <heiko.stuebner@vrull.eu>,
        Jisheng Zhang <jszhang@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Sunil V L <sunilvl@ventanamicro.com>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: [PATCH 1/3] RISC-V: Add Zba extension probing
Date:   Fri, 28 Apr 2023 12:06:06 -0700
Message-Id: <20230428190609.3239486-2-evan@rivosinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230428190609.3239486-1-evan@rivosinc.com>
References: <20230428190609.3239486-1-evan@rivosinc.com>
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

Add the Zba address bit manipulation extension into those the kernel is
aware of and maintains in its riscv_isa bitmap.

Signed-off-by: Evan Green <evan@rivosinc.com>
---

 arch/riscv/include/asm/hwcap.h | 1 +
 arch/riscv/kernel/cpu.c        | 1 +
 arch/riscv/kernel/cpufeature.c | 1 +
 3 files changed, 3 insertions(+)

diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
index 9af793970855..fa36db9281ab 100644
--- a/arch/riscv/include/asm/hwcap.h
+++ b/arch/riscv/include/asm/hwcap.h
@@ -44,6 +44,7 @@
 #define RISCV_ISA_EXT_ZIHINTPAUSE	32
 #define RISCV_ISA_EXT_SVNAPOT		33
 #define RISCV_ISA_EXT_ZICBOZ		34
+#define RISCV_ISA_EXT_ZBA		35
 
 #define RISCV_ISA_EXT_MAX		64
 #define RISCV_ISA_EXT_NAME_LEN_MAX	32
diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
index 3df38052dcbd..2f85b1656557 100644
--- a/arch/riscv/kernel/cpu.c
+++ b/arch/riscv/kernel/cpu.c
@@ -184,6 +184,7 @@ static struct riscv_isa_ext_data isa_ext_arr[] = {
 	__RISCV_ISA_EXT_DATA(zicbom, RISCV_ISA_EXT_ZICBOM),
 	__RISCV_ISA_EXT_DATA(zicboz, RISCV_ISA_EXT_ZICBOZ),
 	__RISCV_ISA_EXT_DATA(zihintpause, RISCV_ISA_EXT_ZIHINTPAUSE),
+	__RISCV_ISA_EXT_DATA(zba, RISCV_ISA_EXT_ZBA),
 	__RISCV_ISA_EXT_DATA(zbb, RISCV_ISA_EXT_ZBB),
 	__RISCV_ISA_EXT_DATA(sscofpmf, RISCV_ISA_EXT_SSCOFPMF),
 	__RISCV_ISA_EXT_DATA(sstc, RISCV_ISA_EXT_SSTC),
diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index 52585e088873..1a80474e308e 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -233,6 +233,7 @@ void __init riscv_fill_hwcap(void)
 				SET_ISA_EXT_MAP("svinval", RISCV_ISA_EXT_SVINVAL);
 				SET_ISA_EXT_MAP("svnapot", RISCV_ISA_EXT_SVNAPOT);
 				SET_ISA_EXT_MAP("svpbmt", RISCV_ISA_EXT_SVPBMT);
+				SET_ISA_EXT_MAP("zba", RISCV_ISA_EXT_ZBA);
 				SET_ISA_EXT_MAP("zbb", RISCV_ISA_EXT_ZBB);
 				SET_ISA_EXT_MAP("zicbom", RISCV_ISA_EXT_ZICBOM);
 				SET_ISA_EXT_MAP("zicboz", RISCV_ISA_EXT_ZICBOZ);
-- 
2.25.1

