Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DC956B80AB
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 19:31:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231359AbjCMSbo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 14:31:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231287AbjCMSbF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 14:31:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C908848D1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 11:30:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1150261468
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 18:30:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22936C433D2;
        Mon, 13 Mar 2023 18:30:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1678732238;
        bh=2ZmWFDJP7W9Eu0QlisAwd3I2utOuVhHKcxmoQW6TiXI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gGraI953dU2dZ0Nusru0tb87Wdlaj65SktviZ5w0V9ohBhs5FZIyENihQoBFSb4yJ
         8q6raFbGcA9U8RavAWu7jTrJA9BpjRtnlqDIXQcl5zEUbgwGVSPrWSwfoJz1TaPppp
         kf4ETJUT3aUtdlXITXA5Cl1YvnNBCQ+Qcuu7zMtY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     rafael@kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 24/36] driver core: bus: constantify bus_register()
Date:   Mon, 13 Mar 2023 19:29:06 +0100
Message-Id: <20230313182918.1312597-24-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230313182918.1312597-1-gregkh@linuxfoundation.org>
References: <20230313182918.1312597-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1810; i=gregkh@linuxfoundation.org; h=from:subject; bh=2ZmWFDJP7W9Eu0QlisAwd3I2utOuVhHKcxmoQW6TiXI=; b=owGbwMvMwCRo6H6F97bub03G02pJDCn82VVcAoekqg6erF/9rMh4tZxPzrkTYedXcqtnSZ50M nuadSmmI5aFQZCJQVZMkeXLNp6j+ysOKXoZ2p6GmcPKBDKEgYtTACayRIRhfrlw+IEek1d1B+Na LvXafWtkv+FQxbBgfURPy9m+9VNezPFrvfXj6Rr5W/oeAA==
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

bus_register() is now safe to take a constant * to bus_type, so make
that change and mark the subsys_private bus_type * constant as well.

Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/base/base.h        | 2 +-
 drivers/base/bus.c         | 2 +-
 include/linux/device/bus.h | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/base/base.h b/drivers/base/base.h
index f1034e27e651..09c6682d16b5 100644
--- a/drivers/base/base.h
+++ b/drivers/base/base.h
@@ -49,7 +49,7 @@ struct subsys_private {
 	struct klist klist_drivers;
 	struct blocking_notifier_head bus_notifier;
 	unsigned int drivers_autoprobe:1;
-	struct bus_type *bus;
+	const struct bus_type *bus;
 	struct device *dev_root;
 
 	struct kset glue_dirs;
diff --git a/drivers/base/bus.c b/drivers/base/bus.c
index 819ab745fa9f..f739a2a79e59 100644
--- a/drivers/base/bus.c
+++ b/drivers/base/bus.c
@@ -841,7 +841,7 @@ static struct bus_attribute bus_attr_uevent = __ATTR(uevent, 0200, NULL,
  * infrastructure, then register the children subsystems it has:
  * the devices and drivers that belong to the subsystem.
  */
-int bus_register(struct bus_type *bus)
+int bus_register(const struct bus_type *bus)
 {
 	int retval;
 	struct subsys_private *priv;
diff --git a/include/linux/device/bus.h b/include/linux/device/bus.h
index 78c875386c06..c30c4748c170 100644
--- a/include/linux/device/bus.h
+++ b/include/linux/device/bus.h
@@ -110,7 +110,7 @@ struct bus_type {
 	bool need_parent_lock;
 };
 
-extern int __must_check bus_register(struct bus_type *bus);
+extern int __must_check bus_register(const struct bus_type *bus);
 
 extern void bus_unregister(const struct bus_type *bus);
 
-- 
2.39.2

