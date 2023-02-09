Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A85F068FCF5
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 03:12:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231681AbjBICMe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 21:12:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231611AbjBICMc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 21:12:32 -0500
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEA2525BB8;
        Wed,  8 Feb 2023 18:11:54 -0800 (PST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31921Km4026350;
        Wed, 8 Feb 2023 18:11:22 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=pfpt0220; bh=HQTLW3GXXAvE//tLnEkmnSFWMNDpVwqLK+9NZXZOOD8=;
 b=OPHUKGCps/Qlt782HCW2QzgPHwii79HXF8B9Mk17M4fe7SdbTWXimkVTDexamoVNexOm
 d4+BslFvmX7nG4bugylOLBqYWKJjZwSsvEbIj68o7lIK651oBTySwZOhG2TipLQHUSU2
 9tiDCb4VSWC4IZT6xi8R9MZiPgeaP8uSCNEE9gjo+xXc5iCiCfPW+0NRyWLoXf/ps0+m
 nD3GVepNrGv9rWg9P3531JrV87IoLzKxj+rWcGJ1KkC4I9uPQ1bOW2cFk5+E2WtTqW2t
 YZrLmXT9jB6j+UjWdJ8HH4WFgYNZRHqKNF5cwlkNJd278x/TpmsujheCDpGsoXfyQILH WQ== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3nm65kydux-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 08 Feb 2023 18:11:21 -0800
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 8 Feb
 2023 18:11:19 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.42 via Frontend
 Transport; Wed, 8 Feb 2023 18:11:19 -0800
Received: from tx2-sever.caveonetworks.com (unknown [10.110.141.15])
        by maili.marvell.com (Postfix) with ESMTP id 587ED5B692A;
        Wed,  8 Feb 2023 18:11:19 -0800 (PST)
From:   George Cherian <george.cherian@marvell.com>
To:     <wim@linux-watchdog.org>, <linux@roeck-us.net>,
        <zhangshaokun@hisilicon.com>
CC:     <linux-watchdog@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "George Cherian" <george.cherian@marvell.com>
Subject: [PATCH v3] watchdog: sbsa_wdog: Make sure the timeout programming is within the limits
Date:   Thu, 9 Feb 2023 02:11:17 +0000
Message-ID: <20230209021117.1512097-1-george.cherian@marvell.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: opIW65Fj7LaV0cAkHuyAIl6IO-X7noSs
X-Proofpoint-ORIG-GUID: opIW65Fj7LaV0cAkHuyAIl6IO-X7noSs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-08_11,2023-02-08_02,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make sure to honour the max_hw_heartbeat_ms while programming the timeout
value to WOR. Clamp the timeout passed to sbsa_gwdt_set_timeout() to
make sure the programmed value is within the permissible range.

Fixes: abd3ac7902fb ("watchdog: sbsa: Support architecture version 1")

Signed-off-by: George Cherian <george.cherian@marvell.com>
---
 drivers/watchdog/sbsa_gwdt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/watchdog/sbsa_gwdt.c b/drivers/watchdog/sbsa_gwdt.c
index 9791c74aebd4..63862803421f 100644
--- a/drivers/watchdog/sbsa_gwdt.c
+++ b/drivers/watchdog/sbsa_gwdt.c
@@ -150,6 +150,7 @@ static int sbsa_gwdt_set_timeout(struct watchdog_device *wdd,
 	struct sbsa_gwdt *gwdt = watchdog_get_drvdata(wdd);
 
 	wdd->timeout = timeout;
+	timeout = clamp_t(unsigned int, timeout, 1, wdd->max_hw_heartbeat_ms / 1000);
 
 	if (action)
 		sbsa_gwdt_reg_write(gwdt->clk * timeout, gwdt);
-- 
2.34.1

