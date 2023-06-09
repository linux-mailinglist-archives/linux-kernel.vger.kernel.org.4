Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9E1F729556
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 11:34:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241647AbjFIJeR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 05:34:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241464AbjFIJdw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 05:33:52 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B6FC421D
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 02:28:49 -0700 (PDT)
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3599C3aW016809;
        Fri, 9 Jun 2023 11:28:15 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=selector1;
 bh=uRvepPfLBwDEe6cjr6Uk7xCGy1ySmdjO/0fLcxMhkcc=;
 b=FOeK+xuHGS5cOI5dZSFhowwmrC6qXXCj8AZDVzWVKXwqGOIStqKOoqbe8UAqlX+dBgc/
 RbGRqF8xlJulDlSr7aGpccJUYMEDXb0mV9VrHLASk6bRegc2k3noW/4SgrWWINTH5kVL
 wq7XwJCXps6XX9PiTCeRvhOj+2znBH46/tNosKjLnyfd31j6BNJwgz7nEL+QTNj97AAr
 oP6RTriSTQ1HI6EtT8uul1po54Oq34ZV04f4l9IoqpIIacvMfC0gZzSuRaNKFX39lUlZ
 TyX2ZnEJP9Pdx7t9I+PEXpwbjvoSENiGS7/33RQNtcSFwwEraERXUgycIw6eazRoMR4a 6Q== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3r4187g3tk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 09 Jun 2023 11:28:15 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 2B76D10003B;
        Fri,  9 Jun 2023 11:28:15 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 23D11210F8B;
        Fri,  9 Jun 2023 11:28:15 +0200 (CEST)
Received: from localhost (10.252.12.6) by SHFDAG1NODE3.st.com (10.75.129.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Fri, 9 Jun
 2023 11:28:14 +0200
From:   Amelie Delaunay <amelie.delaunay@foss.st.com>
To:     Lee Jones <lee@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Amelie Delaunay <amelie.delaunay@st.com>
CC:     Amelie Delaunay <amelie.delaunay@foss.st.com>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [RESEND PATCH 2/2] mfd: stmfx: Nullify stmfx->vdd in case of error
Date:   Fri, 9 Jun 2023 11:28:04 +0200
Message-ID: <20230609092804.793100-2-amelie.delaunay@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230609092804.793100-1-amelie.delaunay@foss.st.com>
References: <20230609092804.793100-1-amelie.delaunay@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.252.12.6]
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-09_06,2023-06-08_01,2023-05-22_02
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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
index 54cc902cb578..c02cbd9c2f5d 100644
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

