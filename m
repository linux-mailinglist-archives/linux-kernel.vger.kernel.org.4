Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 137D969E0DC
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 13:54:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233090AbjBUMyU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 07:54:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232986AbjBUMyR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 07:54:17 -0500
Received: from andre.telenet-ops.be (andre.telenet-ops.be [IPv6:2a02:1800:120:4::f00:15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D9D026CE5
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 04:54:02 -0800 (PST)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed50:22fe:52b9:4e8:3dfc])
        by andre.telenet-ops.be with bizsmtp
        id Potz290011v1X7l01otzqD; Tue, 21 Feb 2023 13:53:59 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1pUS9G-009ce4-DU;
        Tue, 21 Feb 2023 13:53:58 +0100
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1pUS9e-00149K-Rt;
        Tue, 21 Feb 2023 13:53:58 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Lee Jones <lee@kernel.org>,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] driver core: bus: Handle early calls to bus_to_subsys()
Date:   Tue, 21 Feb 2023 13:53:51 +0100
Message-Id: <0a92979f6e790737544638e8a4c19b0564e660a2.1676983596.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When calling soc_device_match() from early_initcall(), bus_kset is still
NULL, causing a crash:

    Unable to handle kernel NULL pointer dereference at virtual address 0000000000000028
    ...
    Call trace:
     __lock_acquire+0x530/0x20f0
     lock_acquire.part.0+0xc8/0x210
     lock_acquire+0x64/0x80
     _raw_spin_lock+0x4c/0x60
     bus_to_subsys+0x24/0xac
     bus_for_each_dev+0x30/0xcc
     soc_device_match+0x4c/0xe0
     r8a7795_sysc_init+0x18/0x60
     rcar_sysc_pd_init+0xb0/0x33c
     do_one_initcall+0x128/0x2bc

Before, bus_for_each_dev() handled this gracefully by checking that
the back-pointer to the private structure was valid.

Fix this by adding a NULL check for bus_kset to bus_to_subsys().

Fixes: 83b9148df2c95e23 ("driver core: bus: bus iterator cleanups")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/base/bus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/bus.c b/drivers/base/bus.c
index cfe8615d5106f030..dd4b82d7510f68fb 100644
--- a/drivers/base/bus.c
+++ b/drivers/base/bus.c
@@ -62,7 +62,7 @@ static struct subsys_private *bus_to_subsys(const struct bus_type *bus)
 	struct subsys_private *sp = NULL;
 	struct kobject *kobj;
 
-	if (!bus)
+	if (!bus || !bus_kset)
 		return NULL;
 
 	spin_lock(&bus_kset->list_lock);
-- 
2.34.1

