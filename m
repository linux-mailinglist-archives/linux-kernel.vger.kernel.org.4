Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09FA06FB465
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 17:52:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234674AbjEHPwR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 11:52:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234439AbjEHPwP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 11:52:15 -0400
Received: from m228-4.mailgun.net (m228-4.mailgun.net [159.135.228.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E20940F3
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 08:51:56 -0700 (PDT)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=equiv.tech; q=dns/txt;
 s=mx; t=1683561115; x=1683568315; h=Content-Transfer-Encoding: MIME-Version:
 Message-Id: Date: Subject: Subject: Cc: To: To: From: From: Sender: Sender;
 bh=EzeSormUv/APmLb2gfl1VbYW9Wt3gs9mSg+do/Wyebs=;
 b=NxGhuOwKwmiDDbzGzgURfB7IquxuMSyKwN+aPmFNK3G5KdgMqisgz2oFd0rTDcH+W06oTfh2wmkLopgti68iotob6Z7cSSF2A4Z9k/jrJkddt8lUwkHF2ej5E1NJKI8EOg0MtBDUHDcwHblF19fyluxFS4HERhobtTN1W/XFjBsKv2u04rX+Cgong471v3OaE+lxoEaI9FHlsi0mLSbR7WjxuRiZLzJsl1NRiMEAhZl6DP0aHgZ783tIWjrCUoebYHzRMzk78C9gyB+01XjvjUHzutWM9TilGXZbza4r4eN4+X4o3EsMEJU8YE5g7W0XLRw6lCq/NuNUr5sgVZQpug==
X-Mailgun-Sending-Ip: 159.135.228.4
X-Mailgun-Sid: WyI4ZWI3MiIsImxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmciLCI5M2Q1YWIiXQ==
Received: from mail.equiv.tech (equiv.tech [142.93.28.83]) by 90bddcf34616 with SMTP id
 64591a9b97a5b02842b7cd3e (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 08 May 2023 15:51:55 GMT
Sender: james@equiv.tech
From:   James Seo <james@equiv.tech>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     James Seo <james@equiv.tech>, linux-kernel@vger.kernel.org
Subject: [PATCH] driver core: device.h: add some missing kerneldocs
Date:   Mon,  8 May 2023 08:48:50 -0700
Message-Id: <20230508154849.1946589-1-james@equiv.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

struct device_attribute, struct dev_ext_attribute, dev_name(), and the
DEVICE_ATTR() macros lack kerneldocs, preventing them from appearing in
the driver core documentation and from being cross-referenced elsewhere.

Add the missing kerneldocs (except for DEVICE_ATTR_IGNORE_LOCKDEP(),
which is only meaningful on debug builds with CONFIG_DEBUG_LOCK_ALLOC
not #defined, and is aliased to DEVICE_ATTR() otherwise).

Signed-off-by: James Seo <james@equiv.tech>
---
 include/linux/device.h | 111 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 110 insertions(+), 1 deletion(-)

diff --git a/include/linux/device.h b/include/linux/device.h
index 472dd24d4823..4e59eda12c88 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -96,7 +96,12 @@ struct device_type {
 	const struct dev_pm_ops *pm;
 };
 
-/* interface for exporting device attributes */
+/**
+ * struct device_attribute - Interface for exporting device attributes.
+ * @attr: sysfs attribute definition.
+ * @show: Show handler.
+ * @store: Store handler.
+ */
 struct device_attribute {
 	struct attribute	attr;
 	ssize_t (*show)(struct device *dev, struct device_attribute *attr,
@@ -105,6 +110,11 @@ struct device_attribute {
 			 const char *buf, size_t count);
 };
 
+/**
+ * struct dev_ext_attribute - Exported device attribute with extra context.
+ * @attr: Exported device attribute.
+ * @var: Pointer to context.
+ */
 struct dev_ext_attribute {
 	struct device_attribute attr;
 	void *var;
@@ -123,30 +133,124 @@ ssize_t device_show_bool(struct device *dev, struct device_attribute *attr,
 ssize_t device_store_bool(struct device *dev, struct device_attribute *attr,
 			 const char *buf, size_t count);
 
+/**
+ * DEVICE_ATTR - Define a device attribute.
+ * @_name: Attribute name.
+ * @_mode: File mode.
+ * @_show: Show handler. Optional, but mandatory if attribute is readable.
+ * @_store: Store handler. Optional, but mandatory if attribute is writable.
+ *
+ * Convenience macro for defining a struct device_attribute.
+ *
+ * For example, ``DEVICE_ATTR(foo, 0644, foo_show, foo_store);`` expands to:
+ *
+ * .. code-block:: c
+ *
+ *	struct device_attribute dev_attr_foo = {
+ *		.attr	= { .name = "foo", .mode = 0644 },
+ *		.show	= foo_show,
+ *		.store	= foo_store,
+ *	};
+ */
 #define DEVICE_ATTR(_name, _mode, _show, _store) \
 	struct device_attribute dev_attr_##_name = __ATTR(_name, _mode, _show, _store)
+
+/**
+ * DEVICE_ATTR_PREALLOC - Define a preallocated device attribute.
+ * @_name: Attribute name.
+ * @_mode: File mode.
+ * @_show: Show handler. Optional, but mandatory if attribute is readable.
+ * @_store: Store handler. Optional, but mandatory if attribute is writable.
+ *
+ * Like DEVICE_ATTR(), but ``SYSFS_PREALLOC`` is set on @_mode.
+ */
 #define DEVICE_ATTR_PREALLOC(_name, _mode, _show, _store) \
 	struct device_attribute dev_attr_##_name = \
 		__ATTR_PREALLOC(_name, _mode, _show, _store)
+
+/**
+ * DEVICE_ATTR_RW - Define a read-write device attribute.
+ * @_name: Attribute name.
+ *
+ * Like DEVICE_ATTR(), but @_mode is 0644, @_show is <_name>_show,
+ * and @_store is <_name>_store.
+ */
 #define DEVICE_ATTR_RW(_name) \
 	struct device_attribute dev_attr_##_name = __ATTR_RW(_name)
+
+/**
+ * DEVICE_ATTR_ADMIN_RW - Define an admin-only read-write device attribute.
+ * @_name: Attribute name.
+ *
+ * Like DEVICE_ATTR_RW(), but @_mode is 0600.
+ */
 #define DEVICE_ATTR_ADMIN_RW(_name) \
 	struct device_attribute dev_attr_##_name = __ATTR_RW_MODE(_name, 0600)
+
+/**
+ * DEVICE_ATTR_RO - Define a readable device attribute.
+ * @_name: Attribute name.
+ *
+ * Like DEVICE_ATTR(), but @_mode is 0444 and @_show is <_name>_show.
+ */
 #define DEVICE_ATTR_RO(_name) \
 	struct device_attribute dev_attr_##_name = __ATTR_RO(_name)
+
+/**
+ * DEVICE_ATTR_ADMIN_RO - Define an admin-only readable device attribute.
+ * @_name: Attribute name.
+ *
+ * Like DEVICE_ATTR_RO(), but @_mode is 0400.
+ */
 #define DEVICE_ATTR_ADMIN_RO(_name) \
 	struct device_attribute dev_attr_##_name = __ATTR_RO_MODE(_name, 0400)
+
+/**
+ * DEVICE_ATTR_WO - Define an admin-only writable device attribute.
+ * @_name: Attribute name.
+ *
+ * Like DEVICE_ATTR(), but @_mode is 0200 and @_store is <_name>_store.
+ */
 #define DEVICE_ATTR_WO(_name) \
 	struct device_attribute dev_attr_##_name = __ATTR_WO(_name)
+
+/**
+ * DEVICE_ULONG_ATTR - Define a device attribute backed by an unsigned long.
+ * @_name: Attribute name.
+ * @_mode: File mode.
+ * @_var: Identifier of unsigned long.
+ *
+ * Like DEVICE_ATTR(), but @_show and @_store are automatically provided
+ * such that reads and writes to the attribute from userspace affect @_var.
+ */
 #define DEVICE_ULONG_ATTR(_name, _mode, _var) \
 	struct dev_ext_attribute dev_attr_##_name = \
 		{ __ATTR(_name, _mode, device_show_ulong, device_store_ulong), &(_var) }
+
+/**
+ * DEVICE_INT_ATTR - Define a device attribute backed by an int.
+ * @_name: Attribute name.
+ * @_mode: File mode.
+ * @_var: Identifier of int.
+ *
+ * Like DEVICE_ULONG_ATTR(), but @_var is an int.
+ */
 #define DEVICE_INT_ATTR(_name, _mode, _var) \
 	struct dev_ext_attribute dev_attr_##_name = \
 		{ __ATTR(_name, _mode, device_show_int, device_store_int), &(_var) }
+
+/**
+ * DEVICE_BOOL_ATTR - Define a device attribute backed by a bool.
+ * @_name: Attribute name.
+ * @_mode: File mode.
+ * @_var: Identifier of bool.
+ *
+ * Like DEVICE_ULONG_ATTR(), but @_var is a bool.
+ */
 #define DEVICE_BOOL_ATTR(_name, _mode, _var) \
 	struct dev_ext_attribute dev_attr_##_name = \
 		{ __ATTR(_name, _mode, device_show_bool, device_store_bool), &(_var) }
+
 #define DEVICE_ATTR_IGNORE_LOCKDEP(_name, _mode, _show, _store) \
 	struct device_attribute dev_attr_##_name =		\
 		__ATTR_IGNORE_LOCKDEP(_name, _mode, _show, _store)
@@ -700,6 +804,11 @@ static inline bool device_iommu_mapped(struct device *dev)
 /* Get the wakeup routines, which depend on struct device */
 #include <linux/pm_wakeup.h>
 
+/**
+ * dev_name - Return a device's name.
+ * @dev: Device with name to get.
+ * Return: The kobject name of the device, or its initial name if unavailable.
+ */
 static inline const char *dev_name(const struct device *dev)
 {
 	/* Use the init name until the kobject becomes available */
-- 
2.34.1

