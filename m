Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F966692EAE
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 07:33:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbjBKGd0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Feb 2023 01:33:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbjBKGdQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Feb 2023 01:33:16 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 015C87BFE5;
        Fri, 10 Feb 2023 22:33:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676097188; x=1707633188;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0JlOSadLZTIZHVM2qZRsqf/jURAo7n/PnYciNcJuWpE=;
  b=kEooXt9mIrz2e1z3jN5WwQLb0RRV6RyZBbp9ilVJ0BZCA5mcAyOCkLK8
   fHYHiqR3MkntYvP3Of0k/Mu9pUpwEQWzo4ekqx1xQWkgivVZKIw3AXlRB
   lfct8/ihBBDCgpCHCeK/tYddSlRTaEbAs56w2QBYKjKrLOs+h0rsnDarc
   gOYrNPNsUTkd9JPgfCgeUOTVeoZx9h7pDX9l6pa6tgwqDjEdHbpjcBdfv
   GMkPW3LcytuTgNPmYZ7NyQh1+DvCjMNFJhwxvQ1XXcNffvmpmBsKwlN6J
   WV457b7Ve0zh4SVvY2w1HydxCOIa/zCMAO8cwL4PQugik3XoxWSplx5cq
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10617"; a="310223204"
X-IronPort-AV: E=Sophos;i="5.97,289,1669104000"; 
   d="scan'208";a="310223204"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2023 22:33:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10617"; a="997171764"
X-IronPort-AV: E=Sophos;i="5.97,289,1669104000"; 
   d="scan'208";a="997171764"
Received: from spandruv-desk.jf.intel.com ([10.54.75.8])
  by fmsmga005.fm.intel.com with ESMTP; 10 Feb 2023 22:33:01 -0800
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     hdegoede@redhat.com, markgross@kernel.org
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 04/12] platform/x86: ISST: Add API version of the target
Date:   Fri, 10 Feb 2023 22:32:49 -0800
Message-Id: <20230211063257.311746-5-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230211063257.311746-1-srinivas.pandruvada@linux.intel.com>
References: <20230211063257.311746-1-srinivas.pandruvada@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

User space can get the API version using IOCTL
ISST_IF_GET_PLATFORM_INFO. This information can be used to get IOCTLs
supported by the kernel driver. This version is hardcoded in the driver.

Allow the registered client to specify the supported API version. In
this way a registered client can specify a higher API version to extend
IOCTL set.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 .../platform/x86/intel/speed_select_if/isst_if_common.c   | 8 +++++++-
 .../platform/x86/intel/speed_select_if/isst_if_common.h   | 3 ++-
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/intel/speed_select_if/isst_if_common.c b/drivers/platform/x86/intel/speed_select_if/isst_if_common.c
index 9fef955bdedc..60e58b0b3835 100644
--- a/drivers/platform/x86/intel/speed_select_if/isst_if_common.c
+++ b/drivers/platform/x86/intel/speed_select_if/isst_if_common.c
@@ -262,11 +262,13 @@ bool isst_if_mbox_cmd_set_req(struct isst_if_mbox_cmd *cmd)
 }
 EXPORT_SYMBOL_GPL(isst_if_mbox_cmd_set_req);
 
+static int isst_if_api_version;
+
 static int isst_if_get_platform_info(void __user *argp)
 {
 	struct isst_if_platform_info info;
 
-	info.api_version = ISST_IF_API_VERSION;
+	info.api_version = isst_if_api_version;
 	info.driver_version = ISST_IF_DRIVER_VERSION;
 	info.max_cmds_per_ioctl = ISST_IF_CMD_LIMIT;
 	info.mbox_supported = punit_callbacks[ISST_IF_DEV_MBOX].registered;
@@ -767,6 +769,10 @@ int isst_if_cdev_register(int device_type, struct isst_if_cmd_cb *cb)
 		mutex_unlock(&punit_misc_dev_open_lock);
 		return -EAGAIN;
 	}
+	if (!cb->api_version)
+		cb->api_version = ISST_IF_API_VERSION;
+	if (cb->api_version > isst_if_api_version)
+		isst_if_api_version = cb->api_version;
 	memcpy(&punit_callbacks[device_type], cb, sizeof(*cb));
 	punit_callbacks[device_type].registered = 1;
 	mutex_unlock(&punit_misc_dev_open_lock);
diff --git a/drivers/platform/x86/intel/speed_select_if/isst_if_common.h b/drivers/platform/x86/intel/speed_select_if/isst_if_common.h
index 34a172e5c82c..1004f2c9cca8 100644
--- a/drivers/platform/x86/intel/speed_select_if/isst_if_common.h
+++ b/drivers/platform/x86/intel/speed_select_if/isst_if_common.h
@@ -41,6 +41,7 @@
  * @offset:	Offset to the first valid member in command structure.
  *		This will be the offset of the start of the command
  *		after command count field
+ * @api_version: API version supported for this target. 0, if none.
  * @owner:	Registered module owner
  * @cmd_callback: Callback function to handle IOCTL. The callback has the
  *		command pointer with data for command. There is a pointer
@@ -60,7 +61,7 @@ struct isst_if_cmd_cb {
 	int registered;
 	int cmd_size;
 	int offset;
-
+	int api_version;
 	struct module *owner;
 	long (*cmd_callback)(u8 *ptr, int *write_only, int resume);
 	long (*def_ioctl)(struct file *file, unsigned int cmd, unsigned long arg);
-- 
2.39.1

