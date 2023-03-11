Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F24CC6B5AC9
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 12:12:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbjCKLMc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 06:12:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjCKLMa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 06:12:30 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 523583AAE
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 03:12:29 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id x3so30647903edb.10
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 03:12:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678533148;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KYRKZXe27DmudkheBo+i7wuEUVnmuvDN257/ihaiBHE=;
        b=Uw5UZUsTO6MlernaGjy4BtjbvWxPmztoSaLSg2tiWr38IzxELmENmPxcSQMtTkwm2t
         8j/YDDbSXNjN2Ud3SvjPbV4ZLscX3BTQJqAw1uti+XvG2+vHMLrNwx9EALmqUB4deQt1
         8KuGM419vOxJFNdsXAJPSAd5prssXRu6Z0P7sd1WOgk/sMQTcJXU8wmVI0y1E1+t8uMt
         BJ+4nrwoTGgua2i2mfETHNKs3ar+7xkFUFg8pvByeHXwGCw7edJCAISsXX+m/DepGygf
         13gTAZq/t+XDFptsFcxrljJiV5naNPlRaPGhcp5H7nCI9ykD4GaKa5SFtoxwR20tkODg
         KBYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678533148;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KYRKZXe27DmudkheBo+i7wuEUVnmuvDN257/ihaiBHE=;
        b=auKTNGHQ17ABOgZSANOG4413sJwygw87Z1WhMwLn7NSa/FHosyNgpzh3YEujnTt3cW
         8NN7bOHU9lWzzsNrhOupILWjp98OeVFDeouKZvO1E5bYZVvKNOL8d+UdM3S2uda7PHWz
         3Wf3wwJt//bfir/kyxNo/TxD/a9lcPmkX8R/sZS224GpyLjm8JaQt9rBFl6i989yWMWa
         51T2f7sdmUvjeKrCZr9FCszk2X1N87xhFjpMYc80Ac/RWAWrXddm8jeGvXHL3y+QuTMU
         a2pFdDyvy6Lhj0Q7DAhToA0/lVAHBHVS8j8vVA/unbWkviZW6hsEef3bu0TAmuTOW3CP
         nA4w==
X-Gm-Message-State: AO0yUKV9vAaPc/RByz4gGz6gN83Wu6xh3FQ2pBIrK345j22jeQ0+OJpQ
        b2RSQjt7IeUgsea2ClEO4tle8Q==
X-Google-Smtp-Source: AK7set/mGqGr4UEcbnXcED5lkt30f/BfLI0+rmnLATtpCNVoIjUob9wm2sdEMjr45t+NDEzlf6f9Iw==
X-Received: by 2002:a17:907:168e:b0:8fc:c566:dc67 with SMTP id hc14-20020a170907168e00b008fcc566dc67mr36976725ejc.64.1678533147829;
        Sat, 11 Mar 2023 03:12:27 -0800 (PST)
Received: from krzk-bin.. ([2a02:810d:15c0:828:fa97:2d7c:bdd7:e1b])
        by smtp.gmail.com with ESMTPSA id b22-20020a170906709600b008c06de45e75sm987809ejk.107.2023.03.11.03.12.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Mar 2023 03:12:27 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] rtc: ds1390: mark OF related data as maybe unused
Date:   Sat, 11 Mar 2023 12:12:26 +0100
Message-Id: <20230311111226.250922-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

The driver can be compile tested with !CONFIG_OF making certain data
unused:

  drivers/rtc/rtc-ds1390.c:216:34: error: ‘ds1390_of_match’ defined but not used [-Werror=unused-const-variable=]

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/rtc/rtc-ds1390.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-ds1390.c b/drivers/rtc/rtc-ds1390.c
index 93ce72b9ae59..f46428ca77cc 100644
--- a/drivers/rtc/rtc-ds1390.c
+++ b/drivers/rtc/rtc-ds1390.c
@@ -213,7 +213,7 @@ static int ds1390_probe(struct spi_device *spi)
 	return res;
 }
 
-static const struct of_device_id ds1390_of_match[] = {
+static const struct of_device_id ds1390_of_match[] __maybe_unused = {
 	{ .compatible = "dallas,ds1390" },
 	{}
 };
-- 
2.34.1

