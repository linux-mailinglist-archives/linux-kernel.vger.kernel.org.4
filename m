Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DA55744DAB
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jul 2023 15:04:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229833AbjGBNEK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jul 2023 09:04:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjGBNEJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jul 2023 09:04:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69B7D12A
        for <linux-kernel@vger.kernel.org>; Sun,  2 Jul 2023 06:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688302997;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=BDWA0cHSXVgfvckMNf+JGKR/aUvwz+pDaTFzfeeBwos=;
        b=gVAYefHkDlf4mK4jeVFr3IbpMrjjmtQq6bARN+YYrhINGVmigAd+gXvjipDcQauEuEAg0V
        P+8F5DB2yT8zVetbYdDfgUjCRRLdvZOKNrm4B0AmCUBW8HLnpOnZe3iLjN2+TJO0pRnwwf
        +gxp358oysyei5/3jdgMuaRXr3sxSAM=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-322-6BR4dGLEP6qE5SzREwrILg-1; Sun, 02 Jul 2023 09:03:16 -0400
X-MC-Unique: 6BR4dGLEP6qE5SzREwrILg-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7659db633acso465430185a.0
        for <linux-kernel@vger.kernel.org>; Sun, 02 Jul 2023 06:03:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688302995; x=1690894995;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BDWA0cHSXVgfvckMNf+JGKR/aUvwz+pDaTFzfeeBwos=;
        b=d5oh1GZB5REh+2gWVHljxcigtGcF0qqUBOpkUiWnamtg8IsYoRYDOXMZbn5rMiL9aM
         IOhm4cKGMxEIKWm7gEWS4PDkXnwDxd2KJZYxIZUJiMvibBe7hCtr9Mc937XAZ6Qy6eIB
         7BXclaU1dMcMaLfyFv5NONBX0E55BteWRorM8ajy9SVzBNaoJQ+Cru3ZB10T5dfZer+Z
         unssHz0Pfr4t4ossnV4hFTq3RkJOA2TSIAyCqrGLsfBoacHaKdJxVFBqxXGNbmhHgnb5
         zlVZhzk7kuNhvwBl7yQduGh/rhjqZdl54siQbAtu5ncVU0uWMS98lC3Sa9IjV721Akss
         Q1ng==
X-Gm-Message-State: ABy/qLbWfzJOs5H19QWOHwOG2dj0N0TX/Tw82+9lXQI6dEw5CrndR9cg
        55maHsyWx3Ua3wvOmXozj6QU0IMra9VUPC/nE+yuzEYMjmSlUrfTx3ogrL0aNum54IEZmckDtvK
        81BawUyb/1dX+/HkAQAssIgQF
X-Received: by 2002:a05:620a:454c:b0:767:5748:cae7 with SMTP id u12-20020a05620a454c00b007675748cae7mr5178670qkp.31.1688302995842;
        Sun, 02 Jul 2023 06:03:15 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEMl5GYrjxK+ozQpsNv0BW9m8jGbSKQM1C6MW3iV+1TqtfpxpQ+GkCfzCCWz1B/9SRBwwFafQ==
X-Received: by 2002:a05:620a:454c:b0:767:5748:cae7 with SMTP id u12-20020a05620a454c00b007675748cae7mr5178643qkp.31.1688302995592;
        Sun, 02 Jul 2023 06:03:15 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id cx13-20020a05620a51cd00b007339c5114a9sm6142847qkb.103.2023.07.02.06.03.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Jul 2023 06:03:15 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     sfrench@samba.org, pc@manguebit.com, lsahlber@redhat.com,
        sprasad@microsoft.com, tom@talpey.com
Cc:     linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
        linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH] smb: client: remove unused variable 'server'
Date:   Sun,  2 Jul 2023 09:03:10 -0400
Message-Id: <20230702130310.3437437-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

gcc with W=1 reports
fs/smb/client/dfs.c: In function ‘__dfs_mount_share’:
fs/smb/client/dfs.c:146:33: error: variable ‘server
  set but not used [-Werror=unused-but-set-variable]
  146 |         struct TCP_Server_Info *server;
      |                                 ^~~~~~

This variable is not used, so remove it.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 fs/smb/client/dfs.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/smb/client/dfs.c b/fs/smb/client/dfs.c
index 26d14dd0482e..1403a2d1ab17 100644
--- a/fs/smb/client/dfs.c
+++ b/fs/smb/client/dfs.c
@@ -143,7 +143,6 @@ static int __dfs_mount_share(struct cifs_mount_ctx *mnt_ctx)
 	struct smb3_fs_context *ctx = mnt_ctx->fs_ctx;
 	char *ref_path = NULL, *full_path = NULL;
 	struct dfs_cache_tgt_iterator *tit;
-	struct TCP_Server_Info *server;
 	struct cifs_tcon *tcon;
 	char *origin_fullpath = NULL;
 	char sep = CIFS_DIR_SEP(cifs_sb);
@@ -214,7 +213,6 @@ static int __dfs_mount_share(struct cifs_mount_ctx *mnt_ctx)
 	} while (rc == -EREMOTE);
 
 	if (!rc) {
-		server = mnt_ctx->server;
 		tcon = mnt_ctx->tcon;
 
 		spin_lock(&tcon->tc_lock);
-- 
2.27.0

