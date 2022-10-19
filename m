Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20673603A19
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 08:52:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbiJSGwQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 02:52:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbiJSGwO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 02:52:14 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28CD66D9D8
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 23:52:14 -0700 (PDT)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4MshDF1WqMzJn1m;
        Wed, 19 Oct 2022 14:49:33 +0800 (CST)
Received: from huawei.com (10.175.101.6) by kwepemi500012.china.huawei.com
 (7.221.188.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 19 Oct
 2022 14:51:37 +0800
From:   Li Zetao <lizetao1@huawei.com>
To:     <dwmw2@infradead.org>, <richard@nod.at>
CC:     <lizetao1@huawei.com>, <miquel.raynal@bootlin.com>,
        <kernel@kempniu.pl>, <tglx@cruncher.tec.linutronix.de>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] jffs2: fix lock not released on error handling path in jffs2_flash_writev()
Date:   Wed, 19 Oct 2022 15:54:58 +0800
Message-ID: <20221019075458.2072174-1-lizetao1@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemi500012.china.huawei.com (7.221.188.12)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When jffs2_sum_add_kvec() returns an error in jffs2_flash_writev(), the
write lock will not be released, resulting in a deadlock.

Fix it by releasing the write lock on error handling path.

Fixes: dcb0932884b8 ("[JFFS2] Simplify writebuffer handling")
Signed-off-by: Li Zetao <lizetao1@huawei.com>
---
 fs/jffs2/wbuf.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/fs/jffs2/wbuf.c b/fs/jffs2/wbuf.c
index 4061e0ba7010..ba3e9f4ba1d8 100644
--- a/fs/jffs2/wbuf.c
+++ b/fs/jffs2/wbuf.c
@@ -903,9 +903,9 @@ int jffs2_flash_writev(struct jffs2_sb_info *c, const struct kvec *invecs,
 	*retlen = donelen;
 
 	if (jffs2_sum_active()) {
-		int res = jffs2_sum_add_kvec(c, invecs, count, (uint32_t) to);
-		if (res)
-			return res;
+		ret = jffs2_sum_add_kvec(c, invecs, count, (uint32_t) to);
+		if (ret)
+			goto outsum;
 	}
 
 	if (c->wbuf_len && ino)
@@ -930,6 +930,8 @@ int jffs2_flash_writev(struct jffs2_sb_info *c, const struct kvec *invecs,
 
 outerr:
 	*retlen = 0;
+
+outsum:
 	up_write(&c->wbuf_sem);
 	return ret;
 }
-- 
2.31.1

