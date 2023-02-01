Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DE536861C0
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 09:34:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231776AbjBAIeE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 03:34:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230043AbjBAIeC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 03:34:02 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00F964CE74
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 00:33:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 861C6616E4
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 08:33:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76CC0C433D2;
        Wed,  1 Feb 2023 08:33:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1675240433;
        bh=aVsGBakABLinDQxJtdl1QIk4NcE6DdHXwR43vgppMVE=;
        h=From:To:Cc:Subject:Date:From;
        b=Q8oPyTsn6/NpqDwuWqeBe2/+8muHZ9pUtzbuc+Vr2ToP6vuQmb9c//BcVKdpeTSij
         LlicxKASM2em8Q8jfy1a20yUF9T/wXGb4MExbq6Kc1MurtL4SWWhL3YsGwlvtxb7K1
         6QTNS2llRE037ytm69VfdcFUE945TG+Q0B19SnoQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH] driver core: bus: move lock_class_key into dynamic structure
Date:   Wed,  1 Feb 2023 09:33:49 +0100
Message-Id: <20230201083349.4038660-1-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2545; i=gregkh@linuxfoundation.org; h=from:subject; bh=aVsGBakABLinDQxJtdl1QIk4NcE6DdHXwR43vgppMVE=; b=owGbwMvMwCRo6H6F97bub03G02pJDMm3lF8b+JXzSnQu37tvosU1Pxl2zv5lx2IuFR6zvrX+n1OM lBtvRywLgyATg6yYIsuXbTxH91ccUvQytD0NM4eVCWQIAxenAEwkRp1hwbFEgb6aBcahqRV3p3lsEr H3CeaexDA/TD8tZ6rnlQUqW5PLVsvea+STtNYFAA==
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

Move the lock_class_key structure out of struct bus_type and into the
dynamic structure we create already for all bus_types registered with
the kernel.  This saves on static space and removes one more writable
field in struct bus_type.

In the future, the same field can be moved out of the struct class logic
because it shares this same private structure.

Most everyone will never notice this change, as lockdep is not enabled
in real systems so no memory or logic changes are happening for them.

Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/base/base.h        | 2 ++
 drivers/base/bus.c         | 5 ++++-
 include/linux/device/bus.h | 1 -
 3 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/base/base.h b/drivers/base/base.h
index 2208af509ce8..0e806f641079 100644
--- a/drivers/base/base.h
+++ b/drivers/base/base.h
@@ -52,6 +52,8 @@ struct subsys_private {
 
 	struct kset glue_dirs;
 	struct class *class;
+
+	struct lock_class_key lock_key;
 };
 #define to_subsys_private(obj) container_of_const(obj, struct subsys_private, subsys.kobj)
 
diff --git a/drivers/base/bus.c b/drivers/base/bus.c
index cf1b8f00b4c0..aa70b3a7d778 100644
--- a/drivers/base/bus.c
+++ b/drivers/base/bus.c
@@ -154,6 +154,7 @@ static void bus_release(struct kobject *kobj)
 	struct subsys_private *priv = to_subsys_private(kobj);
 	struct bus_type *bus = priv->bus;
 
+	lockdep_unregister_key(&priv->lock_key);
 	kfree(priv);
 	bus->p = NULL;
 }
@@ -743,7 +744,7 @@ int bus_register(struct bus_type *bus)
 {
 	int retval;
 	struct subsys_private *priv;
-	struct lock_class_key *key = &bus->lock_key;
+	struct lock_class_key *key;
 
 	priv = kzalloc(sizeof(struct subsys_private), GFP_KERNEL);
 	if (!priv)
@@ -785,6 +786,8 @@ int bus_register(struct bus_type *bus)
 	}
 
 	INIT_LIST_HEAD(&priv->interfaces);
+	key = &priv->lock_key;
+	lockdep_register_key(key);
 	__mutex_init(&priv->mutex, "subsys mutex", key);
 	klist_init(&priv->klist_devices, klist_devices_get, klist_devices_put);
 	klist_init(&priv->klist_drivers, NULL, NULL);
diff --git a/include/linux/device/bus.h b/include/linux/device/bus.h
index 87e4d029c915..e3094db1e9fa 100644
--- a/include/linux/device/bus.h
+++ b/include/linux/device/bus.h
@@ -112,7 +112,6 @@ struct bus_type {
 	const struct iommu_ops *iommu_ops;
 
 	struct subsys_private *p;
-	struct lock_class_key lock_key;
 
 	bool need_parent_lock;
 };
-- 
2.39.1

