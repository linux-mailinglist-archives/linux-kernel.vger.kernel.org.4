Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 249D16DF24F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 12:56:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbjDLK4O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 06:56:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjDLK4M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 06:56:12 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D89E06A7D
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 03:56:09 -0700 (PDT)
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33C8pegq006573;
        Wed, 12 Apr 2023 12:55:57 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=selector1;
 bh=xBkM+wcHkn0+wAwRzFfs1U5GhFDjurk++GN6bVOC3Og=;
 b=hYYb7Puy4Sd9NST1T9rTluYjt9fkZUkBdjbAMEmsqWe/MDXGCbMfVDuJS4e578xRxD4z
 ICgTiNV5snAnd0j27ibk4LmwxfIJRKi+2f05ICcT+8ZDOdWYPZLj7SV9v69QZwP6kzeF
 1w5wd8CuiIOg+r+SDEstNkcobsyRmC1hz8qDuhSWbtJoYRM7ErFp8F4BAWLGfGdPztv2
 /UjEHRk2ZaAE4k+eZp9W8vFKk7vQbbaxSbitUmZJjGrtKHE3NnwcMAoPB3lrIAfRzPZZ
 VVHbU1qyscEeQrVI7rlTLoY7Go7PAOAs871h/6LBQWJTdv7qKOs+6+boBUoyDVCPX7ta 5w== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3pwsgp91ra-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Apr 2023 12:55:57 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 40FC9100034;
        Wed, 12 Apr 2023 12:55:57 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 3AF0D2128D0;
        Wed, 12 Apr 2023 12:55:57 +0200 (CEST)
Received: from localhost (10.252.10.182) by SHFDAG1NODE3.st.com (10.75.129.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Wed, 12 Apr
 2023 12:55:57 +0200
From:   Amelie Delaunay <amelie.delaunay@foss.st.com>
To:     Lee Jones <lee.jones@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
CC:     <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Amelie Delaunay <amelie.delaunay@foss.st.com>
Subject: [RESEND PATCH 1/2] mfd: stmfx: Fix error path in stmfx_chip_init
Date:   Wed, 12 Apr 2023 12:55:41 +0200
Message-ID: <20230412105542.1231131-2-amelie.delaunay@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230412105542.1231131-1-amelie.delaunay@foss.st.com>
References: <20230412105542.1231131-1-amelie.delaunay@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.252.10.182]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-12_03,2023-04-12_01,2023-02-09_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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

