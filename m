Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 386C964D32D
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 00:19:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbiLNXTK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 18:19:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229864AbiLNXSp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 18:18:45 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17F914A5B2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 15:18:44 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-3bd1ff8fadfso15109057b3.18
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 15:18:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=sz3EsdlLQi6luft4uKgNHjeoND5SWdEjOQijkdP8nN8=;
        b=MjA2UQchowrEJVjRbTlPCUFNeyUVAftiWyJUJZ3Phg8OYTLv3seNUDt769fthusDjN
         JMDWjn9nACLzbWNE59zoGrUUqWnn5Qsg/9+LZSHCxb5m6WdX4e4LrE3rXSj+G43rP3PO
         Pav0MT4k68KHa7am0FD9lxX7ejCjmmvO4zqkOnhJOdsgOeuAbOw0AvY9cqOlP6PLXzLf
         qfcstg1xNe+P5u2YlXQGp4ukr89NU5KyllUjrMzFgWKxkf1WIz07VlohnJpxGwQG2xU0
         KAx9yp2mbhj+axMEaq38ZdSscFZAXh8Rj02gzwGc8f4NydcXvthcIht1wMrOgnfnfikO
         O+Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sz3EsdlLQi6luft4uKgNHjeoND5SWdEjOQijkdP8nN8=;
        b=ngjlDSXip1wW9Wd7yBmHYDOvGwK+hwaRjgJHgYUREXuckuQQpUGp8htO20y7GK+3fU
         2yDJvK7Xux30+LsG1z7FFYGq31/UlCaE1G8G4upFZR+CBRIrKTugox4XkrdNoIV1BgoR
         EbADX+B3oz/qqvxcDeBBI97wiIEzMiQwt24GBUTh8e/Qy8EnzXg+IJnnNT7UU7oz48MD
         DAjjrKMLRyD1/w0o3dZxJF/eWBQ/EASKqrcvLRrUQp8mu0Zn/p43c3X5eQoj8znRKcps
         KB8kcezfGRT/Jhqh0TZYwYcyC89jD3s8BuNwarNrxxxHDcJUIFU5B6VvftW6mbAZIQVq
         Z6sA==
X-Gm-Message-State: ANoB5pn+Y8H6zPPDfomHGTFKK/K2llHdvyx1d7iGezTVK23oskKBK+7N
        EUo3iV3Mzr5W7BA4zKssC2bgq2cR0il7hVWFj79Ql6vGAxi5pplHExmBmduXRle/7WVKHtasUfl
        jUxb2V35CoLRZF5hggkbdHPD6SlB/kadreATWgoQjMUhVXB+2VN2K4fYwL8DIH1cw2oLsD0M=
X-Google-Smtp-Source: AA0mqf5wTl6erjuPrEaEfp/M0fJ/LsiW2kTZNYKYjyyPqYEFjdS5sfs6NvNzZN0zuOSDMHwTt/MAk+0lPzgQ
X-Received: from jstultz-noogler2.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:600])
 (user=jstultz job=sendgmr) by 2002:a25:50cd:0:b0:707:18f:7226 with SMTP id
 e196-20020a2550cd000000b00707018f7226mr11427904ybb.505.1671059923320; Wed, 14
 Dec 2022 15:18:43 -0800 (PST)
Date:   Wed, 14 Dec 2022 23:18:34 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20221214231834.3711880-1-jstultz@google.com>
Subject: [PATCH v2] pstore: Switch pmsg_lock to an rt_mutex to avoid priority inversion
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

Cc: Wei Wang <wvw@google.com>
Cc: Midas Chien<midaschieh@google.com>
Cc: Connor O'Brien <connoro@google.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Anton Vorontsov <anton@enomsg.org>
Cc: Colin Cross <ccross@android.com>
Cc: Tony Luck <tony.luck@intel.com>
Cc: kernel-team@android.com
Fixes: 9d5438f462ab ("pstore: Add pmsg - user-space accessible pstore object")
Reported-by: Wei Wang <wvw@google.com>
Signed-off-by: John Stultz <jstultz@google.com>
---
v2: Added Fixes tag
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
2.39.0.314.g84b9a713c41-goog

