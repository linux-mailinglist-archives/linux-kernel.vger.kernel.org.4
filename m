Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 461C56824B6
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 07:41:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231431AbjAaGlZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 01:41:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230377AbjAaGkc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 01:40:32 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55DE73D08E;
        Mon, 30 Jan 2023 22:40:30 -0800 (PST)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30V5uasq010286;
        Tue, 31 Jan 2023 06:40:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=N2R3GvZB0FDC5VCJfoPIgMLQTlamhuK00RoCluA8iqA=;
 b=lha88JHRU3hXl9nGPcNZ7KIFu99hVn3loeJewD6UR8UEazBSmRc7fKda4diMH8l9Qs7O
 g2D5DvppWXrUihXSKakI4mI0ETC8kk3RfM1jpJFAi5mlrGJnjOWkkttJO00hDW8kOzOj
 NMIYVBQ+ppd6q17UI3FKYD0AVH7B2IBSqdoiMrd+ROOmgt8wtJ34PMerJIqozFhDFF7s
 8rpWJ5Kjrh5FfkeAXR9U95WEeIXXgp9h5NHuHQRHZNfK1+BcNlS5Y5kHeqVP64P1O588
 8DKIvTxu9QB77Nuj/lzM9I2YeseDKhGiWjp1IP9sNOsyybUrMvxNDG5vM5CRZVR5w/xg hw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3new9kgtgc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Jan 2023 06:40:15 +0000
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 30V6TtVv001270;
        Tue, 31 Jan 2023 06:40:15 GMT
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3new9kgtey-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Jan 2023 06:40:15 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30V3LI8D025083;
        Tue, 31 Jan 2023 06:40:12 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
        by ppma02fra.de.ibm.com (PPS) with ESMTPS id 3ncvv6a7dr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Jan 2023 06:40:12 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
        by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30V6e9ph46006688
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 31 Jan 2023 06:40:10 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D073F20043;
        Tue, 31 Jan 2023 06:40:09 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D2B3E2004D;
        Tue, 31 Jan 2023 06:40:08 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
        by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 31 Jan 2023 06:40:08 +0000 (GMT)
Received: from jarvis-ozlabs-ibm-com.au.ibm.com (unknown [9.192.255.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 8EB0060953;
        Tue, 31 Jan 2023 17:40:04 +1100 (AEDT)
From:   Andrew Donnellan <ajd@linux.ibm.com>
To:     linuxppc-dev@lists.ozlabs.org, linux-integrity@vger.kernel.org
Cc:     ruscur@russell.cc, bgray@linux.ibm.com, nayna@linux.ibm.com,
        gcwilson@linux.ibm.com, gjoyce@linux.ibm.com, brking@linux.ibm.com,
        stefanb@linux.ibm.com, sudhakar@linux.ibm.com,
        erichte@linux.ibm.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, zohar@linux.ibm.com, joel@jms.id.au,
        npiggin@gmail.com
Subject: [PATCH v5 11/25] powerpc/secvar: Allow backend to populate static list of variable names
Date:   Tue, 31 Jan 2023 17:39:14 +1100
Message-Id: <20230131063928.388035-12-ajd@linux.ibm.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230131063928.388035-1-ajd@linux.ibm.com>
References: <20230131063928.388035-1-ajd@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: lwq7PiogdUrvPFkOtxejUs08LyAT8Ocb
X-Proofpoint-GUID: e7nCQbyZgrdtXeiTDEX2zWKdoPjuGwQS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-31_02,2023-01-30_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0 mlxscore=0
 clxscore=1015 priorityscore=1501 impostorscore=0 mlxlogscore=999
 spamscore=0 suspectscore=0 malwarescore=0 adultscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301310059
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
index 011a53a8076c..4828e0ab7e3c 100644
--- a/arch/powerpc/include/asm/secvar.h
+++ b/arch/powerpc/include/asm/secvar.h
@@ -21,6 +21,10 @@ struct secvar_operations {
 	ssize_t (*format)(char *buf, size_t bufsize);
 	int (*max_size)(u64 *max_size);
 	const struct attribute **config_attrs;
+
+	// NULL-terminated array of fixed variable names
+	// Only used if get_next() isn't provided
+	const char * const *var_names;
 };
 
 #ifdef CONFIG_PPC_SECURE_BOOT
diff --git a/arch/powerpc/kernel/secvar-sysfs.c b/arch/powerpc/kernel/secvar-sysfs.c
index 7df32be86507..2cbc60b37e4e 100644
--- a/arch/powerpc/kernel/secvar-sysfs.c
+++ b/arch/powerpc/kernel/secvar-sysfs.c
@@ -157,9 +157,31 @@ static int secvar_sysfs_config(struct kobject *kobj)
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
@@ -179,31 +201,26 @@ static int secvar_sysfs_load(void)
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
@@ -245,7 +262,15 @@ static int secvar_sysfs_init(void)
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
2.39.1

