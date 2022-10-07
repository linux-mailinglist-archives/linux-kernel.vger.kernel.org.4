Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDED05F758A
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 10:52:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbiJGIwr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 04:52:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbiJGIwf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 04:52:35 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE866CAE57;
        Fri,  7 Oct 2022 01:52:31 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id q10-20020a17090a304a00b0020b1d5f6975so3085389pjl.0;
        Fri, 07 Oct 2022 01:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TB46KdvMZJgbp7dR23YxTpKAGexyJNaQ7bch9IZKt5g=;
        b=LBVqR/yPOZwnyKzExIyyeK2UXrPOk/YcWE0CJHj+Y71HAu4SeFTCiLYC2TTConOuKa
         iCqBXE+VJSoEDuDJJaG167OwcsEKmPNvHSxOzxmRz3rNt88cW4v2rD/mf3uzK0vdzbyy
         ESS1NLv4eJgRvbehfiTj80l+kBB4KIit9CSiyAu7LZaqkqoBb/rClNbnkCAg+W7sfvYL
         rlqwJYepj2zpik//780faN81CpKDaKlT+UigHfVwGQtV0QryXdSjlIrD6ZhZQiIlN+Zf
         pNgzOd0C6q29AXAUQxDpSo6+xz4xIB6Qv+MyQAKFY+1zK3vFqAqenEd8yTFjqS9NDORq
         ot2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TB46KdvMZJgbp7dR23YxTpKAGexyJNaQ7bch9IZKt5g=;
        b=ItO5hOBKti+5eYdecEHyZGzA9/RMuAreSKXjd7dJTGZ5PEihR9UJaWEKQmjFcnhl54
         5JpBeeN1I7teWltxuQRVSRKeOpgbvvov6ll1xo6Gpmfgpg6xkY+B5u5VeF94BnwDIunp
         aoeEFe0cvBC/GL39iC9k6RZ2E1YI+sX3peHXc8nv1hCHlwC3yHF9vYeC6wfw8yOh61r8
         0yUXOe6s7Tl3elP1+iCh43XA/EcBVtuH6h+dJAf1LpY3WgoV7zpHJQujkl0M/lWtREph
         0hd8vY7LjhvahNnCWiN4PLZY2+Pfh8jpZkMbd4MHJSByETM8wrnFlqQhlNhmGXPJ+dnq
         pI4w==
X-Gm-Message-State: ACrzQf3Q41+H1sYnUFqJTPORDuw7C/0AlTdSiEmMQOuZN/xB70hCYYxo
        sUz/ufUo9r8xCcr1x9XVVDFUfRnxXQk=
X-Google-Smtp-Source: AMsMyM4gkNpnh1O7voFAVF9dYkmGJM6lYlbeaDWjeJk6W/pyhR6leZnn7elmN8ywM8HFHG08KGPGIg==
X-Received: by 2002:a17:902:ea09:b0:179:c4bc:20e2 with SMTP id s9-20020a170902ea0900b00179c4bc20e2mr3801539plg.132.1665132750900;
        Fri, 07 Oct 2022 01:52:30 -0700 (PDT)
Received: from carrot.. (i220-109-170-101.s42.a014.ap.plala.or.jp. [220.109.170.101])
        by smtp.gmail.com with ESMTPSA id x188-20020a6263c5000000b0056268979639sm1026918pfb.123.2022.10.07.01.52.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Oct 2022 01:52:29 -0700 (PDT)
From:   Ryusuke Konishi <konishi.ryusuke@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-nilfs <linux-nilfs@vger.kernel.org>,
        syzbot <syzbot+7381dc4ad60658ca4c05@syzkaller.appspotmail.com>,
        syzkaller-bugs@googlegroups.com,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] nilfs2: fix leak of nilfs_root in case of writer thread creation failure
Date:   Fri,  7 Oct 2022 17:52:26 +0900
Message-Id: <20221007085226.57667-1-konishi.ryusuke@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <00000000000098972c05e2117b39@google.com>
References: <00000000000098972c05e2117b39@google.com>
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

If nilfs_attach_log_writer() failed to create a log writer thread, it
frees a data structure of the log writer without any cleanup.  After
commit e912a5b66837 ("nilfs2: use root object to get ifile"), this
causes a leak of struct nilfs_root, which started to leak an ifile
metadata inode and a kobject on that struct.

In addition, if the kernel is booted with panic_on_warn, the above
ifile metadata inode leak will cause the following panic when the
nilfs2 kernel module is removed:

  kmem_cache_destroy nilfs2_inode_cache: Slab cache still has objects when
  called from nilfs_destroy_cachep+0x16/0x3a [nilfs2]
  WARNING: CPU: 8 PID: 1464 at mm/slab_common.c:494 kmem_cache_destroy+0x138/0x140
  ...
  RIP: 0010:kmem_cache_destroy+0x138/0x140
  Code: 00 20 00 00 e8 a9 55 d8 ff e9 76 ff ff ff 48 8b 53 60 48 c7 c6 20 70 65 86 48 c7 c7 d8 69 9c 86 48 8b 4c 24 28 e8 ef 71 c7 00 <0f> 0b e9 53 ff ff ff c3 48 81 ff ff 0f 00 00 77 03 31 c0 c3 53 48
  ...
  Call Trace:
   <TASK>
   ? nilfs_palloc_freev.cold.24+0x58/0x58 [nilfs2]
   nilfs_destroy_cachep+0x16/0x3a [nilfs2]
   exit_nilfs_fs+0xa/0x1b [nilfs2]
    __x64_sys_delete_module+0x1d9/0x3a0
   ? __sanitizer_cov_trace_pc+0x1a/0x50
   ? syscall_trace_enter.isra.19+0x119/0x190
   do_syscall_64+0x34/0x80
   entry_SYSCALL_64_after_hwframe+0x63/0xcd
   ...
   </TASK>
  Kernel panic - not syncing: panic_on_warn set ...

This patch fixes these issues by calling nilfs_detach_log_writer()
cleanup function if spawning the log writer thread fails.

Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Fixes: e912a5b66837 ("nilfs2: use root object to get ifile")
Reported-by: syzbot+7381dc4ad60658ca4c05@syzkaller.appspotmail.com
Tested-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Cc: stable@vger.kernel.org
---
 fs/nilfs2/segment.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/fs/nilfs2/segment.c b/fs/nilfs2/segment.c
index 0afe0832c754..5276ab525f01 100644
--- a/fs/nilfs2/segment.c
+++ b/fs/nilfs2/segment.c
@@ -2786,10 +2786,9 @@ int nilfs_attach_log_writer(struct super_block *sb, struct nilfs_root *root)
 	inode_attach_wb(nilfs->ns_bdev->bd_inode, NULL);
 
 	err = nilfs_segctor_start_thread(nilfs->ns_writer);
-	if (err) {
-		kfree(nilfs->ns_writer);
-		nilfs->ns_writer = NULL;
-	}
+	if (unlikely(err))
+		nilfs_detach_log_writer(sb);
+
 	return err;
 }
 
-- 
2.34.1

