Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8B226AEAD6
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 18:37:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231679AbjCGRhs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 12:37:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231842AbjCGRhT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 12:37:19 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42E3B54CB8
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 09:33:17 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id me6-20020a17090b17c600b0023816b0c7ceso17293513pjb.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Mar 2023 09:33:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1678210396;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fYuh0nFD6NwJIy6fdJnMZv8jO7haLudDJ7hSHLvipCc=;
        b=N2sFEe/DZOOTmqQ2KzWbAd49gMYYEl4qwuPAnxCNlwsSipJ8FFFI+ST1vElZCapdAs
         cPmu+dy2+lyzcCJ2JNdQ26ckeV4hwzFjK6OSbM+hXMZRbio5Fh2cHzjlpwMbt/XkbaS3
         jwONdr4SDUyNegp3VWRHtXioT2NcyzSecpSZzS0JNoYY7XxURKSZkUZt4ODxMeSoEXLF
         pzIldFU6uiBLhu4k9yqIcbX9k5NDnqkaTUbQwnOV6/xHaANYJnA5ShLR8Mmq1mTIlw/Q
         oPQfsf3ksa9STouiRNdQq9w6/V5Fh7zIBKTjhL513ErYBJewsXw2iMYxEQZOKYkqlkZ8
         J2Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678210396;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fYuh0nFD6NwJIy6fdJnMZv8jO7haLudDJ7hSHLvipCc=;
        b=zcrInXs+IhwPD0JQKSLBfpfIRmrm3YD12kgh9g1La5QD5kn13PVLklrju8dTiVMqJK
         5BrG8yoxJcdWUaHGpanT+eQSCGfI0PbvfcgjexLnTG7hv8YJdRISR1JCufw3r58xhmja
         ZB0s16+vNunAAv6a3iwbUBPEm9OLZB4mO8Ym3UeK7W9trAV1mZc5F4See41MXqUKhG4x
         zXcC0kys7bqvhfNYfJvzNNEgKGtYptMijT3VzHzGYtjnibL2ojeHkYF1V5W/9R8Q+B6S
         oDk/GhaEtkgVZ95tnNe1XGcCGeIMvGoznQEmGGS74LxO9ybe72QvFvLwfELO3fmLFvBx
         hEVQ==
X-Gm-Message-State: AO0yUKV4h8SmLZGm7xVwZlSpVDqHVuvXM5QjU2bin1XVLir3hGvl4I/U
        n1inAE0Q1+TKF69nTSsvgNr28A==
X-Google-Smtp-Source: AK7set+kdtB7oESn7B1ADnlc2IIgT0MPiKeaKW9YLHpupL+avmlsX8ulisLCF4jrX2uLwkMDBwFDsA==
X-Received: by 2002:a05:6a20:1607:b0:cd:ed5c:4cd with SMTP id l7-20020a056a20160700b000cded5c04cdmr19219207pzj.6.1678210396664;
        Tue, 07 Mar 2023 09:33:16 -0800 (PST)
Received: from anup-ubuntu-vm.localdomain ([103.97.165.210])
        by smtp.gmail.com with ESMTPSA id 1-20020a630301000000b004fb11a7f2d4sm7996185pgd.57.2023.03.07.09.33.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 09:33:16 -0800 (PST)
From:   Anup Patel <apatel@ventanamicro.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Atish Patra <atishp@atishpatra.org>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        asahi@lists.linux.dev, Anup Patel <apatel@ventanamicro.com>,
        Atish Patra <atishp@rivosinc.com>,
        Palmer Dabbelt <palmer@rivosinc.com>
Subject: [PATCH v17 6/7] RISC-V: Use IPIs for remote icache flush when possible
Date:   Tue,  7 Mar 2023 23:02:30 +0530
Message-Id: <20230307173231.2189275-7-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230307173231.2189275-1-apatel@ventanamicro.com>
References: <20230307173231.2189275-1-apatel@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If we have specialized interrupt controller (such as AIA IMSIC) which
allows supervisor mode to directly inject IPIs without any assistance
from M-mode or HS-mode then using such specialized interrupt controller,
we can do remote icache flushe directly from supervisor mode instead of
using the SBI RFENCE calls.

This patch extends remote icache flush functions to use supervisor mode
IPIs whenever direct supervisor mode IPIs.are supported by interrupt
controller.

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
Reviewed-by: Atish Patra <atishp@rivosinc.com>
Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
---
 arch/riscv/mm/cacheflush.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/mm/cacheflush.c b/arch/riscv/mm/cacheflush.c
index fcd6145fbead..20cec5e7cdbf 100644
--- a/arch/riscv/mm/cacheflush.c
+++ b/arch/riscv/mm/cacheflush.c
@@ -19,7 +19,7 @@ void flush_icache_all(void)
 {
 	local_flush_icache_all();
 
-	if (IS_ENABLED(CONFIG_RISCV_SBI))
+	if (IS_ENABLED(CONFIG_RISCV_SBI) && !riscv_use_ipi_for_rfence())
 		sbi_remote_fence_i(NULL);
 	else
 		on_each_cpu(ipi_remote_fence_i, NULL, 1);
@@ -67,7 +67,8 @@ void flush_icache_mm(struct mm_struct *mm, bool local)
 		 * with flush_icache_deferred().
 		 */
 		smp_mb();
-	} else if (IS_ENABLED(CONFIG_RISCV_SBI)) {
+	} else if (IS_ENABLED(CONFIG_RISCV_SBI) &&
+		   !riscv_use_ipi_for_rfence()) {
 		sbi_remote_fence_i(&others);
 	} else {
 		on_each_cpu_mask(&others, ipi_remote_fence_i, NULL, 1);
-- 
2.34.1

