Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CDA66FE2FC
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 19:03:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236364AbjEJRDf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 13:03:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236319AbjEJRD2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 13:03:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C44B115;
        Wed, 10 May 2023 10:03:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CE8FF64A2D;
        Wed, 10 May 2023 17:02:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F46BC433A7;
        Wed, 10 May 2023 17:02:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683738164;
        bh=T2PP2RT6SZHp2JZxt61wF7BysGP/eXTSVvR5ZsRLK6E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LPDDps13cQGMdapFCTpx/0au0jFJD6sUSA3QEFhJN7jDo1Xz4JVaeF7oE1A1h5QLN
         LTsLOSn1vU6q7Huq67ko2XK6WcB8UI/vmcfPLFe1gCZMoxUOqig4zeVmC2yYkRt99L
         8IEipqOgSjpRemuN1kJRFIig1Do3hp9z8+q+d8rdmBmPgOmRNx2jERhRWTAKgMPUtb
         1Tme4AaYcVLjNOVLgEdbBEBfd79pPZXCNuxtBH0x5LI4yw4Qmr+R4hSh7trNKUbgmT
         sSh7JzxOeW+xY71EsBZIohxPFayfbJIShqENsn+sQceXT/N0WL1jgU/HlgyF6h395e
         wzXUhanZwEfcg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 5C666CE1349; Wed, 10 May 2023 10:02:43 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, Zqiang <qiang1.zhang@intel.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 8/8] rcu/kvfree: Make drain_page_cache() take early return if cache is disabled
Date:   Wed, 10 May 2023 10:02:42 -0700
Message-Id: <20230510170242.2187714-8-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <1c01c38f-3783-44d7-8c11-7416cd5b849c@paulmck-laptop>
References: <1c01c38f-3783-44d7-8c11-7416cd5b849c@paulmck-laptop>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zqiang <qiang1.zhang@intel.com>

If the rcutree.rcu_min_cached_objs kernel boot parameter is set to zero,
then krcp->page_cache_work will never be triggered to fill page cache.
In addition, the put_cached_bnode() will not fill page cache.  As a
result krcp->bkvcache will always be empty, so there is no need to acquire
krcp->lock to get page from krcp->bkvcache.  This commit therefore makes
drain_page_cache() return immediately if the rcu_min_cached_objs is zero.

Signed-off-by: Zqiang <qiang1.zhang@intel.com>
Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 98f2e833e217..00ed45ddc6ca 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2902,6 +2902,9 @@ drain_page_cache(struct kfree_rcu_cpu *krcp)
 	struct llist_node *page_list, *pos, *n;
 	int freed = 0;
 
+	if (!rcu_min_cached_objs)
+		return 0;
+
 	raw_spin_lock_irqsave(&krcp->lock, flags);
 	page_list = llist_del_all(&krcp->bkvcache);
 	WRITE_ONCE(krcp->nr_bkv_objs, 0);
-- 
2.40.1

