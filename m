Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F6236DFB1A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 18:18:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbjDLQSf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 12:18:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbjDLQSd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 12:18:33 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E0D66E98;
        Wed, 12 Apr 2023 09:18:14 -0700 (PDT)
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33CCK5sT012362;
        Wed, 12 Apr 2023 18:17:45 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=selector1;
 bh=qoweobMCw9OjMJIGG9Oluh4CWDKdRBeAll2gFaHrPyY=;
 b=VZ1F0Bi1Q+9bJySmGN3Dizmwbi7b+vmqMIMIDGFTcW+Ryki2GUbGCgF+/l0pewNECfwk
 UZBtMP3dREJsSC2G5oUSXHBTZ9+QIdKFqmusw++eQSzQ4GbIiCHrzEC6F6bzKJewZycT
 MT28TZvLIShZKuHfSLgalbH+LICMtPUH0QKRaxgXbEJ+JBdY7zk5BZjymlW/+Zqk1qIE
 kcGrig0NOiLUC0SOs9FvM48AgvCnOJ94GWUIEyRqmIvZ9wmNE8mNNFc3MEXcNUN5Q1RD
 RNKcT1+OJmwyY8ktBOh7fgpp4KmjyvG7CWnDYCw2SXXtKOjqQfavZcC8H67FWwBwv9kr dQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3pw7wp0exg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Apr 2023 18:17:45 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 804B410002A;
        Wed, 12 Apr 2023 18:17:44 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 5414021A221;
        Wed, 12 Apr 2023 18:17:44 +0200 (CEST)
Received: from localhost (10.48.1.102) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Wed, 12 Apr
 2023 18:17:43 +0200
From:   Fabrice Gasnier <fabrice.gasnier@foss.st.com>
To:     <heikki.krogerus@linux.intel.com>, <gregkh@linuxfoundation.org>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <fabrice.gasnier@foss.st.com>
Subject: [PATCH] usb: typec: ucsi: don't print PPM init deferred errors
Date:   Wed, 12 Apr 2023 18:17:34 +0200
Message-ID: <20230412161734.3425090-1-fabrice.gasnier@foss.st.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.48.1.102]
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-12_08,2023-04-12_01,2023-02-09_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ucsi_init() may be deferred as usb_role_sw may be deferred in
ucsi_register_port(). This results in several PPM init failed (-517)
messages maybe printed several times upon boot, like on stm32mp135f-dk
board, until the role_switch driver gets probed.

[   19.880945] dwc2 49000000.usb: supply vusb_d not found, using dummy regulator
[   19.887136] dwc2 49000000.usb: supply vusb_a not found, using dummy regulator
[   19.975432] ucsi-stm32g0-i2c 0-0053: PPM init failed (-517)
[   20.155746] dwc2 49000000.usb: EPs: 9, dedicated fifos, 952 entries in SPRAM
[   20.175429] ucsi-stm32g0-i2c 0-0053: PPM init failed (-517)
[   20.184242] dwc2 49000000.usb: DWC OTG Controller

Adopt dev_err_probe() instead of dev_err(), to only print other errors.
Also print an error in case the wait count has expired.

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
---
 drivers/usb/typec/ucsi/ucsi.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
index f632350f6dcb..4d809e0d7761 100644
--- a/drivers/usb/typec/ucsi/ucsi.c
+++ b/drivers/usb/typec/ucsi/ucsi.c
@@ -1447,11 +1447,13 @@ static void ucsi_init_work(struct work_struct *work)
 
 	ret = ucsi_init(ucsi);
 	if (ret)
-		dev_err(ucsi->dev, "PPM init failed (%d)\n", ret);
+		dev_err_probe(ucsi->dev, ret, "PPM init failed\n");
 
 	if (ret == -EPROBE_DEFER) {
-		if (ucsi->work_count++ > UCSI_ROLE_SWITCH_WAIT_COUNT)
+		if (ucsi->work_count++ > UCSI_ROLE_SWITCH_WAIT_COUNT) {
+			dev_err(ucsi->dev, "PPM init failed, stop trying\n");
 			return;
+		}
 
 		queue_delayed_work(system_long_wq, &ucsi->work,
 				   UCSI_ROLE_SWITCH_INTERVAL);
-- 
2.25.1

