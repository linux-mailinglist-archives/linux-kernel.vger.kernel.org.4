Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71EE270F343
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 11:44:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbjEXJoR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 05:44:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbjEXJoL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 05:44:11 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A26FA1;
        Wed, 24 May 2023 02:44:10 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id 98e67ed59e1d1-2536e522e47so31006a91.1;
        Wed, 24 May 2023 02:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684921450; x=1687513450;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CwdYQx8FcXFV0J8oDNY/gZUVBoAXgW87pt+1+NvkXAw=;
        b=b1/obuKfWcYZskj6Rc4AdZaTyvTCf9MxLyeApNb1hkqVz1FePSBrjH7ZWnp+6ETncM
         gWthai388O2oeNLLGPc2kK/XDvK078yjSnjFOuS+A8sVsa5doAIWhdJrZoOAW0KfrAo9
         bD4GxQSWNVUBZRTdoUJgmkkY/pNh2tRWyEJfmK9f4DzkUtf0ZjRJDqqPzAy/xvvCyed7
         rmRPS9bNZQQZUVrZiz8N2KoxHQAhYXySH4hykWsaNdgFHKnC0TL9sm2wg+d6WCMpMEzE
         QWTDr7Udwh+QaNMkXeGh9QTo7E5IYh23CMf10Y8fm0ofyf5qWXOeIxI7o6vlMXUpl8cv
         q+pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684921450; x=1687513450;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CwdYQx8FcXFV0J8oDNY/gZUVBoAXgW87pt+1+NvkXAw=;
        b=CnKEJ9ibfMV5xvzGuc4XiGNCFnXDdU1Eg77V8KIcqrtJy+uGxUOWa8ctdncbz1MkJX
         r0Z1h8MfcyufIrgCFGKNfvldq56GzKxAXM1PFZmjAXv7xBAuDeySCflSpEF6OgiRkyED
         BnrSf2wkpzXVq9TeSqmqtKvOH6gZFf3YjukLFj32aILxqB3G1luC11D0GybtJdY+bQpF
         HdXwmkA6/JCmmFBBjWpUbq2S4dG27lh2JIGe0uHsMoo3FjLzVqMKHwqzTd9g8HJHiO0N
         ym+FSW3pymfOYgzV6ttsqh7GvZ6y42XGbbEnjd/nzwwSjijab2UIC0xJiRZmTHteOLzL
         MACg==
X-Gm-Message-State: AC+VfDyIBn9v6TK/RhfoARjBwfI7bRbKTYQG2VKAsDwwtRRe0BaSjtkY
        KH0xxQkZVPV/QInFs2C15Vo=
X-Google-Smtp-Source: ACHHUZ7KNQCu2AQqm8Xww/7w33hsJlA82n6crTdvm4G3aWoOMjWMdJ5xMADYe7wgXWqZto7PgrfW2g==
X-Received: by 2002:a17:90a:fa01:b0:255:63ae:f943 with SMTP id cm1-20020a17090afa0100b0025563aef943mr7632498pjb.35.1684921449506;
        Wed, 24 May 2023 02:44:09 -0700 (PDT)
Received: from carrot.. (i220-108-176-104.s42.a014.ap.plala.or.jp. [220.108.176.104])
        by smtp.gmail.com with ESMTPSA id 17-20020a17090a19d100b0024bcad691d4sm1031326pjj.14.2023.05.24.02.44.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 May 2023 02:44:08 -0700 (PDT)
From:   Ryusuke Konishi <konishi.ryusuke@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-nilfs@vger.kernel.org,
        syzbot <syzbot+33494cd0df2ec2931851@syzkaller.appspotmail.com>,
        syzkaller-bugs@googlegroups.com, linux-kernel@vger.kernel.org
Subject: [PATCH] nilfs2: fix possible out-of-bounds segment allocation in resize ioctl
Date:   Wed, 24 May 2023 18:43:48 +0900
Message-Id: <20230524094348.3784-1-konishi.ryusuke@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <0000000000005434c405fbbafdc5@google.com>
References: <0000000000005434c405fbbafdc5@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Syzbot reports that in its stress test for resize ioctl, the log writing
function nilfs_segctor_do_construct hits a WARN_ON in
nilfs_segctor_truncate_segments().

It turned out that there is a problem with the current implementation of
the resize ioctl, which changes the writable range on the device
(the range of allocatable segments) at the end of the resize process.

This order is necessary for file system expansion to avoid corrupting
the superblock at trailing edge.  However, in the case of a file system
shrink, if log writes occur after truncating out-of-bounds trailing
segments and before the resize is complete, segments may be allocated
from the truncated space.

The userspace resize tool was fine as it limits the range of allocatable
segments before performing the resize, but it can run into this issue if
the resize ioctl is called alone.

Fix this issue by changing nilfs_sufile_resize() to update the range of
allocatable segments immediately after successful truncation of segment
space in case of file system shrink.

Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Reported-by: syzbot+33494cd0df2ec2931851@syzkaller.appspotmail.com
Closes: https://lkml.kernel.org/r/0000000000005434c405fbbafdc5@google.com
Fixes: 4e33f9eab07e ("nilfs2: implement resize ioctl")
Tested-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Cc: stable@vger.kernel.org
---
 fs/nilfs2/sufile.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/fs/nilfs2/sufile.c b/fs/nilfs2/sufile.c
index dc359b56fdfa..2c6078a6b8ec 100644
--- a/fs/nilfs2/sufile.c
+++ b/fs/nilfs2/sufile.c
@@ -779,6 +779,15 @@ int nilfs_sufile_resize(struct inode *sufile, __u64 newnsegs)
 			goto out_header;
 
 		sui->ncleansegs -= nsegs - newnsegs;
+
+		/*
+		 * If the sufile is successfully truncated, immediately adjust
+		 * the segment allocation space while locking the semaphore
+		 * "mi_sem" so that nilfs_sufile_alloc() never allocates
+		 * segments in the truncated space.
+		 */
+		sui->allocmax = newnsegs - 1;
+		sui->allocmin = 0;
 	}
 
 	kaddr = kmap_atomic(header_bh->b_page);
-- 
2.34.1

