Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6D9170665D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 13:15:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230430AbjEQLPI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 07:15:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231173AbjEQLOs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 07:14:48 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C52136189
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 04:14:44 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-9661a1ff1e9so89016566b.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 04:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684322083; x=1686914083;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Djo3KigDLCeskb1s75wtfFqne73QM8Ssl3dvuMpTj8I=;
        b=jbpNsTPcndoFQHxB+zZE1pvWH6PB3oOk0GGSHncVFq60Pzl6/guO3elUgCzUb1JJ+Q
         PQViAH4X+DushQPeB5Y5oeEEQEDP3KD/iPA0Ba77Q1ahp2/9sa+QlD2OOprF3UBIrBJ6
         34Co2bwv+wutKc8XkhQCkHobGDC9RF38e1IxFFGN4RV19S759tGHdeMOdsqFQ1G9bmcS
         WMgKTAtKG1OC927Cy8zgj0w2ELDbAcK4InSxId+JgPETgPIQcBnlUrIIJMJ9OC+DHO8p
         SsFH+tQwFz9uLp9jUA7Jb7HwfnADeDu7jdutszLl1wIveRUC8OV4jK+Iw0uwUZ86jtUx
         Zl3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684322083; x=1686914083;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Djo3KigDLCeskb1s75wtfFqne73QM8Ssl3dvuMpTj8I=;
        b=XhsXXA/Yr2gcRmY0u0NbnM86Lev0Y1H983JNSyRbpkef22zL6GxYtczZGFXwGeauzp
         L9V0jIMrXfK70ilOtUTHRqjBghWS7FOTNsgUY1N1RRdNDkc2vhgzG0/Uww9LZf3QbIH1
         VGBk061Z2eqDQMIydPjc0ozXTU6vcMUewFQspGqsJWGZdvYwMeEBRdsdVcYBdib2opVQ
         SG5CQf1nWANi7iAzJ9ERf9phWswPQq2LEqbLYbq/Qk1DdF2lcUToqtMmZvBHkBbenNCx
         p6gxdbC7YuOljN90DghjzNKs0xPnS91P8IEQD373xgTNxQ9WLUVPY1hXvAZwB0QBKxdB
         M6vw==
X-Gm-Message-State: AC+VfDxsFfe2aXwOa3M9bqGsAdREppkHCXuoXNWqaU8GgRRpcsFOg0Ho
        v5SUYz4iXOUiNFaqD0vIcSSNtWcml1ZMewrqfaE=
X-Google-Smtp-Source: ACHHUZ5mFQSEguv8gaktTRSSdWDKj7/SzUCfiPmUxPkyuqet8SRiloCcTWaYK0ZnTY5zuXJpdG1PxQ==
X-Received: by 2002:a17:907:940e:b0:94e:e5fe:b54f with SMTP id dk14-20020a170907940e00b0094ee5feb54fmr36761324ejc.23.1684322083094;
        Wed, 17 May 2023 04:14:43 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:c9ff:4c84:dd21:568d])
        by smtp.gmail.com with ESMTPSA id ml18-20020a170906cc1200b0094f124a37c4sm12326880ejb.18.2023.05.17.04.14.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 04:14:42 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Oder Chiou <oder_chiou@realtek.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 05/12] ASoC: codecs: rt700: do not store status in state container
Date:   Wed, 17 May 2023 13:14:09 +0200
Message-Id: <20230517111416.424420-5-krzysztof.kozlowski@linaro.org>
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
 sound/soc/codecs/rt700-sdw.c | 5 +----
 sound/soc/codecs/rt700.h     | 1 -
 2 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/sound/soc/codecs/rt700-sdw.c b/sound/soc/codecs/rt700-sdw.c
index 96fc5f36d0d0..ba7767bee07c 100644
--- a/sound/soc/codecs/rt700-sdw.c
+++ b/sound/soc/codecs/rt700-sdw.c
@@ -315,9 +315,6 @@ static int rt700_update_status(struct sdw_slave *slave,
 {
 	struct rt700_priv *rt700 = dev_get_drvdata(&slave->dev);
 
-	/* Update the status */
-	rt700->status = status;
-
 	if (status == SDW_SLAVE_UNATTACHED)
 		rt700->hw_init = false;
 
@@ -325,7 +322,7 @@ static int rt700_update_status(struct sdw_slave *slave,
 	 * Perform initialization only if slave status is present and
 	 * hw_init flag is false
 	 */
-	if (rt700->hw_init || rt700->status != SDW_SLAVE_ATTACHED)
+	if (rt700->hw_init || status != SDW_SLAVE_ATTACHED)
 		return 0;
 
 	/* perform I/O transfers required for Slave initialization */
diff --git a/sound/soc/codecs/rt700.h b/sound/soc/codecs/rt700.h
index 93c44005d38c..491774d207de 100644
--- a/sound/soc/codecs/rt700.h
+++ b/sound/soc/codecs/rt700.h
@@ -15,7 +15,6 @@ struct  rt700_priv {
 	struct regmap *regmap;
 	struct regmap *sdw_regmap;
 	struct sdw_slave *slave;
-	enum sdw_slave_status status;
 	struct sdw_bus_params params;
 	bool hw_init;
 	bool first_hw_init;
-- 
2.34.1

