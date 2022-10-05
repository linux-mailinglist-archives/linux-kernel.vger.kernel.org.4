Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69B375F57D2
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 17:51:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230196AbiJEPvY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 11:51:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230041AbiJEPvP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 11:51:15 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C569D45F4D
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 08:51:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2A5E8B81E72
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 15:51:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB825C43142;
        Wed,  5 Oct 2022 15:51:11 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1og6g0-0028Hj-14;
        Wed, 05 Oct 2022 11:51:16 -0400
Message-ID: <20221005155116.161332893@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 05 Oct 2022 11:50:33 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Chen Zhongjin <chenzhongjin@huawei.com>
Subject: [for-next][PATCH 3/5] tracing: Remove unused variable dups
References: <20221005155030.594135087@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chen Zhongjin <chenzhongjin@huawei.com>

Reported by Clang [-Wunused-but-set-variable]

'commit c193707dde77 ("tracing: Remove code which merges duplicates")'
This commit removed the code which merges duplicates in detect_dups(),
but forgot to delete the variable 'dups' which used to merge
duplicates in the loop.

Now only 'total_dups' is needed, remove 'dups' for clean code.

Link: https://lkml.kernel.org/r/20220930103236.253985-1-chenzhongjin@huawei.com

Signed-off-by: Chen Zhongjin <chenzhongjin@huawei.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/tracing_map.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/tracing_map.c b/kernel/trace/tracing_map.c
index 9901708ce6b8..c774e560f2f9 100644
--- a/kernel/trace/tracing_map.c
+++ b/kernel/trace/tracing_map.c
@@ -961,7 +961,7 @@ create_sort_entry(void *key, struct tracing_map_elt *elt)
 static void detect_dups(struct tracing_map_sort_entry **sort_entries,
 		      int n_entries, unsigned int key_size)
 {
-	unsigned int dups = 0, total_dups = 0;
+	unsigned int total_dups = 0;
 	int i;
 	void *key;
 
@@ -974,11 +974,10 @@ static void detect_dups(struct tracing_map_sort_entry **sort_entries,
 	key = sort_entries[0]->key;
 	for (i = 1; i < n_entries; i++) {
 		if (!memcmp(sort_entries[i]->key, key, key_size)) {
-			dups++; total_dups++;
+			total_dups++;
 			continue;
 		}
 		key = sort_entries[i]->key;
-		dups = 0;
 	}
 
 	WARN_ONCE(total_dups > 0,
-- 
2.35.1
