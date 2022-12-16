Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4FAE64ED75
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 16:07:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231252AbiLPPGx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 10:06:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231290AbiLPPGo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 10:06:44 -0500
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 138DC26F9;
        Fri, 16 Dec 2022 07:06:44 -0800 (PST)
Received: by mail-pg1-x541.google.com with SMTP id 142so1958033pga.1;
        Fri, 16 Dec 2022 07:06:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qXJ+hu1W+MkDKQzyjzyjlsyWKm6yYLZxnEaJDMbEqIw=;
        b=k+IHLTB/7JGZrk31MrVj+wMMruLTAST2U5YIGYOVOy8xjrc4x+2qbrXG1NKRqOn68a
         +khpwQX/VQtNkix/4LDufLWeh8ZeOlLb7cUI3oBtFFYlS4WzfSCgZTb/WFEvdbzXnODm
         2GZACVybtynEvZHGpHr64k2UeJvQDYx6mycJJDsjlQ1ttIQM0qYBYVf8hBBdImjnjoAy
         fr9PbnpzNCkTgIycAPkfInRLfhi4MP/UA56piOGiJr+yBLxP5y8v8CLQCTrc2Rgigxqk
         ozCMn2abngu0oxZt0VpDQ56KtKxBIm6Alq9YLjWDhqDvwGlVA9qkVyDP2eN9zLqiGgas
         UCZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qXJ+hu1W+MkDKQzyjzyjlsyWKm6yYLZxnEaJDMbEqIw=;
        b=gaz7+oJSjAmwL5zF52yzUHPZJ76jAJXgqfx8uBCv0R31UIUD/VsgG2ZYeCyKvPYE3Z
         CjlyOmziRujOpuvEG+koGNRTCw6NE27RRAUUTweW1ODoUOSTTvA3EjvdXb6Xmj1ecK8G
         0LlK2bBkX8zAkwP8lIEKvNBIxa6WHtAlmo8zV+IGHEEo+/d3WpHkMHuerpjfFST/3/8Q
         nFdJdqZq9aqU9Q4o461np+t4/mOpnhk2I658hNZ8EXbEubWW5crKJNk8slFPGdcEbtau
         DH6+DkVY1Ec1RshUKchMWEME4qxzTq7dQ4Bn3SFJkz+x1mWbx56xQw2HvBGQjkp7PdUU
         RR3A==
X-Gm-Message-State: ANoB5pnoEpH+RJdfxXBmev2qvuaF9c4V9djrJpZNxOwSW2A4eXdfiTfa
        9WlgwIJI7mE+9ITpqtJikbA=
X-Google-Smtp-Source: AA0mqf53H/vN42Twc1eK2ccxzt3Q0PqfJkw+e6VijnfUxFJ3ZBzTg+/klTdnsXnTb9qPZJIzt9J9Cw==
X-Received: by 2002:aa7:9041:0:b0:56c:3ed0:1f9d with SMTP id n1-20020aa79041000000b0056c3ed01f9dmr30472657pfo.17.1671203203588;
        Fri, 16 Dec 2022 07:06:43 -0800 (PST)
Received: from localhost.localdomain ([139.177.225.252])
        by smtp.gmail.com with ESMTPSA id b27-20020aa78edb000000b005772bf1b61bsm1615288pfr.67.2022.12.16.07.06.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Dec 2022 07:06:43 -0800 (PST)
From:   huteng19901016@gmail.com
X-Google-Original-From: huteng.ht@bytedance.com
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        "huteng.ht" <huteng.ht@bytedance.com>
Subject: [PATCH] blk-mq: fix possible NULL pointer access in classic polling
Date:   Fri, 16 Dec 2022 23:06:36 +0800
Message-Id: <20221216150636.18111-1-huteng.ht@bytedance.com>
X-Mailer: git-send-email 2.24.2 (Apple Git-127)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "huteng.ht" <huteng.ht@bytedance.com>

Since poll method in blk_mq_ops may not be implemented by driver,
add a judgement to avoid NULL pointer access.

Signed-off-by: huteng.ht <huteng.ht@bytedance.com>
---
 block/blk-mq.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index c5cf0dbca1db..f58f166d1c75 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -4897,6 +4897,8 @@ static int blk_mq_poll_classic(struct request_queue *q, blk_qc_t cookie,
 	int ret;
 
 	do {
+		if (!q->mq_ops->poll)
+			break;
 		ret = q->mq_ops->poll(hctx, iob);
 		if (ret > 0) {
 			__set_current_state(TASK_RUNNING);
-- 
2.20.1

