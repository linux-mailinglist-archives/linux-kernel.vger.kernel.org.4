Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D7C1642A97
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 15:46:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232177AbiLEOqV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 09:46:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231969AbiLEOqR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 09:46:17 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CCC41B1FE;
        Mon,  5 Dec 2022 06:46:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1670251576; x=1701787576;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/A732PXUzOa5QEDZseaW4QKYJ4f5uZaINwwbpO826ps=;
  b=YlOznsoeWfXvfw00ixYArB5bTZOboFkNqaRL97SW3/kf76ms/zr5XKhk
   qxehEX10fyl2082DgWmGXwQgG6oA61rOsJbkXFFjXRay2hkepBRvXN+DI
   kyptBhMNij1iHcIxlz79pEjAfcqBuSsGH9mYDUlQOVSuFzwftyCrc2aMD
   8TZMnCJfXnW/UvFC/l3BFOubilIgSPMSNv6r2jerEzX3GAemOsEqcnxS/
   CK+5/wyPChp3EgBsLlrzxhCo886yMaVp7XyKsSJvvR1w3r4WeRzlfrPxx
   NdwpmLMioozarvU1Ye00pXHXSqt3Qw7bOTPUW5b1TYA68M0xT+NxJhJLK
   w==;
X-IronPort-AV: E=Sophos;i="5.96,219,1665471600"; 
   d="scan'208";a="202640917"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 05 Dec 2022 07:46:15 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Mon, 5 Dec 2022 07:46:14 -0700
Received: from wendy.microchip.com (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2507.12 via Frontend
 Transport; Mon, 5 Dec 2022 07:46:12 -0700
From:   Conor Dooley <conor.dooley@microchip.com>
To:     <linux-riscv@lists.infradead.org>,
        Palmer Dabbelt <palmer@dabbelt.com>
CC:     Conor Dooley <conor.dooley@microchip.com>,
        <ajones@ventanamicro.com>, <aou@eecs.berkeley.edu>,
        <conor@kernel.org>, <corbet@lwn.net>, <guoren@kernel.org>,
        <heiko@sntech.de>, <paul.walmsley@sifive.com>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>
Subject: [PATCH v2 1/3] RISC-V: clarify ISA string ordering rules in cpu.c
Date:   Mon, 5 Dec 2022 14:45:24 +0000
Message-ID: <20221205144525.2148448-2-conor.dooley@microchip.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221205144525.2148448-1-conor.dooley@microchip.com>
References: <20221205144525.2148448-1-conor.dooley@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While the current list of rules may have been accurate when created
it now lacks some clarity in the face of isa-manual updates. Instead of
trying to continuously align this rule-set with the one in the
specifications, change the role of this comment.

This particular comment is important, as the array it "decorates"
defines the order in which the ISA string appears to userspace in
/proc/cpuinfo.

Re-jig and strengthen the wording to provide contributors with a set
order in which to add entries & note why this particular struct needs
more attention than others.

While in the area, add some whitespace and tweak some wording for
readability's sake.

Suggested-by: Andrew Jones <ajones@ventanamicro.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 arch/riscv/kernel/cpu.c | 49 ++++++++++++++++++++++++++++++-----------
 1 file changed, 36 insertions(+), 13 deletions(-)

diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
index 1b9a5a66e55a..db8b16ad9342 100644
--- a/arch/riscv/kernel/cpu.c
+++ b/arch/riscv/kernel/cpu.c
@@ -144,22 +144,45 @@ arch_initcall(riscv_cpuinfo_init);
 		.uprop = #UPROP,				\
 		.isa_ext_id = EXTID,				\
 	}
+
 /*
- * Here are the ordering rules of extension naming defined by RISC-V
- * specification :
- * 1. All extensions should be separated from other multi-letter extensions
- *    by an underscore.
- * 2. The first letter following the 'Z' conventionally indicates the most
+ * The canonical order of ISA extension names in the ISA string is defined in
+ * chapter 27 of the unprivileged specification.
+ *
+ * Ordinarily, for in-kernel data structures, this order is unimportant but
+ * isa_ext_arr defines the order of the ISA string in /proc/cpuinfo.
+ *
+ * The specification uses vague wording, such as should, when it comes to
+ * ordering, so for our purposes the following rules apply:
+ *
+ * 1. All multi-letter extensions must be separated from other extensions by an
+ *    underscore.
+ *
+ * 2. Additional standard extensions (starting with 'Z') must be sorted after
+ *    single-letter extensions and before any higher-privileged extensions.
+
+ * 3. The first letter following the 'Z' conventionally indicates the most
  *    closely related alphabetical extension category, IMAFDQLCBKJTPVH.
- *    If multiple 'Z' extensions are named, they should be ordered first
- *    by category, then alphabetically within a category.
- * 3. Standard supervisor-level extensions (starts with 'S') should be
- *    listed after standard unprivileged extensions.  If multiple
- *    supervisor-level extensions are listed, they should be ordered
+ *    If multiple 'Z' extensions are named, they must be ordered first by
+ *    category, then alphabetically within a category.
+ *
+ * 3. Standard supervisor-level extensions (starting with 'S') must be listed
+ *    after standard unprivileged extensions.  If multiple supervisor-level
+ *    extensions are listed, they must be ordered alphabetically.
+ *
+ * 4. Standard machine-level extensions (starting with 'Zxm') must be listed
+ *    after any lower-privileged, standard extensions.  If multiple
+ *    machine-level extensions are listed, they must be ordered
  *    alphabetically.
- * 4. Non-standard extensions (starts with 'X') must be listed after all
- *    standard extensions. They must be separated from other multi-letter
- *    extensions by an underscore.
+ *
+ * 5. Non-standard extensions (starting with 'X') must be listed after all
+ *    standard extensions. If multiple non-standard extensions are listed, they
+ *    must be ordered alphabetically.
+ *
+ * An example string following the order is:
+ *    rv64imadc_zifoo_zigoo_zafoo_sbar_scar_zxmbaz_xqux_xrux
+ *
+ * New entries to this struct should follow the ordering rules described above.
  */
 static struct riscv_isa_ext_data isa_ext_arr[] = {
 	__RISCV_ISA_EXT_DATA(sscofpmf, RISCV_ISA_EXT_SSCOFPMF),
-- 
2.38.1

