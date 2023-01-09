Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01F82662DDD
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 19:00:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234186AbjAISAq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 13:00:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237540AbjAIR7z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 12:59:55 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59235F5A7
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 09:58:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E5DAC612BB
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 17:58:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87826C433D2;
        Mon,  9 Jan 2023 17:58:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1673287095;
        bh=oc8KjIMBsU20qra+TEmHE94TE/YkqNtambTZXMH6O5I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=k0BgTiFjXvlohifNE8za83mK6ajUl2x4cvIA7YJpUaifp55XB/RkhkrhrsK6FBfZu
         FUyLnJPvowzmasv3iwvHIoIp1vYYilrLjd8yjcQpz8vjFs7ggb1+kGJZPXAm7bdj4p
         +hRYm/Ijenf6eLtE0prgt+808VGstnpaZF6N/lr0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH 2/6] driver core: remove subsys_find_device_by_id()
Date:   Mon,  9 Jan 2023 18:58:06 +0100
Message-Id: <20230109175810.2965448-2-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230109175810.2965448-1-gregkh@linuxfoundation.org>
References: <20230109175810.2965448-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2479; i=gregkh@linuxfoundation.org; h=from:subject; bh=oc8KjIMBsU20qra+TEmHE94TE/YkqNtambTZXMH6O5I=; b=owGbwMvMwCRo6H6F97bub03G02pJDMl7QjeaqMd8Kg2+smay3AezxYmq7+u5lUuFzF5vk47vr4nX 41ToiGVhEGRikBVTZPmyjefo/opDil6Gtqdh5rAygQxh4OIUgIlIPGeYny60YQdr7FGhL63aTc1pRc wnlFxLGBb0W3tULgq4PfdMMn8+S/CmhneGy+8DAA==
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

This function has not been called by any code in the kernel tree in many
many years so remove it as it is unused.

Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/base/bus.c         | 41 --------------------------------------
 include/linux/device/bus.h |  2 --
 2 files changed, 43 deletions(-)

diff --git a/drivers/base/bus.c b/drivers/base/bus.c
index 4e6fdb65a157..45aa8d996f0a 100644
--- a/drivers/base/bus.c
+++ b/drivers/base/bus.c
@@ -363,47 +363,6 @@ struct device *bus_find_device(struct bus_type *bus,
 }
 EXPORT_SYMBOL_GPL(bus_find_device);
 
-/**
- * subsys_find_device_by_id - find a device with a specific enumeration number
- * @subsys: subsystem
- * @id: index 'id' in struct device
- * @hint: device to check first
- *
- * Check the hint's next object and if it is a match return it directly,
- * otherwise, fall back to a full list search. Either way a reference for
- * the returned object is taken.
- */
-struct device *subsys_find_device_by_id(struct bus_type *subsys, unsigned int id,
-					struct device *hint)
-{
-	struct klist_iter i;
-	struct device *dev;
-
-	if (!subsys)
-		return NULL;
-
-	if (hint) {
-		klist_iter_init_node(&subsys->p->klist_devices, &i, &hint->p->knode_bus);
-		dev = next_device(&i);
-		if (dev && dev->id == id && get_device(dev)) {
-			klist_iter_exit(&i);
-			return dev;
-		}
-		klist_iter_exit(&i);
-	}
-
-	klist_iter_init_node(&subsys->p->klist_devices, &i, NULL);
-	while ((dev = next_device(&i))) {
-		if (dev->id == id && get_device(dev)) {
-			klist_iter_exit(&i);
-			return dev;
-		}
-	}
-	klist_iter_exit(&i);
-	return NULL;
-}
-EXPORT_SYMBOL_GPL(subsys_find_device_by_id);
-
 static struct device_driver *next_driver(struct klist_iter *i)
 {
 	struct klist_node *n = klist_next(i);
diff --git a/include/linux/device/bus.h b/include/linux/device/bus.h
index 0699b3970344..d865440d8c02 100644
--- a/include/linux/device/bus.h
+++ b/include/linux/device/bus.h
@@ -250,8 +250,6 @@ bus_find_device_by_acpi_dev(struct bus_type *bus, const void *adev)
 }
 #endif
 
-struct device *subsys_find_device_by_id(struct bus_type *bus, unsigned int id,
-					struct device *hint);
 int bus_for_each_drv(struct bus_type *bus, struct device_driver *start,
 		     void *data, int (*fn)(struct device_driver *, void *));
 void bus_sort_breadthfirst(struct bus_type *bus,
-- 
2.39.0

