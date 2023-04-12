Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ECD36DF074
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 11:31:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231516AbjDLJbl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 05:31:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231501AbjDLJb3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 05:31:29 -0400
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C950561B4
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 02:31:10 -0700 (PDT)
X-UUID: 977d1cfac60f42e38a9c55505f7af3aa-20230412
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.22,REQID:018868c1-4bc0-4ec3-9656-5f7ae3677c0a,IP:5,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:-10
X-CID-INFO: VERSION:1.1.22,REQID:018868c1-4bc0-4ec3-9656-5f7ae3677c0a,IP:5,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:-10
X-CID-META: VersionHash:120426c,CLOUDID:9e5ad083-cd9c-45f5-8134-710979e3df0e,B
        ulkID:230412173051028PMDJ2,BulkQuantity:0,Recheck:0,SF:24|17|19|44|38|102,
        TC:nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
        ,OSI:0,OSA:0,AV:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-UUID: 977d1cfac60f42e38a9c55505f7af3aa-20230412
X-User: zenghao@kylinos.cn
Received: from zdzh5-qitianm428-a376.. [(116.128.244.169)] by mailgw
        (envelope-from <zenghao@kylinos.cn>)
        (Generic MTA)
        with ESMTP id 1359329413; Wed, 12 Apr 2023 17:30:50 +0800
From:   Hao Zeng <zenghao@kylinos.cn>
To:     chenhuacai@kernel.org, rostedt@goodmis.org, zhangqing@loongson.cn,
        linux-kernel@vger.kernel.org
Cc:     Hao Zeng <zenghao@kylinos.cn>
Subject: [PATCH] recordmcount: Fix memory leaks in the uwrite function
Date:   Wed, 12 Apr 2023 17:30:48 +0800
Message-Id: <20230412093048.3005276-1-zenghao@kylinos.cn>
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

Common realloc mistake: 'file_append' nulled but not freed upon failure

Signed-off-by: Hao Zeng <zenghao@kylinos.cn>
---
 scripts/recordmcount.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/scripts/recordmcount.c b/scripts/recordmcount.c
index e30216525325..2b7173a86d4c 100644
--- a/scripts/recordmcount.c
+++ b/scripts/recordmcount.c
@@ -110,22 +110,23 @@ static ssize_t uwrite(void const *const buf, size_t const count)
 {
 	size_t cnt = count;
 	off_t idx = 0;
-
+	void *p = NULL;
 	file_updated = 1;
 
 	if (file_ptr + count >= file_end) {
 		off_t aoffset = (file_ptr + count) - file_end;
 
 		if (aoffset > file_append_size) {
-			file_append = realloc(file_append, aoffset);
+			p = realloc(file_append, aoffset);
+			if (!p) {
+				perror("write");
+				file_append_cleanup();
+				mmap_cleanup();
+				return -1;
+			}
+			file_append = p;
 			file_append_size = aoffset;
 		}
-		if (!file_append) {
-			perror("write");
-			file_append_cleanup();
-			mmap_cleanup();
-			return -1;
-		}
 		if (file_ptr < file_end) {
 			cnt = file_end - file_ptr;
 		} else {
-- 
2.37.2


No virus found
		Checked by Hillstone Network AntiVirus
