Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D466068E274
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 21:59:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbjBGU65 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 15:58:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbjBGU6t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 15:58:49 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C26513DE7
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 12:58:48 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id z13so4466948wmp.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Feb 2023 12:58:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZVDEkwpSNBnNA5bvC0eSecX/xh6oUxrJTLdGIKP8nY4=;
        b=uH2KAUVklw9v43h9yxNBufniyLS6TjEIIWPQXE6iftGk2v0fGkbNJAd8CeWQXDyGTO
         3+jQagCE3g33wzfpDvz1FKzLwayfNTWXZNUcGSwHDCQsY+10LxPptS0u9tN4OmmlfFp4
         htkSYBlpb35kapv9Bddhu7pUZi6razflGKlvnFtGXW45pT/knPZScLm0kaj7vZDkGSMR
         ZfG4xCoTvpdrG+4szCkJASSht4esYG0MqkaPVSJzHa0os1OC2MJRRiftDXTcvRO00kTg
         AY4PXW31vld/2p1G2SfdyAP7/xPUMTFv2mefqhx+SpSVz9eHHvVpvL2nyB0DjMCGYV6L
         +PKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZVDEkwpSNBnNA5bvC0eSecX/xh6oUxrJTLdGIKP8nY4=;
        b=Nc1qUggE333l7IVZ0GexbHd73x7mWmfJFBdQC28DbvnwWc+aTFUGUHCGQl832UhBoZ
         QiZvfEsP0jyIbXqbLFEaWe8BBIGdbY4iGOs2itmqltCHbwk+V+nyyuFF5ybi8zcY4Eln
         k1PXDSds7M2s0+FrH+VQ/rx/3yBxnhaADxqgsgIYON2y5gR5MZderl9XxIzO1Rt6c5l6
         7T8SBBRcky28Kejw9NpXJTsMHvtAhwqF05z9K4wzCfKdIDHHNeqzuuZmg5O+VLYDwQFd
         t3Xd/OTFzV4/OWTgMHXin2NW0fahl5eAGmDIV8kXqoGPGrHZdcFg5EUBuVALOPKxgKau
         x0Kw==
X-Gm-Message-State: AO0yUKWWKs9wnyjYZAAwnQG8l89C1j7u3PogcMr5uz8c1piypPyDd+TC
        RvtWGxkd/g1U9YbdWkLJ+1nZgw==
X-Google-Smtp-Source: AK7set9g0Q4PXzjyBw/7a9A5YeoIjf44d801s6Qofr8X7o0oi+hxj5dbCa8KvDcVQ6d9cBKnOlSLiQ==
X-Received: by 2002:a05:600c:1688:b0:3dc:4042:5c21 with SMTP id k8-20020a05600c168800b003dc40425c21mr4443353wmn.6.1675803527622;
        Tue, 07 Feb 2023 12:58:47 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id h27-20020a05600c2cbb00b003db12112fcfsm16555649wmc.4.2023.02.07.12.58.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 12:58:47 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 4/4] media: samsung: exynos4-is: drop simple-bus from compatibles
Date:   Tue,  7 Feb 2023 21:58:34 +0100
Message-Id: <20230207205834.673163-4-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230207205834.673163-1-krzysztof.kozlowski@linaro.org>
References: <20230207205834.673163-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The FIMC camera node wrapper is not a bus, so using simple-bus fallback
compatible just to instantiate its children nodes was never correct.
Driver should explicitly populate all its children devices.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes since v1:
1. Do not depopulate on errors because it causes several errors.
---
 drivers/media/platform/samsung/exynos4-is/media-dev.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/media/platform/samsung/exynos4-is/media-dev.c b/drivers/media/platform/samsung/exynos4-is/media-dev.c
index 22baa429ed5d..6839007edf1d 100644
--- a/drivers/media/platform/samsung/exynos4-is/media-dev.c
+++ b/drivers/media/platform/samsung/exynos4-is/media-dev.c
@@ -1440,6 +1440,10 @@ static int fimc_md_probe(struct platform_device *pdev)
 	if (!fmd)
 		return -ENOMEM;
 
+	ret = of_platform_populate(dev->of_node, NULL, NULL, dev);
+	if (ret < 0)
+		return -ENOMEM;
+
 	spin_lock_init(&fmd->slock);
 	INIT_LIST_HEAD(&fmd->pipelines);
 	fmd->pdev = pdev;
-- 
2.34.1

