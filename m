Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54419713310
	for <lists+linux-kernel@lfdr.de>; Sat, 27 May 2023 09:38:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232102AbjE0HiD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 May 2023 03:38:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231747AbjE0Hgh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 May 2023 03:36:37 -0400
Received: from smtp.smtpout.orange.fr (smtp-23.smtpout.orange.fr [80.12.242.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3DF4D3
        for <linux-kernel@vger.kernel.org>; Sat, 27 May 2023 00:36:34 -0700 (PDT)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id 2oTXqn1098aX92oTYqO5DH; Sat, 27 May 2023 09:36:32 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1685172992;
        bh=jfcq+JgA5tqsNjhJdIRr8u+hc7+NPdvjx/XHhop2/Is=;
        h=From:To:Cc:Subject:Date;
        b=oP99AC7iTJ4UihSNEW/pzpRz9iPotcP9k/mZw954h9q8LA73LTHHJczpFnk/qBRMl
         lTgFns4cYPAN0ZS5x6mLvkGA9aHf/LGVs7PHK1WyQ8FgT/PZKljP8D+qV/VWCj7u1O
         y5T3byDZuJIiQbpJBgaR92HwVRQk/zMZXh293hilGGGDolrRYqEnnUFkcBH4y5uhzX
         OtG9D7FE7fw1Hosi0RDUdPhpi8F+sq2tb94BpW43lwxRQvXp28WrHCZ0geIHiwbcMM
         EjqY4iW+4nNJFKZbDd+TQdHrgZQFQnnyLnhnvL8JjrLtwL1J2V7JuMPHNCPcY7yrnF
         Pe4WX+B0QtlnA==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 27 May 2023 09:36:32 +0200
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH v2] dmaengine: mcf-edma: Fix a potential un-allocated memory access
Date:   Sat, 27 May 2023 09:36:31 +0200
Message-Id: <f55d914407c900828f6fad3ea5fa791a5f17b9a4.1685172449.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When 'mcf_edma' is allocated, some space is allocated for a
flexible array at the end of the struct. 'chans' item are allocated, that is
to say 'pdata->dma_channels'.

Then, this number of item is stored in 'mcf_edma->n_chans'.

A few lines later, if 'mcf_edma->n_chans' is 0, then a default value of 64
is set.

This ends to no space allocated by devm_kzalloc() because chans was 0, but
64 items are read and/or written in some not allocated memory.

Change the logic to define a default value before allocating the memory.

Fixes: e7a3ff92eaf1 ("dmaengine: fsl-edma: add ColdFire mcf5441x edma support")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
If I'm correct, then:

   - the default value is hard-coded as 64. There is also a
        #define EDMA_CHANNELS 64
     which maybe could be used, or renamed as EDMA_DEFAULT_CHANNELS

   - mcf_edma_err_handler() looks bogus, because it considers that
     mcf_edma->chans has EDMA_CHANNELS items.
     I guess that something related to mcf_edma->n_chans is what is
     expected, but how should this be done?

Maybe, the EDMA_CHANNELS value should be used all the time?
Maybe, the number of chans should be limited to EDMA_CHANNELS?
Maybe, the number of chans should be at least EDMA_CHANNELS?

Maybe, maybe, maybe, but me, I don't know :(

All I know is that this patch compiles :)
and that it can gives Dan an idea for smatch for checking access to un-allocated
memory related to flexible array :)


v2: I forgot the subject in v1...
---
 drivers/dma/mcf-edma.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/dma/mcf-edma.c b/drivers/dma/mcf-edma.c
index ebd8733f72ad..9413fad08a60 100644
--- a/drivers/dma/mcf-edma.c
+++ b/drivers/dma/mcf-edma.c
@@ -190,7 +190,13 @@ static int mcf_edma_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	chans = pdata->dma_channels;
+	if (!pdata->dma_channels) {
+		dev_info(&pdev->dev, "setting default channel number to 64");
+		chans = 64;
+	} else {
+		chans = pdata->dma_channels;
+	}
+
 	len = sizeof(*mcf_edma) + sizeof(*mcf_chan) * chans;
 	mcf_edma = devm_kzalloc(&pdev->dev, len, GFP_KERNEL);
 	if (!mcf_edma)
@@ -202,11 +208,6 @@ static int mcf_edma_probe(struct platform_device *pdev)
 	mcf_edma->drvdata = &mcf_data;
 	mcf_edma->big_endian = 1;
 
-	if (!mcf_edma->n_chans) {
-		dev_info(&pdev->dev, "setting default channel number to 64");
-		mcf_edma->n_chans = 64;
-	}
-
 	mutex_init(&mcf_edma->fsl_edma_mutex);
 
 	mcf_edma->membase = devm_platform_ioremap_resource(pdev, 0);
-- 
2.34.1

