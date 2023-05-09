Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 690196FCEB7
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 21:45:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230264AbjEITpE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 15:45:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbjEITpD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 15:45:03 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C72C1FDD;
        Tue,  9 May 2023 12:45:02 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id 98e67ed59e1d1-24e01ba9e03so4485587a91.1;
        Tue, 09 May 2023 12:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683661501; x=1686253501;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=b9oeW8i4ERlGGva70/AIMht4ybknzJZHtDHqd/eNbOA=;
        b=N1IeTSVRBHKifxU1LRmNhYyio9mPJW9jBsQ/adWljxM6UjGjbPmnmrtkZzhUZpancy
         fb5P+1AuEa193DDjXuwaepzKgVpu4cCOlK7vj1t9P2AaQ/S6MpaRVih220+QKvUGUWO8
         BshKgVj9lSW5plbbkm18cpZKpnXKZrUKIS9Zcj3IZNIPxNsUa8awAFMxOhfvf8AIzmEr
         SbngwXiHgmDyFTE8goFE1InZacElu7VIX5r40qMe6u2S/k7hCsY3pPTnUm3136vDlbcd
         rtCmQHPLIMcB8jYQtndvHY7mGjDb3ka67tGfgJSrv8iPNz/jAIPG4Bb/QbnVR9y4GpCz
         rZkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683661501; x=1686253501;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b9oeW8i4ERlGGva70/AIMht4ybknzJZHtDHqd/eNbOA=;
        b=Zy8f7G28rpjcT1nmpMTXQVcDfmU+Jb/PqsSJzccUoJ/6wH9mTNMuXbcyxhX07vSIOS
         /Dd6uXBqxJExAdS7yurWD26zKReagAXMuG3h3ly63v23fBzCqadcqedT4NSTIDcf+tfY
         VLBBJKO358dxcvi4IxLIqZFpgO2Iq1T+YKJF4KOrlSbZWRh4USdxOdnXRmtm/J3dXtXo
         HRKbZJ8iiz5efUP8mwyFQXA/ScTWiAb17sX7t5k9qxBGNVciNhZc5VTSPFxcIpAgA11X
         WAdERFD52cWBAeWIyxydXPebuNxfwODMmZRRDZSpvjajNFPQE922dxLVsaLP22LSKQss
         Moeg==
X-Gm-Message-State: AC+VfDx1Bf7YFQ1zTMQVh/7RkkowVCOgl5s1qT5kNITQaYDU/UB1vb86
        00srB21cJh9PfULKHLAZZQdk1h+v1QI=
X-Google-Smtp-Source: ACHHUZ6torcC78F1VFiigBe+9yHmvM/rdUIfLMuTEJO/reJBTub8gJSB+MCza/rT9nZ54HYEG4CaGg==
X-Received: by 2002:a17:90a:5644:b0:24e:358a:2c6b with SMTP id d4-20020a17090a564400b0024e358a2c6bmr14645886pji.40.1683661501018;
        Tue, 09 May 2023 12:45:01 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id m12-20020a17090a7f8c00b0024e5ef2af9csm10657582pjl.42.2023.05.09.12.44.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 May 2023 12:45:00 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        =?UTF-8?q?Christian=20L=C3=B6hle?= <CLoehle@hyperstone.com>,
        Avri Altman <avri.altman@wdc.com>,
        Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>,
        Bean Huo <beanhuo@micron.com>,
        Seunghui Lee <sh043.lee@samsung.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        linux-mmc@vger.kernel.org (open list:MULTIMEDIA CARD (MMC), SECURE
        DIGITAL (SD) AND...)
Subject: [PATCH] mmc: block: Suppress empty whitespaces in prints
Date:   Tue,  9 May 2023 12:44:53 -0700
Message-Id: <20230509194455.1791890-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the device is not read-only, then we will be printing an empty
whitespace before the newline, fix that.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/mmc/core/block.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 00c33edb9fb9..761876e5012a 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -2502,9 +2502,9 @@ static struct mmc_blk_data *mmc_blk_alloc_req(struct mmc_card *card,
 
 	string_get_size((u64)size, 512, STRING_UNITS_2,
 			cap_str, sizeof(cap_str));
-	pr_info("%s: %s %s %s %s\n",
+	pr_info("%s: %s %s %s%s\n",
 		md->disk->disk_name, mmc_card_id(card), mmc_card_name(card),
-		cap_str, md->read_only ? "(ro)" : "");
+		cap_str, md->read_only ? " (ro)" : "");
 
 	/* used in ->open, must be set before add_disk: */
 	if (area_type == MMC_BLK_DATA_AREA_MAIN)
-- 
2.34.1

