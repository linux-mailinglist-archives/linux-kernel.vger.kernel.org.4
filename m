Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48E8368B306
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 01:11:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbjBFALq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Feb 2023 19:11:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjBFALo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Feb 2023 19:11:44 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1602199FD;
        Sun,  5 Feb 2023 16:11:43 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id h3so1121603wrp.10;
        Sun, 05 Feb 2023 16:11:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wAbf+uUh8IDhx4P5btdQs6JXwhMK6EMsAdafpHykSig=;
        b=hqdZOfsXvr3HFzzq+ifhJGaW6E30t/fBH4rx5B2HHJq48dxHVp6ZXJhKfZ1ZN0f1/d
         3ovY90IS5GAFg8rnvkXruCjZkMtybQhCgRVkPcDdtVN8HYsdIBxP+CXMwCMSoZ3QPgdN
         L1C6CMjn5ZsYX/Zpq67aGFFPo1dEvmOjM+gBsftkE4t1sMWqlslH2uZD86RSKbS26ISa
         8brBW90nxyuLBaOMrKxB57KpE9D7am3E0iht3CPjY1F0KCAgNvvEP3iSIFCKH6Na2T52
         G2NOHL31lYEoXMsKHUmFB0FFd75NXoXhEIqVeEUrXDCeFvTfKkaSMGV3UJVxLbh4BT34
         B+eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wAbf+uUh8IDhx4P5btdQs6JXwhMK6EMsAdafpHykSig=;
        b=d7aVbdOq+mpv0bpki2jCL0x6vX/GcpQY9NhsUe8Fi8XwOP+geUpyEOc+qtMMqaNCMc
         XrZvYs0ED8mcI0+g6hFs0L5KztbyS9Non6R1U3fIn9KrAXAN0E3LDmmxRFP4BGzb63Ku
         saICoXNQCEqANi+0oj/Grov3vEFUIX1Zty6FBbgtscUhwir1/uW3CwTJZRWjZohAO60Z
         ZLSHW5UQJfw4x4pDBGPyoO63ShbCsERBgxbLLQG9JmGDlW01MjZIBQb9W5DGp0uuNP7F
         X+YeboZULZfJmbKm2bCTNVYs/IqluX57OHDMO2e/1Q8NY8iVeIiCTs4g9phzFcz03k52
         5zZQ==
X-Gm-Message-State: AO0yUKXVw/yPVh/RaRvqpuCCVZxl1E10xa7XJukQS5h5qIvFK1maHu7F
        /s5mtcJP4g18BKmhy+aI7u1tQSgEw4XhlQ==
X-Google-Smtp-Source: AK7set9EwtA/3dUxOfIHAijqcL24vr09/N1bNDsVbF1CL4pqr6JFbbAJ+dzmJjjcRfwsyEjlaS2wSA==
X-Received: by 2002:adf:e6c9:0:b0:2c3:e938:d29b with SMTP id y9-20020adfe6c9000000b002c3e938d29bmr2135139wrm.54.1675642302353;
        Sun, 05 Feb 2023 16:11:42 -0800 (PST)
Received: from prasmi.home ([2a00:23c8:2501:c701:ad64:1263:d26a:39ae])
        by smtp.gmail.com with ESMTPSA id j6-20020adfb306000000b002c3d29d83d2sm7015959wrd.63.2023.02.05.16.11.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Feb 2023 16:11:41 -0800 (PST)
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
Subject: [PATCH v2] arm64: dts: renesas: r9a07g043u: Add Cortex-A55 PMU node
Date:   Mon,  6 Feb 2023 00:11:33 +0000
Message-Id: <20230206001133.28776-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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
v1 -> v2
* Fixed interrupt type
---
 arch/arm64/boot/dts/renesas/r9a07g043u.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a07g043u.dtsi b/arch/arm64/boot/dts/renesas/r9a07g043u.dtsi
index 9d854706ada5..1c9d3193e4ff 100644
--- a/arch/arm64/boot/dts/renesas/r9a07g043u.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a07g043u.dtsi
@@ -35,6 +35,11 @@ L3_CA55: cache-controller-0 {
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

