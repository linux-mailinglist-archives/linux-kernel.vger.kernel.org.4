Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 531836E7833
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 13:11:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232880AbjDSLLC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 07:11:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232849AbjDSLKv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 07:10:51 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C645513F9A
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 04:10:15 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-63b73203e0aso15252473b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 04:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1681902615; x=1684494615;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g1OkcmhU53RbhkMQs1OOfT4IMIpFMn/hvoMN7xVvdpQ=;
        b=tOvJ2jomn2lCN7CzbmQxXUPM+RMt5nQnovetT4UyRyBVZdKUWLTslytcs5Fijiw4IH
         nco6zem+f6UyYuypUHPg1WuTBPSd2/yCDcny+7RkWgqWQf6nzPkIwbw/3Dt98SE9CPvL
         bDcp7NZayY/ZA69jSqsfc5HVI4qcdaRTuNSY2IFurnSljwY1lMjPIXSf+3T0aiTV0o5r
         4n5tZ0OdGGQ6duEP5C7OqQB1lM5CkTP6CiCPoKhWB6nO4I8xW1GzxZZjbtm3NM74MCNo
         Zk0F+k0cZbSeF6eMPaV4vRVlNYRwLkB1D4SHSNlgs8uFm8QORgJqfpI2wKA4eOUjwUOU
         WNFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681902615; x=1684494615;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g1OkcmhU53RbhkMQs1OOfT4IMIpFMn/hvoMN7xVvdpQ=;
        b=Pp68+rhkGcHJRanQjZ+AEFxnW2pE+c/EmWL+djYIDZSy4Tbt7dFVeJoK75SNYc7O2F
         jdBtxZUZyDRwRcz34ioFSymcFR9rSGL++zCk8OJdstNdoxYWQugxznujr7RsrolgkvvM
         3q0GWUqZEDqeM9nh9U1iK7ptZFO8djPVuVs4XCtUY3epsNTvNFYjbFChHNeRcpmqbKcA
         E4YUzfwZNl0oAz/chQhIfmDBpuI2UpaPtKqWGAkAcP9m/b34EY/E6hFmpRfhZWD7Dx1R
         CkZ/bzLhgHWVN2dX0dIDQzh6uUuQJBelOSP0s4oCIf3d9fE0DRujUPN1a+m6XECloDd4
         mkSw==
X-Gm-Message-State: AAQBX9cNIUpDaiYwxJl5fqgJ8AsmKkXsKigoFfMTwo11vxxnYH/OYvGE
        FXqWCOPX8dF/iS26RozN5rpKtQ==
X-Google-Smtp-Source: AKy350aNbAzQPxeM67oYUfXFpZ0iKay8dELpBUn0YBN78d+E7FjUtYnNE1XfqtnYpe6qJVX9PR/weg==
X-Received: by 2002:a17:903:26c9:b0:1a2:7462:d674 with SMTP id jg9-20020a17090326c900b001a27462d674mr1959521plb.24.1681902615276;
        Wed, 19 Apr 2023 04:10:15 -0700 (PDT)
Received: from x1.hsd1.or.comcast.net ([2601:1c2:1800:f680:eaf2:1d7a:7338:16cb])
        by smtp.gmail.com with ESMTPSA id g12-20020a1709026b4c00b001a24cded097sm11180774plt.236.2023.04.19.04.10.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 04:10:14 -0700 (PDT)
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
Subject: [RFC PATCH 04/21] RISC-V: QoS: define CBQRI capacity and bandwidth capabilities
Date:   Wed, 19 Apr 2023 04:10:54 -0700
Message-Id: <20230419111111.477118-5-dfustini@baylibre.com>
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

Define data structures to store the capacity and bandwidth capabilities
that are discovered for a CBQRI-capable controller.

Co-developed-by: Adrien Ricciardi <aricciardi@baylibre.com>
Signed-off-by: Adrien Ricciardi <aricciardi@baylibre.com>
Signed-off-by: Drew Fustini <dfustini@baylibre.com>
---
 arch/riscv/kernel/qos/internal.h | 130 +++++++++++++++++++++++++++++++
 1 file changed, 130 insertions(+)
 create mode 100644 arch/riscv/kernel/qos/internal.h

diff --git a/arch/riscv/kernel/qos/internal.h b/arch/riscv/kernel/qos/internal.h
new file mode 100644
index 000000000000..e07d7f92e206
--- /dev/null
+++ b/arch/riscv/kernel/qos/internal.h
@@ -0,0 +1,130 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef _ASM_RISCV_QOS_INTERNAL_H
+#define _ASM_RISCV_QOS_INTERNAL_H
+
+#include <linux/resctrl.h>
+
+#define CBQRI_CC_CAPABILITIES_OFF 0
+#define CBQRI_CC_MON_CTL_OFF      8
+#define CBQRI_CC_MON_CTL_VAL_OFF 16
+#define CBQRI_CC_ALLOC_CTL_OFF   24
+#define CBQRI_CC_BLOCK_MASK_OFF  32
+
+#define CBQRI_BC_CAPABILITIES_OFF 0
+#define CBQRI_BC_MON_CTL_OFF      8
+#define CBQRI_BC_MON_CTR_VAL_OFF 16
+#define CBQRI_BC_ALLOC_CTL_OFF   24
+#define CBQRI_BC_BW_ALLOC_OFF    32
+
+#define CBQRI_CC_CAPABILITIES_VER_MINOR_MASK  GENMASK(3, 0)
+#define CBQRI_CC_CAPABILITIES_VER_MAJOR_MASK  GENMASK(7, 4)
+
+#define CBQRI_CC_CAPABILITIES_FRCID_MASK   0x1
+#define CBQRI_CC_CAPABILITIES_FRCID_SHIFT  24
+
+#define CBQRI_CC_CAPABILITIES_NCBLKS_SHIFT 8
+#define CBQRI_CC_CAPABILITIES_NCBLKS_MASK  0xFFFF
+
+#define CBQRI_BC_CAPABILITIES_VER_MINOR_MASK  GENMASK(3, 0)
+#define CBQRI_BC_CAPABILITIES_VER_MAJOR_MASK  GENMASK(7, 4)
+
+#define CBQRI_BC_CAPABILITIES_NBWBLKS_SHIFT 8
+#define CBQRI_BC_CAPABILITIES_NBWBLKS_MASK  0xFFFF
+#define CBQRI_BC_CAPABILITIES_MRBWB_SHIFT   32
+#define CBQRI_BC_CAPABILITIES_MRBWB_MASK    0xFFFF
+
+#define CBQRI_CONTROL_REGISTERS_BUSY_SHIFT   39
+#define CBQRI_CONTROL_REGISTERS_BUSY_MASK    0x01
+#define CBQRI_CONTROL_REGISTERS_STATUS_SHIFT 32
+#define CBQRI_CONTROL_REGISTERS_STATUS_MASK  0x7F
+#define CBQRI_CONTROL_REGISTERS_OP_SHIFT     0
+#define CBQRI_CONTROL_REGISTERS_OP_MASK      0x1F
+#define CBQRI_CONTROL_REGISTERS_AT_SHIFT     5
+#define CBQRI_CONTROL_REGISTERS_AT_MASK      0x07
+#define CBQRI_CONTROL_REGISTERS_AT_DATA      0
+#define CBQRI_CONTROL_REGISTERS_AT_CODE      1
+#define CBQRI_CONTROL_REGISTERS_RCID_SHIFT   8
+#define CBQRI_CONTROL_REGISTERS_RCID_MASK    0xFFF
+#define CBQRI_CONTROL_REGISTERS_RBWB_SHIFT   0
+#define CBQRI_CONTROL_REGISTERS_RBWB_MASK    0xFF
+
+#define CBQRI_CC_MON_CTL_OP_CONFIG_EVENT 1
+#define CBQRI_CC_MON_CTL_OP_READ_COUNTER 2
+#define CBQRI_CC_MON_CTL_STATUS_SUCCESS  1
+
+#define CBQRI_CC_ALLOC_CTL_OP_CONFIG_LIMIT 1
+#define CBQRI_CC_ALLOC_CTL_OP_READ_LIMIT   2
+#define CBQRI_CC_ALLOC_CTL_OP_FLUSH_RCID   3
+#define CBQRI_CC_ALLOC_CTL_STATUS_SUCCESS  1
+
+#define CBQRI_BC_MON_CTL_OP_CONFIG_EVENT 1
+#define CBQRI_BC_MON_CTL_OP_READ_COUNTER 2
+#define CBQRI_BC_MON_CTL_STATUS_SUCCESS  1
+
+#define CBQRI_BC_ALLOC_CTL_OP_CONFIG_LIMIT 1
+#define CBQRI_BC_ALLOC_CTL_OP_READ_LIMIT   2
+#define CBQRI_BC_ALLOC_CTL_STATUS_SUCCESS  1
+
+/* Capacity Controller hardware capabilities */
+/* from qemu/include/hw/riscv/cbqri.h */
+struct riscv_cbqri_capacity_caps {
+	u16 ncblks;
+	u16 cache_level;
+	u32 blk_size;
+
+	bool supports_alloc_at_data;
+	bool supports_alloc_at_code;
+
+	bool supports_alloc_op_config_limit;
+	bool supports_alloc_op_read_limit;
+	bool supports_alloc_op_flush_rcid;
+
+	bool supports_mon_at_data;
+	bool supports_mon_at_code;
+
+	bool supports_mon_op_config_event;
+	bool supports_mon_op_read_counter;
+
+	bool supports_mon_evt_id_none;
+	bool supports_mon_evt_id_occupancy;
+};
+
+/* Bandwidth Controller hardware capabilities */
+/* from qemu/include/hw/riscv/cbqri.h */
+struct riscv_cbqri_bandwidth_caps {
+	u16 nbwblks; /* number of bandwidth block */
+	u16 mrbwb;   /* max reserved bw blocks */
+
+	bool supports_alloc_at_data;
+	bool supports_alloc_at_code;
+
+	bool supports_alloc_op_config_limit;
+	bool supports_alloc_op_read_limit;
+
+	bool supports_mon_at_data;
+	bool supports_mon_at_code;
+
+	bool supports_mon_op_config_event;
+	bool supports_mon_op_read_counter;
+
+	bool supports_mon_evt_id_none;
+	bool supports_mon_evt_id_rdwr_count;
+	bool supports_mon_evt_id_rdonly_count;
+	bool supports_mon_evt_id_wronly_count;
+};
+
+struct cbqri_controller {
+	struct cbqri_controller_info *ctrl_info;
+	void __iomem *base;
+
+	int ver_major;
+	int ver_minor;
+
+	struct riscv_cbqri_bandwidth_caps bc;
+	struct riscv_cbqri_capacity_caps cc;
+
+	bool alloc_capable;
+	bool mon_capable;
+};
+
+#endif /* _ASM_RISCV_QOS_INTERNAL_H */
-- 
2.34.1

