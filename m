Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F7096AFE5A
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 06:28:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbjCHF2A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 00:28:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbjCHF1y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 00:27:54 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AECEAA90BC;
        Tue,  7 Mar 2023 21:27:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678253226; x=1709789226;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=qri/KVEiSHHJhydbIzI6u5FWz67X2UhCthcZ5Ix9To8=;
  b=Jdv80soCb/2DAT/ZFBjZWWwPxgt8kTE35lMzEb5awbk5/pf1caG+d0Mc
   hPcDBBuCnQlxeCBOGm86cxaAK5TmtwTbtbrjOGweyVEfAz8v/vUf0T+0j
   U//yUSMwGOIvfFwgsD7b1d4dD25LrDk5Emlk7Bm2Zvb9t/WAUqgUpLqWZ
   D+oFTiuQ/boElS8bPDn2yAJ+0mfCyPZ5Tlim078IERpprCFGnSCVh94GK
   8vkve6dCOVF0PDz2gtxNwoTT3lMNEFHIz3GWZQznIuXpWqtepcHiH/wCl
   A9lr21MtBNtuZ/MNPP96nTRI2yK2719O7CHmckZV5CNk2i7IMqw6W9M/N
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10642"; a="398643933"
X-IronPort-AV: E=Sophos;i="5.98,242,1673942400"; 
   d="scan'208";a="398643933"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2023 21:27:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10642"; a="626786296"
X-IronPort-AV: E=Sophos;i="5.98,242,1673942400"; 
   d="scan'208";a="626786296"
Received: from chenyu-dev.sh.intel.com ([10.239.158.170])
  by orsmga003.jf.intel.com with ESMTP; 07 Mar 2023 21:27:04 -0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Len Brown <lenb@kernel.org>,
        Robert Moore <robert.moore@intel.com>
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chen Yu <yu.c.chen@intel.com>,
        Hariganesh Govindarajulu <hariganesh.govindarajulu@intel.com>
Subject: [PATCH v2] ACPI: tools: pfrut: Check if the input of level and type is in the right numeric range
Date:   Wed,  8 Mar 2023 21:23:09 +0800
Message-Id: <20230308132309.18827-1-yu.c.chen@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The user provides arbitrary non-numeic value to level and type,
which could bring expected behavior. In this case the expected
behavior would be to throw an error.

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

Fix this by restricting the input to be in the expected range.

Reported-by: Hariganesh Govindarajulu <hariganesh.govindarajulu@intel.com>
Suggested-by: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
v2: Replace atoi() with strtol() to filter the number. (Rafael)

---
 tools/power/acpi/tools/pfrut/pfrut.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/tools/power/acpi/tools/pfrut/pfrut.c b/tools/power/acpi/tools/pfrut/pfrut.c
index 52aa0351533c..388c9e3ad040 100644
--- a/tools/power/acpi/tools/pfrut/pfrut.c
+++ b/tools/power/acpi/tools/pfrut/pfrut.c
@@ -97,7 +97,7 @@ static struct option long_options[] = {
 static void parse_options(int argc, char **argv)
 {
 	int option_index = 0;
-	char *pathname;
+	char *pathname, *endptr;
 	int opt;
 
 	pathname = strdup(argv[0]);
@@ -125,11 +125,23 @@ static void parse_options(int argc, char **argv)
 			log_getinfo = 1;
 			break;
 		case 'T':
-			log_type = atoi(optarg);
+			log_type = strtol(optarg, &endptr, 0);
+			if (*endptr || (log_type != 0 && log_type != 1)) {
+				printf("Number expected: type(0:execution, 1:history) - Quit.\n");
+				exit(1);
+			}
+
 			set_log_type = 1;
 			break;
 		case 'L':
-			log_level = atoi(optarg);
+			log_level = strtol(optarg, &endptr, 0);
+			if (*endptr ||
+			    (log_level != 0 && log_level != 1 &&
+			     log_level != 2 && log_level != 4)) {
+				printf("Number expected: level(0, 1, 2, 4) - Quit.\n");
+				exit(1);
+			}
+
 			set_log_level = 1;
 			break;
 		case 'R':
-- 
2.25.1

