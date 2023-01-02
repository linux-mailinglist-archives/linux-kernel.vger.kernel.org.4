Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7688B65B3A9
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 16:00:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235955AbjABO7r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 09:59:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233295AbjABO7p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 09:59:45 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAD0A641E
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 06:58:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1672671538;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=FH/Lp9MlKLCKaZbT73kzq05x4X87GgNm5ap75FWZ5H4=;
        b=FVpgLhlSJkKdJ1Gvo4o2uj33PiBkFDYYxJx1F4xXM7IRAoQACJbkwDhNft7OI/4HBlZLH0
        9mqw0GxhHeqqSKvMMVnPdbJFfJUmV249DADFI29Uf1rfEW21La6n177E5IyFVIRZIwRWNG
        w0+UCB6ZLXHtvOHTaCPqTTyyCNNb5o4=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-611-xjxFSBZ3N7inYxqTvNjKHQ-1; Mon, 02 Jan 2023 09:58:57 -0500
X-MC-Unique: xjxFSBZ3N7inYxqTvNjKHQ-1
Received: by mail-pf1-f197.google.com with SMTP id a1-20020a056a001d0100b0057a6f74d7bcso12978531pfx.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jan 2023 06:58:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FH/Lp9MlKLCKaZbT73kzq05x4X87GgNm5ap75FWZ5H4=;
        b=Z5DxEQJvjiAA6b+EFgYSeFxbfgGZ4itPKLjxbXeWLKu2HX5d/2/Fnk53WfaS9EytJc
         B0Mb2A2ZDHwNm90nR+e1UB4CViqYnQY0enDU9MgHuLnbqAjV0WDzBzNdFPyk3YITBRFD
         0S8V/hs+ur/vXaNK/WF51VlYfc3+nNQOa/oPxL7TzvG+biKfahKVqv2jZRlS+h+qKqUv
         bQXbdxoqwmOLW3SiEijoNMSEEPY6tgpnUN7nguXZVlf+0dhCuCHALbpt0nI9GnE0M52/
         IVR4GCi1NnsliyI5jyX8ysIwsCQzBEPzX5uG15bV2LmbK81/+JR7bjj5daN9tCcSSYli
         5M/g==
X-Gm-Message-State: AFqh2kqlgeYSCiTk8YpyMoz/nL1Fr9Vj/hBQE8viuGW9Xf6JybEQC8jQ
        EHcrRZTodSJLiZJOp5ZNQrSmPk2KJdN7HQml4zgGgjIQK41sn1G5sFPz9FYglLd31j2J0QOtR6F
        ovyNuOEJoRJRCm2ZIDvGcApFZ
X-Received: by 2002:aa7:90d9:0:b0:580:df2d:47c4 with SMTP id k25-20020aa790d9000000b00580df2d47c4mr32414670pfk.19.1672671536545;
        Mon, 02 Jan 2023 06:58:56 -0800 (PST)
X-Google-Smtp-Source: AMrXdXu/jU0eyfX/7zCrMxSUEB4WmKwgUUKrVBc8mnkQozOF8ZixobVxmpjajys62AXlefjhUtgIVA==
X-Received: by 2002:aa7:90d9:0:b0:580:df2d:47c4 with SMTP id k25-20020aa790d9000000b00580df2d47c4mr32414652pfk.19.1672671536244;
        Mon, 02 Jan 2023 06:58:56 -0800 (PST)
Received: from localhost.localdomain ([240d:1a:c0d:9f00:ca6:1aff:fead:cef4])
        by smtp.gmail.com with ESMTPSA id w18-20020aa79a12000000b00581816425f3sm10503683pfj.112.2023.01.02.06.58.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Jan 2023 06:58:55 -0800 (PST)
From:   Shigeru Yoshida <syoshida@redhat.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shigeru Yoshida <syoshida@redhat.com>,
        syzbot+bf4bb7731ef73b83a3b4@syzkaller.appspotmail.com
Subject: [PATCH] ext4: Verify extent header in ext4_find_extent()
Date:   Mon,  2 Jan 2023 14:58:33 +0000
Message-Id: <20230102145833.2758-1-syoshida@redhat.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot reported use-after-free in ext4_find_extent() [1].  If there is
a corrupted file system, this can cause invalid memory access.

This patch fixes the issue by verifying extent header.

Reported-by: syzbot+bf4bb7731ef73b83a3b4@syzkaller.appspotmail.com
Link: https://syzkaller.appspot.com/bug?id=cd95cb722bfa1234ac4c78345c8953ee2e7170d0 [1]
Signed-off-by: Shigeru Yoshida <syoshida@redhat.com>
---
 fs/ext4/extents.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 9de1c9d1a13d..79bfa583ab1d 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -901,6 +901,9 @@ ext4_find_extent(struct inode *inode, ext4_lblk_t block,
 		ret = -EFSCORRUPTED;
 		goto err;
 	}
+	ret = ext4_ext_check(inode, eh, depth, 0);
+	if (ret)
+		goto err;
 
 	if (path) {
 		ext4_ext_drop_refs(path);
-- 
2.38.1

