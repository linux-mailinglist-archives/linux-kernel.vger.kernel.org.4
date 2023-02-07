Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2EE668CE56
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 05:46:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbjBGEqj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 23:46:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjBGEqh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 23:46:37 -0500
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F29CD26CF5;
        Mon,  6 Feb 2023 20:46:35 -0800 (PST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3174fYKH018246;
        Mon, 6 Feb 2023 20:46:16 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=pfpt0220;
 bh=Egg+d/hbXPc5QXNgM0H/dqWjKBRYe/pPd7kAVbaz3T4=;
 b=hAgWZLg/1nD6mKRXlpXGjeC8WO0nLog1XhZi9hO2NSh2lfds6ILfkypbDhbtYwXt+3I3
 vjwFyPAUn70RWY3cBHvzouK+q2MYmVlkXQhmX8pfHZNgV+mrjPzF6RC0TA7e2OG8r/hz
 Djx7UvRwgCfv3xUrCdkwDNoEwRj28eLnQw6ybEtq4N0EEQXFcoFuGne9AwkRMrt3Z/rA
 qE91DXSkX7+YmGazfOHJc9L9TefV8/pf3zF7X5/bl2fCh0V7YnTl8DJXe9qvedqssiZB
 ljcxh5paTUF0Tpl1bgX9EjarRp2UmN+HAphYo3cr4M4tI9dtdtS8+CWblcBUJ8IP0Nkb Sw== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3nkdyrr6vs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 06 Feb 2023 20:46:15 -0800
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 6 Feb
 2023 20:46:14 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.42 via Frontend
 Transport; Mon, 6 Feb 2023 20:46:14 -0800
Received: from tx2-sever.caveonetworks.com (unknown [10.110.141.15])
        by maili.marvell.com (Postfix) with ESMTP id BD4E03F7083;
        Mon,  6 Feb 2023 20:46:13 -0800 (PST)
From:   George Cherian <george.cherian@marvell.com>
To:     <wim@linux-watchdog.org>, <linux@roeck-us.net>,
        <zhangshaokun@hisilicon.com>
CC:     <linux-watchdog@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "George Cherian" <george.cherian@marvell.com>
Subject: [PATCH 2/2] watchdog: sbsa_wdog: Make sure to program a larger timeout value
Date:   Tue, 7 Feb 2023 04:46:03 +0000
Message-ID: <20230207044603.1011555-2-george.cherian@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230207044603.1011555-1-george.cherian@marvell.com>
References: <20230207044603.1011555-1-george.cherian@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 6Qt3lf3rh1op2SaUaRZHU-aw3ekFkCCO
X-Proofpoint-GUID: 6Qt3lf3rh1op2SaUaRZHU-aw3ekFkCCO
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

There could be a corner case were-in the timeout value calculated will
become way to less than the calculated value since we are rounding down
the timeout value from 64-bit to 32-bit. To avoid hitting such cases,
make sure to program the timeout value to be UINT_MAX if the timeout
value is greater than UINT_MAX and the imeplementation is sbsa watchdog
revision 0.

Fixes: abd3ac7902fb ("watchdog: sbsa: Support architecture version 1")

Signed-off-by: George Cherian <george.cherian@marvell.com>
---
 drivers/watchdog/sbsa_gwdt.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/watchdog/sbsa_gwdt.c b/drivers/watchdog/sbsa_gwdt.c
index aaa3f5631f29..028e450ed547 100644
--- a/drivers/watchdog/sbsa_gwdt.c
+++ b/drivers/watchdog/sbsa_gwdt.c
@@ -135,10 +135,14 @@ static u64 sbsa_gwdt_reg_read(struct sbsa_gwdt *gwdt)
 
 static void sbsa_gwdt_reg_write(u64 val, struct sbsa_gwdt *gwdt)
 {
-	if (gwdt->version == 0)
-		writel((u32)val, gwdt->control_base + SBSA_GWDT_WOR);
-	else
+	if (gwdt->version == 0) {
+		if (val > UINT_MAX)
+			writel(UINT_MAX, gwdt->control_base + SBSA_GWDT_WOR);
+		else
+			writel((u32)val, gwdt->control_base + SBSA_GWDT_WOR);
+	} else {
 		lo_hi_writeq(val, gwdt->control_base + SBSA_GWDT_WOR);
+	}
 }
 
 /*
-- 
2.34.1

