Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 425626B52E0
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 22:28:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231906AbjCJV2Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 16:28:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231852AbjCJV2A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 16:28:00 -0500
Received: from mx0a-00190b01.pphosted.com (mx0a-00190b01.pphosted.com [IPv6:2620:100:9001:583::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0EA212F1D
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 13:27:57 -0800 (PST)
Received: from pps.filterd (m0122333.ppops.net [127.0.0.1])
        by mx0a-00190b01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32AIEOaq009120;
        Fri, 10 Mar 2023 21:27:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=from : to : cc :
 subject : date : message-id; s=jan2016.eng;
 bh=+pRamdnzZqBLKcPOdWXE1Hf7TLRaE8x8L2WT1UkacLs=;
 b=hFN6kzT9ijI3SZ5NbY+vxWBLzoeQRfmwVUhmoEsPkllie1iiF8p48s+31Zh6hF/R9yoz
 kdz1wHhXseJduFlfhllUFwDXFvSYaHQQ5wixKAoaynqr/9ykfep1EuUhkD158IKvrmdd
 wT4/Eq4ldia5vUxUoUXzp6aiUS+pPcFAJjq6yIe9JYweBx7C626yCoVZxkqP+DIn264i
 AfRgXI/nDY4wF8Vw907MWa3kR0tNlzk2xP9RhamyCzLZbaZplZDgC8y+jSvhpIgs7ohr
 0UAyO1JyzmAO6RWWzj24JjY9/y6HI7JHIlYC5lJAscZ2OLtjODEzXVOPvlKRIoCpjIBz 4w== 
Received: from prod-mail-ppoint1 (prod-mail-ppoint1.akamai.com [184.51.33.18] (may be forged))
        by mx0a-00190b01.pphosted.com (PPS) with ESMTPS id 3p6fk4n172-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Mar 2023 21:27:49 +0000
Received: from pps.filterd (prod-mail-ppoint1.akamai.com [127.0.0.1])
        by prod-mail-ppoint1.akamai.com (8.17.1.19/8.17.1.19) with ESMTP id 32AJY5U6023997;
        Fri, 10 Mar 2023 16:27:48 -0500
Received: from prod-mail-relay10.akamai.com ([172.27.118.251])
        by prod-mail-ppoint1.akamai.com (PPS) with ESMTP id 3p6ffp5334-1;
        Fri, 10 Mar 2023 16:27:48 -0500
Received: from bos-lhv9ol.bos01.corp.akamai.com (bos-lhv9ol.bos01.corp.akamai.com [172.28.222.101])
        by prod-mail-relay10.akamai.com (Postfix) with ESMTP id 4C093546E2;
        Fri, 10 Mar 2023 21:27:48 +0000 (GMT)
From:   Jason Baron <jbaron@akamai.com>
To:     mcgrof@kernel.org
Cc:     linux-kernel@vger.kernel.org, Jim Cromie <jim.cromie@gmail.com>,
        Vincenzo Palazzo <vincenzopalazzodev@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH] dyndbg: cleanup dynamic usage in ib_srp.c
Date:   Fri, 10 Mar 2023 16:27:28 -0500
Message-Id: <20230310212728.82021-1-jbaron@akamai.com>
X-Mailer: git-send-email 2.17.1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-10_10,2023-03-10_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 suspectscore=0
 mlxscore=0 adultscore=0 malwarescore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2303100171
X-Proofpoint-GUID: FP2z9l-tk8cfcoXsPCYTVSyyjyBetpWD
X-Proofpoint-ORIG-GUID: FP2z9l-tk8cfcoXsPCYTVSyyjyBetpWD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-10_10,2023-03-10_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 suspectscore=0
 impostorscore=0 spamscore=0 bulkscore=0 mlxscore=0 malwarescore=0
 mlxlogscore=999 phishscore=0 priorityscore=1501 clxscore=1011 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2303100171
X-Spam-Status: No, score=0.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, in dynamic_debug.h we only provide
DEFINE_DYNAMIC_DEBUG_METADATA() and DYNAMIC_DEBUG_BRANCH()
definitions if CONFIG_DYNAMIC_CORE is enabled. Thus, drivers
such as infiniband srp (see: drivers/infiniband/ulp/srp/ib_srp.c)
must provide their own definitions for !CONFIG_DYNAMIC_CORE.

Thus, let's move this !CONFIG_DYNAMIC_CORE case into dynamic_debug.h.
However, the dynamic debug interfaces should really only be defined
if CONFIG_DYNAMIC_DEBUG is set or CONFIG_DYNAMIC_CORE is set along
with DYNAMIC_DEBUG_MODULE, (see:
Documentation/admin-guide/dynamic-debug-howto.rst). Thus, the
undefined case becomes: !((CONFIG_DYNAMIC_DEBUG ||
(CONFIG_DYNAMIC_CORE && DYNAMIC_DEBUG_MODULE)).
With those changes in place, we can remove the !CONFIG_DYNAMIC_CORE
case from ib_srp.c

This change was prompted by a build breakeage in ib_srp.c stemming
from the inclusion of dynamic_debug.h unconditionally in module.h, due
to commit 7deabd674988 ("dyndbg: use the module notifier callbacks").
In that case, if we have CONFIG_DYNAMIC_CORE=y and
CONFIG_DYNAMIC_DEBUG=n then the definitions for
DEFINE_DYNAMIC_DEBUG_METADATA() and DYNAMIC_DEBUG_BRANCH() are defined
once in ib_srp.c and then again in the dynamic_debug.h. This had been
working prior to the above referenced commit because dynamic_debug.h
was only pulled into ib_srp.c conditinally via printk.h if
CONFIG_DYNAMIC_DEBUG was set.

Cc: Jim Cromie <jim.cromie@gmail.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>
Cc: Vincenzo Palazzo <vincenzopalazzodev@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Bart Van Assche <bvanassche@acm.org>
Fixes: 7deabd674988 ("dyndbg: use the module notifier callbacks")
Reported-by: kernel test robot <lkp@intel.com>
Link: https://urldefense.com/v3/__https://lore.kernel.org/oe-kbuild-all/202303071444.sIbZTDCy-lkp@intel.com/__;!!GjvTz_vk!S6X1T0wd8DP8kxf6V06_uDcxrNwKJhPOU_7dY0PNghJRL0ahqvE8bh-5544ThnyRkpVyK4Q$
Signed-off-by: Jason Baron <jbaron@akamai.com>
---
 drivers/infiniband/ulp/srp/ib_srp.c |  5 ---
 include/linux/dynamic_debug.h       | 59 ++++++++++++++++++-----------
 2 files changed, 37 insertions(+), 27 deletions(-)

diff --git a/drivers/infiniband/ulp/srp/ib_srp.c b/drivers/infiniband/ulp/srp/ib_srp.c
index df21b30b7735..40ba2c6927c6 100644
--- a/drivers/infiniband/ulp/srp/ib_srp.c
+++ b/drivers/infiniband/ulp/srp/ib_srp.c
@@ -62,11 +62,6 @@ MODULE_AUTHOR("Roland Dreier");
 MODULE_DESCRIPTION("InfiniBand SCSI RDMA Protocol initiator");
 MODULE_LICENSE("Dual BSD/GPL");
 
-#if !defined(CONFIG_DYNAMIC_DEBUG)
-#define DEFINE_DYNAMIC_DEBUG_METADATA(name, fmt)
-#define DYNAMIC_DEBUG_BRANCH(descriptor) false
-#endif
-
 static unsigned int srp_sg_tablesize;
 static unsigned int cmd_sg_entries;
 static unsigned int indirect_sg_entries;
diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index f401414341fb..061dd84d09f3 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -128,14 +128,16 @@ struct ddebug_class_param {
 	const struct ddebug_class_map *map;
 };
 
-#if defined(CONFIG_DYNAMIC_DEBUG_CORE)
+/*
+ * pr_debug() and friends are globally enabled or modules have selectively
+ * enabled them.
+ */
+#if defined(CONFIG_DYNAMIC_DEBUG) || \
+	(defined(CONFIG_DYNAMIC_DEBUG_CORE) && defined(DYNAMIC_DEBUG_MODULE))
 
 extern __printf(2, 3)
 void __dynamic_pr_debug(struct _ddebug *descriptor, const char *fmt, ...);
 
-extern int ddebug_dyndbg_module_param_cb(char *param, char *val,
-					const char *modname);
-
 struct device;
 
 extern __printf(3, 4)
@@ -284,10 +286,6 @@ void __dynamic_ibdev_dbg(struct _ddebug *descriptor,
 				   KERN_DEBUG, prefix_str, prefix_type,	\
 				   rowsize, groupsize, buf, len, ascii)
 
-struct kernel_param;
-int param_set_dyndbg_classes(const char *instr, const struct kernel_param *kp);
-int param_get_dyndbg_classes(char *buffer, const struct kernel_param *kp);
-
 /* for test only, generally expect drm.debug style macro wrappers */
 #define __pr_debug_cls(cls, fmt, ...) do {			\
 	BUILD_BUG_ON_MSG(!__builtin_constant_p(cls),		\
@@ -295,23 +293,14 @@ int param_get_dyndbg_classes(char *buffer, const struct kernel_param *kp);
 	dynamic_pr_debug_cls(cls, fmt, ##__VA_ARGS__);		\
 	} while (0)
 
-#else /* !CONFIG_DYNAMIC_DEBUG_CORE */
+#else /* !(CONFIG_DYNAMIC_DEBUG || (CONFIG_DYNAMIC_DEBUG_CORE && DYNAMIC_DEBUG_MODULE)) */
 
 #include <linux/string.h>
 #include <linux/errno.h>
 #include <linux/printk.h>
 
-static inline int ddebug_dyndbg_module_param_cb(char *param, char *val,
-						const char *modname)
-{
-	if (!strcmp(param, "dyndbg")) {
-		/* avoid pr_warn(), which wants pr_fmt() fully defined */
-		printk(KERN_WARNING "dyndbg param is supported only in "
-			"CONFIG_DYNAMIC_DEBUG builds\n");
-		return 0; /* allow and ignore */
-	}
-	return -EINVAL;
-}
+#define DEFINE_DYNAMIC_DEBUG_METADATA(name, fmt)
+#define DYNAMIC_DEBUG_BRANCH(descriptor) false
 
 #define dynamic_pr_debug(fmt, ...)					\
 	do { if (0) printk(KERN_DEBUG pr_fmt(fmt), ##__VA_ARGS__); } while (0)
@@ -324,14 +313,40 @@ static inline int ddebug_dyndbg_module_param_cb(char *param, char *val,
 				rowsize, groupsize, buf, len, ascii);	\
 	} while (0)
 
+#endif /* CONFIG_DYNAMIC_DEBUG || (CONFIG_DYNAMIC_DEBUG_CORE && DYNAMIC_DEBUG_MODULE) */
+
+
+#ifdef CONFIG_DYNAMIC_DEBUG_CORE
+
+extern int ddebug_dyndbg_module_param_cb(char *param, char *val,
+					const char *modname);
+struct kernel_param;
+int param_set_dyndbg_classes(const char *instr, const struct kernel_param *kp);
+int param_get_dyndbg_classes(char *buffer, const struct kernel_param *kp);
+
+#else
+
+static inline int ddebug_dyndbg_module_param_cb(char *param, char *val,
+						const char *modname)
+{
+	if (!strcmp(param, "dyndbg")) {
+		/* avoid pr_warn(), which wants pr_fmt() fully defined */
+		printk(KERN_WARNING "dyndbg param is supported only in "
+			"CONFIG_DYNAMIC_DEBUG builds\n");
+		return 0; /* allow and ignore */
+	}
+	return -EINVAL;
+}
+
 struct kernel_param;
 static inline int param_set_dyndbg_classes(const char *instr, const struct kernel_param *kp)
 { return 0; }
 static inline int param_get_dyndbg_classes(char *buffer, const struct kernel_param *kp)
 { return 0; }
 
-#endif /* !CONFIG_DYNAMIC_DEBUG_CORE */
+#endif
+
 
 extern const struct kernel_param_ops param_ops_dyndbg_classes;
 
-#endif
+#endif /* _DYNAMIC_DEBUG_H */
-- 
2.17.1

