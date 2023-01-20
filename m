Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E89C675AE6
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 18:14:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbjATROr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 12:14:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbjATROq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 12:14:46 -0500
Received: from MTA-05-3.privateemail.com (mta-05-3.privateemail.com [68.65.122.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5722794CAA;
        Fri, 20 Jan 2023 09:14:37 -0800 (PST)
Received: from mta-05.privateemail.com (localhost [127.0.0.1])
        by mta-05.privateemail.com (Postfix) with ESMTP id B4AF218000A8;
        Fri, 20 Jan 2023 12:14:36 -0500 (EST)
Received: from bpappas-XPS-13-9310.. (rrcs-24-173-168-34.se.biz.rr.com [24.173.168.34])
        by mta-05.privateemail.com (Postfix) with ESMTPA id 7282A18000A3;
        Fri, 20 Jan 2023 12:14:23 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=pappasbrent.com;
        s=default; t=1674234876;
        bh=XhRnErx/eCRnzYjBxFH5JC5AofWxMframtiYYl67Vks=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BMEAomSdT7IP091Ak8NqDlzZL4cUvOdzcKIrGF1w3PUKxsHahTekoYTWUZztJkj4Y
         +1v85fApZ+vUt5OPSDguDw1cZm3w62vwz30tC4jGnyLEnMja/caiVcWQGPVUSHdffi
         ByrvcaAT5vbDhZILlNzh3Zr2xAP2l+nCClxB/19IcNycm5svsUzbv7KGkh4e1qzpx+
         0vy00Qixx3A+/L52+4oPeUMe70q3c1nbyAwE6Jn83cCUuEDIuFPXcjDdmkYqKchUVm
         jjauVWSEnsCA7zbSwjrewdIEv85SYotjpq2kspqVc3a6fvj0DoVCc3hN1dyyY9M8Vu
         4et2tH1F9ltJA==
From:   Brent Pappas <bpappas@pappasbrent.com>
To:     error27@gmail.com
Cc:     andy.shevchenko@gmail.com, andy@kernel.org,
        bpappas@pappasbrent.com, colin.i.king@gmail.com,
        gregkh@linuxfoundation.org, hdegoede@redhat.com,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-staging@lists.linux.dev, mchehab@kernel.org,
        sakari.ailus@linux.intel.com
Subject: [PATCH v3] media: atomisp: pci: sh_css: Inline single invocation of macro STATS_ENABLED()
Date:   Fri, 20 Jan 2023 12:14:08 -0500
Message-Id: <20230120171408.16099-1-bpappas@pappasbrent.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <Y8lZreSphK6DIkJg@kadam>
References: <Y8lZreSphK6DIkJg@kadam>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Inline the single invocation of the macro STATS_ENABLED().
The macro abstraction is not necessary because the logic behind it is only
used once.

Signed-off-by: Brent Pappas <bpappas@pappasbrent.com>
---
Changelog:
V1 -> V2: Inline macro instead of replacing it with a function.

V2 -> V3: Remove unnecessary check that stage is non-null.

 drivers/staging/media/atomisp/pci/sh_css.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/media/atomisp/pci/sh_css.c b/drivers/staging/media/atomisp/pci/sh_css.c
index 726cb7aa4ecd..93789500416f 100644
--- a/drivers/staging/media/atomisp/pci/sh_css.c
+++ b/drivers/staging/media/atomisp/pci/sh_css.c
@@ -97,9 +97,6 @@
  */
 #define JPEG_BYTES (16 * 1024 * 1024)
 
-#define STATS_ENABLED(stage) (stage && stage->binary && stage->binary->info && \
-	(stage->binary->info->sp.enable.s3a || stage->binary->info->sp.enable.dis))
-
 struct sh_css my_css;
 
 int  __printf(1, 0) (*sh_css_printf)(const char *fmt, va_list args) = NULL;
@@ -3743,7 +3740,9 @@ ia_css_pipe_enqueue_buffer(struct ia_css_pipe *pipe,
 			 * The SP will read the params after it got
 			 * empty 3a and dis
 			 */
-			if (STATS_ENABLED(stage)) {
+			if (stage->binary && stage->binary->info &&
+			    (stage->binary->info->sp.enable.s3a ||
+			     stage->binary->info->sp.enable.dis)) {
 				/* there is a stage that needs it */
 				return_err = ia_css_bufq_enqueue_buffer(thread_id,
 									queue_id,
-- 
2.34.1

