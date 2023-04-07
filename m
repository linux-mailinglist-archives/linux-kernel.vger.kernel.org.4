Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F5E66DAAFD
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 11:35:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240698AbjDGJfL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 05:35:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240590AbjDGJef (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 05:34:35 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E52A72B6
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 02:34:34 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id r29so41827490wra.13
        for <linux-kernel@vger.kernel.org>; Fri, 07 Apr 2023 02:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112; t=1680860073; x=1683452073;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ty5wIc3Z81+kG82VSRnC8Apz5DxLYwgxvYQ6Q3KABLA=;
        b=tGurBQVuQ7y9plBgUeZloAz5GvkNiKOghaNxx/zgC4n9qgmf/dYpOv/I1JpDD7BAYm
         lD/0lDBqanGaFQctbOZnMkGXYeWdo2xX4SxSrY67cB0+aIEyvhmxN+M9zyHEanwotGOG
         HQq8w/lm6GHLYxROo9Vskj/9MZeCzS8DbKoaIkAmJL2wHIOVgQ80jHUhe4WJO1V5XQ9L
         jSxS1uvBzzsIaWb0JQnG/RvfWOLeJxeNq9BYFxzas5tknG5RslJOSFbgfAq0Mx3CrIoh
         M67aOk60Bt7VsO8EzPpf0Ltc9SQ/E8WITG/2UsmQMX6ZtgyB+d5A5y7iSf2XDPOQp5dY
         TxJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680860073; x=1683452073;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ty5wIc3Z81+kG82VSRnC8Apz5DxLYwgxvYQ6Q3KABLA=;
        b=5ngvn1W8PfbW3mibjBz/5SkGF0r3ko4fx65hmZqGV+Z/XaCRO28JVDbXCSyr3EnN4L
         cobDlE+2FahsjZ7VNiBXayY1oGLRjQl0R6/t1aO8MUQ22FNCxLktpqsEAEKhokI+j3D/
         oV63pRRyxFeLfS5BCkIsZ65ifWRMpb3Luu/x46L9rFelKT/m0R4HJGqFLlHZ1TsP6h1I
         gNtRKacBEsiUOS0SKBEPCiTnvcWHMmWsTaIibvtuSvqw+qjN5wRV6Mnt4eFDMyNvXkxK
         xFXhTIaAtzRpisUHAIjRrdbWI9Ofx+2kPqxdhRO8KUtsS6SInioQUQd4efMY9S/MdROn
         6Eig==
X-Gm-Message-State: AAQBX9e3pDEEsMPkuEguKuvgL+/sCIhTnmpHmXvG1YfndChvXcbygnIr
        Tb/S16ocb6VZGkYQrb8VFu/SbBCxq4tU0kgzaYg=
X-Google-Smtp-Source: AKy350ZCxukRPbiYxfQSW8vlwe9x8x2sFSg0sdY5cneYe0HCrfwmHA6Q4RTnYxKfkajPgrsZn6ufjQ==
X-Received: by 2002:adf:db8e:0:b0:2d4:a843:d000 with SMTP id u14-20020adfdb8e000000b002d4a843d000mr857999wri.56.1680860073602;
        Fri, 07 Apr 2023 02:34:33 -0700 (PDT)
Received: from [127.0.1.1] (158.22.5.93.rev.sfr.net. [93.5.22.158])
        by smtp.googlemail.com with ESMTPSA id s13-20020a5d510d000000b002d64fcb362dsm4020432wrt.111.2023.04.07.02.34.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Apr 2023 02:34:33 -0700 (PDT)
From:   Alexandre Mergnat <amergnat@baylibre.com>
Date:   Fri, 07 Apr 2023 11:34:18 +0200
Subject: [PATCH v3 7/7] arm64: dts: mediatek: add iommu support for mt8365
 SoC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230207-iommu-support-v3-7-97e19ad4e85d@baylibre.com>
References: <20230207-iommu-support-v3-0-97e19ad4e85d@baylibre.com>
In-Reply-To: <20230207-iommu-support-v3-0-97e19ad4e85d@baylibre.com>
To:     Yong Wu <yong.wu@mediatek.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Alexandre Mergnat <amergnat@baylibre.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1094; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=DnJEBHRsbqHL6qyjSRQDzaDxfH+izMrFh6xvaojG8T4=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBkL+Ohg0L1C33TWbvz3zKaLZwmTsLFe1MkCtyZMLpe
 Ti6X3s+JAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCZC/joQAKCRArRkmdfjHURZN1D/
 9aluz//LTMCYnheiQnLj++jXjk9/55KstgFzy9l/ZWVHcvv8qQgM37m3sxH+YQNW6PJHEUlYzA/75K
 dTUyKBiuWeqMB4BOwQo562DAf1kNBKsF5JcYN4fB0pjA4o5n4m+vzcZKAmtE81cPCrWO+Z680f7rod
 BLI9n/dMaWMSLeII7jmm2Npbe5D8hwifuSO9AUR06joR9hoGb/cDy1eOoehhAj5IPJk0P248cYB1Ri
 o+ThpClfOsU7f22gCusbilqxsw2AXhtW0OnUsfycFnXlzX5Z5EFCzIMJq3AzoUSTZcwD/0umfLMn5Z
 0IfscdgMC/LtaEU5lHtjnj3b0nut0f43D++w9tUJJ/Np3HF9L/OIzb4kDE0HYBo1HNAAFiQHXRZIqf
 3meLX+WJEi+cz8PgFkhmaFS47aAwoe/VlD4BQ3c4Q0O6nuctY/EYQVecHMbtGa6asRpdpSWV6td/15
 FpfUITZap/juI5/Ll13V5MSfEbyH7+iE6qeeQo+GPdatetwyfuEoyQr4yV/tyUVDul0N/PtpwgrdKn
 FznOxUto/U6TBCeK9lh2DHw177IOmvD1ChDGCh4XpHDVUfNlnf5JF/tQ0t5bX295u22eNxSsZWEEQW
 jDnOWlcyNfLFUjdW3Wud9AwSiji2/arQFTmDrfqUDHwUhnVKbm+7MzULNntA==
X-Developer-Key: i=amergnat@baylibre.com; a=openpgp;
 fpr=231B5ED7F3EAAA700E60FE8B2B46499D7E31D445
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add iommu support in the SoC DTS using the 4 local arbiters (LARBs)

Reviewed-by: Yong Wu <yong.wu@mediatek.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
---
 arch/arm64/boot/dts/mediatek/mt8365.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8365.dtsi b/arch/arm64/boot/dts/mediatek/mt8365.dtsi
index 07a7267f338e..6260744f4be5 100644
--- a/arch/arm64/boot/dts/mediatek/mt8365.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8365.dtsi
@@ -456,6 +456,14 @@ sysirq: interrupt-controller@10200a80 {
 			reg = <0 0x10200a80 0 0x20>;
 		};
 
+		iommu: iommu@10205000 {
+			compatible = "mediatek,mt8365-m4u";
+			reg = <0 0x10205000 0 0x1000>;
+			interrupts = <GIC_SPI 102 IRQ_TYPE_LEVEL_LOW>;
+			mediatek,larbs = <&larb0>, <&larb1>, <&larb2>, <&larb3>;
+			#iommu-cells = <1>;
+		};
+
 		infracfg_nao: infracfg@1020e000 {
 			compatible = "mediatek,mt8365-infracfg", "syscon";
 			reg = <0 0x1020e000 0 0x1000>;

-- 
2.25.1

