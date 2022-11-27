Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DDA3639CE4
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Nov 2022 21:41:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229514AbiK0UlL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Nov 2022 15:41:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbiK0UlG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Nov 2022 15:41:06 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E43FDF7F
        for <linux-kernel@vger.kernel.org>; Sun, 27 Nov 2022 12:41:06 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id d6so14542678lfs.10
        for <linux-kernel@vger.kernel.org>; Sun, 27 Nov 2022 12:41:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VxlrZWPFCrFQp2sHfL4Kx3y4fi4AGKGpCjaVKusjlG8=;
        b=d3jnqhwgV+iA6GcPuBtwyOCQEQeVQuXMje2Yq8vUbum5/zrwX0DR68A9MpR0kFimOo
         Qrygewdp7nUvUyCGwliIOgQ4Ys8ZY0ElyLOK7Rdhdvs9LnOCp61rabMG4vRkHT19AoXQ
         A46i6yJijhds8JhaIvGE5C61lbWI3DGbJlXAAqI/it2mH83OBqa6+IeVWuByIoNUK16v
         qpRqZCD6rst1XD9MfGfUzMl/oQbrS4nF0joWUJwDg6+1uolP/FrOx+MQwyPY4pcOghFd
         X1inSMEpy8Pn3FHOG2Sw7Yk5vB/0DU054+J7hhPQ3t3EehRQBgPOgnVjDbbAtQnnZSMX
         YU/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VxlrZWPFCrFQp2sHfL4Kx3y4fi4AGKGpCjaVKusjlG8=;
        b=zOsC8DUCMHVe+/MilOuHCI1p5XZ65IJ3ho2v3Lt9Qn9qMrEA9Gsdt3anKczqyoZKC9
         Vsu8rHGi85SZr+5ywjY42g9NQjGIGzqP5NrBMtu0UUy2uEMPLgEujhbBvnIvMg9ksm7m
         PGkNvVm1NMdluN6VRjTaI30Wti6Amy393ZSijPvHaDUGjUayiGfyJd39ykkPa6qsMdaS
         hAC/BTct7EaxZq5ilMAT1URSH4y2gLSJ/xAKav8EVbS2tsNL3RTO+KnfRe30ByyW/WHG
         bJL1REhk3GDRFHrk/fpXK5rffZP2SqA6qYkHn7R1hnYN+hSjfXfr6ls+jPcp7OqILsKN
         wQDA==
X-Gm-Message-State: ANoB5plGbFh4s4IL7Z5b3iFwUDeitIHKU0AxdQnfjkPbeXSKySL0PjaG
        +0Yes+KFqFrYZFofhlmxJAy8nQ==
X-Google-Smtp-Source: AA0mqf4MIUAbuFwcGvYcH41oYYkbfEqD9y1cRNS51qz0kBy2pxfU9tMJMCGRZHdofLv65jWUGuSiZw==
X-Received: by 2002:a05:6512:692:b0:4a2:58f0:c0df with SMTP id t18-20020a056512069200b004a258f0c0dfmr14940029lfe.268.1669581664453;
        Sun, 27 Nov 2022 12:41:04 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id bi39-20020a05651c232700b002773ac59697sm644607ljb.0.2022.11.27.12.41.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Nov 2022 12:41:04 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Vincent Knecht <vincent.knecht@mailoo.org>,
        Nikita Travkin <nikitos.tr@gmail.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Andrew Davis <afd@ti.com>, Gene Chen <gene_chen@richtek.com>,
        Bjorn Andersson <andersson@kernel.org>,
        ChiYuan Huang <cy_huang@richtek.com>,
        Luca Weiss <luca@z3ntu.xyz>, Neil Brown <neilb@suse.de>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 2/6] dt-bindings: leds: lp55xx: allow label
Date:   Sun, 27 Nov 2022 21:40:54 +0100
Message-Id: <20221127204058.57111-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221127204058.57111-1-krzysztof.kozlowski@linaro.org>
References: <20221127204058.57111-1-krzysztof.kozlowski@linaro.org>
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

The Linux driver and at least one upstream board use 'label' property:

  qcom/msm8996-xiaomi-gemini.dtb: lp5562@30: 'label' does not match any of the regexes: '^led@[0-8]$', '^multi-led@[0-8]$', 'pinctrl-[0-9]+'

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/leds/leds-lp55xx.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/leds/leds-lp55xx.yaml b/Documentation/devicetree/bindings/leds/leds-lp55xx.yaml
index 7ec676e53851..dfaa957eee74 100644
--- a/Documentation/devicetree/bindings/leds/leds-lp55xx.yaml
+++ b/Documentation/devicetree/bindings/leds/leds-lp55xx.yaml
@@ -48,6 +48,8 @@ properties:
     description: |
       GPIO attached to the chip's enable pin
 
+  label: true
+
   pwr-sel:
     $ref: /schemas/types.yaml#/definitions/uint8
     description: |
-- 
2.34.1

