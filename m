Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D47C5EA906
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 16:52:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233222AbiIZOwA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 10:52:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235174AbiIZOvf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 10:51:35 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCF8E8D7BF;
        Mon, 26 Sep 2022 06:17:03 -0700 (PDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28QChtYP013017;
        Mon, 26 Sep 2022 13:16:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=8W0sUEzVknNUWdeLhEf1U8UuT8CwIMgLbQ5U0+91X+U=;
 b=DYqkRpIa4SBcdhWlOGZ3Ee8yrtrVSHCpcvjp0EFC+Ln4oIMeaMhcY5ekZ4+4o9vEIPBE
 694DqT+kMMUuhoakcyY2mTxVCL+verWmpkk2EmJ9mWXt07/jVYi2zvtqqMcWBlCU0sKI
 ww232Jw37RGCLu23+NOkkqCIhBJpkVos4CsDoHP+S0rvBpG3KoH9vsL6S3ZKc+Yq7atZ
 1tt+FvkvpoesJweVYgEdhcgL6RWWUW8HrtZyZePnEdvhimGid9uzpHdbqZl56CbeVJAZ
 m8G+eddOCOeicpyEDvhYDu3mY8AbFq0j+t0uxVm7mNrlDn02HZ2rlaJ5sJ6wx3+YiGcg Cg== 
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jucbj8ysm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 26 Sep 2022 13:16:46 +0000
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 28QD6tS4020955;
        Mon, 26 Sep 2022 13:16:45 GMT
Received: from b03cxnp08027.gho.boulder.ibm.com (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
        by ppma03wdc.us.ibm.com with ESMTP id 3jssh961kp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 26 Sep 2022 13:16:45 +0000
Received: from smtpav03.dal12v.mail.ibm.com ([9.208.128.129])
        by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 28QDGgoe15859986
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 26 Sep 2022 13:16:42 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AFC5C58056;
        Mon, 26 Sep 2022 13:16:43 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 953945803F;
        Mon, 26 Sep 2022 13:16:43 +0000 (GMT)
Received: from localhost (unknown [9.163.91.170])
        by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Mon, 26 Sep 2022 13:16:43 +0000 (GMT)
From:   Nathan Lynch <nathanl@linux.ibm.com>
To:     linuxppc-dev@lists.ozlabs.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     jmorris@namei.org, mpe@ellerman.id.au, paul@paul-moore.com,
        serge@hallyn.com, ajd@linux.ibm.com, gcwilson@linux.ibm.com,
        nayna@linux.ibm.com
Subject: [PATCH v2 1/2] powerpc/pseries: block untrusted device tree changes when locked down
Date:   Mon, 26 Sep 2022 08:16:42 -0500
Message-Id: <20220926131643.146502-2-nathanl@linux.ibm.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220926131643.146502-1-nathanl@linux.ibm.com>
References: <20220926131643.146502-1-nathanl@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Ntwi7r51iwpoB6HW4ORGfcDKOKcnlsvc
X-Proofpoint-GUID: Ntwi7r51iwpoB6HW4ORGfcDKOKcnlsvc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-26_08,2022-09-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 priorityscore=1501
 mlxlogscore=999 bulkscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0
 adultscore=0 suspectscore=0 spamscore=0 impostorscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2209260083
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The /proc/powerpc/ofdt interface allows the root user to freely alter
the in-kernel device tree, enabling arbitrary physical address writes
via drivers that could bind to malicious device nodes, thus making it
possible to disable lockdown.

Historically this interface has been used on the pseries platform to
facilitate the runtime addition and removal of processor, memory, and
device resources (aka Dynamic Logical Partitioning or DLPAR). Years
ago, the processor and memory use cases were migrated to designs that
happen to be lockdown-friendly: device tree updates are communicated
directly to the kernel from firmware without passing through untrusted
user space. I/O device DLPAR via the "drmgr" command in powerpc-utils
remains the sole legitimate user of /proc/powerpc/ofdt, but it is
already broken in lockdown since it uses /dev/mem to allocate argument
buffers for the rtas syscall. So only illegitimate uses of the
interface should see a behavior change when running on a locked down
kernel.

Signed-off-by: Nathan Lynch <nathanl@linux.ibm.com>
---
 arch/powerpc/platforms/pseries/reconfig.c | 5 +++++
 include/linux/security.h                  | 1 +
 security/security.c                       | 1 +
 3 files changed, 7 insertions(+)

diff --git a/arch/powerpc/platforms/pseries/reconfig.c b/arch/powerpc/platforms/pseries/reconfig.c
index cad7a0c93117..599bd2c78514 100644
--- a/arch/powerpc/platforms/pseries/reconfig.c
+++ b/arch/powerpc/platforms/pseries/reconfig.c
@@ -10,6 +10,7 @@
 #include <linux/kernel.h>
 #include <linux/notifier.h>
 #include <linux/proc_fs.h>
+#include <linux/security.h>
 #include <linux/slab.h>
 #include <linux/of.h>
 
@@ -361,6 +362,10 @@ static ssize_t ofdt_write(struct file *file, const char __user *buf, size_t coun
 	char *kbuf;
 	char *tmp;
 
+	rv = security_locked_down(LOCKDOWN_DEVICE_TREE);
+	if (rv)
+		return rv;
+
 	kbuf = memdup_user_nul(buf, count);
 	if (IS_ERR(kbuf))
 		return PTR_ERR(kbuf);
diff --git a/include/linux/security.h b/include/linux/security.h
index 7bd0c490703d..39e7c0e403d9 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -114,6 +114,7 @@ enum lockdown_reason {
 	LOCKDOWN_IOPORT,
 	LOCKDOWN_MSR,
 	LOCKDOWN_ACPI_TABLES,
+	LOCKDOWN_DEVICE_TREE,
 	LOCKDOWN_PCMCIA_CIS,
 	LOCKDOWN_TIOCSSERIAL,
 	LOCKDOWN_MODULE_PARAMETERS,
diff --git a/security/security.c b/security/security.c
index 4b95de24bc8d..51bf66d4f472 100644
--- a/security/security.c
+++ b/security/security.c
@@ -52,6 +52,7 @@ const char *const lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX+1] = {
 	[LOCKDOWN_IOPORT] = "raw io port access",
 	[LOCKDOWN_MSR] = "raw MSR access",
 	[LOCKDOWN_ACPI_TABLES] = "modifying ACPI tables",
+	[LOCKDOWN_DEVICE_TREE] = "modifying device tree contents",
 	[LOCKDOWN_PCMCIA_CIS] = "direct PCMCIA CIS storage",
 	[LOCKDOWN_TIOCSSERIAL] = "reconfiguration of serial port IO",
 	[LOCKDOWN_MODULE_PARAMETERS] = "unsafe module parameters",
-- 
2.37.3

