Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (unknown [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5D615B4A7F
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Sep 2022 00:32:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbiIJW1t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Sep 2022 18:27:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbiIJW1i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Sep 2022 18:27:38 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9323738474
        for <linux-kernel@vger.kernel.org>; Sat, 10 Sep 2022 15:27:37 -0700 (PDT)
Message-ID: <20220910222300.466273303@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1662848855;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=E5VNsdhocstLmuIwTiCMPIibe4zDdVnAf/ePac5FTrs=;
        b=Zy3HnUi2VBS5ut9uhR/yxiVuE5M61YjpLA/xPSpsVmYTNqV9p1HHw6cB+/BmwvbvS24vk9
        IXDNJmqT1Xe0owRlb//4pc09RTWehYtFXH1BrH2NPDemslzdvI6AeOTfzT1MgCokpYDKXu
        ijPjGyH+G2WfmZ7QX2ggS/onqNdrBwKvMxjI36H1TZNVjj6UOIkpHSBRhpN5AR5XzAiOBi
        TqCMSn9Qh4VYejlys4zK5yhUO5ia1wMOUTFQSWtvkmN0pJVBxGEEYfXFbEBOiT01lJMIoN
        ZdMFegZcBoiBeIbeKQ8qllxcTH6MuyVadZ9fcei/utfLciJhmnFdGH6+4cCKtQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1662848855;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=E5VNsdhocstLmuIwTiCMPIibe4zDdVnAf/ePac5FTrs=;
        b=FW65dlnuCZ6asy8+cb0W/jTJqUbzHFWiipkPt5DjzbMJfAqlNSVG5p7HeFUfebCJj9UYNm
        VrtaqLn3el0Lq/CQ==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     John Ogness <john.ogness@linutronix.de>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Helge Deller <deller@gmx.de>,
        Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>
Subject: [patch RFC 02/29] printk: Declare log_wait properly
References: <20220910221947.171557773@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Sun, 11 Sep 2022 00:27:34 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kernel/printk/printk.c:365:1: warning: symbol 'log_wait' was not declared. Should it be static?

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 fs/proc/kmsg.c         |    2 --
 include/linux/syslog.h |    3 +++
 2 files changed, 3 insertions(+), 2 deletions(-)

--- a/fs/proc/kmsg.c
+++ b/fs/proc/kmsg.c
@@ -17,8 +17,6 @@
 
 #include <asm/io.h>
 
-extern wait_queue_head_t log_wait;
-
 static int kmsg_open(struct inode * inode, struct file * file)
 {
 	return do_syslog(SYSLOG_ACTION_OPEN, NULL, 0, SYSLOG_FROM_PROC);
--- a/include/linux/syslog.h
+++ b/include/linux/syslog.h
@@ -8,6 +8,8 @@
 #ifndef _LINUX_SYSLOG_H
 #define _LINUX_SYSLOG_H
 
+#include <linux/wait.h>
+
 /* Close the log.  Currently a NOP. */
 #define SYSLOG_ACTION_CLOSE          0
 /* Open the log. Currently a NOP. */
@@ -35,5 +37,6 @@
 #define SYSLOG_FROM_PROC             1
 
 int do_syslog(int type, char __user *buf, int count, int source);
+extern wait_queue_head_t log_wait;
 
 #endif /* _LINUX_SYSLOG_H */

