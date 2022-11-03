Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A253A617D5A
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 14:02:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231688AbiKCNCa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 09:02:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231841AbiKCNB6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 09:01:58 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 925281740D;
        Thu,  3 Nov 2022 06:01:35 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id u24so2820997edd.13;
        Thu, 03 Nov 2022 06:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vijEGVxtJuuSzGLY9yn/4Hcsl6Bo59fqju4xVlM6UoM=;
        b=X4WtkQQbvCyXAbepVUilqzUNnrMIKg8ualCt8xz9J/6oe5WuAzw67cZ+ELtLXiiNrs
         wrLJBqHxRuvFGQSYAjloChLjFtebdoPZ6d84hOadIC/apJpYNIk5dkBqcSc50AZuBlnn
         z3oYEMB4gGHOmREbOWGcfpghwdMtdKhmZbhd3EkUnx9fJvZtqrYlUL5It71n/nS+fMDO
         d7Di1j3reDirFsfBPRJKRkwDWlJQdzl/VcPfRAlNtblO8XiLGGHAgFp8KoN73YzAzKiC
         59rPPYqB7AR2noEG1sdN7CvUDajk2m7ONtcx2WV9EvWKkTg76KXQ/ltZ6JXUSjLxV0TY
         NPnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vijEGVxtJuuSzGLY9yn/4Hcsl6Bo59fqju4xVlM6UoM=;
        b=Y+wgus8U6M9wzc10nqG8dwUPbITbyk+A71NUPXwmGraTrOG7IhWLmQGeJeddGhSg3a
         tgKvkpD2HiSDh4Ucu+Ki4GhuZYGPM1rzo2jhV47IyflR8sT6KhvqE5MaqzMK/Azkh7sB
         3H3aQdEsSqmpGh+iHK9f7AQTwSUMglB+/V7nXVFUETHN6saOX87vkD2YUHaUMf08ArYr
         w/uA7fJsjJzxpf9XGPazb1MHT2dC228y3xm6TclRVuFEjiNBUZSleETBtxyqkY9rWIXb
         jU4z+tYkK3BzwLL+BUENqHFgLfWTfGobQdyffC2se9cuhN6fCJbbxJQhv3Ksshwyhg2U
         /lZg==
X-Gm-Message-State: ACrzQf1ME3Z6w05Z7ZJHUvUFIJaLt/g0qBDuSXEssQUXquVeYjA500pd
        GPgw3vE5H/Qsk5V1JqJaSdnHzfS16rsHhA==
X-Google-Smtp-Source: AMsMyM7riczyqaNPV3bfZqHqRj3FIzx4oHsOXwBUWZ5CWfTladmDf5xTU1k74lRrgl8jSKiqDS+OZA==
X-Received: by 2002:a05:6402:2947:b0:451:32a:2222 with SMTP id ed7-20020a056402294700b00451032a2222mr29167999edb.376.1667480494116;
        Thu, 03 Nov 2022 06:01:34 -0700 (PDT)
Received: from localhost.localdomain ([5.2.194.157])
        by smtp.gmail.com with ESMTPSA id q12-20020a17090676cc00b00779a605c777sm451829ejn.192.2022.11.03.06.01.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 06:01:33 -0700 (PDT)
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
Subject: [PATCH v4 11/13] dt-bindings: iio: temperature: ltc2983: use generic node name in example
Date:   Thu,  3 Nov 2022 15:00:39 +0200
Message-Id: <20221103130041.2153295-12-demonsingur@gmail.com>
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

Examples should use the generic IIO node name. Fix it.

Signed-off-by: Cosmin Tanislav <cosmin.tanislav@analog.com>
---
 .../devicetree/bindings/iio/temperature/adi,ltc2983.yaml        | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml b/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml
index 467e165e9b0b..bd357ff28e65 100644
--- a/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml
+++ b/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml
@@ -420,7 +420,7 @@ examples:
         #address-cells = <1>;
         #size-cells = <0>;
 
-        sensor_ltc2983: ltc2983@0 {
+        temp@0 {
                 compatible = "adi,ltc2983";
                 reg = <0>;
 
-- 
2.38.1

