Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90733705FA4
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 07:58:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232560AbjEQF6f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 01:58:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232558AbjEQF6c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 01:58:32 -0400
X-Greylist: delayed 453 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 16 May 2023 22:58:31 PDT
Received: from thorn.bewilderbeest.net (thorn.bewilderbeest.net [IPv6:2605:2700:0:5::4713:9cab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22C202729;
        Tue, 16 May 2023 22:58:30 -0700 (PDT)
Received: from hatter.bewilderbeest.net (174-21-172-149.tukw.qwest.net [174.21.172.149])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: zev)
        by thorn.bewilderbeest.net (Postfix) with ESMTPSA id 99B0F6DF;
        Tue, 16 May 2023 22:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bewilderbeest.net;
        s=thorn; t=1684302655;
        bh=+tnO7BfGQlwxHNrnSuMx4B9JwM2zlElAG5v5xkIN+3I=;
        h=From:To:Cc:Subject:Date:From;
        b=ktyoLfJKpbYfN2B3AvyqFhl3/c3kf+aDNoHoiEsmcuj0tBaaXlib2p5HoV+9fkqYD
         iw7Gb4JZGpRBRxGEYo3b1c4DgbU8LrGBFrkN3YNKtENofZ4nNvh5bvopi1Lr7SXxHl
         H5pAI55ICD7/aEugtJ1io23O3N1OhWogfRw4lQOU=
From:   Zev Weiss <zev@bewilderbeest.net>
To:     Bamvor Jian Zhang <bamv2005@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Zev Weiss <zev@bewilderbeest.net>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@kernel.org
Subject: [PATCH] gpio: mockup: Fix mode of debugfs files
Date:   Tue, 16 May 2023 22:47:56 -0700
Message-Id: <20230517054756.11119-1-zev@bewilderbeest.net>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver's debugfs files have had a read operation since commit
2a9e27408e12 ("gpio: mockup: rework debugfs interface"), but were
still being created with write-only mode bits.  Update them to
indicate that the files can also be read.

Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
Fixes: 2a9e27408e12 ("gpio: mockup: rework debugfs interface")
Cc: stable@kernel.org # v5.1+
---
 drivers/gpio/gpio-mockup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-mockup.c b/drivers/gpio/gpio-mockup.c
index e6a7049bef64..b32063ac845a 100644
--- a/drivers/gpio/gpio-mockup.c
+++ b/drivers/gpio/gpio-mockup.c
@@ -369,7 +369,7 @@ static void gpio_mockup_debugfs_setup(struct device *dev,
 		priv->offset = i;
 		priv->desc = gpiochip_get_desc(gc, i);
 
-		debugfs_create_file(name, 0200, chip->dbg_dir, priv,
+		debugfs_create_file(name, 0600, chip->dbg_dir, priv,
 				    &gpio_mockup_debugfs_ops);
 	}
 }
-- 
2.40.1

