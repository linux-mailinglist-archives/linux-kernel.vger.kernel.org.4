Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB0206FFC8B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 00:08:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239468AbjEKWHj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 18:07:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239185AbjEKWH3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 18:07:29 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7366E8A54
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 15:07:27 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-52cb78647ecso5348695a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 15:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1683842847; x=1686434847;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K+dvOm04w8PPu/rImCk8a3YHkXAbeV87AIPZhDPscPw=;
        b=hssIu15bC0KSO0j4n4UiTUSK1g1EmW3565jzwwoTqGY6zacsfwczA5MEV+3WEIgL51
         FaOLFcYy4qZNQX5hyMTUAZC8ss2jKpC9yFQP3B0jicwEflxxCKpWdWKbuC6pxB1ydPks
         q1YL08QBU2trw5ls56AwM/YC2p94uMB+870ko=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683842847; x=1686434847;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K+dvOm04w8PPu/rImCk8a3YHkXAbeV87AIPZhDPscPw=;
        b=kIKwVqqOIlFoQC1y2pfhyO5V9QbkTE8nn5WesXKgr1lVuZy82EsZxAr0sWRo9FMdHF
         3SA+7f2tlrZbphL8rcyyvT4YI6PVN9jrBov+d0LZZJc09KckjcvwDffxw7AWOgBeEGM6
         VWo9dLDJMU1PA/4KjIriUXPaDkJdnVCD6bKSuc5gZLxe9dYgH86szE3xnPjEQUU6hFy+
         8ISZQY416p4dcf9R8hZhxwrz2E8n6fg4nCbX5A+Ne3ndGhi31y5OJNbQAPqkRW4si+Z8
         SC/m23htRM/R7xbCQfObeQPDiRUf4/HAyTElYWjR+Ua4p4ntb5MuEHTbFgcuSbsjxSGn
         0E6g==
X-Gm-Message-State: AC+VfDzPoAmYVJDe/KaZTncJax76AufEQZSgavVOo8BKvNiVE9FVmTbQ
        oZObtAG0hoRVvwzA3Vh8o4t5hw==
X-Google-Smtp-Source: ACHHUZ41RE00te4Ijen+NU2VZLSRZZeq3ieV/CReVKY7S7BpZdh+5eIYWsjWa5jYSCS63ssl+OjuTQ==
X-Received: by 2002:a17:90b:1804:b0:24e:39d2:ab80 with SMTP id lw4-20020a17090b180400b0024e39d2ab80mr22819969pjb.4.1683842846799;
        Thu, 11 May 2023 15:07:26 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:b96a:d776:ee3:e572])
        by smtp.gmail.com with ESMTPSA id h24-20020a17090a9c1800b00247735d1463sm17589457pjp.39.2023.05.11.15.07.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 15:07:25 -0700 (PDT)
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
Subject: [PATCH 4/6] arm64: dts: mediatek: mt8186: Add mediatek,gicr-save-quirk
Date:   Thu, 11 May 2023 15:05:38 -0700
Message-ID: <20230511150539.4.Iaa0ee05cf0362540fda50dd6a0d87ee35dccd88b@changeid>
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

Firmware shipped on mt8186 Chromebooks is affected by the GICR
save/restore issue as described by the patch ("dt-bindings:
interrupt-controller: arm,gic-v3: Add quirk for Mediatek SoCs w/
broken FW"). Add the quirk property.

Fixes: 2e78620b1350 ("arm64: dts: Add MediaTek MT8186 dts and evaluation board and Makefile")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 arch/arm64/boot/dts/mediatek/mt8186.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8186.dtsi b/arch/arm64/boot/dts/mediatek/mt8186.dtsi
index 5e83d4e9efa4..09fbd8f9ea52 100644
--- a/arch/arm64/boot/dts/mediatek/mt8186.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8186.dtsi
@@ -336,6 +336,7 @@ gic: interrupt-controller@c000000 {
 			reg = <0 0x0c000000 0 0x40000>,
 			      <0 0x0c040000 0 0x200000>;
 			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH 0>;
+			mediatek,gicr-save-quirk;
 
 			ppi-partitions {
 				ppi_cluster0: interrupt-partition-0 {
-- 
2.40.1.606.ga4b1b128d6-goog

