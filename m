Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3D506AFE1B
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 06:13:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbjCHFND (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 00:13:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjCHFNB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 00:13:01 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C94C44C02;
        Tue,  7 Mar 2023 21:12:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678252379; x=1709788379;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=tvozT70EfLOxpJDzfJuVfhXexy7OoUDvuPOHFYsw9bk=;
  b=mMbEy1yNCckYcZS6IlVtxuNDXexvB7TlI+Fp/nClom3EHf87DE3u+xcR
   2vRfYMvRCnKJueJuqX3B3HBhXRKWTNcrt6w3HehOirvLxvAqPUzXlW5/V
   /lZLrGK7aILuChI1TxwE5CH+imZHb5XZOmNjDc903QEWnacrgo4cbNc8j
   7ZflNiMp86/nLw5ywfvUaDnmoOhcB1b4QQZv93Bvh+sg55zWTgEQBmxMa
   vlsvfjdkrYQMfoqSrPntOcxsysrexcpWOI0T/SpsUzCe6jwfW/rJwq3VJ
   i6Dh4sl2usoecbZSFQbtdtkq6wSAmVDRLDVCU+BYAXxk0APV3h5LeM+Y6
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10642"; a="398641930"
X-IronPort-AV: E=Sophos;i="5.98,242,1673942400"; 
   d="scan'208";a="398641930"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2023 21:12:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10642"; a="626783809"
X-IronPort-AV: E=Sophos;i="5.98,242,1673942400"; 
   d="scan'208";a="626783809"
Received: from chenyu-dev.sh.intel.com ([10.239.158.170])
  by orsmga003.jf.intel.com with ESMTP; 07 Mar 2023 21:12:57 -0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Len Brown <lenb@kernel.org>,
        Robert Moore <robert.moore@intel.com>
Cc:     linux-acpi@vger.kernel.org, acpica-devel@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org, Chen Yu <yu.c.chen@intel.com>,
        Hariganesh Govindarajulu <hariganesh.govindarajulu@intel.com>
Subject: [PATCH v2] ACPI: tools: pfrut: Check if the input of level and type is in the right numeric range
Date:   Wed,  8 Mar 2023 21:09:02 +0800
Message-Id: <20230308130902.18397-1-yu.c.chen@intel.com>
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

The user provides arbitrary non-numeic value to level and type, which could
bring expected bahavior. In this case the expected behavior would be to throw
an error.

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
 tools/power/acpi/tools/pfrut/pfrut.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/tools/power/acpi/tools/pfrut/pfrut.c b/tools/power/acpi/tools/pfrut/pfrut.c
index 52aa0351533c..13161a6e672d 100644
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
@@ -125,11 +125,21 @@ static void parse_options(int argc, char **argv)
 			log_getinfo = 1;
 			break;
 		case 'T':
-			log_type = atoi(optarg);
+			log_type = strtol(optarg, &endptr, 0);
+			if(*endptr || (log_type != 0 && log_type != 1)) {
+				printf("Please provide numeric value for type (0:execution, 1:history) - Exiting.\n");
+				exit(1);
+			}
+
 			set_log_type = 1;
 			break;
 		case 'L':
-			log_level = atoi(optarg);
+			log_level = strtol(optarg, &endptr, 0);
+			if(*endptr || (log_level != 0 && log_level != 1 && log_level != 2 && log_level != 4)) {
+				printf("Please provide numeric value for level (0, 1, 2, 4) - Exiting.\n");
+				exit(1);
+			}
+
 			set_log_level = 1;
 			break;
 		case 'R':
-- 
2.25.1

