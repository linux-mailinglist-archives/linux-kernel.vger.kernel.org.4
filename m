Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8E1A674E80
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 08:44:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231135AbjATHom (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 02:44:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230223AbjATHnv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 02:43:51 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF33A7DFAD;
        Thu, 19 Jan 2023 23:43:49 -0800 (PST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30K6nVcJ012193;
        Fri, 20 Jan 2023 07:43:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=9prdjajQNkVKI8t/9K1zOS6ovteYwDz+UuInU72mFd4=;
 b=UidKZLfgK3K7+4pC1EtdtdVce2E8/or4zBuPDiIwTAGAEs0gxjv4Ovm24kuOA0LKGe7Y
 QrQuS7aPTndn+/jSEhyG0lFWkGBVhBa1odwb84Csqa8zScMvIGedgdp+QORMTZXoyJHR
 kP47SzBFgjdwHbQ2Yr8YJEF6c+xlaBu6NxbN//u38oYATOmKM9DM4bXnAdO3kcNWf8w9
 4Up/N+RdFVEQ8M2nmVQsilsXh0iYtnpD44u39hwNxDhPhR6zTSyoepfKOOaCQjzwdTsw
 zCWD4L9Sh4dKYaR3G3FG2JRstYF0wrZC4wilgf4wHzTW+Mw1EJ1VmJNkG4WZgmCM6pmh HQ== 
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3n7p1e92gw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Jan 2023 07:43:41 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30K3Pmve010967;
        Fri, 20 Jan 2023 07:43:39 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma05fra.de.ibm.com (PPS) with ESMTPS id 3n3m16dk62-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Jan 2023 07:43:39 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30K7haFh23986840
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Jan 2023 07:43:36 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9564C2004E;
        Fri, 20 Jan 2023 07:43:36 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A071420043;
        Fri, 20 Jan 2023 07:43:35 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
        by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 20 Jan 2023 07:43:35 +0000 (GMT)
Received: from jarvis-ozlabs-ibm-com.ozlabs.ibm.com (haven.au.ibm.com [9.192.254.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 2DF566097C;
        Fri, 20 Jan 2023 18:43:30 +1100 (AEDT)
From:   Andrew Donnellan <ajd@linux.ibm.com>
To:     linuxppc-dev@lists.ozlabs.org, linux-integrity@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, gcwilson@linux.ibm.com,
        linux-kernel@vger.kernel.org, nayna@linux.ibm.com,
        ruscur@russell.cc, zohar@linux.ibm.com, mpe@ellerman.id.au,
        gjoyce@linux.ibm.com, sudhakar@linux.ibm.com, bgray@linux.ibm.com,
        erichte@linux.ibm.com, joel@jms.id.au
Subject: [PATCH v4 16/24] powerpc/pseries: Implement signed update for PLPKS objects
Date:   Fri, 20 Jan 2023 18:42:58 +1100
Message-Id: <20230120074306.1326298-17-ajd@linux.ibm.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230120074306.1326298-1-ajd@linux.ibm.com>
References: <20230120074306.1326298-1-ajd@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: oiM3uiDz2LqTpUi-PdMzmA06D0C13yWM
X-Proofpoint-GUID: oiM3uiDz2LqTpUi-PdMzmA06D0C13yWM
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

From: Nayna Jain <nayna@linux.ibm.com>

The Platform Keystore provides a signed update interface which can be used
to create, replace or append to certain variables in the PKS in a secure
fashion, with the hypervisor requiring that the update be signed using the
Platform Key.

Implement an interface to the H_PKS_SIGNED_UPDATE hcall in the plpks
driver to allow signed updates to PKS objects.

(The plpks driver doesn't need to do any cryptography or otherwise handle
the actual signed variable contents - that will be handled by userspace
tooling.)

Signed-off-by: Nayna Jain <nayna@linux.ibm.com>
[ajd: split patch, add timeout handling and misc cleanups]
Co-developed-by: Andrew Donnellan <ajd@linux.ibm.com>
Signed-off-by: Andrew Donnellan <ajd@linux.ibm.com>
Signed-off-by: Russell Currey <ruscur@russell.cc>

---

v3: Merge plpks fixes and signed update series with secvar series

    Fix error code handling in plpks_confirm_object_flushed() (ruscur)

    Pass plpks_var struct to plpks_signed_update_var() by reference (mpe)

    Consistent constant naming scheme (ruscur)

v4: Fix MAX_HCALL_OPCODE rebasing issue (npiggin)
---
 arch/powerpc/include/asm/hvcall.h      |  1 +
 arch/powerpc/include/asm/plpks.h       |  5 ++
 arch/powerpc/platforms/pseries/plpks.c | 71 ++++++++++++++++++++++++--
 3 files changed, 72 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/include/asm/hvcall.h b/arch/powerpc/include/asm/hvcall.h
index 95fd7f9485d5..c099780385dd 100644
--- a/arch/powerpc/include/asm/hvcall.h
+++ b/arch/powerpc/include/asm/hvcall.h
@@ -335,6 +335,7 @@
 #define H_RPT_INVALIDATE	0x448
 #define H_SCM_FLUSH		0x44C
 #define H_GET_ENERGY_SCALE_INFO	0x450
+#define H_PKS_SIGNED_UPDATE	0x454
 #define H_WATCHDOG		0x45C
 #define MAX_HCALL_OPCODE	H_WATCHDOG
 
diff --git a/arch/powerpc/include/asm/plpks.h b/arch/powerpc/include/asm/plpks.h
index 7c5f51a9af7c..e7204e6c0ca4 100644
--- a/arch/powerpc/include/asm/plpks.h
+++ b/arch/powerpc/include/asm/plpks.h
@@ -68,6 +68,11 @@ struct plpks_var_name_list {
 	struct plpks_var_name varlist[];
 };
 
+/**
+ * Updates the authenticated variable. It expects NULL as the component.
+ */
+int plpks_signed_update_var(struct plpks_var *var, u64 flags);
+
 /**
  * Writes the specified var and its data to PKS.
  * Any caller of PKS driver should present a valid component type for
diff --git a/arch/powerpc/platforms/pseries/plpks.c b/arch/powerpc/platforms/pseries/plpks.c
index 1189246b03dc..796ed5544ee5 100644
--- a/arch/powerpc/platforms/pseries/plpks.c
+++ b/arch/powerpc/platforms/pseries/plpks.c
@@ -81,6 +81,12 @@ static int pseries_status_to_err(int rc)
 		err = -ENOENT;
 		break;
 	case H_BUSY:
+	case H_LONG_BUSY_ORDER_1_MSEC:
+	case H_LONG_BUSY_ORDER_10_MSEC:
+	case H_LONG_BUSY_ORDER_100_MSEC:
+	case H_LONG_BUSY_ORDER_1_SEC:
+	case H_LONG_BUSY_ORDER_10_SEC:
+	case H_LONG_BUSY_ORDER_100_SEC:
 		err = -EBUSY;
 		break;
 	case H_AUTHORITY:
@@ -184,14 +190,17 @@ static struct label *construct_label(char *component, u8 varos, u8 *name,
 				     u16 namelen)
 {
 	struct label *label;
-	size_t slen;
+	size_t slen = 0;
 
 	if (!name || namelen > PLPKS_MAX_NAME_SIZE)
 		return ERR_PTR(-EINVAL);
 
-	slen = strlen(component);
-	if (component && slen > sizeof(label->attr.prefix))
-		return ERR_PTR(-EINVAL);
+	// Support NULL component for signed updates
+	if (component) {
+		slen = strlen(component);
+		if (slen > sizeof(label->attr.prefix))
+			return ERR_PTR(-EINVAL);
+	}
 
 	// The label structure must not cross a page boundary, so we align to the next power of 2
 	label = kzalloc(roundup_pow_of_two(sizeof(*label)), GFP_KERNEL);
@@ -397,6 +406,58 @@ static int plpks_confirm_object_flushed(struct label *label,
 	return pseries_status_to_err(rc);
 }
 
+int plpks_signed_update_var(struct plpks_var *var, u64 flags)
+{
+	unsigned long retbuf[PLPAR_HCALL9_BUFSIZE] = {0};
+	int rc;
+	struct label *label;
+	struct plpks_auth *auth;
+	u64 continuetoken = 0;
+	u64 timeout = 0;
+
+	if (!var->data || var->datalen <= 0 || var->namelen > PLPKS_MAX_NAME_SIZE)
+		return -EINVAL;
+
+	if (!(var->policy & PLPKS_SIGNEDUPDATE))
+		return -EINVAL;
+
+	auth = construct_auth(PLPKS_OS_OWNER);
+	if (IS_ERR(auth))
+		return PTR_ERR(auth);
+
+	label = construct_label(var->component, var->os, var->name, var->namelen);
+	if (IS_ERR(label)) {
+		rc = PTR_ERR(label);
+		goto out;
+	}
+
+	do {
+		rc = plpar_hcall9(H_PKS_SIGNED_UPDATE, retbuf,
+				  virt_to_phys(auth), virt_to_phys(label),
+				  label->size, var->policy, flags,
+				  virt_to_phys(var->data), var->datalen,
+				  continuetoken);
+
+		continuetoken = retbuf[0];
+		if (pseries_status_to_err(rc) == -EBUSY) {
+			int delay_ms = get_longbusy_msecs(rc);
+			mdelay(delay_ms);
+			timeout += delay_ms;
+		}
+		rc = pseries_status_to_err(rc);
+	} while (rc == -EBUSY && timeout < PLPKS_MAX_TIMEOUT);
+
+	if (!rc)
+		rc = plpks_confirm_object_flushed(label, auth);
+
+	kfree(label);
+out:
+	kfree(auth);
+
+	return rc;
+}
+EXPORT_SYMBOL(plpks_signed_update_var);
+
 int plpks_write_var(struct plpks_var var)
 {
 	unsigned long retbuf[PLPAR_HCALL_BUFSIZE] = { 0 };
@@ -443,7 +504,7 @@ int plpks_remove_var(char *component, u8 varos, struct plpks_var_name vname)
 	struct label *label;
 	int rc;
 
-	if (!component || vname.namelen > PLPKS_MAX_NAME_SIZE)
+	if (vname.namelen > PLPKS_MAX_NAME_SIZE)
 		return -EINVAL;
 
 	auth = construct_auth(PLPKS_OS_OWNER);
-- 
2.39.0

