Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2A8B6F67D9
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 10:56:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230057AbjEDI4h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 04:56:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbjEDI4e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 04:56:34 -0400
X-Greylist: delayed 63 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 04 May 2023 01:56:32 PDT
Received: from unicom145.biz-email.net (unicom145.biz-email.net [210.51.26.145])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50CAD358A;
        Thu,  4 May 2023 01:56:31 -0700 (PDT)
Received: from unicom145.biz-email.net
        by unicom145.biz-email.net ((D)) with ASMTP (SSL) id AFI00024;
        Thu, 04 May 2023 16:55:24 +0800
Received: from localhost.localdomain.com (10.73.43.242) by
 jtjnmail201608.home.langchao.com (10.100.2.8) with Microsoft SMTP Server id
 15.1.2507.23; Thu, 4 May 2023 16:55:23 +0800
From:   Bo Liu <liubo03@inspur.com>
To:     <tony@atomide.com>
CC:     <linux-omap@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Bo Liu <liubo03@inspur.com>
Subject: [PATCH] bus: ti-sysc: convert sysfs sprintf to sysfs_emit
Date:   Thu, 4 May 2023 04:55:22 -0400
Message-ID: <20230504085522.2635-1-liubo03@inspur.com>
X-Mailer: git-send-email 2.18.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.73.43.242]
tUid:   2023504165524c241f6fba83c50017744cf9c8f0f8e3c
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Follow the advice of the Documentation/filesystems/sysfs.rst
and show() should only use sysfs_emit() or sysfs_emit_at()
when formatting the value to be returned to user space.

Signed-off-by: Bo Liu <liubo03@inspur.com>
---
 drivers/bus/ti-sysc.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/bus/ti-sysc.c b/drivers/bus/ti-sysc.c
index 6c49de37d5e9..e3d043de894d 100644
--- a/drivers/bus/ti-sysc.c
+++ b/drivers/bus/ti-sysc.c
@@ -969,9 +969,9 @@ static int sysc_show_rev(char *bufp, struct sysc *ddata)
 	int len;
 
 	if (ddata->offsets[SYSC_REVISION] < 0)
-		return sprintf(bufp, ":NA");
+		return sysfs_emit(bufp, ":NA");
 
-	len = sprintf(bufp, ":%08x", ddata->revision);
+	len = sysfs_emit(bufp, ":%08x", ddata->revision);
 
 	return len;
 }
@@ -980,9 +980,9 @@ static int sysc_show_reg(struct sysc *ddata,
 			 char *bufp, enum sysc_registers reg)
 {
 	if (ddata->offsets[reg] < 0)
-		return sprintf(bufp, ":NA");
+		return sysfs_emit(bufp, ":NA");
 
-	return sprintf(bufp, ":%x", ddata->offsets[reg]);
+	return sysfs_emit(bufp, ":%x", ddata->offsets[reg]);
 }
 
 static int sysc_show_name(char *bufp, struct sysc *ddata)
@@ -990,7 +990,7 @@ static int sysc_show_name(char *bufp, struct sysc *ddata)
 	if (!ddata->name)
 		return 0;
 
-	return sprintf(bufp, ":%s", ddata->name);
+	return sysfs_emit(bufp, ":%s", ddata->name);
 }
 
 /**
-- 
2.27.0

