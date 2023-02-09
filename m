Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D756691114
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 20:16:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230002AbjBITQv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 14:16:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbjBITQt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 14:16:49 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6478E5DC31;
        Thu,  9 Feb 2023 11:16:45 -0800 (PST)
Date:   Thu, 09 Feb 2023 19:16:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1675970203;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EMfFhGLF4YWoUbRpNumcg9SymF+uDoK+UCqfijLwxQs=;
        b=rdH8grVmRxQqy5WFKFjklX0VoNI2L8ylZqKwweZVBEcxF4wXWsBmMQV+3t/GAV52MS1Ba/
        444WodgRlE3ll6cRQFHvRb+2PY62wCukz12Xveg1fwlbp49LF0ZUA4JNHhwyjjc8cxt/yJ
        pZWoCQyo44ocSfGn6E99n/NDJWVPQmbPQZ2txwgoCeGW1FoN0jWNW3QzfsMJLX/sx8DSpl
        syRkp8Bg2mzRA0zadRUgkvKs+vcf5/QPCdfLQgDWpSZzGnVgewWaauC+GcGZtEtXZQJWEX
        5K+o8m2GmTYPQAcdfI2uaesWP2rAmRD7EmgcMqtHVbDRv8tyxSi4RSBksKzO9Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1675970203;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EMfFhGLF4YWoUbRpNumcg9SymF+uDoK+UCqfijLwxQs=;
        b=EdTO/Z+U2ylnrwa1CzUuKYUqnisZ5unDYdsqmYdzVr9VYNWYZZXr+sq01h5+Ki/qzo9hV4
        o9wOt+da9n3sQ/Dg==
From:   "tip-bot2 for Greg Kroah-Hartman" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] time/debug: Fix memory leak with using debugfs_lookup()
Cc:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230202151214.2306822-1-gregkh@linuxfoundation.org>
References: <20230202151214.2306822-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Message-ID: <167597020257.4906.14385983132728643575.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     5b268d8abaec6cbd4bd70d062e769098d96670aa
Gitweb:        https://git.kernel.org/tip/5b268d8abaec6cbd4bd70d062e769098d96670aa
Author:        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
AuthorDate:    Thu, 02 Feb 2023 16:12:14 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 09 Feb 2023 20:12:27 +01:00

time/debug: Fix memory leak with using debugfs_lookup()

When calling debugfs_lookup() the result must have dput() called on it,
otherwise the memory will leak over time.  To make things simpler, just
call debugfs_lookup_and_remove() instead which handles all of the logic at
once.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20230202151214.2306822-1-gregkh@linuxfoundation.org

---
 kernel/time/test_udelay.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/time/test_udelay.c b/kernel/time/test_udelay.c
index 13b11eb..20d5df6 100644
--- a/kernel/time/test_udelay.c
+++ b/kernel/time/test_udelay.c
@@ -149,7 +149,7 @@ module_init(udelay_test_init);
 static void __exit udelay_test_exit(void)
 {
 	mutex_lock(&udelay_test_lock);
-	debugfs_remove(debugfs_lookup(DEBUGFS_FILENAME, NULL));
+	debugfs_lookup_and_remove(DEBUGFS_FILENAME, NULL);
 	mutex_unlock(&udelay_test_lock);
 }
 
