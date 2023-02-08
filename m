Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C302568ED99
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 12:17:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbjBHLPJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 06:15:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230393AbjBHLO2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 06:14:28 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4895D241C2
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 03:14:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F0A55B81C6E
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 11:14:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C963C433EF;
        Wed,  8 Feb 2023 11:14:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1675854864;
        bh=TOoBHRJOzCGVRVJMF+VNnmRGTtaa/I1PGR2BmvFohxQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IWzPXXYkxEU7IjiKwb3CX/jIiAIpbuFzGbwgc8dSKGaLmUqv+XqQBVW71YtDX6Uhw
         ynvkqAwqsz/O53/dOX7se79WltvCh7HJikeNULi3PmZwUSmAHxfO/QooX7EFnqkMOJ
         hOd2VWycIBPDAedbT1HDU1VtgzqVc+wWaTgEXXt4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH 03/21] driver core: bus: constantify the bus_find_* functions
Date:   Wed,  8 Feb 2023 12:13:12 +0100
Message-Id: <20230208111330.439504-4-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230208111330.439504-1-gregkh@linuxfoundation.org>
References: <20230208111330.439504-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5718; i=gregkh@linuxfoundation.org; h=from:subject; bh=TOoBHRJOzCGVRVJMF+VNnmRGTtaa/I1PGR2BmvFohxQ=; b=owGbwMvMwCRo6H6F97bub03G02pJDMmPm69NOeolek3v2/csMc1bIh+rJ0kcVPhlKPfnZfH6Ty3u mSliHbEsDIJMDLJiiixftvEc3V9xSNHL0PY0zBxWJpAhDFycAjCRv7cY5pe9maZ+297zcvGNB2ytp6 6IBVzb3cowv/we74SDt9w39DR4zS6ySKx7KF1rAgA=
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All of the bus find and iterator functions do not modify the struct
bus_type passed to them, so mark them as constant to enforce this rule.

Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/base/bus.c         |  6 +++---
 include/linux/device/bus.h | 20 ++++++++++----------
 2 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/base/bus.c b/drivers/base/bus.c
index d346afa4645c..7949302663f9 100644
--- a/drivers/base/bus.c
+++ b/drivers/base/bus.c
@@ -331,7 +331,7 @@ static struct device *next_device(struct klist_iter *i)
  * to retain this data, it should do so, and increment the reference
  * count in the supplied callback.
  */
-int bus_for_each_dev(struct bus_type *bus, struct device *start,
+int bus_for_each_dev(const struct bus_type *bus, struct device *start,
 		     void *data, int (*fn)(struct device *, void *))
 {
 	struct klist_iter i;
@@ -365,7 +365,7 @@ EXPORT_SYMBOL_GPL(bus_for_each_dev);
  * if it does.  If the callback returns non-zero, this function will
  * return to the caller and not iterate over any more devices.
  */
-struct device *bus_find_device(struct bus_type *bus,
+struct device *bus_find_device(const struct bus_type *bus,
 			       struct device *start, const void *data,
 			       int (*match)(struct device *dev, const void *data))
 {
@@ -416,7 +416,7 @@ static struct device_driver *next_driver(struct klist_iter *i)
  * in the callback. It must also be sure to increment the refcount
  * so it doesn't disappear before returning to the caller.
  */
-int bus_for_each_drv(struct bus_type *bus, struct device_driver *start,
+int bus_for_each_drv(const struct bus_type *bus, struct device_driver *start,
 		     void *data, int (*fn)(struct device_driver *, void *))
 {
 	struct klist_iter i;
diff --git a/include/linux/device/bus.h b/include/linux/device/bus.h
index e3094db1e9fa..f0c8bf91b07a 100644
--- a/include/linux/device/bus.h
+++ b/include/linux/device/bus.h
@@ -149,9 +149,9 @@ int device_match_acpi_handle(struct device *dev, const void *handle);
 int device_match_any(struct device *dev, const void *unused);
 
 /* iterator helpers for buses */
-int bus_for_each_dev(struct bus_type *bus, struct device *start, void *data,
+int bus_for_each_dev(const struct bus_type *bus, struct device *start, void *data,
 		     int (*fn)(struct device *dev, void *data));
-struct device *bus_find_device(struct bus_type *bus, struct device *start,
+struct device *bus_find_device(const struct bus_type *bus, struct device *start,
 			       const void *data,
 			       int (*match)(struct device *dev, const void *data));
 /**
@@ -161,7 +161,7 @@ struct device *bus_find_device(struct bus_type *bus, struct device *start,
  * @start: Device to begin with
  * @name: name of the device to match
  */
-static inline struct device *bus_find_device_by_name(struct bus_type *bus,
+static inline struct device *bus_find_device_by_name(const struct bus_type *bus,
 						     struct device *start,
 						     const char *name)
 {
@@ -175,7 +175,7 @@ static inline struct device *bus_find_device_by_name(struct bus_type *bus,
  * @np: of_node of the device to match.
  */
 static inline struct device *
-bus_find_device_by_of_node(struct bus_type *bus, const struct device_node *np)
+bus_find_device_by_of_node(const struct bus_type *bus, const struct device_node *np)
 {
 	return bus_find_device(bus, NULL, np, device_match_of_node);
 }
@@ -187,7 +187,7 @@ bus_find_device_by_of_node(struct bus_type *bus, const struct device_node *np)
  * @fwnode: fwnode of the device to match.
  */
 static inline struct device *
-bus_find_device_by_fwnode(struct bus_type *bus, const struct fwnode_handle *fwnode)
+bus_find_device_by_fwnode(const struct bus_type *bus, const struct fwnode_handle *fwnode)
 {
 	return bus_find_device(bus, NULL, fwnode, device_match_fwnode);
 }
@@ -198,7 +198,7 @@ bus_find_device_by_fwnode(struct bus_type *bus, const struct fwnode_handle *fwno
  * @bus: bus type
  * @devt: device type of the device to match.
  */
-static inline struct device *bus_find_device_by_devt(struct bus_type *bus,
+static inline struct device *bus_find_device_by_devt(const struct bus_type *bus,
 						     dev_t devt)
 {
 	return bus_find_device(bus, NULL, &devt, device_match_devt);
@@ -211,7 +211,7 @@ static inline struct device *bus_find_device_by_devt(struct bus_type *bus,
  * @cur: device to begin the search with.
  */
 static inline struct device *
-bus_find_next_device(struct bus_type *bus,struct device *cur)
+bus_find_next_device(const struct bus_type *bus,struct device *cur)
 {
 	return bus_find_device(bus, cur, NULL, device_match_any);
 }
@@ -226,19 +226,19 @@ struct acpi_device;
  * @adev: ACPI COMPANION device to match.
  */
 static inline struct device *
-bus_find_device_by_acpi_dev(struct bus_type *bus, const struct acpi_device *adev)
+bus_find_device_by_acpi_dev(const struct bus_type *bus, const struct acpi_device *adev)
 {
 	return bus_find_device(bus, NULL, adev, device_match_acpi_dev);
 }
 #else
 static inline struct device *
-bus_find_device_by_acpi_dev(struct bus_type *bus, const void *adev)
+bus_find_device_by_acpi_dev(const struct bus_type *bus, const void *adev)
 {
 	return NULL;
 }
 #endif
 
-int bus_for_each_drv(struct bus_type *bus, struct device_driver *start,
+int bus_for_each_drv(const struct bus_type *bus, struct device_driver *start,
 		     void *data, int (*fn)(struct device_driver *, void *));
 void bus_sort_breadthfirst(struct bus_type *bus,
 			   int (*compare)(const struct device *a,
-- 
2.39.1

