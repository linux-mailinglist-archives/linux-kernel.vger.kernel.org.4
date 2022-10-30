Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15923612A4D
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Oct 2022 12:18:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbiJ3LSJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Oct 2022 07:18:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbiJ3LSH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Oct 2022 07:18:07 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EE8019B
        for <linux-kernel@vger.kernel.org>; Sun, 30 Oct 2022 04:18:06 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id i3so8402668pfc.11
        for <linux-kernel@vger.kernel.org>; Sun, 30 Oct 2022 04:18:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nGegimzJJD/T3a8obFFAOriR2r5i2MS27jrBICwZ++w=;
        b=kZBettFQu2uvNxkaRYEKc5rqe8avhio5gp0JwXdQRmF48TodXPsHT8ZgBF8rY2WG1S
         Bu0A3YhBZrv7h3FDOcIT4RlbZNPbLLanBCXDcCZF20F1gtuA3qdW3EDOxptZwi0EPHpp
         XjW7QTTml9KunHiMBBrfzXakoxjaPP8ivyTbaTkzcVmpyW3k6ojXzF8dGp0e2ALtWBio
         NDyyAYIzbk9CgfPwMvC0G7XlXvZOFXH70f0HvPH0lBs0b1IUGri1ljciNHOUPjS5V7V1
         Rf1YnsnWBqOTfgEvDO0YQzSSFjIqeErofFGLjxHXPdDxBlDt3B5vqvLmoBMXxZ6/crdn
         BhwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nGegimzJJD/T3a8obFFAOriR2r5i2MS27jrBICwZ++w=;
        b=A8PeG8BENsyeDQ+tPDctGcn4oxTo88U8ZEw9gs+xrRqcPXMCKBqQgcP/t2pDIyBFvP
         7XC1D6NW5k7TiFI1AnjrOkdr2sK2pVx2pjEzAMLDSakc+8sA+jeHMPf9517CFmgvm3+6
         AaRHXJZL86vM2y28Bpr6PCk3UwumJN5uWLTAjy7KjsvV2AAvi+26N7dynXC5zUdOpHjO
         XEFmo29jzn03DHGncBE9ru25f0n4+/8W8CSmSF/DWbCnErPL8WoTggKC928/flYIgzHu
         mULkwulA0S5NwPdMo9xTBCYEo6R6lK0vImZdG/90U6ie1ZjZlCyUkbYDx/3I7hy/QG9K
         VnEw==
X-Gm-Message-State: ACrzQf1e/gxt2Gxfk8VgLAy7GYHWlEGcMJRNo425Nzh6ftISS7Pg0EMh
        5+ovMAATTtwNmJFUyodwQF0=
X-Google-Smtp-Source: AMsMyM6z/a0k0K+YCtvix5ZzjoelmcxB09u+rNqMPimr0gFySk4mBRzL+VhU5KMsAtoUpgKs33LHRw==
X-Received: by 2002:a05:6a00:acc:b0:530:e79e:fc27 with SMTP id c12-20020a056a000acc00b00530e79efc27mr8754669pfl.61.1667128685800;
        Sun, 30 Oct 2022 04:18:05 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.234])
        by smtp.gmail.com with ESMTPSA id n11-20020a170903404b00b00176e6f553efsm2559531pla.84.2022.10.30.04.18.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Oct 2022 04:18:05 -0700 (PDT)
From:   wuchi <wuchi.zero@gmail.com>
To:     peterz@infradead.org, mingo@redhat.com, will@kernel.org,
        longman@redhat.com, boqun.feng@gmail.com
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] locking/lockdep: Remove unused variable in __lockdep_count*()
Date:   Sun, 30 Oct 2022 19:17:59 +0800
Message-Id: <20221030111759.95092-1-wuchi.zero@gmail.com>
X-Mailer: git-send-email 2.32.1 (Apple Git-133)
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

The target_entry variable will never be referenced because the
function noop_count() always returns false in __bfs().
So just remove that.

Signed-off-by: wuchi <wuchi.zero@gmail.com>
---
 kernel/locking/lockdep.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index e3375bc40dad..04d2ce5d0215 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -2075,9 +2075,8 @@ static bool noop_count(struct lock_list *entry, void *data)
 static unsigned long __lockdep_count_forward_deps(struct lock_list *this)
 {
 	unsigned long  count = 0;
-	struct lock_list *target_entry;
 
-	__bfs_forwards(this, (void *)&count, noop_count, NULL, &target_entry);
+	__bfs_forwards(this, (void *)&count, noop_count, NULL, NULL);
 
 	return count;
 }
@@ -2100,9 +2099,8 @@ unsigned long lockdep_count_forward_deps(struct lock_class *class)
 static unsigned long __lockdep_count_backward_deps(struct lock_list *this)
 {
 	unsigned long  count = 0;
-	struct lock_list *target_entry;
 
-	__bfs_backwards(this, (void *)&count, noop_count, NULL, &target_entry);
+	__bfs_backwards(this, (void *)&count, noop_count, NULL, NULL);
 
 	return count;
 }
-- 
2.20.1

