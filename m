Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D33626F181D
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 14:37:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345991AbjD1MhQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 08:37:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345913AbjD1MhB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 08:37:01 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4EC6D421E
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 05:37:00 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 23FBFC14;
        Fri, 28 Apr 2023 05:37:44 -0700 (PDT)
Received: from e109506.cambridge.arm.com (e109506.cambridge.arm.com [10.1.199.62])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B971B3F7D8;
        Fri, 28 Apr 2023 05:36:58 -0700 (PDT)
From:   Rahul Singh <rahul.singh@arm.com>
To:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Cc:     Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Samuel Holland <samuel@sholland.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Marc Zyngier <maz@kernel.org>,
        Jane Malalane <jane.malalane@citrix.com>,
        David Woodhouse <dwmw@amazon.co.uk>
Subject: [PATCH] xen/evtchn: Introduce new IOCTL to bind static evtchn
Date:   Fri, 28 Apr 2023 13:36:48 +0100
Message-Id: <48d30a439e37f6917b9a667289792c2b3f548d6d.1682685294.git.rahul.singh@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Xen 4.17 supports the creation of static evtchns. To allow user space
application to bind static evtchns introduce new ioctl
"IOCTL_EVTCHN_BIND_STATIC". Existing IOCTL doing more than binding
that’s why we need to introduce the new IOCTL to only bind the static
event channels.

Also, static evtchns to be available for use during the lifetime of the
guest. When the application exits, __unbind_from_irq() end up
being called from release() fop because of that static evtchns are
getting closed. To avoid closing the static event channel, add the new
bool variable "is_static" in "struct irq_info" to mark the event channel
static when creating the event channel to avoid closing the static
evtchn.

Signed-off-by: Rahul Singh <rahul.singh@arm.com>
---
 drivers/xen/events/events_base.c |  7 +++++--
 drivers/xen/evtchn.c             | 22 +++++++++++++++++-----
 include/uapi/xen/evtchn.h        |  9 +++++++++
 include/xen/events.h             |  2 +-
 4 files changed, 32 insertions(+), 8 deletions(-)

diff --git a/drivers/xen/events/events_base.c b/drivers/xen/events/events_base.c
index c7715f8bd452..31f2d3634ad5 100644
--- a/drivers/xen/events/events_base.c
+++ b/drivers/xen/events/events_base.c
@@ -112,6 +112,7 @@ struct irq_info {
 	unsigned int irq_epoch; /* If eoi_cpu valid: irq_epoch of event */
 	u64 eoi_time;           /* Time in jiffies when to EOI. */
 	raw_spinlock_t lock;
+	u8 is_static;           /* Is event channel static */
 
 	union {
 		unsigned short virq;
@@ -982,7 +983,8 @@ static void __unbind_from_irq(unsigned int irq)
 		unsigned int cpu = cpu_from_irq(irq);
 		struct xenbus_device *dev;
 
-		xen_evtchn_close(evtchn);
+		if (!info->is_static)
+			xen_evtchn_close(evtchn);
 
 		switch (type_from_irq(irq)) {
 		case IRQT_VIRQ:
@@ -1574,7 +1576,7 @@ int xen_set_irq_priority(unsigned irq, unsigned priority)
 }
 EXPORT_SYMBOL_GPL(xen_set_irq_priority);
 
-int evtchn_make_refcounted(evtchn_port_t evtchn)
+int evtchn_make_refcounted(evtchn_port_t evtchn, bool is_static)
 {
 	int irq = get_evtchn_to_irq(evtchn);
 	struct irq_info *info;
@@ -1590,6 +1592,7 @@ int evtchn_make_refcounted(evtchn_port_t evtchn)
 	WARN_ON(info->refcnt != -1);
 
 	info->refcnt = 1;
+	info->is_static = is_static;
 
 	return 0;
 }
diff --git a/drivers/xen/evtchn.c b/drivers/xen/evtchn.c
index c99415a70051..47681d4c696b 100644
--- a/drivers/xen/evtchn.c
+++ b/drivers/xen/evtchn.c
@@ -366,7 +366,8 @@ static int evtchn_resize_ring(struct per_user_data *u)
 	return 0;
 }
 
-static int evtchn_bind_to_user(struct per_user_data *u, evtchn_port_t port)
+static int evtchn_bind_to_user(struct per_user_data *u, evtchn_port_t port,
+			bool is_static)
 {
 	struct user_evtchn *evtchn;
 	struct evtchn_close close;
@@ -402,7 +403,7 @@ static int evtchn_bind_to_user(struct per_user_data *u, evtchn_port_t port)
 	if (rc < 0)
 		goto err;
 
-	rc = evtchn_make_refcounted(port);
+	rc = evtchn_make_refcounted(port, is_static);
 	return rc;
 
 err:
@@ -456,7 +457,7 @@ static long evtchn_ioctl(struct file *file,
 		if (rc != 0)
 			break;
 
-		rc = evtchn_bind_to_user(u, bind_virq.port);
+		rc = evtchn_bind_to_user(u, bind_virq.port, false);
 		if (rc == 0)
 			rc = bind_virq.port;
 		break;
@@ -482,7 +483,7 @@ static long evtchn_ioctl(struct file *file,
 		if (rc != 0)
 			break;
 
-		rc = evtchn_bind_to_user(u, bind_interdomain.local_port);
+		rc = evtchn_bind_to_user(u, bind_interdomain.local_port, false);
 		if (rc == 0)
 			rc = bind_interdomain.local_port;
 		break;
@@ -507,7 +508,7 @@ static long evtchn_ioctl(struct file *file,
 		if (rc != 0)
 			break;
 
-		rc = evtchn_bind_to_user(u, alloc_unbound.port);
+		rc = evtchn_bind_to_user(u, alloc_unbound.port, false);
 		if (rc == 0)
 			rc = alloc_unbound.port;
 		break;
@@ -536,6 +537,17 @@ static long evtchn_ioctl(struct file *file,
 		break;
 	}
 
+	case IOCTL_EVTCHN_BIND_STATIC: {
+		struct ioctl_evtchn_bind bind;
+
+		rc = -EFAULT;
+		if (copy_from_user(&bind, uarg, sizeof(bind)))
+			break;
+
+		rc = evtchn_bind_to_user(u, bind.port, true);
+		break;
+	}
+
 	case IOCTL_EVTCHN_NOTIFY: {
 		struct ioctl_evtchn_notify notify;
 		struct user_evtchn *evtchn;
diff --git a/include/uapi/xen/evtchn.h b/include/uapi/xen/evtchn.h
index 7fbf732f168f..aef2b75f3413 100644
--- a/include/uapi/xen/evtchn.h
+++ b/include/uapi/xen/evtchn.h
@@ -101,4 +101,13 @@ struct ioctl_evtchn_restrict_domid {
 	domid_t domid;
 };
 
+/*
+ * Bind statically allocated @port.
+ */
+#define IOCTL_EVTCHN_BIND_STATIC			\
+	_IOC(_IOC_NONE, 'E', 7, sizeof(struct ioctl_evtchn_bind))
+struct ioctl_evtchn_bind {
+	unsigned int port;
+};
+
 #endif /* __LINUX_PUBLIC_EVTCHN_H__ */
diff --git a/include/xen/events.h b/include/xen/events.h
index 44c2855c76d1..962f0bbc7ce1 100644
--- a/include/xen/events.h
+++ b/include/xen/events.h
@@ -69,7 +69,7 @@ int xen_set_irq_priority(unsigned irq, unsigned priority);
 /*
  * Allow extra references to event channels exposed to userspace by evtchn
  */
-int evtchn_make_refcounted(evtchn_port_t evtchn);
+int evtchn_make_refcounted(evtchn_port_t evtchn, bool is_static);
 int evtchn_get(evtchn_port_t evtchn);
 void evtchn_put(evtchn_port_t evtchn);
 
-- 
2.25.1

