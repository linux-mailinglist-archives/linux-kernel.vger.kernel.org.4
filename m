Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FD81646F05
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 12:51:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230184AbiLHLvp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 06:51:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbiLHLvT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 06:51:19 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41B5784DE5;
        Thu,  8 Dec 2022 03:50:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670500202; x=1702036202;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=aU/UU3IhfOGFIf/tX/8uvsZF4JL0yUqrKcro31NQwXo=;
  b=g/pqbwcPJKxkC29EOKKbsD3RyWVJbxEBrdIzPCF782sJNkLQW7TG9BeX
   BSu3atTVgDEp9hSE9wB8UjQI8imn6zOT37IrAOoVWMjCwKlmjnwLOqyJr
   Vnu9DsRC3x3YMW5LT7Qi+xvvuSatzarrZ4IYJ00ApfUyL8VF8mKAyEUsT
   zTumAld97yAMWZfenjLuHCKZC1zE/DjIV9kqm2sIRcUSB0e6yOXnY0RQU
   6HOaOlgzrCI/TOggZEcLEzRDS9bsje85X9UrhMcHDAEltbPPNXJxKGxdZ
   aDrudnbjr9/KHxlsxUQo9AR/eIoaystWk91i7JhZi7q3LaY/x5j7B+CYF
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10554"; a="297508385"
X-IronPort-AV: E=Sophos;i="5.96,227,1665471600"; 
   d="scan'208";a="297508385"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2022 03:50:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10554"; a="646974577"
X-IronPort-AV: E=Sophos;i="5.96,227,1665471600"; 
   d="scan'208";a="646974577"
Received: from dev2.igk.intel.com ([10.237.148.94])
  by orsmga002.jf.intel.com with ESMTP; 08 Dec 2022 03:49:59 -0800
From:   =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>
To:     "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Robert Moore <robert.moore@intel.com>
Cc:     Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        devel@acpica.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>
Subject: [PATCH] ACPICA: Fix operand resolution
Date:   Thu,  8 Dec 2022 20:50:46 +0100
Message-Id: <20221208195046.1980312-1-amadeuszx.slawinski@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In our tests we get UBSAN warning coming from ACPI parser. This is
caused by trying to resolve operands when there is none.

[    0.000000] Linux version 5.15.0-rc3chromeavsrel1.0.184+ (root@...) (gcc (Ubuntu 10.3.0-1ubuntu1~20.04) 10.3.0, GNU ld (GNU Binutils for Ubuntu) 2.34) #1 SMP PREEMPT Sat Oct 16 00:08:27 UTC 2021
...
[ 14.719508] ================================================================================
[ 14.719551] UBSAN: array-index-out-of-bounds in /.../linux/drivers/acpi/acpica/dswexec.c:401:12
[ 14.719594] index -1 is out of range for type 'acpi_operand_object *[9]'
[ 14.719621] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.15.0-rc3chromeavsrel1.0.184+ #1
[ 14.719657] Hardware name: Intel Corp. Geminilake/GLK RVP2 LP4SD (07), BIOS GELKRVPA.X64.0214.B50.2009111159 09/11/2020
[ 14.719694] Call Trace:
[ 14.719712] dump_stack_lvl+0x38/0x49
[ 14.719749] dump_stack+0x10/0x12
[ 14.719775] ubsan_epilogue+0x9/0x45
[ 14.719801] __ubsan_handle_out_of_bounds.cold+0x44/0x49
[ 14.719835] acpi_ds_exec_end_op+0x1d7/0x6b5
[ 14.719870] acpi_ps_parse_loop+0x942/0xb34
...

Problem happens because WalkState->NumOperands is 0 and it is used when
trying to access into operands table. Actual code is:
WalkState->Operands [WalkState->NumOperands -1]
which causes out of bound access. Improve the check before above access
to check if ACPI opcode should have any arguments (operands) at all.

Link: https://github.com/acpica/acpica/pull/745
Signed-off-by: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>
Reviewed-by: Cezary Rojewski <cezary.rojewski@intel.com>
---
 drivers/acpi/acpica/dswexec.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/acpica/dswexec.c b/drivers/acpi/acpica/dswexec.c
index e8ad41387f84..489c9b9d8d15 100644
--- a/drivers/acpi/acpica/dswexec.c
+++ b/drivers/acpi/acpica/dswexec.c
@@ -389,9 +389,11 @@ acpi_status acpi_ds_exec_end_op(struct acpi_walk_state *walk_state)
 
 		/*
 		 * All opcodes require operand resolution, with the only exceptions
-		 * being the object_type and size_of operators.
+		 * being the object_type and size_of operators as well as operands that
+		 * take no arguments.
 		 */
-		if (!(walk_state->op_info->flags & AML_NO_OPERAND_RESOLVE)) {
+		if (!(walk_state->op_info->flags & AML_NO_OPERAND_RESOLVE) &&
+		    (walk_state->op_info->flags & AML_HAS_ARGS)) {
 
 			/* Resolve all operands */
 
-- 
2.25.1

