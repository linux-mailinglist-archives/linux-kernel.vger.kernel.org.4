Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9984D72AC19
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 16:05:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235030AbjFJOFd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jun 2023 10:05:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbjFJOFa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jun 2023 10:05:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 357801984;
        Sat, 10 Jun 2023 07:05:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C61CF60FB5;
        Sat, 10 Jun 2023 14:05:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C84AC433D2;
        Sat, 10 Jun 2023 14:05:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686405928;
        bh=4F32DwLg6Rr6AdgDkL7pW4vNiCCunXcliQBuqU3PDZs=;
        h=From:Date:Subject:To:Cc:From;
        b=jJXddgvFvvVQIt0qsHhZExQrU8HbU0NPGLLOCg+pKXvcWRH9N2wllaBlyjbbQUbHW
         DTPzy5p6L3uqqI7Xn8+OCArOqrqRJe+/TJNgK+cZJFpT2clwP34vmw1yex6EerT8DA
         VuARGRknNfB9JQiistZOgxtMg7++czuft9JjZhu3xWi1g36lgkeeWuuBrdTKV4jebt
         6VSofvyA4CCVSsUU3JL1RPU1msHwj/qkvUzMUoI0ABIba+hLntxHG6s/zRwQwmbTT1
         vVWez0zdOPWtrimbu3frGtRO7vC/B2efn/C0oZfMYNThOHgMScbMUyIh1ZINbPUoQe
         I0UKMyQ6/8W7Q==
From:   Mark Brown <broonie@kernel.org>
Date:   Sat, 10 Jun 2023 15:05:21 +0100
Subject: [PATCH] mfd: twl6040: Use maple tree register cache
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230609-mfd-twl6040-maple-v1-1-3493d051cd6f@kernel.org>
X-B4-Tracking: v=1; b=H4sIACCDhGQC/x2NQQqDMBAAvyJ77sKaqph+pXiIutGlGmUjWhD/3
 tjjDAxzQmQVjvDKTlDeJcoSEuSPDLrRhYFR+sRgyDypIouz73E7pooKwtmtEyNZKkpb1zb3BlL
 XusjYqgvdeJfHop9br8pevv/Vu7muH3oTmjx6AAAA
To:     Tony Lindgren <tony@atomide.com>, Lee Jones <lee@kernel.org>
Cc:     linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-bfdf5
X-Developer-Signature: v=1; a=openpgp-sha256; l=1021; i=broonie@kernel.org;
 h=from:subject:message-id; bh=4F32DwLg6Rr6AdgDkL7pW4vNiCCunXcliQBuqU3PDZs=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBkhIMl7Ky+j1H5GvBqGWhJUIsVw4YhB2O94Esarh8W
 jq23PpiJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZISDJQAKCRAk1otyXVSH0NomB/
 0f6DiDSaBQn7vG3WQWnkmXH5PDTbx3lmwRgTZ/WksgUHBcd+oe3sKn8VZofduwHovMSm9Bu2aKuHPA
 oMBUzL0xFfREjtAwEU6mYsP/i7ut58Ow67Xk7/lfaMjfiMuF4biIBES5CjJlnMsbZeF+SjO3URsWZR
 +0gcAhYI97IVhwzderXyjh8IncmITsOYlLAPFGSE9OIOStfP66yCtlh2TG1Kw2W+P1ngT4+/+MI9Jj
 LFQGmlPEjcXnLyAV32jOKXM4zgenuZT8kZ7WRUGoLaPs9jqkGQQm8HS2P021AKJbgFO8+jQHwKXHFT
 a5PwGqX+rrI220WeH/10Yc1Qp5rQfZ
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The twl6040 is only capable of performing single register read and write
operations which means it gains no advantage from using a rbtree register
cache, convert it to using the more modern maple tree register cache
instead. This should be more efficient.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/mfd/twl6040.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/twl6040.c b/drivers/mfd/twl6040.c
index e982119bbefa..523439a16b7c 100644
--- a/drivers/mfd/twl6040.c
+++ b/drivers/mfd/twl6040.c
@@ -608,7 +608,7 @@ static const struct regmap_config twl6040_regmap_config = {
 	.volatile_reg = twl6040_volatile_reg,
 	.writeable_reg = twl6040_writeable_reg,
 
-	.cache_type = REGCACHE_RBTREE,
+	.cache_type = REGCACHE_MAPLE,
 	.use_single_read = true,
 	.use_single_write = true,
 };

---
base-commit: 9561de3a55bed6bdd44a12820ba81ec416e705a7
change-id: 20230609-mfd-twl6040-maple-0904598891f2

Best regards,
-- 
Mark Brown <broonie@kernel.org>

