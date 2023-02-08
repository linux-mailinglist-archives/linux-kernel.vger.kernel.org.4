Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 163D768EDA0
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 12:17:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbjBHLPW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 06:15:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230397AbjBHLOb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 06:14:31 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E087425287
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 03:14:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7F0B76162D
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 11:14:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90B16C433EF;
        Wed,  8 Feb 2023 11:14:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1675854869;
        bh=dwfsdtCQB9wF5zjMLcmqwTmUkhdi6CgIhDJfaECGFfY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yJmZWKqZc+wzwp3wqIbuHuCe5vAOlm66YuWNEFyLvjXLoZtrfzkO+TztC899j4IRw
         qK72rkKt6oeW4Ym3TJvGpBQ7SdMqm1Ab+SR4fhYMoUioH11B1duQEVqkrZgXg7pnQG
         bly1SV+lfaFDRn2RVax0J1/cH/CvdgGq+cyAYfbM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH 05/21] driver core: bus: sysfs function cleanups
Date:   Wed,  8 Feb 2023 12:13:14 +0100
Message-Id: <20230208111330.439504-6-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230208111330.439504-1-gregkh@linuxfoundation.org>
References: <20230208111330.439504-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1967; i=gregkh@linuxfoundation.org; h=from:subject; bh=dwfsdtCQB9wF5zjMLcmqwTmUkhdi6CgIhDJfaECGFfY=; b=owGbwMvMwCRo6H6F97bub03G02pJDMmPm6/V3frZaXktJruDNf1+VE5udgZv4LZ/ws0t55L3qpwN PX6jI5aFQZCJQVZMkeXLNp6j+ysOKXoZ2p6GmcPKBDKEgYtTACYybQbDPEsZ0xpNrbo1//rLHD3v7/ Vv/XP8DMN8/40GWnMmL1p8WjW6/pfqFfvnQUyrAA==
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

Convert the drivers_autoprobe show/store and uevent sysfs callbacks to
use bus_to_subsys() and not use the back-pointer to the private
structure.

Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/base/bus.c | 35 +++++++++++++++++++++++++++++------
 1 file changed, 29 insertions(+), 6 deletions(-)

diff --git a/drivers/base/bus.c b/drivers/base/bus.c
index 8debbe00b4ca..f0d3ad41fd5e 100644
--- a/drivers/base/bus.c
+++ b/drivers/base/bus.c
@@ -277,16 +277,31 @@ static DRIVER_ATTR_IGNORE_LOCKDEP(bind, 0200, NULL, bind_store);
 
 static ssize_t drivers_autoprobe_show(struct bus_type *bus, char *buf)
 {
-	return sysfs_emit(buf, "%d\n", bus->p->drivers_autoprobe);
+	struct subsys_private *sp = bus_to_subsys(bus);
+	int ret;
+
+	if (!sp)
+		return -EINVAL;
+
+	ret = sysfs_emit(buf, "%d\n", sp->drivers_autoprobe);
+	subsys_put(sp);
+	return ret;
 }
 
 static ssize_t drivers_autoprobe_store(struct bus_type *bus,
 				       const char *buf, size_t count)
 {
+	struct subsys_private *sp = bus_to_subsys(bus);
+
+	if (!sp)
+		return -EINVAL;
+
 	if (buf[0] == '0')
-		bus->p->drivers_autoprobe = 0;
+		sp->drivers_autoprobe = 0;
 	else
-		bus->p->drivers_autoprobe = 1;
+		sp->drivers_autoprobe = 1;
+
+	subsys_put(sp);
 	return count;
 }
 
@@ -769,10 +784,18 @@ static void klist_devices_put(struct klist_node *n)
 static ssize_t bus_uevent_store(struct bus_type *bus,
 				const char *buf, size_t count)
 {
-	int rc;
+	struct subsys_private *sp = bus_to_subsys(bus);
+	int ret;
 
-	rc = kobject_synth_uevent(&bus->p->subsys.kobj, buf, count);
-	return rc ? rc : count;
+	if (!sp)
+		return -EINVAL;
+
+	ret = kobject_synth_uevent(&sp->subsys.kobj, buf, count);
+	subsys_put(sp);
+
+	if (ret)
+		return ret;
+	return count;
 }
 /*
  * "open code" the old BUS_ATTR() macro here.  We want to use BUS_ATTR_WO()
-- 
2.39.1

