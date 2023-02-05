Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16B6168ADD3
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Feb 2023 02:15:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232084AbjBEBPk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Feb 2023 20:15:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230403AbjBEBP0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Feb 2023 20:15:26 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B26225962
        for <linux-kernel@vger.kernel.org>; Sat,  4 Feb 2023 17:15:26 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id g13so4085525ple.10
        for <linux-kernel@vger.kernel.org>; Sat, 04 Feb 2023 17:15:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F7aws7WJ+JgPsYmq926ziPATo3zeqcvvVIk1K0OdXFk=;
        b=ods8cMcvC3DpjZZR8bGgLD7ZNWo8QbUY9a4HZQfzW7vURdsGqIrTNu7ICMWqoAtScj
         Yx30htgBuZcmHrWBKyTUJp0WsB4vLdkAb6GrAxHGlcyU3b004ZtHvRH5dXj8dgTgLITY
         DLDWzlUdgpPN9W6IoylBlqJsk7avLcNO3jB4yt8SzPkMJB7ZNv2qwn14JaTNk60fzLFs
         y4G6lwUX9ah6AZBCMe5cBjLS0JBCJD9GwtqeeYfg2B69ndI1gHBLymtSRsmAjsKGe3Gm
         38RCAIWcLCKiLTFNe77yEti+lpSyAYtWq/6GZT72WWk4hr/Jo0frhn1+/Ch7mqKSPfhI
         N67g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F7aws7WJ+JgPsYmq926ziPATo3zeqcvvVIk1K0OdXFk=;
        b=U0BwcWUzE3SXefef3t3qjFa2R7+uPM1FVjt+7V+QDNkgBkl1/plfzdnAqKjOfYyH5H
         bMIv8QLFHFcCvpgqzVWxVcHr5ZkU95fB+gQoP2oUeoGCRm9ALjLBezYi/fU4qUiibDbh
         JuaDyZpCcaj/LL8tIu5c3HW1e/A2Z2xNmbLZZwgHvthDR5shwAEva/hOsTaMgU0vOIBU
         /HFyzWGchsi6qX+90PE4eI/jeH++aSeL9PegByBaRJT4cHMzdoLVzD5WnL6zqqDgV4IC
         1kH7AcCilaT85+iVZA78WCE9P6xtJFgk+brnN7bxE0uORaWq/5fTMn38XSop3MwixlHH
         R9xg==
X-Gm-Message-State: AO0yUKWA8/BEJFpyPTGPLEOzkGrxE/qvtgGgtpmk+8WK7KVNT0OG95sU
        TDD72L3jLklGD0Wt3cGC6g36TEOGaZG9S048
X-Google-Smtp-Source: AK7set8GVQ8++sqLaN2nZNAa4EHITi4jHN0uS1FuLRSz+mHDHpLf9ZyU0a48Dr//OxxMMBMg7Zre6A==
X-Received: by 2002:a17:90b:390b:b0:230:8ddd:3878 with SMTP id ob11-20020a17090b390b00b002308ddd3878mr3799853pjb.42.1675559725511;
        Sat, 04 Feb 2023 17:15:25 -0800 (PST)
Received: from atishp.ba.rivosinc.com ([66.220.2.162])
        by smtp.gmail.com with ESMTPSA id c7-20020a17090a020700b0023080c4c3bcsm2721917pjc.31.2023.02.04.17.15.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Feb 2023 17:15:25 -0800 (PST)
From:   Atish Patra <atishp@rivosinc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atishp@rivosinc.com>,
        Anup Patel <anup@brainfault.org>,
        Andrew Jones <ajones@ventanamicro.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atishp@atishpatra.org>,
        Guo Ren <guoren@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
        kvm-riscv@lists.infradead.org, kvm@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Will Deacon <will@kernel.org>
Subject: [PATCH v5 03/14] RISC-V: Improve SBI PMU extension related definitions
Date:   Sat,  4 Feb 2023 17:15:04 -0800
Message-Id: <20230205011515.1284674-4-atishp@rivosinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230205011515.1284674-1-atishp@rivosinc.com>
References: <20230205011515.1284674-1-atishp@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes/improve few minor things in SBI PMU extension
definition.

1. Align all the firmware event names.
2. Add macros for bit positions in cache event ID & ops.

The changes were small enough to combine them together instead
of creating 1 liner patches.

Reviewed-by: Anup Patel <anup@brainfault.org>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 arch/riscv/include/asm/sbi.h | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
index 4ca7fba..945b7be 100644
--- a/arch/riscv/include/asm/sbi.h
+++ b/arch/riscv/include/asm/sbi.h
@@ -169,9 +169,9 @@ enum sbi_pmu_fw_generic_events_t {
 	SBI_PMU_FW_ILLEGAL_INSN		= 4,
 	SBI_PMU_FW_SET_TIMER		= 5,
 	SBI_PMU_FW_IPI_SENT		= 6,
-	SBI_PMU_FW_IPI_RECVD		= 7,
+	SBI_PMU_FW_IPI_RCVD		= 7,
 	SBI_PMU_FW_FENCE_I_SENT		= 8,
-	SBI_PMU_FW_FENCE_I_RECVD	= 9,
+	SBI_PMU_FW_FENCE_I_RCVD		= 9,
 	SBI_PMU_FW_SFENCE_VMA_SENT	= 10,
 	SBI_PMU_FW_SFENCE_VMA_RCVD	= 11,
 	SBI_PMU_FW_SFENCE_VMA_ASID_SENT	= 12,
@@ -215,6 +215,9 @@ enum sbi_pmu_ctr_type {
 #define SBI_PMU_EVENT_CACHE_OP_ID_CODE_MASK 0x06
 #define SBI_PMU_EVENT_CACHE_RESULT_ID_CODE_MASK 0x01
 
+#define SBI_PMU_EVENT_CACHE_ID_SHIFT 3
+#define SBI_PMU_EVENT_CACHE_OP_SHIFT 1
+
 #define SBI_PMU_EVENT_IDX_INVALID 0xFFFFFFFF
 
 /* Flags defined for config matching function */
-- 
2.25.1

