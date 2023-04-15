Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E4916E30CA
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Apr 2023 12:44:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230305AbjDOKok (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Apr 2023 06:44:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230108AbjDOKoJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Apr 2023 06:44:09 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11FD8A275
        for <linux-kernel@vger.kernel.org>; Sat, 15 Apr 2023 03:43:30 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-50489c109f4so5760607a12.2
        for <linux-kernel@vger.kernel.org>; Sat, 15 Apr 2023 03:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681555408; x=1684147408;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dNpxORV+uoxzQyQgTWsAR7xLsJXttT16I2OZ/0Honq0=;
        b=aW07LZTdTwP7o5RXmg8t7d4WFICyTSv+PXdRSa8Msr4wzY/LXIrZsQbLG5nhA6tdfj
         f0Zo3G6XhksREG0cy9X5oV3y4DDqNOD5bZJY1DNCoWthLRVzJQTfSg3UrKmxxoDzbAs1
         80ADIsMge9hQ47Sktug56lB6XdBnUq1b8X17AUF/zhKHwh5mLKmCglcqZeZdc3y030za
         ZF4PYygVggajmzOA//IRZzzuIfSPDlPft5mwgXSIWQGQ/gzovNNNPVDuXe9rlfSlRa0+
         /AIAQtUAQvjitNZNKCH/ZcjksU1xNZLqocrjcD8OJpHQ8l7s0zyRVvxTv0bQx2mOECKw
         psQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681555408; x=1684147408;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dNpxORV+uoxzQyQgTWsAR7xLsJXttT16I2OZ/0Honq0=;
        b=fDO4NvVmXhyJTzzhXWTkuIwg+NEgOSbgiJOiWfbANm4aYBWqWt1mXrB5jLw1SyukU4
         HB0K2yhFjmK9/XT9sacZJqkuUrGfwtxfbRkfnqRqK9/KUNbcCDXKAWTvwS6GrAotV9LO
         wfZsHfhxObNzDflCVjQAJU2IGaMG7G2IJDtEA8sADBluf3ZDxATDW9q6mHJQcNulWESY
         CiDsBxbgVU0taCaBW8/HM0sHlF8Nr3MUiPr6J3T8mrTAVaW85lq8qmkoB56WbqCPvFtO
         +OV3HyvudME+KRa8w/L3ik35cW1UBCKIf8EzjfzfapNmk2NYTesMwkp+WhWlz+R2FnTh
         JbcQ==
X-Gm-Message-State: AAQBX9eQGDcZDYRMR38e32Ve+q0U6+wp5t5/+bWRDs4Rj9AeP9NDcVqR
        WM6PfLOGNX1JDdTB5OHjBStRcQ==
X-Google-Smtp-Source: AKy350Y3GOYqbNMSnzkQCc0JrsAFfLFROPGeR3lT8jjPs5mFkIueWpDuN5QsJOgO7YKSusVnYhKh6Q==
X-Received: by 2002:a50:fe94:0:b0:504:9393:18b1 with SMTP id d20-20020a50fe94000000b00504939318b1mr9209691edt.9.1681555408494;
        Sat, 15 Apr 2023 03:43:28 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:a3bf:4ed:6c53:2a36])
        by smtp.gmail.com with ESMTPSA id b10-20020aa7d48a000000b004fd1ee3f723sm3157481edr.67.2023.04.15.03.43.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Apr 2023 03:43:28 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-kernel@vger.kernel.org
Cc:     Evgeniy Polyakov <zbr@ioremap.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 11/15] w1: matrox: remove unnecessary ENOMEM messages
Date:   Sat, 15 Apr 2023 12:43:00 +0200
Message-Id: <20230415104304.104134-12-krzysztof.kozlowski@linaro.org>
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
 drivers/w1/masters/matrox_w1.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/w1/masters/matrox_w1.c b/drivers/w1/masters/matrox_w1.c
index fb38d92b2f43..2852cd2dc67c 100644
--- a/drivers/w1/masters/matrox_w1.c
+++ b/drivers/w1/masters/matrox_w1.c
@@ -122,13 +122,8 @@ static int matrox_w1_probe(struct pci_dev *pdev, const struct pci_device_id *ent
 
 	dev = kzalloc(sizeof(struct matrox_device) +
 		       sizeof(struct w1_bus_master), GFP_KERNEL);
-	if (!dev) {
-		dev_err(&pdev->dev,
-			"%s: Failed to create new matrox_device object.\n",
-			__func__);
+	if (!dev)
 		return -ENOMEM;
-	}
-
 
 	dev->bus_master = (struct w1_bus_master *)(dev + 1);
 
-- 
2.34.1

