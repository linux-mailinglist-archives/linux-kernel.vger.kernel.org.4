Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80F9A68D608
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 12:55:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230378AbjBGLzj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 06:55:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230075AbjBGLzi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 06:55:38 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37DEEF752
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 03:55:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675770937; x=1707306937;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=NPSeJg67C/t1SF3qeTToYhur69IWS2YZ3kLNFAJ6JA8=;
  b=ZbHc0aHJmbjYWTbkfigm95fIkMuynVT7X5cqpRq5rUMtvI/fAjkhMUNQ
   KwgF8QvlG2Wivyiy6Geve1VRIePC7XqJdZG3XONejdKptNXNxhw12lqX9
   LkzEeuCggXNl2BOmPxYHckaCXqHGGjVChqGKPQLCPQSeXQrDGWR3QkqH9
   bTZOSdeUYHdE4fOU5HFhEUOrXN1ZsAWjiK83hnzmHPLjyOORbla0mp0kl
   rk7iSHPekWtOcvJr9s7Ds7bipS+TJLfieNM07vJX2wuQ8oTQi36NAPHkx
   nlMsPPS8UAdSxVGsVF85oIDJ4L4NpmLIa0b9HQyxqFs0+PRJLZqWoehPW
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="329504586"
X-IronPort-AV: E=Sophos;i="5.97,278,1669104000"; 
   d="scan'208";a="329504586"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2023 03:55:36 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="995703023"
X-IronPort-AV: E=Sophos;i="5.97,278,1669104000"; 
   d="scan'208";a="995703023"
Received: from twinkler-lnx.jer.intel.com ([10.12.87.42])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2023 03:55:34 -0800
From:   Tomas Winkler <tomas.winkler@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Alexander Usyskin <alexander.usyskin@intel.com>,
        Vitaly Lubart <vitaly.lubart@intel.com>,
        linux-kernel@vger.kernel.org,
        Tomas Winkler <tomas.winkler@intel.com>
Subject: [char-misc-next 1/2] mei: bus: disallow driver match while dismantling device
Date:   Tue,  7 Feb 2023 13:55:19 +0200
Message-Id: <20230207115520.846232-1-tomas.winkler@intel.com>
X-Mailer: git-send-email 2.39.1
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

From: Alexander Usyskin <alexander.usyskin@intel.com>

With immediate reply support to enum request and
FW reset, a device on MEI bus can be temporarily removed.
A driver for a device on MEI bus can try to bind to the device
right between bus attempt to remove driver and device
structures removal.
This leaves device driver with pointers to freed memory
of device structures.

Avoid bus device driver bind while dismantling device by
disallowing device match right before driver release.

Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
---
 drivers/misc/mei/bus.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/mei/bus.c b/drivers/misc/mei/bus.c
index a81b890c7ee6..71d53d7ffdba 100644
--- a/drivers/misc/mei/bus.c
+++ b/drivers/misc/mei/bus.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * Copyright (c) 2012-2019, Intel Corporation. All rights reserved.
+ * Copyright (c) 2012-2023, Intel Corporation. All rights reserved.
  * Intel Management Engine Interface (Intel MEI) Linux driver
  */
 
@@ -1392,6 +1392,7 @@ static int mei_cl_bus_dev_add(struct mei_cl_device *cldev)
  */
 static void mei_cl_bus_dev_stop(struct mei_cl_device *cldev)
 {
+	cldev->do_match = 0;
 	if (cldev->is_added)
 		device_release_driver(&cldev->dev);
 }
-- 
2.39.1

