Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C11C870B8F0
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 11:30:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232210AbjEVJaT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 05:30:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231409AbjEVJaN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 05:30:13 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 581779D;
        Mon, 22 May 2023 02:30:11 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (unknown [IPv6:2001:b07:2ed:14ed:a962:cd4d:a84:1eab])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id E658166058F2;
        Mon, 22 May 2023 10:30:08 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1684747809;
        bh=8THYe79i65UdHa2AS5CAUyFodTMPPnYlaLqy/e9sDbY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AcDyWd4R9EBwLOnEZezjmVfSgRSLA2+plkuc7SNL0Bwl1urZ2d/QO4tAiqHYNfkLk
         iWuIB8mOVV7oO7hL0X66aiRBP97hM9uJSmjGQCFnewMqIS2+M2ACKrhWfqihUvnEkB
         6wH5W1HglBuqxomb3ajCfrNo4HwQ5H5sQVX65uudy0qXV2J8vTAeu3M+sisYN3+Um8
         DEDrv28AVCs14mRDrMU8iopM7v6618t+wMYUjytO9D/f1n+5NwxhtP8PRb2Qwm5pDB
         MpkAWXhzbM/RDLyRRppMqfhGoTkKD1NFX3IUYL4fLhfD5J/dJu7eY6dpTZet5dxnQG
         thtJRIMst2x0g==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     matthias.bgg@gmail.com
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, weiyi.lu@mediatek.com, ikjn@chromium.org,
        chun-jie.chen@mediatek.com, tinghan.shen@mediatek.com,
        seiya.wang@mediatek.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, kernel@collabora.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH 1/2] arm64: dts: mediatek: mt8192: Make sure MSDCPLL's rate is 400MHz
Date:   Mon, 22 May 2023 11:30:01 +0200
Message-Id: <20230522093002.75137-2-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230522093002.75137-1-angelogioacchino.delregno@collabora.com>
References: <20230522093002.75137-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some bootloaders will set MSDCPLL's rate lower than 400MHz: what I have
seen is this clock being set at around 384MHz.
This is a performance concern (and possibly a stability one, for picky
eMMC/SD cards) as the MSDC controller's internal divier will choose a
frequency that is lower than expected, in the end causing a difference
in the expected mmc/sd device's timings.

Make sure that the MSDCPLL frequency is always set to 400MHz to both
improve performance and reliability of the sd/mmc storage.

Fixes: 5d2b897bc6f5 ("arm64: dts: mediatek: Add mt8192 clock controllers")
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 arch/arm64/boot/dts/mediatek/mt8192.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8192.dtsi b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
index 5c30caf74026..6fc14004f6fd 100644
--- a/arch/arm64/boot/dts/mediatek/mt8192.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
@@ -677,6 +677,8 @@ apmixedsys: syscon@1000c000 {
 			compatible = "mediatek,mt8192-apmixedsys", "syscon";
 			reg = <0 0x1000c000 0 0x1000>;
 			#clock-cells = <1>;
+			assigned-clocks = <&apmixedsys CLK_APMIXED_MSDCPLL>;
+			assigned-clock-rates = <400000000>;
 		};
 
 		systimer: timer@10017000 {
-- 
2.40.1

