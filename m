Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09073677FBE
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 16:29:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231913AbjAWP3U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 10:29:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231825AbjAWP3S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 10:29:18 -0500
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CCE2A1A483;
        Mon, 23 Jan 2023 07:28:56 -0800 (PST)
Received: from vm02.corp.microsoft.com (unknown [167.220.196.155])
        by linux.microsoft.com (Postfix) with ESMTPSA id DCD6220E2D11;
        Mon, 23 Jan 2023 07:23:07 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com DCD6220E2D11
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1674487389;
        bh=Li2UJyY0mGyrGpuxPLsk95rzcd9mDiZ9P/GYVetjqcw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=I67w1+gjVjdOUzjLbHb5UkXxSblfXRehrmpBsxd/8+khhfHljgMF+bQMLFSczSexy
         2gMObMMD5xu1Z4Lg15FsCs1KxVXQs9+7ySNPIhXhsAonwUOxlV5mWQkr37Abd8qcB9
         lDhQQ4oG8UX6X1wbOYMV0w/lJFeX/DV9M8tfqL6E=
From:   Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>,
        "Brijesh Singh" <brijesh.singh@amd.com>,
        "Tom Lendacky" <thomas.lendacky@amd.com>,
        "Kalra, Ashish" <ashish.kalra@amd.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Len Brown" <lenb@kernel.org>, linux-acpi@vger.kernel.org
Subject: [PATCH v1 1/8] include/acpi: add definition of ASPT table
Date:   Mon, 23 Jan 2023 15:22:43 +0000
Message-Id: <20230123152250.26413-2-jpiotrowski@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230123152250.26413-1-jpiotrowski@linux.microsoft.com>
References: <20230123152250.26413-1-jpiotrowski@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The AMD Secure Processor ACPI Table provides the memory location of the
register window and register offsets necessary to communicate with AMD's
PSP (Platform Security Processor). This table is exposed on Hyper-V VMs
configured with support for AMD's SNP isolation technology.

Signed-off-by: Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
---
 include/acpi/actbl1.h | 46 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/include/acpi/actbl1.h b/include/acpi/actbl1.h
index 15c78678c5d3..00d40373df37 100644
--- a/include/acpi/actbl1.h
+++ b/include/acpi/actbl1.h
@@ -26,6 +26,7 @@
  */
 #define ACPI_SIG_AEST           "AEST"	/* Arm Error Source Table */
 #define ACPI_SIG_ASF            "ASF!"	/* Alert Standard Format table */
+#define ACPI_SIG_ASPT           "ASPT"	/* AMD Secure Processor Table */
 #define ACPI_SIG_BERT           "BERT"	/* Boot Error Record Table */
 #define ACPI_SIG_BGRT           "BGRT"	/* Boot Graphics Resource Table */
 #define ACPI_SIG_BOOT           "BOOT"	/* Simple Boot Flag Table */
@@ -106,6 +107,51 @@ struct acpi_whea_header {
 	u64 mask;		/* Bitmask required for this register instruction */
 };
 
+/* https://docs.microsoft.com/en-us/windows-hardware/drivers/ddi/acpitabl/ns-acpitabl-aspt_table */
+#define ASPT_REVISION_ID 0x01
+struct acpi_table_aspt {
+	struct acpi_table_header header;
+	u32 num_entries;
+};
+
+struct acpi_aspt_header {
+	u16 type;
+	u16 length;
+};
+
+enum acpi_aspt_type {
+	ACPI_ASPT_TYPE_GLOBAL_REGS = 0,
+	ACPI_ASPT_TYPE_SEV_MBOX_REGS = 1,
+	ACPI_ASPT_TYPE_ACPI_MBOX_REGS = 2,
+};
+
+/* 0: ASPT Global Registers */
+struct acpi_aspt_global_regs {
+	struct acpi_aspt_header header;
+	u32 reserved;
+	u64 feature_reg_addr;
+	u64 irq_en_reg_addr;
+	u64 irq_st_reg_addr;
+};
+
+/* 1: ASPT SEV Mailbox Registers */
+struct acpi_aspt_sev_mbox_regs {
+	struct acpi_aspt_header header;
+	u8 mbox_irq_id;
+	u8 reserved[3];
+	u64 cmd_resp_reg_addr;
+	u64 cmd_buf_lo_reg_addr;
+	u64 cmd_buf_hi_reg_addr;
+};
+
+/* 2: ASPT ACPI Mailbox Registers */
+struct acpi_aspt_acpi_mbox_regs {
+	struct acpi_aspt_header header;
+	u32 reserved1;
+	u64 cmd_resp_reg_addr;
+	u64 reserved2[2];
+};
+
 /*******************************************************************************
  *
  * ASF - Alert Standard Format table (Signature "ASF!")
-- 
2.25.1

