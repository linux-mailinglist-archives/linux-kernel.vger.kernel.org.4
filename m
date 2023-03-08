Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E36516B0320
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 10:40:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbjCHJkz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 04:40:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbjCHJko (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 04:40:44 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3856FB2571;
        Wed,  8 Mar 2023 01:40:39 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id u9so63282103edd.2;
        Wed, 08 Mar 2023 01:40:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678268438;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sBRXPiMTjUXngf7UPU3ji30MSYizruFj0On8LBzCAgs=;
        b=Vi49vQhL808PneaoEQRvf+35yFIL9IOBVqMM69KJ6d/R7TpBDCVKvGJ3rfslt2QLWh
         aStXDUfJs2EqfkRzSZiJ7JrVDBJcMKOqSzi1/6sxk4temsPjdRddBmfJlmGqEQqWPlNZ
         2moGM5WOTHi0RVGG+FaT99c9lz77olCBXIdPSFn3g0OS0c+mcsWug1EkhSAisURKpJ2R
         NyNFV7sQVwS+JuaBeca4BZvDVOV1z1v1cdIeSqzmUjTc8paEINAHSjrS+pX86N+i3WJu
         7rUW7OhpktEsNtYE3lXGf07TNho0kIL+xLCoCtxYMupm7oH/r0bBV9PMhS7znlond90j
         rKyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678268438;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sBRXPiMTjUXngf7UPU3ji30MSYizruFj0On8LBzCAgs=;
        b=hCeHAfbF8T86WmvINO62mGpSqScZodFIsVzXr/qywCB7nPZT00kQwds5FTASDdkNAX
         xnmGTB0JAtQgd23qsngeYp3eQfZiPqfhrIUxB2bGMIoVlaa2B/BKfIhSbzLWKfRCZyW1
         9XRN0lNsWcbIEL8xJK9+zd2DIwztY6bU8dyGmFnD7HWWNsyBVMFez4hrHQKRGMKVE9yi
         v43C4buUSxQ/KiUD1lXIXUD+6YphYtLd819TqTZg9k8nNU0J0qX40pPVWMjXZEVe/p6x
         H59EvQ4JQjAlr23YuPM2ruQpP/mGqpx+QmmxnRvzu7OSwAaNLcRDYROVQbJHz3yVxu+A
         TWKQ==
X-Gm-Message-State: AO0yUKXm8d0mHBD5CpjGqFNgEXccKa/axpsFb9kx+mCiMLjWQ5ddzV0h
        JJKGYXcoKLS/qlhxxowzeZo=
X-Google-Smtp-Source: AK7set+LccPOAmjQxKoK78TUwBCqe+sAzzU0MwC2r/prow7dFQjFvO+zXu0ahmyGebNfrSpmGc1h0Q==
X-Received: by 2002:a17:907:94c5:b0:8b1:3821:1406 with SMTP id dn5-20020a17090794c500b008b138211406mr22570420ejc.45.1678268437669;
        Wed, 08 Mar 2023 01:40:37 -0800 (PST)
Received: from xeon.. ([188.163.112.76])
        by smtp.gmail.com with ESMTPSA id h17-20020a17090634d100b008ee5356801dsm7240014ejb.187.2023.03.08.01.40.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 01:40:37 -0800 (PST)
From:   Svyatoslav Ryhel <clamor95@gmail.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/2] dt-bindings: hwmon: ina2xx: add supply property
Date:   Wed,  8 Mar 2023 11:40:23 +0200
Message-Id: <20230308094024.14115-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230308094024.14115-1-clamor95@gmail.com>
References: <20230308094024.14115-1-clamor95@gmail.com>
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

Add supply property.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 Documentation/devicetree/bindings/hwmon/ti,ina2xx.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/hwmon/ti,ina2xx.yaml b/Documentation/devicetree/bindings/hwmon/ti,ina2xx.yaml
index 47af97bb4ced..0f494131fa05 100644
--- a/Documentation/devicetree/bindings/hwmon/ti,ina2xx.yaml
+++ b/Documentation/devicetree/bindings/hwmon/ti,ina2xx.yaml
@@ -57,6 +57,8 @@ properties:
     $ref: /schemas/types.yaml#/definitions/uint32
     enum: [1, 2, 4, 8]
 
+  vdd-supply: true
+
 required:
   - compatible
   - reg
@@ -73,5 +75,7 @@ examples:
             compatible = "ti,ina220";
             reg = <0x44>;
             shunt-resistor = <1000>;
+
+            vdd-supply = <&vdd_3v0_sen>;
         };
     };
-- 
2.37.2

