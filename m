Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DCF56BEA50
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 14:41:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230460AbjCQNlC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 09:41:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230395AbjCQNk7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 09:40:59 -0400
Received: from tretyak2.mcst.ru (tretyak2.mcst.ru [212.5.119.215])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB124E6FDE;
        Fri, 17 Mar 2023 06:40:38 -0700 (PDT)
Received: from tretyak2.mcst.ru (localhost [127.0.0.1])
        by tretyak2.mcst.ru (Postfix) with ESMTP id 46B67102391;
        Fri, 17 Mar 2023 16:40:35 +0300 (MSK)
Received: from frog.lab.sun.mcst.ru (frog.lab.sun.mcst.ru [172.16.4.50])
        by tretyak2.mcst.ru (Postfix) with ESMTP id 4331810238F;
        Fri, 17 Mar 2023 16:40:15 +0300 (MSK)
Received: from artemiev-i.lab.sun.mcst.ru (avior-1 [192.168.53.223])
        by frog.lab.sun.mcst.ru (8.13.4/8.12.11) with ESMTP id 32HDeEQo002688;
        Fri, 17 Mar 2023 16:40:14 +0300
From:   Igor Artemiev <Igor.A.Artemiev@mcst.ru>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Igor Artemiev <Igor.A.Artemiev@mcst.ru>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        lvc-project@linuxtesting.org
Subject: [lvc-project] [PATCH v2] Input: trackpoint - remove unreachable code
Date:   Fri, 17 Mar 2023 16:39:09 +0300
Message-Id: <20230317133909.1564390-1-Igor.A.Artemiev@mcst.ru>
X-Mailer: git-send-email 2.39.0.152.ga5737674b6
In-Reply-To: <ZBQ+bJQkcZREArAq@google.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Anti-Virus: Kaspersky Anti-Virus for Linux Mail Server 5.6.39/RELEASE,
         bases: 20111107 #2745587, check: 20230317 notchecked
X-AV-Checked: ClamAV using ClamSMTP
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The trackpoint_sync() function always returns 0.
And there is no need to check its result.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Igor Artemiev <Igor.A.Artemiev@mcst.ru>
---
v2: make the trackpoint_sync() a void function 
as Andi Shyti <andi.shyti@kernel.org> suggested.
 
 drivers/input/mouse/trackpoint.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/input/mouse/trackpoint.c b/drivers/input/mouse/trackpoint.c
index 4a86b3e31d3b..2c381377ad4b 100644
--- a/drivers/input/mouse/trackpoint.c
+++ b/drivers/input/mouse/trackpoint.c
@@ -300,7 +300,7 @@ static int trackpoint_start_protocol(struct psmouse *psmouse,
  *		      power-on reset was run). If so, values will only be
  *		      written to TP if they differ from power-on default.
  */
-static int trackpoint_sync(struct psmouse *psmouse, bool in_power_on_state)
+static void trackpoint_sync(struct psmouse *psmouse, bool in_power_on_state)
 {
 	struct trackpoint_data *tp = psmouse->private;
 
@@ -340,8 +340,6 @@ static int trackpoint_sync(struct psmouse *psmouse, bool in_power_on_state)
 	TRACKPOINT_UPDATE(in_power_on_state, psmouse, tp, press_to_select);
 	TRACKPOINT_UPDATE(in_power_on_state, psmouse, tp, skipback);
 	TRACKPOINT_UPDATE(in_power_on_state, psmouse, tp, ext_dev);
-
-	return 0;
 }
 
 static void trackpoint_defaults(struct trackpoint_data *tp)
@@ -386,9 +384,7 @@ static int trackpoint_reconnect(struct psmouse *psmouse)
 	was_reset = tp->variant_id == TP_VARIANT_IBM &&
 		    trackpoint_power_on_reset(&psmouse->ps2dev) == 0;
 
-	error = trackpoint_sync(psmouse, was_reset);
-	if (error)
-		return error;
+	trackpoint_sync(psmouse, was_reset);
 
 	return 0;
 }
-- 
2.30.2

