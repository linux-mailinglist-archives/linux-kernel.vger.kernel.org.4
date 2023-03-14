Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D11846B9E97
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 19:32:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231248AbjCNScB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 14:32:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230487AbjCNSbZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 14:31:25 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C3AC9E64F
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 11:31:06 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id r19-20020a05600c459300b003eb3e2a5e7bso10854122wmo.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 11:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112; t=1678818665;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hnfu4ltYl8F1jZ0009KdabFBU7pxUH3F+Inm6kcRMQ0=;
        b=485hQ61jDQ8PlsUl9Jqt9Q9N0OVkEnQI8GouysBYgbKWrdeDxnarStmuSf/rUMkEQs
         fWjESKlmJL0z64Hi7uQ6dSs2euOPhQ7hO+LxUWPYdrG649dE3V1qy+ptdNucj7Zxrg0c
         QDxd2pOF8p6nmr9MeFVfblqc2Sg6m/GWme6nJAbINFbyH8YixMckULpRrha47zkVCGzQ
         3BIlqK/iryIa1HVh5U+QsPfHsNrNF8EObUkmAidNiHWVXTV2DDp2TNw2n9ycFABUPnni
         n7JLgcbpr4f02lejZFHTYKYGSlFmqOZRZ7k6Nf0dtYtZ2yvA9o0yfJsIe82J9ALjIhJI
         doAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678818665;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hnfu4ltYl8F1jZ0009KdabFBU7pxUH3F+Inm6kcRMQ0=;
        b=zMBBXiagQsyqY61xzLeEWhCdlei5JqiHYuOAnDpvCzpcA5UZtwcqDbSL97EkpkfsCn
         nRrIujnimkcFIhlV65ljnWAuASDBhfoRduc0E6iH8y2OMAL9ObyhMdcOIrz1hjP9ezRI
         v0flftgBpWBYN7qQ9VvAeL6n9gLzDY4tTe1f3HZs64dYRpzcy7EsoVR4yO5/Y57jMuq3
         tmduEm6dl9mV2TL8A9crA8sx3UXLpXqlUhIR6SoYAPbY2D5wkajqV+uZhgzhwYJCuYRV
         /3cVJovh2YVNd9VV8PyZadmJEjS2a9sXe8KgmcPChsdbCjjUdFjYryJrYswj9onSqSOD
         qczQ==
X-Gm-Message-State: AO0yUKUNN6YPD9R6gr2GeuXR71ZlCl+QnM5xRC20SPJd4OXsO9KHbVOd
        2SVb7eSO6ER9cv1n/6MqZ0Wfgg==
X-Google-Smtp-Source: AK7set8fGravp7JJ1UiwqKxbBI6VX8TRvR9oLYuhie5zHE4x/0pn5egOszK7o6QbF7c+d4HNJb9mvw==
X-Received: by 2002:a05:600c:4509:b0:3ed:29f7:5b43 with SMTP id t9-20020a05600c450900b003ed29f75b43mr4796338wmo.27.1678818665204;
        Tue, 14 Mar 2023 11:31:05 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:fd14:bd52:b53b:d94c])
        by smtp.gmail.com with ESMTPSA id k28-20020a05600c1c9c00b003e209b45f6bsm4083938wms.29.2023.03.14.11.31.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Mar 2023 11:31:04 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 12/14] dt-bindings: pinctrl: qcom,pmic-gpio: add compatible for pmm8654au-gpio
Date:   Tue, 14 Mar 2023 19:30:41 +0100
Message-Id: <20230314183043.619997-13-brgl@bgdev.pl>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230314183043.619997-1-brgl@bgdev.pl>
References: <20230314183043.619997-1-brgl@bgdev.pl>
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

Add a new compatible for the GPIO controller on the pm8654au PMIC. It
has 12 pins with no holes.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Cc: Linus Walleij <linus.walleij@linaro.org>
---
 Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.yaml
index db505fdeac86..512378a2d4fd 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.yaml
@@ -58,6 +58,7 @@ properties:
           - qcom,pmk8350-gpio
           - qcom,pmk8550-gpio
           - qcom,pmm8155au-gpio
+          - qcom,pmm8654au-gpio
           - qcom,pmp8074-gpio
           - qcom,pmr735a-gpio
           - qcom,pmr735b-gpio
@@ -439,6 +440,7 @@ $defs:
                  - gpio1-gpio4 for pmk8350
                  - gpio1-gpio6 for pmk8550
                  - gpio1-gpio10 for pmm8155au
+                 - gpio1-gpio12 for pmm8654au
                  - gpio1-gpio12 for pmp8074 (holes on gpio1 and gpio12)
                  - gpio1-gpio4 for pmr735a
                  - gpio1-gpio4 for pmr735b
-- 
2.37.2

