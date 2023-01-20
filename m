Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0D156753A7
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 12:47:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229980AbjATLra (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 06:47:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbjATLrU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 06:47:20 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63FE8B2791
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 03:47:01 -0800 (PST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30KBdohc021838;
        Fri, 20 Jan 2023 11:46:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=rfHbfchEBFp0rSAQl1DiDL6znkjA4C2YnGHx5ZHq4jY=;
 b=qgrrFYf3C5wqVEb+bAi7r4fDHNLbrLWcqRGo+JlTcHt/d90bfKjVcz3Ey0xxDvqS0L6X
 xyOYM4DEfN4Z98k+etAojdGFQTXC328oJldkL9mRtguZRf3BJyW6B042JlZXuMEq8z7e
 izFyPHFWsGHaUhmZiV4g/UBshtkXZgiZsYS5vNtdHfoEl2jrk4ZnrZ98MDxoB8h+Uep0
 SNInd1lDArmUXThUWRKdNQmuJR4XCdddtc0VSzamruJcfnuHdTnqXO+p/58dSxhc1dMl
 hbUKxuBO6nR/DOZzwDLa8NbWQeVYqzwTmad62Q36ExU9MUO6969IckEGJXCZx1Ri89IW Vg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3n7sk6h6av-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Jan 2023 11:46:55 +0000
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 30KBeQJ2024356;
        Fri, 20 Jan 2023 11:46:54 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3n7sk6h693-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Jan 2023 11:46:54 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30JJSwff007923;
        Fri, 20 Jan 2023 11:46:52 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
        by ppma06ams.nl.ibm.com (PPS) with ESMTPS id 3n3knfqxj1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Jan 2023 11:46:52 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
        by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30KBknY230408974
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Jan 2023 11:46:49 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C864820043;
        Fri, 20 Jan 2023 11:46:49 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 83A642004B;
        Fri, 20 Jan 2023 11:46:49 +0000 (GMT)
Received: from m83lp52.lnxne.boe (unknown [9.152.108.100])
        by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 20 Jan 2023 11:46:49 +0000 (GMT)
From:   Christian Borntraeger <borntraeger@linux.ibm.com>
To:     Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>
Cc:     Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] checkpatch: recognise NOKPROBE_SYMBOL for blank line detection after function/struct/union/enum
Date:   Fri, 20 Jan 2023 12:46:49 +0100
Message-Id: <20230120114649.117018-1-borntraeger@linux.ibm.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: enZE0vXAWZ3GVKJtfp6KkZS09IBFdrNH
X-Proofpoint-ORIG-GUID: PvYaePtMG2ln00MEH766r9LvLYGLrED6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-20_07,2023-01-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 lowpriorityscore=0 malwarescore=0 priorityscore=1501 adultscore=0
 bulkscore=0 impostorscore=0 mlxscore=0 mlxlogscore=999 spamscore=0
 clxscore=1011 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301200110
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

NOKPROBE_SYMBOL should be treated like EXPORT_SYMBOL to avoid
false positives.

Signed-off-by: Christian Borntraeger <borntraeger@linux.ibm.com>
---
 scripts/checkpatch.pl | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 78cc595b98ce..037acbcee0e1 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -3995,6 +3995,7 @@ sub process {
 		    $line =~ /^\+/ &&
 		    !($line =~ /^\+\s*$/ ||
 		      $line =~ /^\+\s*(?:EXPORT_SYMBOL|early_param)/ ||
+		      $line =~ /^\+\s*NOKPROBE_SYMBOL/ ||
 		      $line =~ /^\+\s*MODULE_/i ||
 		      $line =~ /^\+\s*\#\s*(?:end|elif|else)/ ||
 		      $line =~ /^\+[a-z_]*init/ ||
-- 
2.38.1

