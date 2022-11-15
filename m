Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8F0F629044
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 03:59:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237315AbiKOC7i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 21:59:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237857AbiKOC7O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 21:59:14 -0500
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2C651C930
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 18:56:37 -0800 (PST)
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AF2lArQ011244;
        Mon, 14 Nov 2022 18:56:17 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=PPS06212021;
 bh=/CxmLvqUQR8gZR78/D1hy1TINRUon8HR8i5+i5W8Dyc=;
 b=FRvgyFuXhxVXQldYGTynxaFhRNDnTFHAm4XTLZnXDCfBYN2jcZ7e+G6DjskFp/BXG5IJ
 T3PDmZ6d+ieYqIkW6ZJbhaalYiPNFcCT8dHM9pLmcAIIduwzeZF34Ub3ngC4cz278I9S
 jMBD+XHF+Ymz77UZuMqrhGaM5YPvBgry2573O/Kymypc2upetFGxxA7K3WSB32rwFnDZ
 V7fqblmz38UCZf7FSEi4z5Bk9CgtqQnMDz/qsr2uZXtTycdzbESv2t8YeeXI4kyniC5x
 1bWNOQZeQh3OJEjYYh14XCbLClUn+TcQG79swzjcw0K90suiRjRnwpOtsc5R1HwTo4Wt 2g== 
Received: from ala-exchng02.corp.ad.wrs.com (unknown-82-254.windriver.com [147.11.82.254])
        by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3ktbvr9tst-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 14 Nov 2022 18:56:16 -0800
Received: from ala-exchng01.corp.ad.wrs.com (147.11.82.252) by
 ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Mon, 14 Nov 2022 18:56:16 -0800
Received: from pek-lpd-ccm3.wrs.com (147.11.136.210) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server id
 15.1.2242.12 via Frontend Transport; Mon, 14 Nov 2022 18:56:15 -0800
From:   Yun Zhou <yun.zhou@windriver.com>
To:     <jstultz@google.com>, <tglx@linutronix.de>, <sboyd@kernel.org>
CC:     <linux-kernel@vger.kernel.org>
Subject: [PATCH] timers: fix LVL_START macro
Date:   Tue, 15 Nov 2022 10:56:14 +0800
Message-ID: <20221115025614.79537-1-yun.zhou@windriver.com>
X-Mailer: git-send-email 2.35.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: ldBEMTSq4fIAaL-TbuTO3fRTgJBvaDEm
X-Proofpoint-GUID: ldBEMTSq4fIAaL-TbuTO3fRTgJBvaDEm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-14_15,2022-11-11_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 mlxscore=0
 clxscore=1011 spamscore=0 bulkscore=0 malwarescore=0 mlxlogscore=825
 impostorscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2210170000 definitions=main-2211150020
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The number of buckets per level should be LVL_SIZE, not LVL_SIZE-1.

Signed-off-by: Yun Zhou <yun.zhou@windriver.com>
---
 kernel/time/timer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 717fcb9fb14a..1116b208093e 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -161,7 +161,7 @@ EXPORT_SYMBOL(jiffies_64);
  * time. We start from the last possible delta of the previous level
  * so that we can later add an extra LVL_GRAN(n) to n (see calc_index()).
  */
-#define LVL_START(n)	((LVL_SIZE - 1) << (((n) - 1) * LVL_CLK_SHIFT))
+#define LVL_START(n)	(LVL_SIZE << (((n) - 1) * LVL_CLK_SHIFT))
 
 /* Size of each clock level */
 #define LVL_BITS	6
-- 
2.35.2

