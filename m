Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93CF9718089
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 14:56:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236121AbjEaM4i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 08:56:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235040AbjEaM4c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 08:56:32 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E55CC1B7;
        Wed, 31 May 2023 05:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=/mNIMohr1uFpuUxrcr17WPn+hv1s0+EROxi7hXvr1PA=; b=u866lGd1Vz7A5VVdyUkbO2/gwY
        20+X8LAEch7ckqxwPd5twS1ieR8YO9Pyl8P0njz7Koi7E19RrjR7KdpYcR2VbOsZnJkMo7uc1zi8Y
        ehBF6YjjGmfvesKB0EFJs3dRbXGFQO3umTFm7dOgfL3O7S9ONK5X2xB5fHgDOdFxMa7bAITF/SaxW
        H70Y9lzqVxCdLcINYJtFs9PzXJX277XJlAGwf/ATadOumBCdPmN5ZtWQv5yO3E2kogKMJjOOCA93W
        9+nH+RyxDLMjHiyMuGQmeKbWyqvh2pFsqDeQ/iEyG7iZKo7XPhcZrSCVYBroFw22V3mKj+QhdIFXn
        I3Gu4kNg==;
Received: from [2001:4bb8:182:6d06:2e49:a56:513a:92ee] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q4LMk-00HQwo-2V;
        Wed, 31 May 2023 12:55:51 +0000
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
Subject: [PATCH 02/24] PM: hibernate: factor out a helper to find the resume device
Date:   Wed, 31 May 2023 14:55:13 +0200
Message-Id: <20230531125535.676098-3-hch@lst.de>
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

Split the logic to find the resume device out software_resume and into
a separate helper to start unwindig the convoluted goto logic.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Acked-by: Rafael J. Wysocki <rafael@kernel.org>
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

