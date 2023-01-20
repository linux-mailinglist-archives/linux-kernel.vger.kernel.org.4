Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDA30674E81
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 08:44:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231190AbjATHos (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 02:44:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230230AbjATHnw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 02:43:52 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B8FF8534C;
        Thu, 19 Jan 2023 23:43:50 -0800 (PST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30K7FTbe019105;
        Fri, 20 Jan 2023 07:43:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=8c18rBNboK0RzdDZn2KmS5/NWvIPHXsZKyiDvxnuutI=;
 b=IwA9pu6CZ1aetF6b0S/VMUNDcHiFk+TB8/+Yjpe819rWW7MPX0hPiPvchJlKzA7wQtRz
 irjh9GhNF85GyJAh0WtV1CncKnHgbYUVwccKN6TWp7TKNDqY6itvxHY84I6mmcBrHCf+
 r4TQ3cXAf//6kbwmbTJlxaP3SRWqzNvMGvh09k4bqoF7ksFE+ez9bTvIElaL7v6XoKbX
 hmjdh/rJY52sAtdtjcxQck5SpzNqm/PRKTn+/AxhS275438pPIWP+cx+TfNYS6pjsGAz
 Nh79t5fn4jsyMfwlPdKtWAl5HQobxGiMzQj9qhgp0+IndEVmcPRf9Gx9Yi0KSZLfkVD4 Tg== 
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3n7pdkrhvf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Jan 2023 07:43:41 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30JAbaj5027150;
        Fri, 20 Jan 2023 07:43:39 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
        by ppma02fra.de.ibm.com (PPS) with ESMTPS id 3n3m16njj8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Jan 2023 07:43:39 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
        by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30K7hbKH38535522
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Jan 2023 07:43:37 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0DBEC20040;
        Fri, 20 Jan 2023 07:43:37 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 19FEE20043;
        Fri, 20 Jan 2023 07:43:36 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
        by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 20 Jan 2023 07:43:36 +0000 (GMT)
Received: from jarvis-ozlabs-ibm-com.ozlabs.ibm.com (haven.au.ibm.com [9.192.254.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 51805609BE;
        Fri, 20 Jan 2023 18:43:30 +1100 (AEDT)
From:   Andrew Donnellan <ajd@linux.ibm.com>
To:     linuxppc-dev@lists.ozlabs.org, linux-integrity@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, gcwilson@linux.ibm.com,
        linux-kernel@vger.kernel.org, nayna@linux.ibm.com,
        ruscur@russell.cc, zohar@linux.ibm.com, mpe@ellerman.id.au,
        gjoyce@linux.ibm.com, sudhakar@linux.ibm.com, bgray@linux.ibm.com,
        erichte@linux.ibm.com, joel@jms.id.au
Subject: [PATCH v4 21/24] powerpc/pseries: Pass PLPKS password on kexec
Date:   Fri, 20 Jan 2023 18:43:03 +1100
Message-Id: <20230120074306.1326298-22-ajd@linux.ibm.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230120074306.1326298-1-ajd@linux.ibm.com>
References: <20230120074306.1326298-1-ajd@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: PjT3UfYuD2T8befh4Twt5muUIJwugXSO
X-Proofpoint-ORIG-GUID: PjT3UfYuD2T8befh4Twt5muUIJwugXSO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-20_04,2023-01-19_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=855
 bulkscore=0 suspectscore=0 malwarescore=0 priorityscore=1501 spamscore=0
 impostorscore=0 clxscore=1015 adultscore=0 phishscore=0 lowpriorityscore=0
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

From: Russell Currey <ruscur@russell.cc>

Before interacting with the PLPKS, we ask the hypervisor to generate a
password for the current boot, which is then required for most further
PLPKS operations.

If we kexec into a new kernel, the new kernel will try and fail to
generate a new password, as the password has already been set.

Pass the password through to the new kernel via the device tree, in
/chosen/plpks-pw. Check for the presence of this property before trying
to generate a new password - if it exists, use the existing password and
remove it from the device tree.

Signed-off-by: Russell Currey <ruscur@russell.cc>
Signed-off-by: Andrew Donnellan <ajd@linux.ibm.com>

---

v3: New patch

v4: Fix compile when CONFIG_PSERIES_PLPKS=n (snowpatch)

    Fix error handling on fdt_path_offset() call (ruscur)
---
 arch/powerpc/kexec/file_load_64.c      | 18 ++++++++++++++++++
 arch/powerpc/platforms/pseries/plpks.c | 18 +++++++++++++++++-
 2 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kexec/file_load_64.c b/arch/powerpc/kexec/file_load_64.c
index af8854f9eae3..0c9130af60cc 100644
--- a/arch/powerpc/kexec/file_load_64.c
+++ b/arch/powerpc/kexec/file_load_64.c
@@ -27,6 +27,7 @@
 #include <asm/kexec_ranges.h>
 #include <asm/crashdump-ppc64.h>
 #include <asm/prom.h>
+#include <asm/plpks.h>
 
 struct umem_info {
 	u64 *buf;		/* data buffer for usable-memory property */
@@ -1156,6 +1157,9 @@ int setup_new_fdt_ppc64(const struct kimage *image, void *fdt,
 {
 	struct crash_mem *umem = NULL, *rmem = NULL;
 	int i, nr_ranges, ret;
+#ifdef CONFIG_PSERIES_PLPKS
+	int chosen_offset;
+#endif
 
 	/*
 	 * Restrict memory usage for kdump kernel by setting up
@@ -1230,6 +1234,20 @@ int setup_new_fdt_ppc64(const struct kimage *image, void *fdt,
 		}
 	}
 
+#ifdef CONFIG_PSERIES_PLPKS
+	// If we have PLPKS active, we need to provide the password
+	if (plpks_is_available()) {
+		chosen_offset = fdt_path_offset(fdt, "/chosen");
+		if (chosen_offset < 0) {
+			pr_err("Can't find chosen node: %s\n",
+			       fdt_strerror(chosen_offset));
+			goto out;
+		}
+		ret = fdt_setprop(fdt, chosen_offset, "ibm,plpks-pw",
+				  plpks_get_password(), plpks_get_passwordlen());
+	}
+#endif // CONFIG_PSERIES_PLPKS
+
 out:
 	kfree(rmem);
 	kfree(umem);
diff --git a/arch/powerpc/platforms/pseries/plpks.c b/arch/powerpc/platforms/pseries/plpks.c
index b3c7410a4f13..0350f10e1755 100644
--- a/arch/powerpc/platforms/pseries/plpks.c
+++ b/arch/powerpc/platforms/pseries/plpks.c
@@ -16,6 +16,7 @@
 #include <linux/slab.h>
 #include <linux/string.h>
 #include <linux/types.h>
+#include <linux/of.h>
 #include <asm/hvcall.h>
 #include <asm/machdep.h>
 #include <asm/plpks.h>
@@ -126,7 +127,22 @@ static int plpks_gen_password(void)
 {
 	unsigned long retbuf[PLPAR_HCALL_BUFSIZE] = { 0 };
 	u8 *password, consumer = PLPKS_OS_OWNER;
-	int rc;
+	struct property *prop;
+	int rc, len;
+
+	// Before we generate the password, we may have been booted by kexec and
+	// provided with a previous password.  Check for that first.
+	prop = of_find_property(of_chosen, "ibm,plpks-pw", &len);
+	if (prop) {
+		ospasswordlength = (u16)len;
+		ospassword = kzalloc(ospasswordlength, GFP_KERNEL);
+		if (!ospassword) {
+			of_remove_property(of_chosen, prop);
+			return -ENOMEM;
+		}
+		memcpy(ospassword, prop->value, len);
+		return of_remove_property(of_chosen, prop);
+	}
 
 	// The password must not cross a page boundary, so we align to the next power of 2
 	password = kzalloc(roundup_pow_of_two(maxpwsize), GFP_KERNEL);
-- 
2.39.0

