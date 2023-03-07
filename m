Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E7506AD5D5
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 04:46:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230165AbjCGDqJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 22:46:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230127AbjCGDqF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 22:46:05 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADFD753DB7;
        Mon,  6 Mar 2023 19:46:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678160760; x=1709696760;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=JH6KUnXca9l7Kkc7BEHwMFneDb27PRNKErnVL7Y0kNU=;
  b=ibDmv/bAnBdUxeW6lNvtMWX69AIR7XoS3f5Qks2WHeEVTUSDF3nRknEF
   nMrROAPTehgP8z9WQqOAULPZq8kw8aa5YvyxvzEURaKaoBtXX167rx5e+
   mH7kGqWrwnZUW0ttMkGP88b84AAbFBHRu0szw1hFMpLbDhkKvBXYYXleU
   WSq1POFtRHI9XAKR2skqnx8VV4zLsJHmxNeXGzqv4b3vtC7KpGlRpfXDz
   NgbeTcxjfCwMJI2BUnh2W8SQQKaKipd/PMwZVddOt4iVDmuQwn4sDrA3o
   sxGrGdR1Da4bX/EtCGa8Dp9kS+U1qh+plzk78/4LJIltPTLgvXtq+lslP
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10641"; a="337274278"
X-IronPort-AV: E=Sophos;i="5.98,238,1673942400"; 
   d="scan'208";a="337274278"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2023 19:46:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10641"; a="800260349"
X-IronPort-AV: E=Sophos;i="5.98,238,1673942400"; 
   d="scan'208";a="800260349"
Received: from chenyu-dev.sh.intel.com ([10.239.158.170])
  by orsmga004.jf.intel.com with ESMTP; 06 Mar 2023 19:45:57 -0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Len Brown <lenb@kernel.org>,
        Robert Moore <robert.moore@intel.com>
Cc:     linux-acpi@vger.kernel.org, acpica-devel@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org, Chen Yu <yu.c.chen@intel.com>,
        Hariganesh Govindarajulu <hariganesh.govindarajulu@intel.com>
Subject: [PATCH] ACPI: tools: pfrut: Check if the input of level and type is in the right numeric range
Date:   Tue,  7 Mar 2023 19:41:45 +0800
Message-Id: <20230307114145.8933-1-yu.c.chen@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The user can provide arbitrary non-numeic value to level and type, which
brings unexpected behavior:

 pfrut -h
usage: pfrut [OPTIONS]
code injection:
-l, --load
-s, --stage
-a, --activate
-u, --update [stage and activate]
-q, --query
-d, --revid
update telemetry:
-G, --getloginfo
-T, --type(0:execution, 1:history)
-L, --level(0, 1, 2, 4)
-R, --read
-D, --revid log

 pfrut -T A
 pfrut -G
log_level:0
log_type:0
log_revid:2
max_data_size:65536
chunk1_size:0
chunk2_size:1530
rollover_cnt:0
reset_cnt:17

Fix this by restricting the input is in the expected range.

Reported-by: Hariganesh Govindarajulu <hariganesh.govindarajulu@intel.com>
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
 tools/power/acpi/tools/pfrut/pfrut.c | 33 ++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/tools/power/acpi/tools/pfrut/pfrut.c b/tools/power/acpi/tools/pfrut/pfrut.c
index 52aa0351533c..ed672efef83b 100644
--- a/tools/power/acpi/tools/pfrut/pfrut.c
+++ b/tools/power/acpi/tools/pfrut/pfrut.c
@@ -22,6 +22,7 @@
 #include <sys/ioctl.h>
 #include <sys/mman.h>
 #include <uuid/uuid.h>
+#include <ctype.h>
 #include PFRUT_HEADER
 
 char *capsule_name;
@@ -77,6 +78,18 @@ static void help(void)
 		progname);
 }
 
+static int is_digit_input(char *str)
+{
+	char *scan;
+
+	for (scan = str; *scan != '\0'; scan++) {
+		if (!isdigit(*scan))
+			return 0;
+	}
+
+	return 1;
+}
+
 char *option_string = "l:sauqd:GT:L:RD:h";
 static struct option long_options[] = {
 	{"load", required_argument, 0, 'l'},
@@ -125,11 +138,31 @@ static void parse_options(int argc, char **argv)
 			log_getinfo = 1;
 			break;
 		case 'T':
+			if (!is_digit_input(optarg)) {
+				printf("Please provide numeric value for type (0:execution, 1:history) - Exiting.\n");
+				exit(1);
+			}
+
 			log_type = atoi(optarg);
+			if (log_type != 0 && log_type != 1) {
+				printf("Please provide numeric value for type (0:execution, 1:history) - Exiting.\n");
+				exit(1);
+			}
+
 			set_log_type = 1;
 			break;
 		case 'L':
+			if (!is_digit_input(optarg)) {
+				printf("Please provide numeric value for level (0, 1, 2, 4) - Exiting.\n");
+				exit(1);
+			}
+
 			log_level = atoi(optarg);
+			if (log_level > 4) {
+				printf("Please provide numeric value for level (0, 1, 2, 4) - Exiting.\n");
+				exit(1);
+			}
+
 			set_log_level = 1;
 			break;
 		case 'R':
-- 
2.25.1

