Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5A3E6B760A
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 12:32:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbjCMLcd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 07:32:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230111AbjCMLca (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 07:32:30 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D2C76422D
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 04:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678707120; x=1710243120;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=UivkEGPInLDnNTdFK0nK8RYVbLZqhYStdX+Vyiku2DQ=;
  b=A8topW6zxZlOrmnstGXWazVIm7XyxaGy/4uty8U24zewyZGleFqzmDZZ
   4QtVz3LuVgwpyBFm7tOWgWDMqWzdAA4DQq5/9pCCqXvNJeCOh4AQWHX1c
   OdLI42XM+zNGDOspxzHTwM0btufmnkaagqNtg+SSJVguSkbBCnLxeyKwX
   ekTWvfB0cqSZpRRdkakBkq/h2dt+HOSQpvF9xR86xoNOk86JqfDf2Z/DI
   O8zCgJCdEXvXXNRnrnbB99qGVOTvlcrwiHHJFk7ur/TbHLT1+06ljpMrk
   1s3b1DwYcT+JVcc//t2UunFA/HzJoHjn4blT4tvZ6JQfhMDzfkOrnRpQ5
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10647"; a="316769576"
X-IronPort-AV: E=Sophos;i="5.98,256,1673942400"; 
   d="scan'208";a="316769576"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2023 04:30:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10647"; a="671865035"
X-IronPort-AV: E=Sophos;i="5.98,256,1673942400"; 
   d="scan'208";a="671865035"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 13 Mar 2023 04:30:19 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 738ED209; Mon, 13 Mar 2023 13:31:04 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
Subject: [PATCH v1 1/1] devres: Pass unique name of the resource to devm_add_action_or_reset()
Date:   Mon, 13 Mar 2023 13:31:00 +0200
Message-Id: <20230313113100.59643-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.39.2
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

All the same as it's done in the commit e32c80bbd2f9 ("devres:
Pass unique name of the resource to devm_add_action()") applies
to the devm_add_action_or_reset(), which this change makes real.
This helps with debug resource management.

Reported-and-tested-by: Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/device.h | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/include/linux/device.h b/include/linux/device.h
index 0f128520f6e5..12dc08aa5c0f 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -250,17 +250,19 @@ int __devm_add_action(struct device *dev, void (*action)(void *), void *data, co
 #define devm_add_action(release, action, data) \
 	__devm_add_action(release, action, data, #action)
 
-static inline int devm_add_action_or_reset(struct device *dev,
-					   void (*action)(void *), void *data)
+static inline int __devm_add_action_or_reset(struct device *dev, void (*action)(void *),
+					     void *data, const char *name)
 {
 	int ret;
 
-	ret = devm_add_action(dev, action, data);
+	ret = __devm_add_action(dev, action, data, name);
 	if (ret)
 		action(data);
 
 	return ret;
 }
+#define devm_add_action_or_reset(release, action, data) \
+	__devm_add_action_or_reset(release, action, data, #action)
 
 /**
  * devm_alloc_percpu - Resource-managed alloc_percpu
-- 
2.39.2

