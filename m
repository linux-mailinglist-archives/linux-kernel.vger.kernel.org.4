Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5809C68D609
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 12:55:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231316AbjBGLzl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 06:55:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230203AbjBGLzi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 06:55:38 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C9AAFF3C
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 03:55:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675770938; x=1707306938;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=54ThKiWzsxA8NxNbkvNQzZYgcpzjdfJ722IzAGV96+E=;
  b=mdE3JxAGAwAnZk2QCtWHSPGP4Z/5lneda9MfcIBjOXvogcm190PEBk3H
   d0++cibkhuBYL5hsA+ibAmI6LhTH1kuEX1fXfnc4MVjlgWkEbDMILxVgl
   +YCImT38ivIzL5YJKRCAULi121MW8PPkos6Exqyfa8WJNXhD/GGw2g9aL
   mTTE8Bx9/RxlBMFaRa5zni5lz63e4rceDiasZ6jp5QIW5p9R+4SqqW1xr
   SSnSw/SUQXxbr0CIVfMQBIuCyxHcJ37Fgw8ulTtpGO7n87UrJb32Fy6n0
   +VBtr4O7u0mI+/2OUNxRWs1chkDF/O5OuzpFvtubxdou8c/QwLSnzdw20
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="329504592"
X-IronPort-AV: E=Sophos;i="5.97,278,1669104000"; 
   d="scan'208";a="329504592"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2023 03:55:37 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="995703041"
X-IronPort-AV: E=Sophos;i="5.97,278,1669104000"; 
   d="scan'208";a="995703041"
Received: from twinkler-lnx.jer.intel.com ([10.12.87.42])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2023 03:55:36 -0800
From:   Tomas Winkler <tomas.winkler@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Alexander Usyskin <alexander.usyskin@intel.com>,
        Vitaly Lubart <vitaly.lubart@intel.com>,
        linux-kernel@vger.kernel.org,
        Tomas Winkler <tomas.winkler@intel.com>
Subject: [char-misc-next 2/2] mei: lower the log level for non-fatal failed messages
Date:   Tue,  7 Feb 2023 13:55:20 +0200
Message-Id: <20230207115520.846232-2-tomas.winkler@intel.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230207115520.846232-1-tomas.winkler@intel.com>
References: <20230207115520.846232-1-tomas.winkler@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vitaly Lubart <vitaly.lubart@intel.com>

Some non-fatal log messages should be logged at INFO log level
because failure to send/receive them is not breaking mei functionality
and may happen during legal firmware resets

Signed-off-by: Vitaly Lubart <vitaly.lubart@intel.com>
Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
---
 drivers/misc/mei/bus-fixup.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/misc/mei/bus-fixup.c b/drivers/misc/mei/bus-fixup.c
index 92c0930cc742..211536109308 100644
--- a/drivers/misc/mei/bus-fixup.c
+++ b/drivers/misc/mei/bus-fixup.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * Copyright (c) 2013-2022, Intel Corporation. All rights reserved.
+ * Copyright (c) 2013-2023, Intel Corporation. All rights reserved.
  * Intel Management Engine Interface (Intel MEI) Linux driver
  */
 
@@ -151,7 +151,7 @@ static int mei_fwver(struct mei_cl_device *cldev)
 	ret = __mei_cl_send(cldev->cl, (u8 *)&req, sizeof(req), 0,
 			    MEI_CL_IO_TX_BLOCKING);
 	if (ret < 0) {
-		dev_err(&cldev->dev, "Could not send ReqFWVersion cmd ret = %d\n", ret);
+		dev_info(&cldev->dev, "Could not send ReqFWVersion cmd ret = %d\n", ret);
 		return ret;
 	}
 
@@ -163,7 +163,7 @@ static int mei_fwver(struct mei_cl_device *cldev)
 		 * Should be at least one version block,
 		 * error out if nothing found
 		 */
-		dev_err(&cldev->dev, "Could not read FW version ret = %d\n", bytes_recv);
+		dev_info(&cldev->dev, "Could not read FW version ret = %d\n", bytes_recv);
 		return -EIO;
 	}
 
@@ -220,15 +220,15 @@ static void mei_mkhi_fix(struct mei_cl_device *cldev)
 	if (cldev->bus->fw_f_fw_ver_supported) {
 		ret = mei_fwver(cldev);
 		if (ret < 0)
-			dev_err(&cldev->dev, "FW version command failed %d\n",
-				ret);
+			dev_info(&cldev->dev, "FW version command failed %d\n",
+				 ret);
 	}
 
 	if (cldev->bus->hbm_f_os_supported) {
 		ret = mei_osver(cldev);
 		if (ret < 0)
-			dev_err(&cldev->dev, "OS version command failed %d\n",
-				ret);
+			dev_info(&cldev->dev, "OS version command failed %d\n",
+				 ret);
 	}
 	mei_cldev_disable(cldev);
 }
@@ -247,7 +247,7 @@ static void mei_gsc_mkhi_ver(struct mei_cl_device *cldev)
 
 	ret = mei_fwver(cldev);
 	if (ret < 0)
-		dev_err(&cldev->dev, "FW version command failed %d\n", ret);
+		dev_info(&cldev->dev, "FW version command failed %d\n", ret);
 	mei_cldev_disable(cldev);
 }
 
@@ -278,8 +278,8 @@ static void mei_gsc_mkhi_fix_ver(struct mei_cl_device *cldev)
 
 	ret = mei_fwver(cldev);
 	if (ret < 0)
-		dev_err(&cldev->dev, "FW version command failed %d\n",
-			ret);
+		dev_info(&cldev->dev, "FW version command failed %d\n",
+			 ret);
 out:
 	mei_cldev_disable(cldev);
 }
@@ -403,7 +403,7 @@ static int mei_nfc_if_version(struct mei_cl *cl,
 	memcpy(ver, reply->data, sizeof(*ver));
 
 	dev_info(bus->dev, "NFC MEI VERSION: IVN 0x%x Vendor ID 0x%x Type 0x%x\n",
-		ver->fw_ivn, ver->vendor_id, ver->radio_type);
+		 ver->fw_ivn, ver->vendor_id, ver->radio_type);
 
 err:
 	kfree(reply);
-- 
2.39.1

