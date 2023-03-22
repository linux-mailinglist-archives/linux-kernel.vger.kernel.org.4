Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0106B6C4DFA
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 15:40:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231680AbjCVOjq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 10:39:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231515AbjCVOj0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 10:39:26 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7B31457C6
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 07:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679495964; x=1711031964;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=N33rpjnGQ5ytOuxHzIh25HaIghid6HPaz5R86OU5umw=;
  b=WTC5LQ6u9ge+YN+DIcNShgymbnWsvNdtEw9GiVHte+8uBX/2q2WxSo5G
   nnLDpfaXTGtKl26N8p5OJBlQ8HVOPgE6dAQzTHN+WW5LzTIPyBdHjUEzm
   iMQF8PoU3KImUfQe3kjDGqFua0FwhVn4y6pdo0BR141jJVQovlIxBzfDu
   q6I1LqpJmBaUPSpTLjdwC1khnRFIZmrkl0GE+YAcZgccMiLOcemYrvAQV
   yVS2hkQiy8H1WsgrRJ2JFf32FzzTZZ+luPW/RXdimMLHqZu/McllacfIz
   p2VFO+s5rJwOFVz6bFI+5x0PMcxR2e9v63cnqni9J1bM+wBDQW/tgd0AW
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10657"; a="319622124"
X-IronPort-AV: E=Sophos;i="5.98,282,1673942400"; 
   d="scan'208";a="319622124"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2023 07:39:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10657"; a="856116427"
X-IronPort-AV: E=Sophos;i="5.98,282,1673942400"; 
   d="scan'208";a="856116427"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 22 Mar 2023 07:39:23 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id DE874942; Wed, 22 Mar 2023 16:40:06 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bumwoo Lee <bw365.lee@samsung.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCH v1 09/14] extcon: Use device_match_of_node() helper
Date:   Wed, 22 Mar 2023 16:40:00 +0200
Message-Id: <20230322144005.40368-10-andriy.shevchenko@linux.intel.com>
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

Instead of open coding, use device_match_of_node() helper.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/extcon/extcon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/extcon/extcon.c b/drivers/extcon/extcon.c
index a63e7eef02fd..5cadbfc151e6 100644
--- a/drivers/extcon/extcon.c
+++ b/drivers/extcon/extcon.c
@@ -1411,7 +1411,7 @@ struct extcon_dev *extcon_find_edev_by_node(struct device_node *node)
 
 	mutex_lock(&extcon_dev_list_lock);
 	list_for_each_entry(edev, &extcon_dev_list, entry)
-		if (edev->dev.parent && edev->dev.parent->of_node == node)
+		if (edev->dev.parent && device_match_of_node(edev->dev.parent, node))
 			goto out;
 	edev = ERR_PTR(-EPROBE_DEFER);
 out:
-- 
2.40.0.1.gaa8946217a0b

