Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 303586ED1A3
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 17:44:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232085AbjDXPor (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 11:44:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231974AbjDXPop (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 11:44:45 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20D75114
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 08:44:44 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1a682eee3baso36453705ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 08:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682351083; x=1684943083;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Liz0MIHTZC+8yjVwhyhKwCvxY6q7FuOGysVJHylIYwg=;
        b=aWPMp8aIutJX+5Ikg85ec08QDoj24Ci7AvM3bqIBRm/4ywfZtwpWDHzmPQ2fhzdA3W
         sdTvU4fwc2dBz3VKyw5njkFfuIbPHsB2wsac5Oww+NH/aFngLqp1I3xcg430d0aVtydn
         1W86IIIDPGlhQ1JHfweJlCYgQ7Rvnp8Y6wYQlfPRxeS8sFI1BcDuhuS2qRWuUQ502LFb
         OMB6muEzLOVPM/NIm7Shd8KPCnnHaadZl4UcnZ6bpHrPfHMnZFKqK7S9bnZ3ECgcmSKA
         I93BSs43QwQFLQlRWTtiAo3C0ZXCmdq8Un8VWQDIdWjTt8syzI7D9MOO+OSymEtkXJ5i
         /TnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682351083; x=1684943083;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Liz0MIHTZC+8yjVwhyhKwCvxY6q7FuOGysVJHylIYwg=;
        b=BO3uSLJ4n/Hgk2lPOsLKHhWsUShS0c8NNcx+KbHbRblgWv8tjqzz3ekcYo77nlPFaE
         1vGq1+5jvQKKstQ9csqtz+BYDnn9yElhNrkVZAIoVdcI3Xy7VWp18qgNrs8kaU6hVNrO
         oz8ic7uz3JsHPUbU/YqGmZl5PWL3MZYtFP2ouv19bCqwsaBMyCWj1EB58U2K1bImFpdL
         bKul15hVkVd8sGeSIdHKdozFr1OMTIZiqOk4Ch1Z2c879wZMrQ5r8B8DxEpz2m4mR9Ky
         2Ss896uU7HTJTmCwEn/pGzsgKafPjDqwAjMRu8FG6YvqI7AeosX3rmywzxVWaDdkaWNT
         HlcQ==
X-Gm-Message-State: AAQBX9eqQ99ZPmx0m8Bk2K1zG5x4R5y99Wr70LeZOGRZ32LtaGaMdU/1
        kuyNss6PjRf8A2Taa8i/zw0eS3rLT24=
X-Google-Smtp-Source: AKy350aO8negNf/P+EkoliNumtvWgLv67wKHQ6+vUguorc9UsdSOjfH9FH9T11ABHspJhRPxIkeJ/A==
X-Received: by 2002:a17:902:e5c6:b0:1a1:d70f:7114 with SMTP id u6-20020a170902e5c600b001a1d70f7114mr16930176plf.14.1682351083096;
        Mon, 24 Apr 2023 08:44:43 -0700 (PDT)
Received: from daehojeong-desktop.mtv.corp.google.com ([2620:15c:211:201:26c1:a43d:1ede:71a3])
        by smtp.gmail.com with ESMTPSA id jb4-20020a170903258400b001a682a195basm6813106plb.28.2023.04.24.08.44.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Apr 2023 08:44:42 -0700 (PDT)
From:   Daeho Jeong <daeho43@gmail.com>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Cc:     Daeho Jeong <daehojeong@google.com>
Subject: [PATCH] f2fs: allocate node blocks for atomic write block replacement
Date:   Mon, 24 Apr 2023 08:44:40 -0700
Message-ID: <20230424154440.23279-1-daeho43@gmail.com>
X-Mailer: git-send-email 2.40.0.634.g4ca3ef3211-goog
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

From: Daeho Jeong <daehojeong@google.com>

When a node block is missing for atomic write block replacement, we need
to allocate it in advance of the replacement.

Fixes: 3db1de0e582c ("f2fs: change the current atomic write way")
Signed-off-by: Daeho Jeong <daehojeong@google.com>
---
 fs/f2fs/segment.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index c35476b3c075..0e1e29800934 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -217,7 +217,7 @@ static int __replace_atomic_write_block(struct inode *inode, pgoff_t index,
 
 retry:
 	set_new_dnode(&dn, inode, NULL, NULL, 0);
-	err = f2fs_get_dnode_of_data(&dn, index, LOOKUP_NODE_RA);
+	err = f2fs_get_dnode_of_data(&dn, index, ALLOC_NODE);
 	if (err) {
 		if (err == -ENOMEM) {
 			f2fs_io_schedule_timeout(DEFAULT_IO_TIMEOUT);
-- 
2.40.0.634.g4ca3ef3211-goog

