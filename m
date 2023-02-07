Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEC9D68CE57
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 05:46:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbjBGEql (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 23:46:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjBGEqh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 23:46:37 -0500
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5849A274A1;
        Mon,  6 Feb 2023 20:46:36 -0800 (PST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3171EnKf013612;
        Mon, 6 Feb 2023 20:46:13 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=pfpt0220; bh=sOPOyTjWHdyrO1gDEvB/P6a2NUquFzpQD1ZdVsKcvzE=;
 b=i3Bb8ydAM3fPZ8PUrsjahGBxYissFhn90L1yvxDQC2Qu4jZLIjqaHtWIatdg6YSFymwV
 95JlHmuv1K70Ue63f6Li/EEFaEIONZw8p+KxvQYZviZ5Ca505wUyTBckj/5csn4edJ8f
 5Pyn0xNuOON8xd2aMXKsRIscSEY00z1DVdshsSqWnAune8Tx1uAoRwvzI3SgaZ8XIZNy
 tphL10IGWoVi5G2h7LS/oay8y2X1ic9RNiPz+baAx4nteLF6f15O9rcYslg80au5brJ9
 FQBhc48TObRpklu7E+tmpxTJRGIuTTKbiLZVHTXdDYxE1HQDLT/QAzm1N9x/m9XzSzWH Gw== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3nhqrtgryc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 06 Feb 2023 20:46:13 -0800
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 6 Feb
 2023 20:46:11 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.42 via Frontend
 Transport; Mon, 6 Feb 2023 20:46:11 -0800
Received: from tx2-sever.caveonetworks.com (unknown [10.110.141.15])
        by maili.marvell.com (Postfix) with ESMTP id E2E373F7082;
        Mon,  6 Feb 2023 20:46:10 -0800 (PST)
From:   George Cherian <george.cherian@marvell.com>
To:     <wim@linux-watchdog.org>, <linux@roeck-us.net>,
        <zhangshaokun@hisilicon.com>
CC:     <linux-watchdog@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "George Cherian" <george.cherian@marvell.com>
Subject: [PATCH 1/2] watchdog: sbsa_wdog: Fix the timeout calculation while programming
Date:   Tue, 7 Feb 2023 04:46:02 +0000
Message-ID: <20230207044603.1011555-1-george.cherian@marvell.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: CQoYZciFlgYl45uTG-9_LCjGa--L4TwG
X-Proofpoint-ORIG-GUID: CQoYZciFlgYl45uTG-9_LCjGa--L4TwG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-06_07,2023-02-06_03,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The time out calculation done in sbsa_gwdt_set_timeout() would always
return a 32-bit value. Use proper typecasting to make sure the overflow
values are captured.

Fixes: abd3ac7902fb ("watchdog: sbsa: Support architecture version 1")

Signed-off-by: George Cherian <george.cherian@marvell.com>
---
 drivers/watchdog/sbsa_gwdt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/watchdog/sbsa_gwdt.c b/drivers/watchdog/sbsa_gwdt.c
index 9791c74aebd4..aaa3f5631f29 100644
--- a/drivers/watchdog/sbsa_gwdt.c
+++ b/drivers/watchdog/sbsa_gwdt.c
@@ -152,14 +152,14 @@ static int sbsa_gwdt_set_timeout(struct watchdog_device *wdd,
 	wdd->timeout = timeout;
 
 	if (action)
-		sbsa_gwdt_reg_write(gwdt->clk * timeout, gwdt);
+		sbsa_gwdt_reg_write((u64)gwdt->clk * (u64)timeout, gwdt);
 	else
 		/*
 		 * In the single stage mode, The first signal (WS0) is ignored,
 		 * the timeout is (WOR * 2), so the WOR should be configured
 		 * to half value of timeout.
 		 */
-		sbsa_gwdt_reg_write(gwdt->clk / 2 * timeout, gwdt);
+		sbsa_gwdt_reg_write((u64)gwdt->clk / 2 * (u64)timeout, gwdt);
 
 	return 0;
 }
-- 
2.34.1

