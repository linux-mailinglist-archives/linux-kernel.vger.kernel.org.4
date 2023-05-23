Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3247B70D598
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 09:46:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235597AbjEWHqR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 03:46:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229836AbjEWHqB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 03:46:01 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1093F95;
        Tue, 23 May 2023 00:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=S+6LOPW32mFB65whrqol+dqk4zz+aHIEwnhIsYLGKVw=; b=oYR3R4AmapKEfndwxtDSH8cIdl
        7Vb/uiszNOqzWMoQCuXSkylmgqrgZ0XQ4jpT9VN7brX+jJJ8mOn/Z+vOyl8Y6gh67gY810V8WPzYT
        XINnJ01yFpl2mmC9OPXK80x3++NhDof0RJnlWmgaYri5l2uUbS+x1XVHFnkeykrFQk/EKT30r7ess
        HbPAKwPkPFEWv0fB2OFjJFbIOQHvDvbvaf35wpw1JndNWqM8jrJwY54fb3BZTe6eLUgtPjoXoqUPj
        WAYoZPhJPTuMRRRe2LK08GP7+5Z1PA1n288tVA6A+A6X3S2orje6oJ2qPQHDttb6ZN2/k/FLawjVJ
        WtzHHAMA==;
Received: from [2001:4bb8:188:23b2:6ade:85c9:530f:6eb0] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q1MiF-009GUU-0j;
        Tue, 23 May 2023 07:45:43 +0000
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
Subject: [PATCH 02/24] PM: hibernate: factor out a helper to find the resume device
Date:   Tue, 23 May 2023 09:45:13 +0200
Message-Id: <20230523074535.249802-3-hch@lst.de>
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

Split the logic to find the resume device out software_resume and into
a separate helper to start unwindig the convoluted goto logic.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 kernel/power/hibernate.c | 72 +++++++++++++++++++++-------------------
 1 file changed, 37 insertions(+), 35 deletions(-)

diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
index 30d1274f03f625..07279506366255 100644
--- a/kernel/power/hibernate.c
+++ b/kernel/power/hibernate.c
@@ -910,6 +910,41 @@ int hibernate_quiet_exec(int (*func)(void *data), void *data)
 }
 EXPORT_SYMBOL_GPL(hibernate_quiet_exec);
 
+static int find_resume_device(void)
+{
+	if (!strlen(resume_file))
+		return -ENOENT;
+
+	pm_pr_dbg("Checking hibernation image partition %s\n", resume_file);
+
+	if (resume_delay) {
+		pr_info("Waiting %dsec before reading resume device ...\n",
+			resume_delay);
+		ssleep(resume_delay);
+	}
+
+	/* Check if the device is there */
+	swsusp_resume_device = name_to_dev_t(resume_file);
+	if (swsusp_resume_device)
+		return 0;
+
+	/*
+	 * Some device discovery might still be in progress; we need to wait for
+	 * this to finish.
+	 */
+	wait_for_device_probe();
+	if (resume_wait) {
+		while (!(swsusp_resume_device = name_to_dev_t(resume_file)))
+			msleep(10);
+		async_synchronize_full();
+	}
+
+	swsusp_resume_device = name_to_dev_t(resume_file);
+	if (!swsusp_resume_device)
+		return -ENODEV;
+	return 0;
+}
+
 /**
  * software_resume - Resume from a saved hibernation image.
  *
@@ -949,45 +984,12 @@ static int software_resume(void)
 
 	snapshot_test = false;
 
-	if (swsusp_resume_device)
-		goto Check_image;
-
-	if (!strlen(resume_file)) {
-		error = -ENOENT;
-		goto Unlock;
-	}
-
-	pm_pr_dbg("Checking hibernation image partition %s\n", resume_file);
-
-	if (resume_delay) {
-		pr_info("Waiting %dsec before reading resume device ...\n",
-			resume_delay);
-		ssleep(resume_delay);
-	}
-
-	/* Check if the device is there */
-	swsusp_resume_device = name_to_dev_t(resume_file);
 	if (!swsusp_resume_device) {
-		/*
-		 * Some device discovery might still be in progress; we need
-		 * to wait for this to finish.
-		 */
-		wait_for_device_probe();
-
-		if (resume_wait) {
-			while ((swsusp_resume_device = name_to_dev_t(resume_file)) == 0)
-				msleep(10);
-			async_synchronize_full();
-		}
-
-		swsusp_resume_device = name_to_dev_t(resume_file);
-		if (!swsusp_resume_device) {
-			error = -ENODEV;
+		error = find_resume_device();
+		if (error)
 			goto Unlock;
-		}
 	}
 
- Check_image:
 	pm_pr_dbg("Hibernation image partition %d:%d present\n",
 		MAJOR(swsusp_resume_device), MINOR(swsusp_resume_device));
 
-- 
2.39.2

