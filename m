Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB914626829
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Nov 2022 09:33:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234687AbiKLIdj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Nov 2022 03:33:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234743AbiKLIdb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Nov 2022 03:33:31 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA93F1082
        for <linux-kernel@vger.kernel.org>; Sat, 12 Nov 2022 00:33:29 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id g24so6043984plq.3
        for <linux-kernel@vger.kernel.org>; Sat, 12 Nov 2022 00:33:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HpSAL+Frp6pI5uZevffauYMAMF7An7PWhGzNk6t7irc=;
        b=BjdmEmrRmKb1KewQe1wjYXRVdQ/+pvyafqjJ9iLoUU5lLUjrFYCLilfD2swqM8EmvL
         Mqws98NeNcg21hJWtyVmN7Mfn4wEv911g1lJbhC9FHAyiKlzIN8W8xcG33G0FOdXn44/
         eXS024oauWVrIh64Eg7CBLazucVLvHLol7/DzM5W1Sgk9W164p3AeqeHVonaPxZyarIJ
         ItnN8XGiFU/3cnzMlrcYfLBv0/QzJ03AlGUKU2N7C5KuFG3zcceH64pZxHqsrCCWV3GL
         Xrm7AlApa4KRWs0lyP0jElIJCjC8StEW4ELpufPTfBGf88QwUYsWrmOU/nogrchzfSqE
         7DDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HpSAL+Frp6pI5uZevffauYMAMF7An7PWhGzNk6t7irc=;
        b=go1t4X6GWoXwUQ0uutMhTt5kXzwCR9rf1VNl9BZqKH9TZTWw3akpacIN4QWivjD+HQ
         geFb9Es7//6u4z6FdYD3CnQkqM+w7mh05zs7ArfxbMLAptAPBwoBSBRCyHUqwpHFtpp3
         yM/6AVAXQZR1mUMZ+xyOTWg6iCECqeIo57kocaLTA0vieM2vXezD95UNkx9EKf9AiQF/
         zxxdbvHdYKm8hoUqWiBpVwxEgOVxmL5J1L9DWubS4IVNqhNr0Xm66Dq74tsy+CYlq4Xl
         sBI7KVIOAG7nFw8k13Q1E41QcG6oJSjRBXsZag0TDuNcD3UFBR88NfQLJaKpL3U3xA4j
         wUfw==
X-Gm-Message-State: ANoB5plOoZeB3QhgsWMNaVVzMlM8IqZMG+dDROeEONFUP4EV9WU2Siuo
        NGdGEjTOQGsSAHYh0X4ixWU=
X-Google-Smtp-Source: AA0mqf7tE2XuEywH3c3EIQLoY6KbWyTmYUek3jOnXZumk72NZnsdIP8ou5suR+4dwNG8D8yl5ormYw==
X-Received: by 2002:a17:90b:48cd:b0:213:47:57cc with SMTP id li13-20020a17090b48cd00b00213004757ccmr5459327pjb.174.1668242009382;
        Sat, 12 Nov 2022 00:33:29 -0800 (PST)
Received: from VirtualBox.. ([129.227.152.6])
        by smtp.gmail.com with ESMTPSA id i11-20020a1709026acb00b001870533c443sm3066927plt.236.2022.11.12.00.33.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Nov 2022 00:33:28 -0800 (PST)
From:   Yuwei Guan <ssawgyw@gmail.com>
X-Google-Original-From: Yuwei Guan <Yuwei.Guan@zeekrlife.com>
To:     jaegeuk@kernel.org, chao@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Yuwei.Guan@zeekrlife.com
Subject: [PATCH 3/3] f2fs: change type for 'sbi->readdir_ra'
Date:   Sat, 12 Nov 2022 16:32:50 +0800
Message-Id: <20221112083250.295700-4-Yuwei.Guan@zeekrlife.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221112083250.295700-1-Yuwei.Guan@zeekrlife.com>
References: <20221112083250.295700-1-Yuwei.Guan@zeekrlife.com>
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

Before this patch, the varibale 'readdir_ra' takes effect if it's equal
to '1' or not, so we can change type for it from 'int' to 'bool'.

Signed-off-by: Yuwei Guan <Yuwei.Guan@zeekrlife.com>
---
 fs/f2fs/dir.c   | 7 +++----
 fs/f2fs/f2fs.h  | 2 +-
 fs/f2fs/super.c | 2 +-
 fs/f2fs/sysfs.c | 5 +++++
 4 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index 21960a899b6a..06d9bf98f5ae 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -1000,13 +1000,12 @@ int f2fs_fill_dentries(struct dir_context *ctx, struct f2fs_dentry_ptr *d,
 	struct fscrypt_str de_name = FSTR_INIT(NULL, 0);
 	struct f2fs_sb_info *sbi = F2FS_I_SB(d->inode);
 	struct blk_plug plug;
-	bool readdir_ra = sbi->readdir_ra == 1;
 	bool found_valid_dirent = false;
 	int err = 0;
 
 	bit_pos = ((unsigned long)ctx->pos % d->max);
 
-	if (readdir_ra)
+	if (sbi->readdir_ra)
 		blk_start_plug(&plug);
 
 	while (bit_pos < d->max) {
@@ -1064,14 +1063,14 @@ int f2fs_fill_dentries(struct dir_context *ctx, struct f2fs_dentry_ptr *d,
 			goto out;
 		}
 
-		if (readdir_ra)
+		if (sbi->readdir_ra)
 			f2fs_ra_node_page(sbi, le32_to_cpu(de->ino));
 
 		ctx->pos = start_pos + bit_pos;
 		found_valid_dirent = true;
 	}
 out:
-	if (readdir_ra)
+	if (sbi->readdir_ra)
 		blk_finish_plug(&plug);
 	return err;
 }
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index e6355a5683b7..384840216e7f 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1693,7 +1693,7 @@ struct f2fs_sb_info {
 	unsigned int total_node_count;		/* total node block count */
 	unsigned int total_valid_node_count;	/* valid node block count */
 	int dir_level;				/* directory level */
-	int readdir_ra;				/* readahead inode in readdir */
+	bool readdir_ra;			/* readahead inode in readdir */
 	u64 max_io_bytes;			/* max io bytes to merge IOs */
 
 	block_t user_block_count;		/* # of user blocks */
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index f18ae5410b2c..da304861890f 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -2202,7 +2202,7 @@ static void f2fs_tuning_parameters(struct f2fs_sb_info *sbi, bool is_remount)
 	}
 
 	if (!is_remount)
-		sbi->readdir_ra = 1;
+		sbi->readdir_ra = true;
 }
 
 static int f2fs_remount(struct super_block *sb, int *flags, char *data)
diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index df27afd71ef4..53fbbb87dd0f 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -649,6 +649,11 @@ static ssize_t __sbi_store(struct f2fs_attr *a,
 		return count;
 	}
 
+	if (!strcmp(a->attr.name, "readdir_ra")) {
+		sbi->readdir_ra = !!t;
+		return count;
+	}
+
 	*ui = (unsigned int)t;
 
 	return count;
-- 
2.34.1

