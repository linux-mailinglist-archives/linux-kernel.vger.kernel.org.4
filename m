Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20B5F629B64
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 15:02:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238173AbiKOOCt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 09:02:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231211AbiKOOCr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 09:02:47 -0500
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67AE62790B
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 06:02:46 -0800 (PST)
Received: by mail-io1-xd2b.google.com with SMTP id r81so10710051iod.2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 06:02:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jCMTMQ3bV9ouYbsVyfPhqKIkECYbZdKTE0krZImaYNQ=;
        b=RIUc50f4lWMEMIerZkZiP2SVyqrwDdWHyiMACL97pRFmxXOtmxb/yTHIr/kLfTqJ8G
         sVLx34JgrjsaLjGHkf43Ao5XqqtnW74dam++S0DJ3yhiHGLRlO2reCgXXpaIDfO1JSHb
         LHOWrHc/ESMgKjdqAqWwEdcHnEU7i6rAijFa/gZ16d/44h/dXzeBVtIF8XHmgTwXR9Ha
         MnuvbBzAXlHwbhtZoJxkUEu/SqeglkIjFmaQnbTSzXFmt5dK0JhJvsAkwA4l5cXjo41d
         ANslkgJayLwsFgFsDxcN92L5HwmMti5LjBP9/j5xxa800sNPJth7BRwZq50VxUAQg8HK
         Idhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jCMTMQ3bV9ouYbsVyfPhqKIkECYbZdKTE0krZImaYNQ=;
        b=Y6rv1m9Qm4UcyMjzmoaw7EnxyQgAjyg9hpYbcUPKzFC5CrH7wPg0z6WUTcQiSaax8t
         xAe/K0A3z2Lq3Jkxd4Tut0JXuMIVLWcY2HpCi16kuKIOvYSUf3upOVJK9RwQZ57uXPcW
         UeH2Rf4wfn4H9HqycXvFOvPGAeSi0eQAXICyVHiJPrh6o/3tLkTEif+etv+8RIK/lw36
         416WVV8kd5wHvY47sl1wm0nWhRMnQq52uaT+d4L2SUOiCRNedVxBzT5L1D5tSYyp/lp4
         O6JskhZUhaGFmRSvZ6nxozE5gN8+U9BE6H8dhy9bsshXskyiAm31a9ucHBCHXQ6OOrNV
         Qsyg==
X-Gm-Message-State: ANoB5pk3nA+7ZaUW0E1NUP7zkoqj3yT3/cDCjpbE9dv10gcgZVinAwgg
        TXOnqMUlQEmF8MB8ltpCw+CEX9X86GNXog==
X-Google-Smtp-Source: AA0mqf49T2PIPjkngLu1NtsV9Uodm+voEdwneghs/vgZerQOpe/SZg64ECkHRAiefFaGZa6qtauXGw==
X-Received: by 2002:a5d:80d4:0:b0:6bc:ebd:4df9 with SMTP id h20-20020a5d80d4000000b006bc0ebd4df9mr7212232ior.84.1668520965406;
        Tue, 15 Nov 2022 06:02:45 -0800 (PST)
Received: from MBP.lan (ec2-18-117-95-84.us-east-2.compute.amazonaws.com. [18.117.95.84])
        by smtp.gmail.com with ESMTPSA id y16-20020a920910000000b002e85e8b8d1dsm5095192ilg.5.2022.11.15.06.02.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Nov 2022 06:02:44 -0800 (PST)
From:   Schspa Shi <schspa@gmail.com>
To:     mcgrof@kernel.org
Cc:     linux-kernel@vger.kernel.org, Schspa Shi <schspa@gmail.com>,
        syzbot+10d19d528d9755d9af22@syzkaller.appspotmail.com,
        syzbot+70d5d5d83d03db2c813d@syzkaller.appspotmail.com,
        syzbot+83cb0411d0fcf0a30fc1@syzkaller.appspotmail.com
Subject: [PATCH] umh: fix UAF when the process is being killed
Date:   Tue, 15 Nov 2022 22:02:33 +0800
Message-Id: <20221115140233.21981-1-schspa@gmail.com>
X-Mailer: git-send-email 2.37.3
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

When the process is killed, wait_for_completion_state will return with
-ERESTARTSYS, and the completion variable in the stack will be freed.
If the user-mode thread is complete at the same time, there will be a UAF.

Please refer to the following scenarios.
            T1                                  T2
------------------------------------------------------------------
call_usermodehelper_exec
                                   call_usermodehelper_exec_async
                                   << do something >>
                                   umh_complete(sub_info);
                                   comp = xchg(&sub_info->complete, NULL);
                                   /* we got the completion */
                                   << context switch >>

    << Being killed >>
	retval = wait_for_completion_state(sub_info->complete, state);
	if (!retval)
		goto wait_done;

	if (wait & UMH_KILLABLE) {
		/* umh_complete() will see NULL and free sub_info */
		if (xchg(&sub_info->complete, NULL))
			goto unlock;
        << we can't got the completion >>
	}
	....
unlock:
	helper_unlock();
	return retval;
}

/**
 * the completion variable in stack is end of life cycle.
 * and maybe freed due to process is recycled.
 */
                                   --------UAF here----------
                                   if (comp)
                                       complete(comp);

To fix it, we can put the completion variable in the subprocess_info
variable.

Reported-by: syzbot+10d19d528d9755d9af22@syzkaller.appspotmail.com
Reported-by: syzbot+70d5d5d83d03db2c813d@syzkaller.appspotmail.com
Reported-by: syzbot+83cb0411d0fcf0a30fc1@syzkaller.appspotmail.com

Signed-off-by: Schspa Shi <schspa@gmail.com>
---
 include/linux/umh.h | 1 +
 kernel/umh.c        | 6 +++---
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/include/linux/umh.h b/include/linux/umh.h
index 5d1f6129b847..801f7efbc825 100644
--- a/include/linux/umh.h
+++ b/include/linux/umh.h
@@ -20,6 +20,7 @@ struct file;
 struct subprocess_info {
 	struct work_struct work;
 	struct completion *complete;
+	struct completion done;
 	const char *path;
 	char **argv;
 	char **envp;
diff --git a/kernel/umh.c b/kernel/umh.c
index 850631518665..3ed39956c777 100644
--- a/kernel/umh.c
+++ b/kernel/umh.c
@@ -380,6 +380,7 @@ struct subprocess_info *call_usermodehelper_setup(const char *path, char **argv,
 	sub_info->cleanup = cleanup;
 	sub_info->init = init;
 	sub_info->data = data;
+	init_completion(&sub_info->done);
   out:
 	return sub_info;
 }
@@ -405,7 +406,6 @@ EXPORT_SYMBOL(call_usermodehelper_setup);
 int call_usermodehelper_exec(struct subprocess_info *sub_info, int wait)
 {
 	unsigned int state = TASK_UNINTERRUPTIBLE;
-	DECLARE_COMPLETION_ONSTACK(done);
 	int retval = 0;
 
 	if (!sub_info->path) {
@@ -431,7 +431,7 @@ int call_usermodehelper_exec(struct subprocess_info *sub_info, int wait)
 	 * This makes it possible to use umh_complete to free
 	 * the data structure in case of UMH_NO_WAIT.
 	 */
-	sub_info->complete = (wait == UMH_NO_WAIT) ? NULL : &done;
+	sub_info->complete = (wait == UMH_NO_WAIT) ? NULL : &sub_info->done;
 	sub_info->wait = wait;
 
 	queue_work(system_unbound_wq, &sub_info->work);
@@ -444,7 +444,7 @@ int call_usermodehelper_exec(struct subprocess_info *sub_info, int wait)
 	if (wait & UMH_FREEZABLE)
 		state |= TASK_FREEZABLE;
 
-	retval = wait_for_completion_state(&done, state);
+	retval = wait_for_completion_state(sub_info->complete, state);
 	if (!retval)
 		goto wait_done;
 
-- 
2.37.3

