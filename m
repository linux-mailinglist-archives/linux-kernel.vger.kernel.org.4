Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00DD160F16B
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 09:47:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234845AbiJ0HrV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 03:47:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbiJ0HrK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 03:47:10 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 188E3169100;
        Thu, 27 Oct 2022 00:47:05 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id h14so765514pjv.4;
        Thu, 27 Oct 2022 00:47:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ALxYcoQL7dP6mgXsQO6Lg/e/4QIgrgKqxl3ALb+fP3Y=;
        b=amc8h/bvI9K6TJRi42Q+oYQJ7o5DKKQGbyLckOiVr7tAp1qdgtdGVMIdFK3tfTpNhj
         3ZZOMu0PDZS9trnyjHt1jVJYiOSQ2TjpVLPzTfFZI62zliv8g0Hq3tVLIrCQ3eXa2TR9
         8MEXl8nkakzXY/nGHcqrK4+B8yC5EnuIa+p5p+DfBRQbzOm8ReZ0pkbFyxI/bsiQrEaD
         WPgJN4D7PNfNScnq3WuCZQhx3zYyHFlxvJhHvZTHg1nLNlA+SsCtlYBe9lhhnzL7bEPC
         v9DMdIITeBU4/zS7G5MPiPupVDoujxgObRsL1mSfL6GvEa6ekdl9fUdnyo0ZTVHzdXzt
         lphQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ALxYcoQL7dP6mgXsQO6Lg/e/4QIgrgKqxl3ALb+fP3Y=;
        b=KRXU3N9OWDX7/Ta4uAKiqiocQU4oYp9bZ/z05BvAaA84mT9gbWblJBwjhCTNrYNUdC
         xgF63Cy5kSWegAi0kgzsQxrhdkh4GpSpYFD7na1JalQTmFyZIdaY7lkEerqeJRm0CDtQ
         jxnYTsdSyq7kRiGVTtGqIAXfyhULl2TB1XNEGbNqB4NRplS3rK8nuCmvy6jyq59JEqWv
         D3FmIn6b8fdAZUJM4UGA3asci7zSRUhIoPFrRDA9TJ2r+j8eBxUYrcl8Jafphx/cGCOg
         QK/MJLQgnPB53U4DsfoNnGMQCNrFKToRa5d3ZrjcaFS8QfurP6Mq83QT/kj2LoKKMAkt
         JCgA==
X-Gm-Message-State: ACrzQf0anELw9VQDOEdR9vcaoR9TZBQcyMWZDg8fGJpqwg45FL4q2ISO
        Dw3r09ytDVjitX04su5JyMw=
X-Google-Smtp-Source: AMsMyM7BkAF7n4+4kev5NLXg01Teai+kgMxQXZurnmug6rMBOL7QVqO0VnXiOXZcLcwZIUGOwiqepw==
X-Received: by 2002:a17:903:1250:b0:185:40c6:3c2c with SMTP id u16-20020a170903125000b0018540c63c2cmr48228966plh.64.1666856824425;
        Thu, 27 Oct 2022 00:47:04 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:9d:2:99d6:ae15:f9aa:1819])
        by smtp.gmail.com with ESMTPSA id i4-20020a056a00004400b0056ba02feda1sm611386pfk.94.2022.10.27.00.47.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Oct 2022 00:47:03 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mark Brown <broonie@kernel.org>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 6/6] ASoC: dt-bindings: wcd938x: fix codec reset line polarity in example
Date:   Thu, 27 Oct 2022 00:46:52 -0700
Message-Id: <20221027074652.1044235-6-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.38.0.135.g90850a2211-goog
In-Reply-To: <20221027074652.1044235-1-dmitry.torokhov@gmail.com>
References: <20221027074652.1044235-1-dmitry.torokhov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver for the codec, when resetting the chip, first drives the line
low, and then high. This means that the line is active low. Change the
annotation in the example DTS accordingly.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 Documentation/devicetree/bindings/sound/qcom,wcd938x.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sound/qcom,wcd938x.yaml b/Documentation/devicetree/bindings/sound/qcom,wcd938x.yaml
index 51547190f709..2f5e0df93872 100644
--- a/Documentation/devicetree/bindings/sound/qcom,wcd938x.yaml
+++ b/Documentation/devicetree/bindings/sound/qcom,wcd938x.yaml
@@ -112,7 +112,7 @@ examples:
   - |
     codec {
         compatible = "qcom,wcd9380-codec";
-        reset-gpios = <&tlmm 32 0>;
+        reset-gpios = <&tlmm 32 GPIO_ACTIVE_LOW>;
         #sound-dai-cells = <1>;
         qcom,tx-device = <&wcd938x_tx>;
         qcom,rx-device = <&wcd938x_rx>;
-- 
2.38.0.135.g90850a2211-goog

