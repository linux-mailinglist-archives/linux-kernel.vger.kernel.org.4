Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A00E970D8C2
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 11:19:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236334AbjEWJS5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 05:18:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236429AbjEWJPH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 05:15:07 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 249B7E6A;
        Tue, 23 May 2023 02:14:38 -0700 (PDT)
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34N8nKRU005346;
        Tue, 23 May 2023 11:14:17 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=selector1;
 bh=t/AFG2duLebengydODKmElakzYnHQVPdHkUYtcBP5eI=;
 b=sabo5+Qj8gv0PsnTFVNWmeCml2pfMTsIVdPhQj2oOAsu8EVmeFT9JMyZzNfCJt13htMl
 R0FcWQ5mcfd76unzm6L8IW2AxkI9pj+7u+t0IuZVZK2gTi6rP09WZIsZfvtpnVOFW6Ao
 5tttHJKrRHNeejVdBKxm7NLZIvuRoB/v2QyR6LdJzIoxTq7MItKEHoksy+kBK33NsXiY
 nNcggs7QwiW9oIvDpb5+LuyGed4SOspjKP0rYQ5XrYelXCIl1kL6PuTMRS2BXh+cGPqE
 vY2zLvuUsAVydKXMVxeHGQPFCLT0kAnj3dFQrcLZkFb+XNBAcIPWFgP+zPGXuREJtK5+ iQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3qpnj1gbqc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 May 2023 11:14:17 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id C649A100034;
        Tue, 23 May 2023 11:14:15 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id AC98C222CB8;
        Tue, 23 May 2023 11:14:15 +0200 (CEST)
Received: from localhost (10.252.31.43) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Tue, 23 May
 2023 11:14:15 +0200
From:   Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
To:     Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Jens Wiklander <jens.wiklander@linaro.org>
CC:     <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <op-tee@lists.trustedfirmware.org>,
        Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
Subject: [RFC PATCH 1/4] tee: Re-enable vmalloc page support for shared memory
Date:   Tue, 23 May 2023 11:13:47 +0200
Message-ID: <20230523091350.292221-2-arnaud.pouliquen@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230523091350.292221-1-arnaud.pouliquen@foss.st.com>
References: <20230523091350.292221-1-arnaud.pouliquen@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.252.31.43]
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-23_06,2023-05-22_03,2023-05-22_02
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch revert commit c83900393aa1 ("tee: Remove vmalloc page support")

The firmware framework uses vmalloc page to store an image of a firmware,
got from the file system.
To be able to give this firmware to OP-TEE without an extra copy,
the vmalloc page support needs to be reintroduce.

Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
---
 drivers/tee/tee_shm.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
index 673cf0359494..b2d349ac17b4 100644
--- a/drivers/tee/tee_shm.c
+++ b/drivers/tee/tee_shm.c
@@ -28,14 +28,26 @@ static int shm_get_kernel_pages(unsigned long start, size_t page_count,
 	struct page *page;
 	size_t n;
 
-	if (WARN_ON_ONCE(is_vmalloc_addr((void *)start) ||
-			 is_kmap_addr((void *)start)))
+	if (WARN_ON_ONCE(is_kmap_addr((void *)start)))
 		return -EINVAL;
 
-	page = virt_to_page((void *)start);
-	for (n = 0; n < page_count; n++) {
-		pages[n] = page + n;
-		get_page(pages[n]);
+	if (is_vmalloc_addr((void *)start)) {
+		struct page *page;
+
+		for (n = 0; n < page_count; n++) {
+			page = vmalloc_to_page((void *)(start + PAGE_SIZE * n));
+			if (!page)
+				return -ENOMEM;
+
+			get_page(page);
+			pages[n] = page;
+		}
+	}  else {
+		page = virt_to_page((void *)start);
+		for (n = 0; n < page_count; n++) {
+			pages[n] = page + n;
+			get_page(pages[n]);
+		}
 	}
 
 	return page_count;
-- 
2.25.1

