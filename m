Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 542046D81D1
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 17:28:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238300AbjDEP2e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 11:28:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237974AbjDEP2c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 11:28:32 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33C8A5FC3
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 08:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680708499; x=1712244499;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JO0f1r6wRzpw2LpD2oOXpMFojPtpUquOfRT3bCgNfuI=;
  b=fZIEyajYax7/ymILgEkjfEufZs+1PvwVHM207kIjnGjiMKSNwugAOIWb
   tNrs3hQFCXSxrwBAf95CRaQSxak/i6IitU61qZDYcg3swvZXpCOKfmA//
   ktWCklVdBlMm1ll6O16GwWOF+EZ8lm61fAtBBpw4r/YyGpAuaS3cHY31f
   I7TpeLbL10+PwlpyoAZDnG7gPCCALTIqnYRviRwjt1D3Lxf//OgxAw+OB
   W38MtiTOILMbAO17ERKn4eLNfyer5oxLjpsW3Mc8RS6TCSr1nk4WXpHOq
   F2swCH1VL+Udj/zcrnqIfCp3vaEa06d0d0+bP6nb6Vp97XHhatvw6T28i
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10671"; a="345064762"
X-IronPort-AV: E=Sophos;i="5.98,321,1673942400"; 
   d="scan'208";a="345064762"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2023 08:27:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10671"; a="756028426"
X-IronPort-AV: E=Sophos;i="5.98,321,1673942400"; 
   d="scan'208";a="756028426"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 05 Apr 2023 08:27:50 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id A176F87; Wed,  5 Apr 2023 18:27:52 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Chanwoo Choi <cw00.choi@samsung.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>
Subject: [PATCH v2 1/5] extcon: Make the allocation and freeing to be private calls
Date:   Wed,  5 Apr 2023 18:27:41 +0300
Message-Id: <20230405152745.24959-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
In-Reply-To: <20230405152745.24959-1-andriy.shevchenko@linux.intel.com>
References: <20230405152745.24959-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The extcon_dev_allocate() and extcon_dev_free() are not used
outside of the extcon framework. Moreover, the struct extcon_dev
can't be filled outside of the framework either after allocation.
The registration part, for instance, requires a parent device to
be set and that's done in the devm_extcon_dev_allocate() wrapper.

Taking the above into account, sumply move the mentioned APIs to
the private headers.

Alternatively, the pointer to the parent device can be added to
the extcon_dev_allocate(), but since there are no users and magnitude
of the change it makes a little sense to go this way.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/extcon/extcon.h         | 4 ++++
 include/linux/extcon-provider.h | 9 ---------
 2 files changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/extcon/extcon.h b/drivers/extcon/extcon.h
index 15616446140d..49e4ed9f6450 100644
--- a/drivers/extcon/extcon.h
+++ b/drivers/extcon/extcon.h
@@ -63,4 +63,8 @@ struct extcon_dev {
 	struct device_attribute *d_attrs_muex;
 };
 
+/* Following APIs allocate/free the memory of the extcon device. */
+struct extcon_dev *extcon_dev_allocate(const unsigned int *cable);
+void extcon_dev_free(struct extcon_dev *edev);
+
 #endif /* __LINUX_EXTCON_INTERNAL_H__ */
diff --git a/include/linux/extcon-provider.h b/include/linux/extcon-provider.h
index fa70945f4e6b..db474ae3c711 100644
--- a/include/linux/extcon-provider.h
+++ b/include/linux/extcon-provider.h
@@ -25,8 +25,6 @@ void devm_extcon_dev_unregister(struct device *dev,
 				struct extcon_dev *edev);
 
 /* Following APIs allocate/free the memory of the extcon device. */
-struct extcon_dev *extcon_dev_allocate(const unsigned int *cable);
-void extcon_dev_free(struct extcon_dev *edev);
 struct extcon_dev *devm_extcon_dev_allocate(struct device *dev,
 				const unsigned int *cable);
 void devm_extcon_dev_free(struct device *dev, struct extcon_dev *edev);
@@ -78,13 +76,6 @@ static inline int devm_extcon_dev_register(struct device *dev,
 static inline void devm_extcon_dev_unregister(struct device *dev,
 				struct extcon_dev *edev) { }
 
-static inline struct extcon_dev *extcon_dev_allocate(const unsigned int *cable)
-{
-	return ERR_PTR(-ENOSYS);
-}
-
-static inline void extcon_dev_free(struct extcon_dev *edev) { }
-
 static inline struct extcon_dev *devm_extcon_dev_allocate(struct device *dev,
 				const unsigned int *cable)
 {
-- 
2.40.0.1.gaa8946217a0b

