Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFE0E706666
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 13:15:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231351AbjEQLP3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 07:15:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230444AbjEQLO7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 07:14:59 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F7045FE6
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 04:14:52 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-96aa0cab88dso92614366b.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 04:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684322090; x=1686914090;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ikB2y5rvufm/ROET3UaPHVQf0uJXk4esoL2mDQIzzPA=;
        b=Mqrza8r6L1qVxSOY8tPU3HdOmEKLv1L4y3PLSmB1w5nETDTDauRdLQWLKSc70HZ800
         pi7A8pKDIp3UiLkPHkSm2Z9WKbHpPVQqowRRvDdLX9xaXmcZFAqbO+2DgbzQZo92DKPc
         mfGsvAWTr5zLhsgTVpPH5G7b95kh5eRGV/HhBRsi3O+NGuXyaGLl9tEVU7dTaQROQ9Un
         HBexjtOtDlBB+58I33xjm/oeXxfhsOTQgIc2wwvKbCqosGiLVZQQHsaMol4RliIown2f
         KuLWdNzxde/Dr78sqoTvF8zkY//R7v9P+iWX0ABe7GdxGBXLkAz92qty0kQ5+iiERX0c
         vNtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684322090; x=1686914090;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ikB2y5rvufm/ROET3UaPHVQf0uJXk4esoL2mDQIzzPA=;
        b=aDkhlqqSTJODtdCaQz8iFVutTCuVVg1aaA8+SXTCf4+opU0uu9DJ0Xh13e0+sFAH39
         8geLR8WYG81GftZX6heAEYIMFg+G1NxZ3Ffk2Aq9X3dD+SMS/hMoyuAAkM4XdNDRvsdF
         J4XcwrBtocSbcWS4RczYvejfxZNI8t4ci6eoJ+87YuCfOI5AGaYym6iSXF1WIIwBUydo
         91J92jf8bBTIJGVEH86LrrP/+nt7qmIQUU9DDrBlgTds5fc0XhEQWdDQZXDMtjhYefnx
         6+Dlaf8I3JyG00yB9BsijBtLiCGA5PLBPLx/RykgoNGuN8R7zNQzkTzh2cyzRYXxxq6y
         DJqA==
X-Gm-Message-State: AC+VfDzN0Gu1uKvm0UuQrVCmGnG0fvULHlILr4jgQmcIOGncz9PFkSOk
        jI5OaHtZJ87KkZCNQYeLXMA6ow==
X-Google-Smtp-Source: ACHHUZ77Po5iB686z2AKal+Svea6MuM/egkvm4vr7KEKPnMB5+2IdxYBbcnEdkJ1O2aYG7A3MTAXaQ==
X-Received: by 2002:a17:907:7fa8:b0:969:8d19:74 with SMTP id qk40-20020a1709077fa800b009698d190074mr35584944ejc.57.1684322090644;
        Wed, 17 May 2023 04:14:50 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:c9ff:4c84:dd21:568d])
        by smtp.gmail.com with ESMTPSA id ml18-20020a170906cc1200b0094f124a37c4sm12326880ejb.18.2023.05.17.04.14.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 04:14:49 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Oder Chiou <oder_chiou@realtek.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 11/12] ASoC: codecs: rt715: do not store status in state container
Date:   Wed, 17 May 2023 13:14:15 +0200
Message-Id: <20230517111416.424420-11-krzysztof.kozlowski@linaro.org>
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
 sound/soc/codecs/rt715-sdw.c | 4 +---
 sound/soc/codecs/rt715.h     | 1 -
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/sound/soc/codecs/rt715-sdw.c b/sound/soc/codecs/rt715-sdw.c
index 5ffe9a00dfd8..6db87442b783 100644
--- a/sound/soc/codecs/rt715-sdw.c
+++ b/sound/soc/codecs/rt715-sdw.c
@@ -417,13 +417,11 @@ static int rt715_update_status(struct sdw_slave *slave,
 {
 	struct rt715_priv *rt715 = dev_get_drvdata(&slave->dev);
 
-	/* Update the status */
-	rt715->status = status;
 	/*
 	 * Perform initialization only if slave status is present and
 	 * hw_init flag is false
 	 */
-	if (rt715->hw_init || rt715->status != SDW_SLAVE_ATTACHED)
+	if (rt715->hw_init || status != SDW_SLAVE_ATTACHED)
 		return 0;
 
 	/* perform I/O transfers required for Slave initialization */
diff --git a/sound/soc/codecs/rt715.h b/sound/soc/codecs/rt715.h
index 17a8d041c1c3..12a0ae656d09 100644
--- a/sound/soc/codecs/rt715.h
+++ b/sound/soc/codecs/rt715.h
@@ -18,7 +18,6 @@ struct rt715_priv {
 	int dbg_nid;
 	int dbg_vid;
 	int dbg_payload;
-	enum sdw_slave_status status;
 	struct sdw_bus_params params;
 	bool hw_init;
 	bool first_hw_init;
-- 
2.34.1

