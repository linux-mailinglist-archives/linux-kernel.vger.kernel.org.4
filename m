Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 629516FFC82
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 00:07:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238811AbjEKWHV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 18:07:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230028AbjEKWHT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 18:07:19 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCEBF6A4B
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 15:07:17 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1ab01bf474aso70692515ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 15:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1683842837; x=1686434837;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hpVJsmC3hyyCOV39d1XA4fZrHLIG7rwi+xqTsa1S20U=;
        b=apOp6wOIiyc0bM0pbLWmLbNrAH8nPimt13/Fe40g/kkmqv/jTh+cIfvOVS/TOb6lzI
         5tkY/eBXIzTBk4pnxTf0HCjbbXF0A3BUsNBN8s57G4ArflMx2Tgqmn4NmHKNBtXvfrtM
         Z2MuMp7hMMkWDAATMFaTy931zIfY4ioVVbcuk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683842837; x=1686434837;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hpVJsmC3hyyCOV39d1XA4fZrHLIG7rwi+xqTsa1S20U=;
        b=ljCr8yKo+8UdErBIO1QNSP9WKPJOD7hbq0bot/75cq/851NbdQ8j4Q+eNgcpCGv8nK
         zJEoBEqJehPYKgGTUyBDMqqmjnpLw9WcCM+kxRCMfAEjhCUBkznKijkXdUXDP4BiUPYX
         PtHgE4qVGPNogn2bGAJm87oMh9xU7jy8shWgxDWMy9DlCgKgOjg/h3KdKoCHr+8Xro3k
         BUawYsgDiWS9A2g+OhvdKj9XMWlnahuj2Zomcsh/+nVHCzeNr29T0y+QuT9nOEjycMuQ
         iKQBcTYHqf9qZwwuEOXhCfOhSi2H54lmCBqtXZel/h60AlsfMFKRUqPxBZqA0LnWv0/J
         t5KA==
X-Gm-Message-State: AC+VfDwsJMc74/fpCvX0YEKU+jvSytsFnUdys8RdagmHw/66JLWPXi4s
        3FXMfqVRbyudDmm5eLU5QHq6Yw==
X-Google-Smtp-Source: ACHHUZ7htthqYNJPkIn8G76ac+QLPwd63qP/ae8YFkTLrs+TGcxXUGw4ufIpDY5W75ZqdaFBfXVS3g==
X-Received: by 2002:a17:903:191:b0:1ac:aaf6:ee48 with SMTP id z17-20020a170903019100b001acaaf6ee48mr11781934plg.67.1683842837318;
        Thu, 11 May 2023 15:07:17 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:b96a:d776:ee3:e572])
        by smtp.gmail.com with ESMTPSA id h24-20020a17090a9c1800b00247735d1463sm17589457pjp.39.2023.05.11.15.07.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 15:07:16 -0700 (PDT)
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
Subject: [PATCH 0/6] irqchip/gic-v3: Disable pseudo NMIs on Mediatek Chromebooks w/ bad FW
Date:   Thu, 11 May 2023 15:05:34 -0700
Message-ID: <20230511150539.6.Ia0b6ebbaa351e3cd67e201355b9ae67783c7d718@changeid>
X-Mailer: git-send-email 2.40.1.606.ga4b1b128d6-goog
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

As talked about in the bindings patch included in this series
("dt-bindings: interrupt-controller: arm,gic-v3: Add quirk for
Mediatek SoCs w/ broken FW"), many Mediatek-based Chromebooks shipped
with firmware that doesn't properly save/restore some GICR
registers. This causes the system to crash if "pseudo NMIs" are turned
on.

This series makes sure that we never allow turning on "pseudo NMIs" if
we are running with the problematic firmware.

The patches in this series can land in any order and can go through
entirely different trees. None of the patches are harmful on their
own, but to get things fixed we need all of them.


Douglas Anderson (6):
  dt-bindings: interrupt-controller: arm,gic-v3: Add quirk for Mediatek
    SoCs w/ broken FW
  irqchip/gic-v3: Disable pseudo NMIs on Mediatek devices w/ firmware
    issues
  arm64: dts: mediatek: mt8183: Add mediatek,gicr-save-quirk
  arm64: dts: mediatek: mt8186: Add mediatek,gicr-save-quirk
  arm64: dts: mediatek: mt8192: Add mediatek,gicr-save-quirk
  arm64: dts: mediatek: mt8195: Add mediatek,gicr-save-quirk

 .../interrupt-controller/arm,gic-v3.yaml      |  6 ++++++
 arch/arm64/boot/dts/mediatek/mt8183.dtsi      |  1 +
 arch/arm64/boot/dts/mediatek/mt8186.dtsi      |  1 +
 arch/arm64/boot/dts/mediatek/mt8192.dtsi      |  1 +
 arch/arm64/boot/dts/mediatek/mt8195.dtsi      |  1 +
 drivers/irqchip/irq-gic-common.c              |  8 ++++++--
 drivers/irqchip/irq-gic-common.h              |  1 +
 drivers/irqchip/irq-gic-v3.c                  | 20 +++++++++++++++++++
 8 files changed, 37 insertions(+), 2 deletions(-)

-- 
2.40.1.606.ga4b1b128d6-goog

