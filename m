Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21A8572C904
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 16:56:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237729AbjFLO4B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 10:56:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232090AbjFLOz6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 10:55:58 -0400
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18759C5
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 07:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1686581758;
  x=1718117758;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=b0xZhbVJ2iDdtRWYPfdkFa5rLtdBa+vfP9oTAzuy6e4=;
  b=P2WbVqd9KKCgC5jBn9eQ8tBvK3HcYsw02czxeykj84roLiEBFuESA0+H
   Gv3YhNvblsChW08mrhoy9kSV9peeCdTTodtKBOMYKkZMqz5OxCaNofqN4
   0Ve8krnmqLtIRk+K6qsUqen9tgXFkibu8ofCfqOkrCDP8hE40dhBoDz66
   JG6cB7nXDFWadxuJ3JwV18Fn7/RNr3vgol1qsu+qFlsSv4eFTXLq9e48r
   5EMRj2V+htM5/hHhK8Q65aZ1f6NaD0X/O55XzM78oDXXpEF59CAdOZvlf
   UV/qH6JNEsnr+wrj14e8JxE9kcGFMxnAZkiOdE4ALrpOPTqgmsFmp6Cfn
   Q==;
User-agent: a.out
From:   Waqar Hameed <waqar.hameed@axis.com>
To:     Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <kernel@axis.com>
Subject: [PATCH] regmap: Add debugfs file for forcing field writes
Date:   Mon, 12 Jun 2023 16:53:35 +0200
Message-ID: <pndttvcu3ut.fsf@axis.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.0.5.60]
X-ClientProxiedBy: se-mail02w.axis.com (10.20.40.8) To se-mail01w.axis.com
 (10.20.40.7)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

`_regmap_update_bits` checks if the current register value differs from
the new value, and only writes to the register if they differ. When
testing hardware drivers, it might be desirable to always force a
register write, for example when writing to a `regmap_field`.

This enables and simplifies testing and verification of the hardware
interaction. For example, when using a hardware mock/simulation model,
one can then more easily verify that the driver makes the correct
expected register writes during certain events. Add a bool variable
`force_write_field` and a corresponding debugfs entry.

Signed-off-by: Waqar Hameed <waqarh@axis.com>
---
 drivers/base/regmap/internal.h       | 3 +++
 drivers/base/regmap/regmap-debugfs.c | 3 +++
 drivers/base/regmap/regmap.c         | 2 +-
 3 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/base/regmap/internal.h b/drivers/base/regmap/internal.h
index 9bd0dfd1e259..6472b3222b82 100644
--- a/drivers/base/regmap/internal.h
+++ b/drivers/base/regmap/internal.h
@@ -125,6 +125,9 @@ struct regmap {
 	int reg_stride;
 	int reg_stride_order;
 
+	/* If set, will always write field to HW. */
+	bool force_write_field;
+
 	/* regcache specific members */
 	const struct regcache_ops *cache_ops;
 	enum regcache_type cache_type;
diff --git a/drivers/base/regmap/regmap-debugfs.c b/drivers/base/regmap/regmap-debugfs.c
index c491fabe3617..ed677eb10063 100644
--- a/drivers/base/regmap/regmap-debugfs.c
+++ b/drivers/base/regmap/regmap-debugfs.c
@@ -636,6 +636,9 @@ void regmap_debugfs_init(struct regmap *map)
 				    &regmap_cache_bypass_fops);
 	}
 
+	debugfs_create_bool("force_write_field", 0600, map->debugfs,
+			    &map->force_write_field);
+
 	next = rb_first(&map->range_tree);
 	while (next) {
 		range_node = rb_entry(next, struct regmap_range_node, node);
diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index fa2d3fba6ac9..89b701ceb43f 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -3273,7 +3273,7 @@ static int _regmap_update_bits(struct regmap *map, unsigned int reg,
 		tmp = orig & ~mask;
 		tmp |= val & mask;
 
-		if (force_write || (tmp != orig)) {
+		if (force_write || (tmp != orig) || map->force_write_field) {
 			ret = _regmap_write(map, reg, tmp);
 			if (ret == 0 && change)
 				*change = true;

base-commit: 858fd168a95c5b9669aac8db6c14a9aeab446375
-- 
2.30.2

