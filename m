Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F55B5F9784
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 06:56:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231232AbiJJE4L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 00:56:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231199AbiJJE4E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 00:56:04 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CB845208D
        for <linux-kernel@vger.kernel.org>; Sun,  9 Oct 2022 21:56:03 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id b11-20020a170902d50b00b0017828988079so7428173plg.21
        for <linux-kernel@vger.kernel.org>; Sun, 09 Oct 2022 21:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=RxsdOmr/5R6O83izb+Qz14RQm/ox4oRe3Ga9GwIcpbE=;
        b=FkFgzyPbZsQ7hNEXjbL2xdIOWZkuMKYfOCsz8o7Aqg0eNxiBSOaNoOrR3Qf9uL60wM
         VTj6P7p0CFzx5wLDB3obZQ+zs+nrxxyBmcvR4DRDn00o63HqdvGDddgCThc2ABO6jHpw
         cm9uUOYCeB4KowxD+kNC8NY9xxoq25Ui7uTvS4Age3Yh6hkvwWal5xlAgOLCxDVcI4Id
         h9ltXeJuibrk4rUk6alMBIUx5VxBnrZ6OKB0LXzOyCqqd4IusJvjjf93Z8l+66nNTSjz
         PHYdAhYsKdcSUKvRSJx0N22y0DlAlXUJT/57ISO/kCHshWkQIpcznUevOsUJJS4GJR+9
         I6dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RxsdOmr/5R6O83izb+Qz14RQm/ox4oRe3Ga9GwIcpbE=;
        b=By4NxPsvDRr9IOmHm6p74rkeaj61WzI22AQxfkyEjj5946tqWZyqwcCjJSxA/J+A53
         Rlvd0umQuvCtmXf/KmcpaK8lcadhVKjWUmWlW+S4ErizUlhJX3YRROD4CIWBOJ6qOXtf
         ZeTRbSPTF7RBc9kkoPvPPKX9IoOKuvjQ+BbQl78XA8n0tXDrQ2epA+fZM2V/wpKd52Xc
         hIC9Km1HrOdUVs4QiMh8lZyvJHncXD5luirnN0fFglNZ02qugoOYRnOJ1KHaZQ38CGya
         MZnRqJSpRLQRD04MvLcZswxiQZ0L8KpckqHbNdjQAGP2QP6u1maj6GjVrh3CgnSkx+wc
         bRFg==
X-Gm-Message-State: ACrzQf3hDfR+bbtgI8oR0H31A36mzZAtOwdmCDmUv9+900iYyKE8N+Mo
        Emt+fMEBtDCnOOOfTZyiCsPwHZ6ASKe9
X-Google-Smtp-Source: AMsMyM7IS1QJd/ZymReZAITcO7D6DJHSctw2xXHR0bqcwB2i2Av+jyamUKWzh6rkAS6jB/SEyZwKBlS8xhj8
X-Received: from sgzhang.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3d89])
 (user=sgzhang job=sendgmr) by 2002:a17:90a:cd06:b0:203:ae0e:6a21 with SMTP id
 d6-20020a17090acd0600b00203ae0e6a21mr1584146pju.0.1665377762552; Sun, 09 Oct
 2022 21:56:02 -0700 (PDT)
Date:   Mon, 10 Oct 2022 04:55:49 +0000
In-Reply-To: <20221010045549.2221965-1-sgzhang@google.com>
Mime-Version: 1.0
References: <20221010045549.2221965-1-sgzhang@google.com>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
Message-ID: <20221010045549.2221965-4-sgzhang@google.com>
Subject: [PATCH v4 3/3] mtd: mtdoops: panic caused mtdoops to call
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
index 0226b9e9ea8f..2f11585b5613 100644
--- a/drivers/mtd/mtdoops.c
+++ b/drivers/mtd/mtdoops.c
@@ -170,7 +170,7 @@ static void mtdoops_workfunc_erase(struct work_struct *work)
 	mtdoops_erase(cxt);
 }
 
-static void mtdoops_inc_counter(struct mtdoops_context *cxt)
+static void mtdoops_inc_counter(struct mtdoops_context *cxt, int panic)
 {
 	cxt->nextpage++;
 	if (cxt->nextpage >= cxt->oops_pages)
@@ -180,12 +180,20 @@ static void mtdoops_inc_counter(struct mtdoops_context *cxt)
 		cxt->nextcount = 0;
 
 	if (page_is_used(cxt, cxt->nextpage)) {
-		schedule_work(&cxt->work_erase);
-		return;
+		pr_debug("not ready %d, %d (erase %s)\n",
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
+		pr_debug("ready %d, %d (no erase)\n",
+			 cxt->nextpage, cxt->nextcount);
 	}
-
-	pr_debug("ready %d, %d (no erase)\n",
-		 cxt->nextpage, cxt->nextcount);
 }
 
 static void mtdoops_write(struct mtdoops_context *cxt, int panic)
@@ -221,7 +229,7 @@ static void mtdoops_write(struct mtdoops_context *cxt, int panic)
 	mark_page_used(cxt, cxt->nextpage);
 	memset(cxt->oops_buf, 0xff, record_size);
 
-	mtdoops_inc_counter(cxt);
+	mtdoops_inc_counter(cxt, panic);
 out:
 	clear_bit(0, &cxt->oops_buf_busy);
 }
@@ -286,7 +294,7 @@ static void find_next_position(struct mtdoops_context *cxt)
 		cxt->nextcount = maxcount;
 	}
 
-	mtdoops_inc_counter(cxt);
+	mtdoops_inc_counter(cxt, 0);
 }
 
 static void mtdoops_do_dump(struct kmsg_dumper *dumper,
-- 
2.38.0.rc1.362.ged0d419d3c-goog

