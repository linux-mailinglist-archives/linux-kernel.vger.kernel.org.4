Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C2016D7D8F
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 15:19:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237259AbjDENTo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 09:19:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238232AbjDENTj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 09:19:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42BEE1FFD
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 06:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680700730;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=S1IMAu3kJtNv64ElJe0Fo5uhPnChLUpWs29JbgHtniM=;
        b=WwhYR+Ric8UxUwd57qGty39JWtMegrt7ZWGKBEWihakgVTzdsb9XCL8ghQ8BQ2UYaX0S40
        zvDkvlj6g+QDg9tS6Fu6NEoYOPiBArGx/ALlQGZHqSBEi/Gzw9S63noINHcXvH9obGnatU
        hM5rGJ4yzWrGa66o0bEO0tztd3rSu6Q=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-385-l5gOn0chODCL3P1Aybk6Zg-1; Wed, 05 Apr 2023 09:18:47 -0400
X-MC-Unique: l5gOn0chODCL3P1Aybk6Zg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A8F981C05140;
        Wed,  5 Apr 2023 13:18:46 +0000 (UTC)
Received: from nyarly.com (ovpn-116-127.gru2.redhat.com [10.97.116.127])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4848740C20FA;
        Wed,  5 Apr 2023 13:18:40 +0000 (UTC)
From:   Thiago Becker <tbecker@redhat.com>
To:     Steve French <sfrench@samba.org>, Paulo Alcantara <pc@cjr.nz>,
        Ronnie Sahlberg <lsahlber@redhat.com>,
        Shyam Prasad N <sprasad@microsoft.com>,
        Tom Talpey <tom@talpey.com>,
        Thiago Rafael Becker <trbecker@gmail.com>
Cc:     Thiago Becker <tbecker@redhat.com>,
        Steve French <stfrench@microsoft.com>,
        linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] cifs: sanitize paths in cifs_update_super_prepath.
Date:   Wed,  5 Apr 2023 10:16:48 -0300
Message-Id: <20230405131647.6389-1-tbecker@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After a server reboot, clients are failing to move files with ENOENT.
This is caused by DFS referrals containing multiple separators, which
the server move call doesn't recognize.

v1: Initial patch.
v2: Move prototype to header.

BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=2182472
Fixes: a31080899d5f ("cifs: sanitize multiple delimiters in prepath")
Actually-Fixes: 24e0a1eff9e2 ("cifs: switch to new mount api")
Signed-off-by: Thiago Rafael Becker <tbecker@redhat.com>
---
 fs/cifs/fs_context.c | 13 +++++++------
 fs/cifs/fs_context.h |  3 +++
 fs/cifs/misc.c       |  2 +-
 3 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/fs/cifs/fs_context.c b/fs/cifs/fs_context.c
index 6d13f8207e96a..ace11a1a7c8ab 100644
--- a/fs/cifs/fs_context.c
+++ b/fs/cifs/fs_context.c
@@ -441,13 +441,14 @@ int smb3_parse_opt(const char *options, const char *key, char **val)
  * but there are some bugs that prevent rename from working if there are
  * multiple delimiters.
  *
- * Returns a sanitized duplicate of @path. The caller is responsible for
- * cleaning up the original.
+ * Returns a sanitized duplicate of @path. @gfp indicates the GFP_* flags
+ * for kstrdup.
+ * The caller is responsible for freeing the original.
  */
 #define IS_DELIM(c) ((c) == '/' || (c) == '\\')
-static char *sanitize_path(char *path)
+char *cifs_sanitize_prepath(char *prepath, gfp_t gfp)
 {
-	char *cursor1 = path, *cursor2 = path;
+	char *cursor1 = prepath, *cursor2 = prepath;
 
 	/* skip all prepended delimiters */
 	while (IS_DELIM(*cursor1))
@@ -469,7 +470,7 @@ static char *sanitize_path(char *path)
 		cursor2--;
 
 	*(cursor2) = '\0';
-	return kstrdup(path, GFP_KERNEL);
+	return kstrdup(prepath, gfp);
 }
 
 /*
@@ -531,7 +532,7 @@ smb3_parse_devname(const char *devname, struct smb3_fs_context *ctx)
 	if (!*pos)
 		return 0;
 
-	ctx->prepath = sanitize_path(pos);
+	ctx->prepath = cifs_sanitize_prepath(pos, GFP_KERNEL);
 	if (!ctx->prepath)
 		return -ENOMEM;
 
diff --git a/fs/cifs/fs_context.h b/fs/cifs/fs_context.h
index 3de00e7127ec4..f4eaf85589022 100644
--- a/fs/cifs/fs_context.h
+++ b/fs/cifs/fs_context.h
@@ -287,4 +287,7 @@ extern void smb3_update_mnt_flags(struct cifs_sb_info *cifs_sb);
  */
 #define SMB3_MAX_DCLOSETIMEO (1 << 30)
 #define SMB3_DEF_DCLOSETIMEO (1 * HZ) /* even 1 sec enough to help eg open/write/close/open/read */
+
+extern char *cifs_sanitize_prepath(char *prepath, gfp_t gfp);
+
 #endif
diff --git a/fs/cifs/misc.c b/fs/cifs/misc.c
index b44fb51968bfb..7f085ed2d866b 100644
--- a/fs/cifs/misc.c
+++ b/fs/cifs/misc.c
@@ -1195,7 +1195,7 @@ int cifs_update_super_prepath(struct cifs_sb_info *cifs_sb, char *prefix)
 	kfree(cifs_sb->prepath);
 
 	if (prefix && *prefix) {
-		cifs_sb->prepath = kstrdup(prefix, GFP_ATOMIC);
+		cifs_sb->prepath = cifs_sanitize_prepath(prefix, GFP_ATOMIC);
 		if (!cifs_sb->prepath)
 			return -ENOMEM;
 
-- 
2.39.2

