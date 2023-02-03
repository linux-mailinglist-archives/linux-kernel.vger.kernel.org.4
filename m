Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B92D68911A
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 08:42:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232530AbjBCHku (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 02:40:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232417AbjBCHke (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 02:40:34 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2942793E0B;
        Thu,  2 Feb 2023 23:40:26 -0800 (PST)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31370w03016120;
        Fri, 3 Feb 2023 07:40:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=Ax36eGVT6uv/rdk0f4LW7DqyFxU3vDre425F3oR0aSk=;
 b=q2HQasjU3H1Q700XQ3aIhIW2zD3fgqNHW1ht1jXM3tC3R1bNLFERp/VtWPCCtFzadwW7
 xn1eyDOItKcyO5lSgg/mEbNf618IuNOlggsvwc8dOZdxQHdyaFCu6qKjXEIXf/T7Cgd0
 hQtnpw6om2Hhknd9GMSCg2uMSSN7bD/TlRgJntXio7Ooi7si4FI/LX9CG0Hy9gefxHN7
 vIWAKI58LAm4+ncooc6Ye1Bvcrro+X2vaMK3G/kwZB7vLDKequXNka6UQxTeAiM/Wpzs
 jeLdEILtnLCYRQtmhPlazdf9n0NP7i+zWDMUY4jJ0c0iGegLqYOIIyLrhsz4vwUbri08 /g== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ngwgegugy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Feb 2023 07:40:12 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3136QZPl012873;
        Fri, 3 Feb 2023 07:40:09 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma03ams.nl.ibm.com (PPS) with ESMTPS id 3ncvtyf44y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Feb 2023 07:40:09 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3137e7h921037682
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 3 Feb 2023 07:40:07 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 318A621447;
        Fri,  3 Feb 2023 07:40:07 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 98B0821433;
        Fri,  3 Feb 2023 07:40:04 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Fri,  3 Feb 2023 07:40:04 +0000 (GMT)
From:   Alexander Egorenkov <egorenar@linux.ibm.com>
To:     wim@linux-watchdog.org, linux@roeck-us.net
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        hca@linux.ibm.com
Subject: [PATCH 4/5] watchdog: diag288_wdt: de-duplicate diag_stat_inc() calls
Date:   Fri,  3 Feb 2023 08:39:57 +0100
Message-Id: <20230203073958.1585738-5-egorenar@linux.ibm.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230203073958.1585738-1-egorenar@linux.ibm.com>
References: <20230203073958.1585738-1-egorenar@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: PZXR6kb8t_yX_SNPtMpJOumrt29X-eNP
X-Proofpoint-GUID: PZXR6kb8t_yX_SNPtMpJOumrt29X-eNP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-03_04,2023-02-02_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 phishscore=0
 spamscore=0 lowpriorityscore=0 impostorscore=0 mlxscore=0 malwarescore=0
 priorityscore=1501 adultscore=0 bulkscore=0 clxscore=1015 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302030069
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Call diag_stat_inc() from __diag288() to reduce code duplication.

Reviewed-by: Heiko Carstens <hca@linux.ibm.com>
Signed-off-by: Alexander Egorenkov <egorenar@linux.ibm.com>
---
 drivers/watchdog/diag288_wdt.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/watchdog/diag288_wdt.c b/drivers/watchdog/diag288_wdt.c
index c717f47dd4c3..a29ad164b27a 100644
--- a/drivers/watchdog/diag288_wdt.c
+++ b/drivers/watchdog/diag288_wdt.c
@@ -78,6 +78,8 @@ static int __diag288(unsigned int func, unsigned int timeout,
 	union register_pair r3 = { .even = action, .odd = len, };
 	int err;
 
+	diag_stat_inc(DIAG_STAT_X288);
+
 	err = -EINVAL;
 	asm volatile(
 		"	diag	%[r1],%[r3],0x288\n"
@@ -100,14 +102,12 @@ static int __diag288_vm(unsigned int  func, unsigned int timeout, char *cmd)
 	ASCEBC(cmd_buf, MAX_CMDLEN);
 	EBC_TOUPPER(cmd_buf, MAX_CMDLEN);
 
-	diag_stat_inc(DIAG_STAT_X288);
 	return __diag288(func, timeout, virt_to_phys(cmd_buf), len);
 }
 
 static int __diag288_lpar(unsigned int func, unsigned int timeout,
 			  unsigned long action)
 {
-	diag_stat_inc(DIAG_STAT_X288);
 	return __diag288(func, timeout, action, 0);
 }
 
@@ -135,12 +135,7 @@ static int wdt_start(struct watchdog_device *dev)
 
 static int wdt_stop(struct watchdog_device *dev)
 {
-	int ret;
-
-	diag_stat_inc(DIAG_STAT_X288);
-	ret = __diag288(WDT_FUNC_CANCEL, 0, 0, 0);
-
-	return ret;
+	return __diag288(WDT_FUNC_CANCEL, 0, 0, 0);
 }
 
 static int wdt_ping(struct watchdog_device *dev)
-- 
2.37.2

