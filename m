Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9832E5FF0C6
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 17:05:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229827AbiJNPFj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 11:05:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbiJNPFc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 11:05:32 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98A8CAD9B4
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 08:05:30 -0700 (PDT)
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29EF5CGh032239;
        Fri, 14 Oct 2022 17:05:16 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=selector1;
 bh=npw86qUeqP5mhoB1P4qfCWCWdob8jPDQT+PZIr9f+XE=;
 b=CqImZdRarYObvR0YIp+8/zEXErxeB8EkV1hexKoOtCWqAeQUUgiPtSvBmaPlHmBfSLwa
 9u5GvY8aYB5O6ovoTNpk+ju/7QnJkiTfJkxPlAfW3AdDM6lrAyVW77M4VvABoRWh0Hn4
 ybhS6JxHU62uy3GQ2Mwz8H46gjc+WpEgHdW+ed1CmLDYnkzXAHBLB1/rRKQMBbmvx0Rw
 FQfnoHrGXWWCdevSJ9hfBpdzCblchvJ75qeD478IcrwzrcKesyfwYz5IZfe6FBY6aHUf
 zody0QCtQKhhtMTKDDngne7ccZw0warGYg1gljPRTKPgcTSsOK5XnPZoiULHvrf1aU85 gw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3k75sd9w8v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Oct 2022 17:05:16 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id AC3A6100034;
        Fri, 14 Oct 2022 17:05:12 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id A2945233C74;
        Fri, 14 Oct 2022 17:05:12 +0200 (CEST)
Received: from localhost (10.75.127.122) by SHFDAG1NODE3.st.com (10.75.129.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2375.31; Fri, 14 Oct
 2022 17:05:11 +0200
From:   Patrick Delaunay <patrick.delaunay@foss.st.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
CC:     Patrick Delaunay <patrick.delaunay@foss.st.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
Subject: [PATCH 2/2] nvmem: stm32: add nvmem type attribute
Date:   Fri, 14 Oct 2022 17:04:29 +0200
Message-ID: <20221014170426.2.Iaff264d5b87f54b7c5fe3a408b4d1662d1fdfd2a@changeid>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221014170426.1.Ifa806ff30d7c669ba9a3df9c6b64698a2dcc073a@changeid>
References: <20221014170426.1.Ifa806ff30d7c669ba9a3df9c6b64698a2dcc073a@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.75.127.122]
X-ClientProxiedBy: GPXDAG2NODE4.st.com (10.75.127.68) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-14_08,2022-10-14_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Inform NVMEM framework of type attribute for stm32-romem as NVMEM_TYPE_OTP
so userspace is able to know how the data is stored in BSEC.

Signed-off-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
---

 drivers/nvmem/stm32-romem.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvmem/stm32-romem.c b/drivers/nvmem/stm32-romem.c
index e3c3c333b5d1..7b3a5a5a64b0 100644
--- a/drivers/nvmem/stm32-romem.c
+++ b/drivers/nvmem/stm32-romem.c
@@ -161,6 +161,7 @@ static int stm32_romem_probe(struct platform_device *pdev)
 	priv->cfg.dev = dev;
 	priv->cfg.priv = priv;
 	priv->cfg.owner = THIS_MODULE;
+	priv->cfg.type = NVMEM_TYPE_OTP;
 
 	cfg = (const struct stm32_romem_cfg *)
 		of_match_device(dev->driver->of_match_table, dev)->data;
-- 
2.25.1

