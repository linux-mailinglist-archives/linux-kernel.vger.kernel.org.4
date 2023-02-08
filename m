Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1200C68ED97
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 12:17:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230207AbjBHLPP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 06:15:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230396AbjBHLOa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 06:14:30 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E018E241C2
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 03:14:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 99662B81BA8
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 11:14:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF0DEC433EF;
        Wed,  8 Feb 2023 11:14:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1675854867;
        bh=p5TTPOpWMWq5eEE+GU3lcGME3666+d2rAuul7YL7CAE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zxvfNV5WPLQBgbzqn565uqsBJEha3bjIJ5kSEq+28IuUCP0JrWAIhot3mKdaAKJSP
         KJpOp1EwcJtemoqN5NAvNfdXal4jThM+crHRrpOt7CM8DNrs+RzR2NGCxPxP9we473
         8tMTGcCS38FhWcKV7n8dW+AU1VDXJYtscfR2XvYE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH 04/21] driver core: bus: convert bus_create/remove_file to be constant
Date:   Wed,  8 Feb 2023 12:13:13 +0100
Message-Id: <20230208111330.439504-5-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230208111330.439504-1-gregkh@linuxfoundation.org>
References: <20230208111330.439504-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2643; i=gregkh@linuxfoundation.org; h=from:subject; bh=p5TTPOpWMWq5eEE+GU3lcGME3666+d2rAuul7YL7CAE=; b=owGbwMvMwCRo6H6F97bub03G02pJDMmPm681v7OQLHOfuedP5eplAjdjXf+pxnafPv7tgaDCIuNS /ntmHbEsDIJMDLJiiixftvEc3V9xSNHL0PY0zBxWJpAhDFycAjARD0WGBY2J+16cZuhnmqX1l2068+ 7k8/+cdzEs2Je5X9BvT8nnq+tCU4oTfbi5t/TsAQA=
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

bus_create_file() and bus_remove_file() can be made to take a constant
bus pointer, as it should not be modifying anything in the bus
structure.  Make this change and move the functions to use the internal
subsys_get/put() logic as well, to prevent the use of the back-pointer
in struct bus_type.

Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/base/bus.c         | 28 +++++++++++++++++-----------
 include/linux/device/bus.h |  5 ++---
 2 files changed, 19 insertions(+), 14 deletions(-)

diff --git a/drivers/base/bus.c b/drivers/base/bus.c
index 7949302663f9..8debbe00b4ca 100644
--- a/drivers/base/bus.c
+++ b/drivers/base/bus.c
@@ -175,24 +175,30 @@ static const struct sysfs_ops bus_sysfs_ops = {
 	.store	= bus_attr_store,
 };
 
-int bus_create_file(struct bus_type *bus, struct bus_attribute *attr)
+int bus_create_file(const struct bus_type *bus, struct bus_attribute *attr)
 {
+	struct subsys_private *sp = bus_to_subsys(bus);
 	int error;
-	if (bus_get(bus)) {
-		error = sysfs_create_file(&bus->p->subsys.kobj, &attr->attr);
-		bus_put(bus);
-	} else
-		error = -EINVAL;
+
+	if (!sp)
+		return -EINVAL;
+
+	error = sysfs_create_file(&sp->subsys.kobj, &attr->attr);
+
+	subsys_put(sp);
 	return error;
 }
 EXPORT_SYMBOL_GPL(bus_create_file);
 
-void bus_remove_file(struct bus_type *bus, struct bus_attribute *attr)
+void bus_remove_file(const struct bus_type *bus, struct bus_attribute *attr)
 {
-	if (bus_get(bus)) {
-		sysfs_remove_file(&bus->p->subsys.kobj, &attr->attr);
-		bus_put(bus);
-	}
+	struct subsys_private *sp = bus_to_subsys(bus);
+
+	if (!sp)
+		return;
+
+	sysfs_remove_file(&sp->subsys.kobj, &attr->attr);
+	subsys_put(sp);
 }
 EXPORT_SYMBOL_GPL(bus_remove_file);
 
diff --git a/include/linux/device/bus.h b/include/linux/device/bus.h
index f0c8bf91b07a..f6537f5fc535 100644
--- a/include/linux/device/bus.h
+++ b/include/linux/device/bus.h
@@ -135,9 +135,8 @@ struct bus_attribute {
 #define BUS_ATTR_WO(_name) \
 	struct bus_attribute bus_attr_##_name = __ATTR_WO(_name)
 
-extern int __must_check bus_create_file(struct bus_type *,
-					struct bus_attribute *);
-extern void bus_remove_file(struct bus_type *, struct bus_attribute *);
+int __must_check bus_create_file(const struct bus_type *bus, struct bus_attribute *attr);
+void bus_remove_file(const struct bus_type *bus, struct bus_attribute *attr);
 
 /* Generic device matching functions that all busses can use to match with */
 int device_match_name(struct device *dev, const void *name);
-- 
2.39.1

