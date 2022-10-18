Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7A5B6031BB
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 19:42:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230130AbiJRRmf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 13:42:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbiJRRmc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 13:42:32 -0400
Received: from p3plwbeout26-02.prod.phx3.secureserver.net (p3plsmtp26-02-2.prod.phx3.secureserver.net [216.69.139.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDFF2EE88E
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 10:42:29 -0700 (PDT)
Received: from mailex.mailcore.me ([94.136.40.141])
        by :WBEOUT: with ESMTP
        id kqbjoTEhSaD3jkqbkoAt11; Tue, 18 Oct 2022 10:42:28 -0700
X-CMAE-Analysis: v=2.4 cv=T4FJ89GQ c=1 sm=1 tr=0 ts=634ee584
 a=bheWAUFm1xGnSTQFbH9Kqg==:117 a=84ok6UeoqCVsigPHarzEiQ==:17
 a=ggZhUymU-5wA:10 a=Qawa6l4ZSaYA:10 a=8QSNtyZ53ZY05QiGhuwA:9
X-SECURESERVER-ACCT: phillip@squashfs.org.uk  
X-SID:  kqbjoTEhSaD3j
Received: from 82-69-79-175.dsl.in-addr.zen.co.uk ([82.69.79.175] helo=phoenix.fritz.box)
        by smtp11.mailcore.me with esmtpa (Exim 4.94.2)
        (envelope-from <phillip@squashfs.org.uk>)
        id 1okqbj-0000Im-1l; Tue, 18 Oct 2022 18:42:27 +0100
From:   Phillip Lougher <phillip@squashfs.org.uk>
To:     phillip@squashfs.org.uk
Cc:     bagasdotme@gmail.com, hsinyi@chromium.org,
        linux-kernel@vger.kernel.org, marcmiltenberger@gmail.com,
        mirsad.todorovac@alu.unizg.hr, nicememory@gmail.com,
        regressions@leemhuis.info, regressions@lists.linux.dev,
        srw@sladewatkins.net
Subject: Re: BISECT result: 6.0.0-RC kernels trigger Firefox snap bug with 6.0.0-rc3 through 6.0.0-rc7
Date:   Tue, 18 Oct 2022 18:41:57 +0100
Message-Id: <20221018174157.1897-1-phillip@squashfs.org.uk>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cfe5dd3a-5820-98cf-ae31-b6a3ff3f0578@squashfs.org.uk>
References: <cfe5dd3a-5820-98cf-ae31-b6a3ff3f0578@squashfs.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailcore-Auth: 439999529
X-Mailcore-Domain: 1394945
X-123-reg-Authenticated:  phillip@squashfs.org.uk  
X-Originating-IP: 82.69.79.175
X-CMAE-Envelope: MS4xfAzOq15OjXOtpKqHv+wEeTuSh7GwJ+xWBUTbIgCl2ysxU/0uUhBqc046a+/sNRMrLA2GYxlPGtddNiNKgMhbjmNr8pqTwQVlMF9E7g+RjM2wiTMtUBtS
 E0Vxc2AE6011ZS7EBbFz88WpJpnbmKiOuEjxgB7cXV78si8ZSIRn7Ax9tZBvF39rbJo7I3CPQqRt50rVsmZyY7G9U/ivKX6wJ2I=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This diff has fixed the problem with my repoducer.
Please test and report your results.

Phillip

diff --git a/fs/squashfs/file.c b/fs/squashfs/file.c
index e56510964b22..e526eb7a1658 100644
--- a/fs/squashfs/file.c
+++ b/fs/squashfs/file.c
@@ -557,6 +557,7 @@ static void squashfs_readahead(struct readahead_control *ractl)
 		int res, bsize;
 		u64 block = 0;
 		unsigned int expected;
+		struct page *last_page;
 
 		nr_pages = __readahead_batch(ractl, pages, max_pages);
 		if (!nr_pages)
@@ -593,15 +594,15 @@ static void squashfs_readahead(struct readahead_control *ractl)
 
 		res = squashfs_read_data(inode->i_sb, block, bsize, NULL, actor);
 
-		squashfs_page_actor_free(actor);
+		last_page = squashfs_page_actor_free(actor);
 
 		if (res == expected) {
 			int bytes;
 
 			/* Last page (if present) may have trailing bytes not filled */
 			bytes = res % PAGE_SIZE;
-			if (pages[nr_pages - 1]->index == file_end && bytes)
-				memzero_page(pages[nr_pages - 1], bytes,
+			if (index == file_end && bytes && last_page)
+				memzero_page(last_page, bytes,
 					     PAGE_SIZE - bytes);
 
 			for (i = 0; i < nr_pages; i++) {
diff --git a/fs/squashfs/page_actor.c b/fs/squashfs/page_actor.c
index 54b93bf4a25c..6aa38f88e31c 100644
--- a/fs/squashfs/page_actor.c
+++ b/fs/squashfs/page_actor.c
@@ -53,6 +53,7 @@ struct squashfs_page_actor *squashfs_page_actor_init(void **buffer,
 	actor->pages = pages;
 	actor->next_page = 0;
 	actor->tmp_buffer = NULL;
+	actor->last_page = NULL;
 	actor->squashfs_first_page = cache_first_page;
 	actor->squashfs_next_page = cache_next_page;
 	actor->squashfs_finish_page = cache_finish_page;
@@ -71,11 +72,13 @@ static void *handle_next_page(struct squashfs_page_actor *actor)
 			(actor->next_index != actor->page[actor->next_page]->index)) {
 		actor->next_index++;
 		actor->returned_pages++;
+		actor->last_page = NULL;
 		return actor->alloc_buffer ? actor->tmp_buffer : ERR_PTR(-ENOMEM);
 	}
 
 	actor->next_index++;
 	actor->returned_pages++;
+	actor->last_page = actor->page[actor->next_page];
 	return actor->pageaddr = kmap_local_page(actor->page[actor->next_page++]);
 }
 
diff --git a/fs/squashfs/page_actor.h b/fs/squashfs/page_actor.h
index 95ffbb543d91..97d4983559b1 100644
--- a/fs/squashfs/page_actor.h
+++ b/fs/squashfs/page_actor.h
@@ -16,6 +16,7 @@ struct squashfs_page_actor {
 	void    *(*squashfs_first_page)(struct squashfs_page_actor *);
 	void    *(*squashfs_next_page)(struct squashfs_page_actor *);
 	void    (*squashfs_finish_page)(struct squashfs_page_actor *);
+	struct page *last_page;
 	int	pages;
 	int	length;
 	int	next_page;
@@ -29,10 +30,13 @@ extern struct squashfs_page_actor *squashfs_page_actor_init(void **buffer,
 extern struct squashfs_page_actor *squashfs_page_actor_init_special(
 				struct squashfs_sb_info *msblk,
 				struct page **page, int pages, int length);
-static inline void squashfs_page_actor_free(struct squashfs_page_actor *actor)
+static inline struct page *squashfs_page_actor_free(struct squashfs_page_actor *actor)
 {
+	struct page *last_page = actor->last_page;
+
 	kfree(actor->tmp_buffer);
 	kfree(actor);
+	return last_page;
 }
 static inline void *squashfs_first_page(struct squashfs_page_actor *actor)
 {
