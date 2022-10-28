Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A273D610B6A
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 09:38:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230193AbiJ1Hin (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 03:38:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230308AbiJ1HiW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 03:38:22 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02EB41BF861;
        Fri, 28 Oct 2022 00:38:21 -0700 (PDT)
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29S15iSN013328;
        Fri, 28 Oct 2022 09:38:08 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=selector1;
 bh=Ls6XpX4UfWNReha8+iqxNKjy/N+ngxJZgqPEgE1QHsg=;
 b=5ShIB/gID5SL1hkzcP5DcrnxioKBHTO1Ydsuo/J052grC4OY7BTxRW43g2mxEzjpWffM
 0lsEBG64Dqk2+dX2Lo85HLDcBC9zYqqItMq7k0G0bcrAO4WMZsU3UlsrJgNSMCTqAdN+
 SniB9XS3uxjs5hc6xx99qjVohu0jtPTpBE+rdsBIuWS4zIPv1tw4eGUIZRAl59bWmJXw
 W1k7Cx8laBgCSQDAQ7/5cLc9CbsXVaYD0Cy3zQPo/RKhjiacMiTQgEvPXfb6+g95U6UC
 0N3lt2qNSQAdt6/lNDGNU7rt+rxBUJkknEwFB0SVs+JgH2lQNbIPn04yP2MKGm4q99nu qQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3kfahu2u0d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Oct 2022 09:38:08 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 325DF100039;
        Fri, 28 Oct 2022 09:38:02 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 2AB1621160F;
        Fri, 28 Oct 2022 09:38:02 +0200 (CEST)
Received: from localhost (10.201.20.201) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Fri, 28 Oct
 2022 09:38:01 +0200
From:   Yann Gautier <yann.gautier@foss.st.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
CC:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kees Cook <keescook@chromium.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Shaik Sajida Bhanu <quic_c_sbhanu@quicinc.com>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>,
        <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <christophe.kerello@foss.st.com>,
        Yann Gautier <yann.gautier@foss.st.com>
Subject: [PATCH] mmc: core: properly select voltage range without power cycle
Date:   Fri, 28 Oct 2022 09:37:40 +0200
Message-ID: <20221028073740.7259-1-yann.gautier@foss.st.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.201.20.201]
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-28_04,2022-10-27_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In mmc_select_voltage(), if there is no full power cycle, the voltage
range selected at the end of the function will be on a single range
(e.g. 3.3V/3.4V). To keep a range around the selected voltage (3.2V/3.4V),
the mask shift should be reduced by 1.

This issue was triggered by using a specific SD-card (Verbatim Premium
16GB UHS-1) on an STM32MP157C-DK2 board. This board cannot do UHS modes
and there is no power cycle. And the card was failing to switch to
high-speed mode. When adding the range 3.2V/3.3V for this card with the
proposed shift change, the card can switch to high-speed mode.

Fixes: ce69d37b7d8f ("mmc: core: Prevent violation of specs while initializing cards")
Signed-off-by: Yann Gautier <yann.gautier@foss.st.com>
---
 drivers/mmc/core/core.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 95fa8fb1d45f..c5de202f530a 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -1134,7 +1134,13 @@ u32 mmc_select_voltage(struct mmc_host *host, u32 ocr)
 		mmc_power_cycle(host, ocr);
 	} else {
 		bit = fls(ocr) - 1;
-		ocr &= 3 << bit;
+		/*
+		 * The bit variable represents the highest voltage bit set in
+		 * the OCR register.
+		 * To keep a range of 2 values (e.g. 3.2V/3.3V and 3.3V/3.4V),
+		 * we must shift the mask '3' with (bit - 1).
+		 */
+		ocr &= 3 << (bit - 1);
 		if (bit != host->ios.vdd)
 			dev_warn(mmc_dev(host), "exceeding card's volts\n");
 	}
-- 
2.25.1

