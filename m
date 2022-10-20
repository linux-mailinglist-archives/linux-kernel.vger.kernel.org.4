Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3805260624A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 15:56:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbiJTN4t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 09:56:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbiJTN4r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 09:56:47 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6949016D883
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 06:56:46 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id b5so19292196pgb.6
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 06:56:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nPO05jfjybmXcLv8HEhuWd4rZu708IpG4U7mlzmOe4o=;
        b=etW0oKCItxd0/U46DsdrYxSldrWL/238XSHKmxikTw+hFsbOf6O4uiz6IC9SdyJSTt
         JY6jA6G0h76rPCcjagUSpym/3oftNcZtKmlw03kQ7ZD1xg0rRRVfSxG+XltHZKaq2spF
         7PPzT+LCuNxbif1wFQN248w137pm31FgX/cx5gpvsDLVliUlXF5nloJWMbi/LvIf9UeB
         Zi7z++PKE/zQavKE1PJfroM0AeQDBGbWz0l+WOlakzaalFb3BtvH3TuVMZMs/IxwS8b/
         erKhEcFHSlyXN2jyIbCNc0jm3mqTbA9+LVx2ZfkYuEqaG9yCsdMO2QcKOBr24QCVz3sN
         4p+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nPO05jfjybmXcLv8HEhuWd4rZu708IpG4U7mlzmOe4o=;
        b=7mgoyd5Nli5XcTnTVHFYTS0uAAIKudxZcK5uV09Cps/JX21p6mS4Wc46HYHMDSXY7z
         cmINp18DjpcVIjJ5WJfcMo+Yt1h4guhhxpoYGhJkn76R5f90HCxVIuBTo0Ads9eEhHnW
         +8pCiKWT5zrx+Q1yIJ2OE8Hl2u4VxTyp5X8D/yw7x4S0etjieDGGGKxx33IKiKeqrvt+
         97MiUc/TeGEYgOU1Q4Xi6g2uAYO9UvjAIi7m5LRLsLkQinRtG71snvJN7maOMFBqqTXE
         BYpGdaijX1BQW6Kqo5RRL2nAer6aLo1mV8tluZiQ3JdxPhB34eY0IihWQS9XiWD9MqWh
         SLNA==
X-Gm-Message-State: ACrzQf3LquxlILeUen4g69akaKBwN2D9RgMd+v6Su4NeEXF4zoP1f4UX
        hNgM0kRf2ZrdDfs/Fbs87qk=
X-Google-Smtp-Source: AMsMyM5sReiudgDAIXkOT8S4grAa16BKY2Z8gm5kD41qRiJTzty39MiJA80Hg12ACjEq+wzbg52I6Q==
X-Received: by 2002:a05:6a00:301c:b0:567:6e2c:45f0 with SMTP id ay28-20020a056a00301c00b005676e2c45f0mr10414913pfb.84.1666274205889;
        Thu, 20 Oct 2022 06:56:45 -0700 (PDT)
Received: from localhost.localdomain ([199.101.192.167])
        by smtp.googlemail.com with ESMTPSA id a9-20020a1709027e4900b0017f8094a52asm12873456pln.29.2022.10.20.06.56.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 06:56:45 -0700 (PDT)
From:   Jintao Yin <nicememory@gmail.com>
To:     phillip@squashfs.org.uk
Cc:     bagasdotme@gmail.com, hsinyi@chromium.org,
        linux-kernel@vger.kernel.org, marcmiltenberger@gmail.com,
        mirsad.todorovac@alu.unizg.hr, nicememory@gmail.com,
        regressions@leemhuis.info, regressions@lists.linux.dev,
        srw@sladewatkins.net
Subject: Re: BISECT result: 6.0.0-RC kernels trigger Firefox snap bug with 6.0.0-rc3 through 6.0.0-rc7
Date:   Thu, 20 Oct 2022 21:55:45 +0800
Message-Id: <20221020135545.586-1-nicememory@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221018174157.1897-1-phillip@squashfs.org.uk>
References: <20221018174157.1897-1-phillip@squashfs.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

After review the details of page actor, the tail bytes may be written to
a temp buffer instead the last used page. So before diff would wrongly
memzero a page which is not the tail bytes in.

In this diff fixes it by caculation of the real index the trailing bytes
in and check if the last used page matches this index. If the page is
the real tail bytes in, then memzero the trailing bypte of the page.

Please help test and any feedbacks are welcome.

Thanks,

Jintao


diff --git a/fs/squashfs/file.c b/fs/squashfs/file.c
index e56510964b22..e1fafd10a850 100644
--- a/fs/squashfs/file.c
+++ b/fs/squashfs/file.c
@@ -506,8 +506,9 @@ static int squashfs_readahead_fragment(struct page **page,
 		squashfs_i(inode)->fragment_size);
 	struct squashfs_sb_info *msblk = inode->i_sb->s_fs_info;
 	unsigned int n, mask = (1 << (msblk->block_log - PAGE_SHIFT)) - 1;
+	int res = buffer->error;
 
-	if (buffer->error)
+	if (res)
 		goto out;
 
 	expected += squashfs_i(inode)->fragment_offset;
@@ -529,7 +530,7 @@ static int squashfs_readahead_fragment(struct page **page,
 
 out:
 	squashfs_cache_put(buffer);
-	return buffer->error;
+	return res;
 }
 
 static void squashfs_readahead(struct readahead_control *ractl)
@@ -557,6 +558,7 @@ static void squashfs_readahead(struct readahead_control *ractl)
 		int res, bsize;
 		u64 block = 0;
 		unsigned int expected;
+		int nr_used_pages;
 
 		nr_pages = __readahead_batch(ractl, pages, max_pages);
 		if (!nr_pages)
@@ -593,18 +595,21 @@ static void squashfs_readahead(struct readahead_control *ractl)
 
 		res = squashfs_read_data(inode->i_sb, block, bsize, NULL, actor);
 
-		squashfs_page_actor_free(actor);
+		nr_used_pages = squashfs_page_actor_free(actor);
 
 		if (res == expected) {
 			int bytes;
+			pgoff_t bytes_index;
 
 			/* Last page (if present) may have trailing bytes not filled */
 			bytes = res % PAGE_SIZE;
-			if (pages[nr_pages - 1]->index == file_end && bytes)
-				memzero_page(pages[nr_pages - 1], bytes,
+			bytes_index = (index << shift) + ((res - bytes) >> PAGE_SHIFT);
+			if (bytes && nr_used_pages > 0 &&
+				pages[nr_used_pages - 1]->index == bytes_index)
+				memzero_page(pages[nr_used_pages - 1], bytes,
 					     PAGE_SIZE - bytes);
 
-			for (i = 0; i < nr_pages; i++) {
+			for (i = 0; i < nr_used_pages; i++) {
 				flush_dcache_page(pages[i]);
 				SetPageUptodate(pages[i]);
 			}
diff --git a/fs/squashfs/file_direct.c b/fs/squashfs/file_direct.c
index f1ccad519e28..ee462ef380bf 100644
--- a/fs/squashfs/file_direct.c
+++ b/fs/squashfs/file_direct.c
@@ -26,14 +26,14 @@ int squashfs_readpage_block(struct page *target_page, u64 block, int bsize,
 	struct inode *inode = target_page->mapping->host;
 	struct squashfs_sb_info *msblk = inode->i_sb->s_fs_info;
 
-	int file_end = (i_size_read(inode) - 1) >> PAGE_SHIFT;
-	int mask = (1 << (msblk->block_log - PAGE_SHIFT)) - 1;
-	int start_index = target_page->index & ~mask;
-	int end_index = start_index | mask;
-	int i, n, pages, bytes, res = -ENOMEM;
+	pgoff_t file_end = (i_size_read(inode) - 1) >> PAGE_SHIFT;
+	pgoff_t mask = (1 << (msblk->block_log - PAGE_SHIFT)) - 1;
+	pgoff_t start_index = target_page->index & ~mask;
+	pgoff_t end_index = start_index | mask;
+	int i, pages, used_pages, bytes, res = -ENOMEM;
+	pgoff_t n, bytes_index;
 	struct page **page;
 	struct squashfs_page_actor *actor;
-	void *pageaddr;
 
 	if (end_index > file_end)
 		end_index = file_end;
@@ -74,7 +74,7 @@ int squashfs_readpage_block(struct page *target_page, u64 block, int bsize,
 	/* Decompress directly into the page cache buffers */
 	res = squashfs_read_data(inode->i_sb, block, bsize, NULL, actor);
 
-	squashfs_page_actor_free(actor);
+	used_pages = squashfs_page_actor_free(actor);
 
 	if (res < 0)
 		goto mark_errored;
@@ -86,16 +86,19 @@ int squashfs_readpage_block(struct page *target_page, u64 block, int bsize,
 
 	/* Last page (if present) may have trailing bytes not filled */
 	bytes = res % PAGE_SIZE;
-	if (page[pages - 1]->index == end_index && bytes) {
-		pageaddr = kmap_local_page(page[pages - 1]);
-		memset(pageaddr + bytes, 0, PAGE_SIZE - bytes);
-		kunmap_local(pageaddr);
+	bytes_index = start_index + ((res - bytes) >> PAGE_SHIFT);
+	if (used_pages > 0 && bytes &&
+		page[used_pages - 1]->index == bytes_index) {
+		memzero_page(page[used_pages - 1], bytes,
+			     PAGE_SIZE - bytes);
 	}
 
 	/* Mark pages as uptodate, unlock and release */
 	for (i = 0; i < pages; i++) {
-		flush_dcache_page(page[i]);
-		SetPageUptodate(page[i]);
+		if (i < used_pages) {
+			flush_dcache_page(page[i]);
+			SetPageUptodate(page[i]);
+		}
 		unlock_page(page[i]);
 		if (page[i] != target_page)
 			put_page(page[i]);
@@ -112,8 +115,10 @@ int squashfs_readpage_block(struct page *target_page, u64 block, int bsize,
 	for (i = 0; i < pages; i++) {
 		if (page[i] == NULL || page[i] == target_page)
 			continue;
-		flush_dcache_page(page[i]);
-		SetPageError(page[i]);
+		if (i < used_pages) {
+			flush_dcache_page(page[i]);
+			SetPageError(page[i]);
+		}
 		unlock_page(page[i]);
 		put_page(page[i]);
 	}
diff --git a/fs/squashfs/page_actor.h b/fs/squashfs/page_actor.h
index 95ffbb543d91..c2c5c3937ef9 100644
--- a/fs/squashfs/page_actor.h
+++ b/fs/squashfs/page_actor.h
@@ -29,10 +29,12 @@ extern struct squashfs_page_actor *squashfs_page_actor_init(void **buffer,
 extern struct squashfs_page_actor *squashfs_page_actor_init_special(
 				struct squashfs_sb_info *msblk,
 				struct page **page, int pages, int length);
-static inline void squashfs_page_actor_free(struct squashfs_page_actor *actor)
+static inline int squashfs_page_actor_free(struct squashfs_page_actor *actor)
 {
+	int res = actor->next_page;
 	kfree(actor->tmp_buffer);
 	kfree(actor);
+	return res;
 }
 static inline void *squashfs_first_page(struct squashfs_page_actor *actor)
 {
