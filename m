Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 152F1646866
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 06:08:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbiLHFIU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 00:08:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbiLHFIS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 00:08:18 -0500
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 767C448420
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 21:08:16 -0800 (PST)
Received: by mail-pg1-x544.google.com with SMTP id q71so314643pgq.8
        for <linux-kernel@vger.kernel.org>; Wed, 07 Dec 2022 21:08:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Gdty8nCzzxU1/GlNFaeUd8yKGkLHYUKDqxUERmNsEr8=;
        b=Vvwv2VkYAQSACAqdzGSFhy3nem8BCnsPHs21OgZQITrEYaUTG8oEBA2DViOjBh+BW2
         wZ/tqygqhcuZry305fAntN9EC3u9EOlGOvOhB7HWhaAcPuYGXItjyWWOXdlUGuW/t3e1
         IgiZMThF0EfEliihC1T4XYgRHgiIMNQXungYCrOusU/uwzp2ZZS0k7C8b+EEK4pyOVJR
         bJ2b+WWqDY9STB1g3O22lyKteYGnyPN1v5nufkmsCsSRKCOSMg5S/6YGUkWwAEbr2yUG
         yIOuhUnGMrg4y03ktzfdZ4Ak3bM1L5p1GxlC/zbTae5wEG064gOVKcELLsKRxsH9aKsv
         bJ0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Gdty8nCzzxU1/GlNFaeUd8yKGkLHYUKDqxUERmNsEr8=;
        b=qJ+ibV/5FvCagRqj4ln0ARfXowZhArzhmVd/VvXXc2+ysI4i9oQDMgNNaUm1B7STE4
         Dn9UXE5C1uR4vfNaTipKX6PSYCAd6KTE4yjnRJrsJE14fHVtGpUV5kOg1/tN33YtwNGd
         1LhfaVOmqSantQPUGcZZbUcWUGrIzBrpyd7qsL/bWOj5u3be7p/lcUK5EjE+KGGugW1p
         EPhppG6p2OgIul4GvNMBeP/R3+SP4WHrigo9H1Z0STX3J4uCc4o6HZut9uGOg9F6zRgS
         QeeQnxg4X2LU5J0pFzMjNtZK7tzBygB9FZXs3mVucWuVRNeeJUB8Cf6AI0oVgPD+ka07
         cRtA==
X-Gm-Message-State: ANoB5pnnW6VT9cTUrRXdZMjxlt+QLjdnvZ8HkR3JboJazqAkeynSrMWK
        CikXK2jQqi/DbqY15+ev2p5Ce8FgqZBOKQ==
X-Google-Smtp-Source: AA0mqf5M8DVggQQWkH79sh8XoqSYBx2IHKmduKAbiSGSLQ1P8h0TzOZbwvdLoN9yLs3f4L/RzoaYYg==
X-Received: by 2002:a05:6a00:1388:b0:577:1c59:a96c with SMTP id t8-20020a056a00138800b005771c59a96cmr2103581pfg.2.1670476095931;
        Wed, 07 Dec 2022 21:08:15 -0800 (PST)
Received: from mi-ThinkStation-K.mioffice.cn ([43.224.245.228])
        by smtp.gmail.com with ESMTPSA id c194-20020a621ccb000000b0056d3b8f530csm14383760pfc.34.2022.12.07.21.08.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Dec 2022 21:08:15 -0800 (PST)
From:   zhoudan8 <zhuqiandann@gmail.com>
X-Google-Original-From: zhoudan8 <zhoudan8@xiaomi.com>
To:     jaegeuk@kernel.org
Cc:     chao@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, zhoudan8 <zhoudan8@xiaomi.com>
Subject: [PATCH] f2fs: don't set FI_COMPRESS_RELEASED if file is not compressed
Date:   Thu,  8 Dec 2022 13:08:08 +0800
Message-Id: <20221208050808.2448146-1-zhoudan8@xiaomi.com>
X-Mailer: git-send-email 2.38.1
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

In compress_mode=user, f2fs_release_compress_blocks()
 does not verify whether it has been compressed and
 sets FI_COMPRESS_RELEASED directly. which will lead to
return -EINVAL after calling compress.
To fix it,let's do not set FI_COMPRESS_RELEASED if file
is not compressed.

Signed-off-by: zhoudan8 <zhoudan8@xiaomi.com>
---
 fs/f2fs/file.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 82cda1258227..f32910077df6 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -3451,14 +3451,13 @@ static int f2fs_release_compress_blocks(struct file *filp, unsigned long arg)
 	ret = filemap_write_and_wait_range(inode->i_mapping, 0, LLONG_MAX);
 	if (ret)
 		goto out;
-
-	set_inode_flag(inode, FI_COMPRESS_RELEASED);
 	inode->i_ctime = current_time(inode);
 	f2fs_mark_inode_dirty_sync(inode, true);
 
 	if (!atomic_read(&F2FS_I(inode)->i_compr_blocks))
 		goto out;
 
+	set_inode_flag(inode, FI_COMPRESS_RELEASED);
 	f2fs_down_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
 	filemap_invalidate_lock(inode->i_mapping);
 
-- 
2.38.1

