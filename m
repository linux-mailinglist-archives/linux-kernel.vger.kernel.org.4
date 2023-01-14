Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AC0666AD4D
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Jan 2023 19:42:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbjANSmW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Jan 2023 13:42:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbjANSmU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jan 2023 13:42:20 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D136F900D;
        Sat, 14 Jan 2023 10:42:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=r2z4I/Nj+Ntpxa2lOB55jiImAMYuUh4qJEwkx6RSCvY=; b=adJU1Z/gJpKZL25AYl3h9bqtRh
        ZaBRjmyuwXxyT/BtJ98IWWHup0HYeEVWHxQwshdz0q6QJQB6dFf5Jlsq8/BEsQgtVNOonUFeQsHJ/
        hm7wMZQY3KzuVoiMvs9zl+Ls+zlwqTldd1i3kX+WvR87QE6ZIGdL+gu0FHn78eOko2R0I/RRCXtWy
        NO+xQ7kQ69hwLnmSpgAlqvz5vQLwtwhYFOCoLqlqrWJNwXcVuy15P6DkRKxCF8/cXvYQpiGv1fGc6
        1xzQXeYuD/SxsbSv8iprHyidZa0979x0NQVTtOomgI9nEkiymttjOfry8HBJ0+rFF0aEvVl0YDytb
        fev7/TEw==;
Received: from [2601:1c2:d80:3110::9307] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pGlTs-006Lab-7u; Sat, 14 Jan 2023 18:42:16 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Jerome Neanne <j-neanne@baylibre.com>,
        Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH] regulator: tps65219: use IS_ERR() to detect an error pointer
Date:   Sat, 14 Jan 2023 10:42:15 -0800
Message-Id: <20230114184215.27806-1-rdunlap@infradead.org>
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

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jerome Neanne <j-neanne@baylibre.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
---
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
