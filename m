Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5299060B309
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 18:56:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235765AbiJXQzA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 12:55:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235565AbiJXQtv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 12:49:51 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C1A4B845;
        Mon, 24 Oct 2022 08:33:12 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id b20-20020a05600c4e1400b003cc28585e2fso3571527wmq.1;
        Mon, 24 Oct 2022 08:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=h2f/Wq6hw/Zz7h01CyJIfhHfe2/k6p4+o75M8dITN0c=;
        b=PX5nZva0lV0pnt32fzYeW2dTGOsI4CM2ZxntnUoEx0OMwo5Vx+a/05szDGQSsLlw/d
         NgdIFIoo/5V7jrbaNK71a6S63upr3q/X/dJsUMZD8rT28OutMaizuWtrgzrthsVweccJ
         9MT8hnSrNJw2IK2idnWDtTqxEfg5Wn5Vkab4z8qC/68fH7YjsiZhxUrzb/J+SIPG4efn
         3NnClaiVR7R+QsVxlapoXrpLeFuElCVAQnFoY29e/TMPKIrI3SCji4c270e0fdP8wPpR
         Giv6KD8cQWE4p2iiXOxjCmoxQIMfG6WEfT1tCBWpzGMvXjmvI93eBeUYcxOPj/p4IDJ1
         zTPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h2f/Wq6hw/Zz7h01CyJIfhHfe2/k6p4+o75M8dITN0c=;
        b=n13+gnGF/zr6A2G6ovmJTArrkOejb/UUDwNtB+S37b2e1Ui6Oa5y9zw3wbXqzLJ3Vm
         dKvXu2pEnKWUQT+qznGqFs/Uj5N8Ah227qhw9Z6mUJA6mw/faBsS6TJ2fTbTLyhB/MB8
         rIc428MWsdNeQ2UgwDNJX/Csg6l8Bc1GlSdWlPl+lPOH5F0Rwq1xmo2BWz4tFe5mYmMo
         3hSgJ0nVCAOA00ANt7JoXV9LXPrETtQXouREQA8NLJD4t5WV8veTv6+392+7xGayPpTj
         F5mBiE7GLPMyd4xVPemjsRJXbxcdCy326JSgrAqJDQYotXq0tvdBsnvDVEaBAozrqw5O
         5QBg==
X-Gm-Message-State: ACrzQf1AsWk7SSsrfEOySIQj0SIDRenqyr7awDzGjoah0zuXYMiljrTz
        gm3sl/pANkZHeaPw5wRP/RwXwufnhuQUpYmE
X-Google-Smtp-Source: AMsMyM4vYNbitR0d5EYNcQejuq2Bm6qAgLHpXEvE3v/gmJZw3RhGH5/7o4JA86RGgoLst3OHTYndtg==
X-Received: by 2002:a05:600c:1906:b0:3c6:f83e:d15f with SMTP id j6-20020a05600c190600b003c6f83ed15fmr27287852wmq.205.1666621080888;
        Mon, 24 Oct 2022 07:18:00 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id d9-20020a5d6dc9000000b002364c77bc96sm10691434wrz.33.2022.10.24.07.18.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 07:18:00 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        linux-ide@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ata: sata_dwc_460ex: remove variable num_processed
Date:   Mon, 24 Oct 2022 15:17:59 +0100
Message-Id: <20221024141759.2161963-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Variable num_processed is just being incremented and it's never used
anywhere else. The variable and the increment are redundant so
remove it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/ata/sata_dwc_460ex.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/ata/sata_dwc_460ex.c b/drivers/ata/sata_dwc_460ex.c
index e3263e961045..fd699c5bfc34 100644
--- a/drivers/ata/sata_dwc_460ex.c
+++ b/drivers/ata/sata_dwc_460ex.c
@@ -472,7 +472,7 @@ static irqreturn_t sata_dwc_isr(int irq, void *dev_instance)
 	struct ata_queued_cmd *qc;
 	unsigned long flags;
 	u8 status, tag;
-	int handled, num_processed, port = 0;
+	int handled, port = 0;
 	uint intpr, sactive, sactive2, tag_mask;
 	struct sata_dwc_device_port *hsdevp;
 	hsdev->sactive_issued = 0;
@@ -618,9 +618,7 @@ static irqreturn_t sata_dwc_isr(int irq, void *dev_instance)
 	dev_dbg(ap->dev, "%s ATA status register=0x%x\n", __func__, status);
 
 	tag = 0;
-	num_processed = 0;
 	while (tag_mask) {
-		num_processed++;
 		while (!(tag_mask & 0x00000001)) {
 			tag++;
 			tag_mask <<= 1;
-- 
2.37.3

