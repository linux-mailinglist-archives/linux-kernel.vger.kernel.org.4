Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D01FA6B847C
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 23:07:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbjCMWG6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 18:06:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbjCMWG5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 18:06:57 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10FEA3AAB;
        Mon, 13 Mar 2023 15:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678745216; x=1710281216;
  h=from:to:cc:subject:date:message-id;
  bh=pxSJXOAP6+FkS4KwMiPDKrgeUrDK7Fjyk3nrgSzvo5Y=;
  b=eJJADclN1iYXvdqD6SyljyipXeVL9VCHaM0oWQ51T7OeAA6GTTxH2NfX
   9HMdoO1ZxWKfN2603+Gpq2/0xQli+DRhyYp0TUYRkIs0uFql/F5UJVy7N
   ydxb9F2xYnPFDO8ft3k7l0wgBLpI3cY3AAcO/Xcy8PR1CAWVuG+a9SNEs
   dfkonGFnIgAkrAN5+5pGdjO2AvDmvdF0IQAgbRSmvFmvt93Qsk8SEog1D
   98II3XTJ4GoWInPdRcB311Azr/YrVxhvIwB46t5vCDA8GMUN8H/7ALAAB
   gct178QiziSSlQUQMsuEFAJ8X9exv99Xm6tLE8uxPQM+pzpNiTStaf5N4
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10648"; a="402142779"
X-IronPort-AV: E=Sophos;i="5.98,258,1673942400"; 
   d="scan'208";a="402142779"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2023 15:06:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10648"; a="822117433"
X-IronPort-AV: E=Sophos;i="5.98,258,1673942400"; 
   d="scan'208";a="822117433"
Received: from wopr.jf.intel.com ([10.54.75.136])
  by fmsmga001.fm.intel.com with ESMTP; 13 Mar 2023 15:06:54 -0700
From:   Todd Brandt <todd.e.brandt@intel.com>
To:     linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     todd.e.brandt@linux.intel.com, todd.e.brandt@intel.com,
        srinivas.pandruvada@linux.intel.com, jic23@kernel.org,
        jikos@kernel.org, p.jungkamp@gmx.net
Subject: [PATCH v2] Fix buffer overrun in HID-SENSOR name string
Date:   Mon, 13 Mar 2023 15:06:53 -0700
Message-Id: <20230313220653.3996-1-todd.e.brandt@intel.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On some platforms there are some platform devices created with
invalid names. For example: "HID-SENSOR-INT-020b?.39.auto" instead
of "HID-SENSOR-INT-020b.39.auto"

This string include some invalid characters, hence it will fail to
properly load the driver which will handle this custom sensor. Also
it is a problem for some user space tools, which parse the device
names from ftrace and dmesg.

This is because the string, real_usage, is not NULL terminated and
printed with %s to form device name.

To address this, we initialize the real_usage string with 0s.

Philipp Jungkamp created this fix, I'm simply submitting it. I've
verified it fixes bugzilla issue 217169

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

