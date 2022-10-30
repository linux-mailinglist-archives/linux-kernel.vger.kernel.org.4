Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AA8D612892
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Oct 2022 08:03:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbiJ3HDR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Oct 2022 03:03:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbiJ3HDO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Oct 2022 03:03:14 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E274F6380
        for <linux-kernel@vger.kernel.org>; Sun, 30 Oct 2022 00:03:13 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id 192so8179680pfx.5
        for <linux-kernel@vger.kernel.org>; Sun, 30 Oct 2022 00:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DyF/R/2WTrLneukk7kSdKd5EhCLxrsOWmVW7ecTbbfM=;
        b=YHomcf2498kp/tmkp72Pt2Iup6sbFL7DvV7NfXwhPbU6ZLv/+4FHQvJrfvw1OnVN74
         hS0HUxVXnb9p4cnMisRtzLiXm7MwNcW2wohkuUgHYw6lmkjcwhc6n8MOmAhQ3ukz8gHk
         5WdR9Hp4Yb+eG22ZhGGT2A9rDn4cCLywl1cmQgCTMzQVlgle2lgtBNWz7cbtzv1SRy3A
         lN5O6HJnVkX4/MaHOiz62yHDtveVvJtvjsGJ08UBgyDx+QbKocB5xiKulJnZO/7XNWJT
         FHpQKOglixHOlQsUBejX/uy/50/kRwU19TwwORbqXZc70aziIfoNVnMYtCdFvlVnL0Rh
         Ls6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DyF/R/2WTrLneukk7kSdKd5EhCLxrsOWmVW7ecTbbfM=;
        b=YAVcqB4oQNJdrqhhGchXRDx5dPGcbblN862NC87btOyn5YYtqybS6zuDGPv6vMfTFp
         9J2E2FP/PcUSBjU0wj9HGDS4DU1rOxukeHeueMShmBLcvxAzVbgufhaYA40eoSbAH6J/
         iIOVsb3nS1GExAF9XMlyOy7+fuVsktSokVE2IohcE0DRZkPpk+0a/p0xarXG+Y5wPydF
         fbloDKvk8mLnwWm+38ygJcDvjUlbMVNpHICIHqAWXEHx7e9ZoBjK6Rqa45UD4mZWlyPU
         PhFMHZtBPSE137WUT9eSlhkzdCI2acwPnW7+xhLCzPPn1w26k4YvU2svD32VD25duRGR
         rwGw==
X-Gm-Message-State: ACrzQf20SGM9ymClrLMpnEijWeXun0AD9qUSQZad+IJCFZ29xoMsXsJW
        +bzKmToxSiAOZvoaoughdUOIDOwg71Q=
X-Google-Smtp-Source: AMsMyM7mtvGzeJGvFc/LlsYuZ38YYkGPpeb2EP7dJoxa51Wm848cYTSCAQcJ+BsuVUZojhzc9k+g3g==
X-Received: by 2002:a05:6a00:1582:b0:56d:4bc6:68c7 with SMTP id u2-20020a056a00158200b0056d4bc668c7mr1629218pfk.31.1667113393458;
        Sun, 30 Oct 2022 00:03:13 -0700 (PDT)
Received: from localhost.localdomain ([106.201.172.104])
        by smtp.googlemail.com with ESMTPSA id p1-20020a170902e74100b0017a032d7ae4sm2234195plf.104.2022.10.30.00.03.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Oct 2022 00:03:13 -0700 (PDT)
From:   Abdun Nihaal <abdun.nihaal@gmail.com>
To:     almaz.alexandrovich@paragon-software.com
Cc:     ntfs3@lists.linux.dev, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Abdun Nihaal <abdun.nihaal@gmail.com>,
        syzbot+f45957555ed4a808cc7a@syzkaller.appspotmail.com
Subject: [PATCH] fs/ntfs3: Fix NULL dereference in ni_write_inode
Date:   Sun, 30 Oct 2022 12:32:51 +0530
Message-Id: <20221030070251.614970-1-abdun.nihaal@gmail.com>
X-Mailer: git-send-email 2.37.3
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

Syzbot reports a NULL dereference in ni_write_inode.
When creating a new inode, if allocation fails in mi_init function
(called in mi_format_new function), mi->mrec is set to NULL.
In the error path of this inode creation, mi->mrec is later
dereferenced in ni_write_inode.

Add a NULL check to prevent NULL dereference.

Link: https://syzkaller.appspot.com/bug?extid=f45957555ed4a808cc7a
Reported-and-tested-by: syzbot+f45957555ed4a808cc7a@syzkaller.appspotmail.com
Signed-off-by: Abdun Nihaal <abdun.nihaal@gmail.com>
---
 fs/ntfs3/frecord.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/ntfs3/frecord.c b/fs/ntfs3/frecord.c
index 70a80f9412f7..e55bbd209ef8 100644
--- a/fs/ntfs3/frecord.c
+++ b/fs/ntfs3/frecord.c
@@ -3243,6 +3243,9 @@ int ni_write_inode(struct inode *inode, int sync, const char *hint)
 		return 0;
 	}
 
+	if (!ni->mi.mrec)
+		goto out;
+
 	if (is_rec_inuse(ni->mi.mrec) &&
 	    !(sbi->flags & NTFS_FLAGS_LOG_REPLAYING) && inode->i_nlink) {
 		bool modified = false;
-- 
2.37.3

