Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AACC6BE18B
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 07:50:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230171AbjCQGuI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 02:50:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230084AbjCQGuG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 02:50:06 -0400
Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 127037B98B
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 23:50:01 -0700 (PDT)
X-QQ-mid: bizesmtp84t1679035776tgbpfpnz
Received: from utnb-jevon.. ( [1.202.39.170])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Fri, 17 Mar 2023 14:49:27 +0800 (CST)
X-QQ-SSF: 0140000000000070B000000A0000000
X-QQ-FEAT: dKvkn8qoLrEdStsMLkXGi1P3bKv4zF9smMHGhqZHCQB2/2FlEeen8CmUBHHf9
        3W34kGB4LUMxRR+n9YKaBswwi3AI9smFxMUGMjOenJVm171w0yWkJTjPofQBIcGLuzK2Pnn
        RxC3qRhCkWrMHBl488TbBfhzGG2RWK77s7hyygzMjyJY7HxrQqesiE/TWhqAt3bSO12fXJX
        E9Ul3DuAzMqZVXtdqB1YDrIY1TnX2n3A2ukpcgQ4TDm7XxZydnqL1yFvBKv8P/ieZNHM7Ce
        brLgJ2RZaErzdLGoLmWSSjXGgYUgrswwHxvH330+Vhi0LywllPZXAJ61mkHUbNEyNLXftAe
        nm0XHMx5c8dS0Kt0THg5vzFDdUHt+ulP77GVX+dnavKbVS1cg23NFy6NyHAncx3LW4l/MOo
        FVBrqgdiQc4=
X-QQ-GoodBg: 1
From:   Jianwen Jiang <jiangjianwen@uniontech.com>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        guoke@uniontech.com, jiangjianwen@uniontech.com
Subject: [PATCH] kvm: mmu: move the added page that exists in current lru list to its tail
Date:   Fri, 17 Mar 2023 14:49:20 +0800
Message-Id: <20230317064920.12700-1-jiangjianwen@uniontech.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybglogicsvr:qybglogicsvr5
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: jevon jiang <jiangjianwen@uniontech.com>

If the added page existing in current lru list, it's better to move that
page to the end of that list. This modification can prolong the lifecycle
of activated page and decrease I/O requirements while memory is limited.

Signed-off-by: jevon jiang <jiangjianwen@uniontech.com>
---
 mm/list_lru.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/mm/list_lru.c b/mm/list_lru.c
index a05e5bef3b40..9562e7aea535 100644
--- a/mm/list_lru.c
+++ b/mm/list_lru.c
@@ -124,7 +124,11 @@ bool list_lru_add(struct list_lru *lru, struct list_head *item)
 	struct list_lru_one *l;
 
 	spin_lock(&nlru->lock);
-	if (list_empty(item)) {
+	if (!list_empty(item)) {
+		l = list_lru_from_kmem(lru, nid, item, NULL);
+		list_del_init(item);
+		list_add_tail(item, &l->list);
+	} else {
 		l = list_lru_from_kmem(lru, nid, item, &memcg);
 		list_add_tail(item, &l->list);
 		/* Set shrinker bit if the first element was added */
-- 
2.34.1

