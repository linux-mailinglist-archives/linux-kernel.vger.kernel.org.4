Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A76615EE850
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 23:31:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233972AbiI1Vbr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 17:31:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233601AbiI1Vbo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 17:31:44 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3B42760FE;
        Wed, 28 Sep 2022 14:31:41 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id k3-20020a05600c1c8300b003b4fa1a85f8so1688649wms.3;
        Wed, 28 Sep 2022 14:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=kHtcM/ZhNIQfonSbRMlI/alAAHn24v5beci83RsPETQ=;
        b=QcPgl9ROwUeqG6rw+McsRw+ZhRgG365ZnH4zH77hwFmLx7OXhRi2n0lCo1y2KUvo99
         1RDlXGyiTTiei5sZYSByiYiNVgKwCiLA2oGzoZZGVUOTsIV+tdhJTjIopATrZdPUScv6
         vTKhiPK9zzzeBKZds27pPLluyiugXqWNHBNxMBlt40c6brWNOytiw0MqbwEPnYpbjBLX
         H2SrRN2SabMXgmokbp9OuQurISROaC9JU0MnJEeJ0vcXKLMB8WArmkcM7Gd8uIJRJFbz
         JWVmKg1lsYzz/8qzXRWXcZ90/Ukj6uTFXve9qiW0QDAIQaAchtsflLGLc4q+aMFmH3YG
         sejQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=kHtcM/ZhNIQfonSbRMlI/alAAHn24v5beci83RsPETQ=;
        b=UdKla1kT0B4zKY/aD2yttXv6+iJh3CxZdzfGHd12CJSSRtxwAD8+CRwF53DIKDuF8Q
         52K7eoDGrslp5cTjWJkfGM95Qww0PVXaIBuJNv6OcnVEGcjKT0TD//pljKSLf7ZkbXWX
         DUAsDXqY88YRzpcnH/ZtAzHFoqfF9lwCR7q4Zm/XQ7/dUPWqwq8yaBfr/itSg/ceS+DD
         4vVTBNvXSOH+gXTGc7LjNinF/q0sG6M2XXZMnbfc7y7ZcSHcTtlUEuvZ4TapFNRQBLgm
         eMuNWTBO6q8u2Ru1UQ3Fo2mnVuvTMYN95sRc8Ut5mc8vLHcKNh4mOhAEvSgXqQnnrsmM
         ZCMg==
X-Gm-Message-State: ACrzQf0/RSre0JCi7HHHN77pq4iq4BQ0DheDfRR1ZffA5VEaSoBXfMyj
        Ss5bLfHf0DpPvBNYaCMi+1I=
X-Google-Smtp-Source: AMsMyM7aOjoYbO4hfmIPy5nzW+hPDOHiP9ssPu0Tsdkl4upfL/5kCoMwt7VCP+e4McZiUqr1nWMk2w==
X-Received: by 2002:a05:600c:211a:b0:3b4:75ee:c63e with SMTP id u26-20020a05600c211a00b003b475eec63emr8581535wml.44.1664400700333;
        Wed, 28 Sep 2022 14:31:40 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id d15-20020adffd8f000000b00228a6ce17b4sm5082891wrr.37.2022.09.28.14.31.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 14:31:39 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Christopher Ruehl <chris.ruehl@gtsys.com.hk>,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] devicetree: hwmon: shtc1: Clean up spelling mistakes and grammar
Date:   Wed, 28 Sep 2022 22:31:39 +0100
Message-Id: <20220928213139.63819-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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

The yaml text contains some minor spelling mistakes and grammar issues,
clean these up.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 .../devicetree/bindings/hwmon/sensirion,shtc1.yaml        | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/hwmon/sensirion,shtc1.yaml b/Documentation/devicetree/bindings/hwmon/sensirion,shtc1.yaml
index 7d49478d9668..159238efa9ed 100644
--- a/Documentation/devicetree/bindings/hwmon/sensirion,shtc1.yaml
+++ b/Documentation/devicetree/bindings/hwmon/sensirion,shtc1.yaml
@@ -10,7 +10,7 @@ maintainers:
   - Christopher Ruehl chris.ruehl@gtsys.com.hk
 
 description: |
-  The SHTC1, SHTW1 and SHTC3 are digital humidity and temperature sensor
+  The SHTC1, SHTW1 and SHTC3 are digital humidity and temperature sensors
   designed especially for battery-driven high-volume consumer electronics
   applications.
   For further information refere to Documentation/hwmon/shtc1.rst
@@ -31,13 +31,13 @@ properties:
   sensirion,blocking-io:
     $ref: /schemas/types.yaml#/definitions/flag
     description:
-      If set, the driver hold the i2c bus until measurement is finished.
+      If set, the driver holds the i2c bus until the measurement is finished.
 
   sensirion,low-precision:
     $ref: /schemas/types.yaml#/definitions/flag
     description:
-      If set, the sensor aquire data with low precision (not recommended).
-      The driver aquire data with high precision by default.
+      If set, the sensor acquires data with low precision (not recommended).
+      The driver acquires data with high precision by default.
 
 required:
   - compatible
-- 
2.37.1

