Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 645C66B8731
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 01:47:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbjCNAq7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 20:46:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbjCNAqy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 20:46:54 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA9E05D8A8;
        Mon, 13 Mar 2023 17:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678754810; x=1710290810;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=rcsTvBwbU1YioDRpvQCRJ7zAZ7Wtr8ikLHy99aBB36c=;
  b=c3oIT3/Dza20wE/TpZCttSltnbyYg2klYdEq9AT8aqYcxg65q2DVwLL/
   DxZOCdubTxwxXIlXAm8idm7vKsJ32s3lVUAtq2SIZmrKNjks/u8qF/JRn
   8JQJXbHc2C3V6gJWnC97eAhPy962gpvX3mvnlD3LTIHkp5IzYDsUJZGbQ
   K717uTEAi+H3InWpB9XEa6LMYKbJBIfvdvsJPMP64iVP4odEhGr+SnCaZ
   jYpWJzabEIKCCC8k0o79TB2rwuXsGig4r3/XnPpIuQ7J1OzPAans2NH7C
   1/sbcdEGckWXkRUpiC3BEJCqC15q3OMyY0AnncjA2tV30mDHALM5ySszv
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10648"; a="337321669"
X-IronPort-AV: E=Sophos;i="5.98,258,1673942400"; 
   d="scan'208";a="337321669"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2023 17:46:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10648"; a="672119601"
X-IronPort-AV: E=Sophos;i="5.98,258,1673942400"; 
   d="scan'208";a="672119601"
Received: from agluck-desk3.sc.intel.com ([172.25.222.78])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2023 17:46:22 -0700
From:   Tony Luck <tony.luck@intel.com>
To:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc:     Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        linux-acpi@vger.kernel.org, linux-cxl@vger.kernel.org,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        Tony Luck <tony.luck@intel.com>
Subject: [PATCH] ACPI: APEI: EINJ: Add CXL error types
Date:   Mon, 13 Mar 2023 17:46:11 -0700
Message-Id: <20230314004611.48583-1-tony.luck@intel.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ACPI 6.5 added six new error types for CXL. See chapter 18
table 18.30.

Add strings for the new types so that Linux will list them in the
/sys/kernel/debug/apei/einj/available_error_types file.

It seems no other changes are needed. Linux already accepts
the CXL codes (on a BIOS that advertises them).

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 drivers/acpi/apei/einj.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/acpi/apei/einj.c b/drivers/acpi/apei/einj.c
index b4373e575660..39bee5a067cc 100644
--- a/drivers/acpi/apei/einj.c
+++ b/drivers/acpi/apei/einj.c
@@ -584,6 +584,12 @@ static const char * const einj_error_type_string[] = {
 	"0x00000200\tPlatform Correctable\n",
 	"0x00000400\tPlatform Uncorrectable non-fatal\n",
 	"0x00000800\tPlatform Uncorrectable fatal\n",
+	"0x00001000\tCXL.cache Protocol Correctable\n",
+	"0x00002000\tCXL.cache Protocol Uncorrectable non-fatal\n",
+	"0x00004000\tCXL.cache Protocol Uncorrectable fatal\n",
+	"0x00008000\tCXL.mem Protocol Correctable\n",
+	"0x00010000\tCXL.mem Protocol Uncorrectable non-fatal\n",
+	"0x00020000\tCXL.mem Protocol Uncorrectable fatal\n",
 };
 
 static int available_error_type_show(struct seq_file *m, void *v)
-- 
2.39.2

