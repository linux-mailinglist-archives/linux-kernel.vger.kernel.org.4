Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 608E75F1DF0
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 18:54:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229595AbiJAQyo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Oct 2022 12:54:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbiJAQyj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Oct 2022 12:54:39 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E76F01F7
        for <linux-kernel@vger.kernel.org>; Sat,  1 Oct 2022 09:54:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1DAC7B8075F
        for <linux-kernel@vger.kernel.org>; Sat,  1 Oct 2022 16:54:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E97BC43470;
        Sat,  1 Oct 2022 16:54:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1664643269;
        bh=bPrNV5grbI/hrGpwaoI8SfeYR9gLnDGqPdkJGy4UJUs=;
        h=From:To:Cc:Subject:Date:From;
        b=fCUJxRj0OKUZTabYvGdyddJ0vCxGb9IIlzDGrMNpQbnsXnI46Gs43ITXny34cb6r9
         dejlINkF50ZWxmqqbEMjWseNvNuHKs/YiZsEkZUURTY74LD9fwisnsQl5wZhQEDVWO
         aHMEBLnBMmj7KlcZPJDWDpD64xXu0BsDSM2UH39k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH] driver core: class: make namespace and get_ownership take const *
Date:   Sat,  1 Oct 2022 18:54:26 +0200
Message-Id: <20221001165426.2690912-1-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5190; i=gregkh@linuxfoundation.org; h=from:subject; bh=bPrNV5grbI/hrGpwaoI8SfeYR9gLnDGqPdkJGy4UJUs=; b=owGbwMvMwCRo6H6F97bub03G02pJDMkWBYd+MQUfl34eJZIk1Fz/eF2hg+mlF7FdSctWPN7hXl/3 oj+4I5aFQZCJQVZMkeXLNp6j+ysOKXoZ2p6GmcPKBDKEgYtTACbicIVhwZRPxsY/G/f+e38m9tv8e4 UXS2bKX2ZYcPh0uqdvvFDuz3efFsf4C55nlQr4AwA=
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The callbacks in struct class namespace() and get_ownership() do not
modify the struct device passed to them, so mark the pointer as constant
and fix up all callbacks in the kernel to have the correct function
signature.

This helps make it more obvious what calls and callbacks do, and do not,
modify structures passed to them.

Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/base/core.c              | 4 ++--
 drivers/infiniband/core/device.c | 4 ++--
 drivers/net/ipvlan/ipvtap.c      | 4 ++--
 drivers/net/macvtap.c            | 4 ++--
 include/linux/device/class.h     | 4 ++--
 net/core/net-sysfs.c             | 8 ++++----
 net/wireless/sysfs.c             | 2 +-
 7 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 5fb4bc51dd8b..41c483d338af 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -2336,7 +2336,7 @@ static void device_release(struct kobject *kobj)
 
 static const void *device_namespace(struct kobject *kobj)
 {
-	struct device *dev = kobj_to_dev(kobj);
+	const struct device *dev = kobj_to_dev(kobj);
 	const void *ns = NULL;
 
 	if (dev->class && dev->class->ns_type)
@@ -2347,7 +2347,7 @@ static const void *device_namespace(struct kobject *kobj)
 
 static void device_get_ownership(struct kobject *kobj, kuid_t *uid, kgid_t *gid)
 {
-	struct device *dev = kobj_to_dev(kobj);
+	const struct device *dev = kobj_to_dev(kobj);
 
 	if (dev->class && dev->class->get_ownership)
 		dev->class->get_ownership(dev, uid, gid);
diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index d275db195f1a..2ebd98a517c4 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -524,9 +524,9 @@ static int ib_device_uevent(struct device *device,
 	return 0;
 }
 
-static const void *net_namespace(struct device *d)
+static const void *net_namespace(const struct device *d)
 {
-	struct ib_core_device *coredev =
+	const struct ib_core_device *coredev =
 			container_of(d, struct ib_core_device, dev);
 
 	return read_pnet(&coredev->rdma_net);
diff --git a/drivers/net/ipvlan/ipvtap.c b/drivers/net/ipvlan/ipvtap.c
index cbabca167a07..dde272586e80 100644
--- a/drivers/net/ipvlan/ipvtap.c
+++ b/drivers/net/ipvlan/ipvtap.c
@@ -30,9 +30,9 @@
 static dev_t ipvtap_major;
 static struct cdev ipvtap_cdev;
 
-static const void *ipvtap_net_namespace(struct device *d)
+static const void *ipvtap_net_namespace(const struct device *d)
 {
-	struct net_device *dev = to_net_dev(d->parent);
+	const struct net_device *dev = to_net_dev(d->parent);
 	return dev_net(dev);
 }
 
diff --git a/drivers/net/macvtap.c b/drivers/net/macvtap.c
index cecf8c63096c..0cbaa714290d 100644
--- a/drivers/net/macvtap.c
+++ b/drivers/net/macvtap.c
@@ -35,9 +35,9 @@ struct macvtap_dev {
  */
 static dev_t macvtap_major;
 
-static const void *macvtap_net_namespace(struct device *d)
+static const void *macvtap_net_namespace(const struct device *d)
 {
-	struct net_device *dev = to_net_dev(d->parent);
+	const struct net_device *dev = to_net_dev(d->parent);
 	return dev_net(dev);
 }
 
diff --git a/include/linux/device/class.h b/include/linux/device/class.h
index e61ec5502019..20103e0b03c3 100644
--- a/include/linux/device/class.h
+++ b/include/linux/device/class.h
@@ -68,9 +68,9 @@ struct class {
 	int (*shutdown_pre)(struct device *dev);
 
 	const struct kobj_ns_type_operations *ns_type;
-	const void *(*namespace)(struct device *dev);
+	const void *(*namespace)(const struct device *dev);
 
-	void (*get_ownership)(struct device *dev, kuid_t *uid, kgid_t *gid);
+	void (*get_ownership)(const struct device *dev, kuid_t *uid, kgid_t *gid);
 
 	const struct dev_pm_ops *pm;
 
diff --git a/net/core/net-sysfs.c b/net/core/net-sysfs.c
index d61afd21aab5..c3e5c55d6f85 100644
--- a/net/core/net-sysfs.c
+++ b/net/core/net-sysfs.c
@@ -1910,16 +1910,16 @@ static void netdev_release(struct device *d)
 	netdev_freemem(dev);
 }
 
-static const void *net_namespace(struct device *d)
+static const void *net_namespace(const struct device *d)
 {
-	struct net_device *dev = to_net_dev(d);
+	const struct net_device *dev = to_net_dev(d);
 
 	return dev_net(dev);
 }
 
-static void net_get_ownership(struct device *d, kuid_t *uid, kgid_t *gid)
+static void net_get_ownership(const struct device *d, kuid_t *uid, kgid_t *gid)
 {
-	struct net_device *dev = to_net_dev(d);
+	const struct net_device *dev = to_net_dev(d);
 	const struct net *net = dev_net(dev);
 
 	net_ns_get_ownership(net, uid, gid);
diff --git a/net/wireless/sysfs.c b/net/wireless/sysfs.c
index 0c3f05c9be27..cdb638647e0b 100644
--- a/net/wireless/sysfs.c
+++ b/net/wireless/sysfs.c
@@ -148,7 +148,7 @@ static SIMPLE_DEV_PM_OPS(wiphy_pm_ops, wiphy_suspend, wiphy_resume);
 #define WIPHY_PM_OPS NULL
 #endif
 
-static const void *wiphy_namespace(struct device *d)
+static const void *wiphy_namespace(const struct device *d)
 {
 	struct wiphy *wiphy = container_of(d, struct wiphy, dev);
 
-- 
2.37.3

