Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 915CB5F3F5F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 11:21:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231135AbiJDJVu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 05:21:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230512AbiJDJVW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 05:21:22 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D58653D17
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 02:20:19 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1ofe5m-000210-6m; Tue, 04 Oct 2022 11:19:58 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1ofe5l-004XGK-7w; Tue, 04 Oct 2022 11:19:55 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1ofe5j-005UyX-4r; Tue, 04 Oct 2022 11:19:55 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     kernel@pengutronix.de, Ingo Molnar <mingo@redhat.com>,
        linux-watchdog@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] watchdog: Add tracing events for the most usual watchdog events
Date:   Tue,  4 Oct 2022 11:19:49 +0200
Message-Id: <20221004091950.3419662-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=5467; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=SR68HLWikkZtLUzmsHW+xlak1o3zto6xxI46z3CUIHc=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBjO/qymoD42ekW8qVYAl41KnukjUbCoq4SPhfvhQF9 4TqvSKSJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCYzv6sgAKCRDB/BR4rcrsCWavCA CMLki+z8J3tAXxMiyfUZ5G9WdMfQLMjftyodXNu2y9IQ1nJJclCyqdlXnG9QDRBkpcrMmCTlJF9G0R 1C2+tTsxJ5XvuFCCplYUknosyQFIaMPp1w/fkGA/Ik2FcjW3WCq3bgWdJv+J4/4r9gO2DnTiLSpHKp Ue0378BSvpar6OD+eAzyl4wyxFpiVLrjWg21t7DY7xTxNQNSfXNPzqFCZGho8DBfmiXSnpbjhIVzm6 c0aSPeE70XD+4rAfVovFQ8JrJ1pk9R7VzLwijb8EDUvBV86IOpFa+r8GMAwiogVndbWJAL9kdsyB0S +iMs0PIERlfTP14U3jlau81JRoQaKJ
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To simplify debugging which process touches a watchdog and when, add
tracing events for .start(), .set_timeout(), .ping() and .stop().

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
Changes since (implict) v1 sent with Message-Id:
20220930144935.3373366-1-u.kleine-koenig@pengutronix.de:

 - Make use of DECLARE_EVENT_CLASS as {requ,sugg}ested by Steven.

Best regards
Uwe

 MAINTAINERS                      |  1 +
 drivers/watchdog/watchdog_core.c |  4 ++
 drivers/watchdog/watchdog_dev.c  | 12 +++++-
 include/trace/events/watchdog.h  | 66 ++++++++++++++++++++++++++++++++
 4 files changed, 81 insertions(+), 2 deletions(-)
 create mode 100644 include/trace/events/watchdog.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 72b9654f764c..507de599116b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21890,6 +21890,7 @@ F:	Documentation/watchdog/
 F:	drivers/watchdog/
 F:	include/linux/watchdog.h
 F:	include/uapi/linux/watchdog.h
+F:	include/trace/events/watchdog.h
 
 WHISKEYCOVE PMIC GPIO DRIVER
 M:	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
diff --git a/drivers/watchdog/watchdog_core.c b/drivers/watchdog/watchdog_core.c
index 3fe8a7edc252..c777a612d932 100644
--- a/drivers/watchdog/watchdog_core.c
+++ b/drivers/watchdog/watchdog_core.c
@@ -38,6 +38,9 @@
 
 #include "watchdog_core.h"	/* For watchdog_dev_register/... */
 
+#define CREATE_TRACE_POINTS
+#include <trace/events/watchdog.h>
+
 static DEFINE_IDA(watchdog_ida);
 
 static int stop_on_reboot = -1;
@@ -163,6 +166,7 @@ static int watchdog_reboot_notifier(struct notifier_block *nb,
 			int ret;
 
 			ret = wdd->ops->stop(wdd);
+			trace_watchdog_stop(wdd, ret);
 			if (ret)
 				return NOTIFY_BAD;
 		}
diff --git a/drivers/watchdog/watchdog_dev.c b/drivers/watchdog/watchdog_dev.c
index 54903f3c851e..3323309c913c 100644
--- a/drivers/watchdog/watchdog_dev.c
+++ b/drivers/watchdog/watchdog_dev.c
@@ -47,6 +47,8 @@
 #include "watchdog_core.h"
 #include "watchdog_pretimeout.h"
 
+#include <trace/events/watchdog.h>
+
 /* the dev_t structure to store the dynamically allocated watchdog devices */
 static dev_t watchdog_devt;
 /* Reference to watchdog device behind /dev/watchdog */
@@ -157,10 +159,13 @@ static int __watchdog_ping(struct watchdog_device *wdd)
 
 	wd_data->last_hw_keepalive = now;
 
-	if (wdd->ops->ping)
+	if (wdd->ops->ping) {
 		err = wdd->ops->ping(wdd);  /* ping the watchdog */
-	else
+		trace_watchdog_ping(wdd, err);
+	} else {
 		err = wdd->ops->start(wdd); /* restart watchdog */
+		trace_watchdog_start(wdd, err);
+	}
 
 	if (err == 0)
 		watchdog_hrtimer_pretimeout_start(wdd);
@@ -259,6 +264,7 @@ static int watchdog_start(struct watchdog_device *wdd)
 		}
 	} else {
 		err = wdd->ops->start(wdd);
+		trace_watchdog_start(wdd, err);
 		if (err == 0) {
 			set_bit(WDOG_ACTIVE, &wdd->status);
 			wd_data->last_keepalive = started_at;
@@ -297,6 +303,7 @@ static int watchdog_stop(struct watchdog_device *wdd)
 	if (wdd->ops->stop) {
 		clear_bit(WDOG_HW_RUNNING, &wdd->status);
 		err = wdd->ops->stop(wdd);
+		trace_watchdog_stop(wdd, err);
 	} else {
 		set_bit(WDOG_HW_RUNNING, &wdd->status);
 	}
@@ -369,6 +376,7 @@ static int watchdog_set_timeout(struct watchdog_device *wdd,
 
 	if (wdd->ops->set_timeout) {
 		err = wdd->ops->set_timeout(wdd, timeout);
+		trace_watchdog_set_timeout(wdd, timeout, err);
 	} else {
 		wdd->timeout = timeout;
 		/* Disable pretimeout if it doesn't fit the new timeout */
diff --git a/include/trace/events/watchdog.h b/include/trace/events/watchdog.h
new file mode 100644
index 000000000000..77802d0d8c09
--- /dev/null
+++ b/include/trace/events/watchdog.h
@@ -0,0 +1,66 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM watchdog
+
+#if !defined(_TRACE_WATCHDOG_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_WATCHDOG_H
+
+#include <linux/watchdog.h>
+#include <linux/tracepoint.h>
+
+DECLARE_EVENT_CLASS(watchdog_template,
+
+	TP_PROTO(struct watchdog_device *wdd, int err),
+
+	TP_ARGS(wdd, err),
+
+	TP_STRUCT__entry(
+		__field(int, id)
+		__field(int, err)
+	),
+
+	TP_fast_assign(
+		__entry->id = wdd->id;
+		__entry->err = err;
+	),
+
+	TP_printk("watchdog%d err=%d", __entry->id, __entry->err)
+);
+
+DEFINE_EVENT(watchdog_template, watchdog_start,
+	TP_PROTO(struct watchdog_device *wdd, int err),
+	TP_ARGS(wdd, err));
+
+TRACE_EVENT(watchdog_set_timeout,
+
+	TP_PROTO(struct watchdog_device *wdd, unsigned int timeout, int err),
+
+	TP_ARGS(wdd, timeout, err),
+
+	TP_STRUCT__entry(
+		__field(int, id)
+		__field(unsigned int, timeout)
+		__field(int, err)
+	),
+
+	TP_fast_assign(
+		__entry->id = wdd->id;
+		__entry->timeout = timeout;
+		__entry->err = err;
+	),
+
+	TP_printk("watchdog%d timeout=%u err=%d", __entry->id, __entry->timeout, __entry->err)
+);
+
+DEFINE_EVENT(watchdog_template, watchdog_ping,
+	TP_PROTO(struct watchdog_device *wdd, int err),
+	TP_ARGS(wdd, err));
+
+DEFINE_EVENT(watchdog_template, watchdog_stop,
+	TP_PROTO(struct watchdog_device *wdd, int err),
+	TP_ARGS(wdd, err));
+
+#endif /* !defined(_TRACE_WATCHDOG_H) || defined(TRACE_HEADER_MULTI_READ) */
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>

base-commit: 4fe89d07dcc2804c8b562f6c7896a45643d34b2f
-- 
2.37.2

