Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B418674E6B
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 08:44:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230340AbjATHoG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 02:44:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230188AbjATHnu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 02:43:50 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F93C7E6BA;
        Thu, 19 Jan 2023 23:43:48 -0800 (PST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30K7Jm1Q028170;
        Fri, 20 Jan 2023 07:43:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=5gNfdhTcsLZsf246o2RpjEEusH6QTl70oDb5wKedPWU=;
 b=m0SK3FyxTQzHwkeA7t3aewtogzrN8hpO7j2mdbGCjG8mEIkYMAP4p+K6w14i4aJ6AHqq
 I3NZj7ol/hh6cx5rh6rJcMcrDYOfAeNvJNYSeboEStThxV6Dk8WRD0TKUvMV5VZqiMNR
 1V0dWib+ngZ8wvFmodObmfzvIsoKpoGa1X+fKXjTsVZv6B0nRlNTqltsx2W4b7faeBaE
 n0OYr/wfhRxhRqrOPDndqG2oakQhLoaux9+Sdo/zxqoxcurUfwcs7x/xNkrw4GAh+USG
 zRTWeCqC0fhXDICDfnKm2IsadejKlmMMWK7lGqvzAuQuNtkz/YfKcf/xHKK7Sm+lRX0I +Q== 
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3n7pfj8cjv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Jan 2023 07:43:40 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30JNR9ba007521;
        Fri, 20 Jan 2023 07:43:37 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
        by ppma04fra.de.ibm.com (PPS) with ESMTPS id 3n3m16nk1g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Jan 2023 07:43:37 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
        by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30K7hZML39125442
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Jan 2023 07:43:35 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 324CB2004F;
        Fri, 20 Jan 2023 07:43:35 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3DE0820043;
        Fri, 20 Jan 2023 07:43:34 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
        by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 20 Jan 2023 07:43:34 +0000 (GMT)
Received: from jarvis-ozlabs-ibm-com.ozlabs.ibm.com (haven.au.ibm.com [9.192.254.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.au.ibm.com (Postfix) with ESMTPSA id EE18A605F2;
        Fri, 20 Jan 2023 18:43:29 +1100 (AEDT)
From:   Andrew Donnellan <ajd@linux.ibm.com>
To:     linuxppc-dev@lists.ozlabs.org, linux-integrity@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, gcwilson@linux.ibm.com,
        linux-kernel@vger.kernel.org, nayna@linux.ibm.com,
        ruscur@russell.cc, zohar@linux.ibm.com, mpe@ellerman.id.au,
        gjoyce@linux.ibm.com, sudhakar@linux.ibm.com, bgray@linux.ibm.com,
        erichte@linux.ibm.com, joel@jms.id.au
Subject: [PATCH v4 10/24] powerpc/secvar: Allow backend to populate static list of variable names
Date:   Fri, 20 Jan 2023 18:42:52 +1100
Message-Id: <20230120074306.1326298-11-ajd@linux.ibm.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230120074306.1326298-1-ajd@linux.ibm.com>
References: <20230120074306.1326298-1-ajd@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: jJok9X8QG8eVljlj3-NMZW8GWgGeNElv
X-Proofpoint-GUID: jJok9X8QG8eVljlj3-NMZW8GWgGeNElv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-20_04,2023-01-19_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 mlxlogscore=999 phishscore=0 lowpriorityscore=0
 malwarescore=0 spamscore=0 adultscore=0 bulkscore=0 suspectscore=0
 clxscore=1015 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301200070
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
index 5ed141c711b0..467f83c24084 100644
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
index d7936d8c7478..e1d4c70dd327 100644
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
@@ -177,31 +199,26 @@ static int secvar_sysfs_load(void)
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
@@ -243,7 +260,15 @@ static int secvar_sysfs_init(void)
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

