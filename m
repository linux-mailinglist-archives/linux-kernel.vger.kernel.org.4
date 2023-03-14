Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A24206B93CB
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 13:30:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229748AbjCNMar (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 08:30:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231771AbjCNMaN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 08:30:13 -0400
Received: from tretyak2.mcst.ru (tretyak2.mcst.ru [212.5.119.215])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D7CC591CA;
        Tue, 14 Mar 2023 05:29:10 -0700 (PDT)
Received: from tretyak2.mcst.ru (localhost [127.0.0.1])
        by tretyak2.mcst.ru (Postfix) with ESMTP id 5A59410226F;
        Tue, 14 Mar 2023 15:28:01 +0300 (MSK)
Received: from frog.lab.sun.mcst.ru (frog.lab.sun.mcst.ru [172.16.4.50])
        by tretyak2.mcst.ru (Postfix) with ESMTP id 56D9510238F;
        Tue, 14 Mar 2023 15:27:41 +0300 (MSK)
Received: from artemiev-i.lab.sun.mcst.ru (avior-1 [192.168.53.223])
        by frog.lab.sun.mcst.ru (8.13.4/8.12.11) with ESMTP id 32ECReA8013681;
        Tue, 14 Mar 2023 15:27:40 +0300
From:   Igor Artemiev <Igor.A.Artemiev@mcst.ru>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Igor Artemiev <Igor.A.Artemiev@mcst.ru>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        lvc-project@linuxtesting.org
Subject: [lvc-project] [PATCH] Input: trackpoint - remove unreachable code
Date:   Tue, 14 Mar 2023 15:27:14 +0300
Message-Id: <20230314122714.1494260-1-Igor.A.Artemiev@mcst.ru>
X-Mailer: git-send-email 2.39.0.152.ga5737674b6
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Anti-Virus: Kaspersky Anti-Virus for Linux Mail Server 5.6.39/RELEASE,
         bases: 20111107 #2745587, check: 20230314 notchecked
X-AV-Checked: ClamAV using ClamSMTP
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The trackpoint_sync() function always returnd 0.
And there is no need to check its result.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 2a924d71794c ("Input: trackpoint - only expose supported controls for Elan, ALPS and NXP")
Signed-off-by: Igor Artemiev <Igor.A.Artemiev@mcst.ru>
---
 drivers/input/mouse/trackpoint.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/input/mouse/trackpoint.c b/drivers/input/mouse/trackpoint.c
index 4a86b3e31d3b..561a4d2d81ff 100644
--- a/drivers/input/mouse/trackpoint.c
+++ b/drivers/input/mouse/trackpoint.c
@@ -386,9 +386,7 @@ static int trackpoint_reconnect(struct psmouse *psmouse)
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

