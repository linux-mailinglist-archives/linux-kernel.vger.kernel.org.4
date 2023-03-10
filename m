Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C93926B560D
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 00:54:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231941AbjCJXyV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 18:54:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231811AbjCJXyS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 18:54:18 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B230129729;
        Fri, 10 Mar 2023 15:54:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678492456; x=1710028456;
  h=from:to:cc:subject:date:message-id;
  bh=A9Zx0Tt3VMmA6kLUzIFNHkmnQLW+8/nbOGOKlR/Y+Ig=;
  b=CC/48PzzYqzYBd+fak/9qP5tsKei9f1+YtKpQa6JJwubE5f71lGrDFzv
   CXUiZxEQC8HKOuC9Hb3eYjvY+B5WmdVVDAO2Sx3mfphYqUHE6/5gD6H/A
   BLwDY1jDwdVnTbpflg62tbfmXDFJ7xNV5JnaD0JBJTMHdFE3Ibkuc8xBf
   /Bp93CriOwRq8KdpmU2jCzsNp0Xp8CxwyNu0IgP3hgXZURINCklzPbHnc
   DbsLZjmHJswyNWrh/jaXz9JaV4fnkbosf6IYlUFsC10thxm7BfYvFqpEw
   nsHnAiByQZid0FqMxnlW3IN2yd+UmSIw/DK455FENk3VkuW9a+DBl6dzR
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10645"; a="325210179"
X-IronPort-AV: E=Sophos;i="5.98,251,1673942400"; 
   d="scan'208";a="325210179"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2023 15:54:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10645"; a="680365645"
X-IronPort-AV: E=Sophos;i="5.98,251,1673942400"; 
   d="scan'208";a="680365645"
Received: from wopr.jf.intel.com ([10.54.75.136])
  by fmsmga007.fm.intel.com with ESMTP; 10 Mar 2023 15:54:15 -0800
From:   Todd Brandt <todd.e.brandt@intel.com>
To:     linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     todd.e.brandt@linux.intel.com, todd.e.brandt@intel.com,
        srinivas.pandruvada@linux.intel.com, jic23@kernel.org,
        jikos@kernel.org, p.jungkamp@gmx.net
Subject: [PATCH] Fix buffer overrun in HID-SENSOR name.
Date:   Fri, 10 Mar 2023 15:54:14 -0800
Message-Id: <20230310235414.12467-1-todd.e.brandt@intel.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Philipp Jungkamp created this fix, I'm simply submitting it. I've
verified it fixes bugzilla issue 217169.

Reported-and-tested-by: Todd Brandt <todd.e.brandt@linux.intel.com>
Link: https://bugzilla.kernel.org/show_bug.cgi?id=217169
Signed-off-by: Todd Brandt <todd.e.brandt@intel.com>
---
 drivers/hid/hid-sensor-custom.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/hid-sensor-custom.c b/drivers/hid/hid-sensor-custom.c
index 3e3f89e01d81..d85398721659 100644
--- a/drivers/hid/hid-sensor-custom.c
+++ b/drivers/hid/hid-sensor-custom.c
@@ -940,7 +940,7 @@ hid_sensor_register_platform_device(struct platform_device *pdev,
 				    struct hid_sensor_hub_device *hsdev,
 				    const struct hid_sensor_custom_match *match)
 {
-	char real_usage[HID_SENSOR_USAGE_LENGTH];
+	char real_usage[HID_SENSOR_USAGE_LENGTH] = { 0 };
 	struct platform_device *custom_pdev;
 	const char *dev_name;
 	char *c;
-- 
2.17.1

