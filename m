Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFA526CF7A9
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 01:48:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230389AbjC2XsJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 19:48:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjC2XsH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 19:48:07 -0400
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98C423C1E;
        Wed, 29 Mar 2023 16:48:06 -0700 (PDT)
Received: by mail-pj1-f46.google.com with SMTP id lr16-20020a17090b4b9000b0023f187954acso17889294pjb.2;
        Wed, 29 Mar 2023 16:48:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680133686;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7ETYu9f3O7bRoQnr7/k7PLVrkbB1GMeAB1+nXGIoc5o=;
        b=iRI/dFowb/m0oJsln98s1Zh6mfmPsRdbtf1nvZSX9l9fJ/73lqbptBUFzlVZ+uFtDn
         jqgpnRMrIFQM/EaOQXAZY/tyXRFVYt88CNWhowJdTB0X5i1xgDFjMFF/V6E2Et5IeISm
         Ey4uKhA5ZXiCx45Fe3kPiKENijwhGZ9OJRy9P6aTMmZXXClIXStaMqFBKTIk0O34b8b+
         xlHlEuwJQSju/XABmtJfV//oFmbMHZ5+z+mfKx8497Ew++9ktbvFqhLb1FQhpoqeR/Ap
         90e4ioE1yepgP+GyygZCBWv5NGk11FysjmKzsvLLjP5zP5jBCZFIClxTQF9DfzVJeTpB
         fAYA==
X-Gm-Message-State: AAQBX9fLUuyLPox2rYpXrVCVOMIjK8wPVGVAL47+/uvnhRiYx/OELbw1
        xEjFSNZW6+vfq+E0quwxoCQb3XidEu5wnw==
X-Google-Smtp-Source: AKy350aA/nKzBf/dNWMtkLWggrUUufSqsxTj3eNZu3/Cugd4hGWziglradj5hIni77zV0BT96w7Ykw==
X-Received: by 2002:a17:90b:4c12:b0:23f:7dfb:7dc1 with SMTP id na18-20020a17090b4c1200b0023f7dfb7dc1mr22878981pjb.33.1680133685493;
        Wed, 29 Mar 2023 16:48:05 -0700 (PDT)
Received: from snowbird ([199.73.127.3])
        by smtp.gmail.com with ESMTPSA id q59-20020a17090a1b4100b00233acae2ce6sm1931922pjq.23.2023.03.29.16.48.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 16:48:05 -0700 (PDT)
Date:   Wed, 29 Mar 2023 16:48:01 -0700
From:   Dennis Zhou <dennis@kernel.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] mmc: inline the first mmc_scan() on mmc_start_host()
Message-ID: <ZCTOMVjW+pnZVGsQ@snowbird>
References: <20230329202148.71107-1-dennis@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230329202148.71107-1-dennis@kernel.org>
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
Sigh.. fix missing static declaration.

 drivers/mmc/core/core.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 368f10405e13..fda7ee57dee3 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -2185,10 +2185,8 @@ int mmc_card_alternative_gpt_sector(struct mmc_card *card, sector_t *gpt_sector)
 }
 EXPORT_SYMBOL(mmc_card_alternative_gpt_sector);
 
-void mmc_rescan(struct work_struct *work)
+static void __mmc_rescan(struct mmc_host *host)
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

