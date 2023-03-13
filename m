Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA1206B8040
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 19:20:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230338AbjCMSUJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 14:20:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230252AbjCMSTh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 14:19:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C05B6F622
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 11:19:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A376461474
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 18:19:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4B6DC43444;
        Mon, 13 Mar 2023 18:19:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1678731557;
        bh=pNN6vmAhlLeMrf2ujoqLuBmzLLZa1C/GmAzQf4erYdc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=p9nQh+fNYAEzJllAphqQT79qmfi5RCzLuhXoTNuoKxuOjdS+AuAPhrUTlY2/7wdcg
         FPRGg3o3OEIom/IW3qI5//4WdSeygeeR/aLfMTo85BJWh1n9QDLprCzH2E2HBtfieS
         +9zY+8TSC4YHMUA7kLGVhsWA4dboWv7sHZ07O/Gw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     rafael@kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 07/12] driver core: class: make class_find_device*() options const
Date:   Mon, 13 Mar 2023 19:18:38 +0100
Message-Id: <20230313181843.1207845-7-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230313181843.1207845-1-gregkh@linuxfoundation.org>
References: <20230313181843.1207845-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4271; i=gregkh@linuxfoundation.org; h=from:subject; bh=pNN6vmAhlLeMrf2ujoqLuBmzLLZa1C/GmAzQf4erYdc=; b=owGbwMvMwCRo6H6F97bub03G02pJDCn8mUxcc3uvyRV8TPty7PJlvubv3154hG7NvvDzrd7Ms uNyL8LWdMSyMAgyMciKKbJ82cZzdH/FIUUvQ9vTMHNYmUCGMHBxCsBE7k1nWDAxpOPfNkfW7tQP 0/9s3RS58jvn+SkM80z+qs+0582pnddWvOLf27wQkx3fDwIA
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

The class_find_device*() functions do not modify the struct class or the
struct device passed into it, so mark them as const * to enforce that.

Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/base/class.c         |  2 +-
 include/linux/device/class.h | 25 ++++++++++++-------------
 2 files changed, 13 insertions(+), 14 deletions(-)

diff --git a/drivers/base/class.c b/drivers/base/class.c
index 4937d660c571..52ba0187e66d 100644
--- a/drivers/base/class.c
+++ b/drivers/base/class.c
@@ -402,7 +402,7 @@ EXPORT_SYMBOL_GPL(class_for_each_device);
  * @match is allowed to do anything including calling back into class
  * code.  There's no locking restriction.
  */
-struct device *class_find_device(struct class *class, struct device *start,
+struct device *class_find_device(const struct class *class, const struct device *start,
 				 const void *data,
 				 int (*match)(struct device *, const void *))
 {
diff --git a/include/linux/device/class.h b/include/linux/device/class.h
index fdbcd487e508..dfa8958105e7 100644
--- a/include/linux/device/class.h
+++ b/include/linux/device/class.h
@@ -112,8 +112,8 @@ extern void class_dev_iter_exit(struct class_dev_iter *iter);
 extern int class_for_each_device(const struct class *class, const struct device *start,
 				 void *data,
 				 int (*fn)(struct device *dev, void *data));
-extern struct device *class_find_device(struct class *class,
-					struct device *start, const void *data,
+extern struct device *class_find_device(const struct class *class,
+					const struct device *start, const void *data,
 					int (*match)(struct device *, const void *));
 
 /**
@@ -122,7 +122,7 @@ extern struct device *class_find_device(struct class *class,
  * @class: class type
  * @name: name of the device to match
  */
-static inline struct device *class_find_device_by_name(struct class *class,
+static inline struct device *class_find_device_by_name(const struct class *class,
 						       const char *name)
 {
 	return class_find_device(class, NULL, name, device_match_name);
@@ -134,8 +134,8 @@ static inline struct device *class_find_device_by_name(struct class *class,
  * @class: class type
  * @np: of_node of the device to match.
  */
-static inline struct device *
-class_find_device_by_of_node(struct class *class, const struct device_node *np)
+static inline struct device *class_find_device_by_of_node(const struct class *class,
+							  const struct device_node *np)
 {
 	return class_find_device(class, NULL, np, device_match_of_node);
 }
@@ -146,9 +146,8 @@ class_find_device_by_of_node(struct class *class, const struct device_node *np)
  * @class: class type
  * @fwnode: fwnode of the device to match.
  */
-static inline struct device *
-class_find_device_by_fwnode(struct class *class,
-			    const struct fwnode_handle *fwnode)
+static inline struct device *class_find_device_by_fwnode(const struct class *class,
+							 const struct fwnode_handle *fwnode)
 {
 	return class_find_device(class, NULL, fwnode, device_match_fwnode);
 }
@@ -159,7 +158,7 @@ class_find_device_by_fwnode(struct class *class,
  * @class: class type
  * @devt: device type of the device to match.
  */
-static inline struct device *class_find_device_by_devt(struct class *class,
+static inline struct device *class_find_device_by_devt(const struct class *class,
 						       dev_t devt)
 {
 	return class_find_device(class, NULL, &devt, device_match_devt);
@@ -173,14 +172,14 @@ struct acpi_device;
  * @class: class type
  * @adev: ACPI_COMPANION device to match.
  */
-static inline struct device *
-class_find_device_by_acpi_dev(struct class *class, const struct acpi_device *adev)
+static inline struct device *class_find_device_by_acpi_dev(const struct class *class,
+							   const struct acpi_device *adev)
 {
 	return class_find_device(class, NULL, adev, device_match_acpi_dev);
 }
 #else
-static inline struct device *
-class_find_device_by_acpi_dev(struct class *class, const void *adev)
+static inline struct device *class_find_device_by_acpi_dev(const struct class *class,
+							   const void *adev)
 {
 	return NULL;
 }
-- 
2.39.2

