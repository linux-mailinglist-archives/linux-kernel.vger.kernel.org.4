Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 254B47462D6
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 20:52:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231459AbjGCSwn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 14:52:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231230AbjGCSw3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 14:52:29 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 297F5E64;
        Mon,  3 Jul 2023 11:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688410349; x=1719946349;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AOpwNXsh/T5AKgW2rwkqtZXdctnpIN5g1+lx5hcu/eQ=;
  b=IHKIiGLepKLudKGOFXzXDpHnMJqntvszdLp6yyQo+wx3Or0X3HgsJnic
   YuaazsoTyPeZNxNW7eL5s5ZESQsPun8eU+xOLVEpbGrEFgQ+znqCEaIib
   tSNNTurhwZMNirBnsDd4AOGIjphfWLL0VxCa89/CBXpODSuuj5YH2Pekf
   YYwV6cCFGuHHamTVVv7eHz8fzgXwSemxnwGgtHDeoc1lISxMohXumHsXx
   bRCXg/TjGYXrGe89lv4bvBumeHr8lCSayWLSbSnMnKDvfsChHCMvdvrFg
   iGbEyRR5614v0rogVzNJ2yqAAn0Jzv31alNRbYYnNMasFtRG17fQzEew4
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10760"; a="362986970"
X-IronPort-AV: E=Sophos;i="6.01,178,1684825200"; 
   d="scan'208";a="362986970"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2023 11:52:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10760"; a="721860814"
X-IronPort-AV: E=Sophos;i="6.01,178,1684825200"; 
   d="scan'208";a="721860814"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 03 Jul 2023 11:52:26 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 9C8D369F; Mon,  3 Jul 2023 21:52:27 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Andy Shevchenko <andy@kernel.org>
Subject: [PATCH v1 10/12] HID: cp2112: Use sysfs_emit() to instead of scnprintf()
Date:   Mon,  3 Jul 2023 21:52:20 +0300
Message-Id: <20230703185222.50554-11-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
In-Reply-To: <20230703185222.50554-1-andriy.shevchenko@linux.intel.com>
References: <20230703185222.50554-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Follow the advice of the Documentation/filesystems/sysfs.rst and show()
should only use sysfs_emit() or sysfs_emit_at() when formatting the
value to be returned to user space.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/hid/hid-cp2112.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/hid-cp2112.c b/drivers/hid/hid-cp2112.c
index 2eebb2b19501..1e45f5407d09 100644
--- a/drivers/hid/hid-cp2112.c
+++ b/drivers/hid/hid-cp2112.c
@@ -893,7 +893,7 @@ static ssize_t name##_show(struct device *kdev, \
 	int ret = cp2112_get_usb_config(hdev, &cfg); \
 	if (ret) \
 		return ret; \
-	return scnprintf(buf, PAGE_SIZE, format, ##__VA_ARGS__); \
+	return sysfs_emit(buf, format, ##__VA_ARGS__); \
 } \
 static DEVICE_ATTR_RW(name);
 
-- 
2.40.0.1.gaa8946217a0b

