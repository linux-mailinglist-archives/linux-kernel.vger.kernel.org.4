Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 598276AB74D
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 08:56:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbjCFHz7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 02:55:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjCFHz5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 02:55:57 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D75518151
        for <linux-kernel@vger.kernel.org>; Sun,  5 Mar 2023 23:55:56 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id cp7-20020a17090afb8700b0023756229427so12341393pjb.1
        for <linux-kernel@vger.kernel.org>; Sun, 05 Mar 2023 23:55:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678089356;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DXM+F0nCeNTp6Op2aBBfKjMUtWoANY5Axbyzod0a2dk=;
        b=JuHi9hM/KWhW1Mri//QAde/70PgU9JOPU4yDSh9qWdIQdD8fzQGWUiePB8OSSZAnV1
         zT9kyW1GwWMvvo/Zr8C5c0mst/Ch8s3CljIrPvOkGexctWW/m/vJ12+TSDPlSE6at6N1
         MnCrM1NAjW1I2sDCEgFV9bM66E2nTCR0K8SqwYPDCxba5DUcuMmnYrTpMGqa+WUOLqm1
         dHZxYY6KvpB0Ox486ldWbITM5Cb3E+O5AW7d9DLzcnA5671fRdlB24bn2Sl2PMQo/KnW
         iW/1iOojHqoQg7k0yafD8+jSiwgMK0zgRTcQ3ja7w8ajdG0b7u6H/Ey7Z0SvWEJWExzt
         DHJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678089356;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DXM+F0nCeNTp6Op2aBBfKjMUtWoANY5Axbyzod0a2dk=;
        b=299ovpMpk4A2TZABvG5KCRoIQI+MUeTlATkRmuLRW7zKMmM+9GrFNM4riUCGwUJW5Z
         mtds8KVCrvnc+Rll/iRHbNSq8qu7sECf6bdv11SW05LC9hNMc1x2CeWKFVi3+aG48QlJ
         nKbTLCIh2/+YoNq9suCAEso+S4+x+R9NW0r4OorEbi/ZK+KrgEVH8VaJVyOKQ1TWiDf4
         no0J+dR6sWM70EWyFsFIQ/Y1qTfn93AyhzG+16g2XVBbvAHi2xyCkqvA9tBujFrjeUEH
         4IPq7sj6v9DQq4qJREc91fab5RBVMWjQQzBJqOc9vMmwuZx5t7y0my69vIZyxEmuLFPh
         nVLQ==
X-Gm-Message-State: AO0yUKUHjfkgtlvSfA1DAh2AWFgs96cNe6CDh9olx3ALAYkMwZ6jUK53
        1+mtj0XZUtGvnP8GqUaV3Fc=
X-Google-Smtp-Source: AK7set81pCf7l04ni0N9M1wStJKHShAv5aKLKdYUmKU14uNwyjDN4qqUNH/yoOsUTw7c7PAana0Alg==
X-Received: by 2002:a17:90b:3b85:b0:234:8c58:c325 with SMTP id pc5-20020a17090b3b8500b002348c58c325mr10160476pjb.31.1678089355951;
        Sun, 05 Mar 2023 23:55:55 -0800 (PST)
Received: from localhost.localdomain ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id e8-20020a17090ac20800b0022be36be19asm5383079pjt.53.2023.03.05.23.55.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Mar 2023 23:55:55 -0800 (PST)
From:   Yue Hu <zbestahu@gmail.com>
To:     xiang@kernel.org, chao@kernel.org, jefflexu@linux.alibaba.com,
        linux-erofs@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org, huyue2@coolpad.com,
        zhangwen@coolpad.com
Subject: [PATCH] erofs: use wrapper i_blocksize() in erofs_file_read_iter()
Date:   Mon,  6 Mar 2023 15:55:27 +0800
Message-Id: <20230306075527.1338-1-zbestahu@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yue Hu <huyue2@coolpad.com>

linux/fs.h has a wrapper for this operation.

Signed-off-by: Yue Hu <huyue2@coolpad.com>
---
 fs/erofs/data.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index 5bd0c956a142..7e8baf56faa5 100644
--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -380,7 +380,7 @@ static ssize_t erofs_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 		if (bdev)
 			blksize_mask = bdev_logical_block_size(bdev) - 1;
 		else
-			blksize_mask = (1 << inode->i_blkbits) - 1;
+			blksize_mask = i_blocksize(inode) - 1;
 
 		if ((iocb->ki_pos | iov_iter_count(to) |
 		     iov_iter_alignment(to)) & blksize_mask)
-- 
2.17.1

