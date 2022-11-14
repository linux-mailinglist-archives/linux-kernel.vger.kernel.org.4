Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 271EB6289C9
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 20:49:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236679AbiKNTtr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 14:49:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237427AbiKNTt2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 14:49:28 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39CE52649D;
        Mon, 14 Nov 2022 11:48:53 -0800 (PST)
Received: from Falcon9.mtl.collabora.ca (mtl.collabora.ca [66.171.169.34])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: detlev)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 57386660296B;
        Mon, 14 Nov 2022 19:48:51 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1668455332;
        bh=MLIKw1v4Jq1PCDVbOsMzfRiH8Kzx3kjxryEHcmtLcEw=;
        h=From:To:Cc:Subject:Date:From;
        b=c5GsRd8KXYuQQNtE2igjr0XnkGwB18MKCBgXckogVDELeZVgtWZxjxfLGUQyFhWNg
         nt1RJu+QEqZyyIR4Z08K3pLtoIECvEF0aBM1JNExwpqXjWftublznK2bRvpJOnyHEl
         kDan6Dvn+OXlEzTyCD9sR2E+oETAprRmYdTZBbQIZLk89ihE+oiEqWQLs7b+wI3XjH
         r2haG2iWpDJQkxB2cBs9RbN7nesmV0+b2JYl4av4JGr+F44xOg1dyfv/q4s5yb0KUA
         lTsI09n4xASEssP2uvdA2i+SK++GzxZ5UldmFmr5TAZLi6oBIb08/Uboaz0u2MwiCR
         8F871c4IsJoGA==
From:   Detlev Casanova <detlev.casanova@collabora.com>
To:     linux-kernel@vger.kernel.org
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-renesas-soc@vger.kernel.org (open list:ARM/RENESAS ARCHITECTURE),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        Detlev Casanova <detlev.casanova@collabora.com>
Subject: [PATCH] arm64: dts: renesas: r8a77951: Add reserved memory region
Date:   Mon, 14 Nov 2022 14:48:46 -0500
Message-Id: <20221114194846.108814-1-detlev.casanova@collabora.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 0x3000000 bytes memory region starting at 0x54000000 is
reserved for the lossy_decompression hardware that will try to
decompress any data written in the region.

Mark the region as no-map to prevent linux from using it as RAM.

Signed-off-by: Detlev Casanova <detlev.casanova@collabora.com>
---
 arch/arm64/boot/dts/renesas/r8a77951.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a77951.dtsi b/arch/arm64/boot/dts/renesas/r8a77951.dtsi
index 07c8763c1e77..171833d91313 100644
--- a/arch/arm64/boot/dts/renesas/r8a77951.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a77951.dtsi
@@ -290,6 +290,18 @@ CPU_SLEEP_1: cpu-sleep-1 {
 		};
 	};
 
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		/* device specific region for Lossy Decompression */
+		lossy_decompress: memory-region@54000000 {
+			no-map;
+			reg = <0x00000000 0x54000000 0x0 0x03000000>;
+		};
+	};
+
 	extal_clk: extal {
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
-- 
2.38.1

