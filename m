Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 967BC6ACD4F
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 19:57:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbjCFS5d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 13:57:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230091AbjCFS5O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 13:57:14 -0500
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F79FC168
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 10:56:07 -0800 (PST)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 326IsxMr023437
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 6 Mar 2023 13:55:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1678128903; bh=DgMaY+QajAGrEGVRA0ZgDBNHO9jOImTkXeQduYwOks0=;
        h=From:To:Cc:Subject:Date;
        b=Sw6r+Y+GM4K4n9ahRMRXmuYlywDYglrfeSRn7nzFmpRSt9uKJCh5LEgkmRIcWmUuw
         mb4auqmyFlTYzOVR/Dg0TkpQZtX4J75wbLyvoddbd2zE9oATcxgV9la9PKTiyBrEkv
         QrBhudODNp3COfdbUxL35yleBCUUjfbKHnaGiVzfUvylUYNQFkAEl5PdMEpHA1UzPJ
         L8qRw6HInloW7oNsRP/V6mLgjz9zFOZlKedUvySp2unheq9SWcwGoiof6iHWWBgHj1
         10lkwuqFS9VYLCmm12cfgJECmDkopByfPX3/IYb20fe6IOaGigVHTBkWsY3AtvkaZA
         KPVIkCQvcD5Sg==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id A296B15C3441; Mon,  6 Mar 2023 13:54:59 -0500 (EST)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Linux Kernel Developers List <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH] fs: prevent out-of-bounds array speculation when closing a file descriptor
Date:   Mon,  6 Mar 2023 13:54:50 -0500
Message-Id: <20230306185450.1028235-1-tytso@mit.edu>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Google-Bug-Id: 114199369
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---

I had sent this a while back, and failed to follow up when it
apparently get missed.  $WORK has been carrying this (or the
equivalent) as an out-of-tree security patch since 2018, and now some
folks are now nagging me about why hasn't this gone upstream yet...

 fs/file.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/file.c b/fs/file.c
index c942c89ca4cd..7893ea161d77 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -642,6 +642,7 @@ static struct file *pick_file(struct files_struct *files, unsigned fd)
 	if (fd >= fdt->max_fds)
 		return NULL;
 
+	fd = array_index_nospec(fd, fdt->max_fds);
 	file = fdt->fd[fd];
 	if (file) {
 		rcu_assign_pointer(fdt->fd[fd], NULL);
-- 
2.31.0

