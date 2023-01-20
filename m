Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3296674E88
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 08:45:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231162AbjATHpR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 02:45:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230382AbjATHom (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 02:44:42 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EA9D7DF95;
        Thu, 19 Jan 2023 23:44:03 -0800 (PST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30K5ncDV025122;
        Fri, 20 Jan 2023 07:43:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=Te5YU6YGvqU5K6+sZoUFCjko+4aelRmhWa/p/mRpz/s=;
 b=U1I2H1UkogVHlm6EbSeXSCrFIY4+J4zCBjFIL8rrPtIHqi0XwE4CU3j5B8f/5zBJUzqR
 5zoojB+Z6boC59CJP2++Xkja9OeRC7wFEk9kr7jlfHUBzeRQW4/rkala6xnENsXTytVF
 e2jde0gW9NjxCN+9V2b4j3AF3GSF2uhLRaS5vbBcY48HbDIrVE63E36Cgw2vOlQJQrMC
 xRUYehjrDfLjPWvD5m2nn2FdqwRZwxalHlbZkbVv5mSqwAxaDi3y64ePK8M1Ij9la6vG
 BbKfT7CzMP+bjTt/3k2CAFFhjA0bRzSb6PIGtfmrI7uaolvkbpUXEKxkrTmxpHAgGTxU Vg== 
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3n7n5b23ru-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Jan 2023 07:43:39 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30K2ZGbm027441;
        Fri, 20 Jan 2023 07:43:37 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
        by ppma06fra.de.ibm.com (PPS) with ESMTPS id 3n3knfdkrg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Jan 2023 07:43:37 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
        by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30K7hZ7o42992080
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Jan 2023 07:43:35 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2B3F22004E;
        Fri, 20 Jan 2023 07:43:35 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 36D0F20040;
        Fri, 20 Jan 2023 07:43:34 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
        by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 20 Jan 2023 07:43:34 +0000 (GMT)
Received: from jarvis-ozlabs-ibm-com.ozlabs.ibm.com (haven.au.ibm.com [9.192.254.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.au.ibm.com (Postfix) with ESMTPSA id D4A09605AB;
        Fri, 20 Jan 2023 18:43:29 +1100 (AEDT)
From:   Andrew Donnellan <ajd@linux.ibm.com>
To:     linuxppc-dev@lists.ozlabs.org, linux-integrity@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, gcwilson@linux.ibm.com,
        linux-kernel@vger.kernel.org, nayna@linux.ibm.com,
        ruscur@russell.cc, zohar@linux.ibm.com, mpe@ellerman.id.au,
        gjoyce@linux.ibm.com, sudhakar@linux.ibm.com, bgray@linux.ibm.com,
        erichte@linux.ibm.com, joel@jms.id.au
Subject: [PATCH v4 07/24] powerpc/secvar: Handle max object size in the consumer
Date:   Fri, 20 Jan 2023 18:42:49 +1100
Message-Id: <20230120074306.1326298-8-ajd@linux.ibm.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230120074306.1326298-1-ajd@linux.ibm.com>
References: <20230120074306.1326298-1-ajd@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: qiEwPYUdPPMhq_6V6tbDj8WTGinipoqJ
X-Proofpoint-ORIG-GUID: qiEwPYUdPPMhq_6V6tbDj8WTGinipoqJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-20_04,2023-01-19_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1015
 spamscore=0 adultscore=0 priorityscore=1501 bulkscore=0 mlxlogscore=999
 impostorscore=0 suspectscore=0 lowpriorityscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301200070
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Russell Currey <ruscur@russell.cc>

Currently the max object size is handled in the core secvar code with an
entirely OPAL-specific implementation, so create a new max_size() op and
move the existing implementation into the powernv platform.  Should be
no functional change.

Signed-off-by: Russell Currey <ruscur@russell.cc>
Signed-off-by: Andrew Donnellan <ajd@linux.ibm.com>

---

v3: Change uint64_t type to u64 (mpe)

v4: Return immediately if node is NULL (gjoyce)
---
 arch/powerpc/include/asm/secvar.h            |  1 +
 arch/powerpc/kernel/secvar-sysfs.c           | 17 +++------------
 arch/powerpc/platforms/powernv/opal-secvar.c | 22 ++++++++++++++++++++
 3 files changed, 26 insertions(+), 14 deletions(-)

diff --git a/arch/powerpc/include/asm/secvar.h b/arch/powerpc/include/asm/secvar.h
index 2d9816dff128..b97ab793cc8a 100644
--- a/arch/powerpc/include/asm/secvar.h
+++ b/arch/powerpc/include/asm/secvar.h
@@ -18,6 +18,7 @@ struct secvar_operations {
 	int (*get_next)(const char *key, u64 *key_len, u64 keybufsize);
 	int (*set)(const char *key, u64 key_len, u8 *data, u64 data_size);
 	ssize_t (*format)(char *buf, size_t bufsize);
+	int (*max_size)(u64 *max_size);
 };
 
 #ifdef CONFIG_PPC_SECURE_BOOT
diff --git a/arch/powerpc/kernel/secvar-sysfs.c b/arch/powerpc/kernel/secvar-sysfs.c
index 4beec935f5e7..d2f65a67845c 100644
--- a/arch/powerpc/kernel/secvar-sysfs.c
+++ b/arch/powerpc/kernel/secvar-sysfs.c
@@ -132,27 +132,16 @@ static struct kobj_type secvar_ktype = {
 static int update_kobj_size(void)
 {
 
-	struct device_node *node;
 	u64 varsize;
-	int rc = 0;
+	int rc = secvar_ops->max_size(&varsize);
 
-	node = of_find_compatible_node(NULL, NULL, "ibm,secvar-backend");
-	if (!of_device_is_available(node)) {
-		rc = -ENODEV;
-		goto out;
-	}
-
-	rc = of_property_read_u64(node, "max-var-size", &varsize);
 	if (rc)
-		goto out;
+		return rc;
 
 	data_attr.size = varsize;
 	update_attr.size = varsize;
 
-out:
-	of_node_put(node);
-
-	return rc;
+	return 0;
 }
 
 static int secvar_sysfs_load(void)
diff --git a/arch/powerpc/platforms/powernv/opal-secvar.c b/arch/powerpc/platforms/powernv/opal-secvar.c
index e33bb703ecbc..a8436bf35e2f 100644
--- a/arch/powerpc/platforms/powernv/opal-secvar.c
+++ b/arch/powerpc/platforms/powernv/opal-secvar.c
@@ -122,11 +122,33 @@ static ssize_t opal_secvar_format(char *buf, size_t bufsize)
 	return rc;
 }
 
+static int opal_secvar_max_size(u64 *max_size)
+{
+	int rc;
+	struct device_node *node;
+
+	node = of_find_compatible_node(NULL, NULL, "ibm,secvar-backend");
+	if (!node)
+		return -ENODEV;
+
+	if (!of_device_is_available(node)) {
+		rc = -ENODEV;
+		goto out;
+	}
+
+	rc = of_property_read_u64(node, "max-var-size", max_size);
+
+out:
+	of_node_put(node);
+	return rc;
+}
+
 static const struct secvar_operations opal_secvar_ops = {
 	.get = opal_get_variable,
 	.get_next = opal_get_next_variable,
 	.set = opal_set_variable,
 	.format = opal_secvar_format,
+	.max_size = opal_secvar_max_size,
 };
 
 static int opal_secvar_probe(struct platform_device *pdev)
-- 
2.39.0

