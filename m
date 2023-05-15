Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F4D9703E5F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 22:16:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245263AbjEOUQP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 16:16:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243149AbjEOUQJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 16:16:09 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6FD1C1
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 13:16:08 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-6436e075166so9907734b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 13:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684181768; x=1686773768;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q+xclHRJbfTaOco3ogcoYlZx1POsGrbKOC60b7YSguU=;
        b=g36wlx4dAT/5M/at1hKyNtZto26zWfKQwhNbIbrF+H00O03nyEY6BiCUtUDqrcdMbq
         e7fz+6QIIokAKhGcCOG2WqzT4Luc93tGNTu737dq9vjufkb3y1jzvHWHWkE0QjekmU7p
         lApebxoBnaqlPNm5AlNHXeaQIEHLeKk+EJKHo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684181768; x=1686773768;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q+xclHRJbfTaOco3ogcoYlZx1POsGrbKOC60b7YSguU=;
        b=Xzp/Q4KatNEK/9Ni7WvcJXzCCVfyuQe4wGBBmEgzm1pJxW0CeiwYuJsnWWLLa3WiwA
         Cxyn35m9mGNdezAJfoXvq4vjHF7vfmPDjZNpVna276GPR+oIRBzSYkvmM1/4QVx7tLPj
         aW5mjydkw2gbJGEs+gtUjoz3hMp0EybvVFcUfhzrcEXfsJXyKJxoKWIoFuIV/a7iZhFj
         E25pVXMJJf7UI9TXtKk04aNmU+BTBMrYYt7ZR437tjYCyisx/dFozRZ2c50espj1koYu
         FsUrtaWaqX4B6UI2lhbhr+buqXsPjOwekoUeJHcfjEVpiHXXY6Omycz7wNetdvcDm2ab
         2sAg==
X-Gm-Message-State: AC+VfDzF/65iHkKpiOVEbJ02LliSrayk3IkPrlKiefJpR6bW+O+5RnXr
        KDv4eXX1P672DFQZXlx8nsUhrg==
X-Google-Smtp-Source: ACHHUZ5WhKqgoMTuex1L+d9MK/DlTrH0o+Ldk/9GGkvVe2VsoV5lyk+s+Rn1dX3B0wpYq4ALaKdvAA==
X-Received: by 2002:a05:6a00:10d3:b0:63b:5496:7afa with SMTP id d19-20020a056a0010d300b0063b54967afamr41742520pfu.11.1684181768187;
        Mon, 15 May 2023 13:16:08 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:9f33:9d98:277a:d4cd])
        by smtp.gmail.com with ESMTPSA id a19-20020a62bd13000000b0063f0c9eadc7sm7981411pff.200.2023.05.15.13.16.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 May 2023 13:16:07 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
        linux-mediatek@lists.infradead.org,
        Eddie Huang <eddie.huang@mediatek.com>,
        Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, wenst@chromium.org,
        yidilin@chromium.org, Tinghan Shen <tinghan.shen@mediatek.com>,
        jwerner@chromium.org, Weiyi Lu <weiyi.lu@mediatek.com>,
        Ben Ho <Ben.Ho@mediatek.com>,
        Seiya Wang <seiya.wang@mediatek.com>,
        Douglas Anderson <dianders@chromium.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/5] dt-bindings: interrupt-controller: arm,gic-v3: Add quirk for Mediatek SoCs w/ broken FW
Date:   Mon, 15 May 2023 13:13:50 -0700
Message-ID: <20230515131353.v2.1.Iabe67a827e206496efec6beb5616d5a3b99c1e65@changeid>
X-Mailer: git-send-email 2.40.1.606.ga4b1b128d6-goog
In-Reply-To: <20230515131353.v2.cover@dianders>
References: <20230515131353.v2.cover@dianders>
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
  'mediatek,broken-save-restore-fw' property. The kernel can use this
  to know not to enable certain features like "pseudo NMI". NOTE:
  device trees for Chromebooks are never baked into the firmware but
  are bundled with the kernel. A kernel will never be configured to
  use "pseudo NMIs" and be bundled with an old device tree.
* When we get a fixed firmware for one of these Chromebooks, it will
  patch the device tree to remove this property.

For some details, you can also see the public bug
<https://issuetracker.google.com/281831288>

Reviewed-by: Julius Werner <jwerner@chromium.org>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v2:
- "when CPUs are powered" => "when the GIC redistributors are..."
- mediatek,gicr-save-quirk => mediatek,broken-save-restore-fw

 .../bindings/interrupt-controller/arm,gic-v3.yaml           | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.yaml b/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.yaml
index 92117261e1e1..39e64c7f6360 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.yaml
@@ -166,6 +166,12 @@ properties:
   resets:
     maxItems: 1
 
+  mediatek,broken-save-restore-fw:
+    type: boolean
+    description:
+      Asserts that the firmware on this device has issues saving and restoring
+      GICR registers when the GIC redistributors are powered off.
+
 dependencies:
   mbi-ranges: [ msi-controller ]
   msi-controller: [ mbi-ranges ]
-- 
2.40.1.606.ga4b1b128d6-goog

