Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CC0E7505BB
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 13:14:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233000AbjGLLOx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 07:14:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232997AbjGLLOu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 07:14:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAE96170E
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 04:14:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 58E796175C
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 11:14:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9A6BC433C8;
        Wed, 12 Jul 2023 11:14:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689160488;
        bh=2fRRg922MXnJBLpH2CG47X7Q6Q7bgdnHX1iBu/puZIQ=;
        h=From:Date:Subject:To:Cc:From;
        b=iraQp1mIxYKV3l5KzZovLBYKCaXNJsPPeB41XQO7ca+SiByTuhPBWfIQxd2GSHfg8
         WDr1d1xz/djoxJcHG8ClvVB2OEXRLFZLYp4ghhx+WsbLzitcyr/jq8tod7jW0cOCJA
         3wpUXnnhEXNmA86v3ZaXPpkarWy0sYEjGz9QTlsl9OyThbF1BPytLTR+pgm5ctWjFX
         yNwfSlJeMr+nKgOdgEE8BYRJ8PEr1tPEYlyy7YlefDi21B6oZHgjHRZNyvXHELsXd5
         vVB0Us8Psl6reupDYYciYzr+UPxxDQ7CYLRzEC5kNj+rIdiuUDkozr/EzMcancbNLw
         gcB18iOk3Go4w==
From:   Mark Brown <broonie@kernel.org>
Date:   Wed, 12 Jul 2023 12:14:43 +0100
Subject: [PATCH] mfd: axp20x: Update to use maple tree register cache
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230712-mfd-axp20x-maple-v1-1-4df3749107a6@kernel.org>
X-B4-Tracking: v=1; b=H4sIACKLrmQC/x2N0QrCMAwAf2Xk2UDXogx/RXzI1tQFbC2JjMLYv
 9v5eBzH7WCswgb3YQflTUw+pcN4GWBZqbwYJXYG73xwNx8wp4jUqncNM9U3Y5omdtcUYgwj9Gw
 mY5yVyrKeYSb7sp6iKidp/9fjeRw/hI/7VXsAAAA=
To:     Lee Jones <lee@kernel.org>, Chen-Yu Tsai <wens@csie.org>
Cc:     linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-099c9
X-Developer-Signature: v=1; a=openpgp-sha256; l=3093; i=broonie@kernel.org;
 h=from:subject:message-id; bh=2fRRg922MXnJBLpH2CG47X7Q6Q7bgdnHX1iBu/puZIQ=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBkrosmB2pXlV/R2vUT8GIXc9P2UIJYX03Sy26ix
 wOcVKozqIGJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZK6LJgAKCRAk1otyXVSH
 0OWfB/sGhYXYQDgikalQDoJmlOuGU746ytp3c0SB/weeQ4xyimY+yAv+PK4LulrU/sIFGCDlBju
 K6XFtWfNXlb4LDydDhZvVvt4GljBqWIBPoY7lligrn9kfBN6/N8BeTQxaTKOY39JMwghS50Mh6W
 chgrn+pe/lVd8ykQcbTZQbC1TZLpVKc2n3i/piRL91msEdN5Z1xHSbaarrgYxEMPFGHJGecTmHE
 ScW8JZCZjeRqrvt9XsKOYvjEFmJnDqBwR+ThnStHiy+lk1cvIAAZS4pZseKYuFMBKZlsqguAfAr
 8khUbFrn++GhZQmvQmfqHm1AXiOY5/a2l0W3GQSV8zXa+kFb
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The maple tree register cache is based on a much more modern data structure
than the rbtree cache and makes optimisation choices which are probably
more appropriate for modern systems than those made by the rbtree cache. In
v6.5 it has also acquired the ability to generate multi-register writes in
sync operations, bringing performance up to parity with the rbtree cache
there.

Update the axp20x driver to use the more modern data structure, really it
should have been fine even without the most recent round of updates.

Signed-off-by: Mark Brown <broonie@kernel.org>
---


Signed-off-by: Mark
---
 drivers/mfd/axp20x.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
index c03bc5cda080..87603eeaa277 100644
--- a/drivers/mfd/axp20x.c
+++ b/drivers/mfd/axp20x.c
@@ -342,7 +342,7 @@ static const struct regmap_config axp152_regmap_config = {
 	.wr_table	= &axp152_writeable_table,
 	.volatile_table	= &axp152_volatile_table,
 	.max_register	= AXP152_PWM1_DUTY_CYCLE,
-	.cache_type	= REGCACHE_RBTREE,
+	.cache_type	= REGCACHE_MAPLE,
 };
 
 static const struct regmap_config axp192_regmap_config = {
@@ -360,7 +360,7 @@ static const struct regmap_config axp20x_regmap_config = {
 	.wr_table	= &axp20x_writeable_table,
 	.volatile_table	= &axp20x_volatile_table,
 	.max_register	= AXP20X_OCV(AXP20X_OCV_MAX),
-	.cache_type	= REGCACHE_RBTREE,
+	.cache_type	= REGCACHE_MAPLE,
 };
 
 static const struct regmap_config axp22x_regmap_config = {
@@ -369,7 +369,7 @@ static const struct regmap_config axp22x_regmap_config = {
 	.wr_table	= &axp22x_writeable_table,
 	.volatile_table	= &axp22x_volatile_table,
 	.max_register	= AXP22X_BATLOW_THRES1,
-	.cache_type	= REGCACHE_RBTREE,
+	.cache_type	= REGCACHE_MAPLE,
 };
 
 static const struct regmap_config axp288_regmap_config = {
@@ -378,7 +378,7 @@ static const struct regmap_config axp288_regmap_config = {
 	.wr_table	= &axp288_writeable_table,
 	.volatile_table	= &axp288_volatile_table,
 	.max_register	= AXP288_FG_TUNE5,
-	.cache_type	= REGCACHE_RBTREE,
+	.cache_type	= REGCACHE_MAPLE,
 };
 
 static const struct regmap_config axp313a_regmap_config = {
@@ -396,7 +396,7 @@ static const struct regmap_config axp806_regmap_config = {
 	.wr_table	= &axp806_writeable_table,
 	.volatile_table	= &axp806_volatile_table,
 	.max_register	= AXP806_REG_ADDR_EXT,
-	.cache_type	= REGCACHE_RBTREE,
+	.cache_type	= REGCACHE_MAPLE,
 };
 
 static const struct regmap_config axp15060_regmap_config = {
@@ -405,7 +405,7 @@ static const struct regmap_config axp15060_regmap_config = {
 	.wr_table	= &axp15060_writeable_table,
 	.volatile_table	= &axp15060_volatile_table,
 	.max_register	= AXP15060_IRQ2_STATE,
-	.cache_type	= REGCACHE_RBTREE,
+	.cache_type	= REGCACHE_MAPLE,
 };
 
 #define INIT_REGMAP_IRQ(_variant, _irq, _off, _mask)			\

---
base-commit: 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5
change-id: 20230623-mfd-axp20x-maple-f88e05f3dd31

Best regards,
-- 
Mark Brown <broonie@kernel.org>

