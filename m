Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 542C76D32B1
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Apr 2023 18:57:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229976AbjDAQ5o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Apr 2023 12:57:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjDAQ5m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Apr 2023 12:57:42 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05B671D2C6;
        Sat,  1 Apr 2023 09:57:41 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 331DoJbc009781;
        Sat, 1 Apr 2023 16:57:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=/J7nB6tRhFWnlakZKY5xt/+LvOcnxSh8PjWBMVdUn9k=;
 b=EwjWgQovOl9vsJ8Y2D11UKY7lVPhxhhmHCd1Ih6mv8ZhAViN0Tw216T5fwGIKkYG9p5g
 W3UTRTWU73Ld5m2QpVzqUC/9CRf+qdFwCZycm6g4yYbTdPd9mB/Y7FiNUNt4gIz3+Aa1
 yVjwSSa0gxZKSbkDVDTvBuSyg/bf3SHfWYBbx+Y5dU1Xd+LrZoSuySUfVLA8easgBwaN
 RxFNJe+KqA1AqiEIT2kG+8tdphkkEHwNqiotJHgNrGyVTHgrSSWrIIJbuHEZQXQRXXgC
 iForCv8gGRYfdsypbXwI1ad04gfxaJCewiQ7D+K6LZhIICf/9xKqt2hLHjEbqHQukl5K aw== 
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ppcq3h2e4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 01 Apr 2023 16:57:36 +0000
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 331GvXiu006703;
        Sat, 1 Apr 2023 16:57:33 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3ppdpk2ueb-1;
        Sat, 01 Apr 2023 16:57:33 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 331GvXoD006697;
        Sat, 1 Apr 2023 16:57:33 GMT
Received: from hu-maiyas-hyd.qualcomm.com (hu-sartgarg-hyd.qualcomm.com [10.213.105.147])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 331GvXOi006693;
        Sat, 01 Apr 2023 16:57:33 +0000
Received: by hu-maiyas-hyd.qualcomm.com (Postfix, from userid 2339771)
        id 59D2F504928; Sat,  1 Apr 2023 22:27:32 +0530 (+0530)
From:   Sarthak Garg <quic_sartgarg@quicinc.com>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, quic_rampraka@quicinc.com,
        quic_bhaskarv@quicinc.com, quic_sachgupt@quicinc.com,
        quic_pragalla@quicinc.com, quic_sayalil@quicinc.com,
        Sarthak Garg <quic_sartgarg@quicinc.com>,
        Brian Norris <briannorris@chromium.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH V1 1/2] mmc: core: Define new vendor ops to enable internal features
Date:   Sat,  1 Apr 2023 22:27:22 +0530
Message-Id: <20230401165723.19762-2-quic_sartgarg@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230401165723.19762-1-quic_sartgarg@quicinc.com>
References: <20230401165723.19762-1-quic_sartgarg@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: OZciZy35ebSXZTpC_PNebCEcRxk1vUW_
X-Proofpoint-ORIG-GUID: OZciZy35ebSXZTpC_PNebCEcRxk1vUW_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-31_07,2023-03-31_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 lowpriorityscore=0 phishscore=0 impostorscore=0 suspectscore=0 spamscore=0
 bulkscore=0 mlxlogscore=723 adultscore=0 clxscore=1011 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304010154
X-Spam-Status: No, score=0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Define new ops to let vendor enable internal features in
mmc_suspend/resume paths like partial init feature.

Signed-off-by: Sarthak Garg <quic_sartgarg@quicinc.com>
---
 drivers/mmc/core/mmc.c   | 13 ++++++++++---
 include/linux/mmc/host.h |  4 ++++
 2 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 89cd48fcec79..32386e4644df 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -2112,9 +2112,11 @@ static int _mmc_suspend(struct mmc_host *host, bool is_suspend)
 	    ((host->caps2 & MMC_CAP2_FULL_PWR_CYCLE) || !is_suspend ||
 	     (host->caps2 & MMC_CAP2_FULL_PWR_CYCLE_IN_SUSPEND)))
 		err = mmc_poweroff_notify(host->card, notify_type);
-	else if (mmc_can_sleep(host->card))
+	else if (mmc_can_sleep(host->card)) {
+		if (host->ops->cache_card_properties)
+			host->ops->cache_card_properties(host);
 		err = mmc_sleep(host);
-	else if (!mmc_host_is_spi(host))
+	} else if (!mmc_host_is_spi(host))
 		err = mmc_deselect_cards(host);
 
 	if (!err) {
@@ -2149,6 +2151,7 @@ static int mmc_suspend(struct mmc_host *host)
 static int _mmc_resume(struct mmc_host *host)
 {
 	int err = 0;
+	bool partial_init_success = false;
 
 	mmc_claim_host(host);
 
@@ -2156,7 +2159,11 @@ static int _mmc_resume(struct mmc_host *host)
 		goto out;
 
 	mmc_power_up(host, host->card->ocr);
-	err = mmc_init_card(host, host->card->ocr, host->card);
+
+	if (host->ops->partial_init_card)
+		partial_init_success = host->ops->partial_init_card(host);
+	if (!partial_init_success)
+		err = mmc_init_card(host, host->card->ocr, host->card);
 	mmc_card_clr_suspended(host->card);
 
 out:
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 461d1543893b..0a796a34b83d 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -212,6 +212,10 @@ struct mmc_host_ops {
 
 	/* Initialize an SD express card, mandatory for MMC_CAP2_SD_EXP. */
 	int	(*init_sd_express)(struct mmc_host *host, struct mmc_ios *ios);
+
+	void	(*cache_card_properties)(struct mmc_host *host);
+	bool	(*partial_init_card)(struct mmc_host *host);
+
 };
 
 struct mmc_cqe_ops {
-- 
2.17.1

