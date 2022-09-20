Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C8B65BE1EC
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 11:29:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230353AbiITJ3R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 05:29:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbiITJ3N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 05:29:13 -0400
X-Greylist: delayed 155969 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 20 Sep 2022 02:29:09 PDT
Received: from home.thecybershadow.net (tunnel258969-pt.tunnel.tserv1.bud1.ipv6.he.net [IPv6:2001:470:1f1a:172::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D642D6B174;
        Tue, 20 Sep 2022 02:29:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=home.thecybershadow.net; s=home; h=Sender:Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=QpkkQ4WyftxxHWS4ArtYNAZoBCGANNfQssOOdKoio5E=; b=yMH1LLnzMU0hvSaHHwGZWqn4cT
        GWixLgYiaKD7u5H8UwyfT+zR6HqWwgrI3y7/9eCwUJD2QVav8xBUc4sS+bDzBGscZH9OCmCl3o+bU
        2UnP7WNQa1ote39LeYSPdWpOxk9OcF71LPx0QzSAoz/UbOfQOPyuHCnFRvy9VR66ZuqA=;
Received: from vladimir by home.thecybershadow.net with local (Exim 4.96)
        (envelope-from <vladimir@home.thecybershadow.net>)
        id 1oaZYw-0002ER-1a;
        Tue, 20 Sep 2022 09:29:06 +0000
From:   Vladimir Panteleev <git@vladimir.panteleev.md>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     Vladimir Panteleev <git@vladimir.panteleev.md>,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] watchdog: sp5100_tco: Add "action" module parameter
Date:   Tue, 20 Sep 2022 09:27:21 +0000
Message-Id: <20220920092721.7686-1-git@vladimir.panteleev.md>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender:  <vladimir@home.thecybershadow.net>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow configuring the "action" bit, as documented in [1].

Previously, the only action supported by this module was to reset the
system (0).  It can now be configured to power off (1) instead.

[1]: https://www.amd.com/system/files/TechDocs/44413.pdf

Signed-off-by: Vladimir Panteleev <git@vladimir.panteleev.md>
---

Changes since v1:
 - Drop the rename of the SP5100_WDT_ACTION_RESET define
 - Make the new parameter not visible in sysfs for consistency

 drivers/watchdog/sp5100_tco.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/watchdog/sp5100_tco.c b/drivers/watchdog/sp5100_tco.c
index ae54dd33e233..fb426b7d81da 100644
--- a/drivers/watchdog/sp5100_tco.c
+++ b/drivers/watchdog/sp5100_tco.c
@@ -65,6 +65,12 @@ static struct pci_dev *sp5100_tco_pci;
 
 /* module parameters */
 
+#define WATCHDOG_ACTION 0
+static bool action = WATCHDOG_ACTION;
+module_param(action, bool, 0);
+MODULE_PARM_DESC(action, "Action taken when watchdog expires, 0 to reset, 1 to poweroff (default="
+		 __MODULE_STRING(WATCHDOG_ACTION) ")");
+
 #define WATCHDOG_HEARTBEAT 60	/* 60 sec default heartbeat. */
 static int heartbeat = WATCHDOG_HEARTBEAT;  /* in seconds */
 module_param(heartbeat, int, 0);
@@ -297,8 +303,11 @@ static int sp5100_tco_timer_init(struct sp5100_tco *tco)
 	if (val & SP5100_WDT_FIRED)
 		wdd->bootstatus = WDIOF_CARDRESET;
 
-	/* Set watchdog action to reset the system */
-	val &= ~SP5100_WDT_ACTION_RESET;
+	/* Set watchdog action */
+	if (action)
+		val |= SP5100_WDT_ACTION_RESET;
+	else
+		val &= ~SP5100_WDT_ACTION_RESET;
 	writel(val, SP5100_WDT_CONTROL(tco->tcobase));
 
 	/* Set a reasonable heartbeat before we stop the timer */
-- 
2.37.3

