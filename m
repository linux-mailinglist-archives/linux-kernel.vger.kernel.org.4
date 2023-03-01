Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 144456A6478
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 01:54:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbjCAAyJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 19:54:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbjCAAyI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 19:54:08 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E67A36693
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 16:54:06 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id i10so12316076plr.9
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 16:54:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=efficientek-com.20210112.gappssmtp.com; s=20210112; t=1677632046;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=11WiiE5LECn10SNRXda1xNOScTgJeML/5FN9jEN5+98=;
        b=EoHsEGgCN4rP2xMrtYYBHm6TBpkidrU11vAdumbiy1GJ+Ua03wyo2sOJsGg22fAoR0
         9tum57ZLNlB6lIfRyo1qIyL0fhxWKpjdbFt+yrFIOLY57WRAHCLbednx5fQfgaJNB4eN
         9q4Mb0129eS63EnVJR16IHZczZ9EmZrk0PnMWcljkJ4L6bfI3zSa/OB8C7W/J4E0GyR2
         qCo91dnYbMTcTHVGZaDlH+tEZhULnWGYEP6YcYTUxMBCXwj+n1Af3FHP1aCPpJVHup1l
         fpTAQFtYDSGNEH8tYesweFv16GyLTOUslsQ6wEGCKjOd9Z9KE320n3/DqP0ppK01deHA
         6NAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677632046;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=11WiiE5LECn10SNRXda1xNOScTgJeML/5FN9jEN5+98=;
        b=doyN+yomO39uz9T+H0pjYm1r6HkkXRkORRkesQpX0/24krrL6N+PmZqK81TvzZNTbL
         ebheyxFl2KdCZjngCYBARHR8bKs/gdJBGKk/GUZdUSh6bQRiisWgh9PNlGAf3rg3XQ5I
         06fYRR33ABe+A+K5eH6MSlcsGY5wCBikPV5kuS7+hRZ+i/vvf44ZhkyhRpO6vIvwXMno
         TuhzvbUBnC8pUkj7L5RFJ/qF+KXz15kSZV6+ww4yOwurwySPbBCI+8IK4uRnMsDbkr3A
         ITORTEum8KSJ20CZL4I1LMUCA/QRwDkiiP7gaTBB6m/oHgZwj/g4fQaoFNOymeMbqIkX
         q/YA==
X-Gm-Message-State: AO0yUKUN9p50CuqDTxkNJ2nxwyibLmSog/XQP+E+WWCtkLpoBjO9AV0o
        1yR4/vRR7BuBoTcZuaF9t8N8c/VyXpEmsm1T
X-Google-Smtp-Source: AK7set8Cr7fUcJTR42GCxrxVeRMKWCQgMMJC8yqN+l8CWjpTlVLSJYWzo+A3LqiH9xdIWlUeQ0Yxxg==
X-Received: by 2002:a17:90b:164e:b0:23a:baf:ffec with SMTP id il14-20020a17090b164e00b0023a0bafffecmr932669pjb.22.1677632045785;
        Tue, 28 Feb 2023 16:54:05 -0800 (PST)
Received: from localhost.localdomain ([37.218.244.251])
        by smtp.gmail.com with ESMTPSA id c5-20020a6566c5000000b00503000f0492sm18606pgw.14.2023.02.28.16.53.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 16:54:04 -0800 (PST)
From:   Glenn Washburn <development@efficientek.com>
To:     Jan Kiszka <jan.kiszka@siemens.com>,
        Kieran Bingham <kbingham@kernel.org>
Cc:     Glenn Washburn <development@efficientek.com>,
        John Ogness <john.ogness@linutronix.de>,
        Petr Mladek <pmladek@suse.com>,
        Antonio Borneo <antonio.borneo@foss.st.com>,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 0/2] GDB VFS utils
Date:   Tue, 28 Feb 2023 18:53:33 -0600
Message-Id: <cover.1677631565.git.development@efficientek.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I've created a couple GDB convenience functions that I found useful when
debugging some VFS issues and figure others might find them useful. For
instance, they are useful in setting conditional breakpoints on VFS
functions where you only care if the dentry path is a certain value. I
took the opportunity to create a new "vfs" python module to give VFS
related utilities a home.

Glenn

Glenn Washburn (2):
  scripts/gdb: Create linux/vfs.py for VFS related GDB helpers
  scripts/gdb: Add GDB convenience functions $lx_dentry_name() and
    $lx_i_dentry()

 scripts/gdb/linux/proc.py  | 15 +++++-----
 scripts/gdb/linux/utils.py |  8 ------
 scripts/gdb/linux/vfs.py   | 59 ++++++++++++++++++++++++++++++++++++++
 scripts/gdb/vmlinux-gdb.py |  1 +
 4 files changed, 68 insertions(+), 15 deletions(-)
 create mode 100644 scripts/gdb/linux/vfs.py

-- 
2.30.2

