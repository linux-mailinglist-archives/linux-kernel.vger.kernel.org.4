Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E76C719E07
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 15:28:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233938AbjFAN2S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 09:28:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233925AbjFAN2E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 09:28:04 -0400
Received: from out-11.mta0.migadu.com (out-11.mta0.migadu.com [91.218.175.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 881B6E53
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 06:27:42 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1685626058;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=PXhO3otjBtuh+Ck91TNKKziYmrluCv2b48DIjrztc9w=;
        b=nROl794SQspeHQtioYrDX4qM6UQfGameVH8C+yWUZLeMtwi5yDU/j2qDEtD0MSBHq5NfMt
        tP0VEQaXLg4nJgqvjifARX+/DDfx5wTACWKXU8aF85yB+uaxLinKfzh1TZRee5G092gVHU
        tFHOmVv59+wob5wVJILMtR5F+ohCZxw=
From:   Qi Zheng <qi.zheng@linux.dev>
To:     akpm@linux-foundation.org, roman.gushchin@linux.dev
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH RESEND] mm: vmscan: move shrinker_debugfs_remove() before synchronize_srcu()
Date:   Thu,  1 Jun 2023 13:27:14 +0000
Message-Id: <20230601132714.2540707-1-qi.zheng@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Qi Zheng <zhengqi.arch@bytedance.com>

The debugfs_remove_recursive() will wait for debugfs_file_put()
to return, so there is no need to put it after synchronize_srcu()
to wait for the rcu read-side critical section to exit.

Just move it before synchronize_srcu(), which is also convenient
to put the heavy synchronize_srcu() in the delayed work later.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
Resend as an independent patch.

 mm/vmscan.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index eeca83e28c9b..a773e97e152e 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -818,11 +818,11 @@ void unregister_shrinker(struct shrinker *shrinker)
 	debugfs_entry = shrinker_debugfs_detach(shrinker, &debugfs_id);
 	mutex_unlock(&shrinker_mutex);
 
+	shrinker_debugfs_remove(debugfs_entry, debugfs_id);
+
 	atomic_inc(&shrinker_srcu_generation);
 	synchronize_srcu(&shrinker_srcu);
 
-	shrinker_debugfs_remove(debugfs_entry, debugfs_id);
-
 	kfree(shrinker->nr_deferred);
 	shrinker->nr_deferred = NULL;
 }
-- 
2.30.2

