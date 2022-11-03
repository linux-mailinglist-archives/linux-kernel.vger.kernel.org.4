Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3AC9617D3F
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 14:01:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231703AbiKCNBe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 09:01:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231608AbiKCNBQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 09:01:16 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 145E611C3B;
        Thu,  3 Nov 2022 06:01:15 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id kt23so4978627ejc.7;
        Thu, 03 Nov 2022 06:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RaTZtDR0TYFCz7i+1pOBqesyuPZfqn64Er9UEoziVtg=;
        b=Ezpvi8ir/iAl/l0UWjUGjFxvoDYtTYfDLrLQjPzHycAsdKbPTBMo4JtT+FqOLebh2y
         rconcgFXudbDyB0bmfXpp1splmpzNSVKAx3ZZ61NCEgc42D3bEVunct/w7Y1gh3/m+zV
         I0idt/ErkjAcxkZaqpIuRIQIRfSXpimtfvQmxDpeVV8Dg6MPR20oXd+bwnapFKbK+Ci9
         K6pndCroMYZcNfiw/Dt/gPsTkgfk+HoXGscbxcAYM2I4WGOPa4RFIpvSO+BPfc/xBEyR
         W6QNPJ2j9bWpsgb5QIS0YulgNvHZEVIW8OwGhWAGvN5Q0WFJw5lyvQenAtszZaSsUJ7Z
         96Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RaTZtDR0TYFCz7i+1pOBqesyuPZfqn64Er9UEoziVtg=;
        b=IDuiDQKgJlZ02Zcb3lMT0RC/50XMr3eWpRRg3AZzdUmg4doXP2JjVEpQPykVjXrCEM
         cTRrz0fn5wFGJD2BKHFCVEsLZsHetzfNhsQ1tgQzOW2r724fShmBq2n13bzWVGC2Rk6i
         w0BJlB33Ruo6WWIN8xf0OiNmkTa+PGj4ywsST33eWwJ70vcVrXs7Rd3R+kgx5g7NaMCs
         Xp+EEJpzFG1aF8O3/7QmCMlK1J3+YC2HJr2fiFffoRxXgjdls78f3kJeu3ERbVbm/cXQ
         VB5Ngy4ib3iyzY9o34+RnMR5ZOwaZbfTUPox2gtr8Jt5SGcnmt8Y6la6uNh1wkld/Y/H
         tmPg==
X-Gm-Message-State: ACrzQf1sPq353K2EgsyFY3VfUMuyIkHqBz5xNfbyaoqbWRefwh7PbNqD
        7GpGszzb7696dNIAQGpu4FM=
X-Google-Smtp-Source: AMsMyM7G0RbtkISeuBtn/3YASTT52UYNxSNN2HXZ0S3fvyEXliezJISNv1KVxXiiEnkv/ZeAjuEPgw==
X-Received: by 2002:a17:907:6e0d:b0:7ae:2277:9fc9 with SMTP id sd13-20020a1709076e0d00b007ae22779fc9mr1536983ejc.334.1667480471896;
        Thu, 03 Nov 2022 06:01:11 -0700 (PDT)
Received: from localhost.localdomain ([5.2.194.157])
        by smtp.gmail.com with ESMTPSA id q12-20020a17090676cc00b00779a605c777sm451829ejn.192.2022.11.03.06.01.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 06:01:11 -0700 (PDT)
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
Subject: [PATCH v4 03/13] dt-bindings: iio: temperature: ltc2983: use hex for sensor address
Date:   Thu,  3 Nov 2022 15:00:31 +0200
Message-Id: <20221103130041.2153295-4-demonsingur@gmail.com>
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

Addresses should be in hex, fix it.

Although the driver initially specified 1-20, it can be made free-range
since the address is supposed to match reg, onto which we can impose
restrictions based on the compatible property value.

Signed-off-by: Cosmin Tanislav <cosmin.tanislav@analog.com>
---
 .../devicetree/bindings/iio/temperature/adi,ltc2983.yaml        | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml b/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml
index 82667adc85b1..29f6fa5e2529 100644
--- a/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml
+++ b/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml
@@ -55,7 +55,7 @@ properties:
     const: 0
 
 patternProperties:
-  "@([1-9]|1[0-9]|20)$":
+  "@([0-9a-f]+)$":
     type: object
 
     properties:
-- 
2.38.1

