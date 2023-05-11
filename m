Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E86D6FFC81
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 00:07:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239064AbjEKWHY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 18:07:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238815AbjEKWHV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 18:07:21 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 202C06A45
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 15:07:20 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id 41be03b00d2f7-52c30fa5271so4785029a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 15:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1683842839; x=1686434839;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E8Q+tBaaYskzauPjWFnHayDJlvaj5LMUfZeaf2NrQbQ=;
        b=jO3XvKkwtvxNz993+Li+17L6pa4w/TVRvEMY4tUBXUiXVgPBB5uE1U72Py0ADFowqw
         4UhdzKHqnYW3oIJhRX6Ezvcu9lKjTsfbJHjTMphXNHjJgnIFfy0PwACd0pi08JOHNN5O
         k+3Cb/D+sfCroFVfwv7zboAl4BRPgefSneMLY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683842839; x=1686434839;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E8Q+tBaaYskzauPjWFnHayDJlvaj5LMUfZeaf2NrQbQ=;
        b=WIYMCBoP3+nhJTzKqeo5cA2OoRx5mdsKMWQqqUWg2WbvFVWZD6TDaOYXLtcQH8JhOT
         QuD9pm1ipYnXlvq/vUIviVLpv139meIt3qoQMwLSubQ04TJHaCpHLww2j/rDueLvhnOj
         CCJyozvJ7dhWoIP1pZady+zUi9bj9AvPSzTyO/sxak6c+D/vWsCrgDim5D4uNBibnvVR
         EZlGJ2isAtEAp5hv/sj311ZikvRDtlTebNv69E3Yby/OoFWkpsl2p7eNS4DrGElx5off
         q4fhPHaSEN5rOPYBCFzzGMW55NFtHPJ0wS+rTEipyKKbCBPpbHJ2oYy22G4qbfsL+Hb3
         td6A==
X-Gm-Message-State: AC+VfDz4Pyn/4p9VvJ/GoVvXpexsJKdaHMr3sSV70q3fl9AR3rIRXHvD
        og359tBXXLffSHAI4Pn3Bqwd9w==
X-Google-Smtp-Source: ACHHUZ69G7krdwEzUJkF+GCEatd/o1CBrA0/WhHGMcIG6ybMy7MqBpZJm1nTPpJLTV07Tq+WcxoYhA==
X-Received: by 2002:a17:90b:234f:b0:250:2d63:7b79 with SMTP id ms15-20020a17090b234f00b002502d637b79mr23492520pjb.43.1683842839570;
        Thu, 11 May 2023 15:07:19 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:b96a:d776:ee3:e572])
        by smtp.gmail.com with ESMTPSA id h24-20020a17090a9c1800b00247735d1463sm17589457pjp.39.2023.05.11.15.07.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 15:07:18 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org,
        wenst@chromium.org, Eddie Huang <eddie.huang@mediatek.com>,
        Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
        Ben Ho <Ben.Ho@mediatek.com>, Weiyi Lu <weiyi.lu@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-arm-kernel@lists.infradead.org,
        Tinghan Shen <tinghan.shen@mediatek.com>, jwerner@chromium.org,
        Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>,
        yidilin@chromium.org, Seiya Wang <seiya.wang@mediatek.com>,
        Douglas Anderson <dianders@chromium.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/6] dt-bindings: interrupt-controller: arm,gic-v3: Add quirk for Mediatek SoCs w/ broken FW
Date:   Thu, 11 May 2023 15:05:35 -0700
Message-ID: <20230511150539.1.Iabe67a827e206496efec6beb5616d5a3b99c1e65@changeid>
X-Mailer: git-send-email 2.40.1.606.ga4b1b128d6-goog
In-Reply-To: <20230511150539.6.Ia0b6ebbaa351e3cd67e201355b9ae67783c7d718@changeid>
References: <20230511150539.6.Ia0b6ebbaa351e3cd67e201355b9ae67783c7d718@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When trying to turn on the "pseudo NMI" kernel feature in Linux, it
was discovered that all Mediatek-based Chromebooks that ever shipped
(at least ones with GICv3) had a firmware bug where they wouldn't save
certain GIC "GICR" registers properly. If a processor ever entered a
suspend/idle mode where the GICR registers lost state then they'd be
reset to their default state.

As a result of the bug, if you try to enable "pseudo NMIs" on the
affected devices then certain interrupts will unexpectedly get
promoted to be "pseudo NMIs" and cause crashes / freezes / general
mayhem.

ChromeOS is looking to start turning on "pseudo NMIs" in production to
make crash reports more actionable. To do so, we will release firmware
updates for at least some of the affected Mediatek Chromebooks.
However, even when we update the firmware of a Chromebook it's always
possible that a user will end up booting with old firmware. We need to
be able to detect when we're running with firmware that will crash and
burn if pseudo NMIs are enabled.

The current plan is:
* Update the device trees of all affected Chromebooks to include the
  'mediatek,gicr-save-quirk' property. The kernel can use this to know
  not to enable certain features like "pseudo NMI". NOTE: device trees
  for Chromebooks are never baked into the firmware but are bundled
  with the kernel. A kernel will never be configured to use "pseudo
  NMIs" and be bundled with an old device tree.
* When we get a fixed firmware for one of these Chromebooks, it will
  patch the device tree to remove this property.

For some details, you can also see the public bug
<https://issuetracker.google.com/281831288>

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 .../bindings/interrupt-controller/arm,gic-v3.yaml           | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.yaml b/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.yaml
index 92117261e1e1..8c251caae537 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.yaml
@@ -166,6 +166,12 @@ properties:
   resets:
     maxItems: 1
 
+  mediatek,gicr-save-quirk:
+    type: boolean
+    description:
+      Asserts that the firmware on this device has issues saving and restoring
+      GICR registers when CPUs are powered off.
+
 dependencies:
   mbi-ranges: [ msi-controller ]
   msi-controller: [ mbi-ranges ]
-- 
2.40.1.606.ga4b1b128d6-goog

