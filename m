Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E74271FF6F
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 12:35:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234131AbjFBKfi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 06:35:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235834AbjFBKe6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 06:34:58 -0400
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0312910E3;
        Fri,  2 Jun 2023 03:33:40 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id 2390C5FD03;
        Fri,  2 Jun 2023 13:32:30 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1685701950;
        bh=U2UnoUMYRs9m/BLycNQ2iLq6bQeVm56LTFKDcGw5E4A=;
        h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
        b=dDpfb4nspYq2IX79ggRqGaSgsWFxQt9B9+ivAjCuKkPYK+q/bDLe82NvRXQUIoP+J
         1UgfCSEnRVAf5ne/aOauc+fEm69F8FQcHNj3jabszSu48HnRuxfrN2df70IxJudXUL
         EbvNvDia+9mnO4Yc2jgEksvdVUhgVqGchpdhHZ3m6PqX55BggvX0jUK6f9Y8poxFpZ
         cWQX7YPm52iN0PKBRwsknc5qKJgZX6pM4h4ofywpJyYrEW003YvZ8+H+HYySWIge0D
         wMaJq5LKgKm+TuCkbyW0xzWe44pGE7/VvS1mPdJvdQtxM6Wr43p6CZh8SGtVssXyPz
         w2WiIR79N/Yvg==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Fri,  2 Jun 2023 13:32:29 +0300 (MSK)
From:   George Stark <gnstark@sberdevices.ru>
To:     <thierry.reding@gmail.com>, <u.kleine-koenig@pengutronix.de>,
        <neil.armstrong@linaro.org>, <khilman@baylibre.com>,
        <jbrunet@baylibre.com>, <martin.blumenstingl@googlemail.com>,
        <hkallweit1@gmail.com>
CC:     <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-amlogic@lists.infradead.org>, <kernel@sberdevices.ru>,
        George Stark <GNStark@sberdevices.ru>,
        Dmitry Rokosov <ddrokosov@sberdevices.ru>
Subject: [PATCH] pwm: meson: compute cnt register value in proper way
Date:   Fri, 2 Jun 2023 13:32:11 +0300
Message-ID: <20230602103211.2199283-1-gnstark@sberdevices.ru>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.16.1.6]
X-ClientProxiedBy: S-MS-EXCH02.sberdevices.ru (172.16.1.5) To
 S-MS-EXCH01.sberdevices.ru (172.16.1.4)
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2023/06/02 03:06:00 #21401484
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to the datasheet, the PWM high and low clock count values
should be set to at least one. Therefore, setting the clock count
register to 0 actually means 1 clock count.

Signed-off-by: George Stark <GNStark@sberdevices.ru>
Signed-off-by: Dmitry Rokosov <ddrokosov@sberdevices.ru>
---
This patch is based on currently unmerged patch by Heiner Kallweit
https://lore.kernel.org/linux-amlogic/23fe625e-dc23-4db8-3dce-83167cd3b206@gmail.com
---
diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
index 834acd7..57e7d9c 100644
--- a/drivers/pwm/pwm-meson.c
+++ b/drivers/pwm/pwm-meson.c
@@ -206,6 +206,11 @@
 		channel->pre_div = pre_div;
 		channel->hi = duty_cnt;
 		channel->lo = cnt - duty_cnt;
+
+		if (channel->hi)
+			channel->hi--;
+		if (channel->lo)
+			channel->lo--;
 	}
 
 	return 0;
@@ -340,7 +345,8 @@
 	channel->lo = FIELD_GET(PWM_LOW_MASK, value);
 	channel->hi = FIELD_GET(PWM_HIGH_MASK, value);
 
-	state->period = meson_pwm_cnt_to_ns(chip, pwm, channel->lo + channel->hi);
+	state->period = meson_pwm_cnt_to_ns(chip, pwm,
+					    channel->lo + 1 + channel->hi + 1);
 	state->duty_cycle = meson_pwm_cnt_to_ns(chip, pwm, channel->hi);
 
 	return 0;
