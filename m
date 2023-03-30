Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21CAE6D1052
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 22:55:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbjC3Uy6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 16:54:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbjC3Uy5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 16:54:57 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 588959029;
        Thu, 30 Mar 2023 13:54:56 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id c4so2444304pjs.4;
        Thu, 30 Mar 2023 13:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680209696;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j6pHbeR0wmAFy8/xE4TOwKpB2kz5BJs5rtUuvDEQ2QY=;
        b=otCwGAcVYuthJgfTF3yDfWnr+qefvRNAq8+ay2a+tYpiWRZfs3iatctJe5I4fVDJmw
         /XmckYjZdn0t4UHHV72ZmGmEs/LbTUkD8xF3sQ3nTJtUFAtbuGcecB+8Vo20wzomlTdq
         egzIzlCoLdaBpjgnuYfnRzI1tr5lAQLBQy57ApSS7tCgy91sQ7cP6AuugCS5xh9qiV++
         G4QfzUHylhKDexYLM64Boq4PShUqadG0xV/H+hAVqMMlBFMSqtzdL+xZdNOlR8tpwW4q
         gUP5ZsVoOGmx1nId+Z7pMFrL5QYNnrfm606OUadyVm8xCjkW7mvtgbvccADIuxWXG2fs
         X7Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680209696;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j6pHbeR0wmAFy8/xE4TOwKpB2kz5BJs5rtUuvDEQ2QY=;
        b=K2yCsejCBou5+nP4K7xd5tjvbo6mpfxQ4En3kuM8mHerou403PvJdq/fBpzgd4b85P
         PDGAktNdi+ckNOx7ij5mSuGEoRQ7RLAT+GlaKdCc8UBPkTRprivtNiPX6D8epxJe3bwr
         9kYFlyPJsHppi+z9UAQyVh8XR6iTnC0fXeRyrSG/Qv3BUA8murjirftitlIwQOqyEp8m
         mt/8fKXiaZ3yCC5ZX7qVffMyxTUvwC/5nA89zJlGygktktovEOpFDFTww+R0bHjEbcL5
         E97DR4ipfsvHsGGsjhPH6AovKTaWRsqIuBxcv8KT2g3L1YaEP39sYgnnjhctxCU71qsX
         36Ww==
X-Gm-Message-State: AAQBX9f5qI8SQM/99MO/yUQmmfCu8RnS8nzIAAfQcYXU26ZJNbq0AOIJ
        pGjA9Y9cu4kDoTsaFdjTxmtuxnqXXCI=
X-Google-Smtp-Source: AKy350ZrMw8cmuzkInC9rMkHgVk+gCQLR1FUJjrtRh43O8j+o7JNZx9TGgtlKyPDcRupoqKy5EEXQQ==
X-Received: by 2002:a17:902:e843:b0:1a1:953b:9559 with SMTP id t3-20020a170902e84300b001a1953b9559mr28902178plg.3.1680209695506;
        Thu, 30 Mar 2023 13:54:55 -0700 (PDT)
Received: from carrot.. (i223-217-34-84.s42.a014.ap.plala.or.jp. [223.217.34.84])
        by smtp.gmail.com with ESMTPSA id r24-20020a170902be1800b001992e74d055sm180641pls.12.2023.03.30.13.54.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 13:54:54 -0700 (PDT)
From:   Ryusuke Konishi <konishi.ryusuke@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-nilfs@vger.kernel.org,
        syzbot <syzbot+979fa7f9c0d086fdc282@syzkaller.appspotmail.com>,
        syzbot <syzbot+5b7d542076d9bddc3c6a@syzkaller.appspotmail.com>,
        syzkaller-bugs@googlegroups.com, linux-kernel@vger.kernel.org,
        Viacheslav Dubeyko <slava@dubeyko.com>
Subject: [PATCH] nilfs2: fix sysfs interface lifetime
Date:   Fri, 31 Mar 2023 05:55:15 +0900
Message-Id: <20230330205515.6167-1-konishi.ryusuke@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <0000000000003414b505f7885f7e@google.com>
References: <0000000000003414b505f7885f7e@google.com>
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

The current nilfs2 sysfs support has issues with the timing of creation
and deletion of sysfs entries, potentially leading to null pointer
dereferences, use-after-free, and lockdep warnings.

Some of the sysfs attributes for nilfs2 per-filesystem instance refer
to metadata file "cpfile", "sufile", or "dat", but
nilfs_sysfs_create_device_group that creates those attributes is
executed before the inodes for these metadata files are loaded, and
nilfs_sysfs_delete_device_group which deletes these sysfs entries is
called after releasing their metadata file inodes.

Therefore, access to some of these sysfs attributes may occur outside
of the lifetime of these metadata files, resulting in inode NULL pointer
dereferences or use-after-free.

In addition, the call to nilfs_sysfs_create_device_group() is made
during the locking period of the semaphore "ns_sem" of nilfs object,
so the shrinker call caused by the memory allocation for the sysfs
entries, may derive lock dependencies "ns_sem" -> (shrinker) ->
"locks acquired in nilfs_evict_inode()".

Since nilfs2 may acquire "ns_sem" deep in the call stack holding other
locks via its error handler __nilfs_error(), this causes lockdep to
report circular locking.  This is a false positive and no circular
locking actually occurs as no inodes exist yet when
nilfs_sysfs_create_device_group() is called.  Fortunately, the lockdep
warnings can be resolved by simply moving the call to
nilfs_sysfs_create_device_group() out of "ns_sem".

This fixes these sysfs issues by revising where the device's sysfs
interface is created/deleted and keeping its lifetime within the
lifetime of the metadata files above.

Reported-by: syzbot+979fa7f9c0d086fdc282@syzkaller.appspotmail.com
Link: https://lkml.kernel.org/r/0000000000003414b505f7885f7e@google.com
Reported-by: syzbot+5b7d542076d9bddc3c6a@syzkaller.appspotmail.com
Link: https://lkml.kernel.org/r/0000000000006ac86605f5f44eb9@google.com
Fixes: dd70edbde262 ("nilfs2: integrate sysfs support into driver")
Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Cc: Viacheslav Dubeyko <slava@dubeyko.com>
---
 fs/nilfs2/super.c     |  2 ++
 fs/nilfs2/the_nilfs.c | 12 +++++++-----
 2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/fs/nilfs2/super.c b/fs/nilfs2/super.c
index 1422b8ba24ed..77f1e5778d1c 100644
--- a/fs/nilfs2/super.c
+++ b/fs/nilfs2/super.c
@@ -482,6 +482,7 @@ static void nilfs_put_super(struct super_block *sb)
 		up_write(&nilfs->ns_sem);
 	}
 
+	nilfs_sysfs_delete_device_group(nilfs);
 	iput(nilfs->ns_sufile);
 	iput(nilfs->ns_cpfile);
 	iput(nilfs->ns_dat);
@@ -1105,6 +1106,7 @@ nilfs_fill_super(struct super_block *sb, void *data, int silent)
 	nilfs_put_root(fsroot);
 
  failed_unload:
+	nilfs_sysfs_delete_device_group(nilfs);
 	iput(nilfs->ns_sufile);
 	iput(nilfs->ns_cpfile);
 	iput(nilfs->ns_dat);
diff --git a/fs/nilfs2/the_nilfs.c b/fs/nilfs2/the_nilfs.c
index 3a4c9c150cbf..2894152a6b25 100644
--- a/fs/nilfs2/the_nilfs.c
+++ b/fs/nilfs2/the_nilfs.c
@@ -87,7 +87,6 @@ void destroy_nilfs(struct the_nilfs *nilfs)
 {
 	might_sleep();
 	if (nilfs_init(nilfs)) {
-		nilfs_sysfs_delete_device_group(nilfs);
 		brelse(nilfs->ns_sbh[0]);
 		brelse(nilfs->ns_sbh[1]);
 	}
@@ -305,6 +304,10 @@ int load_nilfs(struct the_nilfs *nilfs, struct super_block *sb)
 		goto failed;
 	}
 
+	err = nilfs_sysfs_create_device_group(sb);
+	if (unlikely(err))
+		goto sysfs_error;
+
 	if (valid_fs)
 		goto skip_recovery;
 
@@ -366,6 +369,9 @@ int load_nilfs(struct the_nilfs *nilfs, struct super_block *sb)
 	goto failed;
 
  failed_unload:
+	nilfs_sysfs_delete_device_group(nilfs);
+
+ sysfs_error:
 	iput(nilfs->ns_cpfile);
 	iput(nilfs->ns_sufile);
 	iput(nilfs->ns_dat);
@@ -697,10 +703,6 @@ int init_nilfs(struct the_nilfs *nilfs, struct super_block *sb, char *data)
 	if (err)
 		goto failed_sbh;
 
-	err = nilfs_sysfs_create_device_group(sb);
-	if (err)
-		goto failed_sbh;
-
 	set_nilfs_init(nilfs);
 	err = 0;
  out:
-- 
2.34.1

