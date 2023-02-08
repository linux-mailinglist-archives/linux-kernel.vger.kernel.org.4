Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D93F68ED9B
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 12:17:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbjBHLOm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 06:14:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230196AbjBHLOG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 06:14:06 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 741E2241C2
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 03:14:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 27EE7B81D46
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 11:14:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7346EC433EF;
        Wed,  8 Feb 2023 11:14:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1675854842;
        bh=1mImGWOl1u7F0otEn6f4kIHAWLUXjPlgHYU4EGCoXk4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IK3TH3L/y3D6Bypj4TmyeSsp8/1KrmEHy0kKEtTBKkTgWIxoNUBpEtk7TsJrYGhP0
         nQCmLmrBDHFWBUBDgav6gYDapZ+cCRtL2rJuiuozRd/6J83Njax7DAF/zk3dwDm7Cp
         YNlpAn0X0946xSruNtVVWOVE5e/fX8asQHVrS70s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH 15/21] driver core: bus: clean up driver_find()
Date:   Wed,  8 Feb 2023 12:13:24 +0100
Message-Id: <20230208111330.439504-16-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230208111330.439504-1-gregkh@linuxfoundation.org>
References: <20230208111330.439504-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1264; i=gregkh@linuxfoundation.org; h=from:subject; bh=1mImGWOl1u7F0otEn6f4kIHAWLUXjPlgHYU4EGCoXk4=; b=owGbwMvMwCRo6H6F97bub03G02pJDMmPm28I/ymI6ltkJLEx7u3c+92Bj1sDNNXEA9Q9tlS7NKiF H97TEcvCIMjEICumyPJlG8/R/RWHFL0MbU/DzGFlAhnCwMUpABOpeMuw4ESlRujkNddVvqWt03ny8J vP5vCiLwwLdtQftP1w+PzsGdy+bb+Np259xfYnAQA=
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

Convert the driver_find() function to use bus_to_subsys() and not use
the back-pointer to the private structure.

Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/base/bus.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/drivers/base/bus.c b/drivers/base/bus.c
index 727de4c36d59..951d63c8e885 100644
--- a/drivers/base/bus.c
+++ b/drivers/base/bus.c
@@ -1302,16 +1302,23 @@ EXPORT_SYMBOL_GPL(subsys_virtual_register);
  */
 struct device_driver *driver_find(const char *name, struct bus_type *bus)
 {
-	struct kobject *k = kset_find_obj(bus->p->drivers_kset, name);
+	struct subsys_private *sp = bus_to_subsys(bus);
+	struct kobject *k;
 	struct driver_private *priv;
 
-	if (k) {
-		/* Drop reference added by kset_find_obj() */
-		kobject_put(k);
-		priv = to_driver(k);
-		return priv->driver;
-	}
-	return NULL;
+	if (!sp)
+		return NULL;
+
+	k = kset_find_obj(sp->drivers_kset, name);
+	subsys_put(sp);
+	if (!k)
+		return NULL;
+
+	priv = to_driver(k);
+
+	/* Drop reference added by kset_find_obj() */
+	kobject_put(k);
+	return priv->driver;
 }
 EXPORT_SYMBOL_GPL(driver_find);
 
-- 
2.39.1

