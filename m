Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1750E71682F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 17:56:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232370AbjE3P4s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 11:56:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229922AbjE3P4l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 11:56:41 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD4BDFC;
        Tue, 30 May 2023 08:56:13 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id ca18e2360f4ac-77483f80522so330931239f.3;
        Tue, 30 May 2023 08:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685462173; x=1688054173;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EHPDY3TJU7UcVZdSMbyBJ0h6GxojmriPacPRkWmpcMs=;
        b=aCTRD+Uau0895BPuxHI20+5Al53gsqSglyzrbXD4iMbup6B0viGsJdYsPTLdR5aEXu
         GV/86BMGQrvcC8BRsYQhTShhJMk7Pj/EUdCyj+JGeIXds2h1CKBZ63w0IO8/h7bQO2sd
         8nbnZi7Su5+RVdHRBNCaVmdIDFwe9NDYJots8URgjwTjUcC3x7hmeVzEVBAb/tNWuaIF
         wdYzu7pKxAVXef6KKVspL3R/RB+qxguw86i7wI/VtI3Pu0woUz9ZHCNUeUQwdGm1GHan
         2PbvLtUxSzIRfRRZr9EqhpjJoapS3S8wYsqwCj46TrtxdoviXqNkMUDh4PDI2tC0CkCG
         RPew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685462173; x=1688054173;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EHPDY3TJU7UcVZdSMbyBJ0h6GxojmriPacPRkWmpcMs=;
        b=GYdvTKGWRJfmCJrYyKHuSEIh66OPPsdAYBJu8nGgRxUHp2ZnwlgFfZd3tichW6dNnp
         Jh2DjnaPPBe8eSXgr4KTVmpLnsKmvUVeOZyznbsmGfPogNATkltgFe+dow2iu2mEQQQt
         XsQIw8IS4dmqJ1Q99XjxQ6h5ZhIpZWDWWQq5Wll6NlF+gxziaRlwckLYBs6gsocHHtxT
         lbRXr7Vjf3PF44+jouV2dcuJP7zrG5F52k+2moOIcnDqOh+daYZw1um3OXJkILQGUjnc
         5Bwax1RYavBI30TiTY8JS41op6JIs5vpwEm6+y7ltNwbwOrVSDL/JgLpP7ixesSkeDk0
         NLTg==
X-Gm-Message-State: AC+VfDz7IPPPUnp/uhbKnwhl3TJ0aJshrVr2WVn61Kf+X43hdnrDqvIa
        Sa4v4Ry1v6iKJ9cIjv5IKtyNen4Cync=
X-Google-Smtp-Source: ACHHUZ4DmqAqJcMsDyI9rOyHLkeO+p79vjuuMBXgNJiX1XgjsMxobl4x7hion01uhoM8kf1bdQjq8g==
X-Received: by 2002:a5e:c101:0:b0:76c:595a:6b5f with SMTP id v1-20020a5ec101000000b0076c595a6b5fmr1927961iol.20.1685462172880;
        Tue, 30 May 2023 08:56:12 -0700 (PDT)
Received: from azeems-kspp.c.googlers.com.com (54.70.188.35.bc.googleusercontent.com. [35.188.70.54])
        by smtp.gmail.com with ESMTPSA id ct11-20020a056638488b00b00408b3bc8061sm805571jab.43.2023.05.30.08.56.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 08:56:12 -0700 (PDT)
From:   Azeem Shaikh <azeemshaikh38@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-hardening@vger.kernel.org,
        Azeem Shaikh <azeemshaikh38@gmail.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] block: Replace all non-returning strlcpy with strscpy
Date:   Tue, 30 May 2023 15:56:08 +0000
Message-ID: <20230530155608.272266-1-azeemshaikh38@gmail.com>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
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

strlcpy() reads the entire source buffer first.
This read may exceed the destination size limit.
This is both inefficient and can lead to linear read
overflows if a source string is not NUL-terminated [1].
In an effort to remove strlcpy() completely [2], replace
strlcpy() here with strscpy().
No return values were used, so direct replacement is safe.

[1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy
[2] https://github.com/KSPP/linux/issues/89

Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>
---
 block/blk-cgroup-fc-appid.c |    2 +-
 block/elevator.c            |    2 +-
 block/genhd.c               |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/block/blk-cgroup-fc-appid.c b/block/blk-cgroup-fc-appid.c
index 842e5e1c0f3c..3ec21333f393 100644
--- a/block/blk-cgroup-fc-appid.c
+++ b/block/blk-cgroup-fc-appid.c
@@ -34,7 +34,7 @@ int blkcg_set_fc_appid(char *app_id, u64 cgrp_id, size_t app_id_len)
 	 * the vmid from the fabric.
 	 * Adding the overhead of a lock is not necessary.
 	 */
-	strlcpy(blkcg->fc_app_id, app_id, app_id_len);
+	strscpy(blkcg->fc_app_id, app_id, app_id_len);
 	css_put(css);
 out_cgrp_put:
 	cgroup_put(cgrp);
diff --git a/block/elevator.c b/block/elevator.c
index 24909069f872..8400e303fbcb 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -751,7 +751,7 @@ ssize_t elv_iosched_store(struct request_queue *q, const char *buf,
 	if (!elv_support_iosched(q))
 		return count;
 
-	strlcpy(elevator_name, buf, sizeof(elevator_name));
+	strscpy(elevator_name, buf, sizeof(elevator_name));
 	ret = elevator_change(q, strstrip(elevator_name));
 	if (!ret)
 		return count;
diff --git a/block/genhd.c b/block/genhd.c
index 1cb489b927d5..3537b7d7c484 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -253,7 +253,7 @@ int __register_blkdev(unsigned int major, const char *name,
 #ifdef CONFIG_BLOCK_LEGACY_AUTOLOAD
 	p->probe = probe;
 #endif
-	strlcpy(p->name, name, sizeof(p->name));
+	strscpy(p->name, name, sizeof(p->name));
 	p->next = NULL;
 	index = major_to_index(major);
 

