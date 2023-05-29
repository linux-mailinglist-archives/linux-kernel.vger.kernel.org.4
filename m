Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 803C1714CFA
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 17:26:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbjE2P0x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 11:26:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbjE2P0w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 11:26:52 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DACAC9
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 08:26:48 -0700 (PDT)
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id C3E0321A87;
        Mon, 29 May 2023 15:26:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1685374006; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=9LThTdNc3l0TTfcqKHMZIFh55bGZbjKiI/0a+5Ltvg0=;
        b=Kw3Hx4Cw+ZLE4wLRr0B8J/5bebN+MgZiyXz0l64lvJWZKfXbfET9SGYyeKxwuTRMW3jHMg
        w5aVMp3s85avm5mAvvfRkNJY7M3mIn8uOg8AQ6Fex031QYbhbl7eQh3HDlbxcWNX21XhcO
        VjpivPLoYAgB6qYPfMHP5iIjqrfF4Gc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1685374006;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=9LThTdNc3l0TTfcqKHMZIFh55bGZbjKiI/0a+5Ltvg0=;
        b=B6ic1MO724bMQ4Ipm8jiEo4Uw9SO23DnqV1lKHbwVuf3A3nsbgK8pM/MfqY/xC1gZz2T2P
        6KvrMhcXHeOSGgCQ==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 3CB31134BC;
        Mon, 29 May 2023 15:26:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id Abn3CjbEdGToAQAAGKfGzw
        (envelope-from <lhenriques@suse.de>); Mon, 29 May 2023 15:26:46 +0000
Received: from localhost (brahms.olymp [local])
        by brahms.olymp (OpenSMTPD) with ESMTPA id 757b2d04;
        Mon, 29 May 2023 15:26:45 +0000 (UTC)
From:   =?UTF-8?q?Lu=C3=ADs=20Henriques?= <lhenriques@suse.de>
To:     Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Heming Zhao <heming.zhao@suse.com>
Cc:     ocfs2-devel@oss.oracle.com, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Lu=C3=ADs=20Henriques?= <lhenriques@suse.de>
Subject: [PATCH] ocfs2: check new file size on fallocate call
Date:   Mon, 29 May 2023 16:26:45 +0100
Message-Id: <20230529152645.32680-1-lhenriques@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When changing a file size with fallocate() the new size isn't being
checked.  In particular, the FSIZE ulimit isn't being checked, which makes
fstest generic/228 fail.  Simply adding a call to inode_newsize_ok() fixes
this issue.

Signed-off-by: Luís Henriques <lhenriques@suse.de>
---
 fs/ocfs2/file.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/ocfs2/file.c b/fs/ocfs2/file.c
index efb09de4343d..b173c36bcab3 100644
--- a/fs/ocfs2/file.c
+++ b/fs/ocfs2/file.c
@@ -2100,14 +2100,20 @@ static long ocfs2_fallocate(struct file *file, int mode, loff_t offset,
 	struct ocfs2_space_resv sr;
 	int change_size = 1;
 	int cmd = OCFS2_IOC_RESVSP64;
+	int ret = 0;
 
 	if (mode & ~(FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE))
 		return -EOPNOTSUPP;
 	if (!ocfs2_writes_unwritten_extents(osb))
 		return -EOPNOTSUPP;
 
-	if (mode & FALLOC_FL_KEEP_SIZE)
+	if (mode & FALLOC_FL_KEEP_SIZE) {
 		change_size = 0;
+	} else {
+		ret = inode_newsize_ok(inode, offset + len);
+		if (ret)
+			return ret;
+	}
 
 	if (mode & FALLOC_FL_PUNCH_HOLE)
 		cmd = OCFS2_IOC_UNRESVSP64;
