Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 354F9750A89
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 16:13:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233019AbjGLONt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 10:13:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232957AbjGLONo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 10:13:44 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D43FE1BCC
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 07:13:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        sang-engineering.com; h=from:to:cc:subject:date:message-id
        :mime-version:content-transfer-encoding; s=k1; bh=Y9d7J5CMu7DEbd
        NW56Qy+zSGey/4BIQ3iYwBhkjkJZo=; b=dh4/Vz56pLuFgMhFRIfv5GtZ7W+kDL
        /EVyjamxjoTPCrMWt+Cdz48KbAPC41ymC3wkyFkUiQCxdXfKmxGHjnJaPF8b6aqt
        VwN0Z9YkqFljmcUoUop75LErqibhkuNp97feiVzjXjvRv0hpggSo8YbCoBH9Y/Eo
        WoRDz3M1amdOT9uMdvd8tXgF6s2jQnXCJERJ7LcgTAMiZLDJK5v/U0TCURWkLQtq
        1320y2lIosZIXQsAXE6NVrtOCiFPEypyouKw5IwUZ2G40NcuQXrTq5OYIu7wfssC
        8C5G34d3OY2ZAISiREgKVGtyKrhW/ZqOtXjPzBEkAJ81AjVgXoM7BBKQ==
Received: (qmail 1639935 invoked from network); 12 Jul 2023 16:13:37 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 12 Jul 2023 16:13:37 +0200
X-UD-Smtp-Session: l3s3148p1@W05l0koAurkujnvL
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-renesas-soc@vger.kernel.org
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH RFT] mmc: uniphier-sd: register irqs before registering controller
Date:   Wed, 12 Jul 2023 16:13:27 +0200
Message-Id: <20230712141327.20827-1-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IRQs should be ready to serve when we call mmc_add_host() via
tmio_mmc_host_probe(). To achieve that, ensure that all irqs are masked
before registering the handlers.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

So, I converted this other TMIO core user as well. But I don't have HW
to test, so it would be great if someone could step up and test it.

 drivers/mmc/host/uniphier-sd.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/host/uniphier-sd.c b/drivers/mmc/host/uniphier-sd.c
index 61acd69fac0e..4dc079f74c1b 100644
--- a/drivers/mmc/host/uniphier-sd.c
+++ b/drivers/mmc/host/uniphier-sd.c
@@ -706,19 +706,19 @@ static int uniphier_sd_probe(struct platform_device *pdev)
 	tmio_data->max_segs = 1;
 	tmio_data->max_blk_count = U16_MAX;
 
-	ret = tmio_mmc_host_probe(host);
-	if (ret)
-		goto disable_clk;
+	sd_ctrl_write32_as_16_and_16(host, CTL_IRQ_MASK, TMIO_MASK_ALL);
 
 	ret = devm_request_irq(dev, irq, tmio_mmc_irq, IRQF_SHARED,
 			       dev_name(dev), host);
 	if (ret)
-		goto remove_host;
+		goto disable_clk;
+
+	ret = tmio_mmc_host_probe(host);
+	if (ret)
+		goto disable_clk;
 
 	return 0;
 
-remove_host:
-	tmio_mmc_host_remove(host);
 disable_clk:
 	uniphier_sd_clk_disable(host);
 free_host:
-- 
2.30.2

