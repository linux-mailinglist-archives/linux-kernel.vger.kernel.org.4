Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 729C162565A
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 10:13:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233523AbiKKJNl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 04:13:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233350AbiKKJNd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 04:13:33 -0500
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18C24C18
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 01:13:33 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id c25so3849430ljr.8
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 01:13:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CG70r3R3U+ByF6Dm/fb3An6dalcnfgrC/IIfYr0Kegg=;
        b=OsGDvA/gwAYIEnfwgCEeq3G4Iacv4yJG9WsMbMnmYM3BNIoqI+ZEDGAB5DKR+pTXUE
         NZkJETBvkiqw1aKOrORv331gFtG2EiJECkF7Uc12L7Q8ZGDUBLiQ3Pxa9buUXCt+jasD
         XpFZVTCrN4E1jD6P5dXWpNBYMxxIzEnorL9FlUL2LQblzD3/r1rnHIvY6D4wq0r1a7XV
         Qdbwld4fdDamXBSWfMpx8+3Q1B8DrTO33jNTiLAkg0SKwIi9892i/5xMGWZpNuC7CylI
         gjg8JpCdJW+icXNmfC6LSeUYO3eVIn8o/t0GRt91VVVlCgcAOQuqxCOlZFiI4vK/VFLC
         u7lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CG70r3R3U+ByF6Dm/fb3An6dalcnfgrC/IIfYr0Kegg=;
        b=x+q5IrBePq7vniRyA1zasmaOtO4JqFr3HaYLEvgoUIdExhpaCxvAKA3PIXdSttBii0
         YGz6il9oFgLAcx8jZIrFsARICuQEA2/SvT88K3xHaqe6O3i6dVaY+COC6BpbLrGNx3zl
         tesvIDCYidxAXQ2VeFzt654FK3hQSpBxHosdd6kof24Ibcrmjxe7yS9K0SunE3SnPl7p
         SMRxQHdhwPbsiG+phfd5x/XhNEZQa9QdfiuSkTMfy3jAjNwjkfALxaj/2Qii3CZuvYjA
         ITTMsaBxmUeF4VEVMvhBgeNr4hubaxKjX48ejQ+e6wSu/spjgSe0JLpqVDuo0T9InmvU
         OXnQ==
X-Gm-Message-State: ANoB5pkTwm9IECjvehsTOFWfKwpeYzn+Bgc4IWoJa5YX9DJjmWh7UgW/
        rzCAqEcJdb7Dm9DDF4O1TVW/cQ==
X-Google-Smtp-Source: AA0mqf7jfxUQwV/asX6PTGhypg3OXbuthfIPAebxbxNVePC1vqYuLhevUGqfg7OaxzBtBi8ZjYX+ZA==
X-Received: by 2002:a2e:a5c8:0:b0:26d:d55f:f1cf with SMTP id n8-20020a2ea5c8000000b0026dd55ff1cfmr325829ljp.175.1668158011429;
        Fri, 11 Nov 2022 01:13:31 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142199.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.199])
        by smtp.gmail.com with ESMTPSA id s7-20020a056512314700b004946b549a19sm229553lfi.45.2022.11.11.01.13.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Nov 2022 01:13:30 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] ASoC: qcom: q6prm: Correct module description
Date:   Fri, 11 Nov 2022 10:13:28 +0100
Message-Id: <20221111091328.31549-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The description was copied from APM driver.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 sound/soc/qcom/qdsp6/q6prm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/qcom/qdsp6/q6prm.c b/sound/soc/qcom/qdsp6/q6prm.c
index cda33ded29be..8aa1a213bfb7 100644
--- a/sound/soc/qcom/qdsp6/q6prm.c
+++ b/sound/soc/qcom/qdsp6/q6prm.c
@@ -247,5 +247,5 @@ static gpr_driver_t prm_driver = {
 };
 
 module_gpr_driver(prm_driver);
-MODULE_DESCRIPTION("Audio Process Manager");
+MODULE_DESCRIPTION("Q6 Proxy Resource Manager");
 MODULE_LICENSE("GPL");
-- 
2.34.1

