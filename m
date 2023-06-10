Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABBBD72AA72
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 11:06:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231791AbjFJJEe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jun 2023 05:04:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbjFJJEb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jun 2023 05:04:31 -0400
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2547935B6
        for <linux-kernel@vger.kernel.org>; Sat, 10 Jun 2023 02:04:29 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id 47F215FD0C;
        Sat, 10 Jun 2023 12:04:26 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1686387866;
        bh=xdrE0qSZT9DJMknXlOlA3GHw6tt6TuBcUDeBnwfeW5U=;
        h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
        b=nZWZ6Om6Mf5PtBD39msvoiY+AyLIyz+WL1YthOLd6zmvxqMEhWPB8tL+3L8eNyW83
         /hIc0vzOpwSFz0H8Rtn18pt6VjCyurahmdLMviJy9iCBT44hD86TYrRhFkH1zw32fA
         uHTh2qvcy03MooEciaT7r7tv5tIcHfisPxVgheqlXxzr53Gao/oB+ydpfMLAnzsy3B
         1WQYoggEt++Fe2Rs6ttbAk3Zw+wY2/dvAWNDfik/2Mul8vTlIFsAL/CtarNRfT4zDT
         IXGa85AhoXlVKqx7yH3WJJJqV481O04Y9W2DHqmru/fPyE2CiDXb389cKdul028cdo
         Wjf4g9ZHymlIA==
Received: from S-MS-EXCH02.sberdevices.ru (S-MS-EXCH02.sberdevices.ru [172.16.1.5])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Sat, 10 Jun 2023 12:04:25 +0300 (MSK)
From:   Alexey Romanov <avromanov@sberdevices.ru>
To:     <narmstrong@baylibre.com>, <neil.armstrong@linaro.org>,
        <khilman@baylibre.com>, <jbrunet@baylibre.com>,
        <martin.blumenstingl@googlemail.com>
CC:     <linux-arm-kernel@lists.infradead.org>, <kernel@sberdevices.ru>,
        <linux-amlogic@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        "Alexey Romanov" <avromanov@sberdevices.ru>
Subject: [PATCH v1] drivers: meson: secure-pwrc: always enable DMA domain
Date:   Sat, 10 Jun 2023 12:04:14 +0300
Message-ID: <20230610090414.90529-1-avromanov@sberdevices.ru>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.16.1.6]
X-ClientProxiedBy: S-MS-EXCH02.sberdevices.ru (172.16.1.5) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2023/06/10 03:45:00 #21472184
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

Starting from commit e45f243409db ("firmware: meson_sm:
populate platform devices from sm device tree data") pwrc
is probed successfully and disables unused pwr domains.
By A1 SoC family design, any TEE requires DMA pwr domain
always enabled.

Signed-off-by: Alexey Romanov <avromanov@sberdevices.ru>
---
I'm not entirely sure if this domain should always be enabled on or it
should be separately enabled in dts file. Comments are welcome.
---
 drivers/soc/amlogic/meson-secure-pwrc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/amlogic/meson-secure-pwrc.c b/drivers/soc/amlogic/meson-secure-pwrc.c
index e93518763526..25b4b71df9b8 100644
--- a/drivers/soc/amlogic/meson-secure-pwrc.c
+++ b/drivers/soc/amlogic/meson-secure-pwrc.c
@@ -105,7 +105,7 @@ static struct meson_secure_pwrc_domain_desc a1_pwrc_domains[] = {
 	SEC_PD(ACODEC,	0),
 	SEC_PD(AUDIO,	0),
 	SEC_PD(OTP,	0),
-	SEC_PD(DMA,	0),
+	SEC_PD(DMA,	GENPD_FLAG_ALWAYS_ON | GENPD_FLAG_IRQ_SAFE),
 	SEC_PD(SD_EMMC,	0),
 	SEC_PD(RAMA,	0),
 	/* SRAMB is used as ATF runtime memory, and should be always on */
-- 
2.30.1

