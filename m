Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FFCD60C6DA
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 10:47:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231324AbiJYIrV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 04:47:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbiJYIrS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 04:47:18 -0400
Received: from mail.nfschina.com (unknown [124.16.136.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A303A2F034;
        Tue, 25 Oct 2022 01:47:16 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id B12871E80C82;
        Tue, 25 Oct 2022 16:45:54 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id iADYo2F-nhmW; Tue, 25 Oct 2022 16:45:52 +0800 (CST)
Received: from localhost.localdomain (unknown [219.141.250.2])
        (Authenticated sender: zeming@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id 1AEC41E80C80;
        Tue, 25 Oct 2022 16:45:52 +0800 (CST)
From:   Li zeming <zeming@nfschina.com>
To:     willy@infradead.org, jlayton@kernel.org, song@kernel.org,
        bvanassche@acm.org, neilb@suse.de
Cc:     reiserfs-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Li zeming <zeming@nfschina.com>
Subject: [PATCH] reiserfs: journal: Increase jl pointer check
Date:   Tue, 25 Oct 2022 16:47:04 +0800
Message-Id: <20221025084704.3922-1-zeming@nfschina.com>
X-Mailer: git-send-email 2.18.2
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If kzalloc fails to allocate the jl pointer, NULL is returned directly.

Signed-off-by: Li zeming <zeming@nfschina.com>
---
 fs/reiserfs/journal.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/reiserfs/journal.c b/fs/reiserfs/journal.c
index 94addfcefede..d64e9de126c1 100644
--- a/fs/reiserfs/journal.c
+++ b/fs/reiserfs/journal.c
@@ -2569,6 +2569,9 @@ static struct reiserfs_journal_list *alloc_journal_list(struct super_block *s)
 	struct reiserfs_journal_list *jl;
 	jl = kzalloc(sizeof(struct reiserfs_journal_list),
 		     GFP_NOFS | __GFP_NOFAIL);
+	if (!jl)
+		return NULL;
+
 	INIT_LIST_HEAD(&jl->j_list);
 	INIT_LIST_HEAD(&jl->j_working_list);
 	INIT_LIST_HEAD(&jl->j_tail_bh_list);
-- 
2.18.2

