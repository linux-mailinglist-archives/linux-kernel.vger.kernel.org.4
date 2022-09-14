Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C6845B8614
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 12:18:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229673AbiINKSu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 06:18:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbiINKSs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 06:18:48 -0400
Received: from out30-43.freemail.mail.aliyun.com (out30-43.freemail.mail.aliyun.com [115.124.30.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0BE777EB0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 03:18:46 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VPn2tTg_1663150711;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0VPn2tTg_1663150711)
          by smtp.aliyun-inc.com;
          Wed, 14 Sep 2022 18:18:44 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     Liam.Howlett@oracle.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH] Maple Tree: Remove unused functions mte_set_full and mte_clear_full
Date:   Wed, 14 Sep 2022 18:18:29 +0800
Message-Id: <20220914101829.82000-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mte_set_full and mte_clear_full are defined in the maple_tree.c file,
but not called elsewhere, so delete these unused function.

lib/maple_tree.c:330:20: warning: unused function 'mte_set_full'.
lib/maple_tree.c:335:20: warning: unused function 'mte_clear_full'.

Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=2156
Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 lib/maple_tree.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index e1743803c851..e31b5b1f71d7 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -327,16 +327,6 @@ static inline void *mte_safe_root(const struct maple_enode *node)
 	return (void *)((unsigned long)node & ~MAPLE_ROOT_NODE);
 }
 
-static inline void mte_set_full(const struct maple_enode *node)
-{
-	node = (void *)((unsigned long)node & ~MAPLE_ENODE_NULL);
-}
-
-static inline void mte_clear_full(const struct maple_enode *node)
-{
-	node = (void *)((unsigned long)node | MAPLE_ENODE_NULL);
-}
-
 static inline bool ma_is_root(struct maple_node *node)
 {
 	return ((unsigned long)node->parent & MA_ROOT_PARENT);
-- 
2.20.1.7.g153144c

