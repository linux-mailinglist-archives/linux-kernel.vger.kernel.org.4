Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58CEF6E0986
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 10:59:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230326AbjDMI7V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 04:59:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229871AbjDMI6s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 04:58:48 -0400
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC5019776;
        Thu, 13 Apr 2023 01:56:45 -0700 (PDT)
X-UUID: cffbef502368419ea3c967b9deffaa25-20230413
X-CID-O-RULE: Release_Ham
X-CID-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.22,REQID:a4fa865e-d2cd-46d3-b924-f292f65e27f5,IP:5,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:0
X-CID-INFO: VERSION:1.1.22,REQID:a4fa865e-d2cd-46d3-b924-f292f65e27f5,IP:5,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
        elease,TS:0
X-CID-META: VersionHash:120426c,CLOUDID:eaf2d5ea-db6f-41fe-8b83-13fe7ed1ef52,B
        ulkID:230413165640C535AKEK,BulkQuantity:0,Recheck:0,SF:19|44|38|24|17|102,
        TC:nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
        ,OSI:0,OSA:0,AV:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-UUID: cffbef502368419ea3c967b9deffaa25-20230413
X-User: zhouzongmin@kylinos.cn
Received: from thinkpadx13gen2i.. [(116.128.244.169)] by mailgw
        (envelope-from <zhouzongmin@kylinos.cn>)
        (Generic MTA)
        with ESMTP id 15698829; Thu, 13 Apr 2023 16:56:38 +0800
From:   Zongmin Zhou <zhouzongmin@kylinos.cn>
To:     zackr@vmware.com, linux-graphics-maintainer@vmware.com,
        pv-drivers@vmware.com, dmitry.torokhov@gmail.com
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zongmin Zhou <zhouzongmin@kylinos.cn>
Subject: [PATCH] Input: vmmouse - add macros to enable vmmouse relative mode
Date:   Thu, 13 Apr 2023 16:56:35 +0800
Message-Id: <20230413085635.2515647-1-zhouzongmin@kylinos.cn>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add macros to enable request relative mode.

Change the REL_Y value passed by input_report_rel function,
to match the direction of mouse movement.

Signed-off-by: Zongmin Zhou<zhouzongmin@kylinos.cn>
---
 drivers/input/mouse/vmmouse.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/input/mouse/vmmouse.c b/drivers/input/mouse/vmmouse.c
index ea9eff7c8099..f39ce21f7af9 100644
--- a/drivers/input/mouse/vmmouse.c
+++ b/drivers/input/mouse/vmmouse.c
@@ -21,6 +21,12 @@
 #include "psmouse.h"
 #include "vmmouse.h"
 
+/*
+ * Enable this to request relative mode.
+ * Defaut to absolute mode.
+ */
+//#define VMMOUSE_RELATIVE_MODE
+
 #define VMMOUSE_PROTO_MAGIC			0x564D5868U
 
 /*
@@ -184,7 +190,7 @@ static psmouse_ret_t vmmouse_report_events(struct psmouse *psmouse)
 		if (status & VMMOUSE_RELATIVE_PACKET) {
 			pref_dev = rel_dev;
 			input_report_rel(rel_dev, REL_X, (s32)x);
-			input_report_rel(rel_dev, REL_Y, -(s32)y);
+			input_report_rel(rel_dev, REL_Y, (s32)y);
 		} else {
 			pref_dev = abs_dev;
 			input_report_abs(abs_dev, ABS_X, x);
@@ -304,8 +310,13 @@ static int vmmouse_enable(struct psmouse *psmouse)
 	VMMOUSE_CMD(ABSPOINTER_RESTRICT, VMMOUSE_RESTRICT_CPL0,
 		    dummy1, dummy2, dummy3, dummy4);
 
+#ifdef VMMOUSE_RELATIVE_MODE
+	VMMOUSE_CMD(ABSPOINTER_COMMAND, VMMOUSE_CMD_REQUEST_RELATIVE,
+		    dummy1, dummy2, dummy3, dummy4);
+#else
 	VMMOUSE_CMD(ABSPOINTER_COMMAND, VMMOUSE_CMD_REQUEST_ABSOLUTE,
 		    dummy1, dummy2, dummy3, dummy4);
+#endif
 
 	return 0;
 }
-- 
2.34.1


No virus found
		Checked by Hillstone Network AntiVirus
