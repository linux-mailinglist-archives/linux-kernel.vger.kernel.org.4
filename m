Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F22C66730F
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 14:20:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232996AbjALNU2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 08:20:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233780AbjALNT4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 08:19:56 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BCA032EB3;
        Thu, 12 Jan 2023 05:19:54 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30CDGLTA018512;
        Thu, 12 Jan 2023 13:19:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2022-7-12; bh=2j0zCAMrw6O9B/7eUR+UO1IBhlgaVEw4+ZhwmJl3llc=;
 b=fy/w6piqQpe0fSSBZIZUxDABsZnWJq/9RHoHPbBhMxQ52VP9AU7w0s3fyVVE+iVp903Z
 qOAjcdN7tyL3+wU0OgX5QRHRN8ftgzE8/fZB2Fyo1cX+ycyDSFPufgEyqQw2lHVWK7cd
 f6BNlLsF4VVkopkqzRk6F0645mBzDcFgRTL4nc1zMqtMVPabrCikf4dq7rC2udlAc3Bc
 3QTgYwCo0laRT7X4XPIYF36ORDs0jUemVKxoSGFl052q2ZF9Vf6nBLKBNL8VsE6xAk0S
 fZDYfYbSXEN2h/iv56FOw5cDrjGxXKWrG162OuR/8REMsqS//ciktt0pJbWKKCgoiT41 4g== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n27nr9257-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Jan 2023 13:19:38 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30CB4r0G022699;
        Thu, 12 Jan 2023 13:19:37 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3n1k4f77e8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Jan 2023 13:19:37 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 30CDJaKZ031929;
        Thu, 12 Jan 2023 13:19:36 GMT
Received: from t460.home (dhcp-10-175-58-190.vpn.oracle.com [10.175.58.190])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3n1k4f77ca-1;
        Thu, 12 Jan 2023 13:19:36 +0000
From:   Vegard Nossum <vegard.nossum@oracle.com>
To:     Luis Chamberlain <mcgrof@kernel.org>, linux-kernel@vger.kernel.org
Cc:     Vegard Nossum <vegard.nossum@oracle.com>,
        Thadeu Lima de Souza Cascardo <cascardo@canonical.com>,
        Serge Hallyn <serge@hallyn.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        linux-hardening@vger.kernel.org, linux-modules@vger.kernel.org,
        John Haxby <john.haxby@oracle.com>,
        Jann Horn <jannh@google.com>
Subject: [PATCH v3] kmod: harden user namespaces with new kernel.ns_modules_allowed sysctl
Date:   Thu, 12 Jan 2023 14:19:11 +0100
Message-Id: <20230112131911.7684-1-vegard.nossum@oracle.com>
X-Mailer: git-send-email 2.35.1.46.g38062e73e0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-12_08,2023-01-12_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 malwarescore=0 mlxscore=0 suspectscore=0 phishscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301120095
X-Proofpoint-GUID: 1Ehw6LuTbVEy1mOdMc3xJdv42YhpQmMf
X-Proofpoint-ORIG-GUID: 1Ehw6LuTbVEy1mOdMc3xJdv42YhpQmMf
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Creating a new user namespace grants you the ability to reach a lot of code
(including loading certain kernel modules) that would otherwise be out of
reach of an attacker. We can reduce the attack surface and block exploits
by ensuring that user namespaces cannot trigger module (auto-)loading.

A cursory search of exploits found online yields the following
non-exhaustive list of vulnerabilities, and shows that the technique is
both old and still in use:

- CVE-2016-8655
- CVE-2017-1000112
- CVE-2021-32606
- CVE-2022-2588
- CVE-2022-27666
- CVE-2022-34918
- CVE-2023-0179

A quick survey of common distros shows that Ubuntu, Fedora, RHEL, CentOS
Stream, and Oracle Linux allow unprivileged user namespaces by default,
probably to support sandboxing in browsers and containers. Major
exceptions would be Debian and Arch Linux which carry an out-of-tree patch
to disable user namespaces by default.

This patch adds a new sysctl, kernel.ns_modules_allowed, which when set to
0 will block requests to load modules when the request originates in a
process running in a user namespace.

For backwards compatibility, the default value of the sysctl is set to
CONFIG_NS_MODULES_ALLOWED_DEFAULT_ON, which in turn defaults to 1, meaning
there should be absolutely no change in behaviour unless you opt in either
at compile time or at runtime.

This mitigation obviously offers no protection if the vulnerable module is
already loaded, but for many of these exploits the vast majority of users
will never actually load or use these modules on purpose; in other words,
for the vast majority of users, this would block exploits for the above
list of vulnerabilities.

Testing: Running the reproducer for CVE-2022-2588 fails and results in the
following message in the kernel log:

    [  130.208030] request_module: pid 4107 (a.out) requested kernel module rtnl-link-dummy; denied due to kernel.ns_modules_allowed sysctl

v2:
- fix build failure due to missing CONFIG_SYSCTL guard around register_sysctl_init()
- use .maxlen = sizeof(int) for proc_dobool()
- don't warn when sysctl_ns_modules_allowed == 1

v3:
- drop capable(CAP_SYS_MODULE) check
- add a new CVE to changelog :-)
- add survey of distros that enable unpriv userns to changelog

Link: https://lore.kernel.org/lkml/20220809185229.28417-1-vegard.nossum@oracle.com/ # v1
Link: https://lore.kernel.org/lkml/20220815082753.6088-1-vegard.nossum@oracle.com/ # v2
Cc: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
Cc: Serge Hallyn <serge@hallyn.com>
Cc: Eric Biederman <ebiederm@xmission.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: linux-hardening@vger.kernel.org
Cc: linux-modules@vger.kernel.org
Cc: John Haxby <john.haxby@oracle.com>
Cc: Jann Horn <jannh@google.com>
Signed-off-by: Vegard Nossum <vegard.nossum@oracle.com>
---
 Documentation/admin-guide/sysctl/kernel.rst | 11 ++++++
 init/Kconfig                                | 17 ++++++++++
 kernel/kmod.c                               | 37 +++++++++++++++++++++
 3 files changed, 65 insertions(+)

diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
index 46e3d62c0eea..bd9b4e911a6a 100644
--- a/Documentation/admin-guide/sysctl/kernel.rst
+++ b/Documentation/admin-guide/sysctl/kernel.rst
@@ -612,6 +612,17 @@ A value of 0 means no change. The default value is 200 meaning the NMI
 watchdog is set to 30s (based on ``watchdog_thresh`` equal to 10).
 
 
+ns_modules_allowed
+==================
+
+Control whether processes may trigger module loading inside a user namespace.
+
+= =================================
+0 Deny module loading requests.
+1 Accept module loading requests.
+= =================================
+
+
 numa_balancing
 ==============
 
diff --git a/init/Kconfig b/init/Kconfig
index 7e5c3ddc341d..5d9ab43a24b9 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1249,6 +1249,23 @@ config USER_NS
 
 	  If unsure, say N.
 
+config NS_MODULES_ALLOWED_DEFAULT_ON
+	bool "Allow user namespaces to auto-load kernel modules by default"
+	depends on MODULES
+	depends on USER_NS
+	default y
+	help
+	  This option makes it so that processes running inside user
+	  namespaces may auto-load kernel modules.
+
+	  Say N to mitigate some exploits that rely on being able to
+	  auto-load kernel modules; however, this may also cause some
+	  legitimate programs to fail unless kernel modules are loaded by
+	  hand.
+
+	  You can write 0 or 1 to /proc/sys/kernel/ns_modules_allowed to
+	  change behaviour at run-time.
+
 config PID_NS
 	bool "PID Namespaces"
 	default y
diff --git a/kernel/kmod.c b/kernel/kmod.c
index b717134ebe17..938c0a39381a 100644
--- a/kernel/kmod.c
+++ b/kernel/kmod.c
@@ -25,6 +25,7 @@
 #include <linux/ptrace.h>
 #include <linux/async.h>
 #include <linux/uaccess.h>
+#include <linux/sysctl.h>
 
 #include <trace/events/module.h>
 
@@ -105,6 +106,12 @@ static int call_modprobe(char *module_name, int wait)
 	return -ENOMEM;
 }
 
+/*
+ * Allow processes running inside namespaces to trigger module loading?
+ */
+static bool sysctl_ns_modules_allowed __read_mostly =
+	IS_BUILTIN(CONFIG_NS_MODULES_ALLOWED_DEFAULT_ON);
+
 /**
  * __request_module - try to load a kernel module
  * @wait: wait (or not) for the operation to complete
@@ -148,6 +155,16 @@ int __request_module(bool wait, const char *fmt, ...)
 	if (ret)
 		return ret;
 
+	/*
+	 * Disallow module loading if we're in a user namespace.
+	 */
+	if (current_user_ns() != &init_user_ns &&
+	    !sysctl_ns_modules_allowed) {
+		pr_warn_ratelimited("request_module: pid %d (%s) in user namespace requested kernel module %s; denied due to kernel.ns_modules_allowed sysctl\n",
+			task_pid_nr(current), current->comm, module_name);
+		return -EPERM;
+	}
+
 	if (atomic_dec_if_positive(&kmod_concurrent_max) < 0) {
 		pr_warn_ratelimited("request_module: kmod_concurrent_max (%u) close to 0 (max_modprobes: %u), for module %s, throttling...",
 				    atomic_read(&kmod_concurrent_max),
@@ -175,3 +192,23 @@ int __request_module(bool wait, const char *fmt, ...)
 	return ret;
 }
 EXPORT_SYMBOL(__request_module);
+
+#ifdef CONFIG_SYSCTL
+static struct ctl_table kmod_sysctl_table[] = {
+	{
+		.procname       = "ns_modules_allowed",
+		.data           = &sysctl_ns_modules_allowed,
+		.maxlen         = sizeof(int),
+		.mode           = 0644,
+		.proc_handler   = proc_dobool,
+	},
+	{ }
+};
+
+static int __init kmod_sysctl_init(void)
+{
+	register_sysctl_init("kernel", kmod_sysctl_table);
+	return 0;
+}
+late_initcall(kmod_sysctl_init);
+#endif
-- 
2.35.1.46.g38062e73e0

