Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 398236FBC96
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 03:41:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233750AbjEIBln (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 21:41:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjEIBll (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 21:41:41 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72CBD7290
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 18:41:40 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id ca18e2360f4ac-76937f5f9c5so147913139f.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 May 2023 18:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683596500; x=1686188500;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8cSgBpMp7p1S/8fw4fhmvnrClK6IteyvpyWXmRkaekc=;
        b=Zah4pAmcZAy5lVPGq7JrGKccBca6COmTSjqHLn0rqmVvpzms0y8d+wfZKAYPDnbYdZ
         WHBGRTYVH2C4WfgwQy/nG09G7IcNK8Ti0Rxy2mRMjjuJdfYGhPTG/XoBd1asqPXi+sJL
         w2OmtDLU07gUQe15DRhsqzykDLYlJiHLLck2jGITcUm4iMdres93IIDnFCuyE8sLQknl
         6umftSrPm3hxx22W1T8oP01knly7kOkp1UnpKEhBASs+T88/LxSoJpXdy4QyqMvvtomn
         PkyDG3vKsZKF+yxytdlK1fVPONqiHKxrkbqVDgnBXq3H1Ua9lwPEN2H47LAwDF+miDrU
         wTig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683596500; x=1686188500;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8cSgBpMp7p1S/8fw4fhmvnrClK6IteyvpyWXmRkaekc=;
        b=iyUBQyBhP/u/2ofN0OLfA78Pu7lMiHgDkKzfPvjyweysx6dh/lBS3Jh3ovOi7QIRc2
         iYM+2Mx8XpLkEO7MjhYi+j7i40zawu6TnrqKxAqTfoCuvyq8srfzBnw6JqyGK3063xgo
         QEdySrwF2MRiEfEz+Ob1BKWTisQ1yWOBe94+a2UC0+BGgxHMQxHrpb1ZFKEOhvW317It
         wsHVEbz0A6FcHYa9DSYZHbn0NQT/082EDxvMh2d+5ChUiLFJO3ekZNrWd4WrZDAt4S4f
         1zfB0uPzKXMDhgTlQT54OH5+Ga8fIzzoDtLXn1m1MJAjVSB4yl59b1rzTmj9Ht1xQPsA
         48fA==
X-Gm-Message-State: AC+VfDzuG4SGGJK39aUCXSvf89EAnkqsXV+EvzGl0lSr0bHEUczMY9LH
        p/gJnySgPvATd3cZES48A1TTWCHCstQ7aA==
X-Google-Smtp-Source: ACHHUZ5qd7nnVgIop1dQCDaETg/aXMgVCjM7mRf2mbD7MHzEuKsD5PGf6ab6OVZ5tmzlWXw0bJyo0Q==
X-Received: by 2002:a92:cd04:0:b0:32c:9c5e:900c with SMTP id z4-20020a92cd04000000b0032c9c5e900cmr8370728iln.8.1683596499663;
        Mon, 08 May 2023 18:41:39 -0700 (PDT)
Received: from azeems-kspp.c.googlers.com.com (54.70.188.35.bc.googleusercontent.com. [35.188.70.54])
        by smtp.gmail.com with ESMTPSA id t12-20020a056e02060c00b00331833da1dasm2790065ils.35.2023.05.08.18.41.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 18:41:39 -0700 (PDT)
From:   Azeem Shaikh <azeemshaikh38@gmail.com>
To:     keescook@google.com, Luis de Bethencourt <luisbg@kernel.org>,
        Salah Triki <salah.triki@gmail.com>
Cc:     Azeem Shaikh <azeemshaikh38@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] befs: Replace all non-returning strlcpy with strscpy
Date:   Tue,  9 May 2023 01:41:36 +0000
Message-ID: <20230509014136.2095900-1-azeemshaikh38@gmail.com>
X-Mailer: git-send-email 2.40.1.521.gf1e218fcd8-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

strlcpy() reads the entire source buffer first.
This read may exceed the destination size limit.
This is both inefficient and can lead to linear read
overflows if a source string is not NUL-terminated.
In an effort to remove strlcpy() completely, replace
strlcpy() here with strscpy().
No return values were used, so direct replacement is safe.

[1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy
[2] https://github.com/KSPP/linux/issues/89

Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>
---
 fs/befs/btree.c    |    2 +-
 fs/befs/linuxvfs.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/befs/btree.c b/fs/befs/btree.c
index 1b7e0f7128d6..53b36aa29978 100644
--- a/fs/befs/btree.c
+++ b/fs/befs/btree.c
@@ -500,7 +500,7 @@ befs_btree_read(struct super_block *sb, const befs_data_stream *ds,
 		goto error_alloc;
 	}
 
-	strlcpy(keybuf, keystart, keylen + 1);
+	strscpy(keybuf, keystart, keylen + 1);
 	*value = fs64_to_cpu(sb, valarray[cur_key]);
 	*keysize = keylen;
 
diff --git a/fs/befs/linuxvfs.c b/fs/befs/linuxvfs.c
index 32749fcee090..eee9237386e2 100644
--- a/fs/befs/linuxvfs.c
+++ b/fs/befs/linuxvfs.c
@@ -374,7 +374,7 @@ static struct inode *befs_iget(struct super_block *sb, unsigned long ino)
 	if (S_ISLNK(inode->i_mode) && !(befs_ino->i_flags & BEFS_LONG_SYMLINK)){
 		inode->i_size = 0;
 		inode->i_blocks = befs_sb->block_size / VFS_BLOCK_SIZE;
-		strlcpy(befs_ino->i_data.symlink, raw_inode->data.symlink,
+		strscpy(befs_ino->i_data.symlink, raw_inode->data.symlink,
 			BEFS_SYMLINK_LEN);
 	} else {
 		int num_blks;

