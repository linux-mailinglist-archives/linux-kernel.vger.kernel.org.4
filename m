Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7435671449
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 07:34:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbjARGeL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 01:34:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbjARGWB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 01:22:01 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8973F4DCE8;
        Tue, 17 Jan 2023 22:11:25 -0800 (PST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30I53VZX015774;
        Wed, 18 Jan 2023 06:11:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=DRGICz5yYX5ouSLzsb2m+IOnUfCQUEaW8DNMC5aDBh0=;
 b=M/sW6GcbgQSaca7+zvw5hj3nxpPsxydOd7RDE21uvZKHEvDnjiJFARDKidrFynpOO1HY
 A/4jv52qtJ7CjQTo5dIQwzl98BYw35V35oU9jWw84HQTg6AoDGCrpJULpH9y1cw+TvOp
 UOjEijuVqQ6q4cAtpPWK+Y3mc+hCXzSihfOV1PjXG2vVV09e1okqMMXf9nH0tLbbV/7r
 gc7frHrJ+eHvuvh/UvN40+8oJcyA0qUfy+gMfTqGZnb7RknwEILSoIF2W0iEKPKSov7q
 qHgp3AiYzmil9rt7xJfP6nkEqyyUH2NlWQOwe+bq62vVawbTiY2+N1psELWxfoxpaNP+ 0g== 
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3n6a9ph6uw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Jan 2023 06:11:15 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30HFpOI4013061;
        Wed, 18 Jan 2023 06:11:13 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
        by ppma04fra.de.ibm.com (PPS) with ESMTPS id 3n3m16kgv1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Jan 2023 06:11:13 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
        by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30I6BBLb47055260
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Jan 2023 06:11:11 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 068392004B;
        Wed, 18 Jan 2023 06:11:11 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1035B20040;
        Wed, 18 Jan 2023 06:11:10 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
        by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 18 Jan 2023 06:11:10 +0000 (GMT)
Received: from jarvis-ozlabs-ibm-com.ozlabs.ibm.com (haven.au.ibm.com [9.192.254.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 31B05605B2;
        Wed, 18 Jan 2023 17:11:08 +1100 (AEDT)
From:   Andrew Donnellan <ajd@linux.ibm.com>
To:     linuxppc-dev@lists.ozlabs.org, linux-integrity@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, gcwilson@linux.ibm.com,
        linux-kernel@vger.kernel.org, nayna@linux.ibm.com,
        ruscur@russell.cc, zohar@linux.ibm.com, mpe@ellerman.id.au,
        gjoyce@linux.ibm.com, sudhakar@linux.ibm.com, bgray@linux.ibm.com,
        erichte@linux.ibm.com
Subject: [PATCH v3 04/24] powerpc/secvar: Handle format string in the consumer
Date:   Wed, 18 Jan 2023 17:10:29 +1100
Message-Id: <20230118061049.1006141-5-ajd@linux.ibm.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230118061049.1006141-1-ajd@linux.ibm.com>
References: <20230118061049.1006141-1-ajd@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: dHpbS8Bs2MA0tlXWchLHCj224ertkAx0
X-Proofpoint-ORIG-GUID: dHpbS8Bs2MA0tlXWchLHCj224ertkAx0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-18_01,2023-01-17_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 mlxscore=0 phishscore=0 malwarescore=0 adultscore=0
 clxscore=1015 priorityscore=1501 impostorscore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2301180051
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Russell Currey <ruscur@russell.cc>

The code that handles the format string in secvar-sysfs.c is entirely
OPAL specific, so create a new "format" op in secvar_operations to make
the secvar code more generic.  No functional change.

Signed-off-by: Russell Currey <ruscur@russell.cc>
Signed-off-by: Andrew Donnellan <ajd@linux.ibm.com>

---

v2: Use sysfs_emit() instead of sprintf() (gregkh)

v3: Enforce format string size limit (ruscur)
---
 arch/powerpc/include/asm/secvar.h            |  3 +++
 arch/powerpc/kernel/secvar-sysfs.c           | 23 ++++--------------
 arch/powerpc/platforms/powernv/opal-secvar.c | 25 ++++++++++++++++++++
 3 files changed, 33 insertions(+), 18 deletions(-)

diff --git a/arch/powerpc/include/asm/secvar.h b/arch/powerpc/include/asm/secvar.h
index 07ba36f868a7..8b6475589120 100644
--- a/arch/powerpc/include/asm/secvar.h
+++ b/arch/powerpc/include/asm/secvar.h
@@ -11,12 +11,15 @@
 #include <linux/types.h>
 #include <linux/errno.h>
 
+#define SECVAR_MAX_FORMAT_LEN	30 // max length of string returned by ->format()
+
 extern const struct secvar_operations *secvar_ops;
 
 struct secvar_operations {
 	int (*get)(const char *key, u64 key_len, u8 *data, u64 *data_size);
 	int (*get_next)(const char *key, u64 *key_len, u64 keybufsize);
 	int (*set)(const char *key, u64 key_len, u8 *data, u64 data_size);
+	ssize_t (*format)(char *buf);
 };
 
 #ifdef CONFIG_PPC_SECURE_BOOT
diff --git a/arch/powerpc/kernel/secvar-sysfs.c b/arch/powerpc/kernel/secvar-sysfs.c
index 462cacc0ca60..d3858eedd72c 100644
--- a/arch/powerpc/kernel/secvar-sysfs.c
+++ b/arch/powerpc/kernel/secvar-sysfs.c
@@ -21,26 +21,13 @@ static struct kset *secvar_kset;
 static ssize_t format_show(struct kobject *kobj, struct kobj_attribute *attr,
 			   char *buf)
 {
-	ssize_t rc = 0;
-	struct device_node *node;
-	const char *format;
-
-	node = of_find_compatible_node(NULL, NULL, "ibm,secvar-backend");
-	if (!of_device_is_available(node)) {
-		rc = -ENODEV;
-		goto out;
-	}
+	char tmp[SECVAR_MAX_FORMAT_LEN];
+	ssize_t len = secvar_ops->format(tmp);
 
-	rc = of_property_read_string(node, "format", &format);
-	if (rc)
-		goto out;
+	if (len <= 0)
+		return -EIO;
 
-	rc = sysfs_emit(buf, "%s\n", format);
-
-out:
-	of_node_put(node);
-
-	return rc;
+	return sysfs_emit(buf, "%s\n", tmp);
 }
 
 
diff --git a/arch/powerpc/platforms/powernv/opal-secvar.c b/arch/powerpc/platforms/powernv/opal-secvar.c
index ef89861569e0..623c6839e66c 100644
--- a/arch/powerpc/platforms/powernv/opal-secvar.c
+++ b/arch/powerpc/platforms/powernv/opal-secvar.c
@@ -98,10 +98,35 @@ static int opal_set_variable(const char *key, u64 ksize, u8 *data, u64 dsize)
 	return opal_status_to_err(rc);
 }
 
+static ssize_t opal_secvar_format(char *buf)
+{
+	ssize_t rc = 0;
+	struct device_node *node;
+	const char *format;
+
+	node = of_find_compatible_node(NULL, NULL, "ibm,secvar-backend");
+	if (!of_device_is_available(node)) {
+		rc = -ENODEV;
+		goto out;
+	}
+
+	rc = of_property_read_string(node, "format", &format);
+	if (rc)
+		goto out;
+
+	rc = snprintf(buf, SECVAR_MAX_FORMAT_LEN, "%s", format);
+
+out:
+	of_node_put(node);
+
+	return rc;
+}
+
 static const struct secvar_operations opal_secvar_ops = {
 	.get = opal_get_variable,
 	.get_next = opal_get_next_variable,
 	.set = opal_set_variable,
+	.format = opal_secvar_format,
 };
 
 static int opal_secvar_probe(struct platform_device *pdev)
-- 
2.39.0

