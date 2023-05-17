Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93374706664
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 13:15:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231315AbjEQLPW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 07:15:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231301AbjEQLOx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 07:14:53 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D5CA420E
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 04:14:49 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-965f7bdab6bso111919766b.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 04:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684322088; x=1686914088;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hg++FY7yhGIzwZILizitxUpO+7bfMUehzjto7GaiR9Q=;
        b=QqGyQVcP+weCBDwAlfPGPZeH7eur+A3XKLVELVFzsWtZeDa7EsfvnyemqYCx8tfCso
         zOrofL/zOLGID7x8MwR30/XR59YqTg6r/In4AqWvuGtx74kLRZUPGQmL5hE7w4SPgqYJ
         0GUTOUkDk82Bb29FXqsk8pfyiH19q8+t5AhX17sBgZe1yZrr4CIrdBj1eN+XHUyYRDBE
         d4Xh9182yu35iRsGleQ97I/W2rPAftQCyoUARli+pbGhkOf1Ur3sk44FNy+kTqB4tEDj
         SpE+jAq8Y9nUdeVZqMOafAEPfIociyC8A8fp9Ms6a6Zb47kbcL+bF0yJw9fpE4q+6mD/
         nWog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684322088; x=1686914088;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hg++FY7yhGIzwZILizitxUpO+7bfMUehzjto7GaiR9Q=;
        b=fP0IAa4keAbfDgIOd00BjRlkYwPi0GvWCi58V41T48uyLwL4w2wTQsdsE/RZRuBFNK
         g+5wwswQkUmOY73rGhTA3SIfh/0wrPWwDO3qpJzI9PtyWZUKX4CpbF9vNpn/xLV7DeV5
         UUA0Lont8OFlGVifhZcfRO5Ink9X6Xlm0ZBwIsR/CsVe0Cc8h8t30MsHbs/VeycwscJR
         N2mqTARXnZyiA1BAC0IWxCfJT224NEvdUKBLghv5Ayts5IeJFg4UHKAJeOVmB6927ZiE
         BzwbD3Wh6mBkmIZRvj5Hc4gil7K+rYtLqnY8DaiLSF0ji+xZigngY+e9HcyXYznpZTnL
         rXYA==
X-Gm-Message-State: AC+VfDxnvvKdS4AlaznNzP0dri4NgZqD8FnxMKMVli3LE2XHk57gCoyL
        5rAhpq7G1f4NGdmRfYS8dGlHzA==
X-Google-Smtp-Source: ACHHUZ6agdt+8cNAIrQlXTt4TZimiL3AU9u8hB11RhwhOm4cME5bRrbuGTkjGC1nNc9gCeh7XqrNVw==
X-Received: by 2002:a17:907:9496:b0:96a:ff7f:692 with SMTP id dm22-20020a170907949600b0096aff7f0692mr10101998ejc.68.1684322088601;
        Wed, 17 May 2023 04:14:48 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:c9ff:4c84:dd21:568d])
        by smtp.gmail.com with ESMTPSA id ml18-20020a170906cc1200b0094f124a37c4sm12326880ejb.18.2023.05.17.04.14.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 04:14:48 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Oder Chiou <oder_chiou@realtek.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 10/12] ASoC: codecs: rt715-sdca: do not store status in state container
Date:   Wed, 17 May 2023 13:14:14 +0200
Message-Id: <20230517111416.424420-10-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230517111416.424420-1-krzysztof.kozlowski@linaro.org>
References: <20230517111416.424420-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Driver in its update status callback stores Soundwire device status in
state container but it never uses it later.  Simplify the code a bit.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 sound/soc/codecs/rt715-sdca-sdw.c | 5 +----
 sound/soc/codecs/rt715-sdca.h     | 1 -
 2 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/sound/soc/codecs/rt715-sdca-sdw.c b/sound/soc/codecs/rt715-sdca-sdw.c
index 38a82e4e2f95..7e5ddce8097d 100644
--- a/sound/soc/codecs/rt715-sdca-sdw.c
+++ b/sound/soc/codecs/rt715-sdca-sdw.c
@@ -121,14 +121,11 @@ static int rt715_sdca_update_status(struct sdw_slave *slave,
 {
 	struct rt715_sdca_priv *rt715 = dev_get_drvdata(&slave->dev);
 
-	/* Update the status */
-	rt715->status = status;
-
 	/*
 	 * Perform initialization only if slave status is present and
 	 * hw_init flag is false
 	 */
-	if (rt715->hw_init || rt715->status != SDW_SLAVE_ATTACHED)
+	if (rt715->hw_init || status != SDW_SLAVE_ATTACHED)
 		return 0;
 
 	/* perform I/O transfers required for Slave initialization */
diff --git a/sound/soc/codecs/rt715-sdca.h b/sound/soc/codecs/rt715-sdca.h
index 7577f3151934..e5d6928ecaba 100644
--- a/sound/soc/codecs/rt715-sdca.h
+++ b/sound/soc/codecs/rt715-sdca.h
@@ -24,7 +24,6 @@ struct rt715_sdca_priv {
 	int dbg_nid;
 	int dbg_vid;
 	int dbg_payload;
-	enum sdw_slave_status status;
 	struct sdw_bus_params params;
 	bool hw_init;
 	bool first_hw_init;
-- 
2.34.1

