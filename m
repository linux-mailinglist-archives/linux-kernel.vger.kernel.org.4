Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98A18629D22
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 16:17:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231210AbiKOPRV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 10:17:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231158AbiKOPRJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 10:17:09 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC75B29C8A;
        Tue, 15 Nov 2022 07:17:08 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id ft34so36732428ejc.12;
        Tue, 15 Nov 2022 07:17:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0aIIY06xYqY7l4jJweomizRZIx+8BUWVg+G4chKa7D4=;
        b=Ow0QsVafB+uvSqbvosI1tESdZ/w+A2TgSh9iJ6NeV7NQDMt3JZUwDScCuGECKab1nR
         N7+RG/6Qymryvrqf9CIA4XgXFwIVvbst2bvjRR0txyfDuzkbuS+fltkQrZqoGrNCAPyD
         cMcffJ6oZsm9AI7YBNjr+fB+605M/4THnUnWDY8uLOAk3iMe1Z5ABE3JpX9iqV9TVEIr
         7JysUMdMqNz4OhTtQsXZ4w8Naia8wC/KNZ/nezwxKXYe2A46wWAIVjekbmgULQANYEqT
         SiOO9vOlLjoyElAlrjYMUMxpD9snOaZQHxo9OZO7iP8QoxreOh3S2KncL9tlKbMR10Qp
         NNEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0aIIY06xYqY7l4jJweomizRZIx+8BUWVg+G4chKa7D4=;
        b=5ElVGEMKjwhHuTk2PPz2e/kG3sGV1fqR1RHhMKl02MKE0+aFSe9T8C0gcnxdvr+dkZ
         cn23nonrKdsxakJaoa4apVLZvux7xg7pJZ5E00aqeU53C91olkrELHZy5NsbKJ/J5wLH
         WSep2dY0r8IblpEsqxQil0IGZ/vyiXkJW+qjTGwG8uj/NaOnPz68kDqJEqqm1kLzw0Qv
         2ZLnQX/g5f3LdGoJbZ2DKgr0Kdk3Y+x4EdZhOTsj+ZWVt+9LYjEHviILEFM2MjsRPHU/
         C6G9b+9f0p0IMdI/7HxvBoxpmMo9kLriQ5b8WKKiJtPwnbouBMuvlvBuRPWygruqiBKI
         AknA==
X-Gm-Message-State: ANoB5plX6NfGa1Y/zun0qrrNEs76zdwN9Xv62XXbnMgKgvcqtUR9/e5a
        /x3T8mofsg8m7TwDJE9KuOA=
X-Google-Smtp-Source: AA0mqf7Bzv0udxo4pNwE7c/x9B12pQkCA8tcPV8j7M/VAhMhDrV5DL4ULHhIlGaKewS0TB1gMmL68Q==
X-Received: by 2002:a17:907:2b26:b0:7ae:c460:c65f with SMTP id gc38-20020a1709072b2600b007aec460c65fmr14007961ejc.226.1668525427162;
        Tue, 15 Nov 2022 07:17:07 -0800 (PST)
Received: from localhost.localdomain ([5.2.194.157])
        by smtp.gmail.com with ESMTPSA id kv17-20020a17090778d100b007aece68483csm5126459ejc.193.2022.11.15.07.17.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 07:17:06 -0800 (PST)
From:   Cosmin Tanislav <demonsingur@gmail.com>
X-Google-Original-From: Cosmin Tanislav <cosmin.tanislav@analog.com>
Cc:     =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Cosmin Tanislav <cosmin.tanislav@analog.com>
Subject: [PATCH] dt-bindings: iio: temperature: ltc2983: drop $ref for -nanoamp properties
Date:   Tue, 15 Nov 2022 17:16:53 +0200
Message-Id: <20221115151653.393559-1-cosmin.tanislav@analog.com>
X-Mailer: git-send-email 2.38.1
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

Currently there are -nanoamp properties both with and without a $ref.
dt-schema has been modified to handle it as a standard unit, but the
change has been reverted since there were still occurrences of
-nanoamp properties with a $ref.
Remove this since it's the only occurrence left.

Signed-off-by: Cosmin Tanislav <cosmin.tanislav@analog.com>
---
 .../devicetree/bindings/iio/temperature/adi,ltc2983.yaml         | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml b/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml
index 44f8b0672f53..b69813f281da 100644
--- a/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml
+++ b/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml
@@ -325,7 +325,6 @@ patternProperties:
         description:
           Excitation current applied to the thermistor.
           0 sets the sensor in auto-range mode.
-        $ref: /schemas/types.yaml#/definitions/uint32
         enum: [0, 250, 500, 1000, 5000, 10000, 25000, 50000, 100000, 250000,
                500000, 1000000]
         default: 0
-- 
2.38.1

