Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB0C172E7F2
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 18:13:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243071AbjFMQNU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 12:13:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243023AbjFMQNH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 12:13:07 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9627F19B5;
        Tue, 13 Jun 2023 09:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686672777; x=1718208777;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VlsDfQe6xmJuoENKAKaKljnxwQolewMVS9540jaiQmg=;
  b=YIadR5RAi7pEJc1edHgAcgyzTJHimKJhsCb9fFYStoRmaR5G8dzlgcZS
   rPW6mvlPDnf3ehUKXt1rKOCFwhWqh/P9Jks1JQxB76IHr0OZuXJrPbbo5
   OYqBuulkLYj8Y6r0nXUxX+mH7rjIIw4qgCWES4VClSGuJe/AOaRqT5yTw
   71zQkNK6yC5rgMzYMozf6uN2wqhp6Z8505kjQNzaWhgiRbSpHX/kkzcnq
   t8QG7W3X+FNmvv19+7mCyxhZzd8j7103wfFoqHax1A6sUWaEpq5je5uHh
   nj20pbJ6kK3f0AboHL7oSrZkvK/7xFst7BQzufM8rseL5weztBu3IxvS2
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="348038920"
X-IronPort-AV: E=Sophos;i="6.00,240,1681196400"; 
   d="scan'208";a="348038920"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2023 09:11:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="714863579"
X-IronPort-AV: E=Sophos;i="6.00,240,1681196400"; 
   d="scan'208";a="714863579"
Received: from powerlab.fi.intel.com ([10.237.71.25])
  by fmsmga007.fm.intel.com with ESMTP; 13 Jun 2023 09:11:09 -0700
From:   Michal Wilczynski <michal.wilczynski@intel.com>
To:     linux-acpi@vger.kernel.org
Cc:     rafael@kernel.org, andriy.shevchenko@intel.com,
        artem.bityutskiy@linux.intel.com, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, lenb@kernel.org,
        jgross@suse.com, linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [PATCH v3 5/5] acpi: Remove acpi_hwp_native_thermal_lvt_osc()
Date:   Tue, 13 Jun 2023 19:10:34 +0300
Message-Id: <20230613161034.3496047-6-michal.wilczynski@intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230613161034.3496047-1-michal.wilczynski@intel.com>
References: <20230613161034.3496047-1-michal.wilczynski@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Workaround for buggy skylake BIOS is implemented in acpi_processor_osc()
and acpi_hwp_native_thermal_lvt_osc() function is not called anywhere.
Remove it.

Suggested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Michal Wilczynski <michal.wilczynski@intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/acpi/acpi_processor.c | 35 -----------------------------------
 1 file changed, 35 deletions(-)

diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processor.c
index 8965e01406e0..1e305ad9540e 100644
--- a/drivers/acpi/acpi_processor.c
+++ b/drivers/acpi/acpi_processor.c
@@ -634,41 +634,6 @@ static acpi_status __init acpi_processor_osc(acpi_handle handle, u32 lvl,
 	return AE_OK;
 }
 
-static acpi_status __init acpi_hwp_native_thermal_lvt_osc(acpi_handle handle,
-							  u32 lvl,
-							  void *context,
-							  void **rv)
-{
-	u32 capbuf[2];
-	struct acpi_osc_context osc_context = {
-		.uuid_str = sb_uuid_str,
-		.rev = 1,
-		.cap.length = 8,
-		.cap.pointer = capbuf,
-	};
-
-	if (acpi_hwp_native_thermal_lvt_set)
-		return AE_CTRL_TERMINATE;
-
-	capbuf[0] = 0x0000;
-	capbuf[1] = 0x1000; /* set bit 12 */
-
-	if (ACPI_SUCCESS(acpi_run_osc(handle, &osc_context))) {
-		if (osc_context.ret.pointer && osc_context.ret.length > 1) {
-			u32 *capbuf_ret = osc_context.ret.pointer;
-
-			if (capbuf_ret[1] & 0x1000) {
-				acpi_handle_info(handle,
-					"_OSC native thermal LVT Acked\n");
-				acpi_hwp_native_thermal_lvt_set = true;
-			}
-		}
-		kfree(osc_context.ret.pointer);
-	}
-
-	return AE_OK;
-}
-
 acpi_status __init acpi_early_processor_osc(void)
 {
 	acpi_status status;
-- 
2.41.0

