Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0D686FF450
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 16:30:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238527AbjEKO3m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 10:29:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238522AbjEKO3Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 10:29:24 -0400
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 919C61162E
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 07:28:21 -0700 (PDT)
Received: (Authenticated sender: maxime.chevallier@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 9DB0660006;
        Thu, 11 May 2023 14:27:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1683815257;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=ug+p6iCVf1udbSgRyqpW9GXjPr5g4rDBs4xk10bbhb4=;
        b=c51IF4h2kvzjIHi4IVnW5nBHSP3LXsR/MIfPMBzfbQvEyDh/KRmu7vXIjsd/zDY3y2ZlEr
        vEAfYjbVvVjOUTmEV9LuagCdnE4GWAsunUWjHy23ZUZnA0jBoPTuv857888c+0qsay9FYZ
        /J4g1mj6raAMJ728V+un4jM5YHa6CFMvGRNX+2CQIgvWA9rbDVoqCc2BoTH4CF8nyhQXjf
        JKQ+tu1KPcioi880HgOZUBdg4bYx3r/EyCv3qC6PVivqY3dr+rdLWluJQsYLilVEB00Df/
        mylDHCsoesiC1ImhyJ9uhspKWmqEiIECrKKEQOKbyMtbimworshw1+QsztnrKA==
From:   Maxime Chevallier <maxime.chevallier@bootlin.com>
To:     Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Colin Foster <colin.foster@in-advantage.com>
Cc:     Maxime Chevallier <maxime.chevallier@bootlin.com>,
        linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
        alexis.lothore@bootlin.com
Subject: [PATCH] regmap: mmio: Allow passing an empty config->reg_stride
Date:   Thu, 11 May 2023 16:27:35 +0200
Message-Id: <20230511142735.316445-1-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Regmap's stride is used for MMIO regmaps to check the correctness of
reg_width. However, it's acceptable to pass an empty config->reg_stride,
in that case the actual stride used is 1.

There are valid cases now to pass an empty stride, when using
down/upshifting of register address. In this case, the stride value
loses its sense, so ignore the reg_width when the stride isn't set.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
This patch is a followup on the discussion here [1]. The regmap core
actually supports pretty-well not passing a stride, and uses a value of
1 by default. However regmap-mmio has specific checks for that case,
which is the only place such a check needs to be added.

[1] : https://lore.kernel.org/all/20230420150617.381922-1-maxime.chevallier@bootlin.com/

 drivers/base/regmap/regmap-mmio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/regmap/regmap-mmio.c b/drivers/base/regmap/regmap-mmio.c
index 3ccdd86a97e7..8132b5c101c4 100644
--- a/drivers/base/regmap/regmap-mmio.c
+++ b/drivers/base/regmap/regmap-mmio.c
@@ -448,7 +448,7 @@ static struct regmap_mmio_context *regmap_mmio_gen_context(struct device *dev,
 	if (min_stride < 0)
 		return ERR_PTR(min_stride);
 
-	if (config->reg_stride < min_stride)
+	if (config->reg_stride && config->reg_stride < min_stride)
 		return ERR_PTR(-EINVAL);
 
 	if (config->use_relaxed_mmio && config->io_port)
-- 
2.40.1

