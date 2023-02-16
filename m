Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC5AD699C10
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 19:21:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbjBPSV0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 13:21:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230157AbjBPSVW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 13:21:22 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45C48552B4
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 10:21:07 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id pg6-20020a17090b1e0600b002349579949aso2560449pjb.5
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 10:21:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pfyzZGOgFR8JpdppLMBGRahWign1okVbjuzaxShQLj4=;
        b=UUpqTB6AUMM+Rdx7uT+Js1SJiUxUEqdBUlVRwfmgNPvgDY5tG85Wxm3Gwp/IEKUHuZ
         ENhr7womW2HoZ2BMwxNaM80t9Mvqr8Up6T/0VnSGLxjBCRKnZWmt4kPZ7ak3QDJZv38W
         qJ3Eq+45h+1FPXzR2jouMZbuuDxkDkqWPQU7lF74NAfc9C2Llq3uqjKOOiXVLcP+8X6z
         vlBl/lo7NfD/254ux+cQuNFC7vQUjHKUORmYpITy0o+zFBNrvthGinJGsCd+7+5jXJMq
         vbkDxrrOWBj6Rv701fRDlfv0umCjx8f2ReLN9OtGGlcJq8i+Fm+1hQ53vTXUZ91JcZDU
         4sLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pfyzZGOgFR8JpdppLMBGRahWign1okVbjuzaxShQLj4=;
        b=yb2zueNM5FBHAZvLVuif8See3EpZfOFw/8Xrc9b7DxwDaEoSLSyt6OCXHQzelWPhZM
         rAkZ11Wy2L13E+gCriCowP/OyKhjmIQg9oFQrVTAztuM4NmvK0tjK0XQAi/DSpGuoNLr
         r3AuoZDbtV8JvtftYxN6MiqAhLef0bBy70BvaQjzLfOKkhTcs8bvw8xde0BS2AUuHfkE
         /VTgS1bgRl++608TKpM47T98VGGm1Ci4dCBAKiyZfUR68xEGVwBoRSV8yxy1mYUO4UV6
         SQDyTJVdDpoXhROHfuU3GfHFGIKgD5LeBrkXeAP21Vd54BYTdicU4DJCdhODeL2eeyUG
         Lb4A==
X-Gm-Message-State: AO0yUKWOaQQgAhgDQM3aPKj4iwkEHJhr6TL61Iw1gzJHVlzfh1xp40+N
        JT9pfiDCtf59FRnayvbti/xLjA==
X-Google-Smtp-Source: AK7set8JpufQhWdcRJ+BEmmVhZstiF26E90Ef0t3jfC9+K2OuXgwMWuOeImG6W7vD/tbgaaMq/DBCQ==
X-Received: by 2002:a05:6a21:6d88:b0:c7:20d8:dc1e with SMTP id wl8-20020a056a216d8800b000c720d8dc1emr3483559pzb.27.1676571666717;
        Thu, 16 Feb 2023 10:21:06 -0800 (PST)
Received: from kerodi.Dlink ([49.206.14.226])
        by smtp.gmail.com with ESMTPSA id n21-20020a637215000000b004dff15fc121sm1517574pgc.36.2023.02.16.10.21.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Feb 2023 10:21:06 -0800 (PST)
From:   Sunil V L <sunilvl@ventanamicro.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc:     linux-riscv@lists.infradead.org, linux-acpi@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Conor Dooley <conor.dooley@microchip.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Atish Patra <atishp@rivosinc.com>,
        Sunil V L <sunilvl@ventanamicro.com>,
        Robert Moore <robert.moore@intel.com>,
        acpica-devel@lists.linuxfoundation.org,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH V2 03/21] ACPICA: Add structure definitions for RISC-V RHCT
Date:   Thu, 16 Feb 2023 23:50:25 +0530
Message-Id: <20230216182043.1946553-4-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230216182043.1946553-1-sunilvl@ventanamicro.com>
References: <20230216182043.1946553-1-sunilvl@ventanamicro.com>
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

