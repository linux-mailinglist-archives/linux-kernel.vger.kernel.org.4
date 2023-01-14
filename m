Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DBFE66AD54
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Jan 2023 19:57:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbjANS5l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Jan 2023 13:57:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbjANS5j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jan 2023 13:57:39 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F9D3B76D;
        Sat, 14 Jan 2023 10:57:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=COfo/oBaSIMqiEbzejZ+tc/RTs2C5/+Q+HgjZl4m/5Q=; b=nN5H6ijpvyI0WhD3m22iQZr6W7
        +5YKA0DdaE6ip5ViwvmqcWedP7YM+ybK/WyHv0nQK6ZjUCkYboQvvOns5QaYWGUd1OHBU/WiPyfye
        aTc/WgGTLyhK+k4aaQuHgpCR6M6tx4IloALsQD1OCAIZNq9Wf7+N0ZilJ9XXqF0tXzQtR3Jo4qNM+
        h2dOZfRUWC4z3CD/qsVD2sS51uk2tISK0FIrQKfBACQvYLNAqqs/IWsKifhcOevg0nMFCxI/JEhwL
        dYaC8nmS4z6fVoFVa11/zXhghpQdUIVsT/x1HcKdv9dCeAcP3spn8N5qW/5Pi+vSMTWijnYLZZgKv
        PmIT69BA==;
Received: from [2601:1c2:d80:3110::9307] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pGlij-006MF8-7c; Sat, 14 Jan 2023 18:57:37 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Jerome Neanne <jneanne@baylibre.com>,
        Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH v2] regulator: tps65219: use IS_ERR() to detect an error pointer
Date:   Sat, 14 Jan 2023 10:57:36 -0800
Message-Id: <20230114185736.2076-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix pointer comparison to integer warning from gcc & sparse:

GCC:
../drivers/regulator/tps65219-regulator.c:370:26: warning: ordered comparison of pointer with integer zero [-Wextra]
  370 |                 if (rdev < 0) {
      |                          ^

sparse warning:
drivers/regulator/tps65219-regulator.c:370:26: sparse: error: incompatible types for operation (<):
drivers/regulator/tps65219-regulator.c:370:26: sparse:    struct regulator_dev *[assigned] rdev
drivers/regulator/tps65219-regulator.c:370:26: sparse:    int

Fixes: c12ac5fc3e0a ("regulator: drivers: Add TI TPS65219 PMIC regulators support")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jerome Neanne <jneanne@baylibre.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
---
v2: correct Jerome's email address;
    add Fixes: tag.

 drivers/regulator/tps65219-regulator.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -- a/drivers/regulator/tps65219-regulator.c b/drivers/regulator/tps65219-regulator.c
--- a/drivers/regulator/tps65219-regulator.c
+++ b/drivers/regulator/tps65219-regulator.c
@@ -367,7 +367,7 @@ static int tps65219_regulator_probe(stru
 		irq_data[i].type = irq_type;
 
 		tps65219_get_rdev_by_name(irq_type->regulator_name, rdevtbl, rdev);
-		if (rdev < 0) {
+		if (IS_ERR(rdev)) {
 			dev_err(tps->dev, "Failed to get rdev for %s\n",
 				irq_type->regulator_name);
 			return -EINVAL;
