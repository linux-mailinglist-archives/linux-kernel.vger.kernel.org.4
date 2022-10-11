Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B10145FBE4B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 01:18:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbiJKXSc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 19:18:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbiJKXSR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 19:18:17 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B51A25D0;
        Tue, 11 Oct 2022 16:18:16 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 29BNHvla086163;
        Tue, 11 Oct 2022 18:17:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1665530277;
        bh=eC0aHb+aZRyM8fNayBdzRLZlJy26hLJ0809gZrd7XoE=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=Tga55FyEs9VNJ0OeIbXZRDN32ZU/3DPDndInmFPTynPbOi+9KLr3/T2kAsfRpHa2B
         QCxIKGY1zvkmXXeWVd+JH3e9eU7j7QrYsrUovjjb3bizCfJd5L0lGDhgH4EyRjsVfR
         8fiKBDTW/AGHoo47wh5CH3Jl8pThT5UvPhPSMQOA=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 29BNHv9k081663
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 11 Oct 2022 18:17:57 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Tue, 11
 Oct 2022 18:17:57 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Tue, 11 Oct 2022 18:17:57 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 29BNHvhe021888;
        Tue, 11 Oct 2022 18:17:57 -0500
From:   Bryan Brattlof <bb@ti.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>, Keerthy <j-keerthy@ti.com>,
        Linux Thermal <linux-pm@vger.kernel.org>,
        Linux Device Tree <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Bryan Brattlof <bb@ti.com>
Subject: [PATCH 01/11] thermal: k3_j72xx_bandgap: simplify k3_thermal_get_temp() function
Date:   Tue, 11 Oct 2022 18:17:17 -0500
Message-ID: <20221011231727.8090-2-bb@ti.com>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20221011231727.8090-1-bb@ti.com>
References: <20221011231727.8090-1-bb@ti.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1018; h=from:subject; bh=nybN46Oj7CyEzxnatV6GbN3i3ebMEiKJTdwL6AscGrY=; b=owNCWmg5MUFZJlNZeGrtwAAAa3///v///v966P7SZPTrfu463e3u6v/8/1uLSp29jv90q/8wARsY IeoGR6mQNNAAAGjQNDTQBoAAAPUAyNAAABoGgB6gD1AAPFMZTahsj1Q6DQNABoBpppoaaDQGmg9JmU DagNGQAPUGj1Mg0DI9RtT1NAaaAMgAeo9QaG1AAgNpGmmQ9IMmgNAGQYmQ0DQaMmg0BkxNDJhMmEYJ oxAaBoDQyaBoaABoZNAABEHNh+8SGTgqAwLmSBk6qeoo2t4uFs3NSB+YlIgDpic3oTn/tFx1JPsNUp fI3ERToBz7AEHJoTtalhvW3YrL495OHwLDr00OIXFAhdP8Kr5Fr/Og3WB479+O3vAHEd2Kg1nbVlCf haY8QcNtmlqNmQAxgWJu2DdicGkQASShe9F9tCayEZ1RvHz2rCz204bsqoR2RKsoR7Hc73zjXLkN54 HhKt2WxbUlkQhMcZEwdfpnqC4TMrXfZYOJOgvwdamnMQyVuJ9vLLdRRpHyPI1mCPoL/n1HK81MWipv 0VKzIcDlIRnZ3ZLFluBm2RN26bJismtTpLpnzn2iBtXP88wJD3XxgVXCopQsDmkCNrGRQTdAtUCoxc NNKmoQjy9rMe0GOPksT2AACVfagGsFpqYiXO0RE5AXXNtggGiMGaBX/i7kinChIPDV24A=
X-Developer-Key: i=bb@ti.com; a=openpgp; fpr=D3D177E40A38DF4D1853FEEF41B90D5D71D56CE0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The k3_thermal_get_temp() function can be simplified to return only
the result of k3_bgp_read_temp() without needing the 'ret' variable

Signed-off-by: Bryan Brattlof <bb@ti.com>
---
 drivers/thermal/k3_j72xx_bandgap.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/thermal/k3_j72xx_bandgap.c b/drivers/thermal/k3_j72xx_bandgap.c
index c073b1023bbe7..a9f99a190cb61 100644
--- a/drivers/thermal/k3_j72xx_bandgap.c
+++ b/drivers/thermal/k3_j72xx_bandgap.c
@@ -249,14 +249,7 @@ static inline int k3_bgp_read_temp(struct k3_thermal_data *devdata,
 /* Get temperature callback function for thermal zone */
 static int k3_thermal_get_temp(struct thermal_zone_device *tz, int *temp)
 {
-	struct k3_thermal_data *data = tz->devdata;
-	int ret = 0;
-
-	ret = k3_bgp_read_temp(data, temp);
-	if (ret)
-		return ret;
-
-	return ret;
+	return k3_bgp_read_temp(tz->devdata, temp);
 }
 
 static const struct thermal_zone_device_ops k3_of_thermal_ops = {
-- 
2.38.0

