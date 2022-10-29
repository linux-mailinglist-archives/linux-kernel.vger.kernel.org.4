Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F24B61203C
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 06:49:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbiJ2EtU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Oct 2022 00:49:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiJ2EtS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Oct 2022 00:49:18 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5F2D1AFA84;
        Fri, 28 Oct 2022 21:49:17 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id 17so2159735pfv.4;
        Fri, 28 Oct 2022 21:49:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=euh2my+Sy+qXwfAid3AtEb0nPeWmqr+fHHInSeKPPc0=;
        b=EUB36euj9XgdqD9PfFhr6RPcN0XLaM9nL58cjW4OidgmsavA6U7bO4E3/PbC7zIXpY
         b1XYr0B2wA7Qjh9wBE0w3xb5+/STwpPfWoxDXM/Vmak3RC31Un265kFVreu2+qUWPyd4
         GCRBgPjqT12EzMLX1DRZzY5Munjeg7hJCseU7/S2QDgvxQ/RZ5iHGnf+B+y9ZBv1RKa7
         +p/gNUWmM3wlS7hcO6LRVybjqmVq1gFt9P7RbKEIkkvcj95RGdFQoB8ey+wTpFGjuEtO
         81O5QknK0M34Mr3Z2eSWThmDTSK0CSL0AgknRtmMGkQ/ucTHtluPySLXjnhgRZHb4MBr
         ucxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=euh2my+Sy+qXwfAid3AtEb0nPeWmqr+fHHInSeKPPc0=;
        b=WL/aaIXxd42wxTGA2MegfhD3i9xx1rZAqgbTrqvhbbr9cSvAoMbsprWNzDhwEkXMHi
         wzW4sDN6S/S4eUvhhTIFILDlGCG1671we4icdnnDWY4KVAKpnA/QOG9TP+vYJ9LJstCv
         b+kfTxAjtyn+jMyaOWNz0PL56v1YKAXn6uM+ycXk3cSPPCZ8NNOf5UZMHhrUpTxCmO+M
         FdE4nl6piItZF/IMDkYUwGkmhM7hXypAciPwl4dHGBc4LS0BOOVkdSxgs04RQ4owLlFa
         L2NFhqJFaBSuK3YTQ2sUCUNWXD08wvWfSbyOwUHLT/iqNxz1+GN3197ZvHGJTu9v+hyw
         xYoQ==
X-Gm-Message-State: ACrzQf3qaNFfa16MsAcItBeGLqaEmIQKAY0+R+0y+CwUk/ssgUxvhDxY
        VCaU54r0GCKaWmErdHK7M0S0LakL9p4BKQ==
X-Google-Smtp-Source: AMsMyM5a+c4lGXLfvT7zalR6LAsK+xkQ4h+V3YtI7eM4s5t1Ozvyu4i34Fn3+0nVpokheo6eurmfJQ==
X-Received: by 2002:a63:f214:0:b0:461:8862:331e with SMTP id v20-20020a63f214000000b004618862331emr2600393pgh.386.1667018956989;
        Fri, 28 Oct 2022 21:49:16 -0700 (PDT)
Received: from carrot.. (i220-108-44-211.s42.a014.ap.plala.or.jp. [220.108.44.211])
        by smtp.gmail.com with ESMTPSA id f1-20020a170902f38100b00176ab6a0d5fsm324652ple.54.2022.10.28.21.49.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 21:49:16 -0700 (PDT)
From:   Ryusuke Konishi <konishi.ryusuke@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-nilfs <linux-nilfs@vger.kernel.org>,
        syzbot <syzbot+45d6ce7b7ad7ef455d03@syzkaller.appspotmail.com>,
        syzkaller-bugs@googlegroups.com,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] nilfs2: fix deadlock in nilfs_count_free_blocks()
Date:   Sat, 29 Oct 2022 13:49:12 +0900
Message-Id: <20221029044912.9139-1-konishi.ryusuke@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <000000000000fbf46f05eb3645d0@google.com>
References: <000000000000fbf46f05eb3645d0@google.com>
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

A semaphore deadlock can occur if nilfs_get_block() detects metadata
corruption while locating data blocks and a superblock writeback
occurs at the same time:

task 1                               task 2
------                               ------
* A file operation *
nilfs_truncate()
  nilfs_get_block()
    down_read(rwsem A) <--
    nilfs_bmap_lookup_contig()
      ...                            generic_shutdown_super()
                                       nilfs_put_super()
                                         * Prepare to write superblock *
                                         down_write(rwsem B) <--
                                         nilfs_cleanup_super()
      * Detect b-tree corruption *         nilfs_set_log_cursor()
      nilfs_bmap_convert_error()             nilfs_count_free_blocks()
        __nilfs_error()                        down_read(rwsem A) <--
          nilfs_set_error()
            down_write(rwsem B) <--

                           *** DEADLOCK ***

Here, nilfs_get_block() readlocks rwsem A (= NILFS_MDT(dat_inode)->mi_sem)
and then calls nilfs_bmap_lookup_contig(), but if it fails due to metadata
corruption, __nilfs_error() is called from nilfs_bmap_convert_error()
inside the lock section.

Since __nilfs_error() calls nilfs_set_error() unless the filesystem is
read-only and nilfs_set_error() attempts to writelock rwsem B
(= nilfs->ns_sem) to write back superblock exclusively, hierarchical lock
acquisition occurs in the order rwsem A -> rwsem B.

Now, if another task starts updating the superblock, it may writelock
rwsem B during the lock sequence above, and can deadlock trying to
readlock rwsem A in nilfs_count_free_blocks().

However, there is actually no need to take rwsem A in
nilfs_count_free_blocks() because it, within the lock section, only
reads a single integer data on a shared struct with
nilfs_sufile_get_ncleansegs().  This has been the case after
commit aa474a220180 ("nilfs2: add local variable to cache the number
of clean segments"), that is, even before this bug was introduced.

So, this resolves the deadlock problem by just not taking the
semaphore in nilfs_count_free_blocks().

Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Reported-by: syzbot+45d6ce7b7ad7ef455d03@syzkaller.appspotmail.com
Fixes: e828949e5b42 ("nilfs2: call nilfs_error inside bmap routines")
Tested-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Cc: stable@vger.kernel.org # v2.6.38+
---
 fs/nilfs2/the_nilfs.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/nilfs2/the_nilfs.c b/fs/nilfs2/the_nilfs.c
index 3b4a079c9617..c8b89b4f94e0 100644
--- a/fs/nilfs2/the_nilfs.c
+++ b/fs/nilfs2/the_nilfs.c
@@ -690,9 +690,7 @@ int nilfs_count_free_blocks(struct the_nilfs *nilfs, sector_t *nblocks)
 {
 	unsigned long ncleansegs;
 
-	down_read(&NILFS_MDT(nilfs->ns_dat)->mi_sem);
 	ncleansegs = nilfs_sufile_get_ncleansegs(nilfs->ns_sufile);
-	up_read(&NILFS_MDT(nilfs->ns_dat)->mi_sem);
 	*nblocks = (sector_t)ncleansegs * nilfs->ns_blocks_per_segment;
 	return 0;
 }
-- 
2.34.1

