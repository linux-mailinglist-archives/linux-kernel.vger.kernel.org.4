Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EE8C70D5A7
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 09:46:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235702AbjEWHqb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 03:46:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235164AbjEWHqD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 03:46:03 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99FF6118;
        Tue, 23 May 2023 00:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=jZRF33U9/i0WwWhIXhCPDfpLuiH0EpaeKjfubU+/NSk=; b=dkBi+PBtwIHBctSBmpUW7XDd+E
        SZnvGvAWk+dfSf4TqHZf6neGTK+SWpj/1rwAZ/uVDABZ51wxkIIOCagDjD7Wk2mN57Jd6czkFJczK
        jI9At/MpPQIaTOhOp6y6bbjvNTtiOJw+hFlzMMOF5eXAqSCdw3yBhVvEiBI/jnSvSSrUlCvSJdU2O
        WD8XEvIPyY+Er3vLaIcd++xXWU5fPpKpaFpEwJIuNxZRH6qkZeLIh5V2xdgF0M36L6i6mcZrFzNrh
        huurPNkzH3UiIUIgv5RRefgXFJx8OJ6RYFQA+otrqgq7EUuMpCkgy/iIRwqwcVZ96KqY9LFT1AMzO
        Jr7ztCNQ==;
Received: from [2001:4bb8:188:23b2:6ade:85c9:530f:6eb0] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q1MiK-009GWl-20;
        Tue, 23 May 2023 07:45:49 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Mike Snitzer <snitzer@kernel.org>,
        Joern Engel <joern@lazybastard.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Pavel Machek <pavel@ucw.cz>, dm-devel@redhat.com,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-pm@vger.kernel.org
Subject: [PATCH 04/24] PM: hibernate: move finding the resume device out of software_resume
Date:   Tue, 23 May 2023 09:45:15 +0200
Message-Id: <20230523074535.249802-5-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230523074535.249802-1-hch@lst.de>
References: <20230523074535.249802-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

software_resume can be called either from an init call in the boot code,
or from sysfs once the system has finished booting, and the two
invocation methods this can't race with each other.

For the latter case we did just parse the suspend device manually, while
the former might not have one.  Split software_resume so that the search
only happens for the boot case, which also means the special lockdep
nesting annotation can go away as the system transition mutex can be
taken a little later and doesn't have the sysfs locking nest inside it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 kernel/power/hibernate.c | 80 ++++++++++++++++++++--------------------
 1 file changed, 39 insertions(+), 41 deletions(-)

diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
index 78696aa04f5ca3..45e24b02cd50b6 100644
--- a/kernel/power/hibernate.c
+++ b/kernel/power/hibernate.c
@@ -907,7 +907,7 @@ int hibernate_quiet_exec(int (*func)(void *data), void *data)
 }
 EXPORT_SYMBOL_GPL(hibernate_quiet_exec);
 
-static int find_resume_device(void)
+static int __init find_resume_device(void)
 {
 	if (!strlen(resume_file))
 		return -ENOENT;
@@ -942,53 +942,16 @@ static int find_resume_device(void)
 	return 0;
 }
 
-/**
- * software_resume - Resume from a saved hibernation image.
- *
- * This routine is called as a late initcall, when all devices have been
- * discovered and initialized already.
- *
- * The image reading code is called to see if there is a hibernation image
- * available for reading.  If that is the case, devices are quiesced and the
- * contents of memory is restored from the saved image.
- *
- * If this is successful, control reappears in the restored target kernel in
- * hibernation_snapshot() which returns to hibernate().  Otherwise, the routine
- * attempts to recover gracefully and make the kernel return to the normal mode
- * of operation.
- */
 static int software_resume(void)
 {
 	int error;
 
-	/*
-	 * If the user said "noresume".. bail out early.
-	 */
-	if (noresume || !hibernation_available())
-		return 0;
-
-	/*
-	 * name_to_dev_t() below takes a sysfs buffer mutex when sysfs
-	 * is configured into the kernel. Since the regular hibernate
-	 * trigger path is via sysfs which takes a buffer mutex before
-	 * calling hibernate functions (which take system_transition_mutex)
-	 * this can cause lockdep to complain about a possible ABBA deadlock
-	 * which cannot happen since we're in the boot code here and
-	 * sysfs can't be invoked yet. Therefore, we use a subclass
-	 * here to avoid lockdep complaining.
-	 */
-	mutex_lock_nested(&system_transition_mutex, SINGLE_DEPTH_NESTING);
-
-	if (!swsusp_resume_device) {
-		error = find_resume_device();
-		if (error)
-			goto Unlock;
-	}
-
 	pm_pr_dbg("Hibernation image partition %d:%d present\n",
 		MAJOR(swsusp_resume_device), MINOR(swsusp_resume_device));
 
 	pm_pr_dbg("Looking for hibernation image.\n");
+
+	mutex_lock(&system_transition_mutex);
 	error = swsusp_check(false);
 	if (error)
 		goto Unlock;
@@ -1035,7 +998,39 @@ static int software_resume(void)
 	goto Finish;
 }
 
-late_initcall_sync(software_resume);
+/**
+ * software_resume_initcall - Resume from a saved hibernation image.
+ *
+ * This routine is called as a late initcall, when all devices have been
+ * discovered and initialized already.
+ *
+ * The image reading code is called to see if there is a hibernation image
+ * available for reading.  If that is the case, devices are quiesced and the
+ * contents of memory is restored from the saved image.
+ *
+ * If this is successful, control reappears in the restored target kernel in
+ * hibernation_snapshot() which returns to hibernate().  Otherwise, the routine
+ * attempts to recover gracefully and make the kernel return to the normal mode
+ * of operation.
+ */
+static int __init software_resume_initcall(void)
+{
+	/*
+	 * If the user said "noresume".. bail out early.
+	 */
+	if (noresume || !hibernation_available())
+		return 0;
+
+	if (!swsusp_resume_device) {
+		int error = find_resume_device();
+
+		if (error)
+			return error;
+	}
+
+	return software_resume();
+}
+late_initcall_sync(software_resume_initcall);
 
 
 static const char * const hibernation_modes[] = {
@@ -1176,6 +1171,9 @@ static ssize_t resume_store(struct kobject *kobj, struct kobj_attribute *attr,
 	char *name;
 	dev_t res;
 
+	if (!hibernation_available())
+		return 0;
+
 	if (len && buf[len-1] == '\n')
 		len--;
 	name = kstrndup(buf, len, GFP_KERNEL);
-- 
2.39.2

