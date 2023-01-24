Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8A9C6796B1
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 12:32:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234103AbjAXLcr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 06:32:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234101AbjAXLcp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 06:32:45 -0500
Received: from mail-ed1-x549.google.com (mail-ed1-x549.google.com [IPv6:2a00:1450:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADCA13EC61
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 03:32:41 -0800 (PST)
Received: by mail-ed1-x549.google.com with SMTP id y21-20020a056402359500b0049e171c4ad0so10411563edc.6
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 03:32:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=eUs+oxPX+Th3wCoMo6p6epBi5r7JS+DC4cGwD7gny+c=;
        b=CqGd/97PcLQj91KKCP5sxd4iglhV1eOb7dm0qEy1kEmbfQ9dWO/BilGXTlraPVU/uo
         8qVKcb+sPAZUz5xOgKIa8tqZcq9ak5jafw0trh0fnw2+7H5ymJnBuBw8kJfjeRVRG4VP
         RiWvT1jniMcwmDlrK9v0dqfsVJOfnFcJB+PvBMXGMGisiwZzxRtzvJL+lkIIh76o5joG
         cyWQhxAKNfEW8OSBUCiXWoOYRJ+k76EgWktoj1igjFT+++pLILH6yGzoIVZMHLcJIjCG
         Vl57c4dYpI7JkJH/Sh2ILc8hmtPb+3gyWYt+tC54dYHroPPOyPo4CWmLj0hAQkYO8u/+
         ST3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eUs+oxPX+Th3wCoMo6p6epBi5r7JS+DC4cGwD7gny+c=;
        b=etBVYzDMCaSWKYo3VRWMXOlzTamqPr1hu7u5po0IdmY5fQsFBGfCzc12WYHAOAf6vI
         SV3fgaqAMhPRm92Go6DHSvT0DlBNrJ957d3NXMgie8Ffc0UxVA+E5RYKzM2O0h5Qmwp6
         sV57uy7mT8JvkMdRHh5dLi0ywv/WvAjLx2GozJ0pdnBvxxrzZSnHp4d2wbTYgq9lTRGy
         0G5TJ8HypXVBrqOgQTGVOm0rtOeyuofUnkFrE6pvI4Z0lGIclT245tAoYEH515Le7UzR
         yj0KXPN9WyyJtG+Lebmv4acGd/p4YgNZRZCEZglEgA8ugYRdHEvnk4oG48ROme1YE9uL
         ZgZA==
X-Gm-Message-State: AFqh2kqq5rwy5lEO5G0KuRVReWP/44z2efiTT2BezG77p/m6h14tqNaI
        Ug2NXQ0owRx9EUn+y9ZjJpRl2MHer7M=
X-Google-Smtp-Source: AMrXdXukPK/fp3o4cX+0H76GM//1rajVg16t0TEI+/mYOVFX441vBmDJO4sQq9Ijsu2A4ylpiGExyr8esNA=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:9c:201:21dc:97d0:ed7:bbcd])
 (user=glider job=sendgmr) by 2002:a05:6402:d2:b0:48e:bad6:720c with SMTP id
 i18-20020a05640200d200b0048ebad6720cmr3152609edu.2.1674559959884; Tue, 24 Jan
 2023 03:32:39 -0800 (PST)
Date:   Tue, 24 Jan 2023 12:32:34 +0100
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.0.246.g2a6d74b583-goog
Message-ID: <20230124113234.2070729-1-glider@google.com>
Subject: [PATCH] btrfs: zlib: zero-initialize zlib workspace
From:   Alexander Potapenko <glider@google.com>
To:     glider@google.com
Cc:     clm@fb.com, dsterba@suse.com, josef@toxicpanda.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        ebiggers@kernel.org,
        syzbot+14d9e7602ebdf7ec0a60@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

KMSAN reports uses of uninitialized memory in zlib's longest_match()
called on memory originating from zlib_alloc_workspace().
This issue is known by zlib maintainers and is claimed to be harmless,
but to be on the safe side we'd better initialize the memory.

Link: https://zlib.net/zlib_faq.html#faq36
Reported-by: syzbot+14d9e7602ebdf7ec0a60@syzkaller.appspotmail.com
Signed-off-by: Alexander Potapenko <glider@google.com>
---
 fs/btrfs/zlib.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/zlib.c b/fs/btrfs/zlib.c
index 01a13de118320..da7bb9187b68a 100644
--- a/fs/btrfs/zlib.c
+++ b/fs/btrfs/zlib.c
@@ -63,7 +63,7 @@ struct list_head *zlib_alloc_workspace(unsigned int level)
 
 	workspacesize = max(zlib_deflate_workspacesize(MAX_WBITS, MAX_MEM_LEVEL),
 			zlib_inflate_workspacesize());
-	workspace->strm.workspace = kvmalloc(workspacesize, GFP_KERNEL);
+	workspace->strm.workspace = kvzalloc(workspacesize, GFP_KERNEL);
 	workspace->level = level;
 	workspace->buf = NULL;
 	/*
-- 
2.39.0.246.g2a6d74b583-goog

