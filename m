Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 781646D32B5
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Apr 2023 19:00:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229987AbjDARAd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Apr 2023 13:00:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjDARAb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Apr 2023 13:00:31 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C5809018;
        Sat,  1 Apr 2023 10:00:30 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 331GiHY9029723;
        Sat, 1 Apr 2023 16:57:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=kO0AaTsdO0F707hnDYDMtznkjiKFYiD5tu5F7PAj02o=;
 b=O2xIW4y5vN3Vz6uHur634oRVJiYhCcypS+6uPim0GU6z3s0i72KHBTbZLXJURKuoL1Lx
 N1zH+X1hRvv/5eMocjxCM5o2M7t3NqsiuREgztWj26aBlI4x3MgTiLwluxhRlRm/MH8Z
 jzWR5vAbuaI4570v0aVtFlEbAJr5VVUvzJEBbjPH4+XFt5MrdiPt8t3mRxcvetp0uJv7
 fYGDfLJPg2VJa93/+T9AlhmCPED6UX2YC4w5bVWdV54xOusbmCPQbo/GK/gqmXsB7/Q2
 xXL/e5Ux/BXuMYsroWzZJVGgWbdN9PlsNPL9ucqTeBqaHB7ly6DbQOSyAbqDGjEaaVnU 7A== 
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ppcq3h2eb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 01 Apr 2023 16:57:49 +0000
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 331GvkLd007088;
        Sat, 1 Apr 2023 16:57:46 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3ppdpk2ufb-1;
        Sat, 01 Apr 2023 16:57:46 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 331GvkdJ007014;
        Sat, 1 Apr 2023 16:57:46 GMT
Received: from hu-maiyas-hyd.qualcomm.com (hu-sartgarg-hyd.qualcomm.com [10.213.105.147])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 331GvkJe006988;
        Sat, 01 Apr 2023 16:57:46 +0000
Received: by hu-maiyas-hyd.qualcomm.com (Postfix, from userid 2339771)
        id 6F386504928; Sat,  1 Apr 2023 22:27:45 +0530 (+0530)
From:   Sarthak Garg <quic_sartgarg@quicinc.com>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, quic_rampraka@quicinc.com,
        quic_bhaskarv@quicinc.com, quic_sachgupt@quicinc.com,
        quic_pragalla@quicinc.com, quic_sayalil@quicinc.com,
        Sarthak Garg <quic_sartgarg@quicinc.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Kees Cook <keescook@chromium.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        =?UTF-8?q?Christian=20L=C3=B6hle?= <CLoehle@hyperstone.com>,
        Yann Gautier <yann.gautier@foss.st.com>,
        ChanWoo Lee <cw9316.lee@samsung.com>,
        Shaik Sajida Bhanu <quic_c_sbhanu@quicinc.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Ye Bin <yebin10@huawei.com>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Yu Zhe <yuzhe@nfschina.com>,
        Yang Yingliang <yangyingliang@huawei.com>,
        Brian Norris <briannorris@chromium.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jens Axboe <axboe@kernel.dk>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        David Sterba <dsterba@suse.com>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH V1 2/2] mmc: core: Export core functions to let vendors use for their features
Date:   Sat,  1 Apr 2023 22:27:23 +0530
Message-Id: <20230401165723.19762-3-quic_sartgarg@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230401165723.19762-1-quic_sartgarg@quicinc.com>
References: <20230401165723.19762-1-quic_sartgarg@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: gHQ1LSsFIB8xHEmZlHFJ_fd91KlJYc5g
X-Proofpoint-ORIG-GUID: gHQ1LSsFIB8xHEmZlHFJ_fd91KlJYc5g
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-31_07,2023-03-31_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 lowpriorityscore=0 phishscore=0 impostorscore=0 suspectscore=0 spamscore=0
 bulkscore=0 mlxlogscore=999 adultscore=0 clxscore=1011 malwarescore=0
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

Export core functions to let vendors use for their internal features.

Signed-off-by: Sarthak Garg <quic_sartgarg@quicinc.com>
---
 drivers/mmc/core/core.c    |  6 ++++++
 drivers/mmc/core/host.c    |  1 +
 drivers/mmc/core/mmc.c     | 18 ++++++++++++------
 drivers/mmc/core/mmc_ops.c |  1 +
 drivers/mmc/core/queue.c   |  1 +
 5 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 3d3e0ca52614..ed44b65f19e0 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -916,6 +916,7 @@ void mmc_set_clock(struct mmc_host *host, unsigned int hz)
 	host->ios.clock = hz;
 	mmc_set_ios(host);
 }
+EXPORT_SYMBOL_GPL(mmc_set_clock);
 
 int mmc_execute_tuning(struct mmc_card *card)
 {
@@ -950,6 +951,7 @@ int mmc_execute_tuning(struct mmc_card *card)
 
 	return err;
 }
+EXPORT_SYMBOL_GPL(mmc_execute_tuning);
 
 /*
  * Change the bus mode (open drain/push-pull) of a host.
@@ -959,6 +961,7 @@ void mmc_set_bus_mode(struct mmc_host *host, unsigned int mode)
 	host->ios.bus_mode = mode;
 	mmc_set_ios(host);
 }
+EXPORT_SYMBOL_GPL(mmc_set_bus_mode);
 
 /*
  * Change data bus width of a host.
@@ -968,6 +971,7 @@ void mmc_set_bus_width(struct mmc_host *host, unsigned int width)
 	host->ios.bus_width = width;
 	mmc_set_ios(host);
 }
+EXPORT_SYMBOL_GPL(mmc_set_bus_width);
 
 /*
  * Set initial state after a power cycle or a hw_reset.
@@ -1001,6 +1005,7 @@ void mmc_set_initial_state(struct mmc_host *host)
 
 	mmc_crypto_set_initial_state(host);
 }
+EXPORT_SYMBOL_GPL(mmc_set_initial_state);
 
 /**
  * mmc_vdd_to_ocrbitnum - Convert a voltage to the OCR bit number
@@ -1270,6 +1275,7 @@ void mmc_set_timing(struct mmc_host *host, unsigned int timing)
 	host->ios.timing = timing;
 	mmc_set_ios(host);
 }
+EXPORT_SYMBOL_GPL(mmc_set_timing);
 
 /*
  * Select appropriate driver type for host.
diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
index 76900f67c782..1c5eb1d9d585 100644
--- a/drivers/mmc/core/host.c
+++ b/drivers/mmc/core/host.c
@@ -166,6 +166,7 @@ void mmc_retune_hold(struct mmc_host *host)
 		host->retune_now = 1;
 	host->hold_retune += 1;
 }
+EXPORT_SYMBOL(mmc_retune_hold);
 
 void mmc_retune_release(struct mmc_host *host)
 {
diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 32386e4644df..b984a4f90535 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -1002,7 +1002,7 @@ static void mmc_set_bus_speed(struct mmc_card *card)
  * If the bus width is changed successfully, return the selected width value.
  * Zero is returned instead of error value if the wide width is not supported.
  */
-static int mmc_select_bus_width(struct mmc_card *card)
+int mmc_select_bus_width(struct mmc_card *card)
 {
 	static unsigned ext_csd_bits[] = {
 		EXT_CSD_BUS_WIDTH_8,
@@ -1067,11 +1067,12 @@ static int mmc_select_bus_width(struct mmc_card *card)
 
 	return err;
 }
+EXPORT_SYMBOL_GPL(mmc_select_bus_width);
 
 /*
  * Switch to the high-speed mode
  */
-static int mmc_select_hs(struct mmc_card *card)
+int mmc_select_hs(struct mmc_card *card)
 {
 	int err;
 
@@ -1085,11 +1086,12 @@ static int mmc_select_hs(struct mmc_card *card)
 
 	return err;
 }
+EXPORT_SYMBOL_GPL(mmc_select_hs);
 
 /*
  * Activate wide bus and DDR if supported.
  */
-static int mmc_select_hs_ddr(struct mmc_card *card)
+int mmc_select_hs_ddr(struct mmc_card *card)
 {
 	struct mmc_host *host = card->host;
 	u32 bus_width, ext_csd_bits;
@@ -1158,8 +1160,9 @@ static int mmc_select_hs_ddr(struct mmc_card *card)
 
 	return err;
 }
+EXPORT_SYMBOL_GPL(mmc_select_hs_ddr);
 
-static int mmc_select_hs400(struct mmc_card *card)
+int mmc_select_hs400(struct mmc_card *card)
 {
 	struct mmc_host *host = card->host;
 	unsigned int max_dtr;
@@ -1253,6 +1256,7 @@ static int mmc_select_hs400(struct mmc_card *card)
 	       __func__, err);
 	return err;
 }
+EXPORT_SYMBOL_GPL(mmc_select_hs400);
 
 int mmc_hs200_to_hs400(struct mmc_card *card)
 {
@@ -1533,7 +1537,7 @@ static int mmc_select_hs200(struct mmc_card *card)
 /*
  * Activate High Speed, HS200 or HS400ES mode if supported.
  */
-static int mmc_select_timing(struct mmc_card *card)
+int mmc_select_timing(struct mmc_card *card)
 {
 	int err = 0;
 
@@ -1568,12 +1572,13 @@ static int mmc_select_timing(struct mmc_card *card)
 	mmc_set_bus_speed(card);
 	return 0;
 }
+EXPORT_SYMBOL_GPL(mmc_select_timing);
 
 /*
  * Execute tuning sequence to seek the proper bus operating
  * conditions for HS200 and HS400, which sends CMD21 to the device.
  */
-static int mmc_hs200_tuning(struct mmc_card *card)
+int mmc_hs200_tuning(struct mmc_card *card)
 {
 	struct mmc_host *host = card->host;
 
@@ -1588,6 +1593,7 @@ static int mmc_hs200_tuning(struct mmc_card *card)
 
 	return mmc_execute_tuning(card);
 }
+EXPORT_SYMBOL_GPL(mmc_hs200_tuning);
 
 /*
  * Handle the detection and initialisation of a card.
diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
index 3b3adbddf664..62c16dac9d62 100644
--- a/drivers/mmc/core/mmc_ops.c
+++ b/drivers/mmc/core/mmc_ops.c
@@ -118,6 +118,7 @@ int mmc_select_card(struct mmc_card *card)
 
 	return _mmc_select_card(card->host, card);
 }
+EXPORT_SYMBOL_GPL(mmc_select_card);
 
 int mmc_deselect_cards(struct mmc_host *host)
 {
diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
index b396e3900717..2c710d736032 100644
--- a/drivers/mmc/core/queue.c
+++ b/drivers/mmc/core/queue.c
@@ -69,6 +69,7 @@ enum mmc_issue_type mmc_issue_type(struct mmc_queue *mq, struct request *req)
 
 	return MMC_ISSUE_SYNC;
 }
+EXPORT_SYMBOL_GPL(mmc_issue_type);
 
 static void __mmc_cqe_recovery_notifier(struct mmc_queue *mq)
 {
-- 
2.17.1

