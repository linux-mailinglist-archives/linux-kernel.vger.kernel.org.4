Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 227CC73D16B
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 16:22:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230459AbjFYOVx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 10:21:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230309AbjFYOVm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 10:21:42 -0400
Received: from smtp-fw-9105.amazon.com (smtp-fw-9105.amazon.com [207.171.188.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FEC91B1;
        Sun, 25 Jun 2023 07:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1687702902; x=1719238902;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=K9olSALxwiqvfXFwnOq4yhThTzE4wPH5nlr+cWBRTlc=;
  b=SDJIQhpc1bN1h3cyiCuMKxM5viemm/wEDp84rSIuQ1Pq8PfMwmjEI+XB
   UpY3w7fqJ2j+8q3qD2a6Y7wzbbVOlEC3f6u2RrXQJkk611Ntp6y9Uw9Lt
   Cyz1J7ZeKQsQ6VwAheq1rq3taYTJtq5s36enZri+g8J2R8ecgFJEYF28B
   A=;
X-IronPort-AV: E=Sophos;i="6.01,157,1684800000"; 
   d="scan'208";a="656892651"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-pdx-2c-m6i4x-e7094f15.us-west-2.amazon.com) ([10.25.36.214])
  by smtp-border-fw-9105.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2023 14:21:37 +0000
Received: from EX19MTAUWC002.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-pdx-2c-m6i4x-e7094f15.us-west-2.amazon.com (Postfix) with ESMTPS id B89B740D61;
        Sun, 25 Jun 2023 14:21:35 +0000 (UTC)
Received: from EX19D013UWB003.ant.amazon.com (10.13.138.111) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Sun, 25 Jun 2023 14:21:34 +0000
Received: from EX19MTAUWA001.ant.amazon.com (10.250.64.204) by
 EX19D013UWB003.ant.amazon.com (10.13.138.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Sun, 25 Jun 2023 14:21:34 +0000
Received: from dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com
 (172.19.116.181) by mail-relay.amazon.com (10.250.64.204) with Microsoft SMTP
 Server id 15.2.1118.26 via Frontend Transport; Sun, 25 Jun 2023 14:21:34
 +0000
Received: by dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com (Postfix, from userid 14301484)
        id 115AC5AA; Sun, 25 Jun 2023 14:21:34 +0000 (UTC)
From:   Eliav Farber <farbere@amazon.com>
To:     <giometti@enneenne.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <farbere@amazon.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <ronenk@amazon.com>, <talel@amazon.com>, <hhhawa@amazon.com>,
        <jonnyc@amazon.com>, <itamark@amazon.com>, <shellykz@amazon.com>,
        <amitlavi@amazon.com>, <almogbs@amazon.com>
Subject: [PATCH 1/5] pps: add pulse-width calculation in nsec
Date:   Sun, 25 Jun 2023 14:21:30 +0000
Message-ID: <20230625142134.33690-2-farbere@amazon.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230625142134.33690-1-farbere@amazon.com>
References: <20230625142134.33690-1-farbere@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This change adds PPS pulse-width calculation in nano seconds.
Width time can be calculated for both assert time and reset time.

Calculation can be done only if capture ASSERT and capture CLEAR modes
are both enabled.

Assert width is calculated as:
  clear-time - assert-time
and clear width is calculated as:
  assert-time - clear-time

Read-only sysfs were added to get the last pulse-width time and event
sequence.
Examples:
 * cat /sys/class/pps/pps0/pulse_width_assert
   20001450#85
 * cat /sys/class/pps/pps1/pulse_width_clear
   979893314#16

Signed-off-by: Eliav Farber <farbere@amazon.com>
---
 drivers/pps/kapi.c         | 49 ++++++++++++++++++++++++++++++++++++++
 drivers/pps/pps.c          |  9 +++++++
 drivers/pps/sysfs.c        | 30 +++++++++++++++++++++++
 include/linux/pps_kernel.h |  3 +++
 include/uapi/linux/pps.h   | 19 +++++++++++++++
 5 files changed, 110 insertions(+)

diff --git a/drivers/pps/kapi.c b/drivers/pps/kapi.c
index d9d566f70ed1..deeecfc0a3ee 100644
--- a/drivers/pps/kapi.c
+++ b/drivers/pps/kapi.c
@@ -82,6 +82,14 @@ struct pps_device *pps_register_source(struct pps_source_info *info,
 		goto pps_register_source_exit;
 	}
 
+	if ((info->mode & PPS_WIDTHBOTH) &&
+	    ((info->mode & PPS_CAPTUREBOTH) != PPS_CAPTUREBOTH)) {
+		pr_err("%s: width can't be calculated without both captures (mode = 0x%x)\n",
+		       info->name, info->mode);
+		err = -EINVAL;
+		goto pps_register_source_exit;
+	}
+
 	/* Allocate memory for the new PPS source struct */
 	pps = kzalloc(sizeof(struct pps_device), GFP_KERNEL);
 	if (pps == NULL) {
@@ -143,6 +151,39 @@ void pps_unregister_source(struct pps_device *pps)
 }
 EXPORT_SYMBOL(pps_unregister_source);
 
+static u64 pps_ktime_sub(struct pps_ktime *ts1, struct pps_ktime *ts2)
+{
+	if (ts1->sec == ts2->sec)
+		return (ts1->nsec > ts2->nsec) ? (ts1->nsec - ts2->nsec) : (ts2->nsec - ts1->nsec);
+
+	if (ts1->sec > ts2->sec)
+		return (ts1->sec - ts2->sec) * NSEC_PER_SEC + ts1->nsec - ts2->nsec;
+
+	return (ts2->sec - ts1->sec) * NSEC_PER_SEC + ts2->nsec - ts1->nsec;
+}
+
+static void pps_calc_clear_width(struct pps_device *pps)
+{
+	if (pps->clear_sequence == 0)
+		return;
+
+	pps->clear_width.sequence++;
+	pps->clear_width.nsec = pps_ktime_sub(&pps->assert_tu, &pps->clear_tu);
+	dev_dbg(pps->dev, "PPS clear width = %llu#%u\n",
+		pps->clear_width.nsec, pps->clear_width.sequence);
+}
+
+static void pps_calc_assert_width(struct pps_device *pps)
+{
+	if (pps->assert_sequence == 0)
+		return;
+
+	pps->assert_width.sequence++;
+	pps->assert_width.nsec = pps_ktime_sub(&pps->clear_tu, &pps->assert_tu);
+	dev_dbg(pps->dev, "PPS assert width = %llu#%u\n",
+		pps->assert_width.nsec, pps->assert_width.sequence);
+}
+
 /* pps_event - register a PPS event into the system
  * @pps: the PPS device
  * @ts: the event timestamp
@@ -191,6 +232,10 @@ void pps_event(struct pps_device *pps, struct pps_event_time *ts, int event,
 		dev_dbg(pps->dev, "capture assert seq #%u\n",
 			pps->assert_sequence);
 
+		/* Calculate clear pulse-width */
+		if (pps->params.mode & PPS_WIDTHCLEAR)
+			pps_calc_clear_width(pps);
+
 		captured = ~0;
 	}
 	if (event & pps->params.mode & PPS_CAPTURECLEAR) {
@@ -205,6 +250,10 @@ void pps_event(struct pps_device *pps, struct pps_event_time *ts, int event,
 		dev_dbg(pps->dev, "capture clear seq #%u\n",
 			pps->clear_sequence);
 
+		/* Calculate assert pulse-width */
+		if (pps->params.mode & PPS_WIDTHASSERT)
+			pps_calc_assert_width(pps);
+
 		captured = ~0;
 	}
 
diff --git a/drivers/pps/pps.c b/drivers/pps/pps.c
index 5d19baae6a38..8299a272af11 100644
--- a/drivers/pps/pps.c
+++ b/drivers/pps/pps.c
@@ -195,6 +195,11 @@ static long pps_cdev_ioctl(struct file *file,
 		fdata.info.clear_tu = pps->clear_tu;
 		fdata.info.current_mode = pps->current_mode;
 
+		memcpy(&fdata.info.assert_width, &pps->assert_width,
+		       sizeof(struct pps_kwidth));
+		memcpy(&fdata.info.clear_width, &pps->clear_width,
+		       sizeof(struct pps_kwidth));
+
 		spin_unlock_irq(&pps->lock);
 
 		err = copy_to_user(uarg, &fdata, sizeof(struct pps_fdata));
@@ -283,6 +288,10 @@ static long pps_cdev_compat_ioctl(struct file *file,
 				sizeof(struct pps_ktime_compat));
 		memcpy(&compat.info.clear_tu, &pps->clear_tu,
 				sizeof(struct pps_ktime_compat));
+		memcpy(&compat.info.assert_width, &pps->assert_width,
+		       sizeof(struct pps_kwidth_compat));
+		memcpy(&compat.info.clear_width, &pps->clear_width,
+		       sizeof(struct pps_kwidth_compat));
 
 		spin_unlock_irq(&pps->lock);
 
diff --git a/drivers/pps/sysfs.c b/drivers/pps/sysfs.c
index 134bc33f6ad0..3e34de77dba6 100644
--- a/drivers/pps/sysfs.c
+++ b/drivers/pps/sysfs.c
@@ -79,6 +79,34 @@ static ssize_t path_show(struct device *dev, struct device_attribute *attr,
 }
 static DEVICE_ATTR_RO(path);
 
+static ssize_t pulse_width_assert_show(struct device *dev,
+				       struct device_attribute *attr,
+				       char *buf)
+{
+	struct pps_device *pps = dev_get_drvdata(dev);
+
+	if (!(pps->info.mode & PPS_WIDTHASSERT))
+		return 0;
+
+	return sprintf(buf, "%llu#%u\n",
+		       pps->assert_width.nsec, pps->assert_width.sequence);
+}
+static DEVICE_ATTR_RO(pulse_width_assert);
+
+static ssize_t pulse_width_clear_show(struct device *dev,
+				      struct device_attribute *attr,
+				      char *buf)
+{
+	struct pps_device *pps = dev_get_drvdata(dev);
+
+	if (!(pps->info.mode & PPS_WIDTHCLEAR))
+		return 0;
+
+	return sprintf(buf, "%llu#%u\n",
+		       pps->clear_width.nsec, pps->clear_width.sequence);
+}
+static DEVICE_ATTR_RO(pulse_width_clear);
+
 static struct attribute *pps_attrs[] = {
 	&dev_attr_assert.attr,
 	&dev_attr_clear.attr,
@@ -86,6 +114,8 @@ static struct attribute *pps_attrs[] = {
 	&dev_attr_echo.attr,
 	&dev_attr_name.attr,
 	&dev_attr_path.attr,
+	&dev_attr_pulse_width_assert.attr,
+	&dev_attr_pulse_width_clear.attr,
 	NULL,
 };
 
diff --git a/include/linux/pps_kernel.h b/include/linux/pps_kernel.h
index 78c8ac4951b5..15f2338095c6 100644
--- a/include/linux/pps_kernel.h
+++ b/include/linux/pps_kernel.h
@@ -51,6 +51,9 @@ struct pps_device {
 	struct pps_ktime clear_tu;
 	int current_mode;			/* PPS mode at event time */
 
+	struct pps_kwidth assert_width;		/* PPS assert pulse-width time and event seq # */
+	struct pps_kwidth clear_width;		/* PPS clear pulse-width time and event seq # */
+
 	unsigned int last_ev;			/* last PPS event id */
 	wait_queue_head_t queue;		/* PPS event queue */
 
diff --git a/include/uapi/linux/pps.h b/include/uapi/linux/pps.h
index 009ebcd8ced5..dd93dac0afc1 100644
--- a/include/uapi/linux/pps.h
+++ b/include/uapi/linux/pps.h
@@ -64,12 +64,24 @@ struct pps_ktime_compat {
 } __attribute__((packed, aligned(4)));
 #define PPS_TIME_INVALID	(1<<0)	/* used to specify timeout==NULL */
 
+struct pps_kwidth {
+	__u64 nsec;
+	__u32 sequence;
+};
+
+struct pps_kwidth_compat {
+	__u64 nsec;
+	__u32 sequence;
+} __attribute__((packed, aligned(4)));
+
 struct pps_kinfo {
 	__u32 assert_sequence;		/* seq. num. of assert event */
 	__u32 clear_sequence; 		/* seq. num. of clear event */
 	struct pps_ktime assert_tu;	/* time of assert event */
 	struct pps_ktime clear_tu;	/* time of clear event */
 	int current_mode;		/* current mode bits */
+	struct pps_kwidth assert_width;	/* assert pulse-width time and seq. num. */
+	struct pps_kwidth clear_width;	/* clear pulse-width time and seq. num. */
 };
 
 struct pps_kinfo_compat {
@@ -78,6 +90,8 @@ struct pps_kinfo_compat {
 	struct pps_ktime_compat assert_tu;	/* time of assert event */
 	struct pps_ktime_compat clear_tu;	/* time of clear event */
 	int current_mode;			/* current mode bits */
+	struct pps_kwidth_compat assert_width;	/* assert pulse-width time and seq. num. */
+	struct pps_kwidth_compat clear_width;	/* clear pulse-width time and seq. num. */
 };
 
 struct pps_kparams {
@@ -96,6 +110,11 @@ struct pps_kparams {
 #define PPS_CAPTURECLEAR	0x02	/* capture clear events */
 #define PPS_CAPTUREBOTH		0x03	/* capture assert and clear events */
 
+/* Pulse-width calculation */
+#define PPS_WIDTHASSERT		0x04	/* calculate assert width */
+#define PPS_WIDTHCLEAR		0x08	/* calculate clear width */
+#define PPS_WIDTHBOTH		0x0c	/* calculate assert and clear width */
+
 #define PPS_OFFSETASSERT	0x10	/* apply compensation for assert event */
 #define PPS_OFFSETCLEAR		0x20	/* apply compensation for clear event */
 
-- 
2.40.1

