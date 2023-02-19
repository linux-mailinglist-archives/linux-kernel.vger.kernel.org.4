Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D8DA69C186
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Feb 2023 18:04:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230481AbjBSREE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Feb 2023 12:04:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230474AbjBSREA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Feb 2023 12:04:00 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E7ABCA11;
        Sun, 19 Feb 2023 09:03:55 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id c3so683927wrb.6;
        Sun, 19 Feb 2023 09:03:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LxN/C/jybwbMYR4wEWNcCABLxYQEb4wcLKCkWZ6KEn0=;
        b=d1ymHx5n3MBvY1AGRijA1AFagn6OV2Y4iNbTXgCvTaFtoQlHjHkUzNyAxsD+5y09gb
         zfdG3cohW1ETkoCYg3jU+oPT+xFUKeuTD715kFwj4o6tAiJqUXpNQGX9CYMP6jipgMr8
         K24DFEh+55uI2BSLrXYPqllOmFbX/DeALDExWYbH2FIBIwAOv3woBVAQ3Agv39ubQFOn
         iB5CkqRXQB+vfLuxQdeXiaQBZ9s2/a6NiTmKXvVnG1wxXxsFu43L6Pzic7HNyg36TuwE
         f8JGjb4QFyEmWaMqGNM6ON9h/z7kxOHknjXytpt4YTXAHVaJlRyXOmpbDmXVO0JbIc2A
         LaUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LxN/C/jybwbMYR4wEWNcCABLxYQEb4wcLKCkWZ6KEn0=;
        b=TjTTU17FZjN+3YLMaQv170WrXSn8mG/53P6XoLTMT3xvnyCcMFyWmv5t1D7VmELqut
         Kj/ZOx39kFd6rnAgDf1CnFlSMuIzBM6UpCdjDVISDw+dUu67LrG7r4E+j7LdafCLXTjH
         xU7sKh1zYddYc6SPpsnC8DVwGM7uO141O5IM3MUIoU7N8VZovuW0pbnbSboNfbLxZymk
         jtxo+1xnyEvJyClW/5Wurl1wgW/jB0n6wOnccoxuiZf/2S9cTU6cEFXoAvOmlM88hiP4
         hvdGF088n9Y0di8u5Nf4B0iL4U5yY/oC58j+Ff7rEb77QWwowQmPJdeTGeRO7sqz4NSr
         Y1qQ==
X-Gm-Message-State: AO0yUKWkf4dDEl5bBFtBWH3Iwgz1AkisDdiSale5lF15MmJrDZMNxjsn
        lqqNgl7krnExgsRLg0OwP6fI252dY/M=
X-Google-Smtp-Source: AK7set+Ck7r77P+7vw05qYXeQ2N6aH1H09nEOXtpxYksSqRKpyUBykedCvrBpOp4/iX8Db0sIIOIIQ==
X-Received: by 2002:a5d:4441:0:b0:2c6:1482:33fa with SMTP id x1-20020a5d4441000000b002c6148233famr108589wrr.59.1676826233761;
        Sun, 19 Feb 2023 09:03:53 -0800 (PST)
Received: from localhost.localdomain (6.red-83-37-22.dynamicip.rima-tde.net. [83.37.22.6])
        by smtp.gmail.com with ESMTPSA id m11-20020a5d6a0b000000b002c55ec7f661sm9918548wru.5.2023.02.19.09.03.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Feb 2023 09:03:53 -0800 (PST)
From:   Angel Iglesias <ang.iglesiasg@gmail.com>
To:     linux-iio@vger.kernel.org
Cc:     Angel Iglesias <ang.iglesiasg@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alexandru Lazar <alazar@startmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andreas Klinger <ak@it-klinger.de>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 6/7] dt-bindings: iio: pressure: bmp085: Add BMP580 compatible string
Date:   Sun, 19 Feb 2023 18:03:05 +0100
Message-Id: <2510dccfd44e2225c5978bfdf4136f423326c31a.1676823250.git.ang.iglesiasg@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1676823250.git.ang.iglesiasg@gmail.com>
References: <cover.1676823250.git.ang.iglesiasg@gmail.com>
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
index 63885af6a74b..6fda887ee9d4 100644
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
2.39.2

