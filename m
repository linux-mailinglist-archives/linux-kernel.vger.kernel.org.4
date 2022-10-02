Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A3D85F211B
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Oct 2022 05:08:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229481AbiJBDIP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Oct 2022 23:08:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiJBDIK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Oct 2022 23:08:10 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6F4F2BE1C;
        Sat,  1 Oct 2022 20:08:09 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id i6so7501931pfb.2;
        Sat, 01 Oct 2022 20:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=H94AYH5YtHBkal/GiFTQVCFtPlhU2OjgiQ2dQ8FUTFw=;
        b=qgbNytB8z5Bj8JoQzwz8kS+Ikv4oEd/VUDI9jP8UhJGyS0e/YhY63cwuhgqUnwSOCa
         5HIxK4LRq9UCO4rUodculT+kZBKOZMfQ7ly+s7k6B2igC9vQ4svXAOZE8kh8n2a0xeI0
         //YeLO0OXjJAAqOoDkqneYmp30k7B+PACZ/WohdrOwT0Y3bL89DomMz5gMM1Ri4lGV1j
         xEFhSYS43RY1ueVJK5THxT3mwmMSMzII2gJRb4i9MazyXnwUqJFvhSeK2cD9a8ebN6f6
         dBbgTkDPtGqko9cck0EYgH4m5IeqiGUbuwVPQ/UdW5K2kQlyWLuIBtJdg4W/4nQsAwz0
         7keQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=H94AYH5YtHBkal/GiFTQVCFtPlhU2OjgiQ2dQ8FUTFw=;
        b=UY25YdoQFSHyeWQ7SSOu24zX07TZXcU/8utTt9q/8MbbDs37fpBbeDfYGe1UJC7Cc/
         io+NfHx1fpcBjxX3/2n0DQOpUXItBuM/WpEbrKCx63/Qsx5LB2HeV6OeJNj+jDw2VxEy
         61S6GrtJ0Qb5WVxZK84v5w94J4PUdCBKrEaeWzlHVpL2mQm/QJ0FDME/bfwKMuINzCgP
         +h4mBIaF3t9+M+AljuBxKrQbQB8xYnVCI5hKzYhhhlge6vzOeUluVGitgUTPu9IzxsPN
         ZwfM7x3IhYFd+Tm+2r3hFOKZY5Yj52BGy2KLCot/o6w9BUtuSTKeNMenHnsLG+EHDb6Y
         cvtQ==
X-Gm-Message-State: ACrzQf1OdFa4snjBDHj/idKEo99wkRQhQNVbasSQ9iYCHOAWFU+ObMgK
        xtS0DfbIS32xHSYTpO14Oxk=
X-Google-Smtp-Source: AMsMyM5SfKLd0YiOP8TGufRZ3gOlacqHTP3wRF38GE/B7TIcPJXSsB2SCuSBIpDU9Splneb1B08kSw==
X-Received: by 2002:a65:6cc4:0:b0:412:35fa:5bce with SMTP id g4-20020a656cc4000000b0041235fa5bcemr13374373pgw.466.1664680089138;
        Sat, 01 Oct 2022 20:08:09 -0700 (PDT)
Received: from carrot.. (i220-109-170-101.s42.a014.ap.plala.or.jp. [220.109.170.101])
        by smtp.gmail.com with ESMTPSA id lb12-20020a17090b4a4c00b00205fafa6768sm6677189pjb.6.2022.10.01.20.08.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Oct 2022 20:08:08 -0700 (PDT)
From:   Ryusuke Konishi <konishi.ryusuke@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-nilfs <linux-nilfs@vger.kernel.org>,
        syzbot <syzbot+2b32eb36c1a825b7a74c@syzkaller.appspotmail.com>,
        syzkaller-bugs@googlegroups.com,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] nilfs2: fix NULL pointer dereference at nilfs_bmap_lookup_at_level()
Date:   Sun,  2 Oct 2022 12:08:04 +0900
Message-Id: <20221002030804.29978-1-konishi.ryusuke@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <000000000000eb0ba805e9d6e30e@google.com>
References: <000000000000eb0ba805e9d6e30e@google.com>
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

If the i_mode field in inode of metadata files is corrupted on disk,
it can cause the initialization of bmap structure, which should have
been called from nilfs_read_inode_common(), not to be called.  This
causes a lockdep warning followed by a NULL pointer dereference at
nilfs_bmap_lookup_at_level().

This patch fixes these issues by adding a missing sanitiy check for
the i_mode field of metadata file's inode.

Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Reported-by: syzbot+2b32eb36c1a825b7a74c@syzkaller.appspotmail.com
Reported-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Tested-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Cc: stable@vger.kernel.org
---
 fs/nilfs2/inode.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/nilfs2/inode.c b/fs/nilfs2/inode.c
index 67f63cfeade5..d4e653d51869 100644
--- a/fs/nilfs2/inode.c
+++ b/fs/nilfs2/inode.c
@@ -440,6 +440,8 @@ int nilfs_read_inode_common(struct inode *inode,
 	inode->i_atime.tv_nsec = le32_to_cpu(raw_inode->i_mtime_nsec);
 	inode->i_ctime.tv_nsec = le32_to_cpu(raw_inode->i_ctime_nsec);
 	inode->i_mtime.tv_nsec = le32_to_cpu(raw_inode->i_mtime_nsec);
+	if (nilfs_is_metadata_file_inode(inode) && !S_ISREG(inode->i_mode))
+		return -EIO; /* this inode is for metadata and corrupted */
 	if (inode->i_nlink == 0)
 		return -ESTALE; /* this inode is deleted */
 
-- 
2.34.1

