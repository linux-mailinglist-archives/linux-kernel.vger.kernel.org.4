Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2064D63B444
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 22:33:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231451AbiK1Vd2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 16:33:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231252AbiK1VdZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 16:33:25 -0500
Received: from sender4-op-o14.zoho.com (sender4-op-o14.zoho.com [136.143.188.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FAE51CB37;
        Mon, 28 Nov 2022 13:33:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1669671187; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=R/S87fl94BFiPI5qMA2RIlbkHvMFcCzvqUxQQvPSUQ0EyE5C18479+pA97bx3FR8bX/f2PbCWK6t6m7yszAVPVaiMCZbWkQandLqayVVm+w0ri15afC5tKALkafUEamieCDaeB3PsborJgPjKP8yGYnxOYUIJsLO/0Is8QszHkk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1669671187; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:MIME-Version:Message-ID:Subject:To; 
        bh=QVXbcaj0HG2V69BRM9WHD2nb8nYMSoGDBdtG+KKs/r8=; 
        b=WiDE7CPPDeoy7lWxl26RSsiZ0sqWcePZWpUbxA/QSpv9AgHFxc0hSkvZGh3uDredoHLwxC6RV1b7qEnfY6/PDtuS6zzbGnmyLoh0xEs8fCVLq6cluVHT11sVKV/6iouYKGLlrL3bX6ovWBnQ1xqeOs54PPyzo8ox5dpn7d/3S1Q=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=arinc9.com;
        spf=pass  smtp.mailfrom=arinc.unal@arinc9.com;
        dmarc=pass header.from=<arinc.unal@arinc9.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1669671187;
        s=zmail; d=arinc9.com; i=arinc.unal@arinc9.com;
        h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:Reply-To;
        bh=QVXbcaj0HG2V69BRM9WHD2nb8nYMSoGDBdtG+KKs/r8=;
        b=W8DrlAuiZWEAivLGMb3xsjUYZfLC5DqzMnIodHeElRWu/ZzGOSOPFNDQnXH8B0aZ
        BP8zq50oJiG+HbBCO+bkkOU8xZAGSPdzaNY1OYYU+2oGkXXIZuxYco7GXrVPcEmmorN
        /ewPLsYcnHA0E36mVKAbuTv4+VB+YjYBKJ6lJMDo=
Received: from arinc9-Xeront.lan (37.120.152.236 [37.120.152.236]) by mx.zohomail.com
        with SMTPS id 1669671186041271.1969592308891; Mon, 28 Nov 2022 13:33:06 -0800 (PST)
From:   =?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>
To:     Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     linux-mips@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>,
        Petr Louda <petr.louda@outlook.cz>
Subject: [PATCH] mips: ralink: mt7621: fix phy-mode of external phy on GB-PC2
Date:   Tue, 29 Nov 2022 00:32:38 +0300
Message-Id: <20221128213238.3959-1-arinc.unal@arinc9.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The phy-mode property must be defined on the MAC instead of the PHY. Define
phy-mode under gmac1 which the external phy is connected to.

Tested-by: Petr Louda <petr.louda@outlook.cz>
Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
---
 arch/mips/boot/dts/ralink/mt7621-gnubee-gb-pc2.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/boot/dts/ralink/mt7621-gnubee-gb-pc2.dts b/arch/mips/boot/dts/ralink/mt7621-gnubee-gb-pc2.dts
index 7515555388ae..e31417569e09 100644
--- a/arch/mips/boot/dts/ralink/mt7621-gnubee-gb-pc2.dts
+++ b/arch/mips/boot/dts/ralink/mt7621-gnubee-gb-pc2.dts
@@ -113,13 +113,13 @@ &pcie {
 
 &gmac1 {
 	status = "okay";
+	phy-mode = "rgmii-rxid";
 	phy-handle = <&ethphy5>;
 };
 
 &mdio {
 	ethphy5: ethernet-phy@5 {
 		reg = <5>;
-		phy-mode = "rgmii-rxid";
 	};
 };
 
-- 
2.34.1

