Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED85C6FE2FA
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 19:03:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236264AbjEJRDa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 13:03:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236138AbjEJRDZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 13:03:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11ECF5276;
        Wed, 10 May 2023 10:03:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C477964A2F;
        Wed, 10 May 2023 17:02:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06901C433A1;
        Wed, 10 May 2023 17:02:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683738164;
        bh=txQDJDLfcrk89uoEEXKL4LZWnIrpTUCXeBg768P6sLs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uIJWv3bDn2hFfC3GAznQKTfEIn92fqAADGNsdFRt24u/29/slTTyOIBocfq0g6l4N
         hP16khOH4RVpTapoxN0aiNt7XqwJlLFn0PWuKJ5bjUL20abVXnDMsVnqchKpVDKJ0c
         juQ5Z09scxOuxTXQqSA69FuE5lnAabTg8vu5bf2MKygUgoYnJtfLXjpLRWUuitfIBz
         hJlvVmQlWVN3HLbX90MwIFkKtEjuHeUS4hvE6Go5C/HNmOAGoRNa2GPwkxfgIfdK/1
         Hw/omcb7AF7rKOB1vdAdx/rN+pn3Y/DXCXDNN1tK0UYcCCPLsvmdpKuO93+/eXZLxp
         Fj6l3XJrDZUnQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 5A4C3CE1348; Wed, 10 May 2023 10:02:43 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, Zqiang <qiang1.zhang@intel.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 7/8] rcu/kvfree: Make fill page cache start from krcp->nr_bkv_objs
Date:   Wed, 10 May 2023 10:02:41 -0700
Message-Id: <20230510170242.2187714-7-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <1c01c38f-3783-44d7-8c11-7416cd5b849c@paulmck-laptop>
References: <1c01c38f-3783-44d7-8c11-7416cd5b849c@paulmck-laptop>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zqiang <qiang1.zhang@intel.com>

When the fill_page_cache_func() function is invoked, it assumes that
the cache of pages is completely empty.  However, there can be some time
between triggering execution of this function and its actual invocation.
During this time, kfree_rcu_work() might run, and might fill in part or
all of this cache of pages, thus invalidating the fill_page_cache_func()
function's assumption.

This will not overfill the cache because put_cached_bnode() will reject
the extra page.  However, it will result in a needless allocation and
freeing of one extra page, which might not be helpful under lowish-memory
conditions.

This commit therefore causes the fill_page_cache_func() to explicitly
account for pages that have been placed into the cache shortly before
it starts running.

Signed-off-by: Zqiang <qiang1.zhang@intel.com>
Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 18f592bf6dc6..98f2e833e217 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3201,7 +3201,7 @@ static void fill_page_cache_func(struct work_struct *work)
 	nr_pages = atomic_read(&krcp->backoff_page_cache_fill) ?
 		1 : rcu_min_cached_objs;
 
-	for (i = 0; i < nr_pages; i++) {
+	for (i = READ_ONCE(krcp->nr_bkv_objs); i < nr_pages; i++) {
 		bnode = (struct kvfree_rcu_bulk_data *)
 			__get_free_page(GFP_KERNEL | __GFP_NORETRY | __GFP_NOMEMALLOC | __GFP_NOWARN);
 
-- 
2.40.1

