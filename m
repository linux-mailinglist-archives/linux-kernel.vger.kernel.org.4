Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DAFE617D53
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 14:02:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230182AbiKCNCU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 09:02:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231664AbiKCNBx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 09:01:53 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5276D1573C;
        Thu,  3 Nov 2022 06:01:27 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id a13so2948604edj.0;
        Thu, 03 Nov 2022 06:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=04P2tRolwIvSbGhfQHq/FrE12nmgNU3RtNHs+uPtM2g=;
        b=dnHmCO97bGIC+Jyy8IQWvR4BsWXIVI7TyKHdjynNho/G131BVkZyxhiXxiUXhtg6qZ
         WlWB+5jSWuYufmxwacrxsXL8AV0st9h0CPq4juKwfK4dZi0vuYNaJcMt7hGCTdLoxJzK
         TaRP+Zc2sMXdW4jEp7urqTPOTIIZ9v+romaTT9dJQSW92ek+9dWp5fUNIb00yW7kjLAd
         pjgBXIrAgtCDrHm7Ay8ug+e189LJgyIqCnm95ZRFEHMIYmk+YXYJHV8YI4oWBA0A2EKl
         RemBWGE/x0AUa7GvXgrydHuR0W3skmdDOGSY17J6xrFz7yX1g3SzR+lfoqLI7Dm6suRw
         kgSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=04P2tRolwIvSbGhfQHq/FrE12nmgNU3RtNHs+uPtM2g=;
        b=ouHCspE9eXU3xGhibx64XAp3myQwHddVeamIyefz5YFvFPqvejYCFffSHEtUkUm8zb
         EpYYvUCUiXwHuXukEa9bVsaXuvBqFQMYK//qUgxnd2khzPQ7bYr/CGlQ8tAFxwgRJX+3
         wREAmRp1RX+tW/jAA+gddgNSj0xGvDGKyIPX7chfCz12C6l+iwcR8GdKJItCNrPAqVbu
         Z84xpVRxV1v7/wX7bYKhCjumn247BgV90C186g0qxCG5Gx7olVBfF0WLlFcfWUT8Zyfs
         W2JBtFIr17NRudbsgNRvNF3TxlidVvmqIKK/yZTwCPtXxFDYhjfXhZb3jmwYSZotwWJW
         HszQ==
X-Gm-Message-State: ACrzQf17CO7NvlJ9tbjXTqqwOnyd5OgEu7r4G4GZlUyERPFmbrO6nFe0
        tIpPk41xmfuhhGpJP9nhE2g=
X-Google-Smtp-Source: AMsMyM6p8HJee76lS+w8VExqd223CIGj17t8m0B1NxMkBiW+5H7HtValuPZRh2P23VIrm2VWOb4Mag==
X-Received: by 2002:a05:6402:2994:b0:453:4c5c:d31c with SMTP id eq20-20020a056402299400b004534c5cd31cmr29918522edb.412.1667480485718;
        Thu, 03 Nov 2022 06:01:25 -0700 (PDT)
Received: from localhost.localdomain ([5.2.194.157])
        by smtp.gmail.com with ESMTPSA id q12-20020a17090676cc00b00779a605c777sm451829ejn.192.2022.11.03.06.01.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 06:01:25 -0700 (PDT)
From:   Cosmin Tanislav <demonsingur@gmail.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Cosmin Tanislav <cosmin.tanislav@analog.com>
Subject: [PATCH v4 08/13] dt-bindings: iio: temperature: ltc2983: change default excitation for custom thermistors
Date:   Thu,  3 Nov 2022 15:00:36 +0200
Message-Id: <20221103130041.2153295-9-demonsingur@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221103130041.2153295-1-demonsingur@gmail.com>
References: <20221103130041.2153295-1-demonsingur@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cosmin Tanislav <cosmin.tanislav@analog.com>

Excitation cannot be set to auto-range when using a custom thermistor
or Steinhart sensor type. Default it to 1000nA to match the driver
and remove the auto-range value from the enum.

Signed-off-by: Cosmin Tanislav <cosmin.tanislav@analog.com>
---
 .../bindings/iio/temperature/adi,ltc2983.yaml          | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml b/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml
index b603219fb0c9..1b6a11f2aa9d 100644
--- a/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml
+++ b/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml
@@ -378,6 +378,11 @@ patternProperties:
             adi,sensor-type:
               const: 26
         then:
+          properties:
+            adi,excitation-current-nanoamp:
+              enum: [250, 500, 1000, 5000, 10000, 25000, 50000, 100000,
+                     250000, 500000, 1000000]
+              default: 1000
           required:
             - adi,custom-steinhart
       - if:
@@ -385,6 +390,11 @@ patternProperties:
             adi,sensor-type:
               const: 27
         then:
+          properties:
+            adi,excitation-current-nanoamp:
+              enum: [250, 500, 1000, 5000, 10000, 25000, 50000, 100000,
+                     250000, 500000, 1000000]
+              default: 1000
           required:
             - adi,custom-thermistor
 
-- 
2.38.1

