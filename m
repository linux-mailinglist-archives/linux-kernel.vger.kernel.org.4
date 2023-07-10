Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B48574D416
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 13:03:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231791AbjGJLC4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 07:02:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230047AbjGJLCv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 07:02:51 -0400
Received: from blizzard.enjellic.com (wind.enjellic.com [76.10.64.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 385F6CE;
        Mon, 10 Jul 2023 04:02:50 -0700 (PDT)
Received: from blizzard.enjellic.com (localhost [127.0.0.1])
        by blizzard.enjellic.com (8.15.2/8.15.2) with ESMTP id 36AANTIX019804;
        Mon, 10 Jul 2023 05:23:29 -0500
Received: (from greg@localhost)
        by blizzard.enjellic.com (8.15.2/8.15.2/Submit) id 36AANTS0019802;
        Mon, 10 Jul 2023 05:23:29 -0500
X-Authentication-Warning: blizzard.enjellic.com: greg set sender to greg@enjellic.com using -f
From:   "Dr. Greg" <greg@enjellic.com>
To:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, corbet@lwn.net
Subject: [PATCH 13/13] Activate the configuration and build of the TSEM LSM.
Date:   Mon, 10 Jul 2023 05:23:19 -0500
Message-Id: <20230710102319.19716-14-greg@enjellic.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230710102319.19716-1-greg@enjellic.com>
References: <20230710102319.19716-1-greg@enjellic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Complete the implementation by integrating the LSM into the
configuration and kernel build infrastructure.

Signed-off-by: Greg Wettstein <greg@enjellic.com>
---
 security/Kconfig       | 11 ++++++-----
 security/Makefile      |  1 +
 security/tsem/Kconfig  | 36 ++++++++++++++++++++++++++++++++++++
 security/tsem/Makefile |  2 ++
 4 files changed, 45 insertions(+), 5 deletions(-)
 create mode 100644 security/tsem/Kconfig
 create mode 100644 security/tsem/Makefile

diff --git a/security/Kconfig b/security/Kconfig
index 97abeb9b9a19..23c25a12c8df 100644
--- a/security/Kconfig
+++ b/security/Kconfig
@@ -202,6 +202,7 @@ source "security/yama/Kconfig"
 source "security/safesetid/Kconfig"
 source "security/lockdown/Kconfig"
 source "security/landlock/Kconfig"
+source "security/tsem/Kconfig"
 
 source "security/integrity/Kconfig"
 
@@ -241,11 +242,11 @@ endchoice
 
 config LSM
 	string "Ordered list of enabled LSMs"
-	default "landlock,lockdown,yama,loadpin,safesetid,smack,selinux,tomoyo,apparmor,bpf" if DEFAULT_SECURITY_SMACK
-	default "landlock,lockdown,yama,loadpin,safesetid,apparmor,selinux,smack,tomoyo,bpf" if DEFAULT_SECURITY_APPARMOR
-	default "landlock,lockdown,yama,loadpin,safesetid,tomoyo,bpf" if DEFAULT_SECURITY_TOMOYO
-	default "landlock,lockdown,yama,loadpin,safesetid,bpf" if DEFAULT_SECURITY_DAC
-	default "landlock,lockdown,yama,loadpin,safesetid,selinux,smack,tomoyo,apparmor,bpf"
+	default "tsem,landlock,lockdown,yama,loadpin,safesetid,smack,selinux,tomoyo,apparmor,bpf" if DEFAULT_SECURITY_SMACK
+	default "tsem,landlock,lockdown,yama,loadpin,safesetid,apparmor,selinux,smack,tomoyo,bpf" if DEFAULT_SECURITY_APPARMOR
+	default "tsem,landlock,lockdown,yama,loadpin,safesetid,tomoyo,bpf" if DEFAULT_SECURITY_TOMOYO
+	default "tsem,landlock,lockdown,yama,loadpin,safesetid,bpf" if DEFAULT_SECURITY_DAC
+	default "tsem,landlock,lockdown,yama,loadpin,safesetid,selinux,smack,tomoyo,apparmor,bpf"
 	help
 	  A comma-separated list of LSMs, in initialization order.
 	  Any LSMs left off this list, except for those with order
diff --git a/security/Makefile b/security/Makefile
index 18121f8f85cd..11d93885c806 100644
--- a/security/Makefile
+++ b/security/Makefile
@@ -24,6 +24,7 @@ obj-$(CONFIG_SECURITY_LOCKDOWN_LSM)	+= lockdown/
 obj-$(CONFIG_CGROUPS)			+= device_cgroup.o
 obj-$(CONFIG_BPF_LSM)			+= bpf/
 obj-$(CONFIG_SECURITY_LANDLOCK)		+= landlock/
+obj-$(CONFIG_SECURITY_TSEM)		+= tsem/
 
 # Object integrity file lists
 obj-$(CONFIG_INTEGRITY)			+= integrity/
diff --git a/security/tsem/Kconfig b/security/tsem/Kconfig
new file mode 100644
index 000000000000..2e9d54eb3acc
--- /dev/null
+++ b/security/tsem/Kconfig
@@ -0,0 +1,36 @@
+config SECURITY_TSEM
+	bool "Trusted Security Event Modeling"
+	depends on SECURITY
+	depends on NET && INET
+	select SECURITY_NETWORK
+	select SECURITYFS
+	select CRYPTO
+	select CRYPTO_SHA256
+	select CRYPTO_HASH_INFO
+	select TCG_TPM if HAS_IOMEM && !UML
+	select TCG_TIS if TCG_TPM && X86
+	select TCG_CRB if TCG_TPM && ACPI
+	default n
+	help
+	  This option selects support for Trusted Security Event
+	  Modeling (TSEM).  TSEM implements the ability to model
+	  the security state of either the system at large or in a
+	  restricted namespace on the basis of the LSM security
+	  events and attributes that occur in the scope of the model.
+	  The model may be implemented either in the kernel proper
+	  or exported to an external Trusted Modeling Agent (TMA).
+	  If you are unsure how to answer this question, answer N.
+
+config SECURITY_TSEM_ROOT_MODEL_PCR
+	int "TPM PCR index for root domain"
+	depends on SECURITY_TSEM
+	range 8 14
+	default 11
+	help
+	  This configuration variable determines the TPM Platform
+	  Configuration Register (PCR) that the coefficients of
+	  security events for the root modeling domain are extended
+	  into.  The default value is one register above the default
+	  value that IMA uses for its integrity measurements, in order
+	  to avoid a conflict between the two sub-systems.  If unsure,
+	  leave the value at its default value of 11.
diff --git a/security/tsem/Makefile b/security/tsem/Makefile
new file mode 100644
index 000000000000..d43cf2ae2142
--- /dev/null
+++ b/security/tsem/Makefile
@@ -0,0 +1,2 @@
+obj-$(CONFIG_SECURITY_TSEM) := tsem.o model.o namespace.o map.o event.o fs.o \
+	export.o trust.o
-- 
2.39.1

