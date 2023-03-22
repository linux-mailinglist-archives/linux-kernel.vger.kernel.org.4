Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 459A26C4DFE
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 15:40:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231835AbjCVOj5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 10:39:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231539AbjCVOj0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 10:39:26 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE7B454C8D
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 07:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679495965; x=1711031965;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hoaAx9Ps+XUntb1eapTod1FMgNK7hAJfzIEXEA74T44=;
  b=YowXbGbEuwMX3f3a+dXoyeNhKZCY7RyzQ84gWM0B3rFMryNud0dY9XJD
   enltDkzUTVghWNzucsQ1nZZV9DXJTunY86/LCQAzZrPFssxp34j8BtYSP
   hprXPEsKev+DVovGO/SlklR0zO/7IcymTWTRbeTsSZvWDAYHM6256Ojf+
   /mstvdtC3W7Siwh12wClIz8mL1zcldGBrabwD8h6LURdVEkudilGoFmVE
   ouhNNpuLp5edowb929o/ljdq9PH+4qxgMuod07GjqFQ+Let8X63LznfAe
   Zr08nYBufeFUct0RFY+usN+7ulDQVaC+YSGYyjGBWpYaPCc9N6yebTsdm
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10657"; a="319622128"
X-IronPort-AV: E=Sophos;i="5.98,282,1673942400"; 
   d="scan'208";a="319622128"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2023 07:39:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10657"; a="856116428"
X-IronPort-AV: E=Sophos;i="5.98,282,1673942400"; 
   d="scan'208";a="856116428"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 22 Mar 2023 07:39:23 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 11EC0A53; Wed, 22 Mar 2023 16:40:07 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bumwoo Lee <bw365.lee@samsung.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCH v1 13/14] extcon: Drop unneeded assignments
Date:   Wed, 22 Mar 2023 16:40:04 +0200
Message-Id: <20230322144005.40368-14-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
In-Reply-To: <20230322144005.40368-1-andriy.shevchenko@linux.intel.com>
References: <20230322144005.40368-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In one case the assignment is duplicative, in the other,
it's better to move it into the loop — the user of it.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/extcon/extcon.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/extcon/extcon.c b/drivers/extcon/extcon.c
index b3f038639cd6..edfa0450e605 100644
--- a/drivers/extcon/extcon.c
+++ b/drivers/extcon/extcon.c
@@ -246,7 +246,7 @@ static DEFINE_MUTEX(extcon_dev_list_lock);
 
 static int check_mutually_exclusive(struct extcon_dev *edev, u32 new_state)
 {
-	int i = 0;
+	int i;
 
 	if (!edev->mutually_exclusive)
 		return 0;
@@ -1244,7 +1244,7 @@ static int extcon_alloc_groups(struct extcon_dev *edev)
  */
 int extcon_dev_register(struct extcon_dev *edev)
 {
-	int ret, index = 0;
+	int ret, index;
 
 	ret = create_extcon_class();
 	if (ret < 0)
@@ -1253,7 +1253,7 @@ int extcon_dev_register(struct extcon_dev *edev)
 	if (!edev || !edev->supported_cable)
 		return -EINVAL;
 
-	for (; edev->supported_cable[index] != EXTCON_NONE; index++);
+	for (index = 0; edev->supported_cable[index] != EXTCON_NONE; index++);
 
 	edev->max_supported = index;
 	if (index > SUPPORTED_CABLE_MAX) {
-- 
2.40.0.1.gaa8946217a0b

