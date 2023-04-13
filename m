Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F09FE6E061A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 06:46:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbjDMEqS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 00:46:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbjDMEqR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 00:46:17 -0400
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2A7059F4;
        Wed, 12 Apr 2023 21:46:13 -0700 (PDT)
X-UUID: 88b58fc1a5574416af0bdbef49684799-20230413
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.22,REQID:1e4830ac-918e-4878-8fdf-8b271f98f3c4,IP:15,
        URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
        ON:release,TS:0
X-CID-INFO: VERSION:1.1.22,REQID:1e4830ac-918e-4878-8fdf-8b271f98f3c4,IP:15,UR
        L:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:0
X-CID-META: VersionHash:120426c,CLOUDID:c9a9cdea-db6f-41fe-8b83-13fe7ed1ef52,B
        ulkID:230413124607FPIJEWCS,BulkQuantity:0,Recheck:0,SF:44|38|24|17|19|102,
        TC:nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
        ,OSI:0,OSA:0,AV:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-UUID: 88b58fc1a5574416af0bdbef49684799-20230413
X-User: zenghao@kylinos.cn
Received: from zdzh5-qitianm428-a376.. [(116.128.244.169)] by mailgw
        (envelope-from <zenghao@kylinos.cn>)
        (Generic MTA)
        with ESMTP id 821352072; Thu, 13 Apr 2023 12:46:04 +0800
From:   Hao Zeng <zenghao@kylinos.cn>
To:     trenn@suse.com, shuah@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Hao Zeng <zenghao@kylinos.cn>
Subject: [PATCH] cpupower:Fix resource leaks in sysfs_get_enabled()
Date:   Thu, 13 Apr 2023 12:46:02 +0800
Message-Id: <20230413044602.3221453-1-zenghao@kylinos.cn>
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

The sysfs_get_enabled() opened file processor not closed,
may cause a file handle leak.

Signed-off-by: Hao Zeng <zenghao@kylinos.cn>
---
 tools/power/cpupower/lib/powercap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/power/cpupower/lib/powercap.c b/tools/power/cpupower/lib/powercap.c
index 0ce29ee4c2e4..a39ee1c89679 100644
--- a/tools/power/cpupower/lib/powercap.c
+++ b/tools/power/cpupower/lib/powercap.c
@@ -51,7 +51,7 @@ static int sysfs_get_enabled(char *path, int *mode)
 		close(fd);
 		return -1;
 	}
-
+	close(fd);
 	if (yes_no == '1') {
 		*mode = 1;
 		return 0;
-- 
2.37.2


No virus found
		Checked by Hillstone Network AntiVirus
