Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4679743AE4
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 13:33:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232414AbjF3Ldo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 07:33:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229957AbjF3Ldl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 07:33:41 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A81A41FC1;
        Fri, 30 Jun 2023 04:33:40 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-4fb761efa7aso2811586e87.0;
        Fri, 30 Jun 2023 04:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688124819; x=1690716819;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7oDpGX7SadvHF0PBwxOvdE+kg9NeeEeLYzE8RLSZxyI=;
        b=hNT+Q7klvxC/zjyhFtOH0PasSSR5T6dWL85jB02f0h/XRjrZqI40h82c6/TTdZbEVx
         KNGw68S934TwE6OBBed4Xul2/X1DEeh5W64AuxiLmSV4wHxfJv9zXLlzJpzqM9VcXhT+
         CJcx4QzGOK1isSlEuNMU8KyabdqrELfwXStJZgnSNC+M/IalpfwHySGws+FkIpjiRJfn
         F20vvs0svavEcAqfiDVXAfJwYTF2FDX60X0zOq7zrKjN3Cd3Y4Ysw+wzQRJFTDbWsG1J
         OSblJNQt7ZKgMvmtrRl0/vS4mb8HtNbhxQAPzMnJHUwXFYxdxfaoUQySUNlArZDHYVZu
         upiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688124819; x=1690716819;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7oDpGX7SadvHF0PBwxOvdE+kg9NeeEeLYzE8RLSZxyI=;
        b=VW+FAO0m9Q+Md+NtTjbspn1xGoP10bGb6sdiXE6EmqlKB2fwQX5BP20JWY0A/L0qfR
         cCRwBdGF+eCZGbbh7SxteizYgEBpXyB07n8wI4HerJaG0ivP9UbgVlsdhWMPQIB/oeO8
         aO9A0XC/e2cGgTofB0B6oANbXeb7hc4D873E5u+S3IAseQ9TCsH8VXQLKh+FPAEwj2KN
         anjJuNzP3pTFOUzdQTEZCQvujJCe8qDla3l3uy4K+i/FL45ut5eynzTAA1spIBqjfGnr
         HqK5NnNSfB3rkJ65bwrgMZp4uv1+fih529I0s8++z+eI3yYjwbGQxIHsDIseNjVWTpMi
         Qfwg==
X-Gm-Message-State: ABy/qLYC8Nu+/QLYEtbFMs6qaU5zR58Fo83Yquedfr02IJgGBq/KzBwh
        jA/+ZHfojoB3qq2+G5dC6J8=
X-Google-Smtp-Source: APBJJlFxTsPYthU3KN/Dq8lE2AoDRMrc2DPuPaIbkbwqbwp4wgN6PIImE0WFHCi56FDqlGDnBSgCqQ==
X-Received: by 2002:a05:6512:3592:b0:4fb:9f93:365e with SMTP id m18-20020a056512359200b004fb9f93365emr1828727lfr.41.1688124818526;
        Fri, 30 Jun 2023 04:33:38 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id z24-20020a05600c221800b003fa96fe2bd9sm13772194wml.22.2023.06.30.04.33.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jun 2023 04:33:37 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Steve French <sfrench@samba.org>,
        Paulo Alcantara <pc@manguebit.com>,
        Ronnie Sahlberg <lsahlber@redhat.com>,
        Shyam Prasad N <sprasad@microsoft.com>,
        Tom Talpey <tom@talpey.com>, linux-cifs@vger.kernel.org,
        samba-technical@lists.samba.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] smb: client: remove redundant pointer 'server'
Date:   Fri, 30 Jun 2023 12:33:37 +0100
Message-Id: <20230630113337.123257-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pointer 'server' is assigned but never read, the pointer is
redundant and can be removed. Cleans up clang scan build warning:

fs/smb/client/dfs.c:217:3: warning: Value stored to 'server' is
never read [deadcode.DeadStores]

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
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
2.39.2

