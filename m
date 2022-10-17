Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A647B6012FC
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 17:51:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230339AbiJQPvA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 11:51:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbiJQPuu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 11:50:50 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1810966867
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 08:50:49 -0700 (PDT)
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29HEnXPi031465;
        Mon, 17 Oct 2022 17:50:43 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=selector1;
 bh=phlzu4FsLYCgo+33k55masOClxFOICgga//eKhVT5DA=;
 b=m0kBsPwO7CE8y2TIS764D0+CDjpFLbruiUt5BdWM/Y+5Qa6z8so8W7gWR8xiunow8D/2
 Ag3MKDsbAGZK/mY32jTN+NytkpII29vKQ6mQ5exp3vsgT/rkKIMLluW571BGiBb8N+cs
 6jcYfXL3toxjYhrwSxp85jYYJQJPaggP2Y1OfdRpBNSDsPZ5n0grj9yNfgYzK96TeQ9Y
 AeMZ1BN0gLKokbG3J3Odh5dbCZTQy/ayv1Z/SkTNTRLZX2vhALBbS77hM9Y94gaDlw62
 GMNuMEfZLEKwOJuaCg4Ndpi9p8IE5gl80CX3OLRPrsnMECb4LY8Qzh97z0r3H8hEbtop aQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3k7krjnsh8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Oct 2022 17:50:43 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id F230210002A;
        Mon, 17 Oct 2022 17:50:38 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id ED63723C6A0;
        Mon, 17 Oct 2022 17:50:38 +0200 (CEST)
Received: from localhost (10.75.127.120) by SHFDAG1NODE3.st.com (10.75.129.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2375.31; Mon, 17 Oct
 2022 17:50:38 +0200
From:   Patrick Delaunay <patrick.delaunay@foss.st.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
CC:     Patrick Delaunay <patrick.delaunay@foss.st.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
Subject: [PATCH v2 2/3] nvmem: stm32: add warning when upper OTPs are updated
Date:   Mon, 17 Oct 2022 17:49:56 +0200
Message-ID: <20221017174953.v2.2.Ifa806ff30d7c669ba9a3df9c6b64698a2dcc073a@changeid>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221017154957.277120-1-patrick.delaunay@foss.st.com>
References: <20221017154957.277120-1-patrick.delaunay@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.75.127.120]
X-ClientProxiedBy: GPXDAG2NODE4.st.com (10.75.127.68) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-17_13,2022-10-17_02,2022-06-22_01
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

(no changes since v1)

 drivers/nvmem/stm32-romem.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/nvmem/stm32-romem.c b/drivers/nvmem/stm32-romem.c
index d93baee01d7b..bb8aa72ba2f9 100644
--- a/drivers/nvmem/stm32-romem.c
+++ b/drivers/nvmem/stm32-romem.c
@@ -132,6 +132,9 @@ static int stm32_bsec_write(void *context, unsigned int offset, void *buf,
 		}
 	}
 
+	if (offset + bytes >= priv->lower * 4)
+		dev_warn(dev, "Update of upper OTPs with ECC protection (word programming, only once)\n");
+
 	return 0;
 }
 
-- 
2.25.1

