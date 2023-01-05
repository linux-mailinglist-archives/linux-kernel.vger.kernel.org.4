Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0132065E641
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 08:51:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230397AbjAEHvK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 02:51:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjAEHvH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 02:51:07 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E02E39FA7
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 23:51:05 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id c2so11040378plc.5
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jan 2023 23:51:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ACKJJiJLwOD+bKHkEbqMQJLUZaVo4k37AOJXtfHcw4s=;
        b=TjHFlXlYP8a6e2cNMwXF3OtUlGDX67wYUv03D5hc3N6jjhFQx26qra2p3CoxaCo9T2
         QiQgtTgyOL/e39N+D+N54ZbaYHgO5ZMLZXMvNT/O0Hvt0a4s4vQLY00/Ukc75Ny3mgDQ
         cKIVrQHx9eJHyW7wwg5Hy7OutS86AHKs56/UGYqvDyUVGPyRo6ZrOQ5B0aqYdvg963vL
         cWk4Ap3ogtD35fvR9p46D31wsz1tfyyPthfRvWyt0mGX/IeFuB4VuvRaiXruWWlHc9cv
         1pZGYclb82fxEHVpBLHS8lnw+XwzTx8SCZFd+v8kKu4vd+KkWz2tUTj9izgqneegr/iu
         dceQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ACKJJiJLwOD+bKHkEbqMQJLUZaVo4k37AOJXtfHcw4s=;
        b=gDzLDDt0tmdePSW5Ga0E003gVA24gyjJw8/ktpJIMrOFhwWvhwgFAOzSmpw9XSxc+T
         vKpLmBLWJIVUoDA2VgJOE2Udw2JF6C8q/Kpw+Ygz6zxf6a7rvtu+q6yOfBRR/gt7Ogxx
         HLhNu6L9qfaf/RadOppxIbXrOQjxHLa7Wfh8GbBoStGXv5Mtbv4DSutK+wuVpEfk9Cba
         cJUlPMNCbaGWPAdmwjElvy3BerPwxw9JsX0wtCwKu/G9XKN7yFGqNeGm4pPzAqLniymY
         kejjHR1FlMPjfWoRjoKbcvVuvtWGlgzjmgO2qJ/x0dpIe11Yze00XufmLmgE/Pjc8lkp
         QQhA==
X-Gm-Message-State: AFqh2kooD7iLSjyILJ8w+rRPWBd5uVhMDjFYKY23xAfYj6YtTs9qxHX4
        BAgaNBqbnHjG1qsHIrzVTV99lQ==
X-Google-Smtp-Source: AMrXdXtWmCoKQRKYF6n9uBgZWh3dfSyz8kkf2r69NubGg3H0lv4ZzrM4Bcd5DKUShIQcQbSm2riNPQ==
X-Received: by 2002:a05:6a20:6aa8:b0:b3:87f8:8387 with SMTP id bi40-20020a056a206aa800b000b387f88387mr31789839pzb.50.1672905065014;
        Wed, 04 Jan 2023 23:51:05 -0800 (PST)
Received: from niej-dt-7B47.. (80.251.214.228.16clouds.com. [80.251.214.228])
        by smtp.gmail.com with ESMTPSA id g130-20020a625288000000b0056c2e497b02sm24513555pfb.173.2023.01.04.23.50.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jan 2023 23:51:04 -0800 (PST)
From:   Jun Nie <jun.nie@linaro.org>
To:     heikki.krogerus@linux.intel.com, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        devicetree@vger.kernel.org
Cc:     sven@svenpeter.dev, shawn.guo@linaro.org,
        bryan.odonoghue@linaro.org, Jun Nie <jun.nie@linaro.org>
Subject: [PATCH 1/2] dt-bindings: usb: tps6598x: Add wakeup property
Date:   Thu,  5 Jan 2023 15:50:57 +0800
Message-Id: <20230105075058.924680-1-jun.nie@linaro.org>
X-Mailer: git-send-email 2.34.1
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

Add wakeup property description. People can enable it with adding
the property.

Signed-off-by: Jun Nie <jun.nie@linaro.org>
---
 Documentation/devicetree/bindings/usb/ti,tps6598x.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/ti,tps6598x.yaml b/Documentation/devicetree/bindings/usb/ti,tps6598x.yaml
index fef4acdc4773..348a715d61f4 100644
--- a/Documentation/devicetree/bindings/usb/ti,tps6598x.yaml
+++ b/Documentation/devicetree/bindings/usb/ti,tps6598x.yaml
@@ -23,6 +23,8 @@ properties:
   reg:
     maxItems: 1
 
+  wakeup-source: true
+
   interrupts:
     maxItems: 1
 
@@ -48,6 +50,7 @@ examples:
         tps6598x: tps6598x@38 {
             compatible = "ti,tps6598x";
             reg = <0x38>;
+            wakeup-source;
 
             interrupt-parent = <&msmgpio>;
             interrupts = <107 IRQ_TYPE_LEVEL_LOW>;
-- 
2.34.1

