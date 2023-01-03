Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDB1365C3DD
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 17:27:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238232AbjACQ0e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 11:26:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238322AbjACQ0D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 11:26:03 -0500
X-Greylist: delayed 1661 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 03 Jan 2023 08:25:06 PST
Received: from mailfo01.lmco.com (mailfo01.lmco.com [192.31.106.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06983F5B6
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 08:25:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lmco.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=corpgw220615;
 bh=knWzglPZrsKljGf6ozfn1q3KvzWcWQQUlc8ggzSjiBc=;
 b=s7TkttjgYW5tZSZvKmQJrvpC1LcYrzoyPR0fR+avi+NFnNznLO0Y9vDCPjrez/QCUqet
 L9Er04kVTJjmnxepOf8BPKxFPz6XzHrO+8/uc4VyH9drPFHV6JPou0GQTaPMKatLirW5
 dO8CoI915y4gvIgtwifUpedgeqyDn1+8MUpJtK5pyMVzFUGT1CfMNzFP51G6EeCyypTT
 TOPQKOFemvc27ybmJeR/VuEkWpG7+e1xJqOGxN8v1rEilu1xKRIYwqWO0kltgJHX7Ao0
 /YXb6Q2TtLCJzp3dQjQq0cc6rEMrAzle29xlWpxsPLacviuDvtb42vu5DI3mm+IbFcyj 1w== 
Received: from lmxpdend12w04.us.lmco.com (lmxpdend12w04.ems.lmco.com [172.23.20.83])
        by mailfo01.lmco.com (8.16.0.42/8.16.0.42) with ESMTP id 303FunkH362325;
        Tue, 3 Jan 2023 15:56:51 GMT
Received: from lmxpdend07w03.us.lmco.com (172.23.20.42) by
 lmxpdend12w04.us.lmco.com (172.23.20.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.27; Tue, 3 Jan 2023 08:56:49 -0700
Received: from emss04g01.ems.lmco.com (134.133.98.130) by
 lmxpdend07w03.us.lmco.com (172.23.20.42) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.1.2308.27 via Frontend Transport; Tue, 3 Jan 2023 08:56:50 -0700
Received: from pps.reinject (emss04g01.ems.lmco.com [127.0.0.1])
        by emss04g01.ems.lmco.com (8.16.0.42/8.16.0.42) with ESMTPS id 303FunlY452203
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 3 Jan 2023 15:56:49 GMT
Received: from emss04g01.ems.lmco.com (emss04g01.ems.lmco.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 303FuGR3451628;
        Tue, 3 Jan 2023 15:56:49 GMT
Received: from orlvm30702.orl.lmco.com (orlvm30702.orl.lmco.com [141.240.192.247])
        by emss04g01.ems.lmco.com with ESMTP id 303Fum56452178;
        Tue, 03 Jan 2023 15:56:49 +0000
From:   "Moore, Neil A" <neil.a.moore@lmco.com>
To:     <x86@kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        Neil Moore <neil.a.moore@lmco.com>
Subject: [PATCH 1/1] x86: Add detection of the LMHS SRE hypervisor
Date:   Tue, 3 Jan 2023 10:56:48 -0500
Message-ID: <1672761408-30617-2-git-send-email-neil.a.moore@lmco.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1672761408-30617-1-git-send-email-neil.a.moore@lmco.com>
References: <1672761408-30617-1-git-send-email-neil.a.moore@lmco.com>
X-LM-Intranet-Inbound: IPlocal=127.0.0.1 FromIP=127.0.0.1 Env=neil.a.moore@lmco.com 
 g=-E3Anr7fC2hAMNWY9oF2vp17rfklcH9Y q=303FunlY452203 m=1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.545,18.0.923
 definitions=2023-01-03_05:2023-01-03,2023-01-03 signatures=0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.545,18.0.923
 definitions=2023-01-03_05:2023-01-03,2023-01-03 signatures=0
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-GUID: lC3d7R4l7nQ2ESwWlh_--BM_VhOwi5d2
X-Proofpoint-ORIG-GUID: lC3d7R4l7nQ2ESwWlh_--BM_VhOwi5d2
X-LM-Outbound: External 172.23.20.83 cntry=** g=lC3d7R4l7nQ2ESwWlh_--BM_VhOwi5d2
 q=303FunkH362325 m=2
X-LM-OBSENDER: neil.a.moore@lmco.com
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 mlxlogscore=999
 phishscore=0 spamscore=0 suspectscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301030135
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Neil Moore <neil.a.moore@lmco.com>

LMHS SRE is a hypervisor developed and maintained by Lockheed Martin that
targets embedded, edge, or cloud deployments with security, isolation,
and determinism requirements.

Add detection of the LMHS SRE and enable x2APIC when available.

Signed-off-by: Neil Moore <neil.a.moore@lmco.com>
---
 arch/x86/Kconfig                  | 12 +++++++++++-
 arch/x86/include/asm/hypervisor.h |  2 ++
 arch/x86/include/asm/sre.h        | 13 +++++++++++++
 arch/x86/kernel/cpu/Makefile      |  1 +
 arch/x86/kernel/cpu/hypervisor.c  |  3 +++
 arch/x86/kernel/cpu/sre.c         | 31 +++++++++++++++++++++++++++++++
 6 files changed, 61 insertions(+), 1 deletion(-)
 create mode 100644 arch/x86/include/asm/sre.h
 create mode 100644 arch/x86/kernel/cpu/sre.c

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 67745ceab0db..ba1f77dcbc7f 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -894,7 +894,17 @@ config INTEL_TDX_GUEST
 	  memory contents and CPU state. TDX guests are protected from
 	  some attacks from the VMM.
 
-endif # HYPERVISOR_GUEST
+config SRE_GUEST
+	bool "LMHS SRE Guest support"
+	depends on X86_64
+	help
+	  This option allows Linux to detect when running on top of the SRE
+	  hypervisor. SRE is a hypervisor targeting environments with high
+	  security, isolation, and determinism requirements and can be used
+	  in embedded, edge or cloud environments. More details can found at
+	  https://www.lockheedmartin.com/en-us/products/Hardened-Security-for-Intel-Processors.html
+
+endif #HYPERVISOR_GUEST
 
 source "arch/x86/Kconfig.cpu"
 
diff --git a/arch/x86/include/asm/hypervisor.h b/arch/x86/include/asm/hypervisor.h
index e41cbf2ec41d..3fc5d4cb4d9c 100644
--- a/arch/x86/include/asm/hypervisor.h
+++ b/arch/x86/include/asm/hypervisor.h
@@ -30,6 +30,7 @@ enum x86_hypervisor_type {
 	X86_HYPER_KVM,
 	X86_HYPER_JAILHOUSE,
 	X86_HYPER_ACRN,
+	X86_HYPER_SRE,
 };
 
 #ifdef CONFIG_HYPERVISOR_GUEST
@@ -64,6 +65,7 @@ extern const struct hypervisor_x86 x86_hyper_xen_pv;
 extern const struct hypervisor_x86 x86_hyper_kvm;
 extern const struct hypervisor_x86 x86_hyper_jailhouse;
 extern const struct hypervisor_x86 x86_hyper_acrn;
+extern const struct hypervisor_x86 x86_hyper_sre;
 extern struct hypervisor_x86 x86_hyper_xen_hvm;
 
 extern bool nopv;
diff --git a/arch/x86/include/asm/sre.h b/arch/x86/include/asm/sre.h
new file mode 100644
index 000000000000..e76a91f83bb5
--- /dev/null
+++ b/arch/x86/include/asm/sre.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_X86_SRE_H
+#define _ASM_X86_SRE_H
+
+static inline u32 sre_cpuid_base(void)
+{
+	if (boot_cpu_has(X86_FEATURE_HYPERVISOR))
+		return hypervisor_cpuid_base("SRESRESRESRE", 0);
+
+	return 0;
+}
+
+#endif /* _ASM_X86_SRE_H */
diff --git a/arch/x86/kernel/cpu/Makefile b/arch/x86/kernel/cpu/Makefile
index f10a921ee756..70dddeb7b7e3 100644
--- a/arch/x86/kernel/cpu/Makefile
+++ b/arch/x86/kernel/cpu/Makefile
@@ -56,6 +56,7 @@ obj-$(CONFIG_X86_LOCAL_APIC)		+= perfctr-watchdog.o
 
 obj-$(CONFIG_HYPERVISOR_GUEST)		+= vmware.o hypervisor.o mshyperv.o
 obj-$(CONFIG_ACRN_GUEST)		+= acrn.o
+obj-$(CONFIG_SRE_GUEST)			+= sre.o
 
 ifdef CONFIG_X86_FEATURE_NAMES
 quiet_cmd_mkcapflags = MKCAP   $@
diff --git a/arch/x86/kernel/cpu/hypervisor.c b/arch/x86/kernel/cpu/hypervisor.c
index 553bfbfc3a1b..08854aaedc74 100644
--- a/arch/x86/kernel/cpu/hypervisor.c
+++ b/arch/x86/kernel/cpu/hypervisor.c
@@ -45,6 +45,9 @@ static const __initconst struct hypervisor_x86 * const hypervisors[] =
 #ifdef CONFIG_ACRN_GUEST
 	&x86_hyper_acrn,
 #endif
+#ifdef CONFIG_SRE_GUEST
+	&x86_hyper_sre,
+#endif
 };
 
 enum x86_hypervisor_type x86_hyper_type;
diff --git a/arch/x86/kernel/cpu/sre.c b/arch/x86/kernel/cpu/sre.c
new file mode 100644
index 000000000000..9521d74c4c5b
--- /dev/null
+++ b/arch/x86/kernel/cpu/sre.c
@@ -0,0 +1,31 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * LMHS SRE detection support
+ *
+ * Copyright (C) 2022 Lockheed Martin Corporation. All rights reserved.
+ *
+ * Neil Moore <neil.a.moore@lmco.com>
+ *
+ */
+
+#include <asm/apic.h>
+#include <asm/cpufeatures.h>
+#include <asm/hypervisor.h>
+#include <asm/sre.h>
+
+static u32 __init sre_detect(void)
+{
+	return sre_cpuid_base();
+}
+
+static bool sre_x2apic_available(void)
+{
+	return boot_cpu_has(X86_FEATURE_X2APIC);
+}
+
+const __initconst struct hypervisor_x86 x86_hyper_sre = {
+	.name                   = "SRE",
+	.detect                 = sre_detect,
+	.type			= X86_HYPER_SRE,
+	.init.x2apic_available  = sre_x2apic_available,
+};
-- 
2.38.1

