Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0726072E269
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 14:03:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242269AbjFMMDd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 08:03:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235323AbjFMMD3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 08:03:29 -0400
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C59D91AC
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 05:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1686657808;
  x=1718193808;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=0M3Bw0Wvlmg09M9Otqtr7gQiKvBD/9rNZgj0Z8luQVA=;
  b=B1pggX0KfEPzMjBeAa5P3gRPVvmWxjYmsFxCvdyOTDRL6aavEywxlkr+
   I/X9LWD/1pziIF5jNnH6EUCkIIrID0DJemAt+rT3iI48cDsn0LTOnK+u3
   03CqcIY2jSOjEbrJI6tU1Af+5/ae3rxYTA9cgcbyokBn1BjNKbVVSPnIv
   dVMWl/wu5y//pMsddgMILytIWxsZRbkrQk12nOix8E/Ia8XZDpYC17ope
   Y7GbiOd7GXkPtTUVgXa0UJeisXMMQUCHBXcVgUJo27nvxqtKR6rHxUp4/
   zFHkEiTzmzfRKJCKmStD0e4mAXcFSh1FOJApfj5TWXx90F76nXgx9WSOC
   A==;
User-agent: a.out
From:   Waqar Hameed <waqar.hameed@axis.com>
To:     Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
CC:     <kernel@axis.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] regmap: Add debugfs file for forcing field writes
Date:   Tue, 13 Jun 2023 13:42:27 +0200
Message-ID: <pnd1qifa7sj.fsf@axis.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.0.5.60]
X-ClientProxiedBy: se-mail02w.axis.com (10.20.40.8) To se-mail01w.axis.com
 (10.20.40.7)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

`_regmap_update_bits()` checks if the current register value differs
from the new value, and only writes to the register if they differ. When
testing hardware drivers, it might be desirable to always force a
register write, for example when writing to a `regmap_field`. This
enables and simplifies testing and verification of the hardware
interaction. For example, when using a hardware mock/simulation model,
one can then more easily verify that the driver makes the correct
expected register writes during certain events.

Add a bool variable `force_write_field` and a corresponding debugfs
entry to enable this. Since this feature could interfere with driver
operation, guard it with a macro.

Signed-off-by: Waqar Hameed <waqar.hameed@axis.com>
---
Changes in v2:
* Add macro to guard the debugfs entry.
* Fix `Signed-off-by` in commit message to match actual email address.
* Link to v1: https://lore.kernel.org/all/pndttvcu3ut.fsf@axis.com/

 drivers/base/regmap/internal.h       |  3 +++
 drivers/base/regmap/regmap-debugfs.c | 11 +++++++++++
 drivers/base/regmap/regmap.c         |  2 +-
 3 files changed, 15 insertions(+), 1 deletion(-)

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
index c491fabe3617..f36027591e1a 100644
--- a/drivers/base/regmap/regmap-debugfs.c
+++ b/drivers/base/regmap/regmap-debugfs.c
@@ -636,6 +636,17 @@ void regmap_debugfs_init(struct regmap *map)
 				    &regmap_cache_bypass_fops);
 	}
 
+	/*
+	 * This could interfere with driver operation. Therefore, don't provide
+	 * any real compile time configuration option for this feature. One will
+	 * have to modify the source code directly in order to use it.
+	 */
+#undef REGMAP_ALLOW_FORCE_WRITE_FIELD_DEBUGFS
+#ifdef REGMAP_ALLOW_FORCE_WRITE_FIELD_DEBUGFS
+	debugfs_create_bool("force_write_field", 0600, map->debugfs,
+			    &map->force_write_field);
+#endif
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

