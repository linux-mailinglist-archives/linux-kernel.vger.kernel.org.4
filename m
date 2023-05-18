Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E886707AD3
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 09:28:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230159AbjERH21 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 03:28:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230108AbjERH2G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 03:28:06 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 711D4213A
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 00:28:05 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-965b5f3b9ffso177815466b.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 00:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684394884; x=1686986884;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fXL5o5qPvph6Jym30uHyOqMAZEOM4W+jtVScVxTiDlk=;
        b=ryT3oII2qDSHvEnNd8R3Sxowcji9SoTEbJkcGp19IIs+FWqR5+MsE+p0x5qh15PDQd
         i6kTbi07i9WT+RjRbfYWccwFP297hTr1IW9+vIW4y4ldZsySI2GacVMRsOWHWD8vRcXw
         fCCnIuBKoI3pQB7+fpAmk5rlAASAmGvL26SC0XR8c6iX5K3N3H6oIawvpL+EHYoS3M5v
         HIx3FfeqyJLxmgdWEtMNZpAKwrdmlAmTdwGVSFpHRDWy8/1qpho/tf2ePrHktnIReFPK
         3viszkD0I3ZkFL5h9H4v05K/ZzLF1WRU3TmaQZb8h16t18DKTxcZ8XTnXie3BvMdrFJf
         PcHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684394884; x=1686986884;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fXL5o5qPvph6Jym30uHyOqMAZEOM4W+jtVScVxTiDlk=;
        b=lr+UQ7Pl69eovTjKnbMf/15cXcvBURrlAV6UG78n9Swaba5YWF7cvfMzA5QXNmuHg/
         59wpYqCaOGMm82oCOpYc2ybriDulOwE5O/t6V1EMWG71KSv6d8M5RyYwO7qR3vAwXHjH
         jWtwbORsk8U0BJkMI4paRMNB3qzTuM3vZt66zdmRx5cJwL05HRCTYgggGQxUAnBBz0Do
         Hu0RMPw9ywYIDCA6Q5op30W9zjKquinOEWrI+j8/nB0q8/K35ngMFshv6TpC5lM8owlK
         4JbxKTrZhDrvD1sPJtQtxneLr3/skyKqKwDKDZCJ1VBGnEcrgH9gTYfgUOcRMzFLR0qo
         113Q==
X-Gm-Message-State: AC+VfDx47ZV41pe3imoujVFBtP7U9v7AIC/GC4jK78KjESsoZh7f3Jsv
        TEL1QnCe3BY+aj3weu2BhpTT+fliXd37WVZjVrVvJA==
X-Google-Smtp-Source: ACHHUZ6jvtLDiIknXfnlrRB0KFzN9p8chuhdTxU60B7h54mon8DHKl9rh8r1GsMm+rETremULB/ksA==
X-Received: by 2002:a17:907:3d93:b0:94a:4739:bed9 with SMTP id he19-20020a1709073d9300b0094a4739bed9mr5233414ejc.13.1684394883911;
        Thu, 18 May 2023 00:28:03 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:a2b:c408:5834:f48e])
        by smtp.gmail.com with ESMTPSA id g17-20020a17090669d100b00965aee5be9asm594241ejs.170.2023.05.18.00.28.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 00:28:03 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Oder Chiou <oder_chiou@realtek.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [RESEND PATCH 06/12] ASoC: codecs: rt711-sdca: do not store status in state container
Date:   Thu, 18 May 2023 09:27:47 +0200
Message-Id: <20230518072753.7361-7-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230518072753.7361-1-krzysztof.kozlowski@linaro.org>
References: <20230518072753.7361-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Driver in its update status callback stores Soundwire device status in
state container but it never uses it later.  Simplify the code a bit.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/codecs/rt711-sdca-sdw.c | 5 +----
 sound/soc/codecs/rt711-sdca.h     | 1 -
 2 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/sound/soc/codecs/rt711-sdca-sdw.c b/sound/soc/codecs/rt711-sdca-sdw.c
index 51f3335343e0..2c5eb28259dc 100644
--- a/sound/soc/codecs/rt711-sdca-sdw.c
+++ b/sound/soc/codecs/rt711-sdca-sdw.c
@@ -143,9 +143,6 @@ static int rt711_sdca_update_status(struct sdw_slave *slave,
 {
 	struct rt711_sdca_priv *rt711 = dev_get_drvdata(&slave->dev);
 
-	/* Update the status */
-	rt711->status = status;
-
 	if (status == SDW_SLAVE_UNATTACHED)
 		rt711->hw_init = false;
 
@@ -168,7 +165,7 @@ static int rt711_sdca_update_status(struct sdw_slave *slave,
 	 * Perform initialization only if slave status is present and
 	 * hw_init flag is false
 	 */
-	if (rt711->hw_init || rt711->status != SDW_SLAVE_ATTACHED)
+	if (rt711->hw_init || status != SDW_SLAVE_ATTACHED)
 		return 0;
 
 	/* perform I/O transfers required for Slave initialization */
diff --git a/sound/soc/codecs/rt711-sdca.h b/sound/soc/codecs/rt711-sdca.h
index 22076f268577..11d421e8ab2b 100644
--- a/sound/soc/codecs/rt711-sdca.h
+++ b/sound/soc/codecs/rt711-sdca.h
@@ -19,7 +19,6 @@ struct  rt711_sdca_priv {
 	struct regmap *regmap, *mbq_regmap;
 	struct snd_soc_component *component;
 	struct sdw_slave *slave;
-	enum sdw_slave_status status;
 	struct sdw_bus_params params;
 	bool hw_init;
 	bool first_hw_init;
-- 
2.34.1

