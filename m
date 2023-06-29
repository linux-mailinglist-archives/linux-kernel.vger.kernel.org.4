Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C4CD741DCE
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 03:50:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231253AbjF2BmI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 21:42:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231769AbjF2BmA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 21:42:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 355CD2D56
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 18:41:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 772E3614B3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 01:41:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C131CC433C8;
        Thu, 29 Jun 2023 01:41:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688002898;
        bh=L7S8mzMQYGKIhxRcHxSQJwBqPxvW57dJoZChkWhi8UQ=;
        h=From:To:Cc:Subject:Date:From;
        b=h30G/Ady3rTuj4pHc4oWRB3blePjJz5XFd/9KEEWRzUxfvNqyc9o1X8gYVmzQ35zY
         BXqPAVyMc1TT5LcjStHIFg42667UMOGHH4zP/90dwcpi3gYTKxdecpNdM8uVAQi90+
         c0TEYq7vvUG88wqKf0unzA53ngGoVo6PtSw9iyNnln9emfTnZuXyhCnDWkK1bLLAkF
         O3H8upLiPGXvBgPtB8YK1+4MqvhzXG9Q56C/7rPDkYCbx9pNHfuMQSw/tI9chDB62h
         Oni7IlLkEPtbFaQhAn0vCri36+h72jw3QBkHHRNd1X4QLZBQDoBkq/EDhqk0QInEJN
         yppxRiS9wJroQ==
From:   Chao Yu <chao@kernel.org>
To:     jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <chao@kernel.org>
Subject: [PATCH] f2fs: fix compile warning in f2fs_destroy_node_manager()
Date:   Thu, 29 Jun 2023 09:41:34 +0800
Message-Id: <20230629014134.3058318-1-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

fs/f2fs/node.c: In function ‘f2fs_destroy_node_manager’:
fs/f2fs/node.c:3390:1: warning: the frame size of 1048 bytes is larger than 1024 bytes [-Wframe-larger-than=]
 3390 | }

Merging below pointer arrays into common one, and reuse it by cast type.

struct nat_entry *natvec[NATVEC_SIZE];
struct nat_entry_set *setvec[SETVEC_SIZE];

Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/node.c | 14 ++++++++------
 fs/f2fs/node.h |  3 +--
 2 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index dadea6b01888..3e1fa564db8f 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -3062,7 +3062,7 @@ int f2fs_flush_nat_entries(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 	struct f2fs_nm_info *nm_i = NM_I(sbi);
 	struct curseg_info *curseg = CURSEG_I(sbi, CURSEG_HOT_DATA);
 	struct f2fs_journal *journal = curseg->journal;
-	struct nat_entry_set *setvec[SETVEC_SIZE];
+	struct nat_entry_set *setvec[NAT_VEC_SIZE];
 	struct nat_entry_set *set, *tmp;
 	unsigned int found;
 	nid_t set_idx = 0;
@@ -3095,7 +3095,7 @@ int f2fs_flush_nat_entries(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 		remove_nats_in_journal(sbi);
 
 	while ((found = __gang_lookup_nat_set(nm_i,
-					set_idx, SETVEC_SIZE, setvec))) {
+					set_idx, NAT_VEC_SIZE, setvec))) {
 		unsigned idx;
 
 		set_idx = setvec[found - 1]->set + 1;
@@ -3316,8 +3316,9 @@ void f2fs_destroy_node_manager(struct f2fs_sb_info *sbi)
 {
 	struct f2fs_nm_info *nm_i = NM_I(sbi);
 	struct free_nid *i, *next_i;
-	struct nat_entry *natvec[NATVEC_SIZE];
-	struct nat_entry_set *setvec[SETVEC_SIZE];
+	void *vec[NAT_VEC_SIZE];
+	struct nat_entry **natvec = (struct nat_entry **)vec;
+	struct nat_entry_set **setvec = (struct nat_entry_set **)vec;
 	nid_t nid = 0;
 	unsigned int found;
 
@@ -3340,7 +3341,7 @@ void f2fs_destroy_node_manager(struct f2fs_sb_info *sbi)
 	/* destroy nat cache */
 	f2fs_down_write(&nm_i->nat_tree_lock);
 	while ((found = __gang_lookup_nat_cache(nm_i,
-					nid, NATVEC_SIZE, natvec))) {
+					nid, NAT_VEC_SIZE, natvec))) {
 		unsigned idx;
 
 		nid = nat_get_nid(natvec[found - 1]) + 1;
@@ -3356,8 +3357,9 @@ void f2fs_destroy_node_manager(struct f2fs_sb_info *sbi)
 
 	/* destroy nat set cache */
 	nid = 0;
+	memset(vec, 0, sizeof(void *) * NAT_VEC_SIZE);
 	while ((found = __gang_lookup_nat_set(nm_i,
-					nid, SETVEC_SIZE, setvec))) {
+					nid, NAT_VEC_SIZE, setvec))) {
 		unsigned idx;
 
 		nid = setvec[found - 1]->set + 1;
diff --git a/fs/f2fs/node.h b/fs/f2fs/node.h
index 906fb67a99da..5bd16a95eef8 100644
--- a/fs/f2fs/node.h
+++ b/fs/f2fs/node.h
@@ -35,8 +35,7 @@
 #define DEF_RF_NODE_BLOCKS			0
 
 /* vector size for gang look-up from nat cache that consists of radix tree */
-#define NATVEC_SIZE	64
-#define SETVEC_SIZE	32
+#define NAT_VEC_SIZE	32
 
 /* return value for read_node_page */
 #define LOCKED_PAGE	1
-- 
2.40.1

