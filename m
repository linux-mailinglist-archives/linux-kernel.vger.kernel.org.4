Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADFF96B6ABA
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 20:37:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230193AbjCLThd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 15:37:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbjCLThb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 15:37:31 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7B883B0F9
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 12:37:26 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id o12so40591334edb.9
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 12:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678649845;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MbxHbzvLkp3+YSMpJS7DaRrqJlMIKLo4VULg0QWg/H4=;
        b=umsOdME+n7N5qEvbkVpH8L8St+VsfKxIxCEfnKTPN+qY9RN9VuKIAoeEZxUIGXiQde
         WT1pZDIREAjrDiwz2Nnu6/AF5WLtf0N/EjrpgAgPLQhgPTx9RiMatgEzG9UX2qePOi4B
         Si/R/B9HfAS0TVXY6P3KOauSjYE4lmmtlDRUVfijg4wZi17Wbc0tCD7K2jNwpFXguFKJ
         ghqgOiMyAtghVxPviMslgObfyfn0GzmdXkdz7mdVMXJei8/EEkt528rfoKbvtavS+MkI
         YxT11+hUszvDpyxkGpMErQdNXrWOeiXKVSkzTid5vEM9boscFeaX8D7DtaXwO2aE8jpU
         NcKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678649845;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MbxHbzvLkp3+YSMpJS7DaRrqJlMIKLo4VULg0QWg/H4=;
        b=7VqVnKW5V06oN+VTIkWJXyMmkF7oCZ9q8FTNNqi3s/hZlHoGPz801IPugfdOuNxVcL
         xPpsfYr2MsJO0MM1uivHBKaHjyp73gfJSmVLoTN2WhvJpNpdLjAC19nBq3WgTARkMmfB
         sTTEwRp7JoFpFFiv67Ex6zk/6q4oZJ8zCa3w3fivhMJTnuaynOga5EKkZco2/arVucYI
         rVmveogQkxmMqIkPli800qPLspcm/Bu1woT2Lr84nyHHKXkXjuPY9pVKAaLzx1Xep/rB
         cIvOuXLrloQ78BvTA0y6re9LLuY2cwV/KptJDAmnWWQzLn8vXXzHtpCm2XadMEbvrRWC
         x0dw==
X-Gm-Message-State: AO0yUKVttaUp59NV/SZ+d+YA8iVzq2OgZW3eZKtRD0EfOPPwspPJk10H
        4I86ujeHClbLlEq1ZH998k6X+g==
X-Google-Smtp-Source: AK7set/zfiIBD0KgL7vNebTmVUD5UyFF1IRwhCDdPLf8/3juOwKUQHHZJ6b+XI5Wz0FsLJICL6BIDg==
X-Received: by 2002:a17:906:1b19:b0:90d:5f56:b109 with SMTP id o25-20020a1709061b1900b0090d5f56b109mr8468370ejg.2.1678649845365;
        Sun, 12 Mar 2023 12:37:25 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:d9f6:3e61:beeb:295a])
        by smtp.gmail.com with ESMTPSA id gb17-20020a170907961100b00882f9130eafsm2526071ejc.26.2023.03.12.12.37.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Mar 2023 12:37:25 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Eric Tremblay <etremblay@distech-controls.com>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 1/2] hwmon: gpio-fan: drop of_match_ptr for ID table
Date:   Sun, 12 Mar 2023 20:37:22 +0100
Message-Id: <20230312193723.478032-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

The driver can match only via the DT table so the table should be always
used and the of_match_ptr does not have any sense (this also allows ACPI
matching via PRP0001, even though it might not be relevant here).  This
also fixes !CONFIG_OF error:

  drivers/hwmon/gpio-fan.c:484:34: error: ‘of_gpio_fan_match’ defined but not used [-Werror=unused-const-variable=]

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes since v1:
1. Rework patch and commit msg - drop of_match_ptr.
---
 drivers/hwmon/gpio-fan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/gpio-fan.c b/drivers/hwmon/gpio-fan.c
index e75db6f64e8c..d92c536be9af 100644
--- a/drivers/hwmon/gpio-fan.c
+++ b/drivers/hwmon/gpio-fan.c
@@ -586,7 +586,7 @@ static struct platform_driver gpio_fan_driver = {
 	.driver	= {
 		.name	= "gpio-fan",
 		.pm	= pm_sleep_ptr(&gpio_fan_pm),
-		.of_match_table = of_match_ptr(of_gpio_fan_match),
+		.of_match_table = of_gpio_fan_match,
 	},
 };
 
-- 
2.34.1

