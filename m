Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 380746B9D02
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 18:28:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229748AbjCNR2l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 13:28:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbjCNR2j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 13:28:39 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36C1930EAD;
        Tue, 14 Mar 2023 10:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678814917; x=1710350917;
  h=from:to:cc:subject:date:message-id;
  bh=DaQNsZPNuwEZmQfv4ilWdbGgK7Acovm7M+l1yC6x52w=;
  b=Q7awHz96/bdxnfWtK03TKuqnsrk44W618mOS2KnspoHum9kyhP+Hg+l0
   npGK3BHFz3ohGzFl++byxuId7eb2W7r1r4t4Zz/G+dmZnj7W1JR6D0ECI
   OtK0gaqXuAVZDHhu3VPGeVCn7LsnchX2rYdThHT7aGjDU8eVdY8KIDXQQ
   Kj+OosNe1H8aEsnj1sY/5o27UxPruBtHfO1EK+tO5JWeDCbeOvY4yYPPq
   m94gqVy3ZVKFaVJMsgrojhW2hKFRZrq39GNBLTcA5LJq+Yfe5Sv5xl3ra
   dDisUtI4NMv9HcSkbo0dQj88eX61Z16TPG9HctL9obhRp984BLpSIjCmk
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10649"; a="339036762"
X-IronPort-AV: E=Sophos;i="5.98,260,1673942400"; 
   d="scan'208";a="339036762"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2023 10:28:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10649"; a="748090937"
X-IronPort-AV: E=Sophos;i="5.98,260,1673942400"; 
   d="scan'208";a="748090937"
Received: from wopr.jf.intel.com ([10.54.75.136])
  by fmsmga004.fm.intel.com with ESMTP; 14 Mar 2023 10:28:35 -0700
From:   Todd Brandt <todd.e.brandt@intel.com>
To:     linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     todd.e.brandt@linux.intel.com, todd.e.brandt@intel.com,
        srinivas.pandruvada@linux.intel.com, jic23@kernel.org,
        jikos@kernel.org, p.jungkamp@gmx.net
Subject: [PATCH v3] HID:hid-sensor-custom: Fix buffer overrun in device name
Date:   Tue, 14 Mar 2023 10:28:34 -0700
Message-Id: <20230314172834.13175-1-todd.e.brandt@intel.com>
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

On some platforms there are some platform devices created with
invalid names. For example: "HID-SENSOR-INT-020b?.39.auto" instead
of "HID-SENSOR-INT-020b.39.auto"

This string include some invalid characters, hence it will fail to
properly load the driver which will handle this custom sensor. Also
it is a problem for some user space tools, which parses the device
names from ftrace and dmesg.

This is because the string, real_usage, is not NULL terminated and
printed with %s to form device name.

To address this, initialize the real_usage string with 0s.

Reported-and-tested-by: Todd Brandt <todd.e.brandt@linux.intel.com>
Link: https://bugzilla.kernel.org/show_bug.cgi?id=217169
Suggested-by: Philipp Jungkamp <p.jungkamp@gmx.net>
Signed-off-by: Philipp Jungkamp <p.jungkamp@gmx.net>
Signed-off-by: Todd Brandt <todd.e.brandt@intel.com>
Reviewed-by: Andi Shyti <andi.shyti@kernel.org>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
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

