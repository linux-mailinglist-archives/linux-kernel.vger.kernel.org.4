Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C5436DE994
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 04:38:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbjDLCip (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 22:38:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjDLCio (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 22:38:44 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ECF840D8
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 19:38:43 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id d2e1a72fcca58-63af68592f0so859950b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 19:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681267122; x=1683859122;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RNWG2HLYVu8lISkZ1sV4u+6+PLx7BcJ7lAq9oMLMvNk=;
        b=he62bc8OveLb0DVwvJVNFeL8V9939ycFrKnUYdFQveUBL6N8KkND5MSvuP7n0DMR3I
         qcv8jPZ2mpLHZ2ATdlDQaERA3ie780MAiMLaOB6fIKe13CHm+J9Xxpt59jLJiVwAjNfe
         sCg+faCVAXXsYScFe8ETvtzBFg5G/5NrTrnxa4JFQNymZiDDOF1dBOp4JONT0MmUQ6c7
         QPqkAX8pQYakP6xFuTb5rReqycTe5bpeWtPZvcvgYweS96ActIKmr6uwaDMBlKMQZAgP
         6uMdd1JtpdKeXUC77A7OT/nv4ApemHGnE8jq9dGJA3LxGlaUXnOSLaQo9tsLs5qHgHq7
         jeow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681267122; x=1683859122;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RNWG2HLYVu8lISkZ1sV4u+6+PLx7BcJ7lAq9oMLMvNk=;
        b=7TRik38Q2Z6oqzp+OEoEqkitJYd+ej99/rsEJks+On6s2j4lz7xWeBWGH9aIzYjuof
         Mz1BZOfAfmVHvohCccr/BHowtXwFEEQL0MBrXFjctHMG/0EtbTdKq1MSFGQ4qs6MCOjr
         ALWZ6DiYtiSSNV8ldWUkOI+NLtm2IUhodeczJ7pMA/KHFnFvClokRAXsN4p7/xo45ost
         OlEsIpGG0KOK/bLWO61HvdlSGYfsPwmqABQ4OZxnMPGge7WOs+tK+TmuR6k/RcsK6ek4
         5aPJXqLvZ+drqIV5FMU+4rT5h82RWqN60PlH5CNAWt4NVCJPKwx1qCRgtXWUxIBNa1kO
         zepw==
X-Gm-Message-State: AAQBX9eN6nyh5zgiYAZakfE2jzZq1fmvQ7qjooJyJF8zx+Ln8lwRuUut
        p5OvwZt/1kNDpE5qr2LIO0UYSINPsKg19jxv8TX8unBmRt4hiLwN+fdYRboHrzjGP1hWisy/DPK
        BttfRZcorYi4wLydNKLTDuzzck69ug752PXfK+phXjTyYgY1/69bEaF0JsagUAZnRxt19eQs=
X-Google-Smtp-Source: AKy350bDT1s8PAqQU63jFNJ65fDC8ReNM/DryIQ8gPGrrq5Vrqhki098rPAbm73qeZxAqs+8RhGiflRK3iUR
X-Received: from jstultz-noogler2.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:600])
 (user=jstultz job=sendgmr) by 2002:a05:6a00:1ca4:b0:63a:2000:6e0c with SMTP
 id y36-20020a056a001ca400b0063a20006e0cmr545417pfw.3.1681267122451; Tue, 11
 Apr 2023 19:38:42 -0700 (PDT)
Date:   Wed, 12 Apr 2023 02:38:39 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.0.577.gac1e443424-goog
Message-ID: <20230412023839.2869114-1-jstultz@google.com>
Subject: [RFC][PATCH] locking/rwsem: Add __sched annotation to __down_read_common()
From:   John Stultz <jstultz@google.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     John Stultz <jstultz@google.com>, Minchan Kim <minchan@kernel.org>,
        Tim Murray <timmurray@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>, kernel-team@android.com,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Apparently despite it being marked inline, the compiler
may not inline __down_read_common() which makes it difficult
to identify the cause of lock contention, as the blocked
function will always be listed as __down_read_common().

So this patch adds __sched annotation to the function so
the calling function will instead be listed.

Cc: Minchan Kim <minchan@kernel.org>
Cc: Tim Murray <timmurray@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Will Deacon <will@kernel.org>
Cc: Waiman Long <longman@redhat.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: kernel-team@android.com
Cc: stable@vger.kernel.org
Fixes: c995e638ccbb ("locking/rwsem: Fold __down_{read,write}*()")
Reported-by: Tim Murray <timmurray@google.com>
Signed-off-by: John Stultz <jstultz@google.com>
---
 kernel/locking/rwsem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
index acb5a50309a1..cde2f22e65a8 100644
--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -1240,7 +1240,7 @@ static struct rw_semaphore *rwsem_downgrade_wake(struct rw_semaphore *sem)
 /*
  * lock for reading
  */
-static inline int __down_read_common(struct rw_semaphore *sem, int state)
+static inline __sched int __down_read_common(struct rw_semaphore *sem, int state)
 {
 	int ret = 0;
 	long count;
-- 
2.40.0.577.gac1e443424-goog

