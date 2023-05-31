Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5748C71808C
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 14:56:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236146AbjEaM4p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 08:56:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236073AbjEaM4d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 08:56:33 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42190129;
        Wed, 31 May 2023 05:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=AmHMaGciyZumE4aVkyv6UwavmqIcFHl8yaRqRVfDzhM=; b=NsM8t9GA8hmexagtW2AzKtnA0e
        Z+UPA1K2V+XTF4g2vk5DkSw6j7IEsplDglWCsKaGG8ztKFFfTbdJQ5mnROhRbT+ni9eCsYXI18cOY
        WUvCo0K/lGrJR07dM+ilbcQAw/l5CbITDmKpQw5NI/bQLMrXYhpAmXF8U861hgVn40la7JDceSpQ+
        LlHC9/l5g2wqqOPM0spQIyZ/Sri6AzoZyWG5VkvLrp54M+fM81W+N8ZZ6zi9hY1ro0srtQHX9uezm
        lsN2V15kqrmCN9iAYq7Tp1WgaK0ePOQd7Lp4+KMwvf1qXOodZoRJpp58c9aF/7iBRaH84FAxPPZNE
        NMnYPv6Q==;
Received: from [2001:4bb8:182:6d06:2e49:a56:513a:92ee] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q4LMq-00HQy6-2x;
        Wed, 31 May 2023 12:55:57 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Mike Snitzer <snitzer@kernel.org>,
        Joern Engel <joern@lazybastard.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Pavel Machek <pavel@ucw.cz>,
        Loic Poulain <loic.poulain@linaro.org>, dm-devel@redhat.com,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-pm@vger.kernel.org
Subject: [PATCH 03/24] PM: hibernate: remove the global snapshot_test variable
Date:   Wed, 31 May 2023 14:55:14 +0200
Message-Id: <20230531125535.676098-4-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230531125535.676098-1-hch@lst.de>
References: <20230531125535.676098-1-hch@lst.de>
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

Passing call dependent variable in global variables is a huge
antipattern.  Fix it up.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Acked-by: Rafael J. Wysocki <rafael@kernel.org>
---
 kernel/power/hibernate.c | 17 ++++++-----------
 kernel/power/power.h     |  3 +--
 kernel/power/swap.c      |  2 +-
 3 files changed, 8 insertions(+), 14 deletions(-)

diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
index 07279506366255..78696aa04f5ca3 100644
--- a/kernel/power/hibernate.c
+++ b/kernel/power/hibernate.c
@@ -64,7 +64,6 @@ enum {
 static int hibernation_mode = HIBERNATION_SHUTDOWN;
 
 bool freezer_test_done;
-bool snapshot_test;
 
 static const struct platform_hibernation_ops *hibernation_ops;
 
@@ -684,7 +683,7 @@ static void power_down(void)
 		cpu_relax();
 }
 
-static int load_image_and_restore(void)
+static int load_image_and_restore(bool snapshot_test)
 {
 	int error;
 	unsigned int flags;
@@ -721,6 +720,7 @@ static int load_image_and_restore(void)
  */
 int hibernate(void)
 {
+	bool snapshot_test = false;
 	unsigned int sleep_flags;
 	int error;
 
@@ -748,9 +748,6 @@ int hibernate(void)
 	if (error)
 		goto Exit;
 
-	/* protected by system_transition_mutex */
-	snapshot_test = false;
-
 	lock_device_hotplug();
 	/* Allocate memory management structures */
 	error = create_basic_memory_bitmaps();
@@ -792,9 +789,9 @@ int hibernate(void)
 	unlock_device_hotplug();
 	if (snapshot_test) {
 		pm_pr_dbg("Checking hibernation image\n");
-		error = swsusp_check();
+		error = swsusp_check(snapshot_test);
 		if (!error)
-			error = load_image_and_restore();
+			error = load_image_and_restore(snapshot_test);
 	}
 	thaw_processes();
 
@@ -982,8 +979,6 @@ static int software_resume(void)
 	 */
 	mutex_lock_nested(&system_transition_mutex, SINGLE_DEPTH_NESTING);
 
-	snapshot_test = false;
-
 	if (!swsusp_resume_device) {
 		error = find_resume_device();
 		if (error)
@@ -994,7 +989,7 @@ static int software_resume(void)
 		MAJOR(swsusp_resume_device), MINOR(swsusp_resume_device));
 
 	pm_pr_dbg("Looking for hibernation image.\n");
-	error = swsusp_check();
+	error = swsusp_check(false);
 	if (error)
 		goto Unlock;
 
@@ -1022,7 +1017,7 @@ static int software_resume(void)
 		goto Close_Finish;
 	}
 
-	error = load_image_and_restore();
+	error = load_image_and_restore(false);
 	thaw_processes();
  Finish:
 	pm_notifier_call_chain(PM_POST_RESTORE);
diff --git a/kernel/power/power.h b/kernel/power/power.h
index b83c8d5e188dec..978189fcafd124 100644
--- a/kernel/power/power.h
+++ b/kernel/power/power.h
@@ -59,7 +59,6 @@ asmlinkage int swsusp_save(void);
 
 /* kernel/power/hibernate.c */
 extern bool freezer_test_done;
-extern bool snapshot_test;
 
 extern int hibernation_snapshot(int platform_mode);
 extern int hibernation_restore(int platform_mode);
@@ -174,7 +173,7 @@ extern int swsusp_swap_in_use(void);
 #define SF_HW_SIG		8
 
 /* kernel/power/hibernate.c */
-extern int swsusp_check(void);
+int swsusp_check(bool snapshot_test);
 extern void swsusp_free(void);
 extern int swsusp_read(unsigned int *flags_p);
 extern int swsusp_write(unsigned int flags);
diff --git a/kernel/power/swap.c b/kernel/power/swap.c
index 92e41ed292ada8..efed11568bfc72 100644
--- a/kernel/power/swap.c
+++ b/kernel/power/swap.c
@@ -1514,7 +1514,7 @@ int swsusp_read(unsigned int *flags_p)
  *      swsusp_check - Check for swsusp signature in the resume device
  */
 
-int swsusp_check(void)
+int swsusp_check(bool snapshot_test)
 {
 	int error;
 	void *holder;
-- 
2.39.2

