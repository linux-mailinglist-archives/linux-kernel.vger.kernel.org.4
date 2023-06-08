Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B500727A60
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 10:48:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234378AbjFHIsL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 04:48:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235564AbjFHIro (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 04:47:44 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF4411984
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 01:47:21 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-652d76be8c2so287913b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 01:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1686214041; x=1688806041;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jpOSC83U6MeRWzobwwrbyrIn8PFmAweJrd0CPHgT5eo=;
        b=lB9UnP+PZk/bGV8hLEcegEzVxi28mg+gtSjiuOudDXzqRQv5k1+5jBOHYdossrt9Es
         ERgR+FMrAuts8z9XMAxuklmArlSxafDMUAiEKOsMrqFFKQN/UsRQxIpfB87StBqVqFHK
         Ura+mvZg4cga1RTr15CeCTDtETNyE9Gps03oGJuXVwJ8Tb17SIPRhjWqxxgQpW7WxDdZ
         XMbtMfT+tMJvxCFtMhaY0FtUHJrrlbqn5MzZP+RsV63rq3EmAYjPZ4logvdQMc3zWh9I
         ZVrrOd1xrLz1PrQNV4pauX4xGZLJ18NSmtBMz4ze4YB6aNgvmevGv+UzAnCOi4PNh2Nh
         3KdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686214041; x=1688806041;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jpOSC83U6MeRWzobwwrbyrIn8PFmAweJrd0CPHgT5eo=;
        b=d5nx5/6n82NScLCyPIfxrepsxRuULn9FeyKFvgxyM92dcPvBuqRzj2pimIjlDM5ht2
         8RdcZaQ09/hXDGjLWSi0yduq5lT1TT2P0CC/5QMbvsZxTfuzWxkWSaCv50xcojJa8J25
         lujFr5DrbKuOij9wZhslRkIeRUyN9IMSzw8F6+zTyBWxxq72BDzKRDDIlk3BWiZ5sJXw
         +7S5tpYhdH8bdyP1Vk5naNGGAIxD1vjNpFrjt/xG7pTeeFDA24bzFOUcLTBC4/2arb8U
         JR2oxEDO1FZvlIbQZverZj6ffhBj8vHtBQez8FYUJMPG0IsiJthbcCljPVfKcPs/VpuA
         0FzQ==
X-Gm-Message-State: AC+VfDzgAc4f4mUlhvO2yZxH5pDJTip/0rvwsnHxff78okiOYWRan556
        f2au1HXAtgCIles4k0RD7WD0HQ==
X-Google-Smtp-Source: ACHHUZ5+hqoVn2yxaf0eYbAugWWKR7uGqS4jxd8ISdwoApe43ylskaUC37/6UGXxnyifyJf0OSH8vQ==
X-Received: by 2002:a05:6a00:18aa:b0:658:26a8:9d9e with SMTP id x42-20020a056a0018aa00b0065826a89d9emr10720128pfh.29.1686214041248;
        Thu, 08 Jun 2023 01:47:21 -0700 (PDT)
Received: from localhost.localdomain ([61.213.176.13])
        by smtp.gmail.com with ESMTPSA id 23-20020aa79157000000b0063b806b111csm614160pfi.169.2023.06.08.01.47.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 01:47:20 -0700 (PDT)
From:   Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>
To:     Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@osdl.org>, me@jcix.top,
        Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>
Subject: [PATCH 1/2] fuse: support unlock remote OFD locks on file release
Date:   Thu,  8 Jun 2023 16:46:08 +0800
Message-Id: <20230608084609.14245-2-zhangjiachen.jaycee@bytedance.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230608084609.14245-1-zhangjiachen.jaycee@bytedance.com>
References: <20230608084609.14245-1-zhangjiachen.jaycee@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Like flock(2), the fcntl(2) OFD locks also use struct file addresses as
the lock owner ID, and also should be unlocked on file release.

The commit 37fb3a30b462 ("fuse: fix flock") fixed the flock unlocking
issue on file release. This commit aims to fix the OFD lock by reusing
the release_flag 'FUSE_RELEASE_FLOCK_UNLOCK'. The FUSE daemons should
unlock both OFD locks and flocks in the FUSE_RELEASE handler.

To make it more clear, rename 'ff->flock' to 'ff->unlock_on_release', as
it would be used for both flock and OFD lock. It will be set true if the
value of fl->fl_owner equals to the struct file address.

Fixes: 37fb3a30b462 ("fuse: fix flock")
Signed-off-by: Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>
---
 fs/fuse/file.c   | 17 ++++++++++++++---
 fs/fuse/fuse_i.h |  2 +-
 2 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index de37a3a06a71..7fe9d405969e 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -312,7 +312,7 @@ void fuse_file_release(struct inode *inode, struct fuse_file *ff,
 
 	fuse_prepare_release(fi, ff, open_flags, opcode);
 
-	if (ff->flock) {
+	if (ff->unlock_on_release) {
 		ra->inarg.release_flags |= FUSE_RELEASE_FLOCK_UNLOCK;
 		ra->inarg.lock_owner = fuse_lock_owner_id(ff->fm->fc, id);
 	}
@@ -2650,8 +2650,19 @@ static int fuse_file_lock(struct file *file, int cmd, struct file_lock *fl)
 	} else {
 		if (fc->no_lock)
 			err = posix_lock_file(file, fl, NULL);
-		else
+		else {
+			/*
+			 * Like flock, the OFD lock also uses the struct
+			 * file address as the fl_owner, and should be
+			 * unlocked on file release.
+			 */
+			if (file == fl->fl_owner) {
+				struct fuse_file *ff = file->private_data;
+
+				ff->unlock_on_release = true;
+			}
 			err = fuse_setlk(file, fl, 0);
+		}
 	}
 	return err;
 }
@@ -2668,7 +2679,7 @@ static int fuse_file_flock(struct file *file, int cmd, struct file_lock *fl)
 		struct fuse_file *ff = file->private_data;
 
 		/* emulate flock with POSIX locks */
-		ff->flock = true;
+		ff->unlock_on_release = true;
 		err = fuse_setlk(file, fl, 1);
 	}
 
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 9b7fc7d3c7f1..574f67bd5684 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -225,7 +225,7 @@ struct fuse_file {
 	wait_queue_head_t poll_wait;
 
 	/** Has flock been performed on this file? */
-	bool flock:1;
+	bool unlock_on_release:1;
 };
 
 /** One input argument of a request */
-- 
2.20.1

