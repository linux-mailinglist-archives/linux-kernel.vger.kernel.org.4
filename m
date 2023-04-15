Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A30BF6E30CC
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Apr 2023 12:44:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230327AbjDOKop (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Apr 2023 06:44:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230130AbjDOKoK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Apr 2023 06:44:10 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CB889EF7
        for <linux-kernel@vger.kernel.org>; Sat, 15 Apr 2023 03:43:34 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-94f1a6e66c9so25556866b.2
        for <linux-kernel@vger.kernel.org>; Sat, 15 Apr 2023 03:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681555411; x=1684147411;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5buqkue5965jfQy5B2BdRMuK1Vit+T6gg2ptTUMAnCo=;
        b=JbNLf4kZtv5Gjgl0zLLoKT4pJSwleFT3ifkJekiFLaat6x5g4dVnqrHkkCEn1H0rNL
         bec3i9Nj5vmMLznJbar3okJAxZCj1hJ15TixBGdrHRt485nQYXyvih6vXLh1DBx95aWh
         yy7/G1ZTNTCCTJbyDiI44ip363NsgriVktYooVC8R5FxrBWkNqeHC1Z2o7GIgRPeik7H
         2bJ5sZgeW/yAFkbO+XqkmDOOOr+QHnj/rsMFGrwWBpvayPfpQbijX70hTRCh3P/bkvug
         ez3SGh67/kYA3QZ8aPzVWL863MoNKbW1NYFYw2Zh/qSAgQ/Dec47sL1schb0hTXirCmj
         ydWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681555411; x=1684147411;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5buqkue5965jfQy5B2BdRMuK1Vit+T6gg2ptTUMAnCo=;
        b=AVFRsPbcUD3ak7UZSt19ykF+WvVEjaD+gt13JQ5JqQwPcwBc8PzptKfC/65TCxGqHv
         kRtO+C52PhLYKotNPipEdye7gVocATwQt51EcCUDGk0cufj0yBDnS/PjAruS9njepdLw
         s0trUK+JHEFauTW8XqOHH0j3PQhc9F23y3dGAT6+SihocSQCF2dgjyL1aWDYgxdlbHUu
         GBTNrITWvDojGf4SharjqLtswIIYBIm1Y3s+xSjrWgsKJHd6/5S9PtsGg8Rp2XmwktIo
         O3doFp4nyNyp9Atn0hbDWE88WRAhYRvU4cP8dVi/2rbOOpomr3HnFsw6N7shDGhgws+S
         75rg==
X-Gm-Message-State: AAQBX9fOeYC7bCQZp54LZKIM/I8PxVor6Y8UcZBrfDWKku/F21LVGUkl
        TeAhvGEvTgil4q6zbgLdnf8Yxw==
X-Google-Smtp-Source: AKy350ZKvLWv7f/2M2Sgzqt65cxEHQTSAG6DpgZTuH7ADx+YAHDCfjCjqt3IgUqQLWy0Lug5eSJBOg==
X-Received: by 2002:aa7:d48a:0:b0:504:b313:5898 with SMTP id b10-20020aa7d48a000000b00504b3135898mr8886150edr.27.1681555411461;
        Sat, 15 Apr 2023 03:43:31 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:a3bf:4ed:6c53:2a36])
        by smtp.gmail.com with ESMTPSA id b10-20020aa7d48a000000b004fd1ee3f723sm3157481edr.67.2023.04.15.03.43.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Apr 2023 03:43:31 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-kernel@vger.kernel.org
Cc:     Evgeniy Polyakov <zbr@ioremap.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 14/15] w1: omap-hdq: remove unnecessary ENOMEM messages
Date:   Sat, 15 Apr 2023 12:43:03 +0200
Message-Id: <20230415104304.104134-15-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230415104304.104134-1-krzysztof.kozlowski@linaro.org>
References: <20230415104304.104134-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Core already prints detailed reports on out of memory:

  WARNING: Possible unnecessary 'out of memory' message

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/w1/masters/omap_hdq.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/w1/masters/omap_hdq.c b/drivers/w1/masters/omap_hdq.c
index 826207c24bd0..6a39b71eb718 100644
--- a/drivers/w1/masters/omap_hdq.c
+++ b/drivers/w1/masters/omap_hdq.c
@@ -573,10 +573,8 @@ static int omap_hdq_probe(struct platform_device *pdev)
 	const char *mode;
 
 	hdq_data = devm_kzalloc(dev, sizeof(*hdq_data), GFP_KERNEL);
-	if (!hdq_data) {
-		dev_dbg(&pdev->dev, "unable to allocate memory\n");
+	if (!hdq_data)
 		return -ENOMEM;
-	}
 
 	hdq_data->dev = dev;
 	platform_set_drvdata(pdev, hdq_data);
-- 
2.34.1

