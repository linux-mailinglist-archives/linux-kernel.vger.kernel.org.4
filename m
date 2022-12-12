Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E6DC64A4ED
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 17:36:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232653AbiLLQgO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 11:36:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232518AbiLLQfv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 11:35:51 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85CDBFCDC
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 08:35:46 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id y25so291830lfa.9
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 08:35:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MrlXoiGbA/2CszX40DeD+tawQUe1JnBh5V1LSFMpA5I=;
        b=rer1g8GORdvmzqTiedHoBbXnxcQ2UNzJeXv2VXp7om9lUZzin06+eTqRtdHT13tBrK
         bOsYNmgzb/P06emo71WjpXinOxZyL7uOngh15mbJjUjSOtys0yQmNcd2UNwnhhuuZZij
         vALMoh44/cA3nzTtxcRE8eCUIlUv9PUHPmZd+h1V7ggQKS9oySwnMUtafUU5UKm3CDC/
         HQlf8IZ3VgxbEDJQkID8UHghIb2YRAo9lpZBwKT2UAIOJsGImLRetUP82Vdw7lXQ6MdB
         siwHNphVC/3+LazQFPdLxJn8S7QInTlFoPCUYyB+Ku7rL7962gsRE0nPeFscGtQ03WR8
         U2Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MrlXoiGbA/2CszX40DeD+tawQUe1JnBh5V1LSFMpA5I=;
        b=mIwjivTWTeBvD3yMIg8bvCPCaIhJY7LYb0+t6mjx935Q07OhnFkZfzX3LheK2nuaFI
         DoCCLtJH4LFHzGHFn7H8nUi537emIyc6nInUwvMFDUHTxUrMqLivLrpMx6Qk6O3JDZip
         vtL2PptiD+NWzS4uqYzAnh9A4G5a2X7hS8W3YFLqTo1e/o7F6gNQK3xmRl75K/v8BRYg
         De0WN3oQg5DHyiqGSNeU8cXKaFp5/wsaK+lWIAKfeVMEs+LHEoQf8xQXkyNmRCGmUrzx
         yMK/NtbYl9Lr6BlhgWXjlSkDffoYZASL7I2PagvxnjkYiXcgTNG43lRAjQLbJKUYLgkZ
         YHdA==
X-Gm-Message-State: ANoB5pnje6d3yqAH+inEqSK9EwtEVAwMWP0Fawf01G9XShLBXFWcJlGo
        ycRW7DMyHUSZCQORyr0XvWuBRg==
X-Google-Smtp-Source: AA0mqf4lEiGXY/G8VPd3QBRf0uJu0eKFDZFX8MfnlMleY/jamRaoZbjZon/FxlAbdhCsTU2WEhbadQ==
X-Received: by 2002:ac2:569e:0:b0:4b5:9e59:8ce0 with SMTP id 30-20020ac2569e000000b004b59e598ce0mr3141109lfr.40.1670862940945;
        Mon, 12 Dec 2022 08:35:40 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id v16-20020ac25b10000000b004acff58a951sm29209lfn.133.2022.12.12.08.35.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Dec 2022 08:35:40 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 04/12] dt-bindings: watchdog: qcom-wdt: add qcom,kpss-wdt-mdm9615
Date:   Mon, 12 Dec 2022 17:35:24 +0100
Message-Id: <20221212163532.142533-4-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221212163532.142533-1-krzysztof.kozlowski@linaro.org>
References: <20221212163532.142533-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,TVD_SPACE_RATIO autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document new MDM9615 qcom,kpss-wdt-mdm9615 watchdog/timer compatible.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml b/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml
index 93e4381067dd..1828eaf70b3b 100644
--- a/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml
+++ b/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml
@@ -40,6 +40,7 @@ properties:
           - enum:
               - qcom,kpss-wdt-apq8064
               - qcom,kpss-wdt-ipq8064
+              - qcom,kpss-wdt-mdm9615
               - qcom,kpss-wdt-msm8960
           - const: qcom,kpss-timer
           - const: qcom,msm-timer
-- 
2.34.1

