Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBACB622F7C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 16:57:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230374AbiKIP5G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 10:57:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230347AbiKIP5E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 10:57:04 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAC9211C36;
        Wed,  9 Nov 2022 07:57:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668009423; x=1699545423;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=yG5W+euZHxEU00+gNIBSv0ub1RDo6lvAbXS9KYbHbdI=;
  b=mNFbFjWxEkFLY+SUAJ+CcV9pAFlDq0g/YxCsyIzKiKzlOKMorpDeo+rj
   f42/ANV/TFgR8VhfCgkAmPJTvgMdgUpBXr2zywDwOYItsC53mlhPpLUmK
   z1XYZZt5nhU8joDB6ZEk1ju2E7YGWsmR313F6ovujMZtQ9YqLAZ2uGFDK
   v7/ymCwQeL36AUpUDEF1LTCTC4rX39VS1GGPab9qGfWl/zj05OX3N1JGk
   GgFip/IpDCMRjw/8H9emN8hIEyeMM8ThkqHyMKpGUbChUCXQbvMtbT0Vq
   SlTiLSkn6h0GAKswId6zPvwC3uBz4D9cW34nYMkCk3geUV2jeIfBralkN
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10526"; a="337751663"
X-IronPort-AV: E=Sophos;i="5.96,151,1665471600"; 
   d="scan'208";a="337751663"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2022 07:57:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10526"; a="636789555"
X-IronPort-AV: E=Sophos;i="5.96,151,1665471600"; 
   d="scan'208";a="636789555"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 09 Nov 2022 07:57:01 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 5A5B7155; Wed,  9 Nov 2022 17:57:25 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v1 1/1] pinctrl: Move for_each_maps() to namespace and hide iterator inside
Date:   Wed,  9 Nov 2022 17:57:24 +0200
Message-Id: <20221109155724.42354-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

First of all, while for_each_maps() is private to pin control subsystem
it's still better to have it put into a namespace.

Besides that, users are not relying on iterator variable, so hide it
inside for-loop.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pinctrl/core.c |  6 ++----
 drivers/pinctrl/core.h | 10 +++++-----
 2 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/pinctrl/core.c b/drivers/pinctrl/core.c
index 9e57f4c62e60..f2f99972a0d3 100644
--- a/drivers/pinctrl/core.c
+++ b/drivers/pinctrl/core.c
@@ -1028,7 +1028,6 @@ static struct pinctrl *create_pinctrl(struct device *dev,
 	struct pinctrl *p;
 	const char *devname;
 	struct pinctrl_maps *maps_node;
-	int i;
 	const struct pinctrl_map *map;
 	int ret;
 
@@ -1054,7 +1053,7 @@ static struct pinctrl *create_pinctrl(struct device *dev,
 
 	mutex_lock(&pinctrl_maps_mutex);
 	/* Iterate over the pin control maps to locate the right ones */
-	for_each_maps(maps_node, i, map) {
+	for_each_pin_map(maps_node, map) {
 		/* Map must be for this device */
 		if (strcmp(map->dev_name, devname))
 			continue;
@@ -1805,13 +1804,12 @@ static inline const char *map_type(enum pinctrl_map_type type)
 static int pinctrl_maps_show(struct seq_file *s, void *what)
 {
 	struct pinctrl_maps *maps_node;
-	int i;
 	const struct pinctrl_map *map;
 
 	seq_puts(s, "Pinctrl maps:\n");
 
 	mutex_lock(&pinctrl_maps_mutex);
-	for_each_maps(maps_node, i, map) {
+	for_each_pin_map(maps_node, map) {
 		seq_printf(s, "device %s\nstate %s\ntype %s (%d)\n",
 			   map->dev_name, map->name, map_type(map->type),
 			   map->type);
diff --git a/drivers/pinctrl/core.h b/drivers/pinctrl/core.h
index 840103c40c14..8b90b4f0bc7e 100644
--- a/drivers/pinctrl/core.h
+++ b/drivers/pinctrl/core.h
@@ -242,8 +242,8 @@ extern int pinctrl_force_default(struct pinctrl_dev *pctldev);
 extern struct mutex pinctrl_maps_mutex;
 extern struct list_head pinctrl_maps;
 
-#define for_each_maps(_maps_node_, _i_, _map_) \
-	list_for_each_entry(_maps_node_, &pinctrl_maps, node) \
-		for (_i_ = 0, _map_ = &_maps_node_->maps[_i_]; \
-			_i_ < _maps_node_->num_maps; \
-			_i_++, _map_ = &_maps_node_->maps[_i_])
+#define for_each_pin_map(_maps_node_, _map_)						\
+	list_for_each_entry(_maps_node_, &pinctrl_maps, node)				\
+		for (unsigned int __i = 0;						\
+		     _map_ = &_maps_node_->maps[__i], __i < _maps_node_->num_maps;	\
+		     __i++)
-- 
2.35.1

