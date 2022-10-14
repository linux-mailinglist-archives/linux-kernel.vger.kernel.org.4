Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65E5C5FF0C5
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 17:05:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229485AbiJNPFf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 11:05:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229824AbiJNPFb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 11:05:31 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84881A3AAB
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 08:05:29 -0700 (PDT)
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29EF5CUm031283;
        Fri, 14 Oct 2022 17:05:16 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=selector1;
 bh=wRlyGKw6VgdQ2d1sRB7WsBi1jFMUKA9qlH7Ogi8UJ3Q=;
 b=SZ3hTvda1/8mgXWADaxQc5uP+6m6EJSUGbwxAVUNdADrYqx97d75pK101tdOl5VJqH7M
 xeesK61F6zcZczXV1+Vfv+IysappYKZh54mMdnAUCVpnl0UHvr4fTiP4PQsQDmErhjSD
 FY3PXltu0Vgf2mPioCh9I88Ce8ZBm4Ba1J7ssZjfp8IeBGvnJzsIsNQAR+ISAfybjrSX
 7j8oqipLlWInnojuDGd8M0fmRfU0nQ2UJj9QNa7dxc2krpP7fvNVpDQmugzP/JFj0Psy
 za9EIKOZMfQAxal7+K3yLRcsh3BL4425OrSi2ypNNoH5vmwsx0uQZmOZo0ai9yOq6Ie5 uQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3k64m7xbpe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Oct 2022 17:05:16 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 292EA100038;
        Fri, 14 Oct 2022 17:05:13 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 23FC0233C75;
        Fri, 14 Oct 2022 17:05:13 +0200 (CEST)
Received: from localhost (10.75.127.50) by SHFDAG1NODE3.st.com (10.75.129.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2375.31; Fri, 14 Oct
 2022 17:05:10 +0200
From:   Patrick Delaunay <patrick.delaunay@foss.st.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
CC:     Patrick Delaunay <patrick.delaunay@foss.st.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
Subject: [PATCH 1/2] nvmem: stm32: add warning when upper OTPs are updated
Date:   Fri, 14 Oct 2022 17:04:28 +0200
Message-ID: <20221014170426.1.Ifa806ff30d7c669ba9a3df9c6b64698a2dcc073a@changeid>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.75.127.50]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SHFDAG1NODE3.st.com
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

As the upper OTPs are ECC protected, they support only one 32 bits word
programming.
For a second modification of this word, these ECC become invalid and
this OTP will be no more accessible, the shadowed value is invalid.

This patch adds a warning to indicate an upper OTP update, because this
operation is dangerous as OTP is not locked by the driver after the first
update to avoid a second update.

Signed-off-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
---

 drivers/nvmem/stm32-romem.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/nvmem/stm32-romem.c b/drivers/nvmem/stm32-romem.c
index 354be526897f..e3c3c333b5d1 100644
--- a/drivers/nvmem/stm32-romem.c
+++ b/drivers/nvmem/stm32-romem.c
@@ -133,6 +133,9 @@ static int stm32_bsec_write(void *context, unsigned int offset, void *buf,
 		}
 	}
 
+	if (offset + bytes >= priv->lower * 4)
+		dev_warn(dev, "Update of upper OTPs with ECC protection (word programming, only once)\n");
+
 	return 0;
 }
 
-- 
2.25.1

