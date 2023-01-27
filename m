Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6D3967ECA6
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 18:40:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234250AbjA0Rkv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 12:40:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234652AbjA0Rkt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 12:40:49 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3712144AE;
        Fri, 27 Jan 2023 09:40:46 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id j17so4009507wms.0;
        Fri, 27 Jan 2023 09:40:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Jg+L/dIfQJFh+GZqzna4n3hn6tEkcnwoTmL4ftOct3A=;
        b=QKDK/2EAkfFV7TjWXY2jzGT7bDmYErlerJ8K/iLC/uQjxb5GfwZ9cVwSGKhyd/uGqo
         8xv1QRYmUo4fZFCamdbPkrDFLvsPBe1tLXmEi2j39rkJN1WUe2kYmNhsBzDxexe/svm1
         oU2hNZhxd13OjwsATjQwYfVd8gI9lXnQPJ+G/XNkPX0PKERHwd+27xhf0nOjU0HTppi1
         8AxhC0AZY5B3If8v82LF+WKKyf9Ldmsf20PRWZbne18z4U9Cq//LEEDfRrFZap3458dP
         KovG+OX+dsKzDDW/+Kx9+Am5/yVns1QpgXYHw/MMFeT9v3M4xPbH/CviRkOQZA4lcfzF
         xBQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Jg+L/dIfQJFh+GZqzna4n3hn6tEkcnwoTmL4ftOct3A=;
        b=pMlvM0duu913tSEVW4FT4RluITqz0zFDk5HXjFihntTVMb6R6a1b53LQ1F9fQT6oFH
         Mk6+Fvuji4H14ynq7XfNNac4mvCnUUPUplfkSvebbTAkLQPQz6TQeaW4nNCuBVYUePBJ
         ROz0fRFob0iJnDLMHrOyn2X+fg/uDUUREjxZkhcbpnTZTGrxGKCNIBq0B7lTgoPoQdl+
         ZXJ1LuC9oY18xIxPRSKZcbWMY2jCgMv34arNiWtZXbkwiRTnLK3V0h2ic9MSdTuK8aK8
         Mj0Hcbhb1S2N2cr3jU2zRQeCLOKDkIlNcimfqBwICdBheEnGJb4LeF/8QwHvGaQD61Fu
         uxZQ==
X-Gm-Message-State: AFqh2kqnmSCahdggwM+PvcXqvIQ0eiUFOPbsez+npOIf0Dih6LOmoqJu
        DsvF7TvS9RBCUOmNXtpoHxk=
X-Google-Smtp-Source: AMrXdXu8pMXsok/7sGNm3sDL+TZtGg3gGuk/CFqrUYqioTi2UFA/kPoVPW8QIzTqyzfZ1pti+TD9uA==
X-Received: by 2002:a05:600c:1d8e:b0:3d9:f9ef:3d23 with SMTP id p14-20020a05600c1d8e00b003d9f9ef3d23mr41538656wms.23.1674841245436;
        Fri, 27 Jan 2023 09:40:45 -0800 (PST)
Received: from prasmi.home ([2a00:23c8:2501:c701:ca6:cb06:c6e7:59f6])
        by smtp.gmail.com with ESMTPSA id f9-20020a05600c4e8900b003d990372dd5sm9812208wmq.20.2023.01.27.09.40.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 09:40:45 -0800 (PST)
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
Subject: [PATCH] arm64: dts: renesas: r9a07g043u: Add Cortex-A55 PMU node
Date:   Fri, 27 Jan 2023 17:40:40 +0000
Message-Id: <20230127174040.251642-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

Enable the performance monitor unit for the Cortex-A55 core on the
RZ/G2UL (r9a07g043u) SoC.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a07g043u.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a07g043u.dtsi b/arch/arm64/boot/dts/renesas/r9a07g043u.dtsi
index 9d854706ada5..33e562390646 100644
--- a/arch/arm64/boot/dts/renesas/r9a07g043u.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a07g043u.dtsi
@@ -35,6 +35,11 @@ L3_CA55: cache-controller-0 {
 		};
 	};
 
+	pmu_a55 {
+		compatible = "arm,cortex-a55-pmu";
+		interrupts-extended = <&gic GIC_PPI 7 IRQ_TYPE_LEVEL_HIGH>;
+	};
+
 	psci {
 		compatible = "arm,psci-1.0", "arm,psci-0.2";
 		method = "smc";
-- 
2.25.1

