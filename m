Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 486CC6CF463
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 22:21:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbjC2UVz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 16:21:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjC2UVx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 16:21:53 -0400
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 574392D54;
        Wed, 29 Mar 2023 13:21:52 -0700 (PDT)
Received: by mail-pj1-f52.google.com with SMTP id f6-20020a17090ac28600b0023b9bf9eb63so17409725pjt.5;
        Wed, 29 Mar 2023 13:21:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680121312;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T5NQnbIOswA6Ti0U79v9z7Dy9nEdRdSuCh18z6XZsC8=;
        b=pPS8hC+zR70gsdzLstt6kz2iZPgExEdSIHSuGI/T+CKJ8aFQ2aLP+W8SlkR9j/7MsW
         SxDu6uyGVFqPbg7+BQdBCouIBC8b3S/tlUz2W+se+BYuwaYggMeI2XBoKrxwmmrixgQ/
         ZzJmHOKKBE3rfhC9NPqDqd3wtQEVzsZrSShc7fpXDpC81mvxy5WS3CLoIFjeJTYHHngs
         2pwhFIsySbiZsQA0QGJuMWmELszY32ktpMGzKQoghMnEbwYJQMymYKQ9RFcj8rSqNnJH
         KRPslpzBmwj1OqXB4gls7EXE0j0Xgr2rwCHjygn0bQT6n2S6wkzNrogMN13JF2BUR680
         gMBw==
X-Gm-Message-State: AAQBX9cd1tYGNphtsibAf5Px+eYcbTF1QZRL+/6ZS79Q6++rcwTaUcxR
        Cwf/HheDZF6BN3b2BWtafLPSLKTDUgJ3+Q==
X-Google-Smtp-Source: AKy350bbGdIsdhyddfmiQOjMsx8dzijJbT477Zqg/0NHqwsCTUS0h5CCb+UsPRMCOa8v6CN1nBz6BQ==
X-Received: by 2002:a17:902:ea0a:b0:19d:1a8e:836f with SMTP id s10-20020a170902ea0a00b0019d1a8e836fmr26659976plg.27.1680121311558;
        Wed, 29 Mar 2023 13:21:51 -0700 (PDT)
Received: from snowbird.robot.car ([199.73.127.3])
        by smtp.gmail.com with ESMTPSA id p19-20020a170902a41300b001a281063ab4sm341749plq.233.2023.03.29.13.21.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 13:21:51 -0700 (PDT)
From:   Dennis Zhou <dennis@kernel.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dennis Zhou <dennis@kernel.org>
Subject: [PATCH] mmc: inline the first mmc_scan() on mmc_start_host()
Date:   Wed, 29 Mar 2023 13:21:48 -0700
Message-Id: <20230329202148.71107-1-dennis@kernel.org>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.5 required=5.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When using dm-verity with a data partition on an emmc device, dm-verity
races with the discovery of attached emmc devices. This is because mmc's
probing code sets up the host data structure then a work item is
scheduled to do discovery afterwards. To prevent this race on init,
let's inline the first call to detection, __mm_scan(), and let
subsequent detect calls be handled via the workqueue.

Signed-off-by: Dennis Zhou <dennis@kernel.org>
---
 drivers/mmc/core/core.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 368f10405e13..c0fdc438c882 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -2185,10 +2185,8 @@ int mmc_card_alternative_gpt_sector(struct mmc_card *card, sector_t *gpt_sector)
 }
 EXPORT_SYMBOL(mmc_card_alternative_gpt_sector);
 
-void mmc_rescan(struct work_struct *work)
+void __mmc_rescan(struct mmc_host *host)
 {
-	struct mmc_host *host =
-		container_of(work, struct mmc_host, detect.work);
 	int i;
 
 	if (host->rescan_disable)
@@ -2249,6 +2247,14 @@ void mmc_rescan(struct work_struct *work)
 		mmc_schedule_delayed_work(&host->detect, HZ);
 }
 
+void mmc_rescan(struct work_struct *work)
+{
+	struct mmc_host *host =
+		container_of(work, struct mmc_host, detect.work);
+
+	__mmc_rescan(host);
+}
+
 void mmc_start_host(struct mmc_host *host)
 {
 	host->f_init = max(min(freqs[0], host->f_max), host->f_min);
@@ -2261,7 +2267,8 @@ void mmc_start_host(struct mmc_host *host)
 	}
 
 	mmc_gpiod_request_cd_irq(host);
-	_mmc_detect_change(host, 0, false);
+	host->detect_change = 1;
+	__mmc_rescan(host);
 }
 
 void __mmc_stop_host(struct mmc_host *host)
-- 
2.40.0

