Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBC34689116
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 08:42:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232550AbjBCHk6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 02:40:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232474AbjBCHke (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 02:40:34 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC57893AEC;
        Thu,  2 Feb 2023 23:40:26 -0800 (PST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3137Ecc4025439;
        Fri, 3 Feb 2023 07:40:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=iLsMVUM9lmAtrcEhKWOz4nJ+jGFwhM8fO2Yr4tUse9Q=;
 b=WlcGlrF1rIeLe+P4CGn54QWKzlV5o6GUCAWOmg+MQguUCBSFNbcVnEvlN1bXXhUbpY74
 e34lH+lOO6vzv1gbgZ6YLJf+fNRbdEE497ZY2VnAwGuEa8z56i+xo3pLZxbxOV1kEZV0
 bnahahcyEX/cZlMZnZspvIUKSWhfbCzNSPnZmatFy0yUa2mjI/IHFdOWC/F0ZrWk1L+4
 qp4NYZkfBwjy1Rn7jmfSkbauRPWHUEiwooSEnJZeVxXhEAo/it0hGYIwWMg/YHaTtddB
 z6CTcnEUW3640z89PgjWGPRifTy8cFDPrBQniqD521BW4ztnzB/QdlUbHyO1ksBA6fyu 7A== 
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ngwpr0j9g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Feb 2023 07:40:13 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 312G5BEM020245;
        Fri, 3 Feb 2023 07:40:11 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma04fra.de.ibm.com (PPS) with ESMTPS id 3ndn6ucbm7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Feb 2023 07:40:11 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3137e7Qo19726670
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 3 Feb 2023 07:40:07 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2B0732141D;
        Fri,  3 Feb 2023 07:40:07 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3C57D2142E;
        Fri,  3 Feb 2023 07:40:04 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Fri,  3 Feb 2023 07:40:04 +0000 (GMT)
From:   Alexander Egorenkov <egorenar@linux.ibm.com>
To:     wim@linux-watchdog.org, linux@roeck-us.net
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        hca@linux.ibm.com
Subject: [PATCH 1/5] watchdog: diag288_wdt: get rid of register asm
Date:   Fri,  3 Feb 2023 08:39:54 +0100
Message-Id: <20230203073958.1585738-2-egorenar@linux.ibm.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230203073958.1585738-1-egorenar@linux.ibm.com>
References: <20230203073958.1585738-1-egorenar@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: skPicpaedP-BLxb1ZtJKpslJfwh7VgyH
X-Proofpoint-GUID: skPicpaedP-BLxb1ZtJKpslJfwh7VgyH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-03_04,2023-02-02_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 spamscore=0
 malwarescore=0 priorityscore=1501 suspectscore=0 bulkscore=0
 lowpriorityscore=0 mlxscore=0 mlxlogscore=999 impostorscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302030069
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using register asm statements has been proven to be very error prone,
especially when using code instrumentation where gcc may add function
calls, which clobbers register contents in an unexpected way.

Therefore, get rid of register asm statements in watchdog code, and make
sure this bug class cannot happen.

Moreover, remove the register r1 from the clobber list because this
register is not changed by DIAG 288.

Reviewed-by: Heiko Carstens <hca@linux.ibm.com>
Signed-off-by: Alexander Egorenkov <egorenar@linux.ibm.com>
---
 drivers/watchdog/diag288_wdt.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/watchdog/diag288_wdt.c b/drivers/watchdog/diag288_wdt.c
index 6ca5d9515d85..07ebbb709af4 100644
--- a/drivers/watchdog/diag288_wdt.c
+++ b/drivers/watchdog/diag288_wdt.c
@@ -73,20 +73,19 @@ MODULE_ALIAS("vmwatchdog");
 static int __diag288(unsigned int func, unsigned int timeout,
 		     unsigned long action, unsigned int len)
 {
-	register unsigned long __func asm("2") = func;
-	register unsigned long __timeout asm("3") = timeout;
-	register unsigned long __action asm("4") = action;
-	register unsigned long __len asm("5") = len;
+	union register_pair r1 = { .even = func, .odd = timeout, };
+	union register_pair r3 = { .even = action, .odd = len, };
 	int err;
 
 	err = -EINVAL;
 	asm volatile(
-		"	diag	%1, %3, 0x288\n"
-		"0:	la	%0, 0\n"
+		"	diag	%[r1],%[r3],0x288\n"
+		"0:	la	%[err],0\n"
 		"1:\n"
 		EX_TABLE(0b, 1b)
-		: "+d" (err) : "d"(__func), "d"(__timeout),
-		  "d"(__action), "d"(__len) : "1", "cc", "memory");
+		: [err] "+d" (err)
+		: [r1] "d" (r1.pair), [r3] "d" (r3.pair)
+		: "cc", "memory");
 	return err;
 }
 
-- 
2.37.2

