Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03DF16294F3
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 10:55:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238030AbiKOJzd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 04:55:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230108AbiKOJzZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 04:55:25 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A946112A96
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 01:55:24 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id s8so6462302lfc.8
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 01:55:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rh6bYHIsyDNDTnfvzoAbdszZSJH6gLxzazLnOaj70HA=;
        b=bSZZJfROZutTxt3595+PfI4ZhtPwBIahanBafiFrPMZPMBHP1Cmv8o6Il/aM2Xp+o/
         o71uuAgm14aS6XGge20gAPleiOmWMKad0YaGMNaqXiWzT4y/Xf8ixcz9bpPQbdBHjN/D
         29DWsynBrQj9W/80laRWbTMtubp/CHC/kaToM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rh6bYHIsyDNDTnfvzoAbdszZSJH6gLxzazLnOaj70HA=;
        b=noAJ9hulUZy1TEegNzZil1XK2ey0FMbHM8x7SP0hQdVzoPh5mukXi6sbQaJhptmC0D
         N93KP0O2G0z1tiZ0BNo5JNgHfVYNV2SgCqUx0Q1k5fAgb/+PZDecpvUgR2O4nDlPCSfk
         dh1Vf6mF59bNrl9FToqvERjaGmD/eXsytKhRZiFLv1EQZVOHGOtg0LmcqSsW6SXd6CCo
         ztcZG2KVMrlaH3QY5bysowyyOj+CQ8bUzCLCuA2VgxTZ1vkuADCF3J5lLaOCwlC4YJYI
         PXiiwLvH9GQ9FzfLmesirb40l5nV6N31cmHl5gaSbzqIpe3w40ixNmW8fOdbgitW+3tB
         xkAg==
X-Gm-Message-State: ANoB5pnjIGRQrD7hwD0A0jOjXVf3Ug8C9VXqeDuq5sJh/2nu+pS3jAMG
        CLAIuheEy9Zz2jcyTjOj795VMw==
X-Google-Smtp-Source: AA0mqf4IpDdOzB7uHmqouFHDhpeTZ4WG8GgpzIbAK3v260DQIYB187asu3q1m+4TmytYyTGWKJjh+A==
X-Received: by 2002:ac2:4f0e:0:b0:4b4:9193:1caf with SMTP id k14-20020ac24f0e000000b004b491931cafmr3920173lfr.300.1668506122988;
        Tue, 15 Nov 2022 01:55:22 -0800 (PST)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id q3-20020a19f203000000b00493014c3d7csm2148598lfh.309.2022.11.15.01.55.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 01:55:22 -0800 (PST)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Rob Herring <robh+dt@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Cosmin Tanislav <cosmin.tanislav@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     devicetree@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] dt-bindings: iio: ad74413r: add optional reset-gpios
Date:   Tue, 15 Nov 2022 10:55:16 +0100
Message-Id: <20221115095517.1008632-3-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221115095517.1008632-1-linux@rasmusvillemoes.dk>
References: <20221111143921.742194-1-linux@rasmusvillemoes.dk>
 <20221115095517.1008632-1-linux@rasmusvillemoes.dk>
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

The ad74412 and ad74413 devices have an active-low reset pin. Add a
binding allowing one to specify a gpio tied to that.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 Documentation/devicetree/bindings/iio/addac/adi,ad74413r.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/addac/adi,ad74413r.yaml b/Documentation/devicetree/bindings/iio/addac/adi,ad74413r.yaml
index 03bb90a7f4f8..62f446dbc3d8 100644
--- a/Documentation/devicetree/bindings/iio/addac/adi,ad74413r.yaml
+++ b/Documentation/devicetree/bindings/iio/addac/adi,ad74413r.yaml
@@ -51,6 +51,9 @@ properties:
       Shunt (sense) resistor value in micro-Ohms.
     default: 100000000
 
+  reset-gpios:
+    maxItems: 1
+
 required:
   - compatible
   - reg
@@ -129,6 +132,7 @@ examples:
         interrupts = <26 IRQ_TYPE_EDGE_FALLING>;
 
         refin-supply = <&ad74413r_refin>;
+        reset-gpios = <&gpio2 6 GPIO_ACTIVE_LOW>;
 
         channel@0 {
           reg = <0>;
-- 
2.37.2

