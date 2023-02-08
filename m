Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10E8668ED8F
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 12:15:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230246AbjBHLOH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 06:14:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230368AbjBHLNy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 06:13:54 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 018D1252A4
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 03:13:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A83EAB81C6E
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 11:13:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 991A3C433EF;
        Wed,  8 Feb 2023 11:13:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1675854827;
        bh=cn5nHUc6lR7TQRKfGigfXa7oBZoUPrcprKiU8P3aMFs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=opPdyg+UFomBXvB6bMf4nHe1J/FNTBYbatakbLOabCVEFxgwDdCfnZCF6+iIwDQfr
         R/ZFq2Uep5ut7gx5An0AWTOnlWsuhTYUoxCXwiogTMpVfNhrwVuau977PU5pCSfyUR
         MP+B+MimUnMeDIkRxWd7M8a4BXtY99kaAMJBhyWg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH 10/21] driver core: bus: bus_register/unregister_notifier() cleanups
Date:   Wed,  8 Feb 2023 12:13:19 +0100
Message-Id: <20230208111330.439504-11-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230208111330.439504-1-gregkh@linuxfoundation.org>
References: <20230208111330.439504-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1893; i=gregkh@linuxfoundation.org; h=from:subject; bh=cn5nHUc6lR7TQRKfGigfXa7oBZoUPrcprKiU8P3aMFs=; b=owGbwMvMwCRo6H6F97bub03G02pJDMmPm68zxU7NDt2zJsnreVJJreQyn0tv8rx+XFVxUa+um/vE e+aujlgWBkEmBlkxRZYv23iO7q84pOhlaHsaZg4rE8gQBi5OAZjIuo0M831jXu7/cpk/8iXHjp6/l3 5tPRPz8TbDgrW2N0M2ThO4peaUMD3ywS6vbDHxtQA=
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

Convert the bus_register_notifier() and bus_unregister_notifier() public
functions to use bus_to_subsys() and not use the back-pointer to the
private structure as well as the bus_notify() function.

Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/base/bus.c | 28 +++++++++++++++++++++++-----
 1 file changed, 23 insertions(+), 5 deletions(-)

diff --git a/drivers/base/bus.c b/drivers/base/bus.c
index 90627c68d02b..f23c6f6306e2 100644
--- a/drivers/base/bus.c
+++ b/drivers/base/bus.c
@@ -936,22 +936,40 @@ EXPORT_SYMBOL_GPL(bus_unregister);
 
 int bus_register_notifier(struct bus_type *bus, struct notifier_block *nb)
 {
-	return blocking_notifier_chain_register(&bus->p->bus_notifier, nb);
+	struct subsys_private *sp = bus_to_subsys(bus);
+	int retval;
+
+	if (!sp)
+		return -EINVAL;
+
+	retval = blocking_notifier_chain_register(&sp->bus_notifier, nb);
+	subsys_put(sp);
+	return retval;
 }
 EXPORT_SYMBOL_GPL(bus_register_notifier);
 
 int bus_unregister_notifier(struct bus_type *bus, struct notifier_block *nb)
 {
-	return blocking_notifier_chain_unregister(&bus->p->bus_notifier, nb);
+	struct subsys_private *sp = bus_to_subsys(bus);
+	int retval;
+
+	if (!sp)
+		return -EINVAL;
+	retval = blocking_notifier_chain_unregister(&sp->bus_notifier, nb);
+	subsys_put(sp);
+	return retval;
 }
 EXPORT_SYMBOL_GPL(bus_unregister_notifier);
 
 void bus_notify(struct device *dev, enum bus_notifier_event value)
 {
-	struct bus_type *bus = dev->bus;
+	struct subsys_private *sp = bus_to_subsys(dev->bus);
 
-	if (bus)
-		blocking_notifier_call_chain(&bus->p->bus_notifier, value, dev);
+	if (!sp)
+		return;
+
+	blocking_notifier_call_chain(&sp->bus_notifier, value, dev);
+	subsys_put(sp);
 }
 
 struct kset *bus_get_kset(struct bus_type *bus)
-- 
2.39.1

