Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8A4970666B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 13:15:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231359AbjEQLPc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 07:15:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231140AbjEQLPA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 07:15:00 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 929EF2D66
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 04:14:52 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-510bcd2d6b8so5692290a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 04:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684322092; x=1686914092;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VnIEpqHICz7MCR44hDCQrdJI2TjC+iEi+weDD/DiHgQ=;
        b=uMpMaqG1DqCWwx1hCI5PuOhkim7/TDAijWwMpe1ydZKEw+qIhizYVg/cft4VQapzD4
         vzRLPboKiuQD0ZoY9vRl7zLw4E7JgW6k5CzgJIlwjvUz6TVW1XPRsfFF2wWQ4R14/pZi
         pAn7ChTywYn6exjMI1vNn5Ih0jSFSXn7AgpetOMZhQr7x0kzU1k+kk9zfhRC/JIaArDl
         SvoXQkKGfjFzJnPROvYxvC77bUGONoLXl+YQnBK7TWVdHGzUMY0mmb10gDIlZkXpNXgc
         VmvfNO4QTLaSiJPS+ROPLbAm2awcyFtVjD0nDsFHebUVzUYXb0H8js0WQ+bS39DRONlF
         zj1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684322092; x=1686914092;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VnIEpqHICz7MCR44hDCQrdJI2TjC+iEi+weDD/DiHgQ=;
        b=jMwzy9JlYEuuS+389bhR91niYx2oD2HcveL84P9eR5BTwxn8dKTTPA5ekNBmalA008
         Seorr8Q2oNDoIM6ZXpI15sVy2oFA0+lUBaF3V5Vf7ySCiegk/6y65pFJpztE7O2+/qt9
         fxXt3X6dTKhAolsf56JUvAM86svB9CcBAkZ+o/pRMENYXRTrAST17PGHRPQ38SeKH527
         9fbnosGsCUuVtLcm83wSLenXkNu5Wf+7xXILxV5acGqeQtdCl1+rJL4MIr9S/h8o4AZ+
         zarSwcmtFK3K+OCVz4RUubLln+1CFQQ0g29q61z2co9TXsnXo2kCjfE0bOHutoZlgWII
         jyaw==
X-Gm-Message-State: AC+VfDxG5Jj8b9+iygYloWFbgNMKjw6vR8juKahRdvHzM5PkPx4g33I6
        k04lFNK8af4023QiswOgYa1Jcw==
X-Google-Smtp-Source: ACHHUZ5o/6icRslOMBgpWvrVIHAHLvuvr5xOTVdS5zygNzE9ImG9M96dMpU+Dv/r1s/UxbSnU5g9IA==
X-Received: by 2002:a17:907:6d25:b0:965:d7c7:24db with SMTP id sa37-20020a1709076d2500b00965d7c724dbmr1640573ejc.32.1684322091870;
        Wed, 17 May 2023 04:14:51 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:c9ff:4c84:dd21:568d])
        by smtp.gmail.com with ESMTPSA id ml18-20020a170906cc1200b0094f124a37c4sm12326880ejb.18.2023.05.17.04.14.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 04:14:51 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Oder Chiou <oder_chiou@realtek.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 12/12] ASoC: codecs: rt722-sdca: do not store status in state container
Date:   Wed, 17 May 2023 13:14:16 +0200
Message-Id: <20230517111416.424420-12-krzysztof.kozlowski@linaro.org>
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
 sound/soc/codecs/rt722-sdca-sdw.c | 5 +----
 sound/soc/codecs/rt722-sdca.h     | 1 -
 2 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/sound/soc/codecs/rt722-sdca-sdw.c b/sound/soc/codecs/rt722-sdca-sdw.c
index 0a791a14215e..bfb2dac6bfee 100644
--- a/sound/soc/codecs/rt722-sdca-sdw.c
+++ b/sound/soc/codecs/rt722-sdca-sdw.c
@@ -163,9 +163,6 @@ static int rt722_sdca_update_status(struct sdw_slave *slave,
 {
 	struct rt722_sdca_priv *rt722 = dev_get_drvdata(&slave->dev);
 
-	/* Update the status */
-	rt722->status = status;
-
 	if (status == SDW_SLAVE_UNATTACHED)
 		rt722->hw_init = false;
 
@@ -188,7 +185,7 @@ static int rt722_sdca_update_status(struct sdw_slave *slave,
 	 * Perform initialization only if slave status is present and
 	 * hw_init flag is false
 	 */
-	if (rt722->hw_init || rt722->status != SDW_SLAVE_ATTACHED)
+	if (rt722->hw_init || status != SDW_SLAVE_ATTACHED)
 		return 0;
 
 	/* perform I/O transfers required for Slave initialization */
diff --git a/sound/soc/codecs/rt722-sdca.h b/sound/soc/codecs/rt722-sdca.h
index 5bc6184d09aa..44af8901352e 100644
--- a/sound/soc/codecs/rt722-sdca.h
+++ b/sound/soc/codecs/rt722-sdca.h
@@ -20,7 +20,6 @@ struct  rt722_sdca_priv {
 	struct regmap *mbq_regmap;
 	struct snd_soc_component *component;
 	struct sdw_slave *slave;
-	enum sdw_slave_status status;
 	struct sdw_bus_params params;
 	bool hw_init;
 	bool first_hw_init;
-- 
2.34.1

