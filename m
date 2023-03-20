Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96A4F6C203A
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 19:46:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231321AbjCTSqT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 14:46:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229961AbjCTSpw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 14:45:52 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F01CF59F0;
        Mon, 20 Mar 2023 11:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679337537; x=1710873537;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EsUqD7zHZfhJc1niZQc3vdHLYkAA8CFNFuJTGMjtmwY=;
  b=NqPGIddujiNHtlhtLwX7Yq6+Km4lXL4tcDUNAqY9NHNmnJFvFY0rHr7q
   T03hQTls7dVXpwNWAt6OU/E9R9YzyOGs+SBjlkxIZaKD8Z9rKLDb20HAm
   VS1fmpAvBTct1xt4KKb4M0kr3KSeOn2pfzfpv8jF71lT8DDalMAt42hca
   Yzv7U5T0GPabq08DfPDrwxvBAvUibF5gXUaTYBnZ97/nCuxELTKWRyaZQ
   pJYD5x4bZGjPhBtk590QRho8q+AxSiu4GVhp9nqlZQ5868ziLZnBtRAFv
   SvYVRkELHx0Q3250KtsQJTTHqVisYbbxPLIf5TGUPKSNylstD4Fu9YW/t
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10655"; a="322588321"
X-IronPort-AV: E=Sophos;i="5.98,276,1673942400"; 
   d="scan'208";a="322588321"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2023 11:35:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10655"; a="791730823"
X-IronPort-AV: E=Sophos;i="5.98,276,1673942400"; 
   d="scan'208";a="791730823"
Received: from spalihov-mobl2.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.252.34.182])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2023 11:35:40 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: [PATCH 2/2] perf intel-pt: Add support for new branch instructions ERETS and ERETU
Date:   Mon, 20 Mar 2023 20:35:17 +0200
Message-Id: <20230320183517.15099-3-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230320183517.15099-1-adrian.hunter@intel.com>
References: <20230320183517.15099-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Intel Flexible Return and Event Delivery (FRED) adds instructions ERETS
(return to supervisor) and ERETU (return to user). Intel PT instruction
decoder needs to know about these instructions because they are
branch instructions. Similar to IRET instructions, when the decoder
encounters one of these instructions it will match it to a TIP (target
instruction pointer) packet that informs what the branch destination is.

The existing "x86 instruction decoder - new instructions" test can be
used to test the result e.g.

  $ perf test -v ins |& grep eret
  Decoded ok: f2 0f 01 ca         erets
  Decoded ok: f3 0f 01 ca         eretu

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/arch/x86/tests/insn-x86.c           |  4 ++++
 .../intel-pt-decoder/intel-pt-insn-decoder.c   | 18 ++++++++++++++++++
 .../intel-pt-decoder/intel-pt-insn-decoder.h   |  2 ++
 3 files changed, 24 insertions(+)

diff --git a/tools/perf/arch/x86/tests/insn-x86.c b/tools/perf/arch/x86/tests/insn-x86.c
index 94b490c434d0..735257d205b5 100644
--- a/tools/perf/arch/x86/tests/insn-x86.c
+++ b/tools/perf/arch/x86/tests/insn-x86.c
@@ -29,6 +29,8 @@ struct test_data test_data_64[] = {
 #include "insn-x86-dat-64.c"
 	{{0x0f, 0x01, 0xee}, 3, 0, NULL, NULL, "0f 01 ee             \trdpkru"},
 	{{0x0f, 0x01, 0xef}, 3, 0, NULL, NULL, "0f 01 ef             \twrpkru"},
+	{{0xf2, 0x0f, 0x01, 0xca}, 4, 0, "erets", "indirect", "f2 0f 01 ca  \terets"},
+	{{0xf3, 0x0f, 0x01, 0xca}, 4, 0, "eretu", "indirect", "f3 0f 01 ca  \teretu"},
 	{{0}, 0, 0, NULL, NULL, NULL},
 };
 
@@ -49,6 +51,8 @@ static int get_op(const char *op_str)
 		{"syscall", INTEL_PT_OP_SYSCALL},
 		{"sysret",  INTEL_PT_OP_SYSRET},
 		{"vmentry",  INTEL_PT_OP_VMENTRY},
+		{"erets",   INTEL_PT_OP_ERETS},
+		{"eretu",   INTEL_PT_OP_ERETU},
 		{NULL, 0},
 	};
 	struct val_data *val;
diff --git a/tools/perf/util/intel-pt-decoder/intel-pt-insn-decoder.c b/tools/perf/util/intel-pt-decoder/intel-pt-insn-decoder.c
index 22308dd93010..c5d57027ec23 100644
--- a/tools/perf/util/intel-pt-decoder/intel-pt-insn-decoder.c
+++ b/tools/perf/util/intel-pt-decoder/intel-pt-insn-decoder.c
@@ -52,6 +52,20 @@ static void intel_pt_insn_decoder(struct insn *insn,
 				op = INTEL_PT_OP_VMENTRY;
 				branch = INTEL_PT_BR_INDIRECT;
 				break;
+			case 0xca:
+				switch (insn->prefixes.bytes[3]) {
+				case 0xf2: /* erets */
+					op = INTEL_PT_OP_ERETS;
+					branch = INTEL_PT_BR_INDIRECT;
+					break;
+				case 0xf3: /* eretu */
+					op = INTEL_PT_OP_ERETU;
+					branch = INTEL_PT_BR_INDIRECT;
+					break;
+				default:
+					break;
+				}
+				break;
 			default:
 				break;
 			}
@@ -230,6 +244,8 @@ const char *branch_name[] = {
 	[INTEL_PT_OP_SYSCALL]	= "Syscall",
 	[INTEL_PT_OP_SYSRET]	= "Sysret",
 	[INTEL_PT_OP_VMENTRY]	= "VMentry",
+	[INTEL_PT_OP_ERETS]	= "Erets",
+	[INTEL_PT_OP_ERETU]	= "Eretu",
 };
 
 const char *intel_pt_insn_name(enum intel_pt_insn_op op)
@@ -273,6 +289,8 @@ int intel_pt_insn_type(enum intel_pt_insn_op op)
 	case INTEL_PT_OP_LOOP:
 		return PERF_IP_FLAG_BRANCH | PERF_IP_FLAG_CONDITIONAL;
 	case INTEL_PT_OP_IRET:
+	case INTEL_PT_OP_ERETS:
+	case INTEL_PT_OP_ERETU:
 		return PERF_IP_FLAG_BRANCH | PERF_IP_FLAG_RETURN |
 		       PERF_IP_FLAG_INTERRUPT;
 	case INTEL_PT_OP_INT:
diff --git a/tools/perf/util/intel-pt-decoder/intel-pt-insn-decoder.h b/tools/perf/util/intel-pt-decoder/intel-pt-insn-decoder.h
index e3338b56a75f..7fb7fe3a1566 100644
--- a/tools/perf/util/intel-pt-decoder/intel-pt-insn-decoder.h
+++ b/tools/perf/util/intel-pt-decoder/intel-pt-insn-decoder.h
@@ -25,6 +25,8 @@ enum intel_pt_insn_op {
 	INTEL_PT_OP_SYSCALL,
 	INTEL_PT_OP_SYSRET,
 	INTEL_PT_OP_VMENTRY,
+	INTEL_PT_OP_ERETS,
+	INTEL_PT_OP_ERETU,
 };
 
 enum intel_pt_insn_branch {
-- 
2.34.1

