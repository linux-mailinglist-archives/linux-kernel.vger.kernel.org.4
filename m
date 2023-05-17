Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F3F87064A2
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 11:53:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbjEQJxV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 05:53:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229936AbjEQJxT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 05:53:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B653420B;
        Wed, 17 May 2023 02:53:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AD5316397C;
        Wed, 17 May 2023 09:53:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB02DC433EF;
        Wed, 17 May 2023 09:53:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684317197;
        bh=1O71rnHUAVYOpai5MwI9FdkQjUuXGmcfH/UvyTLdUcM=;
        h=From:To:Cc:Subject:Date:From;
        b=oFreSjh/FO+Twy9XWAkOLaCUaI8lajqkYvSvf2X4l75qhDxHw6CyPuos1ysw7aJxu
         Djv9zGrLD+qvG0O5r9TDpFrGpxgrTvGOKAqB4ht9brZCoHAchGoUof6OurwyOghY1g
         6g+nGeKRMhqr5LNfFTGIv8IxpRRc2dw9B6AY3L27oF5N6U3Mmb3wuSIETVLVwGvKMz
         mFgRl644I2B+ApLsZTtPWwaA5/N8W+6eAaMlbX/bdtLxdYmN/qJw8RFB378vcGAuox
         1UZ/TR9j1y7ezCPJijypDzjTqXXn1hf3fqB7EtPUQqy+6C/ButzeoPGWzlGiZoTTeh
         ExE+q5aMGETEg==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] gpio: sa1100: include <mach/generic.h>
Date:   Wed, 17 May 2023 11:52:53 +0200
Message-Id: <20230517095301.903567-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

sa1100_init_gpio() is declared in a machine specific header so it
can be called from platform code, but the definition is in the device
driver, which causes a warning:

drivers/gpio/gpio-sa1100.c:310:13: error: no previous prototype for 'sa1100_init_gpio' [-Werror=missing-prototypes]

It's already possible to include mach/generic.h from drivers, so add
this one here as well.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
v2: rebase back on mainline tree
---
 drivers/gpio/gpio-sa1100.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpio/gpio-sa1100.c b/drivers/gpio/gpio-sa1100.c
index edff5e81489f..242dad763ac4 100644
--- a/drivers/gpio/gpio-sa1100.c
+++ b/drivers/gpio/gpio-sa1100.c
@@ -12,6 +12,7 @@
 #include <soc/sa1100/pwer.h>
 #include <mach/hardware.h>
 #include <mach/irqs.h>
+#include <mach/generic.h>
 
 struct sa1100_gpio_chip {
 	struct gpio_chip chip;
-- 
2.39.2

