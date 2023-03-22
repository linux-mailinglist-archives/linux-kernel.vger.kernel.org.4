Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 919486C4DFF
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 15:40:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231861AbjCVOkA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 10:40:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231560AbjCVOj2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 10:39:28 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E5905FEAB
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 07:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679495966; x=1711031966;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mmz2iv76okOwpVenPFn6EHP4R2cbAkp+w1ZBuPRcRrI=;
  b=dH1tx7ZBnq2ocjMA4zKKKcauKCfFH8/HAkCNBGktQ+hvVgIci7CZM8wj
   ro4I18u2BjVqcxFHLt33fjoJkLN9jbHkRHVD2UjN1aCzWhda4XcreuvjD
   DzhkAkAUSwbAJ00HuDXN30W4+ApgEnf5QEUT/pMdXCRAuB43Hhandf6gk
   29ODE6UUbc3+IeuWDYsYGIo2V363zrf8laG7GbHw0Yb0YDdIU6trTAd2X
   V1pxrVmQooiusdk7l+4fnfJSCHezGePg27b61QJvBE3nWpQcwwE9OsOsE
   0/4DMf9dYUlQTO5MafqNUC3naVHbQYosqIstiMp3N8lkZpV5g+AgzTTpC
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10657"; a="319622131"
X-IronPort-AV: E=Sophos;i="5.98,282,1673942400"; 
   d="scan'208";a="319622131"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2023 07:39:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10657"; a="856116430"
X-IronPort-AV: E=Sophos;i="5.98,282,1673942400"; 
   d="scan'208";a="856116430"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 22 Mar 2023 07:39:23 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 171C7A43; Wed, 22 Mar 2023 16:40:07 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bumwoo Lee <bw365.lee@samsung.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCH v1 14/14] extcon: Use positive conditional in ternary operator
Date:   Wed, 22 Mar 2023 16:40:05 +0200
Message-Id: <20230322144005.40368-15-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
In-Reply-To: <20230322144005.40368-1-andriy.shevchenko@linux.intel.com>
References: <20230322144005.40368-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's easier to parse by a human being the positive conditional.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/extcon/extcon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/extcon/extcon.c b/drivers/extcon/extcon.c
index edfa0450e605..3e8522d522b4 100644
--- a/drivers/extcon/extcon.c
+++ b/drivers/extcon/extcon.c
@@ -1466,7 +1466,7 @@ EXPORT_SYMBOL_GPL(extcon_get_edev_by_phandle);
  */
 const char *extcon_get_edev_name(struct extcon_dev *edev)
 {
-	return !edev ? NULL : edev->name;
+	return edev ? edev->name : NULL;
 }
 EXPORT_SYMBOL_GPL(extcon_get_edev_name);
 
-- 
2.40.0.1.gaa8946217a0b

