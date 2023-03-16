Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C756D6BD657
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 17:54:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231343AbjCPQyX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 12:54:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbjCPQyQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 12:54:16 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE992B0BBD
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 09:54:14 -0700 (PDT)
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32GCLvl0025488;
        Thu, 16 Mar 2023 17:53:57 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=selector1;
 bh=A+lMTa0nB7HohOca8aARuO3o3kfnPHCwrPixYCAy+Cc=;
 b=jCalCzWEGgluzEpxxwmaELyiEdADSScn2RV6MlJVuNiwYfwne+RJr9Bwuja2e/E34WIX
 WgjqdD0IUeriFgIG54kLV5DiqK/1KKaI9WHsKMepoZNDpVD4IyfwPHsao89CcBUcWBO3
 bhADgaCpKgcbyr6RT/GpQqtxmYZ3keQEMQr6Fl4QvuGmw0viXAekvoM+jnNvMsPyetAy
 /j1Hs2G7Tar3yOQCzPbMRr5fJPyOC5Rcv6ZCj5VafNocRM9cwVTPk41mVSFzK9BVvOXf
 bjUh06RuR7yAjyuf93n/8QIai3hN1yGsNoTlPcqTYRNKeBfbBvABNemQ5n1C86wpB55w dQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3pbpwqwxtq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Mar 2023 17:53:57 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id E759710002A;
        Thu, 16 Mar 2023 17:53:56 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id E1F7221ED52;
        Thu, 16 Mar 2023 17:53:56 +0100 (CET)
Received: from localhost (10.201.20.208) by SHFDAG1NODE3.st.com (10.75.129.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.17; Thu, 16 Mar
 2023 17:53:56 +0100
From:   Amelie Delaunay <amelie.delaunay@foss.st.com>
To:     Lee Jones <lee.jones@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
CC:     <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Amelie Delaunay <amelie.delaunay@foss.st.com>
Subject: [PATCH 2/2] mfd: stmfx: Nullify stmfx->vdd in case of error
Date:   Thu, 16 Mar 2023 17:53:47 +0100
Message-ID: <20230316165347.2669038-3-amelie.delaunay@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230316165347.2669038-1-amelie.delaunay@foss.st.com>
References: <20230316165347.2669038-1-amelie.delaunay@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.201.20.208]
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-16_10,2023-03-16_01,2023-02-09_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nullify stmfx->vdd in case devm_regulator_get_optional() returns an error.
And simplify code by returning an error only if return code is not -ENODEV,
which means there is no vdd regulator and it is not an issue.

Fixes: d75846ed08e6 ("mfd: stmfx: Fix dev_err_probe() call in stmfx_chip_init()")
Signed-off-by: Amelie Delaunay <amelie.delaunay@foss.st.com>
---
 drivers/mfd/stmfx.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/mfd/stmfx.c b/drivers/mfd/stmfx.c
index bfe89df27611..76188212c66e 100644
--- a/drivers/mfd/stmfx.c
+++ b/drivers/mfd/stmfx.c
@@ -330,9 +330,8 @@ static int stmfx_chip_init(struct i2c_client *client)
 	stmfx->vdd = devm_regulator_get_optional(&client->dev, "vdd");
 	ret = PTR_ERR_OR_ZERO(stmfx->vdd);
 	if (ret) {
-		if (ret == -ENODEV)
-			stmfx->vdd = NULL;
-		else
+		stmfx->vdd = NULL;
+		if (ret != -ENODEV)
 			return dev_err_probe(&client->dev, ret, "Failed to get VDD regulator\n");
 	}
 
-- 
2.25.1

