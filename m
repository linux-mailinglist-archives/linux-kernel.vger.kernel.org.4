Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE9536936CF
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Feb 2023 11:03:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbjBLKD5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Feb 2023 05:03:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjBLKDu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Feb 2023 05:03:50 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE04713D55;
        Sun, 12 Feb 2023 02:03:47 -0800 (PST)
Date:   Sun, 12 Feb 2023 10:03:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1676196225;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=i58dQV836cBfuE0SUdw7q9h0Gp64Uso8549QkT4sJfc=;
        b=LdkQW1gbEeX7pj5hed54g3vEj2OD8sNFWmp6h/20223RGm/oyhzqtJ7YbVhSc5vQkfI7Z4
        wyzBfSyaODFTagtblPnthHJ2aGK+vzI4PP4OHdornO3OQsURTkuL+rVXABHR39oxh3RnCn
        xC42nxy28xX732mH1ogGV8vu1JGXee2c0Mp2DT/VvizpTq9ELOk+vCjbb4pgPkDdf7f1J7
        xcC5dnSwEV2EsxQw9B/qHwoWARjlOxYSrYc01LM2xvhexyQ324h5AaNVTLKrxsgMiDEEE7
        LGcrvjHcOPBS3crU1UGXYYK4y3bAO+GXBBDNUXIofZVvav6BcyaNurBH9bIgbg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1676196225;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=i58dQV836cBfuE0SUdw7q9h0Gp64Uso8549QkT4sJfc=;
        b=ovMWMuoGK0se3LuImkbsDUqOQ3V/WMKQC8geV7RFE5KcLxpRiFFn8Lp6GpeQVKXsWhjrDa
        SRwUi1qcn5Jd/9BA==
From:   "tip-bot2 for Per Bilse" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] drivers/xen/hypervisor: Expose Xen SIF flags to userspace
Cc:     Per Bilse <per.bilse@citrix.com>, Juergen Gross <jgross@suse.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230103130213.2129753-1-per.bilse@citrix.com>
References: <20230103130213.2129753-1-per.bilse@citrix.com>
MIME-Version: 1.0
Message-ID: <167619622463.4906.55039390504901687.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     859761e770f8c88eea2ae6ae379798b432728cd6
Gitweb:        https://git.kernel.org/tip/859761e770f8c88eea2ae6ae379798b432728cd6
Author:        Per Bilse <per.bilse@citrix.com>
AuthorDate:    Tue, 03 Jan 2023 13:02:13 
Committer:     Juergen Gross <jgross@suse.com>
CommitterDate: Tue, 17 Jan 2023 08:47:05 +01:00

drivers/xen/hypervisor: Expose Xen SIF flags to userspace

/proc/xen is a legacy pseudo filesystem which predates Xen support
getting merged into Linux.  It has largely been replaced with more
normal locations for data (/sys/hypervisor/ for info, /dev/xen/ for
user devices).  We want to compile xenfs support out of the dom0 kernel.

There is one item which only exists in /proc/xen, namely
/proc/xen/capabilities with "control_d" being the signal of "you're in
the control domain".  This ultimately comes from the SIF flags provided
at VM start.

This patch exposes all SIF flags in /sys/hypervisor/start_flags/ as
boolean files, one for each bit, returning '1' if set, '0' otherwise.
Two known flags, 'privileged' and 'initdomain', are explicitly named,
and all remaining flags can be accessed via generically named files,
as suggested by Andrew Cooper.

Signed-off-by: Per Bilse <per.bilse@citrix.com>
Reviewed-by: Juergen Gross <jgross@suse.com>
Link: https://lore.kernel.org/r/20230103130213.2129753-1-per.bilse@citrix.com
Signed-off-by: Juergen Gross <jgross@suse.com>
---
 Documentation/ABI/stable/sysfs-hypervisor-xen | 13 +++-
 drivers/xen/sys-hypervisor.c                  | 69 ++++++++++++++++--
 2 files changed, 78 insertions(+), 4 deletions(-)

diff --git a/Documentation/ABI/stable/sysfs-hypervisor-xen b/Documentation/ABI/stable/sysfs-hypervisor-xen
index 748593c..be9ca99 100644
--- a/Documentation/ABI/stable/sysfs-hypervisor-xen
+++ b/Documentation/ABI/stable/sysfs-hypervisor-xen
@@ -120,3 +120,16 @@ Contact:	xen-devel@lists.xenproject.org
 Description:	If running under Xen:
 		The Xen version is in the format <major>.<minor><extra>
 		This is the <minor> part of it.
+
+What:		/sys/hypervisor/start_flags/*
+Date:		March 2023
+KernelVersion:	6.3.0
+Contact:	xen-devel@lists.xenproject.org
+Description:	If running under Xen:
+		All bits in Xen's start-flags are represented as
+		boolean files, returning '1' if set, '0' otherwise.
+		This takes the place of the defunct /proc/xen/capabilities,
+		which would contain "control_d" on dom0, and be empty
+		otherwise.  This flag is now exposed as "initdomain" in
+		addition to the "privileged" flag; all other possible flags
+		are accessible as "unknownXX".
diff --git a/drivers/xen/sys-hypervisor.c b/drivers/xen/sys-hypervisor.c
index fcb0792..ca092db 100644
--- a/drivers/xen/sys-hypervisor.c
+++ b/drivers/xen/sys-hypervisor.c
@@ -31,7 +31,10 @@ struct hyp_sysfs_attr {
 	struct attribute attr;
 	ssize_t (*show)(struct hyp_sysfs_attr *, char *);
 	ssize_t (*store)(struct hyp_sysfs_attr *, const char *, size_t);
-	void *hyp_attr_data;
+	union {
+		void *hyp_attr_data;
+		unsigned long hyp_attr_value;
+	};
 };
 
 static ssize_t type_show(struct hyp_sysfs_attr *attr, char *buffer)
@@ -399,6 +402,60 @@ static int __init xen_sysfs_properties_init(void)
 	return sysfs_create_group(hypervisor_kobj, &xen_properties_group);
 }
 
+#define FLAG_UNAME "unknown"
+#define FLAG_UNAME_FMT FLAG_UNAME "%02u"
+#define FLAG_UNAME_MAX sizeof(FLAG_UNAME "XX")
+#define FLAG_COUNT (sizeof(xen_start_flags) * BITS_PER_BYTE)
+static_assert(sizeof(xen_start_flags) <=
+	      sizeof_field(struct hyp_sysfs_attr, hyp_attr_value));
+
+static ssize_t flag_show(struct hyp_sysfs_attr *attr, char *buffer)
+{
+	char *p = buffer;
+
+	*p++ = '0' + ((xen_start_flags & attr->hyp_attr_value) != 0);
+	*p++ = '\n';
+	return p - buffer;
+}
+
+#define FLAG_NODE(flag, node)				\
+	[ilog2(flag)] = {				\
+		.attr = { .name = #node, .mode = 0444 },\
+		.show = flag_show,			\
+		.hyp_attr_value = flag			\
+	}
+
+/*
+ * Add new, known flags here.  No other changes are required, but
+ * note that each known flag wastes one entry in flag_unames[].
+ * The code/complexity machinations to avoid this isn't worth it
+ * for a few entries, but keep it in mind.
+ */
+static struct hyp_sysfs_attr flag_attrs[FLAG_COUNT] = {
+	FLAG_NODE(SIF_PRIVILEGED, privileged),
+	FLAG_NODE(SIF_INITDOMAIN, initdomain)
+};
+static struct attribute_group xen_flags_group = {
+	.name = "start_flags",
+	.attrs = (struct attribute *[FLAG_COUNT + 1]){}
+};
+static char flag_unames[FLAG_COUNT][FLAG_UNAME_MAX];
+
+static int __init xen_sysfs_flags_init(void)
+{
+	for (unsigned fnum = 0; fnum != FLAG_COUNT; fnum++) {
+		if (likely(flag_attrs[fnum].attr.name == NULL)) {
+			sprintf(flag_unames[fnum], FLAG_UNAME_FMT, fnum);
+			flag_attrs[fnum].attr.name = flag_unames[fnum];
+			flag_attrs[fnum].attr.mode = 0444;
+			flag_attrs[fnum].show = flag_show;
+			flag_attrs[fnum].hyp_attr_value = 1 << fnum;
+		}
+		xen_flags_group.attrs[fnum] = &flag_attrs[fnum].attr;
+	}
+	return sysfs_create_group(hypervisor_kobj, &xen_flags_group);
+}
+
 #ifdef CONFIG_XEN_HAVE_VPMU
 struct pmu_mode {
 	const char *name;
@@ -539,18 +596,22 @@ static int __init hyper_sysfs_init(void)
 	ret = xen_sysfs_properties_init();
 	if (ret)
 		goto prop_out;
+	ret = xen_sysfs_flags_init();
+	if (ret)
+		goto flags_out;
 #ifdef CONFIG_XEN_HAVE_VPMU
 	if (xen_initial_domain()) {
 		ret = xen_sysfs_pmu_init();
 		if (ret) {
-			sysfs_remove_group(hypervisor_kobj,
-					   &xen_properties_group);
-			goto prop_out;
+			sysfs_remove_group(hypervisor_kobj, &xen_flags_group);
+			goto flags_out;
 		}
 	}
 #endif
 	goto out;
 
+flags_out:
+	sysfs_remove_group(hypervisor_kobj, &xen_properties_group);
 prop_out:
 	sysfs_remove_file(hypervisor_kobj, &uuid_attr.attr);
 uuid_out:
