Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D28675F745E
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 08:51:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbiJGGv0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 02:51:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbiJGGvU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 02:51:20 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 420E41176F6
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 23:51:18 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id pc10-20020a17090b3b8a00b00202be8d81d2so4313364pjb.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Oct 2022 23:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=O8RGq8MFx6yg4rvWL2LsrEdijzeVAuwua99jyz3WuY0=;
        b=F6dW5mLyZy3KMwXGdnG0uw0vgxq5BEd+oBP42as46H5qvUK9UUtnPoEFvqRjcLp2it
         3rrZO+tOIKDyRV9cO0K8eFfD5qE0aq8/pOQ1qMjNT2kuDlzCxmiyNiNu8smEUUxWgXir
         qvanrdH44yXvkeRzWz2qggoyZsuAiESRGspyhTjmq550BG4iXCYue3thQoCeKJtWKbIn
         dnbBOuqYHUOo6fDvehxnSRx67QyOOhZO1IO0evxROS53XAX9T5qFE5eBmA1HILs/WX54
         xB6v9SfRbaoumFZK56o7t8VI47GxqtaTq9n1KZwEY5Ykc/WSe0t3090uQjFbndtU1jh/
         0d8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O8RGq8MFx6yg4rvWL2LsrEdijzeVAuwua99jyz3WuY0=;
        b=GBPhsOw+KxZZW2e5iLuGcxnuFSk9bWLaTXsLxcTZYbrswVFzAnOukd5qB1rGJVj8Ku
         g70aYpGsqG6/q2J9yBNJxSntVHK/UwlwcXVt/oCsdOQeeWD1TaDP1DH8MPXeeL2zzIvo
         5Qmvv4MV1ZEjr+3mQg/lZ6GM18BNOqOSC+fSL3fxADPO9rchjtH9z/EyvuK/T5ybAyXZ
         VQU5GaafRdY8T+PPbTAdZGtBaf+ki9GqALojm5xXFI9+bGRKjmkQrORS4ib+NW58yOq8
         Ibog4/SudmKwKLnsg6iOn5CLIvWeXE6I2Pnwb8F1fiY2aCa/ctEcPqvU5BS6nVM0cPQz
         WF0Q==
X-Gm-Message-State: ACrzQf3MpsFcvWKfDl9nEtYpWxQbbXDjR5ftIU6wjV6iT74TigF7rZ5o
        OyFoUvke+elHVVAeGX2jMTGdZDMUeIUZ
X-Google-Smtp-Source: AMsMyM6SBWhzRurstP/chVETSQSz8yWa44PhYa3t6INGan3rp4//jh+O5/UVex4A60beBfyt1HRxiZPKB3n9
X-Received: from sgzhang.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3d89])
 (user=sgzhang job=sendgmr) by 2002:a05:6a00:134d:b0:545:4d30:eebf with SMTP
 id k13-20020a056a00134d00b005454d30eebfmr3430107pfu.32.1665125459940; Thu, 06
 Oct 2022 23:50:59 -0700 (PDT)
Date:   Fri,  7 Oct 2022 06:50:42 +0000
In-Reply-To: <20221007065042.700761-1-sgzhang@google.com>
Mime-Version: 1.0
References: <20221007065042.700761-1-sgzhang@google.com>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
Message-ID: <20221007065042.700761-4-sgzhang@google.com>
Subject: [PATCH v2 3/3] mtd: mtdoops: panic caused mtdoops to call
 mtdoops_erase function immediately
From:   Ray Zhang <sgzhang@google.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Ray Zhang <sgzhang@google.com>
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

The panic function disables the local interrupts, preemption, and all
other processors. When the invoked mtdoops needs to erase a used page,
calling schedule_work() to do it will not work. Instead, just call
mtdoops_erase function immediately.

Tested:
~# echo c > /proc/sysrq-trigger
[  171.654759] sysrq: Trigger a crash
[  171.658325] Kernel panic - not syncing: sysrq triggered crash
......
[  172.406423] mtdoops: not ready 34, 35 (erase immediately)
[  172.432285] mtdoops: ready 34, 35
[  172.435633] Rebooting in 10 seconds..

Signed-off-by: Ray Zhang <sgzhang@google.com>
---
 drivers/mtd/mtdoops.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/drivers/mtd/mtdoops.c b/drivers/mtd/mtdoops.c
index eca48dff9b53..eccb7dea892f 100644
--- a/drivers/mtd/mtdoops.c
+++ b/drivers/mtd/mtdoops.c
@@ -168,7 +168,7 @@ static void mtdoops_workfunc_erase(struct work_struct *work)
 	mtdoops_erase(cxt);
 }
 
-static void mtdoops_inc_counter(struct mtdoops_context *cxt)
+static void mtdoops_inc_counter(struct mtdoops_context *cxt, int panic)
 {
 	cxt->nextpage++;
 	if (cxt->nextpage >= cxt->oops_pages)
@@ -178,12 +178,20 @@ static void mtdoops_inc_counter(struct mtdoops_context *cxt)
 		cxt->nextcount = 0;
 
 	if (page_is_used(cxt, cxt->nextpage)) {
-		schedule_work(&cxt->work_erase);
-		return;
+		pr_debug("mtdoops: not ready %d, %d (erase %s)\n",
+			 cxt->nextpage, cxt->nextcount,
+			 panic ? "immediately" : "scheduled");
+		if (panic) {
+			/* In case of panic, erase immediately */
+			mtdoops_erase(cxt);
+		} else {
+			/* Otherwise, schedule work to erase it "nicely" */
+			schedule_work(&cxt->work_erase);
+		}
+	} else {
+		pr_debug("mtdoops: ready %d, %d (no erase)\n",
+			 cxt->nextpage, cxt->nextcount);
 	}
-
-	pr_debug("mtdoops: ready %d, %d (no erase)\n",
-		 cxt->nextpage, cxt->nextcount);
 }
 
 static void mtdoops_write(struct mtdoops_context *cxt, int panic)
@@ -219,7 +227,7 @@ static void mtdoops_write(struct mtdoops_context *cxt, int panic)
 	mark_page_used(cxt, cxt->nextpage);
 	memset(cxt->oops_buf, 0xff, record_size);
 
-	mtdoops_inc_counter(cxt);
+	mtdoops_inc_counter(cxt, panic);
 out:
 	clear_bit(0, &cxt->oops_buf_busy);
 }
@@ -284,7 +292,7 @@ static void find_next_position(struct mtdoops_context *cxt)
 		cxt->nextcount = maxcount;
 	}
 
-	mtdoops_inc_counter(cxt);
+	mtdoops_inc_counter(cxt, 0);
 }
 
 static void mtdoops_do_dump(struct kmsg_dumper *dumper,
-- 
2.38.0.rc1.362.ged0d419d3c-goog

