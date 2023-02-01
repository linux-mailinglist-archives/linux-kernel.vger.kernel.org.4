Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B04D686A0E
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 16:21:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232403AbjBAPVe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 10:21:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232338AbjBAPV1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 10:21:27 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82AAE1F5DF
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 07:21:20 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id d4-20020a05600c3ac400b003db1de2aef0so1733045wms.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 Feb 2023 07:21:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2xDvLHuSGsMQKguNv/ZDYnaK3vl6YmrvH8TUn7lN/FY=;
        b=ri9kKbfu+aKtCgfFQ3b+hJFuijuObx43Lc2YSA9UfBT0hOv/dGQHEzZncqnvQlInoq
         cmr/thH3pgX8mQXVtBsu4NQhfQf3M2fsSpAPeHBfgTGzuX0VsrO7TxqlT7jULieesbeS
         UMfl5KWeYdFK7tL1Pr+rhd4NGmMhj8Q9WhTwsk41F3o2WZiK8QZMAH3h8zp0AIZru8CR
         8eVL7Obr1Udvp7zb7Ph8Gdta395DpPGmBEk19l4yRxRcDcgKXlYW2yxEuLMwFenmx8OY
         DLA1BFmXPHDKra6G/evSyZGpYdAXL4dUjKdbVrSJ4sgbpd61ihULCL4PDR3Db/HAiujz
         f3Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2xDvLHuSGsMQKguNv/ZDYnaK3vl6YmrvH8TUn7lN/FY=;
        b=NbfNBhPphyu4s45kzrmw0T+YY8OqoqonHCglbEN0SxMHoLoNVN782D15Hy6q/W5iN3
         FjZfAUdKePQUUoYJveTa3OuMlY1F30rRUDr1yjk3u89EWYXWR88bF4izXMiFJucsg1I5
         Q/WPGTuPnNru8sQ1ob0KuunNHuHNeTji3U5AhzD0NcezjW7VWUxfR5en1yB4OVbkXvdH
         Mn6UHDjSnWmtSLzI+/Nw+KjNckVraZloufHqrQ9bQiEKXa0KTxmEmWS+FTIp001n6ZOa
         Ui9ScMiUAAYCuORvJ6VoNuQUcBezt+92afE1EdK9hjGI+fMJeHogCevGrPoiN4n7+w4q
         KRSw==
X-Gm-Message-State: AO0yUKXD7RsBaZmu5k5eD3QJMNM/+U8sb8pNXmOl/slMn4+XyqVhwpNx
        1pNyt1cYBVyI5NXES+cLMqT4Tg==
X-Google-Smtp-Source: AK7set+jfKlYb3NXWvKe2s/DXGOiOakAnv5/vjFBeBy/gDlWR91/U8D7AX2C9qnM4Wt9OKa/cUTOdQ==
X-Received: by 2002:a05:600c:358a:b0:3da:fcb7:39e5 with SMTP id p10-20020a05600c358a00b003dafcb739e5mr2596926wmq.23.1675264879054;
        Wed, 01 Feb 2023 07:21:19 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:d64:a4e6:40a8:8e69])
        by smtp.gmail.com with ESMTPSA id j19-20020a05600c42d300b003dc53217e07sm1893120wme.16.2023.02.01.07.21.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Feb 2023 07:21:18 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 3/5] dt-bindings: watchdog: qcom-wdt: add qcom,apss-wdt-sa8775p compatible
Date:   Wed,  1 Feb 2023 16:20:36 +0100
Message-Id: <20230201152038.203387-4-brgl@bgdev.pl>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230201152038.203387-1-brgl@bgdev.pl>
References: <20230201152038.203387-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Add a compatible for the sa8775p platform's KPSS watchdog.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml b/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml
index d8ac0be36e6c..27fb484d5f8d 100644
--- a/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml
+++ b/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml
@@ -18,6 +18,7 @@ properties:
       - items:
           - enum:
               - qcom,apss-wdt-qcs404
+              - qcom,apss-wdt-sa8775p
               - qcom,apss-wdt-sc7180
               - qcom,apss-wdt-sc7280
               - qcom,apss-wdt-sc8180x
-- 
2.37.2

