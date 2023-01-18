Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3BAF671454
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 07:35:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbjARGfD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 01:35:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjARGWE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 01:22:04 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20E484DCEC;
        Tue, 17 Jan 2023 22:11:26 -0800 (PST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30I53UtB015732;
        Wed, 18 Jan 2023 06:11:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=gSeb7p+nI+cvgpG3tJb8/8BacKZihHB01aYKrRWv7OI=;
 b=b0qNG6meX11LViiz4h5xJlfO0i6h1PeyqK6IQSWROlreU6PM30vmMg6ZXOfi5PTQu6Ef
 4AwQogp5B7K7tp7dU4lXjrSvFSPaWl9zp97ISY6PDQwGsXoRgIeQhpa7z7eSMO4hrHd0
 YfWOVwHXXNOcN5LnOjMhc6Ng/NCOSB6zkNN2kJc9UNmi2HpZtOLYgCXoQUKLQKymIrq2
 R6Om86dECN7daHmEE49f4U2zWPxl+QiVbrgnmULAC4qKbkvS6xFhk+8GcJfGxzfcGilr
 bduIJNAlMwomke3X5wrJ0xctSQNyXh0fyMBQjlnuXwML3zcn3driOdC3VOSmorcVW1rH jA== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3n6a9ph6w2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Jan 2023 06:11:17 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30HM36Aq007923;
        Wed, 18 Jan 2023 06:11:15 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
        by ppma06ams.nl.ibm.com (PPS) with ESMTPS id 3n3knfmtkh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Jan 2023 06:11:15 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
        by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30I6BD2l48366020
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Jan 2023 06:11:13 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 540862004B;
        Wed, 18 Jan 2023 06:11:13 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 606FF20040;
        Wed, 18 Jan 2023 06:11:12 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
        by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 18 Jan 2023 06:11:12 +0000 (GMT)
Received: from jarvis-ozlabs-ibm-com.ozlabs.ibm.com (haven.au.ibm.com [9.192.254.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 4D896605F3;
        Wed, 18 Jan 2023 17:11:08 +1100 (AEDT)
From:   Andrew Donnellan <ajd@linux.ibm.com>
To:     linuxppc-dev@lists.ozlabs.org, linux-integrity@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, gcwilson@linux.ibm.com,
        linux-kernel@vger.kernel.org, nayna@linux.ibm.com,
        ruscur@russell.cc, zohar@linux.ibm.com, mpe@ellerman.id.au,
        gjoyce@linux.ibm.com, sudhakar@linux.ibm.com, bgray@linux.ibm.com,
        erichte@linux.ibm.com
Subject: [PATCH v3 08/24] powerpc/secvar: Allow backend to populate static list of variable names
Date:   Wed, 18 Jan 2023 17:10:33 +1100
Message-Id: <20230118061049.1006141-9-ajd@linux.ibm.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230118061049.1006141-1-ajd@linux.ibm.com>
References: <20230118061049.1006141-1-ajd@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: zVPVTZzltHGxRihbg8CIp5WqLNp44g_V
X-Proofpoint-ORIG-GUID: zVPVTZzltHGxRihbg8CIp5WqLNp44g_V
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

Currently, the list of variables is populated by calling
secvar_ops->get_next() repeatedly, which is explicitly modelled on the
OPAL API (including the keylen parameter).

For the upcoming PLPKS backend, we have a static list of variable names.
It is messy to fit that into get_next(), so instead, let the backend put
a NULL-terminated array of variable names into secvar_ops->var_names,
which will be used if get_next() is undefined.

Signed-off-by: Andrew Donnellan <ajd@linux.ibm.com>
Signed-off-by: Russell Currey <ruscur@russell.cc>

---

v3: New patch (ajd/mpe)
---
 arch/powerpc/include/asm/secvar.h  |  4 ++
 arch/powerpc/kernel/secvar-sysfs.c | 67 ++++++++++++++++++++----------
 2 files changed, 50 insertions(+), 21 deletions(-)

diff --git a/arch/powerpc/include/asm/secvar.h b/arch/powerpc/include/asm/secvar.h
index ebf95386d720..c8bee1834b54 100644
--- a/arch/powerpc/include/asm/secvar.h
+++ b/arch/powerpc/include/asm/secvar.h
@@ -23,6 +23,10 @@ struct secvar_operations {
 	ssize_t (*format)(char *buf);
 	int (*max_size)(u64 *max_size);
 	const struct attribute **config_attrs;
+
+	// NULL-terminated array of fixed variable names
+	// Only used if get_next() isn't provided
+	const char * const *var_names;
 };
 
 #ifdef CONFIG_PPC_SECURE_BOOT
diff --git a/arch/powerpc/kernel/secvar-sysfs.c b/arch/powerpc/kernel/secvar-sysfs.c
index b82e95a2e415..d9352d4be87b 100644
--- a/arch/powerpc/kernel/secvar-sysfs.c
+++ b/arch/powerpc/kernel/secvar-sysfs.c
@@ -153,9 +153,31 @@ static int secvar_sysfs_config(struct kobject *kobj)
 	return 0;
 }
 
-static int secvar_sysfs_load(void)
+static int add_var(const char *name)
 {
 	struct kobject *kobj;
+	int rc;
+
+	kobj = kzalloc(sizeof(*kobj), GFP_KERNEL);
+	if (!kobj)
+		return -ENOMEM;
+
+	kobject_init(kobj, &secvar_ktype);
+
+	rc = kobject_add(kobj, &secvar_kset->kobj, "%s", name);
+	if (rc) {
+		pr_warn("kobject_add error %d for attribute: %s\n", rc,
+			name);
+		kobject_put(kobj);
+		return rc;
+	}
+
+	kobject_uevent(kobj, KOBJ_ADD);
+	return 0;
+}
+
+static int secvar_sysfs_load(void)
+{
 	u64 namesize = 0;
 	char *name;
 	int rc;
@@ -173,31 +195,26 @@ static int secvar_sysfs_load(void)
 			break;
 		}
 
-		kobj = kzalloc(sizeof(*kobj), GFP_KERNEL);
-		if (!kobj) {
-			rc = -ENOMEM;
-			break;
-		}
-
-		kobject_init(kobj, &secvar_ktype);
-
-		rc = kobject_add(kobj, &secvar_kset->kobj, "%s", name);
-		if (rc) {
-			pr_warn("kobject_add error %d for attribute: %s\n", rc,
-				name);
-			kobject_put(kobj);
-			kobj = NULL;
-		}
-
-		if (kobj)
-			kobject_uevent(kobj, KOBJ_ADD);
-
+		rc = add_var(name);
 	} while (!rc);
 
 	kfree(name);
 	return rc;
 }
 
+static int secvar_sysfs_load_static(void)
+{
+	const char * const *name_ptr = secvar_ops->var_names;
+	int rc;
+	while (*name_ptr) {
+		rc = add_var(*name_ptr);
+		if (rc)
+			return rc;
+		name_ptr++;
+	}
+	return 0;
+}
+
 static int secvar_sysfs_init(void)
 {
 	int rc;
@@ -239,7 +256,15 @@ static int secvar_sysfs_init(void)
 		goto err;
 	}
 
-	secvar_sysfs_load();
+	if (secvar_ops->get_next)
+		rc = secvar_sysfs_load();
+	else
+		rc = secvar_sysfs_load_static();
+
+	if (rc) {
+		pr_err("Failed to create variable attributes\n");
+		goto err;
+	}
 
 	return 0;
 err:
-- 
2.39.0

