Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27C5862EDF8
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 07:53:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231768AbiKRGxz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 01:53:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241262AbiKRGxI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 01:53:08 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 813CD82BD0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 22:53:06 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id v1so7753259wrt.11
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 22:53:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wOd5sCkTHPY17SsnnLrxGTaF5zttQyfEfssssgWyoFM=;
        b=WvDsy0qfZkJaSZOzWG8/PYKaJ1+1vE3ywmP29Fjz0IejgQtUuWhgqegHjpJ4/uv+CX
         hVcxJ76jEuT7LRX+qF/GcPFGjZEInbwD57QSOb6ZrvhoZe48eviLryht/Z0owg34q7mF
         oBsmDq4AlB27lnK/HyhHv0SKGnaret5kVO8LsF2Oxl4hC/bxswqyKVO5o9Jpn6fD04hG
         VVCJ6aOqrzjn9J6rLMdhEMSvxUZhwvMZZPyNitumE9lvz6/GBE8xLbpYjzLAX7XWvanx
         DDsCSYL1g7Vyrmk84c+L51zoagsFDBmBt2Z8HLFFBcFvCKg4ptocmjmA/E0qH7pZ6V5K
         rQGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wOd5sCkTHPY17SsnnLrxGTaF5zttQyfEfssssgWyoFM=;
        b=CN5AQ3Blig5rj9wrDRkPZX+3THtO5GwbanM0ZMSciltpKAuZZplk1BcFAimD16UJG9
         Bvhrx0GkN1bNuVMRX9kWZM9hqHHLkIVBe03oDL+Ycx24IYm2D5qSbOd4glSkyIfl5MQ+
         1bg0E/hySh8MbcHeSnwrMrOjfU0WWJLQpGCDGIo0tGI1RR/kgNhkRIWUhR0LOfUYjSCv
         r/pPFW/l0QkYAgykdnF+I9mc9TQ+DxWzXCFbpqNM0Z44I5AVVJtcewv+6FIEumc1S0oC
         lH8hpy7akQOZgo9yDsOc1sCaPZKxAe7JkdlhiFXtFsI4yr0PTwa1ZIzYkf3sqqC8SXc1
         i/pw==
X-Gm-Message-State: ANoB5pn3L5uyXxIFw7rjV21cEeXs85G5ujW35gwR1BmhRHpesnqZBN8m
        mA4RZghIiQM6We0qUd/+wblu7w==
X-Google-Smtp-Source: AA0mqf5CNCJRY0Pypf/O/pjB1G0eS8PO4r2/eA8X/6N6z0XCKZugMtDmwkEtxG+1WTwgPc3Fgygl3g==
X-Received: by 2002:a5d:4344:0:b0:22e:3430:475d with SMTP id u4-20020a5d4344000000b0022e3430475dmr3515521wrr.65.1668754385106;
        Thu, 17 Nov 2022 22:53:05 -0800 (PST)
Received: from localhost.localdomain ([167.98.215.174])
        by smtp.gmail.com with ESMTPSA id 23-20020a05600c229700b003cf75213bb9sm7648100wmf.8.2022.11.17.22.53.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 22:53:04 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 08/12] slimbus: qcom-ngd-ctrl: use devm_platform_get_and_ioremap_resource()
Date:   Fri, 18 Nov 2022 06:52:42 +0000
Message-Id: <20221118065246.6835-9-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221118065246.6835-1-srinivas.kandagatla@linaro.org>
References: <20221118065246.6835-1-srinivas.kandagatla@linaro.org>
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

From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Simplify the code with devm_platform_get_and_ioremap_resource().

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/slimbus/qcom-ngd-ctrl.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/slimbus/qcom-ngd-ctrl.c b/drivers/slimbus/qcom-ngd-ctrl.c
index 22720ad4c22d..a6f3b6860d8f 100644
--- a/drivers/slimbus/qcom-ngd-ctrl.c
+++ b/drivers/slimbus/qcom-ngd-ctrl.c
@@ -1597,7 +1597,6 @@ static int qcom_slim_ngd_ctrl_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct qcom_slim_ngd_ctrl *ctrl;
-	struct resource *res;
 	int ret;
 	struct pdr_service *pds;
 
@@ -1607,8 +1606,7 @@ static int qcom_slim_ngd_ctrl_probe(struct platform_device *pdev)
 
 	dev_set_drvdata(dev, ctrl);
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	ctrl->base = devm_ioremap_resource(dev, res);
+	ctrl->base = devm_platform_get_and_ioremap_resource(pdev, 0, NULL);
 	if (IS_ERR(ctrl->base))
 		return PTR_ERR(ctrl->base);
 
-- 
2.25.1

