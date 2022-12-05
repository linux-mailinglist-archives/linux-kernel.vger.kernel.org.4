Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 989146435B7
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 21:33:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233397AbiLEUdG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 15:33:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233467AbiLEUc7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 15:32:59 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42F1465E4
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 12:32:58 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id m2-20020a17090a730200b0021020cce6adso17472468pjk.3
        for <linux-kernel@vger.kernel.org>; Mon, 05 Dec 2022 12:32:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=antRRD0vokgKx0N3J+PXb46vFk8dibXmcnSX4dVIdQw=;
        b=ShcU1Hu7FjHVxESQXX7VbG15++IpyzlkpBWKvZ0Pj2ZiCG5CXf3V3tl8VyjMYAab3Q
         p71i5QpQ91HzcA9nBbabEkuvkuYlcsQwtD8P5XN74eYDbN4H2+ka6J9GXH//H6abyVzO
         IqwYtMPh6LL8xCO1tcC6JuOqIchwcmD2dIrB3yuxJaGFIQItgqNgKx3hP6Rl+ZVwuwbp
         8FH8Ao6Fw7Uy05o9e4h8c3TaQuAsFDoSsQCKEWjHHLEDrVQh3pV9p5o0T+2zZKPgCLpc
         7q0vnxpyWUi4U6G02COuubsAt1EgtlxuXtW64+IXzxarw1yM53pNlP9VzCyXh1yrhUai
         xX6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=antRRD0vokgKx0N3J+PXb46vFk8dibXmcnSX4dVIdQw=;
        b=wKPEEhU7KaboN1DWRRbG7/Q1yBhoV5ywuYcBSqIa8UVDznKR1DBgO82RbIIPuCuNPX
         8T0qXor+ZKCZEFGn6Radw2ynqC7yhViA7hpWbUBEJ/hfRomoD7razbOM7d9lFrQ0W59D
         Y13PUxnlMF0bfbbh4DF4Vslo8oXI1x7WphnILDz3+FSto6aAcPrwZBOelSPqmorUb8s5
         bKe8k7knHCBmuBHrZqGZ2Y1YCDqEIie2AcAn872M7RSikYHP1oUfprXb6xWnAngekDkX
         1sis7C/EoMBZmtln+0+ISHn5WSpii90kqeueKcNDwWqjZ6TypKamTP9L+ivPSDOKztAK
         fyIw==
X-Gm-Message-State: ANoB5pnFX8pH+dwbFWtFCrftiRBOk0Q7oq1xLz5B7iDZzQDtzQX+A3HY
        WWfrxSkBceP31LUT5lHwlM/NluOctsqtUSQMc3V48AD5lbqQvmfDT6Tt5WwVXTKx8cZgj3GOVAA
        ZSjGJ9FsLqtj6YwrvtONVzdT1qu36w6hZbBGvlQMZlwXE4AyHrktBYHGtKCUE3sOijr1NkDs=
X-Google-Smtp-Source: AA0mqf4+dGIqnVghmvz7rwEqE5YsFG5l4kqy4fjZBE67+9RraWy3UP8PNc+4yVXDDZoeXyVrSChbEu9xtbCH
X-Received: from jstultz-noogler2.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:600])
 (user=jstultz job=sendgmr) by 2002:a17:90a:43a4:b0:219:1d0a:34a6 with SMTP id
 r33-20020a17090a43a400b002191d0a34a6mr4744517pjg.1.1670272377261; Mon, 05 Dec
 2022 12:32:57 -0800 (PST)
Date:   Mon,  5 Dec 2022 20:32:53 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.0.rc0.267.gcb52ba06e7-goog
Message-ID: <20221205203253.3923812-1-jstultz@google.com>
Subject: [RFC PATCH] pstore: Switch pmsg_lock to an rt_mutex to avoid priority inversion
From:   John Stultz <jstultz@google.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     John Stultz <jstultz@google.com>, Wei Wang <wvw@google.com>,
        Midas Chien <midaschieh@google.com>,
        "Connor O'Brien" <connoro@google.com>,
        Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>, kernel-team@android.com
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

Wei Wang reported seeing priority inversion caused latencies
caused by contention on pmsg_lock, and suggested it be switched
to a rt_mutex.

I was initially hesitant this would help, as the tasks in that
trace all seemed to be SCHED_NORMAL, so the benefit would be
limited to only nice boosting.

However, another similar issue was raised where the priority
inversion was seen did involve a blocked RT task so it is clear
this would be helpful in that case.

Feedback would be appreciate!

Cc: Wei Wang <wvw@google.com>
Cc: Midas Chien<midaschieh@google.com>
Cc: Connor O'Brien <connoro@google.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Anton Vorontsov <anton@enomsg.org>
Cc: Colin Cross <ccross@android.com>
Cc: Tony Luck <tony.luck@intel.com>
Cc: kernel-team@android.com
Reported-by: Wei Wang <wvw@google.com>
Signed-off-by: John Stultz <jstultz@google.com>
---
 fs/pstore/pmsg.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/pstore/pmsg.c b/fs/pstore/pmsg.c
index d8542ec2f38c..18cf94b597e0 100644
--- a/fs/pstore/pmsg.c
+++ b/fs/pstore/pmsg.c
@@ -7,9 +7,10 @@
 #include <linux/device.h>
 #include <linux/fs.h>
 #include <linux/uaccess.h>
+#include <linux/rtmutex.h>
 #include "internal.h"
 
-static DEFINE_MUTEX(pmsg_lock);
+static DEFINE_RT_MUTEX(pmsg_lock);
 
 static ssize_t write_pmsg(struct file *file, const char __user *buf,
 			  size_t count, loff_t *ppos)
@@ -28,9 +29,9 @@ static ssize_t write_pmsg(struct file *file, const char __user *buf,
 	if (!access_ok(buf, count))
 		return -EFAULT;
 
-	mutex_lock(&pmsg_lock);
+	rt_mutex_lock(&pmsg_lock);
 	ret = psinfo->write_user(&record, buf);
-	mutex_unlock(&pmsg_lock);
+	rt_mutex_unlock(&pmsg_lock);
 	return ret ? ret : count;
 }
 
-- 
2.39.0.rc0.267.gcb52ba06e7-goog

