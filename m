Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C44E67FC2E
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jan 2023 02:36:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233395AbjA2BgI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Jan 2023 20:36:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232628AbjA2Bfn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 20:35:43 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4581223C64;
        Sat, 28 Jan 2023 17:35:09 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id l41-20020a05600c1d2900b003daf986faaeso5945579wms.3;
        Sat, 28 Jan 2023 17:35:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H4fPPorGvJaEHWHXxPRWBCDldwjlaX0Z+q61uPOSuPo=;
        b=ceY+MdeznrAVhfOXeFxFV4OkwcSQWzojzffUAafOIxL8cBMYUJkvJSx/5oT2tKuNHv
         aVvoIEQ5YmtBmUB8l4zS4xMTrKjW8zk6XokRl+kdt35aZtlI9KPpNxXaP2/g8EPtOOYv
         n6GYK2270xwFyP7eNW8ms0/V6rRbGoLI1ndxDsSTHpKz8Dn86ex+t5CiYkktu6oGhghJ
         q3QwsxV3ui1nFeQhzOdLGWGV0kuKy8X/BsT7bF/XjJOI3w1XCsNLDwZgJwCDvCXjgMyQ
         N8uG80Z3cbesp1J8RVsNkRO3RPTT2zsaOx9SpzG0Eiuq19R9h/+UmhnqIdIvOwikW9qE
         rhNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H4fPPorGvJaEHWHXxPRWBCDldwjlaX0Z+q61uPOSuPo=;
        b=YTJPy1hxX8EHZANZ/p9wMAEocl3/x7T0fWD74AL/ao6W0xh91Q/AsO4lvKnq6hpWpB
         dwujP7YvhTRIOvVmvPg+QfmEzzonz5kLH+Dl4vcrcAx2gkEM6xJeGtxdoD6ZoxqwJByy
         dIjEiGo268C04Om3+15Cdk8tcc74AoIgIgu54E6kwpngC7w7hJvPtsTOw19mVkoHye0i
         92UPbtsduUhS6Jml9P5b5W/W1KGG40AtPQu73/EN6ZV862dNt+dSUOkokJd5dTfRbVsG
         Pkk/RJChl1m33sGZVvm/LsPr9xrY5uN/7ryVEgwzXT5UrgNb16Xh3/7SCi5SG7vDfWEq
         SoPQ==
X-Gm-Message-State: AFqh2kpayRMSLDh4xryqPgtBuyLce2EUmmurTNrGLfzNFdd2gEwJWfQY
        ZN2q9hoCTkKJUgiQtsxfnR8/92I3YZA=
X-Google-Smtp-Source: AMrXdXvVleLbJ1l71VKbn3RArWQSbjlMwVwC/zcNFPLY4LRhcXiMGIzXh4Be5UdOXd7UO68NZPFjdA==
X-Received: by 2002:a05:600c:3110:b0:3dc:e66:4cb9 with SMTP id g16-20020a05600c311000b003dc0e664cb9mr20982368wmo.13.1674956107358;
        Sat, 28 Jan 2023 17:35:07 -0800 (PST)
Received: from localhost.localdomain (143.red-83-35-57.dynamicip.rima-tde.net. [83.35.57.143])
        by smtp.gmail.com with ESMTPSA id r7-20020a05600c434700b003dc3f195abesm5197132wme.39.2023.01.28.17.35.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Jan 2023 17:35:07 -0800 (PST)
From:   Angel Iglesias <ang.iglesiasg@gmail.com>
To:     linux-iio@vger.kernel.org
Cc:     Angel Iglesias <ang.iglesiasg@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andreas Klinger <ak@it-klinger.de>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 6/7] dt-bindings: iio: pressure: bmp085: Add BMP580 compatible string
Date:   Sun, 29 Jan 2023 02:33:08 +0100
Message-Id: <9d840fc038896c1b73cf0922fc11190eaf4116cc.1674954271.git.ang.iglesiasg@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <cover.1674954271.git.ang.iglesiasg@gmail.com>
References: <cover.1674954271.git.ang.iglesiasg@gmail.com>
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

Add bosch,bmp580 to compatible string for the new family of sensors.
This family includes the BMP580 and BMP581 sensors. The register map
in this family presents significant departures from previous generations.

Signed-off-by: Angel Iglesias <ang.iglesiasg@gmail.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

diff --git a/Documentation/devicetree/bindings/iio/pressure/bmp085.yaml b/Documentation/devicetree/bindings/iio/pressure/bmp085.yaml
index 72cd2c2d3f17..f52c4794e21b 100644
--- a/Documentation/devicetree/bindings/iio/pressure/bmp085.yaml
+++ b/Documentation/devicetree/bindings/iio/pressure/bmp085.yaml
@@ -17,6 +17,7 @@ description: |
     https://www.bosch-sensortec.com/bst/products/all_products/bmp280
     https://www.bosch-sensortec.com/bst/products/all_products/bme280
     https://www.bosch-sensortec.com/bst/products/all_products/bmp380
+    https://www.bosch-sensortec.com/bst/products/all_products/bmp580
 
 properties:
   compatible:
@@ -26,6 +27,7 @@ properties:
       - bosch,bmp280
       - bosch,bme280
       - bosch,bmp380
+      - bosch,bmp580
 
   reg:
     maxItems: 1
-- 
2.39.1

