Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59B8863E5A8
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 00:42:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229918AbiK3XmI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 18:42:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbiK3XmC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 18:42:02 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E99884D5FA;
        Wed, 30 Nov 2022 15:42:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AE9EFB81D59;
        Wed, 30 Nov 2022 23:42:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF770C43140;
        Wed, 30 Nov 2022 23:41:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669851719;
        bh=pFJPFr1bYR15HN/6Ql3O3Nqt1/yhoHZv7oRl5CFhYeg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BfN7AZujL3v4Pw7dJ191/MllgmRUWFI98V/rTAYbF3N3CbKhzBPc25dHL5sTJYdMw
         w2JWddwtc/WP32pzOSYOmX3NV4bz4Cr+0bglMeVKBJa93VxHHHvqYk4rCtYGDWGpbR
         UvMzijLaqrKCYQkFw889UBx2mgpEp47UixWb34+2J5axA4ua6hBirhQh4HQ6qASDjz
         j62GI9CVGXcUI6xJtjy5Pjbs12QjnAZF5NLgtoKLNpef2ixQ1PRVovvGBRFWRQJEEU
         Cmk/1eAeufueb8lVEX72VFfRPApG0msXg1CFc+gfipCCUvhwNYib4YWqADLkCJ27g7
         Lc/za5OEOtYDg==
From:   Conor Dooley <conor@kernel.org>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv@lists.infradead.org
Cc:     Conor Dooley <conor.dooley@microchip.com>, ajones@ventanamicro.com,
        aou@eecs.berkeley.edu, conor@kernel.org, corbet@lwn.net,
        guoren@kernel.org, heiko@sntech.de, paul.walmsley@sifive.com,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: [PATCH v1 1/3] RISC-V: clarify ISA string ordering rules in cpu.c
Date:   Wed, 30 Nov 2022 23:41:24 +0000
Message-Id: <20221130234125.2722364-2-conor@kernel.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221130234125.2722364-1-conor@kernel.org>
References: <20221130234125.2722364-1-conor@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Conor Dooley <conor.dooley@microchip.com>

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
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 arch/riscv/kernel/cpu.c | 49 ++++++++++++++++++++++++++++++-----------
 1 file changed, 36 insertions(+), 13 deletions(-)

diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
index 852ecccd8920..68b2bd0cc3bc 100644
--- a/arch/riscv/kernel/cpu.c
+++ b/arch/riscv/kernel/cpu.c
@@ -120,22 +120,45 @@ device_initcall(riscv_cpuinfo_init);
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
+ * ordering so for our purposes the following rules apply:
+ *
+ * 1. All multi-letter extensions must be separated from other multi-letter
+ *    extensions by an underscore.
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
+ *    If multiple 'Z' extensions are named, they should be ordered first by
+ *    category, then alphabetically within a category.
+ *
+ * 3. Standard supervisor-level extensions (starting with 'S') must be listed
+ *    after standard unprivileged extensions.  If multiple
+ *    supervisor-level extensions are listed, they must be ordered
  *    alphabetically.
- * 4. Non-standard extensions (starts with 'X') must be listed after all
- *    standard extensions. They must be separated from other multi-letter
- *    extensions by an underscore.
+ *
+ * 4. Standard machine-level extensions (starting with 'Zxm') must be listed
+ *    after any lower-privileged, standard extensions.  If multiple
+ *    machine-level extensions are listed, they must be ordered
+ *    alphabetically.
+ *
+ * 5. Non-standard extensions (starts with 'X') must be listed after all
+ *    standard extensions.
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

