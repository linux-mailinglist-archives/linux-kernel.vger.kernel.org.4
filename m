Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FBDD673A9B
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 14:43:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231177AbjASNnF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 08:43:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230462AbjASNnB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 08:43:01 -0500
Received: from h5.fbrelay.privateemail.com (h5.fbrelay.privateemail.com [162.0.218.228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E55287E6A6;
        Thu, 19 Jan 2023 05:42:56 -0800 (PST)
Received: from MTA-13-3.privateemail.com (mta-13-1.privateemail.com [198.54.122.107])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by h5.fbrelay.privateemail.com (Postfix) with ESMTPS id 4BCC560540;
        Thu, 19 Jan 2023 13:42:55 +0000 (UTC)
Received: from mta-13.privateemail.com (localhost [127.0.0.1])
        by mta-13.privateemail.com (Postfix) with ESMTP id 9A43B18000B2;
        Thu, 19 Jan 2023 08:42:53 -0500 (EST)
Received: from bpappas-XPS-13-9310.ucf.edu (050-088-208-136.res.spectrum.com [50.88.208.136])
        by mta-13.privateemail.com (Postfix) with ESMTPA id 42E3B18000AE;
        Thu, 19 Jan 2023 08:42:42 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=pappasbrent.com;
        s=default; t=1674135773;
        bh=OqhTI0JnyhpAPSkx4ylvuoAQKclxNMjvVyiT/4YlsiU=;
        h=From:To:Cc:Subject:Date:From;
        b=H4A37OHivaNSB21JWpSLdSsyRSBe8WXbFevwV/zw+NQ2h3H+AkvcOlcS/n8q0r7xv
         bf4fFWy3/SLk0qYkh82gwPLIdNTbGA/YRgT+9j2LEvCm56+Dc9pSEjFEmbPtqzpa7i
         T6pO3o2nkmyK7fZROIaDbYuRvlfoN955POEKebMaxlO+5qPL00uy/WpdufVCHm2vr2
         daYDx6pvxg6GHxoxpKIexLkdWrakKaVg8paxQHD7pwgU3L9KHziljC8NP78/c0auF/
         Ih5kKBC5UWYP8VJThOY90sCRThE4fm/dAAYnHKQy7LATR/4CCvvi9+mxxVI5Ns++ny
         ah6iaCfoblinw==
From:   Brent Pappas <bpappas@pappasbrent.com>
To:     hdegoede@redhat.com
Cc:     mchehab@kernel.org, sakari.ailus@linux.intel.com,
        gregkh@linuxfoundation.org, andy@kernel.org,
        colin.i.king@gmail.com, linux-media@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Brent Pappas <bpappas@pappasbrent.com>
Subject: [PATCH] media: atomisp: pci: sh_css: Replace macro STATS_ENABLED() with function
Date:   Thu, 19 Jan 2023 08:42:18 -0500
Message-Id: <20230119134218.12280-1-bpappas@pappasbrent.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace the macro STATS_ENABLED() with a static function to conform to
Linux coding style standards.

Signed-off-by: Brent Pappas <bpappas@pappasbrent.com>
---
 drivers/staging/media/atomisp/pci/sh_css.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/media/atomisp/pci/sh_css.c b/drivers/staging/media/atomisp/pci/sh_css.c
index 726cb7aa4ecd..753b3e0fcb07 100644
--- a/drivers/staging/media/atomisp/pci/sh_css.c
+++ b/drivers/staging/media/atomisp/pci/sh_css.c
@@ -97,8 +97,12 @@
  */
 #define JPEG_BYTES (16 * 1024 * 1024)
 
-#define STATS_ENABLED(stage) (stage && stage->binary && stage->binary->info && \
-	(stage->binary->info->sp.enable.s3a || stage->binary->info->sp.enable.dis))
+static bool stats_enabled(struct ia_css_pipeline_stage *stage)
+{
+	return stage && stage->binary && stage->binary->info &&
+	       (stage->binary->info->sp.enable.s3a ||
+		stage->binary->info->sp.enable.dis);
+}
 
 struct sh_css my_css;
 
@@ -3743,7 +3747,7 @@ ia_css_pipe_enqueue_buffer(struct ia_css_pipe *pipe,
 			 * The SP will read the params after it got
 			 * empty 3a and dis
 			 */
-			if (STATS_ENABLED(stage)) {
+			if (stats_enabled(stage)) {
 				/* there is a stage that needs it */
 				return_err = ia_css_bufq_enqueue_buffer(thread_id,
 									queue_id,
-- 
2.34.1

