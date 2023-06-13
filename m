Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84E1572E466
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 15:43:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242555AbjFMNmc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 09:42:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238289AbjFMNm3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 09:42:29 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C43010E9;
        Tue, 13 Jun 2023 06:42:28 -0700 (PDT)
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35DBOJRi009309;
        Tue, 13 Jun 2023 15:42:00 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=selector1;
 bh=1a+OE8g+HLElK2FOpBWytDVRk0d3UkmYF7USr1krSEY=;
 b=z+AF5Kqune0n0F6zrTtUiTaX9mFyk4bvhXviEkOIutaD3EpAkYDVHac3ZhF61ETXFwFs
 5UkHmEOpmeqrCFtKd9IDHkBzY9LvNihlSz1ip6HLseQjfdST5KTSK3OSfkB02AFGGfuo
 1/t0BNMNam6bApRpoDbaK8xQZ1qGo0DJzANZLDg6Jo2A+fPhHzl0P5ocn0Mgg88tm/2b
 zJ/MbS321CyFBkeQf+jisCrULWnbJ//RzefPMZ2sFK10OcqqCxer8mXdbyDnwIYLsYY2
 4TnAnISq8rpBIcOwJTjVN31IzwSGD7NMHOyGsfsNLrm4obA+sdT8iVyi9C9bcxgbSeHC /w== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3r6mrba8me-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Jun 2023 15:42:00 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 3F0AC10002A;
        Tue, 13 Jun 2023 15:41:52 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 38A82228A48;
        Tue, 13 Jun 2023 15:41:52 +0200 (CEST)
Received: from localhost (10.201.21.210) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Tue, 13 Jun
 2023 15:41:51 +0200
From:   Yann Gautier <yann.gautier@foss.st.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>, <linux-mmc@vger.kernel.org>
CC:     Russell King <linux@armlinux.org.uk>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Christophe Kerello <christophe.kerello@foss.st.com>,
        Rob Herring <robh@kernel.org>,
        Xiang wangx <wangxiang@cdjrlc.com>,
        Yang Yingliang <yangyingliang@huawei.com>,
        <linux-kernel@vger.kernel.org>, Marek Vasut <marex@denx.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Dennis Zhou <dennis@kernel.org>,
        Yann Gautier <yann.gautier@foss.st.com>
Subject: [PATCH] mmc: mmci: stm32: fix max busy timeout calculation
Date:   Tue, 13 Jun 2023 15:41:46 +0200
Message-ID: <20230613134146.418016-1-yann.gautier@foss.st.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.201.21.210]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-13_04,2023-06-12_02,2023-05-22_02
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christophe Kerello <christophe.kerello@foss.st.com>

The way that the timeout is currently calculated could lead to a u64
timeout value in mmci_start_command(). This value is then cast in a u32
register that leads to mmc erase failed issue with some SD cards.

Fixes: 8266c585f489 ("mmc: mmci: add hardware busy timeout feature")
Signed-off-by: Yann Gautier <yann.gautier@foss.st.com>
Signed-off-by: Christophe Kerello <christophe.kerello@foss.st.com>
---
 drivers/mmc/host/mmci.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index f2b2e8b0574e8..696cbef3ff7de 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -1735,7 +1735,8 @@ static void mmci_set_max_busy_timeout(struct mmc_host *mmc)
 		return;
 
 	if (host->variant->busy_timeout && mmc->actual_clock)
-		max_busy_timeout = ~0UL / (mmc->actual_clock / MSEC_PER_SEC);
+		max_busy_timeout = U32_MAX / DIV_ROUND_UP(mmc->actual_clock,
+							  MSEC_PER_SEC);
 
 	mmc->max_busy_timeout = max_busy_timeout;
 }
-- 
2.25.1

