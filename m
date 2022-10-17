Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9F81600BF2
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 12:05:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231487AbiJQKFJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 06:05:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230201AbiJQKE6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 06:04:58 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08CE61EEE8
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 03:04:50 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id p14so10636578pfq.5
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 03:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RuPi2kJWnTKaT4aVfokzpN9MYv+IdW9MQr50PHecKpc=;
        b=YqrS+attN7r6MY97eZcauP2HvFXu4WYJG9YWeF68qJKfCeX4QvaDqnSIf7HRVaCGBu
         dyfX63Th9wv9ekjiN4sNRwIFAJOIH8V4CW4DoGjI3E7NrGgyqpxqX+Gb5LVgxMrT5iph
         kp6diM4a3u4zvnIh9+qT9M+bISfNBPi8ilhCdN3gfZRoX92oalbeY8NOo61j4icEA/LU
         TUl+caQH8o+IfOQx/Gr6iJFRzWFJPl+UVKH7dEsC69z1Fe5CI6CfnwEUnXtLFS62gjmj
         I6WvoOaJkOq2dj2Tj2qjCVWcvVNYoBZLQd7VkGTI0YotieAGsHB8qRroUGsYyI6JNS3Q
         9Lrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RuPi2kJWnTKaT4aVfokzpN9MYv+IdW9MQr50PHecKpc=;
        b=65VFBUC3qg+GRhN9diKHEPQbKR0k+a4ZM8I7eCnfjpjRwU1ycrejG4pYqxC2VgF94v
         ctuTrmprKOh9pX2Ch0zU4CKf2PCM5+OoD0pQ12ud8udMuGl6yFw7f4L4pu1wjWUHiYuX
         p9bJO6NCmkC8pmPqxNb2aeAF6XJwnWaeTlSzrhhyGEeuYBD99lzb026Yr/3k9uhckILT
         z5WeIwC1GuQ8AKFjrfHjeNSnPtZDBdjNQiNzJ6MaRS+xgOxYOXXrSbvOyoruLCHVLwdf
         o1z/M7sa+ZY7gs3a5XWkcn9QTm+U6ekV5yWBeuJPLk57+cuKp7/a44EJwbb1OAO1qXZ5
         RRRQ==
X-Gm-Message-State: ACrzQf3mE0ivnv/fyLzF1Ed8c6cib1BqrA0639QpcEfDKu7YeqwsmyPB
        Ef7cfiLn4hsvBn7t2ySOT6Q=
X-Google-Smtp-Source: AMsMyM7eZofAjeHWzJ94vO88RDrBbxJwmqGvA2+l5nKX+AFUaM4MF83Mofo0oOBLql0h1YnbJ4S/fg==
X-Received: by 2002:a63:5658:0:b0:43c:dac:9e24 with SMTP id g24-20020a635658000000b0043c0dac9e24mr9915160pgm.562.1666001089618;
        Mon, 17 Oct 2022 03:04:49 -0700 (PDT)
Received: from localhost.localdomain (124244014158.ctinets.com. [124.244.14.158])
        by smtp.gmail.com with ESMTPSA id d8-20020a170902cec800b0017f7b6e970esm6248454plg.146.2022.10.17.03.04.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 03:04:49 -0700 (PDT)
From:   Hoi Pok Wu <wuhoipok@gmail.com>
To:     jaegeuk@kernel.org, chao@kernel.org
Cc:     Hoi Pok Wu <wuhoipok@gmail.com>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org,
        syzbot+035a381ea1afb63f098d@syzkaller.appspotmail.com,
        syzkaller-bugs@googlegroups.com
Subject: [PATCH] fs: f2fs: fix kernel discard_thread NULL dereference
Date:   Mon, 17 Oct 2022 18:04:37 +0800
Message-Id: <20221017100437.618363-1-wuhoipok@gmail.com>
X-Mailer: git-send-email 2.38.0
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

Pointer discard_thread is pointing to nowhere, using IS_ERR prevents the
situation. IS_ERR also seen being used throughout the file.

Link: https://syzkaller.appspot.com/bug?id=9499bc6574cea5940e48199c2fd0732d9b11e5e1
Reported-by: syzbot+035a381ea1afb63f098d@syzkaller.appspotmail.com
Signed-off-by: Hoi Pok Wu <wuhoipok@gmail.com>
---
 fs/f2fs/segment.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index acf3d3fa4363..79978b7206b5 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1634,7 +1634,8 @@ void f2fs_stop_discard_thread(struct f2fs_sb_info *sbi)
 		struct task_struct *discard_thread = dcc->f2fs_issue_discard;
 
 		dcc->f2fs_issue_discard = NULL;
-		kthread_stop(discard_thread);
+		if (!IS_ERR(discard_thread))
+			kthread_stop(discard_thread);
 	}
 }
 
-- 
2.38.0

