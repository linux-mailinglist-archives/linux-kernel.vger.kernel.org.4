Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D112F6B01AF
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 09:38:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230366AbjCHIiq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 03:38:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbjCHIiP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 03:38:15 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56BAAC64D;
        Wed,  8 Mar 2023 00:38:12 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id cy23so62402102edb.12;
        Wed, 08 Mar 2023 00:38:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678264691;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FjcDlz4XTRjbVMkK7ur7l1kd35DIiV7fVBc0YXc8Pfk=;
        b=CiNyVTkTUk5idm4lvZK53mA0Qada/38QZ1MYF4CZX6P8Xf0S8lo2XN5xMcgBWTSdN5
         i5duPacjeQzfcYql+JwzqccufOmqB3JHHjV6dzmKCecSA10+RQ6i4dCEld+fXjFercsR
         E89Iv0Mv4D/84bE7pM9dDjiteg71w335VaSO0sR+vzQY59r9auj9TMFWVaBTCwCvze9P
         qTVJAdJG8RwPDTCRS1eXfwlEP57dTBuj1RKse97aCqF9zDrN/9gN01Bo1Dx9nHJb5lTm
         PL9j74yzkfG62z5g4wU6lnaEdmmBkC6Ui9KuXPPGSm7uf5to70niDJcEDdL82GX+kc7l
         f3bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678264691;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FjcDlz4XTRjbVMkK7ur7l1kd35DIiV7fVBc0YXc8Pfk=;
        b=Hs60iQfsW2HygGMx/n9A19kK0v0MEdKZXHkwIZJ3MsuNgT5EPM9YsWsrQtpPFqqX/X
         BSdAlbOBEgKHu/Z9EdHBoNXVpCgW3b/ccVXr5G0yvEy7Al8a2Iw7s/MOeD/ya89edoMH
         UgbKW60XxASGfEd4oJ6Mq1abBizVBSYoXUf3hVMgb4G9CXj9XVFxSNMfeDimiq5zYjo9
         5XtAScmVDTvfcYFbQB8J8VChv+iqlPdOqUaV4tFXzMjE3f+/fUN0MamO7bIim4VHnlos
         VSLGz3dM4J21sxy5FnaKc6XEYXs2ZNqGk8FXlBRupzhh6wmLwzFbgH62HpWsA9gZIMnz
         i2QQ==
X-Gm-Message-State: AO0yUKXnL+VpaUpJKO6x1GpnvoUoxYD/by2dPJIFBNFgPGC4IiC18mnK
        OakgXgOrt2an/7QgUezNgkM=
X-Google-Smtp-Source: AK7set/wNPkppLjM+7xCA+q7PYZ74OnWYsw0svBWJtQee5GhjhIWL2eeMKPdgyi1bqIT/cggn3tC5g==
X-Received: by 2002:aa7:c0da:0:b0:4c0:9bd7:54cc with SMTP id j26-20020aa7c0da000000b004c09bd754ccmr13365511edp.11.1678264690784;
        Wed, 08 Mar 2023 00:38:10 -0800 (PST)
Received: from xeon.. ([188.163.112.76])
        by smtp.gmail.com with ESMTPSA id k7-20020a170906578700b008b904cb2bcdsm7300511ejq.11.2023.03.08.00.38.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 00:38:10 -0800 (PST)
From:   Svyatoslav Ryhel <clamor95@gmail.com>
To:     Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Svyatoslav Ryhel <clamor95@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org
Subject: [PATCH v1] max77663-rtc: pass rtc address from device tree node if exists
Date:   Wed,  8 Mar 2023 10:37:59 +0200
Message-Id: <20230308083759.11692-1-clamor95@gmail.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MAX77663 PMIC can have RTC on both 0x63 i2c address (like grouper)
which is main address but on some devices RTC is located on 0x48
i2c address (like p880 and p895 from LG). Lets add property to be
able to use alternative address if needed without breaking existing
bindings.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/rtc/rtc-max77686.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-max77686.c b/drivers/rtc/rtc-max77686.c
index b0250d91fb00..218177375531 100644
--- a/drivers/rtc/rtc-max77686.c
+++ b/drivers/rtc/rtc-max77686.c
@@ -691,6 +691,7 @@ static int max77686_init_rtc_regmap(struct max77686_rtc_info *info)
 {
 	struct device *parent = info->dev->parent;
 	struct i2c_client *parent_i2c = to_i2c_client(parent);
+	int rtc_i2c_addr;
 	int ret;
 
 	if (info->drv_data->rtc_irq_from_platform) {
@@ -714,8 +715,13 @@ static int max77686_init_rtc_regmap(struct max77686_rtc_info *info)
 		goto add_rtc_irq;
 	}
 
+	ret = device_property_read_u32(parent, "maxim,rtc-i2c-address",
+				       &rtc_i2c_addr);
+	if (ret)
+		rtc_i2c_addr = info->drv_data->rtc_i2c_addr;
+
 	info->rtc = devm_i2c_new_dummy_device(info->dev, parent_i2c->adapter,
-					      info->drv_data->rtc_i2c_addr);
+					      rtc_i2c_addr);
 	if (IS_ERR(info->rtc)) {
 		dev_err(info->dev, "Failed to allocate I2C device for RTC\n");
 		return PTR_ERR(info->rtc);
-- 
2.37.2

