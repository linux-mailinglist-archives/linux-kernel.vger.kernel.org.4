Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A37A640AFD
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 17:42:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233600AbiLBQmI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 11:42:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234087AbiLBQmA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 11:42:00 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01E42C7243;
        Fri,  2 Dec 2022 08:42:00 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id d1so8606489wrs.12;
        Fri, 02 Dec 2022 08:41:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NBhUhPdweZ3fTupviVjoDkaZ/Bzxjb/TM6/+Uzw6tYM=;
        b=W3qrvxNWQG18OXMSTFZQkIOrmn9ZkqxlS3C/C5VDGgmacy8F6t4GEmPN7+nIzI3R1W
         UQjqIBsFhs2EmDiU4IouSTnNwPv6jUb97Il4+HByArzo6uADGnPWEGKJLJ0rOnvWxX1Q
         f7y6wk9Q+rYhTodh2rXoXvfytFFWNLtzU0x8mLSiy9Oj/a0izKbpcO//QAVdGSHCTEQg
         x7K8L8ymNYZvoApuerQTVuOL6ysZ97HpDjOG0FG8GgNNUBbRBrKcD2VJFGysU5557HPv
         5o7o9qy8DYTXJzniz5BXdgMtT2ot4J5sVDErgRFSi7f57gVONYVkQTVbHGLr6WJsqv3J
         dNOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NBhUhPdweZ3fTupviVjoDkaZ/Bzxjb/TM6/+Uzw6tYM=;
        b=HrmbnKlJ9KIXdDGDUkGCJ6p0MIkiu2LQB90jCvNcOPVSEVWeBI6/6qx/J8/jGZtnf6
         ElgbccdIcQdDtNVto0GCbPSBOvEqdHaKcCGw6nQrAihiEV8nXoXuIzYZHL04T8bt+7oh
         Uce2tpbBJ9hh01cXqJYg5OVjmt75J7dIWOY4ddoZNpsz1AtPgfPefis+p5+3lUfD4I66
         1pBoGuvYXdlvN38Tg2InopRkzwJuVO4TCAtuRsFWrwUfkfHPJh6pdR0/2i8nfOvZ5cGu
         uBG15sIf3aFEcQXD/+aQmaWixmbZUqchEsaFElkO/usAiy+4vdM2sh8NWfOt+FC+YsUr
         B1Kw==
X-Gm-Message-State: ANoB5pl2xu4xDP5U9c1Q55nC7ewk2waxQ8sCF7341+/JAN+gXbR1/dnQ
        LG2WklM0EK8urOpecnZwkLo0xbekiIbDTVU7
X-Google-Smtp-Source: AA0mqf684oIN5gBFoOCtGHGhakQpJrnScN39W14mgEhGfEioE0MUho6Hs0PFLef9eXd4F5q208iQ/A==
X-Received: by 2002:a5d:46d1:0:b0:242:4698:f0a7 with SMTP id g17-20020a5d46d1000000b002424698f0a7mr2151557wrs.77.1669999318410;
        Fri, 02 Dec 2022 08:41:58 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id q17-20020a05600000d100b0024207ed4ce0sm7491149wrx.58.2022.12.02.08.41.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 08:41:57 -0800 (PST)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] ASoC: uniphier: aio-core: Make some read-only arrays static const
Date:   Fri,  2 Dec 2022 16:41:56 +0000
Message-Id: <20221202164156.1812971-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Don't populate the read-only arrays slotsel_2ch, slotsel_multi, v_pll
and v_div on the stack but instead make them static const. Also makes
the object code a little smaller.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 sound/soc/uniphier/aio-core.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/sound/soc/uniphier/aio-core.c b/sound/soc/uniphier/aio-core.c
index b8195778953e..0eba60758134 100644
--- a/sound/soc/uniphier/aio-core.c
+++ b/sound/soc/uniphier/aio-core.c
@@ -277,17 +277,18 @@ void aio_port_reset(struct uniphier_aio_sub *sub)
 static int aio_port_set_ch(struct uniphier_aio_sub *sub)
 {
 	struct regmap *r = sub->aio->chip->regmap;
-	u32 slotsel_2ch[] = {
+	static const u32 slotsel_2ch[] = {
 		0, 0, 0, 0, 0,
 	};
-	u32 slotsel_multi[] = {
+	static const u32 slotsel_multi[] = {
 		OPORTMXTYSLOTCTR_SLOTSEL_SLOT0,
 		OPORTMXTYSLOTCTR_SLOTSEL_SLOT1,
 		OPORTMXTYSLOTCTR_SLOTSEL_SLOT2,
 		OPORTMXTYSLOTCTR_SLOTSEL_SLOT3,
 		OPORTMXTYSLOTCTR_SLOTSEL_SLOT4,
 	};
-	u32 mode, *slotsel;
+	u32 mode;
+	const u32 *slotsel;
 	int i;
 
 	switch (params_channels(&sub->params)) {
@@ -515,13 +516,13 @@ static int aio_port_set_clk(struct uniphier_aio_sub *sub)
 	struct uniphier_aio_chip *chip = sub->aio->chip;
 	struct device *dev = &sub->aio->chip->pdev->dev;
 	struct regmap *r = sub->aio->chip->regmap;
-	u32 v_pll[] = {
+	static const u32 v_pll[] = {
 		OPORTMXCTR2_ACLKSEL_A1, OPORTMXCTR2_ACLKSEL_F1,
 		OPORTMXCTR2_ACLKSEL_A2, OPORTMXCTR2_ACLKSEL_F2,
 		OPORTMXCTR2_ACLKSEL_A2PLL,
 		OPORTMXCTR2_ACLKSEL_RX1,
 	};
-	u32 v_div[] = {
+	static const u32 v_div[] = {
 		OPORTMXCTR2_DACCKSEL_1_2, OPORTMXCTR2_DACCKSEL_1_3,
 		OPORTMXCTR2_DACCKSEL_1_1, OPORTMXCTR2_DACCKSEL_2_3,
 	};
-- 
2.38.1

