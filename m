Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DC0E649693
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Dec 2022 22:58:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229461AbiLKV6S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Dec 2022 16:58:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiLKV6P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Dec 2022 16:58:15 -0500
Received: from relay10.mail.gandi.net (relay10.mail.gandi.net [IPv6:2001:4b98:dc4:8::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFF0B626B;
        Sun, 11 Dec 2022 13:58:13 -0800 (PST)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 98805240003;
        Sun, 11 Dec 2022 21:58:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1670795891;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Gn2wozbp6UyyW3PSzzTKHcaffuxRTyrivYdS1OSvB80=;
        b=iiuJJraB2yHN/8rtn9HhMb03Cnahm5piBbrQrTrNZpLD42cKbqtXfviul9U+OC03XKetxG
        z5tLeAQg9MhrBBXzJO+qf79vf1nJhsgv1qfhgSd9ZrTuhGtWwkedZeZO2C6kjO8QZh1lU+
        vTGU3tjGlblxEBmlFJchb/adefeVuirqMwEAS7sIvywt+Tutm2fTj50nuSGFgWdbXPmQgu
        F6rqse6lvXQM9jbng0yVkwMrPcETdNOummMHSg5+TaXj4omqbkM2PbyKZFUk/V/hzS15Vi
        5vJTylXwK8hdznfmm1bwVCWNbn6wbwb2/AFSDrYcii9RYaYe1ENkLzD+L8GfdA==
From:   alexandre.belloni@bootlin.com
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     kernel test robot <lkp@intel.com>, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] rtc: rx6110: fix warning with !OF
Date:   Sun, 11 Dec 2022 22:57:55 +0100
Message-Id: <20221211215756.54002-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexandre Belloni <alexandre.belloni@bootlin.com>

rx6110_spi_of_match is not used when !OF, leading to a warning:

>> drivers/rtc/rtc-rx6110.c:384:34: warning: 'rx6110_spi_of_match' defined but not used [-Wunused-const-variable=]
     384 | static const struct of_device_id rx6110_spi_of_match[] = {
         |                                  ^~~~~~~~~~~~~~~~~~~

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-rx6110.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-rx6110.c b/drivers/rtc/rtc-rx6110.c
index cc634558b928..76a49838014b 100644
--- a/drivers/rtc/rtc-rx6110.c
+++ b/drivers/rtc/rtc-rx6110.c
@@ -376,7 +376,7 @@ static const struct spi_device_id rx6110_spi_id[] = {
 };
 MODULE_DEVICE_TABLE(spi, rx6110_spi_id);
 
-static const struct of_device_id rx6110_spi_of_match[] = {
+static const __maybe_unused struct of_device_id rx6110_spi_of_match[] = {
 	{ .compatible = "epson,rx6110" },
 	{ },
 };
-- 
2.38.1

