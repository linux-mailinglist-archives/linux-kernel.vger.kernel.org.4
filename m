Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DA607388A0
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 17:16:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233312AbjFUPQy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 11:16:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233271AbjFUPQ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 11:16:29 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 709AA3C05;
        Wed, 21 Jun 2023 08:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687360331; x=1718896331;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Fy9uOC8gBt63gljWFjyljJTHdFzCmYEir+Wh6USceZ8=;
  b=cBKGxkG4DIa+Fd/eB99NSpzii5x7e7Q2D3dRSwNhJFhpu8ZZ+BomKlDa
   qg3jqS/OmyZVfVHsDzSstbEkmuP06YaLNIJjx02n7w7c9KyI/7wKPmiNt
   Eo7+CwLfZlyiP2VCozPYcXlnptNTzQ0dDIRsTxOQAEjBeivGtFG6cVrjn
   jgveiWpkVaR05pC89H5bB5HCQGkj7e9O7vuCVsWrUSLoOxSpNIZ3IDrtR
   D+x0GEOb7C/JE/CgspodY/NA9NGpb8nn2dpyUsu9Dc8vbvqR6hQY6A08a
   G4SCWz3r9amd++k2ayiOkQS6uDmF2SUlD2hwKSzpda5zZvwPEvrXAa4EC
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10748"; a="344937866"
X-IronPort-AV: E=Sophos;i="6.00,260,1681196400"; 
   d="scan'208";a="344937866"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2023 08:11:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10748"; a="827489545"
X-IronPort-AV: E=Sophos;i="6.00,260,1681196400"; 
   d="scan'208";a="827489545"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 21 Jun 2023 08:11:48 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 19698241; Wed, 21 Jun 2023 18:11:59 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Mark Gross <markgross@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 2/2] platform/x86: wmi: Replace open coded guid_parse_and_compare()
Date:   Wed, 21 Jun 2023 18:11:55 +0300
Message-Id: <20230621151155.78279-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
In-Reply-To: <20230621151155.78279-1-andriy.shevchenko@linux.intel.com>
References: <20230621151155.78279-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Even though we have no issues in the code, let's replace the open
coded guid_parse_and_compare().

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/platform/x86/wmi.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
index 098512a53170..a78ddd83cda0 100644
--- a/drivers/platform/x86/wmi.c
+++ b/drivers/platform/x86/wmi.c
@@ -1241,11 +1241,7 @@ static bool guid_already_parsed_for_legacy(struct acpi_device *device, const gui
 	list_for_each_entry(wblock, &wmi_block_list, list) {
 		/* skip warning and register if we know the driver will use struct wmi_driver */
 		for (int i = 0; allow_duplicates[i] != NULL; i++) {
-			guid_t tmp;
-
-			if (guid_parse(allow_duplicates[i], &tmp))
-				continue;
-			if (guid_equal(&tmp, guid))
+			if (guid_parse_and_compare(allow_duplicates[i], guid))
 				return false;
 		}
 		if (guid_equal(&wblock->gblock.guid, guid)) {
-- 
2.40.0.1.gaa8946217a0b

