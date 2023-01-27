Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63F3567ECA3
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 18:40:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234909AbjA0Rk3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 12:40:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234652AbjA0Rk1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 12:40:27 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D7ACF744;
        Fri, 27 Jan 2023 09:40:26 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id z5so5640958wrt.6;
        Fri, 27 Jan 2023 09:40:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IxxOyfVtW8TzSWM52t4kUJ1Vb5uyFnTZzRWxaUFRbEQ=;
        b=PDs00BCSd9asE5smLGc9CaTLWrnXatsMhBXf8u7vHIFSIDe0eJlND6aAgwb3/W3QYX
         M0CGIipPfw/jjK16nPvMzQyAYQ4iwLMe7lo+0GgG5USWJ6bWpxuYxD83H32q/jjL7fFb
         aX1Vyxgt6jZyEqpbS2051JCHuqqMokTkFyUO3JucbS1LVGNycYAsxaggFr1EuSf6nj3h
         N7uO0nmy9S9yHUGUZuhTs82jXPH7pB3O0AWOKmd356cTkRr6M9QhX5zZK74IMC08X+Vf
         NVulv32+uHAWohreOMhxGGYj/5zgdmwEaJiALoPmmg9Ci853t4OnnZLbQbdAbZxsn1FZ
         0dEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IxxOyfVtW8TzSWM52t4kUJ1Vb5uyFnTZzRWxaUFRbEQ=;
        b=oRnDwNijA7TtK2R+jef/Qz4Oyc7J/oRwu1PIT/HgpA5pTrUvBrgxYEWEiMYldvWW74
         H3Br1DaQgoPc/rhcfhGiF7xbyflbhgHl8xyPSPVTxDshN2BSWauud53s14JCEvz1cRku
         51lhEGr5wlPwu9NZ7xobVKtT1D1YX4Ps5mnGpz/xUfZmrY5rFRch0FrRSplAqXVOprJr
         oxqPopqW/WnmM5UT4zd2PX6Byhjewb+lXnTm/PVp6dIx4ozICzhWW1nsFGYvKFU/vsmX
         UbxJJLFpobf0HNAcMHrzJqdXmLaq2kjTaA3CXdCrgBlz6fTZVJZ6s+eY9WQvyZbxyhXf
         YKHw==
X-Gm-Message-State: AO0yUKWOLz4L+vc/rnWWQ9nQK0xdyXy6bRghLR3GIedQsxSbwDPh2h9K
        6ZGQfHgHoUzciooCl6r7fHk=
X-Google-Smtp-Source: AK7set8xHUi7tsJwsQaxaW7CJH8oH3gtHikA+OTh4lYdkqoFOi0F41HSY0mTO9pKtOm19v7cjIeOuw==
X-Received: by 2002:a05:6000:1f91:b0:2bf:d1a1:ff5d with SMTP id bw17-20020a0560001f9100b002bfd1a1ff5dmr2857509wrb.32.1674841225087;
        Fri, 27 Jan 2023 09:40:25 -0800 (PST)
Received: from prasmi.home ([2a00:23c8:2501:c701:ca6:cb06:c6e7:59f6])
        by smtp.gmail.com with ESMTPSA id r28-20020adfa15c000000b002bfd137ecddsm2574930wrr.11.2023.01.27.09.40.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 09:40:24 -0800 (PST)
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
Subject: [PATCH] arm64: dts: renesas: r9a07g044: Add Cortex-A55 PMU node
Date:   Fri, 27 Jan 2023 17:40:14 +0000
Message-Id: <20230127174014.251539-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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
 arch/arm64/boot/dts/renesas/r9a07g044.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a07g044.dtsi b/arch/arm64/boot/dts/renesas/r9a07g044.dtsi
index 80b2332798d9..ff9bdc03a3ed 100644
--- a/arch/arm64/boot/dts/renesas/r9a07g044.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a07g044.dtsi
@@ -161,6 +161,11 @@ opp-50000000 {
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

