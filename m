Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28A07692EAC
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 07:33:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229657AbjBKGdY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Feb 2023 01:33:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbjBKGdQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Feb 2023 01:33:16 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E320B7B390;
        Fri, 10 Feb 2023 22:33:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676097187; x=1707633187;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fqW8c5N27aHnEIPv6D4igbjXtAZiZeCdbG59Y48XwDY=;
  b=AELmavOkTsPCMZMd2OYD8zrYfTFhZPKCp/w+/gnXE8K1tkR0/gnQvoR/
   8r/gaU/raaYVRq3Kq4A1FBs0kyukC1E7pHHX2p7ERBETatEWBjJI83ixh
   RWRVSfEDZ+Gb2sdvXVQcf2HN/XNJpXwVwfDjNMg+7hXMUsn4GuLbcuuax
   mPLTgH7zgt8pPs+L4N4KEYHt92meaQMldwiHol6tiGYQ7DRcz8I3YXPKg
   GQJGZ3I5o/tNuNFyJxl6EEdpUAS3OOEUmmDuYwf+zitVwtgplNrQL8rpg
   EMFrvljTAkgFEp/f/OT6SM7Br/haA1EM7GAjalt5pvhCbiOIj11eysej+
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10617"; a="310223201"
X-IronPort-AV: E=Sophos;i="5.97,289,1669104000"; 
   d="scan'208";a="310223201"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2023 22:33:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10617"; a="997171763"
X-IronPort-AV: E=Sophos;i="5.97,289,1669104000"; 
   d="scan'208";a="997171763"
Received: from spandruv-desk.jf.intel.com ([10.54.75.8])
  by fmsmga005.fm.intel.com with ESMTP; 10 Feb 2023 22:33:00 -0800
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     hdegoede@redhat.com, markgross@kernel.org
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 03/12] platform/x86: ISST: Add IOCTL default callback
Date:   Fri, 10 Feb 2023 22:32:48 -0800
Message-Id: <20230211063257.311746-4-srinivas.pandruvada@linux.intel.com>
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

The common IOCTL handler has a predefined list of of IOCTLs it can
handle. There is no default handler, if there is no match.

Allow a client driver to define their own version of default IOCTL
callback. In this way the default handling is passed to the client
drivers to handle.

With the introduction of TPMI target, IOCTL list is extended. The
additional TPMI specific IOCTLs will be passed to the TPMI client
driver default IOCTL handler.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 .../x86/intel/speed_select_if/isst_if_common.c        | 11 +++++++++++
 .../x86/intel/speed_select_if/isst_if_common.h        |  4 ++++
 2 files changed, 15 insertions(+)

diff --git a/drivers/platform/x86/intel/speed_select_if/isst_if_common.c b/drivers/platform/x86/intel/speed_select_if/isst_if_common.c
index 63d49fe17a16..9fef955bdedc 100644
--- a/drivers/platform/x86/intel/speed_select_if/isst_if_common.c
+++ b/drivers/platform/x86/intel/speed_select_if/isst_if_common.c
@@ -588,6 +588,7 @@ static long isst_if_def_ioctl(struct file *file, unsigned int cmd,
 	struct isst_if_cmd_cb cmd_cb;
 	struct isst_if_cmd_cb *cb;
 	long ret = -ENOTTY;
+	int i;
 
 	switch (cmd) {
 	case ISST_IF_GET_PLATFORM_INFO:
@@ -616,6 +617,16 @@ static long isst_if_def_ioctl(struct file *file, unsigned int cmd,
 		ret = isst_if_exec_multi_cmd(argp, &cmd_cb);
 		break;
 	default:
+		for (i = 0; i < ISST_IF_DEV_MAX; ++i) {
+			struct isst_if_cmd_cb *cb = &punit_callbacks[i];
+			int ret;
+
+			if (cb->def_ioctl) {
+				ret = cb->def_ioctl(file, cmd, arg);
+				if (!ret)
+					return ret;
+			}
+		}
 		break;
 	}
 
diff --git a/drivers/platform/x86/intel/speed_select_if/isst_if_common.h b/drivers/platform/x86/intel/speed_select_if/isst_if_common.h
index 967c338e83c5..34a172e5c82c 100644
--- a/drivers/platform/x86/intel/speed_select_if/isst_if_common.h
+++ b/drivers/platform/x86/intel/speed_select_if/isst_if_common.h
@@ -48,6 +48,8 @@
  *		response to user ioctl buffer. The "resume" argument
  *		can be used to avoid storing the command for replay
  *		during system resume
+ * @def_ioctl:	Default IOCTL handler callback, if there is no match in
+ *		the existing list of IOCTL handled by the common handler.
  *
  * This structure is used to register an handler for IOCTL. To avoid
  * code duplication common code handles all the IOCTL command read/write
@@ -58,8 +60,10 @@ struct isst_if_cmd_cb {
 	int registered;
 	int cmd_size;
 	int offset;
+
 	struct module *owner;
 	long (*cmd_callback)(u8 *ptr, int *write_only, int resume);
+	long (*def_ioctl)(struct file *file, unsigned int cmd, unsigned long arg);
 };
 
 /* Internal interface functions */
-- 
2.39.1

