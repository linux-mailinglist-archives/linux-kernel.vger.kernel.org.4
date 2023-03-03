Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B3636A9896
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 14:37:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231271AbjCCNhe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 08:37:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231193AbjCCNhT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 08:37:19 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E434062336
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 05:37:10 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id p20so2626790plw.13
        for <linux-kernel@vger.kernel.org>; Fri, 03 Mar 2023 05:37:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1677850630;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pfyzZGOgFR8JpdppLMBGRahWign1okVbjuzaxShQLj4=;
        b=QbfGLwIuluvMNX0Ta2fzSLSVBC7hhY3oQGitdmSvQddpboah2piDakV2DkzR8/PDMa
         p2SBD5il7DVwdWfqiIdTlKhiYt5Id3CvaIfe6KLTf3unakUrjwOsed2Ko6vkCY8QPAsX
         9gEx7ClulHt10YDsNZllZTSx9SRjIcWRIkXbRP0SQRO+x6irEX4LOiQIAtapl+xfDq12
         gD45eRlcsodYO3zsa81If1Pn2ShUj6hfFdqjoATwLkVFwkRrRxUYNtZsoFDS8+QvtCZy
         sh8IqiUHecMUJMAznYTCORyxmml4vRQLuB9Osxg1Pn52y4USC68J9O+zwsJ+OE2CA6EV
         H2nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677850630;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pfyzZGOgFR8JpdppLMBGRahWign1okVbjuzaxShQLj4=;
        b=ZGdI3tdJona2x2WzBqNpG9PO5hYVJcdOdvLhIBVn+ymTQKGtoguBWreX6jROgUyYrk
         dMxyzkQh9tMOOwDBIjxHoE1BkTCzl/sRy2g3GXMeQKm1dxv0kT8OghfT8wE0wCHYhuTb
         PrpYazOc3yeiQV5SWflU1P1P9p08TkN37+qND12EnbJ/RRydcuWdmw3N/fGs1K7poBEX
         Bejn0plfXgy8ldR5eMEOglzCk5DBtylw/iWIsaoeuuMBdlHw6HV+NLGB5pQMSa5CgHzl
         JRK067fAcY4tY0rrIVQ/Qdad3Doa1YyDHe6Jztg065mjBTnTs/s/qJcFVkiyS7Sl5Ri3
         qcYA==
X-Gm-Message-State: AO0yUKWWlqZKq86SI7qSGPyS/fXPIeGMezCmYDWvWcD0O6Lw45q/Nauz
        4BV6DCF2e8xxbxk5TK7qMMur1w==
X-Google-Smtp-Source: AK7set/7mpqJYQyP2c7P7o6FdhEOlGmQ7gcqb5kaRjsFekLE9espZ/Nhpcj7/VMu31HKQhIxtlIxIw==
X-Received: by 2002:a17:902:e80f:b0:19e:747e:813e with SMTP id u15-20020a170902e80f00b0019e747e813emr2324704plg.23.1677850630195;
        Fri, 03 Mar 2023 05:37:10 -0800 (PST)
Received: from localhost.localdomain ([49.206.14.226])
        by smtp.gmail.com with ESMTPSA id m9-20020a170902768900b0019ac5d3ee9dsm1533125pll.157.2023.03.03.05.37.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Mar 2023 05:37:09 -0800 (PST)
From:   Sunil V L <sunilvl@ventanamicro.com>
To:     linux-riscv@lists.infradead.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Anup Patel <apatel@ventanamicro.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Atish Patra <atishp@rivosinc.com>,
        'Conor Dooley ' <conor.dooley@microchip.com>,
        Sunil V L <sunilvl@ventanamicro.com>,
        Robert Moore <robert.moore@intel.com>,
        acpica-devel@lists.linuxfoundation.org,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH V3 03/20] ACPICA: Add structure definitions for RISC-V RHCT
Date:   Fri,  3 Mar 2023 19:06:30 +0530
Message-Id: <20230303133647.845095-4-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230303133647.845095-1-sunilvl@ventanamicro.com>
References: <20230303133647.845095-1-sunilvl@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RISC-V Hart Capabilities Table (RHCT) is a new static table.
The ECR to add RHCT is approved by the UEFI forum and will be
available in the next version of the ACPI spec.

This patch is not yet merged in ACPICA but a PR is raised.

ACPICA PR: https://github.com/acpica/acpica/pull/804
Reference: Mantis: 2349

Cc: Robert Moore <robert.moore@intel.com>
Cc: acpica-devel@lists.linuxfoundation.org
Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 include/acpi/actbl2.h | 47 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
index abb700d246df..0715e937a453 100644
--- a/include/acpi/actbl2.h
+++ b/include/acpi/actbl2.h
@@ -47,6 +47,7 @@
 #define ACPI_SIG_PRMT           "PRMT"	/* Platform Runtime Mechanism Table */
 #define ACPI_SIG_RASF           "RASF"	/* RAS Feature table */
 #define ACPI_SIG_RGRT           "RGRT"	/* Regulatory Graphics Resource Table */
+#define ACPI_SIG_RHCT           "RHCT"  /* RISC-V Hart Capabilities Table */
 #define ACPI_SIG_SBST           "SBST"	/* Smart Battery Specification Table */
 #define ACPI_SIG_SDEI           "SDEI"	/* Software Delegated Exception Interface Table */
 #define ACPI_SIG_SDEV           "SDEV"	/* Secure Devices table */
@@ -2606,6 +2607,52 @@ enum acpi_rgrt_image_type {
 
 /*******************************************************************************
  *
+ * RHCT - RISC-V Hart Capabilities Table
+ *        Version 1
+ *
+ ******************************************************************************/
+
+struct acpi_table_rhct {
+	struct acpi_table_header        header;             /* Common ACPI table header */
+	u32                             reserved;
+	u64                             time_base_freq;
+	u32                             node_count;
+	u32                             node_offset;
+};
+
+/*
+ * RHCT subtables
+ */
+struct acpi_rhct_node_header {
+	u16                             type;
+	u16                             length;
+	u16                             revision;
+};
+
+/* Values for RHCT subtable Type above */
+
+enum acpi_rhct_node_type {
+	ACPI_RHCT_NODE_TYPE_ISA_STRING = 0x0000,
+	ACPI_RHCT_NODE_TYPE_HART_INFO  = 0xFFFF,
+};
+
+/*
+ * RHCT node specific subtables
+ */
+
+/* ISA string node structure */
+struct acpi_rhct_isa_string {
+	u16                             isa_length;
+	char                            isa[];
+};
+
+/* Hart Info node structure */
+struct acpi_rhct_hart_info {
+	u16                             num_offsets;
+	u32                             uid;                /* ACPI processor UID */
+};
+
+/*******************************************************************************
  * SBST - Smart Battery Specification Table
  *        Version 1
  *
-- 
2.34.1

