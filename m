Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CBA95F48BD
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 19:41:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229446AbiJDRlM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 13:41:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbiJDRkk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 13:40:40 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D55221E32;
        Tue,  4 Oct 2022 10:40:36 -0700 (PDT)
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 294GTKiJ011068;
        Tue, 4 Oct 2022 19:40:30 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=selector1;
 bh=giapiNY7TCRzpUo88U0f93okWpLLKpJ1FSwj1WrxUAs=;
 b=JJcGzU9SS/qMFd/uT0HTdhAuUsnp96CrnRib9NWFhe+aduh3mBv9yEpVbBzzrapNQnqX
 XOOgxAh3Ix269nuKYuqlOQOAwKkBA1NcwofP85BXMne6i5lIFK72tKQa9KLDN0h/JFe/
 8vypCt43d/csgUIuSlRUn85VcpSkbWaCV1CSnpMbzJXAXr6BzomEolF+SFOQJGYBh0Dk
 aEO44vBxUcm3KKS594xbiBgmYDz8zy82YpLXFUwUmh/MEYZ47YdDSVQvDubdZvuCo8ma
 /gZ4gJspqe9TxeZDNRJschL9fN3OLOuvVZ+Ct69L/+z1z8qt0IWEEtAC6nFBGOF8khBN Cg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3jxcw21qh2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 Oct 2022 19:40:30 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 7433610002A;
        Tue,  4 Oct 2022 19:40:24 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id E5BA825225C;
        Tue,  4 Oct 2022 19:40:24 +0200 (CEST)
Received: from localhost (10.75.127.117) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2375.31; Tue, 4 Oct
 2022 19:40:24 +0200
From:   Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
To:     Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh@kernel.org>
CC:     <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <arnaud.pouliquen@foss.st.com>
Subject: [PATCH] remoteproc: virtio: Fix warning on bindings by removing the of_match_table
Date:   Tue, 4 Oct 2022 19:40:18 +0200
Message-ID: <20221004174018.3319712-1-arnaud.pouliquen@foss.st.com>
X-Mailer: git-send-email 2.24.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.75.127.117]
X-ClientProxiedBy: GPXDAG2NODE4.st.com (10.75.127.68) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-04_08,2022-09-29_03,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The checkpatch tool complains that "virtio,rproc" is not documented.
But it is not possible to probe the device "rproc-virtio" by declaring
it in the device tree. So documenting it in the bindings does not make
sense.
This commit solves the checkpatch warning by suppressing the useless
of_match_table.

Fix-suggested-by: Rob Herring <robh@kernel.org>
Fixes: 1d7b61c06dc3 ("remoteproc: virtio: Create platform device for the remoteproc_virtio")

Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
---
 drivers/remoteproc/remoteproc_virtio.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/remoteproc/remoteproc_virtio.c b/drivers/remoteproc/remoteproc_virtio.c
index a29e3b8ff69c..26a7d8c498bc 100644
--- a/drivers/remoteproc/remoteproc_virtio.c
+++ b/drivers/remoteproc/remoteproc_virtio.c
@@ -593,17 +593,11 @@ static int rproc_virtio_remove(struct platform_device *pdev)
 }
 
 /* Platform driver */
-static const struct of_device_id rproc_virtio_match[] = {
-	{ .compatible = "virtio,rproc" },
-	{},
-};
-
 static struct platform_driver rproc_virtio_driver = {
 	.probe		= rproc_virtio_probe,
 	.remove		= rproc_virtio_remove,
 	.driver		= {
 		.name	= "rproc-virtio",
-		.of_match_table	= rproc_virtio_match,
 	},
 };
 builtin_platform_driver(rproc_virtio_driver);
-- 
2.24.3

