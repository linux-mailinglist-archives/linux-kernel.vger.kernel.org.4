Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD8296E1AA0
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 05:09:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229571AbjDNDJL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 23:09:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjDNDJI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 23:09:08 -0400
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D5401998;
        Thu, 13 Apr 2023 20:09:06 -0700 (PDT)
X-UUID: 12db5403e36046049364e194e7c8e264-20230414
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.22,REQID:5ce2be2d-84dd-428d-ac01-1c1a80930b4b,IP:-32
        768,URL:-32768,TC:-32768,Content:-32768,EDM:-32768,RT:-32768,SF:-32768,FIL
        E:-32768,BULK:-32768,RULE:Release_Ham,ACTION:release,TS:0
X-CID-INFO: VERSION:1.1.22,REQID:5ce2be2d-84dd-428d-ac01-1c1a80930b4b,IP:-3276
        8,URL:-32768,TC:-32768,Content:-32768,EDM:-32768,RT:-32768,SF:-32768,FILE:
        -32768,BULK:-32768,RULE:Release_Ham,ACTION:release,TS:0
X-CID-META: VersionHash:120426c,CLOUDID:nil,BulkID:nil,BulkQuantity:0,Recheck:
        0,SF:nil,TC:nil,Content:nil,EDM:nil,IP:nil,URL:nil,File:nil,Bulk:nil,QS:ni
        l,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-UUID: 12db5403e36046049364e194e7c8e264-20230414
X-User: zenghao@kylinos.cn
Received: from zdzh5-qitianm428-a376.. [(116.128.244.169)] by mailgw
        (envelope-from <zenghao@kylinos.cn>)
        (Generic MTA)
        with ESMTP id 1123143396; Fri, 14 Apr 2023 11:08:32 +0800
From:   Hao Zeng <zenghao@kylinos.cn>
To:     skhan@linuxfoundation.org
Cc:     trenn@suse.com, shuah@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Hao Zeng <zenghao@kylinos.cn>
Subject: [PATCH v2] cpupower:Fix resource leaks in sysfs_get_enabled()
Date:   Fri, 14 Apr 2023 11:08:30 +0800
Message-Id: <20230414030830.3829332-1-zenghao@kylinos.cn>
X-Mailer: git-send-email 2.37.2
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

When the read return value is equal to 1, a file handle leak will occur

Signed-off-by: Hao Zeng <zenghao@kylinos.cn>
Suggested-by: Shuah Khan <skhan@linuxfoundation.org>
---
 tools/power/cpupower/lib/powercap.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/tools/power/cpupower/lib/powercap.c b/tools/power/cpupower/lib/powercap.c
index 0ce29ee4c2e4..02ec5b0bff6b 100644
--- a/tools/power/cpupower/lib/powercap.c
+++ b/tools/power/cpupower/lib/powercap.c
@@ -40,7 +40,7 @@ static int sysfs_get_enabled(char *path, int *mode)
 {
 	int fd;
 	char yes_no;
-
+	int ret = 0;
 	*mode = 0;
 
 	fd = open(path, O_RDONLY);
@@ -48,17 +48,18 @@ static int sysfs_get_enabled(char *path, int *mode)
 		return -1;
 
 	if (read(fd, &yes_no, 1) != 1) {
-		close(fd);
-		return -1;
+		ret = -1;
+		goto err;
 	}
 
-	if (yes_no == '1') {
-		*mode = 1;
-		return 0;
-	} else if (yes_no == '0') {
-		return 0;
+	if (yes_no != '1' || yes_no != '0') {
+		ret = -1;
+		goto err;
 	}
-	return -1;
+	*mode = yes_no - '0';
+err:
+	close(fd);
+	return ret;
 }
 
 int powercap_get_enabled(int *mode)
-- 
2.37.2


No virus found
		Checked by Hillstone Network AntiVirus
