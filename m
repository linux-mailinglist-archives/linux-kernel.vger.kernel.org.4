Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8194707AD8
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 09:28:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230189AbjERH2s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 03:28:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230136AbjERH2S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 03:28:18 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A45A12D41
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 00:28:10 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-965c3f9af2aso252795066b.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 00:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684394889; x=1686986889;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WSuhjZFmCIUit+haslyLLFjLlYcrxcE4KHcrJzAwJBY=;
        b=TznhBWZE03vv3t6BYxwUACwueYgrs1Ep3am2yskk4mEYGRjuema9R0bhklB/A4EYwq
         xq/kh/yu/4rwL9VhJPMfJS0lEVnKKv1az7+D9EicsrG+MicaTGHQFqn3+JEg2DI/X7Fb
         C+qzU/kJAFGbXFHTHMMYV8g6qAusfkex407LywnkHKTONWMAX7lqCi/piOOmH3amTtuS
         ZkOf57RBU9nd12mJzy1DZpOD7RQvNhZOxMq2r4452BSN7mjw+j28ELcvKSNmmtTT+nPg
         hMxwfQIAv5NlxIp8w+yqPqay10dOLP70vMRa5pncT+r8uYjN7/mf8UfaB6m5XfjjjKTE
         vriQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684394889; x=1686986889;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WSuhjZFmCIUit+haslyLLFjLlYcrxcE4KHcrJzAwJBY=;
        b=Ev+Qul4pospSYrCrqX7VuYidN41hn1ZeHPzdTSn21Y4aCEsJ778Qwk9LAUS2ILpCh4
         ocjC7Gc6uHzMyu9w/X909esumtWnzBve0Iqm4JhOV0j6ZJHXdA7uNUZpjZm/SF/1Z0CX
         yr/F7s151MAUG/eGNSt2NDBgFavb+0NHg41XYL06zgmREZqOMOFbfjOr9QlAUjO2n631
         7Dm4Sfr6hEYS4YF4mOC7IkB8TEwfrmsxMNu5z+dfYnJwSvVB0+9dWrAucf5qGQygERRr
         zwgi8nZbEfdO0ol07nZRmPfh/41CKYuK7SOocTQn49fQRaKwltB9c0BSKdHn6qjmAXKv
         otTg==
X-Gm-Message-State: AC+VfDzNRn08IsyTNL1ptZ2Uz/Nyxm76uO4g76YRxSQ+WcV5lTEVyK8a
        HYJsPDUdW4GM/0147SDC2Tr+SQ==
X-Google-Smtp-Source: ACHHUZ4McNgf/1YlCyZhja1AYOncpGaPhNUPxjBOY/NlnHGibDpAgAupegzUKCoSeRkDzpsEpb9d9g==
X-Received: by 2002:a17:907:7293:b0:969:dda1:38a4 with SMTP id dt19-20020a170907729300b00969dda138a4mr32698956ejc.38.1684394888689;
        Thu, 18 May 2023 00:28:08 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:a2b:c408:5834:f48e])
        by smtp.gmail.com with ESMTPSA id g17-20020a17090669d100b00965aee5be9asm594241ejs.170.2023.05.18.00.28.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 00:28:08 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Oder Chiou <oder_chiou@realtek.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [RESEND PATCH 10/12] ASoC: codecs: rt715-sdca: do not store status in state container
Date:   Thu, 18 May 2023 09:27:51 +0200
Message-Id: <20230518072753.7361-11-krzysztof.kozlowski@linaro.org>
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

