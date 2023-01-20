Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF578674E8A
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 08:45:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231240AbjATHpV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 02:45:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231235AbjATHpD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 02:45:03 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEB3F891CC;
        Thu, 19 Jan 2023 23:44:04 -0800 (PST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30K785c3022812;
        Fri, 20 Jan 2023 07:43:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=jHqYnNNSehOqnFYe+obF2xo6NpZcocauyYjQSPOSdDw=;
 b=G5mCpinwVQlulxQfRCCa0+pD/r6Bez9jGrAaTerINTkWWyd/6D+D3u38JCkc8K5e4HhB
 dOEj6yqpNzMB6P98D7D4bLgvuxSKRvOHFURVc8UKuA9iJz9WkAMsTn3EaQgleERNgR00
 ck3CzFTpku5HrTFf+lHwQkxiOW6uzatl8vAPbRSblitiIGpcuqU/epciSnQHRYoch41F
 BhiAkkjrco0n4EpESC+iZwEd+rV33mgFT+1ljUez53q0/7lygl7SVAfnafCXrESNMZag
 WY55BSJpR+dajKxQxpOgef7+6vW+RdZrI9ZCdM3mWpkLwp269jy0udgK4Cf5eukG1mSN FA== 
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3n7p1drwyx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Jan 2023 07:43:39 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30K0KahD003649;
        Fri, 20 Jan 2023 07:43:37 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
        by ppma05fra.de.ibm.com (PPS) with ESMTPS id 3n3m16dk60-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Jan 2023 07:43:37 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
        by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30K7hZMw35979604
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Jan 2023 07:43:35 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 384CC20043;
        Fri, 20 Jan 2023 07:43:35 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B0CA02004B;
        Fri, 20 Jan 2023 07:43:34 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
        by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 20 Jan 2023 07:43:34 +0000 (GMT)
Received: from jarvis-ozlabs-ibm-com.ozlabs.ibm.com (haven.au.ibm.com [9.192.254.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 0284060954;
        Fri, 20 Jan 2023 18:43:30 +1100 (AEDT)
From:   Andrew Donnellan <ajd@linux.ibm.com>
To:     linuxppc-dev@lists.ozlabs.org, linux-integrity@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, gcwilson@linux.ibm.com,
        linux-kernel@vger.kernel.org, nayna@linux.ibm.com,
        ruscur@russell.cc, zohar@linux.ibm.com, mpe@ellerman.id.au,
        gjoyce@linux.ibm.com, sudhakar@linux.ibm.com, bgray@linux.ibm.com,
        erichte@linux.ibm.com, joel@jms.id.au
Subject: [PATCH v4 12/24] powerpc/secvar: Don't print error on ENOENT when reading variables
Date:   Fri, 20 Jan 2023 18:42:54 +1100
Message-Id: <20230120074306.1326298-13-ajd@linux.ibm.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230120074306.1326298-1-ajd@linux.ibm.com>
References: <20230120074306.1326298-1-ajd@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: -y2bkWUupNMP6jiDJJn3BjdWY5ihTm_e
X-Proofpoint-GUID: -y2bkWUupNMP6jiDJJn3BjdWY5ihTm_e
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-20_04,2023-01-19_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 priorityscore=1501 impostorscore=0 spamscore=0 bulkscore=0 suspectscore=0
 mlxscore=0 mlxlogscore=999 clxscore=1015 phishscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301200070
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If attempting to read the size or data attributes of a  non-existent
variable (which will be possible after a later patch to expose the PLPKS
via the secvar interface), don't spam the kernel log with error messages.
Only print errors for return codes that aren't ENOENT.

Reported-by: Sudhakar Kuppusamy <sudhakar@linux.ibm.com>
Signed-off-by: Andrew Donnellan <ajd@linux.ibm.com>

---

v3: New patch
---
 arch/powerpc/kernel/secvar-sysfs.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/secvar-sysfs.c b/arch/powerpc/kernel/secvar-sysfs.c
index 6dd9b4f6f87c..33d1797851ba 100644
--- a/arch/powerpc/kernel/secvar-sysfs.c
+++ b/arch/powerpc/kernel/secvar-sysfs.c
@@ -43,8 +43,8 @@ static ssize_t size_show(struct kobject *kobj, struct kobj_attribute *attr,
 
 	rc = secvar_ops->get(kobj->name, strlen(kobj->name) + 1, NULL, &dsize);
 	if (rc) {
-		pr_err("Error retrieving %s variable size %d\n", kobj->name,
-		       rc);
+		if (rc != -ENOENT)
+			pr_err("Error retrieving %s variable size %d\n", kobj->name, rc);
 		return rc;
 	}
 
@@ -61,7 +61,8 @@ static ssize_t data_read(struct file *filep, struct kobject *kobj,
 
 	rc = secvar_ops->get(kobj->name, strlen(kobj->name) + 1, NULL, &dsize);
 	if (rc) {
-		pr_err("Error getting %s variable size %d\n", kobj->name, rc);
+		if (rc != -ENOENT)
+			pr_err("Error getting %s variable size %d\n", kobj->name, rc);
 		return rc;
 	}
 	pr_debug("dsize is %llu\n", dsize);
-- 
2.39.0

