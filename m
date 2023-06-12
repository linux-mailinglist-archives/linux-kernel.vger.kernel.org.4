Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82AF372BBBF
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 11:08:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233865AbjFLJIT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 05:08:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232086AbjFLJHn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 05:07:43 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C1B0526C;
        Mon, 12 Jun 2023 02:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686560596; x=1718096596;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Ikq1JZUtD42zuhPeuCVWdxOC98LK4HCQX9rMW7i+Mjg=;
  b=XntN7dRb49z5yKmZvCpysfHI6d0xSycNAiCr1ax6ql8mbdnuUrmSpR+x
   hRzuqWybPGwF4Az3SKJwonnVvQ4/ZEiZZ33w3Ri/ZIK9cRVhk8kRYTr05
   U/npNzWI4e05BW2h392bCWKrwlSTZ/NykDFgxE32uOQcf5xgWTZlvh/0s
   e/PV31au44qYomFvc891z1Pc3PxMuSJGMpcKKUymnuNQJ5pMPEBtnlMUZ
   hPXNxg6c0Kq6WHQgtiSp77o6knTAuJH2reBSW3IQ5f9TmFkRZb0fVWAIt
   zEsbiqdsKzyGqL8QIN9str8T8mkUaPksTvlo1RTQJDvqUfW+dzMTnxizV
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10738"; a="423864270"
X-IronPort-AV: E=Sophos;i="6.00,236,1681196400"; 
   d="scan'208";a="423864270"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2023 02:03:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10738"; a="835405536"
X-IronPort-AV: E=Sophos;i="6.00,236,1681196400"; 
   d="scan'208";a="835405536"
Received: from powerlab.fi.intel.com ([10.237.71.25])
  by orsmga004.jf.intel.com with ESMTP; 12 Jun 2023 02:03:03 -0700
From:   Michal Wilczynski <michal.wilczynski@intel.com>
To:     linux-acpi@vger.kernel.org
Cc:     rafael@kernel.org, andriy.shevchenko@intel.com,
        ilpo.jarvinen@linux.intel.com, pali@kernel.org,
        hdegoede@redhat.com, markgross@kernel.org, fengguang.wu@intel.com,
        dvhart@linux.intel.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1] platform/x86/dell/dell-rbtn: Fix resources leaking on error path
Date:   Mon, 12 Jun 2023 12:02:50 +0300
Message-Id: <20230612090250.1417940-1-michal.wilczynski@intel.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently rbtn_add() in case of failure is leaking resources. Fix this
by adding a proper rollback. While at it, remove unnecessary assignment
of NULL to device->driver_data and unnecessary whitespace, plus add a
break for the default case in a switch.

Suggested-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Fixes: 817a5cdb40c8 ("dell-rbtn: Dell Airplane Mode Switch driver")
Signed-off-by: Michal Wilczynski <michal.wilczynski@intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/platform/x86/dell/dell-rbtn.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/dell/dell-rbtn.c b/drivers/platform/x86/dell/dell-rbtn.c
index aa0e6c907494..e9b3f9c3ab7d 100644
--- a/drivers/platform/x86/dell/dell-rbtn.c
+++ b/drivers/platform/x86/dell/dell-rbtn.c
@@ -420,10 +420,12 @@ static int rbtn_add(struct acpi_device *device)
 		break;
 	default:
 		ret = -EINVAL;
+		break;
 	}
+	if (ret)
+		rbtn_acquire(device, false);
 
 	return ret;
-
 }
 
 static void rbtn_remove(struct acpi_device *device)
@@ -442,7 +444,6 @@ static void rbtn_remove(struct acpi_device *device)
 	}
 
 	rbtn_acquire(device, false);
-	device->driver_data = NULL;
 }
 
 static void rbtn_notify(struct acpi_device *device, u32 event)
-- 
2.40.1

