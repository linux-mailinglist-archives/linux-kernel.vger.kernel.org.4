Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A8C6623B18
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 06:00:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbiKJFA5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 00:00:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiKJFAw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 00:00:52 -0500
Received: from out203-205-221-205.mail.qq.com (out203-205-221-205.mail.qq.com [203.205.221.205])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCEA4165A6
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 21:00:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1668056447;
        bh=lQ05UohQZFPg34PCvRKS5qsX2szAvngpSSLP9PSdRMI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=Ehmt7HFhouq+7h+nJ37ndJASctGhep751nHTMvccRFKpGHQUe3P9uF1hfyDVDHCWx
         Yi1zDx06Mhpecuvs1sKIlvvatKUf0AUJJr/w6+1vhTY1AUZrRvMFiqdxxNf3NF569L
         Y4Dmm/4xOwjCkBNh15yf1BTPJWfHhn4cTZZoVz3M=
Received: from localhost.localdomain ([39.156.73.13])
        by newxmesmtplogicsvrszc1-0.qq.com (NewEsmtp) with SMTP
        id 2C8461A; Thu, 10 Nov 2022 13:00:44 +0800
X-QQ-mid: xmsmtpt1668056444tr7a92mjm
Message-ID: <tencent_B7D657EF5135C40D0303A1C3AC90CB0B9507@qq.com>
X-QQ-XMAILINFO: NEq0i4SycP3bv+65xr1ALYKbv+MlBVuPbWw8eCgzgosWvCsW3Qh9AAkPtfDrYR
         cn/12nGPzEyM23Gum3A0dRboExwLKrQuuFBSw4rvX750CGqPQwopCG6RehRRTNuDfZ+L0+l+btFs
         ciK42iYGkWE7lHxq7hcDqK783c3h7Dl1BKuCB1kEbqfxtYGcAijglb/e8MC/Xp1aiQ5mLyOWzsFT
         RT1wq6JBdtuzAkdTxKgJrs1EgQF6M7mnoDjF9JJwHZDa8xn2lzZ3H1uRB2T8HzF+kJYwxt6iKJsf
         J+oBT5mc7pCnXJviLffP4/7bHcZD3q85jfKnU0hTqyC3zWcqt1Jkh/h+ScvROhBjzs51nArPgD5N
         UuxOOzKS7YYjSr//GhiN9AX6Cj/bPNJBk84Q994UWoaM4kxNL3k3GqFmhVXmw/w1r9YkmlbYa8Fi
         jrBRtqSsvUmeIeppVv4Gu8t5aqsGuw+SVf2rFKvxdnD189erxbyII/4x5XVOlRMTaWF16AoQb3kr
         OGbPSy6fEHsHbNLKhBqEg3h56pAiIzt8NtQ98qEsWirCfxa1UtJBuBWhk6+64jVSAJNCnExIafXh
         UH49Xc/udFxp/TjXlAgGSiZVdNGODkoo+mECpspb0REXGHQFy3x3Sd3AG1pr8Bb0aRDgBFq8qrNu
         kfBV+3QP/1IIl3U46/jHnAfLWDEK/rIiPgdqQ7TyF3s2YDUBZGdwH79GnJFK1zmged9UGUob5OvX
         YLZfMZgvOMls5432GQhITw0/+Ux6PWfshVczS7hory3G7p1HVmIaafgaBh/ApKY/+0yz86FesyfW
         tS0dVNjG3loHnVwhYFT4EvGF8S1MLBCOwP4ME7KpXg+c2SGBHpNlt++uswHEhdEaR7Ji9fnDOt/q
         K4c2PX4yr+opDfGYQPnFOGzN5Bb/TxcYW9qHsAli8syWhY/z5QbkVjle4xY2pU+88Bm6a+tHef02
         6xwnuATAtD3HFguH5aFOfa4qCrVeAH1OY5kMbHbH33GQtqHvOYuwMas5wQXmPioaFJqlfmhic=
From:   Rong Tao <rtoax@foxmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org, rongtao@cestc.cn,
        rtoax@foxmail.com, willy@infradead.org, wuchi.zero@gmail.com
Subject: [PATCH] lib/radix-tree: Fix uninitialized variable compilation warning
Date:   Thu, 10 Nov 2022 13:00:42 +0800
X-OQ-MSGID: <20221110050042.88361-1-rtoax@foxmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221109162348.3dbde3a7942c303af012276c@linux-foundation.org>
References: <20221109162348.3dbde3a7942c303af012276c@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,RDNS_DYNAMIC,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rong Tao <rongtao@cestc.cn>

We need to set an initial value for offset to eliminate compilation
warning. And if the tree is empty, return NULL early.

How to reproduce warning:

$ make -C tools/testing/radix-tree
radix-tree.c: In function ‘radix_tree_tag_clear’:
radix-tree.c:1046:17: warning: ‘offset’ may be used uninitialized in this function [-Wmaybe-uninitialized]
1046 |                 node_tag_clear(root, parent, tag, offset);
     |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Signed-off-by: Rong Tao <rongtao@cestc.cn>
---
 lib/radix-tree.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/radix-tree.c b/lib/radix-tree.c
index 3c78e1e8b2ad..eee453b856b6 100644
--- a/lib/radix-tree.c
+++ b/lib/radix-tree.c
@@ -1029,10 +1029,10 @@ void *radix_tree_tag_clear(struct radix_tree_root *root,
 {
 	struct radix_tree_node *node, *parent;
 	unsigned long maxindex;
-	int offset;
+	int offset = 0;
 
 	radix_tree_load_root(root, &node, &maxindex);
-	if (index > maxindex)
+	if (index > maxindex || !node)
 		return NULL;
 
 	parent = NULL;
-- 
2.31.1

