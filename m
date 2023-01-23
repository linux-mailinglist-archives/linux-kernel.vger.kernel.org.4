Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1589A677537
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 07:52:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230186AbjAWGvr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 01:51:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjAWGvq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 01:51:46 -0500
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D8DF1204A
        for <linux-kernel@vger.kernel.org>; Sun, 22 Jan 2023 22:51:44 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sendonly@marcansoft.com)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 06EBF424EC;
        Mon, 23 Jan 2023 06:51:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=marcan.st; s=default;
        t=1674456702; bh=j2bWBmQyozgHL4EsWv4N1w989XFOWo0e4L5yN04ucaI=;
        h=From:To:Cc:Subject:Date;
        b=P+q17GaAoExZBPKuP33jcACzrUJoRNQEoH6CmYa4ECDyIqBWYKozTX6ggnmCkuUhg
         BAKmRCzhXHxpFbFWGq5awTdBFQHQjPnck3St6JX9OLs+xNCCmWjXWhTt8VkHEHNjvY
         CrWvjwxNFRv48WZaGg8QWr8bqbdsLse9FdrlgXY7q3zOFGBeRIoiUVwZuOJ985NFTP
         Q4+2ompsX8psMb1Wp92phoZIY0auTXVHtkIyHwiGtBiyKfwZ6dZX9vDO8haqjgH+oj
         7Melgg3iSS8bg63xzByn/glTpM0PeEUMaVm8ZlvY0+IJTGJRxJXJQs7D63sw2tVlFU
         JYfJn950non7A==
From:   Hector Martin <marcan@marcan.st>
To:     Sven Peter <sven@svenpeter.dev>
Cc:     Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Janne Grunau <j@jannau.net>, asahi@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Hector Martin <marcan@marcan.st>
Subject: [PATCH] soc: apple: apple-pmgr-pwrstate: Switch to IRQ-safe mode
Date:   Mon, 23 Jan 2023 15:51:25 +0900
Message-Id: <20230123065125.26350-1-marcan@marcan.st>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This requires changing the reset path locking primitives to the spinlock
path in genpd, instead of the mutex path.

Signed-off-by: Hector Martin <marcan@marcan.st>
---
 drivers/soc/apple/apple-pmgr-pwrstate.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/soc/apple/apple-pmgr-pwrstate.c b/drivers/soc/apple/apple-pmgr-pwrstate.c
index e1122288409a..a3e2bc1d2686 100644
--- a/drivers/soc/apple/apple-pmgr-pwrstate.c
+++ b/drivers/soc/apple/apple-pmgr-pwrstate.c
@@ -116,8 +116,9 @@ static int apple_pmgr_ps_power_off(struct generic_pm_domain *genpd)
 static int apple_pmgr_reset_assert(struct reset_controller_dev *rcdev, unsigned long id)
 {
 	struct apple_pmgr_ps *ps = rcdev_to_apple_pmgr_ps(rcdev);
+	unsigned long flags;
 
-	mutex_lock(&ps->genpd.mlock);
+	spin_lock_irqsave(&ps->genpd.slock, flags);
 
 	if (ps->genpd.status == GENPD_STATE_OFF)
 		dev_err(ps->dev, "PS 0x%x: asserting RESET while powered down\n", ps->offset);
@@ -129,7 +130,7 @@ static int apple_pmgr_reset_assert(struct reset_controller_dev *rcdev, unsigned
 	regmap_update_bits(ps->regmap, ps->offset, APPLE_PMGR_FLAGS | APPLE_PMGR_RESET,
 			   APPLE_PMGR_RESET);
 
-	mutex_unlock(&ps->genpd.mlock);
+	spin_unlock_irqrestore(&ps->genpd.slock, flags);
 
 	return 0;
 }
@@ -137,8 +138,9 @@ static int apple_pmgr_reset_assert(struct reset_controller_dev *rcdev, unsigned
 static int apple_pmgr_reset_deassert(struct reset_controller_dev *rcdev, unsigned long id)
 {
 	struct apple_pmgr_ps *ps = rcdev_to_apple_pmgr_ps(rcdev);
+	unsigned long flags;
 
-	mutex_lock(&ps->genpd.mlock);
+	spin_lock_irqsave(&ps->genpd.slock, flags);
 
 	dev_dbg(ps->dev, "PS 0x%x: deassert reset\n", ps->offset);
 	regmap_update_bits(ps->regmap, ps->offset, APPLE_PMGR_FLAGS | APPLE_PMGR_RESET, 0);
@@ -147,7 +149,7 @@ static int apple_pmgr_reset_deassert(struct reset_controller_dev *rcdev, unsigne
 	if (ps->genpd.status == GENPD_STATE_OFF)
 		dev_err(ps->dev, "PS 0x%x: RESET was deasserted while powered down\n", ps->offset);
 
-	mutex_unlock(&ps->genpd.mlock);
+	spin_unlock_irqrestore(&ps->genpd.slock, flags);
 
 	return 0;
 }
@@ -222,6 +224,7 @@ static int apple_pmgr_ps_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	ps->genpd.flags |= GENPD_FLAG_IRQ_SAFE;
 	ps->genpd.name = name;
 	ps->genpd.power_on = apple_pmgr_ps_power_on;
 	ps->genpd.power_off = apple_pmgr_ps_power_off;
-- 
2.35.1

