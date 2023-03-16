Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5A516BD656
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 17:54:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231321AbjCPQyU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 12:54:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbjCPQyQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 12:54:16 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE344B0B9E
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 09:54:13 -0700 (PDT)
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32GCMrts018637;
        Thu, 16 Mar 2023 17:53:57 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=selector1;
 bh=xBkM+wcHkn0+wAwRzFfs1U5GhFDjurk++GN6bVOC3Og=;
 b=XvDoo3cSem2rJP2ZZdblTx5Zmu6cku9C4Zv7kzdEVCTQqCldnRmgz3L06aeqwUXj6jIT
 SyMP55y0aWaa8I9zXNC6dpl2SEPUm7SdYxgk5hKQ7eA9lXs30rJfWyxIFfAYjS+BCWzT
 quB57Qy5tB/4f5tMo5A0uDS8mdXIDn+BeR2MPY7jPqUoPUG4izK2H239AaZSzyjKS6oG
 W904l2HNCjpLPoW8H/mmisUn9MGdUSEMlggX/1RcMhE6DR9PzIP88JW/SDeB1tC4Ai8O
 J5HBk3qAEe8rJOX12EcvmLyU5mgPt0b5pFGxCCnHXK1A9dOVsMk3fTuLkmncXgW3G+AN SA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3pbpwp604d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Mar 2023 17:53:56 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 31A90100034;
        Thu, 16 Mar 2023 17:53:56 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 2C3FA21ED52;
        Thu, 16 Mar 2023 17:53:56 +0100 (CET)
Received: from localhost (10.201.20.208) by SHFDAG1NODE3.st.com (10.75.129.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.17; Thu, 16 Mar
 2023 17:53:55 +0100
From:   Amelie Delaunay <amelie.delaunay@foss.st.com>
To:     Lee Jones <lee.jones@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
CC:     <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Amelie Delaunay <amelie.delaunay@foss.st.com>
Subject: [PATCH 1/2] mfd: stmfx: Fix error path in stmfx_chip_init
Date:   Thu, 16 Mar 2023 17:53:46 +0100
Message-ID: <20230316165347.2669038-2-amelie.delaunay@foss.st.com>
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

In error path, disable vdd regulator if it exists, but don't overload ret.
Because if regulator_disable() is successful, stmfx_chip_init will exit
successfully while chip init failed.

Fixes: 06252ade9156 ("mfd: Add ST Multi-Function eXpander (STMFX) core driver")
Signed-off-by: Amelie Delaunay <amelie.delaunay@foss.st.com>
---
 drivers/mfd/stmfx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/stmfx.c b/drivers/mfd/stmfx.c
index e281971ba54e..bfe89df27611 100644
--- a/drivers/mfd/stmfx.c
+++ b/drivers/mfd/stmfx.c
@@ -387,7 +387,7 @@ static int stmfx_chip_init(struct i2c_client *client)
 
 err:
 	if (stmfx->vdd)
-		return regulator_disable(stmfx->vdd);
+		regulator_disable(stmfx->vdd);
 
 	return ret;
 }
-- 
2.25.1

