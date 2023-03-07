Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 755676AE181
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 14:57:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230272AbjCGN5v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 08:57:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbjCGN5t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 08:57:49 -0500
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C5813D934;
        Tue,  7 Mar 2023 05:57:48 -0800 (PST)
Received: by mail-pl1-x641.google.com with SMTP id v11so14115128plz.8;
        Tue, 07 Mar 2023 05:57:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678197468;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e26yGfrppj54n5vu7MfF/4DYSTLCxazeKAAKghatviY=;
        b=k/LZaCEOhH/zfw12s8b5z0xjRas5BMADQ6kguj4C3m0zq1lB+MXNW1Fd8Fjuahrynt
         eDorKtTgJrkOE0rzQiVFYgMzVFk8oGeKxaHzQskwupYpLsqvLPmuchycVQWV2Vgz4fiK
         u7jSI+8UUKIN0rrao7v1iXyDGLrvHr9tHa66HMvrDCEWM+wqe2mZSbW5mTFlLTyD5lF1
         I7mU3a48MjsXv5HCqXfHZwYYl07VuFI4GMFa7WZkyy3Mr++BfuzXgfZkAolFoF5LZEPT
         2tR1Zs4S9WF9DcNUV8eMK0vi6NMXPtWfmolKSMpvI0OtvzQycSHdk9GL1CPnDhgfwqgC
         nkUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678197468;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e26yGfrppj54n5vu7MfF/4DYSTLCxazeKAAKghatviY=;
        b=aCzY/YNEipiwFhHbsDZhS+5ggguMRgToUhueEPlLv0fmmnczfI7HidhjUZBUqfO4Z1
         /7WsF5NSEnOT7ZUeJlW5Gv5bEX+hpZ/Zkcp17JyZ22bd+cs9W+5npBY2BkMfXk/zKoTY
         HtLylGrXmHRt3oRnIZPfHjYugp7zfufVGmSQ4Svl4L8wmtYu7LuKAlcrgQIdlTSq+NRl
         92dCz4ppK2pS5E5Q9WOVaEOSvyEAxsVWJ8+jiHrqUxW43W7lVOnqZFGET38eX+E4cLIh
         5sjgaCAYMaSzCNh3DzYSVNrAM1MbKfdGRWb3+m8R/NSJOjTiMQpE5lhiS6O4MoXUvw7T
         KTDA==
X-Gm-Message-State: AO0yUKWP0WMasAnHUNUqxlEwuSx3dNY517rcO1978YdNQUwPEGy4gSkR
        baueciDCo+bZVUh3bptDTJM=
X-Google-Smtp-Source: AK7set9r+bjjz1RVMZbPFkGSq6WmI+Zg//SSBPKYDlE0h7u9jAfa342u/wsZvjs2SDljBlts4ZFswA==
X-Received: by 2002:a17:903:41c6:b0:19d:181f:511 with SMTP id u6-20020a17090341c600b0019d181f0511mr17521973ple.30.1678197468004;
        Tue, 07 Mar 2023 05:57:48 -0800 (PST)
Received: from c1ion.lan ([139.227.13.23])
        by smtp.gmail.com with ESMTPSA id x7-20020a1709029a4700b0019339f3368asm8535554plv.3.2023.03.07.05.57.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 05:57:47 -0800 (PST)
From:   MIngyi Cong <congmingyi@gmail.com>
To:     linkinjeon@kernel.org, senozhatsky@chromium.org, sfrench@samba.org,
        tom@talpey.com
Cc:     congmingyi@gmail.com, linux-kernel@vger.kernel.org,
        linux-cifs@vger.kernel.org
Subject: [PATCH v2] fs: add the tuncate check of hfs, exfat and hfsplus
Date:   Tue,  7 Mar 2023 21:57:40 +0800
Message-Id: <20230307135740.13209-1-congmingyi@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230304083559.172398-1-congmingyi@gmail.com>
References: <20230304083559.172398-1-congmingyi@gmail.com>
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

HFS, EXFAT and HFSPLUS will fill zero data in truncated range.
Fix this by adding *_SUPER_MAGIC check.

Signed-off-by: MIngyi Cong <congmingyi@gmail.com>
---
V1 -> V2: add the truncate check of hfs and remove EXFAT_SUPER_MAGIC in magic.h
 fs/ksmbd/smb2pdu.c         | 5 ++++-
 include/uapi/linux/magic.h | 2 ++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/ksmbd/smb2pdu.c b/fs/ksmbd/smb2pdu.c
index 0685c1c77b9f..881a2b37fab0 100644
--- a/fs/ksmbd/smb2pdu.c
+++ b/fs/ksmbd/smb2pdu.c
@@ -5746,7 +5746,10 @@ static int set_end_of_file_info(struct ksmbd_work *work, struct ksmbd_file *fp,
 	 * truncate of some filesystem like FAT32 fill zero data in
 	 * truncated range.
 	 */
-	if (inode->i_sb->s_magic != MSDOS_SUPER_MAGIC) {
+	if (inode->i_sb->s_magic != MSDOS_SUPER_MAGIC ||
+		inode->i_sb->s_magic != EXFAT_SUPER_MAGIC ||
+		inode->i_sb->s_magic != HFSPLUS_SUPER_MAGIC ||
+		inode->i_sb->s_magic != HFS_SUPER_MAGIC) {
 		ksmbd_debug(SMB, "truncated to newsize %lld\n", newsize);
 		rc = ksmbd_vfs_truncate(work, fp, newsize);
 		if (rc) {
diff --git a/include/uapi/linux/magic.h b/include/uapi/linux/magic.h
index 6325d1d0e90f..db2c81755025 100644
--- a/include/uapi/linux/magic.h
+++ b/include/uapi/linux/magic.h
@@ -46,6 +46,8 @@
 
 #define MSDOS_SUPER_MAGIC	0x4d44		/* MD */
 #define EXFAT_SUPER_MAGIC	0x2011BAB0
+#define HFSPLUS_SUPER_MAGIC	0x482b		/* HFSPLUS */
+#define HFS_SUPER_MAGIC	0x4244		/* "BD": HFS MDB (super block) */
 #define NCP_SUPER_MAGIC		0x564c		/* Guess, what 0x564c is :-) */
 #define NFS_SUPER_MAGIC		0x6969
 #define OCFS2_SUPER_MAGIC	0x7461636f
-- 
2.34.1

