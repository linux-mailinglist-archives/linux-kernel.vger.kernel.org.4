Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A15472F642
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 09:27:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235246AbjFNH0y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 03:26:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243389AbjFNHYY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 03:24:24 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1048A1FD4
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 00:23:48 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4Qgxjr623rzBQJYc
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 15:23:44 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1686727424; x=1689319425; bh=YX2AQ8xFNrWpKSzaCk01/HXly/M
        edBgyuGyHyDou450=; b=KhB2SohTmoiZFSWlWV5PLEe8UxZWYq/ibM2LOv8UYaC
        KmoZIwWYppI4jvvWy2s6YtEyX34P+y/aVqhq9nTMu5Q+CMex8u8P8CQfR0zHooYN
        8N1aQl8jZ9x1baPQKDcw+v4OhnZS2/QZeJaTsXeQ9epT8ev2qgoIB3TiOwAr6hYl
        2lWgkaYGrrmjnpeRQ1eUgHap5p/qIpJRUioJgXRAU09MLW2EKj7/mf39CcuMZS+m
        Nw5C8OqoYYb8LV3b9O5NB424ACKjZYE4MpUMXhGbseTK8o/c9quQ597jHMPU1zNU
        /S0Myfv/3ah8UH6+xuylE548jUKOi8NVaFIVoRXjz5g==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id LbV7SwVSJnAg for <linux-kernel@vger.kernel.org>;
        Wed, 14 Jun 2023 15:23:44 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4Qgxjr3pK5zBJLB3;
        Wed, 14 Jun 2023 15:23:44 +0800 (CST)
MIME-Version: 1.0
Date:   Wed, 14 Jun 2023 15:23:44 +0800
From:   hexingwei001@208suo.com
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mm: page_io: Prefer 'unsigned int' to bare use of 'unsigned'
In-Reply-To: <20230614071804.13110-1-panzhiai@cdjrlc.com>
References: <20230614071804.13110-1-panzhiai@cdjrlc.com>
User-Agent: Roundcube Webmail
Message-ID: <1e132a6416d673e285af610ff185fa5f@208suo.com>
X-Sender: hexingwei001@208suo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RDNS_NONE,SPF_HELO_FAIL,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following checkpatch warning:

mm/page_io.c:87: WARNING: Prefer 'unsigned int' to bare use of 
'unsigned'.
mm/page_io.c:89: WARNING: Prefer 'unsigned int' to bare use of 
'unsigned'.
mm/page_io.c:109: WARNING: Prefer 'unsigned int' to bare use of 
'unsigned'.

Signed-off-by: Xingwei He <hexingwei001@208suo.com>
---
  mm/page_io.c | 6 +++---
  1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/page_io.c b/mm/page_io.c
index 684cd3c7b59b..138f73386612 100644
--- a/mm/page_io.c
+++ b/mm/page_io.c
@@ -84,9 +84,9 @@ int generic_swapfile_activate(struct swap_info_struct 
*sis,
  {
      struct address_space *mapping = swap_file->f_mapping;
      struct inode *inode = mapping->host;
-    unsigned blocks_per_page;
+    unsigned int blocks_per_page;
      unsigned long page_no;
-    unsigned blkbits;
+    unsigned int blkbits;
      sector_t probe_block;
      sector_t last_block;
      sector_t lowest_block = -1;
@@ -106,7 +106,7 @@ int generic_swapfile_activate(struct 
swap_info_struct *sis,
      last_block = i_size_read(inode) >> blkbits;
      while ((probe_block + blocks_per_page) <= last_block &&
              page_no < sis->max) {
-        unsigned block_in_page;
+        unsigned int block_in_page;
          sector_t first_block;

          cond_resched();
