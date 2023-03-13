Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC5286B80D0
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 19:34:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231530AbjCMSdz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 14:33:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230513AbjCMSdV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 14:33:21 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A115385B17
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 11:31:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 04F28B811ED
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 18:30:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E098C433EF;
        Mon, 13 Mar 2023 18:30:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1678732243;
        bh=cRo1e+kQK1rWKnvTCLavWPeNNSm38qrbsMoD6hfrwy8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OvPa6zoEIp0uxqt3Q/zRXqMovt1MsKCzHngAGfnLroaxMCVZL+lAFZJi6s/I7nqQO
         YuB1obA2s7ufeKSk2Cm3aWer0z941V7U6hrq97jAuAkgUOG1IIn5kMOT/Vv8faltdx
         nD4CRoKQQBNxNyrZNG/60GKiwWq7iPktegy91y+4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     rafael@kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 26/36] driver core: bus: constify driver_find()
Date:   Mon, 13 Mar 2023 19:29:08 +0100
Message-Id: <20230313182918.1312597-26-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230313182918.1312597-1-gregkh@linuxfoundation.org>
References: <20230313182918.1312597-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1534; i=gregkh@linuxfoundation.org; h=from:subject; bh=cRo1e+kQK1rWKnvTCLavWPeNNSm38qrbsMoD6hfrwy8=; b=owGbwMvMwCRo6H6F97bub03G02pJDCn82VVZJt47pb9mc8xXffNrVpT/vt1yFzTcGKw1ZDZVr Uz94rS9I5aFQZCJQVZMkeXLNp6j+ysOKXoZ2p6GmcPKBDKEgYtTACYiOJNhwdqTU5/NVglpSNps Ezl/Zxz/q8Wq/AwLTtX/frjOQ+eLWXu/n4VZhFCZZtEMAA==
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

The driver_find() function can now take a const * to bus_type, not just
a * so fix that up.

Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/base/bus.c            | 2 +-
 include/linux/device/driver.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/base/bus.c b/drivers/base/bus.c
index ced61fad390e..8fea26c22521 100644
--- a/drivers/base/bus.c
+++ b/drivers/base/bus.c
@@ -1307,7 +1307,7 @@ EXPORT_SYMBOL_GPL(subsys_virtual_register);
  * from being unregistered or unloaded while the caller is using it.
  * The caller is responsible for preventing this.
  */
-struct device_driver *driver_find(const char *name, struct bus_type *bus)
+struct device_driver *driver_find(const char *name, const struct bus_type *bus)
 {
 	struct subsys_private *sp = bus_to_subsys(bus);
 	struct kobject *k;
diff --git a/include/linux/device/driver.h b/include/linux/device/driver.h
index 50d0a416a5e7..ceb0e477c2c8 100644
--- a/include/linux/device/driver.h
+++ b/include/linux/device/driver.h
@@ -126,7 +126,7 @@ extern int __must_check driver_register(struct device_driver *drv);
 extern void driver_unregister(struct device_driver *drv);
 
 extern struct device_driver *driver_find(const char *name,
-					 struct bus_type *bus);
+					 const struct bus_type *bus);
 extern int driver_probe_done(void);
 extern void wait_for_device_probe(void);
 void __init wait_for_init_devices_probe(void);
-- 
2.39.2

