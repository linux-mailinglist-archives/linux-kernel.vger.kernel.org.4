Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A18668B309
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 01:13:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229559AbjBFANR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Feb 2023 19:13:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjBFANP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Feb 2023 19:13:15 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FEE61816E;
        Sun,  5 Feb 2023 16:13:14 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id m16-20020a05600c3b1000b003dc4050c94aso7597809wms.4;
        Sun, 05 Feb 2023 16:13:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FacqhinIE3cYzcHWL+sIHtqTA2GbL6NIBfMucLlCGic=;
        b=Knf06s8pt8mbdxTpfNvgXKole3+l5jv7IwBSWfA0bGadXS1L+aeX0qDjyvzKoYIEY+
         2w96V8sVec2Yk+Txg3X8Dzc3ANKzcau4/mwNqhPq2j7hi9NiD1Dt2522tj8BleQJeo32
         lWtZ4FXHH6MSqAeuzVHtgVaHQsdi5X8WZk0h4xO00zScVi/1+tvoLkJZsNtZMaiQbqP0
         PXOQfCBdLhefTGcZ+mTrA7mCGjSh59wrgX07uprGVUPMtd7dHowqY5Z8/8C55AG03UNG
         TZfIHcwxW4+rtzYevyGXi7FB+n3Kz+Uac4oIe6O9UqhnyNydb+z/Vl8AgxhboUEP056G
         0hNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FacqhinIE3cYzcHWL+sIHtqTA2GbL6NIBfMucLlCGic=;
        b=pdyiV6SxQAdK100AGYM8sZfvGKygjiiDuz8l/1+2hbDzNd6w14NVguVTvU2CfQm6m/
         CUyrs68Lb3E23JzEjxMYHqVGNBXcngTFKCH7KrgdPprijG8vDCPdKe127qtIMquv0pYU
         bX1TGpdSkGvLz/kZx4wlX5RxXwd7DZtV+N7OycLSqMAYAZ3G9q34ZuphD3KXjeu/oOc6
         KCjPIvTEsNYB2iQtStVPkebGzNsqmzqLb5G1M0G1iJ+1dsCtgLgyVet8bmuqu/RyVIuL
         oQeepw2WIiBRzMXuJj+yv/lKekvv8ZmKo/P+k2uoTNRjOx8xVw8Tc38D11JKGJuVudFg
         HZ+Q==
X-Gm-Message-State: AO0yUKUPO75GS/MQ4L2wUl+8Ur1LWulZpGm23nkxZCzFmEkMjyraQITy
        H83IaVU4RUZAAQ9FlEfvrBY=
X-Google-Smtp-Source: AK7set/5apFyhhx9Ky/PaYsJhuRV0Sm5j0nwp0xTR6YKGWciD3apNFq27D+biSlLgIiTqgSFUMUSuQ==
X-Received: by 2002:a05:600c:1c1c:b0:3df:9858:c02f with SMTP id j28-20020a05600c1c1c00b003df9858c02fmr10080938wms.4.1675642393251;
        Sun, 05 Feb 2023 16:13:13 -0800 (PST)
Received: from prasmi.home ([2a00:23c8:2501:c701:ad64:1263:d26a:39ae])
        by smtp.gmail.com with ESMTPSA id v9-20020a05600c470900b003dfe549da4fsm9508994wmo.18.2023.02.05.16.13.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Feb 2023 16:13:12 -0800 (PST)
From:   Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v2] arm64: dts: renesas: r9a07g044: Add Cortex-A55 PMU node
Date:   Mon,  6 Feb 2023 00:13:00 +0000
Message-Id: <20230206001300.28937-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
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

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Enable the performance monitor unit for the Cortex-A55 cores on the
RZ/G2L (r9a07g044) SoC.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
v1->v2
* Fixed interrupt type
---
 arch/arm64/boot/dts/renesas/r9a07g044.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a07g044.dtsi b/arch/arm64/boot/dts/renesas/r9a07g044.dtsi
index 80b2332798d9..2c848aad7aea 100644
--- a/arch/arm64/boot/dts/renesas/r9a07g044.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a07g044.dtsi
@@ -161,6 +161,11 @@ opp-50000000 {
 		};
 	};
 
+	pmu {
+		compatible = "arm,cortex-a55-pmu";
+		interrupts-extended = <&gic GIC_PPI 7 IRQ_TYPE_LEVEL_LOW>;
+	};
+
 	psci {
 		compatible = "arm,psci-1.0", "arm,psci-0.2";
 		method = "smc";
-- 
2.25.1

