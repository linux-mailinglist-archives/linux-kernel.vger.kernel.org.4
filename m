Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D91E962D76E
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 10:49:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234819AbiKQJtc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 04:49:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230344AbiKQJt3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 04:49:29 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C19BB877;
        Thu, 17 Nov 2022 01:49:28 -0800 (PST)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AH935J3001073;
        Thu, 17 Nov 2022 09:49:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id; s=qcppdkim1;
 bh=mXyp3kuz6+raj/Kj/BPH6q/i8EriXCANwM6ExVdaBaY=;
 b=eC1sBSIAa4z0dgRUSgCpnx+p5g4R277LLYvaw1SMqJpOxDMK0gb9wQGK378zCE2HSlBq
 wYI/tnV9m6dZmL1epc+yN3/Xt7xguHWAD7wlz8PFNl7KNeaUm77ZdFe7m6+xJcX+LfqE
 mveOL4KBNemPwIP900G9l9fMM754oV6XmqJ26EC34cpae0SyqhQPLsO7AwVd2wlKAh+G
 NkcafyIhdRRhXEFFQ8jdj0r2phRZ2fLQGhYEcAKxg5flS55Gl31tmCt36ALJdbV35yvq
 ZA8JzAHjwdctVtK9cqwzdnSt5VBBpbyKpBw94+1Q/TxoECFc616fpBg+qJQF0HEQuUCf cw== 
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3kwfcb0hc4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Nov 2022 09:49:17 +0000
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 2AH9nCJ3014247;
        Thu, 17 Nov 2022 09:49:12 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 3kt4jm2fk8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 17 Nov 2022 09:49:12 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2AH9nCG9014241;
        Thu, 17 Nov 2022 09:49:12 GMT
Received: from hu-maiyas-hyd.qualcomm.com (hu-sartgarg-hyd.qualcomm.com [10.213.105.147])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 2AH9nC8w014240;
        Thu, 17 Nov 2022 09:49:12 +0000
Received: by hu-maiyas-hyd.qualcomm.com (Postfix, from userid 2339771)
        id 8A9495001D8; Thu, 17 Nov 2022 15:19:11 +0530 (+0530)
From:   Sarthak Garg <quic_sartgarg@quicinc.com>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, quic_rampraka@quicinc.com,
        quic_pragalla@quicinc.com, quic_sayalil@quicinc.com,
        Sarthak Garg <quic_sartgarg@quicinc.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shaik Sajida Bhanu <quic_c_sbhanu@quicinc.com>
Subject: [PATCH V1] mmc: core: Wait for 1ms after enabling the clocks post voltage switch
Date:   Thu, 17 Nov 2022 15:18:48 +0530
Message-Id: <20221117094859.20582-1-quic_sartgarg@quicinc.com>
X-Mailer: git-send-email 2.17.1
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: E8iSzsCjZO6PhuCyrhhC2LzKyzTpc9z0
X-Proofpoint-GUID: E8iSzsCjZO6PhuCyrhhC2LzKyzTpc9z0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-17_06,2022-11-16_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 bulkscore=0
 mlxscore=0 lowpriorityscore=0 adultscore=0 priorityscore=1501
 mlxlogscore=999 impostorscore=0 spamscore=0 malwarescore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211170075
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As per spec we should wait for 1ms after providing the SD clock to the
card again as part of voltage switch sequence but there seems to be a
violation here. Clocks are getting gated before 1ms as part of
sdhci_set_ios function where we try to reset SD Clock Enable by
resetting SDHCI_CLOCK_CARD_EN bit in SDHCI_CLOCK_CONTROL register
leading to voltage switch failures for specific SD cards.
Below ftraces also confirms the above understanding :

9.511367: mmc_host_set_uhs_voltage: mmc1 called
9.511369: mmc_set_ios: mmc1: clock 0Hz busmode 2 powermode 2 cs 0
Vdd 18 width 1 timing 0
9.511370: sdhci_set_ios: mmc1 called
9.511370: sdhci_set_ios: mmc1 setting clock ios->clock: 0 host->clock:
400000
9.511372: sdhci_msm_set_clock: mmc1 clock: 0
9.511394: sdhci_set_ios: mmc1 gating clocks by writing
~SDHCI_CLOCK_CARD_EN to SDHCI_CLOCK_CONTROL register
9.511413: sdhci_msm_set_clock: mmc1 clock: 0
9.511423: mmc_set_signal_voltage: mmc1 called
9.533816: mmc_set_ios: mmc1: clock 400000Hz busmode 2 powermode 2 cs 0
Vdd 18 width 1 timing 0
9.533820: sdhci_set_ios: mmc1 called
9.533822: sdhci_set_ios: mmc1 setting clock ios->clock: 400000
host->clock: 0
9.533826: sdhci_msm_set_clock: mmc1 clock: 400000
9.533925: sdhci_enable_clk: mmc1 Enabling clocks by writing
SDHCI_CLOCK_CARD_EN to SDHCI_CLOCK_CONTROL register
9.533950: sdhci_set_ios: mmc1 gating clocks by writing
~SDHCI_CLOCK_CARD_EN to SDHCI_CLOCK_CONTROL register
9.533973: sdhci_msm_set_clock: mmc1 clock: 400000
9.534043: sdhci_enable_clk: mmc1 Enabling clocks by writing
SDHCI_CLOCK_CARD_EN to SDHCI_CLOCK_CONTROL register
9.534045: mmc_host_set_uhs_voltage: mmc1 Done

Wait for 1ms after enabling the clock post voltage switch to make sure
clock is kept alive for alteast 1ms as per spec.

Signed-off-by: Sarthak Garg <quic_sartgarg@quicinc.com>
---
 drivers/mmc/core/core.c  | 4 ++++
 drivers/mmc/host/sdhci.c | 3 +++
 include/linux/mmc/host.h | 1 +
 3 files changed, 8 insertions(+)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index a1efda85c6f2..d63e00aab6cb 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -1181,6 +1181,8 @@ int mmc_host_set_uhs_voltage(struct mmc_host *host)
 	host->ios.clock = 0;
 	mmc_set_ios(host);
 
+	host->doing_signal_voltage_switch = true;
+
 	if (mmc_set_signal_voltage(host, MMC_SIGNAL_VOLTAGE_180))
 		return -EAGAIN;
 
@@ -1189,6 +1191,8 @@ int mmc_host_set_uhs_voltage(struct mmc_host *host)
 	host->ios.clock = clock;
 	mmc_set_ios(host);
 
+	host->doing_signal_voltage_switch = false;
+
 	return 0;
 }
 
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index fb6e9a81f198..ac7c254eef4b 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2312,6 +2312,9 @@ void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 		host->ops->set_clock(host, ios->clock);
 		host->clock = ios->clock;
 
+		if (mmc->doing_signal_voltage_switch)
+			usleep_range(1000, 1250);
+
 		if (host->quirks & SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK &&
 		    host->clock) {
 			host->timeout_clk = mmc->actual_clock ?
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 8fdd3cf971a3..06c88cd7a8bf 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -521,6 +521,7 @@ struct mmc_host {
 	bool			hsq_enabled;
 
 	u32			err_stats[MMC_ERR_MAX];
+	bool			doing_signal_voltage_switch;
 	unsigned long		private[] ____cacheline_aligned;
 };
 
-- 
2.17.1

