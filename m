Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CCD46B66CD
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 14:40:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230450AbjCLNkX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 09:40:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230256AbjCLNkV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 09:40:21 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D00E724BCD;
        Sun, 12 Mar 2023 06:40:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 82088B80B18;
        Sun, 12 Mar 2023 13:40:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D155DC433D2;
        Sun, 12 Mar 2023 13:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678628415;
        bh=ke7T1l0eRGRWmebXcI69qvnIV9XLz1cUDufT5C689es=;
        h=From:To:Cc:Subject:Date:From;
        b=heid8DOUEl48pfy/rKb5NLhK226OaqMoL/TmdUEE+uWdBXQVmGNsuwIIoYAkjv26t
         ZfXiLkUl2mq/+sYGdr+M68ObjtOwGvTNR0nZ7hx0Gta4axC/MrsOKg3C9LHG5+KC1Z
         IHreXPhgRhI25BoqRRWI73rF9AUJzN+po9YD71BjvVKc+wv9Db2ta6CJ3atQsc65hb
         uaMlhSTiRmHv3irn2ZoQfSn+2KI/98IHqMk323DMmwTI03rTdJuMA08xbw37Avb4c7
         7lQllheSgMpt5fO589jeSKNq/0WgPnzzBRGJjGRK5eRogwOGfzWl7NP97jjbB1Xuyv
         9zs1y8pfr2TAQ==
From:   Andi Shyti <andi.shyti@kernel.org>
To:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andi Shyti <andi.shyti@kernel.org>
Subject: [PATCH] spi: mpc5xxx-psc: Fix compile error
Date:   Sun, 12 Mar 2023 14:39:59 +0100
Message-Id: <20230312133959.256855-1-andi.shyti@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 9e21720a4958 ("spi: mpc5xxx-psc: use
devm_clk_get_enabled() for core clock") has made use of the
devm_clk_get_enabled(), but it actually forgot to remove a couple
of goto's, triggering the following compile error:

drivers/spi/spi-mpc512x-psc.c: In function ‘mpc512x_psc_spi_of_probe’:
drivers/spi/spi-mpc512x-psc.c:518:17: error: label ‘free_ipg_clock’ used but not defined
  518 |                 goto free_ipg_clock;

Replace those goto's with actual returns.

Fixes: 9e21720a4958 ("spi: mpc5xxx-psc: use devm_clk_get_enabled() for core clock")
Signed-off-by: Andi Shyti <andi.shyti@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/spi/spi-mpc512x-psc.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-mpc512x-psc.c b/drivers/spi/spi-mpc512x-psc.c
index 77a228f633d1..0b86f1804682 100644
--- a/drivers/spi/spi-mpc512x-psc.c
+++ b/drivers/spi/spi-mpc512x-psc.c
@@ -511,13 +511,9 @@ static int mpc512x_psc_spi_of_probe(struct platform_device *pdev)
 
 	ret = mpc512x_psc_spi_port_config(master, mps);
 	if (ret < 0)
-		goto free_ipg_clock;
-
-	ret = devm_spi_register_master(dev, master);
-	if (ret < 0)
-		goto free_ipg_clock;
+		return ret;
 
-	return ret;
+	return devm_spi_register_master(dev, master);
 }
 
 static const struct of_device_id mpc512x_psc_spi_of_match[] = {
-- 
2.39.2

