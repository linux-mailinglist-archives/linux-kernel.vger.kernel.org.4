Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 204E26DDA07
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 13:49:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230178AbjDKLtM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 07:49:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230130AbjDKLtD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 07:49:03 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84D6DA3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 04:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681213735; x=1712749735;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Gdags1M6Medyo7CL5SRzy4P8BpRShQdkhod4NJbc6wU=;
  b=WWZZhQFkwZw+vohf/mLTxvkNt9+eK3UTMCL+1yeUq60bP6pOf31dQqad
   TRrUn3NgEbXghbLmA4e0V6+eX9RMl4V4KyeEDh6rq7PeUujBI+lGigMve
   4AhaWl+1irPpXTl9vei6MARwpZJx8kF5Bte5uZbdQ/uyf2BAz/FuZ4gU8
   HM59YBLERCdEzoV6ZmXcBCqMoLXOvu6LMM1BAW6skZBMZOrmR9AlzzM7P
   D46noATzZuHcT/RmJnINoJ0itTSe3J/f/M7+wKcXJPXB/XDp9qtNK92Oj
   1H3uiMeRAZ5ZPiCeLhOk3KnJrt/Xihzb9A379amIJG60PGUr17xYuLYG3
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10676"; a="343600836"
X-IronPort-AV: E=Sophos;i="5.98,336,1673942400"; 
   d="scan'208";a="343600836"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2023 04:48:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10676"; a="777888102"
X-IronPort-AV: E=Sophos;i="5.98,336,1673942400"; 
   d="scan'208";a="777888102"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 11 Apr 2023 04:48:23 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 4F7306FC; Tue, 11 Apr 2023 14:48:26 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Chanwoo Choi <cw00.choi@samsung.com>,
        Bumwoo Lee <bw365.lee@samsung.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>
Subject: [PATCH v3 3/3] extcon: Drop unneeded assignments
Date:   Tue, 11 Apr 2023 14:48:24 +0300
Message-Id: <20230411114824.82960-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
In-Reply-To: <20230411114824.82960-1-andriy.shevchenko@linux.intel.com>
References: <20230411114824.82960-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In one case the assignment is duplicative, in the other,
it's better to move it into the loop — the user of it.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 drivers/extcon/extcon.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/extcon/extcon.c b/drivers/extcon/extcon.c
index 76dc41e8f250..6f7a60d2ed91 100644
--- a/drivers/extcon/extcon.c
+++ b/drivers/extcon/extcon.c
@@ -245,7 +245,7 @@ static DEFINE_MUTEX(extcon_dev_list_lock);
 
 static int check_mutually_exclusive(struct extcon_dev *edev, u32 new_state)
 {
-	int i = 0;
+	int i;
 
 	if (!edev->mutually_exclusive)
 		return 0;
@@ -1246,7 +1246,7 @@ static int extcon_alloc_groups(struct extcon_dev *edev)
  */
 int extcon_dev_register(struct extcon_dev *edev)
 {
-	int ret, index = 0;
+	int ret, index;
 
 	ret = create_extcon_class();
 	if (ret < 0)
@@ -1255,7 +1255,7 @@ int extcon_dev_register(struct extcon_dev *edev)
 	if (!edev || !edev->supported_cable)
 		return -EINVAL;
 
-	for (; edev->supported_cable[index] != EXTCON_NONE; index++);
+	for (index = 0; edev->supported_cable[index] != EXTCON_NONE; index++);
 
 	edev->max_supported = index;
 	if (index > SUPPORTED_CABLE_MAX) {
-- 
2.40.0.1.gaa8946217a0b

