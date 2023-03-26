Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BBE26C961E
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Mar 2023 17:21:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232408AbjCZPVu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Mar 2023 11:21:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbjCZPVt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Mar 2023 11:21:49 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87FA27284;
        Sun, 26 Mar 2023 08:21:44 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id h12-20020a17090aea8c00b0023d1311fab3so6181080pjz.1;
        Sun, 26 Mar 2023 08:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679844104;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nSW0yZ/8PqCmJ515Nk2Q6ClqvBnG6F3s+Yexzns2FiY=;
        b=NcAEOnWfyfOYB53pnelUpofAE53NS/W77HtJB+tEii830WjdSQgP2t6NIKXtSdW0/X
         RmE5+6l2PMRnn3bymt+uaA+QUclipcmcsMEPqUfmPzTnLwuBxeQ3OOdzWwlV2CpJL6wi
         5ULtS+4bM/Ct58SDIg0HA/XadZu4qPGIod7T1+i9xDruhhdJQNXvJOkyeiloo3IcVMAT
         S/b+IAOzvwqYCWS1d1WdSKmR8tn7cSGxAJewlmIjWjOmvnreoHTMfFzkJv/ybluvRlqj
         w1ggqTxTqniXXFdYAS+h5Kkd+XxIa+fgQTZhGXPyPXnYu4/tw3vTzeykcO2opNTMQ4Hz
         BJdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679844104;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nSW0yZ/8PqCmJ515Nk2Q6ClqvBnG6F3s+Yexzns2FiY=;
        b=wQ9bmaz6FowGDPBjvjVQ5y45SViRe6a3xk6IH1H1mityCOHDMv6T8RO81VWCpKpGij
         TCvE+ljQzhMtAoc9gds6TCicwmlKAVbB/rk++z40TJ1IM6Urol5qYuPtuFkUC1gZP9Qj
         XHQF9zkcKWfp4zlci3mV1RZtBMjMJ6NqhUk52OnfGS3x7b/dJy/UMMOo7wQkTRf6Ii3j
         14qUGF35BUJiDoHqbtOAz8Yxcxu+3u3tgOIV9OvGlTzZfC37SOqAqCkpZ1MpmR2YTate
         jbmDavUGct6y2u4Vm5JFdixPXaK4jsg/2+buN5XYPZGmIYKYERgMjC/UPhLlZsaJ0eqY
         FcmQ==
X-Gm-Message-State: AO0yUKW/o3AJgfCrSsauFmap2XXPNh0gjyD4ER3dTtkHnP2y+S5bpZ4M
        FifMS7zfsUdIhbvT0GiiQpU=
X-Google-Smtp-Source: AK7set/DT/n1mOzyzwvLsMxr1LvnQHIG2G6jdc6yPe8aQzO63eo+7x7dumwJUFc+OanIwMPLvG3bog==
X-Received: by 2002:a05:6a20:bca6:b0:da:949:f074 with SMTP id fx38-20020a056a20bca600b000da0949f074mr8033210pzb.43.1679844103695;
        Sun, 26 Mar 2023 08:21:43 -0700 (PDT)
Received: from carrot.. (i223-217-34-84.s42.a014.ap.plala.or.jp. [223.217.34.84])
        by smtp.gmail.com with ESMTPSA id y22-20020aa78556000000b00627eac32b11sm14459450pfn.192.2023.03.26.08.21.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Mar 2023 08:21:42 -0700 (PDT)
From:   Ryusuke Konishi <konishi.ryusuke@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-nilfs@vger.kernel.org,
        syzbot <syzbot+048585f3f4227bb2b49b@syzkaller.appspotmail.com>,
        syzkaller-bugs@googlegroups.com, linux-kernel@vger.kernel.org,
        glider@google.com,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Subject: [PATCH] nilfs2: initialize "struct nilfs_binfo_dat"->bi_pad field
Date:   Mon, 27 Mar 2023 00:21:46 +0900
Message-Id: <20230326152146.15872-1-konishi.ryusuke@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <0000000000000d710705f63f014c@google.com>
References: <0000000000000d710705f63f014c@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>

nilfs_btree_assign_p() and nilfs_direct_assign_p() are not initializing
"struct nilfs_binfo_dat"->bi_pad field, causing uninit-value reports
when being passed to CRC function.

Reported-by: syzbot <syzbot+048585f3f4227bb2b49b@syzkaller.appspotmail.com>
Link: https://syzkaller.appspot.com/bug?extid=048585f3f4227bb2b49b
Reported-by: Dipanjan Das <mail.dipanjan.das@gmail.com>
Link: https://lkml.kernel.org/r/CANX2M5bVbzRi6zH3PTcNE_31TzerstOXUa9Bay4E6y6dX23_pg@mail.gmail.com
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
---
Andrew, please pick this up, a fix for the KMSAN report.

Ryusuke Konishi

fs/nilfs2/btree.c  | 1 +
 fs/nilfs2/direct.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/fs/nilfs2/btree.c b/fs/nilfs2/btree.c
index 2681a449edc1..13592e82eaf6 100644
--- a/fs/nilfs2/btree.c
+++ b/fs/nilfs2/btree.c
@@ -2219,6 +2219,7 @@ static int nilfs_btree_assign_p(struct nilfs_bmap *btree,
 	/* on-disk format */
 	binfo->bi_dat.bi_blkoff = cpu_to_le64(key);
 	binfo->bi_dat.bi_level = level;
+	memset(binfo->bi_dat.bi_pad, 0, sizeof(binfo->bi_dat.bi_pad));
 
 	return 0;
 }
diff --git a/fs/nilfs2/direct.c b/fs/nilfs2/direct.c
index a35f2795b242..4c85914f2abc 100644
--- a/fs/nilfs2/direct.c
+++ b/fs/nilfs2/direct.c
@@ -314,6 +314,7 @@ static int nilfs_direct_assign_p(struct nilfs_bmap *direct,
 
 	binfo->bi_dat.bi_blkoff = cpu_to_le64(key);
 	binfo->bi_dat.bi_level = 0;
+	memset(binfo->bi_dat.bi_pad, 0, sizeof(binfo->bi_dat.bi_pad));
 
 	return 0;
 }
-- 
2.34.1

