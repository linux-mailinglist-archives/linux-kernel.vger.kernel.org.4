Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EA8A6D81D4
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 17:28:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238565AbjDEP2n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 11:28:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237974AbjDEP2e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 11:28:34 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D61083C3E
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 08:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680708512; x=1712244512;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tQcZfnW0s5Te2GMdRZ+as8NovZGN837gxEAnvgXa0Ik=;
  b=K+TtFo7OJ1eW9qXqYOw+7/kYQa1qDWfK3FfZy05V/zu5niqUZUBz4Qfu
   FkkPU1Gxq8WFyzB+a/1Gh6A2f2jYNKma0uU+iF5OUDmVhkfjYIyUN0Y3p
   Vp7ZeBuSOXSVbMD7oiJKUm5W0buAJZnMM3TPkbYKu38N0SHfQvmac4eAO
   MAB7fidPHvNeFrTo3ZM2eHYAGQc95UbkQrrgzkynOpJUSRKFD27vFvg2A
   iAqLd5YDqWyYKcngrSBs63UvIFg7xmSIMVpfQFVhuGCOgoFgRheZTCC0t
   p7v3JzPP4DKpIG2Gxk5vHIwadxHGXtUWY+T/MsCZqkxsmGb9B824Aq28M
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10671"; a="345064784"
X-IronPort-AV: E=Sophos;i="5.98,321,1673942400"; 
   d="scan'208";a="345064784"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2023 08:27:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10671"; a="756028446"
X-IronPort-AV: E=Sophos;i="5.98,321,1673942400"; 
   d="scan'208";a="756028446"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 05 Apr 2023 08:27:52 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id C4D7F206; Wed,  5 Apr 2023 18:27:52 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Chanwoo Choi <cw00.choi@samsung.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Bumwoo Lee <bw365.lee@samsung.com>
Subject: [PATCH v2 5/5] extcon: Drop unneeded assignments
Date:   Wed,  5 Apr 2023 18:27:45 +0300
Message-Id: <20230405152745.24959-6-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
In-Reply-To: <20230405152745.24959-1-andriy.shevchenko@linux.intel.com>
References: <20230405152745.24959-1-andriy.shevchenko@linux.intel.com>
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
Acked-by: Bumwoo Lee <bw365.lee@samsung.com>
---
 drivers/extcon/extcon.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/extcon/extcon.c b/drivers/extcon/extcon.c
index 50c5fd454488..88ce0656d23c 100644
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

