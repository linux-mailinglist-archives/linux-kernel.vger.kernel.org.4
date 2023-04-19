Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B107F6E7831
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 13:11:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232919AbjDSLLI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 07:11:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232879AbjDSLLC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 07:11:02 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26F9913C1D
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 04:10:21 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1a52667955dso35500485ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 04:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1681902618; x=1684494618;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=erF7h0FFrrflFOP1De39iTiQwqZxcNsKEc8OIQm5UJM=;
        b=wz3bVzECh81V9P/8eSWWBlXF/ppb7Eo6YzU8zyukUtrt3VzZ0IEpHBtlfje9DVEk8A
         WgQ43IxHuPg5JxpS+AeX0+JDT9BXNewP9GBxLEbdYftK7bLLCUGMUBxE7QFEhweo+hXs
         ikPvUAgfl+FTTZIHdjmvg1mvLBoejr44HJSj8MVhg6jkkNQb0V/xq7HvECgQM+xvxg07
         /rhj2VeNHkSdv02dw84Cnm0BPWlGc4/tYeOszJHSqvjMvIJoOYvVzIpUznLiSKPl9ow8
         IW5VIWbPwZJgWUbhYU2YozHm+nuM/R3jyKv8aDekyuNVAe3ivBaYboWEbeNyyV528ZgP
         kQ1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681902618; x=1684494618;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=erF7h0FFrrflFOP1De39iTiQwqZxcNsKEc8OIQm5UJM=;
        b=hEz3Xh1sAubvbIvBnJHJ2sehVaTW3JG5ykg9QGSJCAJ8vrrIpuZ1czzIfgahy42k8S
         Dm8MXeSSXploDw37Wc7HvfgV9Di7oPvruyP7bEIU0wlg1jR4ymuA2778hNmmBqX22Rf4
         jIBYeIIDC1P+SHe+qhF5NTWa/jNE6Pv0socXyaxwhTfYVzNKAcjHf8IY1n51KCVYA/cp
         iRZ7QpLG349wS8ncIJ+X6oRLyst6UTCKsC6mNiyCT2XBLer/wwz7/iXiYNlLrtXMaYKH
         xAbSQkCO0FvAjvk8wAV2Xn/N1blK0ANjdD7jBnYpaQ04EejswALDDRFdMAgiCy4Y9OAg
         x1LA==
X-Gm-Message-State: AAQBX9cgnGNRCO0p2LD4AvzrHGuMiwci2oy0cubkxhcUhpqbxjseRMO/
        kkuB4pjA2RhWxrgoYDXbKojQKw==
X-Google-Smtp-Source: AKy350ZRSZ8md3xymsWabEgKJyV9SXGwr0uyWNsabbIVXDib5OEDsFleXNsdFcITKR6mAw9AfBngJw==
X-Received: by 2002:a17:903:41c2:b0:1a8:106c:4a1a with SMTP id u2-20020a17090341c200b001a8106c4a1amr3748412ple.1.1681902618470;
        Wed, 19 Apr 2023 04:10:18 -0700 (PDT)
Received: from x1.hsd1.or.comcast.net ([2601:1c2:1800:f680:eaf2:1d7a:7338:16cb])
        by smtp.gmail.com with ESMTPSA id g12-20020a1709026b4c00b001a24cded097sm11180774plt.236.2023.04.19.04.10.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 04:10:17 -0700 (PDT)
From:   Drew Fustini <dfustini@baylibre.com>
To:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Ved Shanbhogue <ved@rivosinc.com>,
        =?UTF-8?q?Kornel=20Dul=C4=99ba?= <mindal@semihalf.com>,
        Adrien Ricciardi <aricciardi@baylibre.com>,
        Nicolas Pitre <npitre@baylibre.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Babu Moger <babu.moger@amd.com>,
        Peter Newman <peternewman@google.com>, x86@kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        James Morse <james.morse@arm.com>
Cc:     Drew Fustini <dfustini@baylibre.com>
Subject: [RFC PATCH 06/21] RISC-V: QoS: define CBQRI resctrl resources and domains
Date:   Wed, 19 Apr 2023 04:10:56 -0700
Message-Id: <20230419111111.477118-7-dfustini@baylibre.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230419111111.477118-1-dfustini@baylibre.com>
References: <20230419111111.477118-1-dfustini@baylibre.com>
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

Define data structures to encapsulate the resctrl resource
and domain structures.

Co-developed-by: Adrien Ricciardi <aricciardi@baylibre.com>
Signed-off-by: Adrien Ricciardi <aricciardi@baylibre.com>
Signed-off-by: Drew Fustini <dfustini@baylibre.com>
---
 arch/riscv/kernel/qos/internal.h | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/riscv/kernel/qos/internal.h b/arch/riscv/kernel/qos/internal.h
index e07d7f92e206..a3ed98ce5dd6 100644
--- a/arch/riscv/kernel/qos/internal.h
+++ b/arch/riscv/kernel/qos/internal.h
@@ -65,6 +65,11 @@
 #define CBQRI_BC_ALLOC_CTL_OP_READ_LIMIT   2
 #define CBQRI_BC_ALLOC_CTL_STATUS_SUCCESS  1
 
+int qos_resctrl_setup(void);
+void qos_resctrl_exit(void);
+int qos_resctrl_online_cpu(unsigned int cpu);
+int qos_resctrl_offline_cpu(unsigned int cpu);
+
 /* Capacity Controller hardware capabilities */
 /* from qemu/include/hw/riscv/cbqri.h */
 struct riscv_cbqri_capacity_caps {
@@ -127,4 +132,26 @@ struct cbqri_controller {
 	bool mon_capable;
 };
 
+struct cbqri_resctrl_res {
+	struct rdt_resource     resctrl_res;
+	struct cbqri_controller controller;
+	u32 max_rcid;
+	u32 max_mcid;
+};
+
+struct cbqri_resctrl_dom {
+	struct rdt_domain       resctrl_dom;
+	// NCBLKS is 16 bit which is 2^16 = 65536
+	// If each bit is a block, then cc_block_mask could 1024 times 64 byte
+	u64 cbm;
+	u64 rbwb;
+	u64 *ctrl_val;
+	struct cbqri_controller *hw_ctrl;
+};
+
+struct cbqri_config {
+	u64 cbm; /* capacity block mask */
+	u64 rbwb; /* reserved bandwidth blocks */
+};
+
 #endif /* _ASM_RISCV_QOS_INTERNAL_H */
-- 
2.34.1

