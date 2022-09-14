Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB2FA5B8547
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 11:40:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbiINJkn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 05:40:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbiINJkE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 05:40:04 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EF741ADBE;
        Wed, 14 Sep 2022 02:39:50 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 28E9deER073476;
        Wed, 14 Sep 2022 04:39:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1663148380;
        bh=irLXL59E4mT6LrYt3YZ8LsCgwANIbUY0MO6/Z2yRp4M=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=DCZ6b7CvUAnKL/gymxoPBepTdO7zKaw+RUZGUvlOKvHCmc2f0bwXTmS8MmL/ANZTy
         +N7gzF1GXfsCztfLXz180wNrDRrRaiakgmabDMlCkRD6wWABsdqB5kQeRxlL8rYBl7
         /bcd9G9omH5692uhH93hdPfzhbKPM7NhZxGl76ws=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 28E9de4P014867
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 14 Sep 2022 04:39:40 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Wed, 14
 Sep 2022 04:39:40 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Wed, 14 Sep 2022 04:39:40 -0500
Received: from uda0492258.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 28E9dBHI111966;
        Wed, 14 Sep 2022 04:39:36 -0500
From:   Siddharth Vadapalli <s-vadapalli@ti.com>
To:     <robh+dt@kernel.org>, <lee.jones@linaro.org>,
        <krzysztof.kozlowski@linaro.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <kishon@ti.com>,
        <vkoul@kernel.org>, <dan.carpenter@oracle.com>,
        <grygorii.strashko@ti.com>, <rogerq@kernel.org>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-phy@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>, <sjakhade@cadence.com>,
        <s-vadapalli@ti.com>
Subject: [PATCH 5/6] phy: ti: phy-j721e-wiz: Add SGMII support in wiz driver for J721E
Date:   Wed, 14 Sep 2022 15:09:10 +0530
Message-ID: <20220914093911.187764-6-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220914093911.187764-1-s-vadapalli@ti.com>
References: <20220914093911.187764-1-s-vadapalli@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable full rate divider configuration support for J721E_WIZ_16G for
SGMII.

Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---
 drivers/phy/ti/phy-j721e-wiz.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/phy/ti/phy-j721e-wiz.c b/drivers/phy/ti/phy-j721e-wiz.c
index 20af142580ad..9a33aebdcbe5 100644
--- a/drivers/phy/ti/phy-j721e-wiz.c
+++ b/drivers/phy/ti/phy-j721e-wiz.c
@@ -1191,6 +1191,7 @@ static int wiz_phy_fullrt_div(struct wiz *wiz, int lane)
 			return regmap_field_write(wiz->p0_fullrt_div[lane], 0x1);
 		break;
 	case J721E_WIZ_10G:
+	case J721E_WIZ_16G:
 	case J7200_WIZ_10G:
 		if (wiz->lane_phy_type[lane] == PHY_TYPE_SGMII)
 			return regmap_field_write(wiz->p0_fullrt_div[lane], 0x2);
-- 
2.25.1

