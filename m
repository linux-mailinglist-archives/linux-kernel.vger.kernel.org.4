Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88BBC674E6D
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 08:44:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230419AbjATHoI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 02:44:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230206AbjATHnu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 02:43:50 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FE2B80B8E;
        Thu, 19 Jan 2023 23:43:48 -0800 (PST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30K6nbwk012329;
        Fri, 20 Jan 2023 07:43:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=IqqaNkGszMHZvB6PEm1qTf1UDr88EmlgNbzmmdZ7dNA=;
 b=kK78rxkBTyyCoY/fiw4UPuFLQhWpwMK9RrUt5BloGxz07ek/ynXCrZ6WwX9bnIz0ldkm
 AG8hu7gDSJLCCCmh5nK3whEH5jlziqq702wv+oM7cFJwVtRk8IY0l4Pz4PFc30b1dL9/
 nOsoVICkWcAofvSYRU1RgQt/JLTW+Roi8ywv790UnI80ZY2bqxrjeysDhh5MZWFhRcLB
 haj3fGMBlk05RM8oARAb10SDyCOMurzaoq99d0tc1l18nNcNhzS4X5VoqYU35IX8Afas
 a+wLjDKR+5F0xQVfXjEXFZ8AnZrqEy4KAeaiXxTvjcgkIQIus2u/Uw798aYQxpBnkEPA fA== 
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3n7p1e92gj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Jan 2023 07:43:40 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30JAGVtt011562;
        Fri, 20 Jan 2023 07:43:38 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
        by ppma01fra.de.ibm.com (PPS) with ESMTPS id 3n3m16dkgw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Jan 2023 07:43:38 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
        by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30K7hZ2e43581864
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Jan 2023 07:43:35 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A9BCC20043;
        Fri, 20 Jan 2023 07:43:35 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B357820049;
        Fri, 20 Jan 2023 07:43:34 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
        by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 20 Jan 2023 07:43:34 +0000 (GMT)
Received: from jarvis-ozlabs-ibm-com.ozlabs.ibm.com (haven.au.ibm.com [9.192.254.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 225536096E;
        Fri, 20 Jan 2023 18:43:30 +1100 (AEDT)
From:   Andrew Donnellan <ajd@linux.ibm.com>
To:     linuxppc-dev@lists.ozlabs.org, linux-integrity@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, gcwilson@linux.ibm.com,
        linux-kernel@vger.kernel.org, nayna@linux.ibm.com,
        ruscur@russell.cc, zohar@linux.ibm.com, mpe@ellerman.id.au,
        gjoyce@linux.ibm.com, sudhakar@linux.ibm.com, bgray@linux.ibm.com,
        erichte@linux.ibm.com, joel@jms.id.au
Subject: [PATCH v4 14/24] powerpc/pseries: Move PLPKS constants to header file
Date:   Fri, 20 Jan 2023 18:42:56 +1100
Message-Id: <20230120074306.1326298-15-ajd@linux.ibm.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230120074306.1326298-1-ajd@linux.ibm.com>
References: <20230120074306.1326298-1-ajd@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: bIhumNl2V8wa4m50eVadyq1LqAnzZIN7
X-Proofpoint-GUID: bIhumNl2V8wa4m50eVadyq1LqAnzZIN7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-20_04,2023-01-19_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 mlxscore=0 malwarescore=0 adultscore=0 bulkscore=0
 phishscore=0 priorityscore=1501 impostorscore=0 clxscore=1015
 mlxlogscore=999 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2301200070
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Russell Currey <ruscur@russell.cc>

Move the constants defined in plpks.c to plpks.h, and standardise their
naming, so that PLPKS consumers can make use of them later on.

Signed-off-by: Russell Currey <ruscur@russell.cc>
Co-developed-by: Andrew Donnellan <ajd@linux.ibm.com>
Signed-off-by: Andrew Donnellan <ajd@linux.ibm.com>

---

v3: New patch
---
 arch/powerpc/include/asm/plpks.h       | 36 +++++++++++++---
 arch/powerpc/platforms/pseries/plpks.c | 57 ++++++++++----------------
 2 files changed, 53 insertions(+), 40 deletions(-)

diff --git a/arch/powerpc/include/asm/plpks.h b/arch/powerpc/include/asm/plpks.h
index 8295502ee93b..6466aadd7145 100644
--- a/arch/powerpc/include/asm/plpks.h
+++ b/arch/powerpc/include/asm/plpks.h
@@ -14,14 +14,40 @@
 #include <linux/types.h>
 #include <linux/list.h>
 
-#define OSSECBOOTAUDIT 0x40000000
-#define OSSECBOOTENFORCE 0x20000000
-#define WORLDREADABLE 0x08000000
-#define SIGNEDUPDATE 0x01000000
+// Object policy flags from supported_policies
+#define PLPKS_OSSECBOOTAUDIT	PPC_BIT32(1) // OS secure boot must be audit/enforce
+#define PLPKS_OSSECBOOTENFORCE	PPC_BIT32(2) // OS secure boot must be enforce
+#define PLPKS_PWSET		PPC_BIT32(3) // No access without password set
+#define PLPKS_WORLDREADABLE	PPC_BIT32(4) // Readable without authentication
+#define PLPKS_IMMUTABLE		PPC_BIT32(5) // Once written, object cannot be removed
+#define PLPKS_TRANSIENT		PPC_BIT32(6) // Object does not persist through reboot
+#define PLPKS_SIGNEDUPDATE	PPC_BIT32(7) // Object can only be modified by signed updates
+#define PLPKS_HVPROVISIONED	PPC_BIT32(28) // Hypervisor has provisioned this object
 
-#define PLPKS_VAR_LINUX	0x02
+// Signature algorithm flags from signed_update_algorithms
+#define PLPKS_ALG_RSA2048	PPC_BIT(0)
+#define PLPKS_ALG_RSA4096	PPC_BIT(1)
+
+// Object label OS metadata flags
+#define PLPKS_VAR_LINUX		0x02
 #define PLPKS_VAR_COMMON	0x04
 
+// Flags for which consumer owns an object is owned by
+#define PLPKS_FW_OWNER			0x1
+#define PLPKS_BOOTLOADER_OWNER		0x2
+#define PLPKS_OS_OWNER			0x3
+
+// Flags for label metadata fields
+#define PLPKS_LABEL_VERSION		0
+#define PLPKS_MAX_LABEL_ATTR_SIZE	16
+#define PLPKS_MAX_NAME_SIZE		239
+#define PLPKS_MAX_DATA_SIZE		4000
+
+// Timeouts for PLPKS operations
+#define PLPKS_MAX_TIMEOUT		5000 // msec
+#define PLPKS_FLUSH_SLEEP		10 // msec
+#define PLPKS_FLUSH_SLEEP_RANGE		400
+
 struct plpks_var {
 	char *component;
 	u8 *name;
diff --git a/arch/powerpc/platforms/pseries/plpks.c b/arch/powerpc/platforms/pseries/plpks.c
index 13e6daadb179..91f3f623a2c7 100644
--- a/arch/powerpc/platforms/pseries/plpks.c
+++ b/arch/powerpc/platforms/pseries/plpks.c
@@ -20,19 +20,6 @@
 #include <asm/machdep.h>
 #include <asm/plpks.h>
 
-#define PKS_FW_OWNER	     0x1
-#define PKS_BOOTLOADER_OWNER 0x2
-#define PKS_OS_OWNER	     0x3
-
-#define LABEL_VERSION	    0
-#define MAX_LABEL_ATTR_SIZE 16
-#define MAX_NAME_SIZE	    239
-#define MAX_DATA_SIZE	    4000
-
-#define PKS_FLUSH_MAX_TIMEOUT 5000 //msec
-#define PKS_FLUSH_SLEEP	      10 //msec
-#define PKS_FLUSH_SLEEP_RANGE 400
-
 static u8 *ospassword;
 static u16 ospasswordlength;
 
@@ -59,7 +46,7 @@ struct label_attr {
 
 struct label {
 	struct label_attr attr;
-	u8 name[MAX_NAME_SIZE];
+	u8 name[PLPKS_MAX_NAME_SIZE];
 	size_t size;
 };
 
@@ -122,7 +109,7 @@ static int pseries_status_to_err(int rc)
 static int plpks_gen_password(void)
 {
 	unsigned long retbuf[PLPAR_HCALL_BUFSIZE] = { 0 };
-	u8 *password, consumer = PKS_OS_OWNER;
+	u8 *password, consumer = PLPKS_OS_OWNER;
 	int rc;
 
 	// The password must not cross a page boundary, so we align to the next power of 2
@@ -159,7 +146,7 @@ static struct plpks_auth *construct_auth(u8 consumer)
 {
 	struct plpks_auth *auth;
 
-	if (consumer > PKS_OS_OWNER)
+	if (consumer > PLPKS_OS_OWNER)
 		return ERR_PTR(-EINVAL);
 
 	// The auth structure must not cross a page boundary and must be
@@ -171,7 +158,7 @@ static struct plpks_auth *construct_auth(u8 consumer)
 	auth->version = 1;
 	auth->consumer = consumer;
 
-	if (consumer == PKS_FW_OWNER || consumer == PKS_BOOTLOADER_OWNER)
+	if (consumer == PLPKS_FW_OWNER || consumer == PLPKS_BOOTLOADER_OWNER)
 		return auth;
 
 	memcpy(auth->password, ospassword, ospasswordlength);
@@ -191,7 +178,7 @@ static struct label *construct_label(char *component, u8 varos, u8 *name,
 	struct label *label;
 	size_t slen;
 
-	if (!name || namelen > MAX_NAME_SIZE)
+	if (!name || namelen > PLPKS_MAX_NAME_SIZE)
 		return ERR_PTR(-EINVAL);
 
 	slen = strlen(component);
@@ -206,9 +193,9 @@ static struct label *construct_label(char *component, u8 varos, u8 *name,
 	if (component)
 		memcpy(&label->attr.prefix, component, slen);
 
-	label->attr.version = LABEL_VERSION;
+	label->attr.version = PLPKS_LABEL_VERSION;
 	label->attr.os = varos;
-	label->attr.length = MAX_LABEL_ATTR_SIZE;
+	label->attr.length = PLPKS_MAX_LABEL_ATTR_SIZE;
 	memcpy(&label->name, name, namelen);
 
 	label->size = sizeof(struct label_attr) + namelen;
@@ -274,10 +261,10 @@ static int plpks_confirm_object_flushed(struct label *label,
 			break;
 		}
 
-		usleep_range(PKS_FLUSH_SLEEP,
-			     PKS_FLUSH_SLEEP + PKS_FLUSH_SLEEP_RANGE);
-		timeout = timeout + PKS_FLUSH_SLEEP;
-	} while (timeout < PKS_FLUSH_MAX_TIMEOUT);
+		usleep_range(PLPKS_FLUSH_SLEEP,
+			     PLPKS_FLUSH_SLEEP + PLPKS_FLUSH_SLEEP_RANGE);
+		timeout = timeout + PLPKS_FLUSH_SLEEP;
+	} while (timeout < PLPKS_MAX_TIMEOUT);
 
 	if (timed_out)
 		return -ETIMEDOUT;
@@ -293,13 +280,13 @@ int plpks_write_var(struct plpks_var var)
 	int rc;
 
 	if (!var.component || !var.data || var.datalen <= 0 ||
-	    var.namelen > MAX_NAME_SIZE || var.datalen > MAX_DATA_SIZE)
+	    var.namelen > PLPKS_MAX_NAME_SIZE || var.datalen > PLPKS_MAX_DATA_SIZE)
 		return -EINVAL;
 
-	if (var.policy & SIGNEDUPDATE)
+	if (var.policy & PLPKS_SIGNEDUPDATE)
 		return -EINVAL;
 
-	auth = construct_auth(PKS_OS_OWNER);
+	auth = construct_auth(PLPKS_OS_OWNER);
 	if (IS_ERR(auth))
 		return PTR_ERR(auth);
 
@@ -331,10 +318,10 @@ int plpks_remove_var(char *component, u8 varos, struct plpks_var_name vname)
 	struct label *label;
 	int rc;
 
-	if (!component || vname.namelen > MAX_NAME_SIZE)
+	if (!component || vname.namelen > PLPKS_MAX_NAME_SIZE)
 		return -EINVAL;
 
-	auth = construct_auth(PKS_OS_OWNER);
+	auth = construct_auth(PLPKS_OS_OWNER);
 	if (IS_ERR(auth))
 		return PTR_ERR(auth);
 
@@ -366,14 +353,14 @@ static int plpks_read_var(u8 consumer, struct plpks_var *var)
 	u8 *output;
 	int rc;
 
-	if (var->namelen > MAX_NAME_SIZE)
+	if (var->namelen > PLPKS_MAX_NAME_SIZE)
 		return -EINVAL;
 
 	auth = construct_auth(consumer);
 	if (IS_ERR(auth))
 		return PTR_ERR(auth);
 
-	if (consumer == PKS_OS_OWNER) {
+	if (consumer == PLPKS_OS_OWNER) {
 		label = construct_label(var->component, var->os, var->name,
 					var->namelen);
 		if (IS_ERR(label)) {
@@ -388,7 +375,7 @@ static int plpks_read_var(u8 consumer, struct plpks_var *var)
 		goto out_free_label;
 	}
 
-	if (consumer == PKS_OS_OWNER)
+	if (consumer == PLPKS_OS_OWNER)
 		rc = plpar_hcall(H_PKS_READ_OBJECT, retbuf, virt_to_phys(auth),
 				 virt_to_phys(label), label->size, virt_to_phys(output),
 				 maxobjsize);
@@ -428,17 +415,17 @@ static int plpks_read_var(u8 consumer, struct plpks_var *var)
 
 int plpks_read_os_var(struct plpks_var *var)
 {
-	return plpks_read_var(PKS_OS_OWNER, var);
+	return plpks_read_var(PLPKS_OS_OWNER, var);
 }
 
 int plpks_read_fw_var(struct plpks_var *var)
 {
-	return plpks_read_var(PKS_FW_OWNER, var);
+	return plpks_read_var(PLPKS_FW_OWNER, var);
 }
 
 int plpks_read_bootloader_var(struct plpks_var *var)
 {
-	return plpks_read_var(PKS_BOOTLOADER_OWNER, var);
+	return plpks_read_var(PLPKS_BOOTLOADER_OWNER, var);
 }
 
 static __init int pseries_plpks_init(void)
-- 
2.39.0

