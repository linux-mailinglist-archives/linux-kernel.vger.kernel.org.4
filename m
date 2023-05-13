Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA22F701623
	for <lists+linux-kernel@lfdr.de>; Sat, 13 May 2023 12:24:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237370AbjEMKYS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 May 2023 06:24:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbjEMKYQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 May 2023 06:24:16 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCD6A1BF3;
        Sat, 13 May 2023 03:24:15 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1aaf706768cso83531185ad.0;
        Sat, 13 May 2023 03:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683973455; x=1686565455;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tdWliSyw9Vs0a4+Mx5Ea0mS03ZFAZO0XAn6m7qo+Pro=;
        b=TYUf0yciahwHAoINMlmasYHsNIj0mB0vwA8sRRG+HcY+oJopfvY6iqibdm5kAMp8xZ
         VAOmON3bpEOSXqaTShgAQEZ1330E/h/aJbAWTNo6qwReBwPbhMIBPBJp6hxxVm413onX
         zeQoRP6rUV7uzyU53vXr2GkhozaGfQ3aqBMfCwdfCubhDJis+A0ZiNjN8+Iv1gc7BabQ
         wSE1o0qu9P96h1khnyfGgq2sa2EWxfHlmm9sru/jczengeor+hZXj0Ddtl5kjiPYxNVa
         UMpgGBpOTi7S3UDhk7DLOm40xPPECl2+QAfOisqQ4tSTyAKRU0aeles6EApESs/xhbW+
         S5Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683973455; x=1686565455;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tdWliSyw9Vs0a4+Mx5Ea0mS03ZFAZO0XAn6m7qo+Pro=;
        b=Nj0/2epLWOruUlJCkI6QUsEg6d4iLG9W4xXMnH+yXZEZHwd9LYmJ5d7u4ZGxiwliae
         DsrH+VpGIm2KuAYmQM8bZIE13ihEebjWGbS+dq9TqymWtAqNNI/gA15YgSnY6yFkNz71
         66GeClJNalZv4dEOzdp5+3yIRCH0LcjM9Wze+BRqTZs4V7CTDD52W7F9Yu/UJCIbo+Gr
         GGnUOuXaaBgMKya8VG2FI7LqfTN13G1pl9CPOPUXj6cMuT0zqRrwIQBEgk3uQMW+1NJD
         Ly1W7bK7KE+Qn9y+CptOkISbbD00D8ZOvrSSuTRy9VNGEzefsIm+90IPV9apqcdC6yOL
         0AAw==
X-Gm-Message-State: AC+VfDxAcaSBhnagE5f4neREiOvj/DVo0rTdLBd7arP3aXAGvMlMvPpv
        onwZ+P8OGoAIi6ozcKPTPoneLvloLEksAg==
X-Google-Smtp-Source: ACHHUZ6CKpZVrfFk2enNb1auS49jWWNhoz1qdWWdg6ZQCSE1DokGvNh4FzhvGDqns37AbeddA6CKXg==
X-Received: by 2002:a17:903:2448:b0:1ac:3642:bff3 with SMTP id l8-20020a170903244800b001ac3642bff3mr35575521pls.38.1683973455158;
        Sat, 13 May 2023 03:24:15 -0700 (PDT)
Received: from carrot.. (i220-108-176-245.s42.a014.ap.plala.or.jp. [220.108.176.245])
        by smtp.gmail.com with ESMTPSA id d15-20020a170902cecf00b001a94a497b50sm9494784plg.20.2023.05.13.03.24.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 May 2023 03:24:13 -0700 (PDT)
From:   Ryusuke Konishi <konishi.ryusuke@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-nilfs@vger.kernel.org,
        syzbot <syzbot+b0a35a5c1f7e846d3b09@syzkaller.appspotmail.com>,
        syzkaller-bugs@googlegroups.com, linux-kernel@vger.kernel.org
Subject: [PATCH] nilfs2: fix incomplete buffer cleanup in nilfs_btnode_abort_change_key()
Date:   Sat, 13 May 2023 19:24:28 +0900
Message-Id: <20230513102428.10223-1-konishi.ryusuke@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <000000000000d1d6c205ebc4d512@google.com>
References: <000000000000d1d6c205ebc4d512@google.com>
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

A syzbot fault injection test reported that nilfs_btnode_create_block,
a helper function that allocates a new node block for b-trees, causes a
kernel BUG for disk images where the file system block size is smaller
than the page size.

This was due to unexpected flags on the newly allocated buffer head, and
it turned out to be because the buffer flags were not cleared by
nilfs_btnode_abort_change_key() after an error occurred during a b-tree
update operation and the buffer was later reused in that state.

Fix this issue by using nilfs_btnode_delete() to abandon the unused
preallocated buffer in nilfs_btnode_abort_change_key().

Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Reported-by: syzbot+b0a35a5c1f7e846d3b09@syzkaller.appspotmail.com
Closes: https://lkml.kernel.org/r/000000000000d1d6c205ebc4d512@google.com
Tested-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Cc: stable@vger.kernel.org
---
 fs/nilfs2/btnode.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/fs/nilfs2/btnode.c b/fs/nilfs2/btnode.c
index e956f886a1a1..5710833ac1cc 100644
--- a/fs/nilfs2/btnode.c
+++ b/fs/nilfs2/btnode.c
@@ -285,6 +285,14 @@ void nilfs_btnode_abort_change_key(struct address_space *btnc,
 	if (nbh == NULL) {	/* blocksize == pagesize */
 		xa_erase_irq(&btnc->i_pages, newkey);
 		unlock_page(ctxt->bh->b_page);
-	} else
-		brelse(nbh);
+	} else {
+		/*
+		 * When canceling a buffer that a prepare operation has
+		 * allocated to copy a node block to another location, use
+		 * nilfs_btnode_delete() to initialize and release the buffer
+		 * so that the buffer flags will not be in an inconsistent
+		 * state when it is reallocated.
+		 */
+		nilfs_btnode_delete(nbh);
+	}
 }
-- 
2.34.1

