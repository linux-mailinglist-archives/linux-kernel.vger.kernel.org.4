Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 617E66259F2
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 13:00:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233519AbiKKMAf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 07:00:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233624AbiKKMAb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 07:00:31 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 638506C729;
        Fri, 11 Nov 2022 04:00:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668168030; x=1699704030;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=cEBkqBhvlhdSqicQY8nR684nIxo/8KEjEshZzsYziO0=;
  b=CcZLXpThBV/PTBLEj+R4NSBINrjvPGxWLEBNwBQ6fs3wwqYRmH79on1h
   4VgLwNqzbX1zjh+A6dGzDPaTXcfm2BYo8dII+ykwTHaLMcssYliE1q8Cm
   pYHjRcQLBoNAUNHrUwhW1ox+djn1zVuz3lH4Z8mAIWMki6KGUmH1krY3g
   JwZEsUCJsvpbWTyB3cNUfZAKoC6A20x42vYOJ59n87vpUSXjkw7Gdn+3r
   jvhdqmrim8O9sQISi4nmuyFLYBb5whJwyyDYh4CnyscbWHtEpVRDTHEzN
   5FWbTnBg9R0urTlCPWKfZvkVN7UkbPAtUkL1gIhCIzXaD8+R7lfcanlyC
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10527"; a="291304590"
X-IronPort-AV: E=Sophos;i="5.96,156,1665471600"; 
   d="scan'208";a="291304590"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2022 04:00:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10527"; a="780157656"
X-IronPort-AV: E=Sophos;i="5.96,156,1665471600"; 
   d="scan'208";a="780157656"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 11 Nov 2022 04:00:29 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 4F0F5155; Fri, 11 Nov 2022 14:00:53 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v2 1/1] pinctrl: Move for_each_maps() to namespace and hide iterator inside
Date:   Fri, 11 Nov 2022 14:00:48 +0200
Message-Id: <20221111120048.42968-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
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

First of all, while for_each_maps() is private to pin control subsystem
it's still better to have it put into a namespace.

Besides that, users are not relying on iterator variable, so hide it
inside for-loop.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: shuffled conditional to avoid NULL dereference
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
index 840103c40c14..35f3e84dd61b 100644
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
+		     __i < _maps_node_->num_maps && (_map_ = &_maps_node_->maps[__i]);	\
+		     __i++)
-- 
2.35.1

