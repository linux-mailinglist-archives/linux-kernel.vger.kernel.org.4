Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D322609239
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Oct 2022 11:58:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230272AbiJWJ6R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 05:58:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230283AbiJWJ6K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 05:58:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42B0553A56
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 02:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666519086;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Ky31uYoPpYXLv9EkeY7euMSIkvPC1CoReepeci/ICSE=;
        b=MJKqRV85KzGjlX3sI58P4k3GP5g344L6o46Cgkl7RNpxlNad7jVaQd3dTdWnqrTEr5Swsd
        75mqRUugxl4tZuM8WI9uZ8RWZzs95ndEfcKBQR190wKlGFIQ1MyHYEk2bt0KCXwK6B2ULf
        2gpaVBT+jmH+sLuE5Bug+33uig+eS24=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-52-hpiq6nCMN_Snt4RhYWhJQA-1; Sun, 23 Oct 2022 05:58:04 -0400
X-MC-Unique: hpiq6nCMN_Snt4RhYWhJQA-1
Received: by mail-qt1-f197.google.com with SMTP id f19-20020ac84713000000b00397692bdaecso5431452qtp.22
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 02:58:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ky31uYoPpYXLv9EkeY7euMSIkvPC1CoReepeci/ICSE=;
        b=P5NtoGDDPdAWP7prT8v67H7DpXPj2k8iuKzuOch8pT+yj6cbdLxfhRCpMIqGfZ1mkI
         DA3cdBOVmoUo/BIdUw8+VMPDGjvW6PrD0P3ZnbNBEt7kktiIzCtxfv8An2eb8MKs90NB
         qE1tqsAwQ+6ffJ9Z/dZCZw8q8IncvUg2rtx82U9MPZCfgg2dvKwnZ/vU2As/8VL0ICX4
         mE/RprMMP7zv1wecLy+/dtUlKwtYhwI/T8EFP6hGOuXZsdRWwxhN5+ylJOAtROT4TOxM
         tvlVlg7Z0FmaPSEW0zD/zT3dryXJ+nbxwmjHxZVQyosremvZ0Pc/mSHMnDLs5AUXAlv7
         /LNw==
X-Gm-Message-State: ACrzQf1dbj29I1hSIVQUksfHiRT6FXBwQr2AxXKRSRGrXU+78XMTWrW9
        /B8kXRAYLS1dloVhJMap3Vx2dmLtBQ3aqOAfbbJG6fSVMj2jARMLXdUAQMmysH++237rDY4dZyr
        0+wl1XwKvToikeRCVM6suHOw8
X-Received: by 2002:ad4:5f0e:0:b0:4b1:cfa1:3c59 with SMTP id fo14-20020ad45f0e000000b004b1cfa13c59mr23336861qvb.130.1666519083755;
        Sun, 23 Oct 2022 02:58:03 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM44s3VHxd7h3nNNgMrpyn20I4ShmsUR/iRSxkRvF6mQaYPcTP/ebbusdqQF9kJhLRGUnADuKw==
X-Received: by 2002:a05:6a00:a22:b0:54e:6a90:fbef with SMTP id p34-20020a056a000a2200b0054e6a90fbefmr28032580pfh.53.1666519073014;
        Sun, 23 Oct 2022 02:57:53 -0700 (PDT)
Received: from ryzen.. ([240d:1a:c0d:9f00:fc9c:8ee9:e32c:2d9])
        by smtp.gmail.com with ESMTPSA id t10-20020a63444a000000b0041c0c9c0072sm15523583pgk.64.2022.10.23.02.57.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Oct 2022 02:57:52 -0700 (PDT)
From:   Shigeru Yoshida <syoshida@redhat.com>
To:     jack@suse.com
Cc:     linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        Shigeru Yoshida <syoshida@redhat.com>,
        syzbot+7902cd7684bc35306224@syzkaller.appspotmail.com
Subject: [PATCH] udf: Avoid double brelse() in udf_rename()
Date:   Sun, 23 Oct 2022 18:57:41 +0900
Message-Id: <20221023095741.271430-1-syoshida@redhat.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot reported a warning like below [1]:

VFS: brelse: Trying to free free buffer
WARNING: CPU: 2 PID: 7301 at fs/buffer.c:1145 __brelse+0x67/0xa0
...
Call Trace:
 <TASK>
 invalidate_bh_lru+0x99/0x150
 smp_call_function_many_cond+0xe2a/0x10c0
 ? generic_remap_file_range_prep+0x50/0x50
 ? __brelse+0xa0/0xa0
 ? __mutex_lock+0x21c/0x12d0
 ? smp_call_on_cpu+0x250/0x250
 ? rcu_read_lock_sched_held+0xb/0x60
 ? lock_release+0x587/0x810
 ? __brelse+0xa0/0xa0
 ? generic_remap_file_range_prep+0x50/0x50
 on_each_cpu_cond_mask+0x3c/0x80
 blkdev_flush_mapping+0x13a/0x2f0
 blkdev_put_whole+0xd3/0xf0
 blkdev_put+0x222/0x760
 deactivate_locked_super+0x96/0x160
 deactivate_super+0xda/0x100
 cleanup_mnt+0x222/0x3d0
 task_work_run+0x149/0x240
 ? task_work_cancel+0x30/0x30
 do_exit+0xb29/0x2a40
 ? reacquire_held_locks+0x4a0/0x4a0
 ? do_raw_spin_lock+0x12a/0x2b0
 ? mm_update_next_owner+0x7c0/0x7c0
 ? rwlock_bug.part.0+0x90/0x90
 ? zap_other_threads+0x234/0x2d0
 do_group_exit+0xd0/0x2a0
 __x64_sys_exit_group+0x3a/0x50
 do_syscall_64+0x34/0xb0
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

The cause of the issue is that brelse() is called on both ofibh.sbh
and ofibh.ebh by udf_find_entry() when it returns NULL.  However,
brelse() is called by udf_rename(), too.  So, b_count on buffer_head
becomes unbalanced.

This patch fixes the issue by not calling brelse() by udf_rename()
when udf_find_entry() returns NULL.

Link: https://syzkaller.appspot.com/bug?id=8297f45698159c6bca8a1f87dc983667c1a1c851 [1]
Reported-by: syzbot+7902cd7684bc35306224@syzkaller.appspotmail.com
Signed-off-by: Shigeru Yoshida <syoshida@redhat.com>
---
 fs/udf/namei.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/udf/namei.c b/fs/udf/namei.c
index fb4c30e05245..d6081538bfc0 100644
--- a/fs/udf/namei.c
+++ b/fs/udf/namei.c
@@ -1091,8 +1091,9 @@ static int udf_rename(struct user_namespace *mnt_userns, struct inode *old_dir,
 		return -EINVAL;
 
 	ofi = udf_find_entry(old_dir, &old_dentry->d_name, &ofibh, &ocfi);
-	if (IS_ERR(ofi)) {
-		retval = PTR_ERR(ofi);
+	if (!ofi || IS_ERR(ofi)) {
+		if (IS_ERR(ofi))
+			retval = PTR_ERR(ofi);
 		goto end_rename;
 	}
 
@@ -1101,8 +1102,7 @@ static int udf_rename(struct user_namespace *mnt_userns, struct inode *old_dir,
 
 	brelse(ofibh.sbh);
 	tloc = lelb_to_cpu(ocfi.icb.extLocation);
-	if (!ofi || udf_get_lb_pblock(old_dir->i_sb, &tloc, 0)
-	    != old_inode->i_ino)
+	if (udf_get_lb_pblock(old_dir->i_sb, &tloc, 0) != old_inode->i_ino)
 		goto end_rename;
 
 	nfi = udf_find_entry(new_dir, &new_dentry->d_name, &nfibh, &ncfi);
-- 
2.37.3

