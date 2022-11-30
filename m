Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1DF163DC83
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 18:57:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229955AbiK3R5Y convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 30 Nov 2022 12:57:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiK3R5W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 12:57:22 -0500
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F7824A9FE;
        Wed, 30 Nov 2022 09:57:21 -0800 (PST)
Received: by mail-qt1-f173.google.com with SMTP id c15so11673774qtw.8;
        Wed, 30 Nov 2022 09:57:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0r+qoVGex27F3PzpZtPMiTDGjKKV7o+719GPjal98r0=;
        b=xgP9Zgnzclog5C0xh73dpDMbpSBdkRz5hwCpkRFDaTOSkM0USojRQH6pFsO5bWkjDf
         mI3vXuUhu7734xmuViMatJIae3U5EZMDacnwtyrs0sBVyIFMT8D3MNjsPxb3iwKlmiJb
         mUiz6cJm1eouECCdW9l0x7G392F3KaiMcJMGavvjUTEfou4aoIoTfFqAEZTBkwHkWS5C
         //oKPeLsbraXdeRcrOfcDOmdMXGjCi+JhGJdWW8DvgEapimfE3KHMRfqIMAk6nC1j08P
         VVzeYu0g6mGHKsQVtza/Ok97AvxQpV4jXo4xAhc+s/isrbmqUIt6HjY47/MKPk5wzl/Q
         2hDg==
X-Gm-Message-State: ANoB5pkp2+ptf8OI253W3owQC1lDtI1/XvqYPtISnhmDsd/qdAw5BSNf
        8niXZNkvbg2zr9ziAVdaoTY9aagGD/SGPocX0z0=
X-Google-Smtp-Source: AA0mqf5MSsQw2lo+u3a2PKwj4cdrb0LTqNXPpvKWPMiVbpzw5t7TBdFnrCeYShTgtv8eCF5xSqWvP/Pw5cSrcCQYQeA=
X-Received: by 2002:a05:622a:1989:b0:3a5:7cf8:1a6e with SMTP id
 u9-20020a05622a198900b003a57cf81a6emr58578957qtc.48.1669831040582; Wed, 30
 Nov 2022 09:57:20 -0800 (PST)
MIME-Version: 1.0
References: <20221125190948.2062-1-linux@weissschuh.net>
In-Reply-To: <20221125190948.2062-1-linux@weissschuh.net>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 30 Nov 2022 18:57:09 +0100
Message-ID: <CAJZ5v0i8pm1vxQeQu4GJqvf=rinU9dO2gswsLseyEt3E2CgbtA@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] printk: introduce new macros pr_<level>_cont()
To:     =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        linux-pm@vger.kernel.org, Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andy Whitcroft <apw@canonical.com>,
        Joe Perches <joe@perches.com>, linux-kernel@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 25, 2022 at 8:10 PM Thomas Weißschuh <linux@weissschuh.net> wrote:
>
> This series adds new printk wrapper macros pr_<level>_cont().
> These create continuation messages with an explicit level.
>
> Explicit levels are useful when a continuation message is split from its main
> message. Without the explicit level KERN_DEFAULT ("warn" by default) is used
> which can lead to stray partial log messages when filtering by level.
>
> Also checkpatch is modified to recommend the new macros over plain pr_cont().
>
> Lastly the new macros are used in kernel/power/process.c as this file uses
> continuation messages during system suspend-resume which creates a high
> likelyhood of interspersed messages.

Well, if process.c is the only problematic piece of code in this
respect, I'm not sure if adding the new infrastructure for its benefit
alone is worth it, because it can very well do without pr_cont() at
all.

Please see the patch below (compiled only, sorry for gmail-induced
white space damage).  I'll submit it properly later if it works for
everyone.

---
 kernel/power/process.c |   25 ++++++++++---------------
 1 file changed, 10 insertions(+), 15 deletions(-)

Index: linux-pm/kernel/power/process.c
===================================================================
--- linux-pm.orig/kernel/power/process.c
+++ linux-pm/kernel/power/process.c
@@ -27,6 +27,8 @@ unsigned int __read_mostly freeze_timeou

 static int try_to_freeze_tasks(bool user_only)
 {
+    const char *what = user_only ? "user space processes" :
+                    "remaining freezable tasks";
     struct task_struct *g, *p;
     unsigned long end_time;
     unsigned int todo;
@@ -36,6 +38,8 @@ static int try_to_freeze_tasks(bool user
     bool wakeup = false;
     int sleep_usecs = USEC_PER_MSEC;

+    pr_info("Freezing %s\n", what);
+
     start = ktime_get_boottime();

     end_time = jiffies + msecs_to_jiffies(freeze_timeout_msecs);
@@ -82,9 +86,8 @@ static int try_to_freeze_tasks(bool user
     elapsed_msecs = ktime_to_ms(elapsed);

     if (todo) {
-        pr_cont("\n");
-        pr_err("Freezing of tasks %s after %d.%03d seconds "
-               "(%d tasks refusing to freeze, wq_busy=%d):\n",
+        pr_err("Freezing %s %s after %d.%03d seconds "
+               "(%d tasks refusing to freeze, wq_busy=%d):\n", what,
                wakeup ? "aborted" : "failed",
                elapsed_msecs / 1000, elapsed_msecs % 1000,
                todo - wq_busy, wq_busy);
@@ -101,8 +104,8 @@ static int try_to_freeze_tasks(bool user
             read_unlock(&tasklist_lock);
         }
     } else {
-        pr_cont("(elapsed %d.%03d seconds) ", elapsed_msecs / 1000,
-            elapsed_msecs % 1000);
+        pr_info("Freezing %s completed (elapsed %d.%03d seconds)\n",
+            what, elapsed_msecs / 1000, elapsed_msecs % 1000);
     }

     return todo ? -EBUSY : 0;
@@ -130,14 +133,11 @@ int freeze_processes(void)
         static_branch_inc(&freezer_active);

     pm_wakeup_clear(0);
-    pr_info("Freezing user space processes ... ");
     pm_freezing = true;
     error = try_to_freeze_tasks(true);
-    if (!error) {
+    if (!error)
         __usermodehelper_set_disable_depth(UMH_DISABLED);
-        pr_cont("done.");
-    }
-    pr_cont("\n");
+
     BUG_ON(in_atomic());

     /*
@@ -166,14 +166,9 @@ int freeze_kernel_threads(void)
 {
     int error;

-    pr_info("Freezing remaining freezable tasks ... ");
-
     pm_nosig_freezing = true;
     error = try_to_freeze_tasks(false);
-    if (!error)
-        pr_cont("done.");

-    pr_cont("\n");
     BUG_ON(in_atomic());

     if (error)
