Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4BD86E508D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 21:05:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230331AbjDQTFD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 15:05:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230186AbjDQTE6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 15:04:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93F021FF3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 12:04:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2A922623F0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 19:04:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D49D6C4339B;
        Mon, 17 Apr 2023 19:04:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681758296;
        bh=WQfGLRATu5yNqviGHfeBkCPNz4Cl1WILm/qvutnMXWM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dmjUVyzkqRGC4Yojq0nM+pzKAoFDXDU3sVCdhZ3hv2uEK5wjYbcmA3aTqHR+GuGh4
         uEct+GTMJZbVjpj5FAlkfhw1EVUoO7XvwA0m1qaNQOkDbawzVhGrZfU9wkL/e3A2Nl
         jOGKt40oSlBMO2ZkGesT6jY+Mz6QSKGQEJ6kGbb8A2x8+10XVbMdhbJLYEWKWl3TgS
         EMSeGVNi9cZ3LvKM0rqDRcNRqrvXgcEbZU0UQehUPp2UDMFVE2XQWrl0HldWnRwgNO
         1kyLYV2jiJv1yz9VGjAXR6a+zhEWjYF7P8pjnlnMW3k2DY9TWQKx94lB9ZUCVlVFYs
         CkenS7BaVQY0A==
From:   SeongJae Park <sj@kernel.org>
To:     akpm@linux-foundation.org
Cc:     SeongJae Park <sj@kernel.org>, vbabka@suse.cz, willy@infradead.org,
        paulmck@kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/2] mm/slab: break up RCU readers on SLAB_TYPESAFE_BY_RCU example code
Date:   Mon, 17 Apr 2023 19:04:50 +0000
Message-Id: <20230417190450.1682-3-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230417190450.1682-1-sj@kernel.org>
References: <20230417190450.1682-1-sj@kernel.org>
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

The SLAB_TYPESAFE_BY_RCU example code snippet uses a single RCU
read-side critical section for retries.
'Documentation/RCU/rculist_nulls.rst' has similar example code snippet,
and commit da82af04352b ("doc: Update and wordsmith rculist_nulls.rst")
broke it up.  Apply the change to SLAB_TYPESAFE_BY_RCU example code
snippet, too.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 include/linux/slab.h | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/include/linux/slab.h b/include/linux/slab.h
index b18e56c6f06c..6acf1b7c6551 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -53,16 +53,18 @@
  * stays valid, the trick to using this is relying on an independent
  * object validation pass. Something like:
  *
+ * begin:
  *  rcu_read_lock();
- * again:
  *  obj = lockless_lookup(key);
  *  if (obj) {
  *    if (!try_get_ref(obj)) // might fail for free objects
- *      goto again;
+ *      rcu_read_unlock();
+ *      goto begin;
  *
  *    if (obj->key != key) { // not the object we expected
  *      put_ref(obj);
- *      goto again;
+ *      rcu_read_unlock();
+ *      goto begin;
  *    }
  *  }
  *  rcu_read_unlock();
-- 
2.25.1

