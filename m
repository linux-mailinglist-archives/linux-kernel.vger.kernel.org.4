Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AE8E6186D5
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 19:00:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232140AbiKCSAn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 14:00:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232072AbiKCR73 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 13:59:29 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7107E5F97
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 10:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667498362; x=1699034362;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OZimIu89EeGi5tqLMGLYWDXCZnDY709jANJn7l/dlDM=;
  b=Mpx6SJJZHPkR7EsUdeLIiScHl6ObAm4/NLI9wgNZcQJJcNmBFCe8Nl5u
   2BsdYZMKpQ5W6VF2+kgw0xuSB6PU8Q7yb0/A3YjNHcl/lsE2Je445wBDo
   fBdNHNWctgZeShvO8hK3UPEyrSrYQNt7GDjO2N4zvln1rnOnzPCN5ItvN
   NnBK8Hch3qUxuF3B7jG33sK3oTQzsLI0A5XoSKY1NcJxNwVobsWI9gWOL
   3FyjBrprcT+VRX8hZj6NAaMicXj5Wi/JaF7Zk2sH6f/NDryWx/fWQ3VKO
   EsV3fNZXODjIjY+YJpyvrKg5O35vjZxvZdVF4yuNAuxhrAknYLO4Y4ctd
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10520"; a="308476972"
X-IronPort-AV: E=Sophos;i="5.96,134,1665471600"; 
   d="scan'208";a="308476972"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2022 10:59:18 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10520"; a="809762556"
X-IronPort-AV: E=Sophos;i="5.96,134,1665471600"; 
   d="scan'208";a="809762556"
Received: from araj-dh-work.jf.intel.com ([10.165.157.158])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2022 10:59:18 -0700
From:   Ashok Raj <ashok.raj@intel.com>
To:     Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     "LKML Mailing List" <linux-kernel@vger.kernel.org>,
        X86-kernel <x86@kernel.org>, Tony Luck <tony.luck@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Arjan van de Ven <arjan.van.de.ven@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Jacon Jun Pan <jacob.jun.pan@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Kai Huang <kai.huang@intel.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Ashok Raj <ashok.raj@intel.com>
Subject: [v2 06/13] x86/ipi: Support sending NMI_VECTOR as self ipi
Date:   Thu,  3 Nov 2022 17:58:54 +0000
Message-Id: <20221103175901.164783-7-ashok.raj@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221103175901.164783-1-ashok.raj@intel.com>
References: <20221103175901.164783-1-ashok.raj@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jacob Pan <jacob.jun.pan@linux.intel.com>

apic->send_IPI_self() can be used to send any general vector as a self IPI.
The function uses a SHORTCUT specifier, but it can't be used to send a
vector with delivery mode as NMI. Chapter 10, Advanved Programmable
Interrupt Controller (APIC) Table 10-3 indicates that the shortcut isn't a
legal combination for NMI delivery. The same is true for x2apic
implementations as well, the self IPI MSR can only specify the vector
number, but no delivery mode.

The helper adds proper handling if the vector is NMI_VECTOR.

Suggested-by: Ashok Raj <ashok.raj@intel.com>
Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
Co-developed-by: Ashok Raj <ashok.raj@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Ashok Raj <ashok.raj@intel.com>
---
 arch/x86/kernel/apic/ipi.c         |  6 +++++-
 arch/x86/kernel/apic/x2apic_phys.c |  6 +++++-
 arch/x86/kernel/nmi_selftest.c     | 32 ++++++++++++++++++++++++++++++
 3 files changed, 42 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/apic/ipi.c b/arch/x86/kernel/apic/ipi.c
index 2a6509e8c840..e967c49609ef 100644
--- a/arch/x86/kernel/apic/ipi.c
+++ b/arch/x86/kernel/apic/ipi.c
@@ -239,7 +239,11 @@ void default_send_IPI_all(int vector)
 
 void default_send_IPI_self(int vector)
 {
-	__default_send_IPI_shortcut(APIC_DEST_SELF, vector);
+	if (unlikely(vector == NMI_VECTOR))
+		apic->send_IPI_mask(cpumask_of(smp_processor_id()),
+				    NMI_VECTOR);
+	else
+		__default_send_IPI_shortcut(APIC_DEST_SELF, vector);
 }
 
 #ifdef CONFIG_X86_32
diff --git a/arch/x86/kernel/apic/x2apic_phys.c b/arch/x86/kernel/apic/x2apic_phys.c
index 6bde05a86b4e..cf187f1906b2 100644
--- a/arch/x86/kernel/apic/x2apic_phys.c
+++ b/arch/x86/kernel/apic/x2apic_phys.c
@@ -149,7 +149,11 @@ int x2apic_phys_pkg_id(int initial_apicid, int index_msb)
 
 void x2apic_send_IPI_self(int vector)
 {
-	apic_write(APIC_SELF_IPI, vector);
+	if (unlikely(vector == NMI_VECTOR))
+		apic->send_IPI_mask(cpumask_of(smp_processor_id()),
+				    NMI_VECTOR);
+	else
+		apic_write(APIC_SELF_IPI, vector);
 }
 
 static struct apic apic_x2apic_phys __ro_after_init = {
diff --git a/arch/x86/kernel/nmi_selftest.c b/arch/x86/kernel/nmi_selftest.c
index a1a96df3dff1..f4b813821208 100644
--- a/arch/x86/kernel/nmi_selftest.c
+++ b/arch/x86/kernel/nmi_selftest.c
@@ -105,6 +105,36 @@ static void __init local_ipi(void)
 	test_nmi_ipi(to_cpumask(nmi_ipi_mask));
 }
 
+static void __init self_nmi_test(void)
+{
+	unsigned long timeout;
+
+	cpumask_clear(to_cpumask(nmi_ipi_mask));
+	cpumask_set_cpu(smp_processor_id(), to_cpumask(nmi_ipi_mask));
+
+	if (register_nmi_handler(NMI_LOCAL, test_nmi_ipi_callback,
+				 NMI_FLAG_FIRST, "nmi_selftest", __initdata)) {
+		nmi_fail = FAILURE;
+		return;
+	}
+
+	/* sync above data before sending NMI */
+	wmb();
+
+	apic->send_IPI_self(NMI_VECTOR);
+
+	/* Don't wait longer than a second */
+	timeout = USEC_PER_SEC;
+	while (!cpumask_empty(to_cpumask(nmi_ipi_mask)) && --timeout)
+		udelay(1);
+
+	/* What happens if we timeout, do we still unregister?? */
+	unregister_nmi_handler(NMI_LOCAL, "nmi_selftest");
+
+	if (!timeout)
+		nmi_fail = TIMEOUT;
+}
+
 static void __init reset_nmi(void)
 {
 	nmi_fail = 0;
@@ -157,6 +187,8 @@ void __init nmi_selftest(void)
 	print_testname("local IPI");
 	dotest(local_ipi, SUCCESS);
 	printk(KERN_CONT "\n");
+	print_testname("Self NMI IPI");
+	dotest(self_nmi_test, SUCCESS);
 
 	cleanup_nmi_testsuite();
 
-- 
2.34.1

