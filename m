Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D8A76988AF
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 00:16:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbjBOXQH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 18:16:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbjBOXQG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 18:16:06 -0500
Received: from mx0a-0068d901.pphosted.com (mx0a-0068d901.pphosted.com [205.220.168.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE28B3E63F;
        Wed, 15 Feb 2023 15:15:57 -0800 (PST)
Received: from pps.filterd (m0278264.ppops.net [127.0.0.1])
        by mx0b-0068d901.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31FCJVtq016822;
        Wed, 15 Feb 2023 15:15:57 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=biamp.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=proofpoint;
 bh=TL+CCgNe2Mmpvu7piOA/eAlTyoqx1qIx4ZsFF/gdxHw=;
 b=bXUI0Ni2w3YnWyMKT3XP23nFP+VtVaUa8DiWWrE7C2GhROvAAVKOK/f/T3Y8xoG7r8cd
 wCApoVjora4Dwzs7Oo1JrZ5pBtjq3njWv58GzhT7YWC7xpG29qLsoFHp/CWz+sFFAeRN
 fqcQMcoByYD0+0d+wpessGvnY1cVp+jlzUgGWjphV+I7RU3tAbkhzCWkziCU71yIXjt1
 Wp+o3p4Q80cQELu2AasjLsA+kv1h16ms4Xamp9BLnP8cMjJ4EGzyfOS4Tj2+Yh9aSRxF
 oLCmfJiCb+rWBhaGyTIITEGIXn6hX2eTTYzzdJX1Q+LrhaBb3t2uwlcBi094XMhZxYPe Jg== 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2171.outbound.protection.outlook.com [104.47.59.171])
        by mx0b-0068d901.pphosted.com (PPS) with ESMTPS id 3npaxs33rn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Feb 2023 15:15:57 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hLZt70InxUonL9ClJpz/GfR36Lnd6ih49y9fmYzxmAVHsMZGwDFUxNMmhdyBfxUbds4pbqoAh4DZEj+T9KucvWtJyvxYVOJ0wKBkVmj7RE25ZeJvqTQ6Yv1F0r2fNXny6waicU6pMtTqFst5ixyk+aVJzxJ3H+3Uj1mVSi+1b7nFx15c57XgDi91vHS4EXpD5Oejcy4NszuFsXFb3J3VtL9XcHR+o9fLGA7likEmXSOeMM0MWoLkj4mUTKV2I2BaPLiUqVH37HU/xFNEvWTEqGxOT4whm66fCNe3CXM7Ko3SnbXxpe1L8+hn3hiE5zclm3K7wMgAZrdasrGNXizhhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TL+CCgNe2Mmpvu7piOA/eAlTyoqx1qIx4ZsFF/gdxHw=;
 b=B6HAlxSt58UKpuhgg3YWC0btabhpZ7s1/vBFNUju/qyh8Hy0B7hHHs5+u2Tg2JqUjXiBfs2iojRZckdeolYKmSjtp58yzktfJDlhSXxsKYnv9FI0zJvyYA0CMACDHratFxKpP0VMvqs9/rZTRCJaCrfMRTbVEjhJuhK421VaKFihdqPLOvUj/m1Wk+jfozt65xG68tsXswLBIwQ5gEZuYV8YmBjzffoMe3RlT8ahH2beb0WMcYg1FYj2uknPoyWpplJJ8oct043LkzOaqgYu6MXipKe7HCDlifWEEhqI6R77JaowqI1Yh6lE1tPRZ5WlcI+OLoYG6pRzRbRrJapWEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 50.203.150.150) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=biamp.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=biamp.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=biamp.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TL+CCgNe2Mmpvu7piOA/eAlTyoqx1qIx4ZsFF/gdxHw=;
 b=itb5w5s0IEcimioiGzPYbG4K2THcUduHszYlM1/FAH/6vNKqRCdMMmMbS7qP2HzAijASa5EcT5DdKAeImJPSrENVYjaMJGHFKxWTY5dLxr/XU1wlpB5Wn4YUaOrE3oDF8z9K8cQNnWPNNiCRsryrpgRaqkvUziC8NcngfISePTEkKYJW9b7DAPyvGmD/0nUhGmSbm9a3V26WwIlgsl12F/lsvbN9iy3YkTC90mqU8z0ysR2KtimEN4kC5L6l7qcjjS3LzGUuvOTc+fxAiPYfy/U9p55IdlE2LziWBh1OxKd3ynNBB/ZXDy2fNi4igWw6538Fn8LkdaJxq7ORX+lskQ==
Received: from DM6PR17CA0005.namprd17.prod.outlook.com (2603:10b6:5:1b3::18)
 by MW4PR17MB6008.namprd17.prod.outlook.com (2603:10b6:303:1bf::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.26; Wed, 15 Feb
 2023 23:15:54 +0000
Received: from DM3NAM02FT012.eop-nam02.prod.protection.outlook.com
 (2603:10b6:5:1b3:cafe::5c) by DM6PR17CA0005.outlook.office365.com
 (2603:10b6:5:1b3::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.26 via Frontend
 Transport; Wed, 15 Feb 2023 23:15:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 50.203.150.150)
 smtp.mailfrom=biamp.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=biamp.com;
Received-SPF: Pass (protection.outlook.com: domain of biamp.com designates
 50.203.150.150 as permitted sender) receiver=protection.outlook.com;
 client-ip=50.203.150.150; helo=biampwebapp1.biamp.com; pr=C
Received: from biampwebapp1.biamp.com (50.203.150.150) by
 DM3NAM02FT012.mail.protection.outlook.com (10.13.5.125) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.6111.12 via Frontend Transport; Wed, 15 Feb 2023 23:15:53 +0000
Received: from djs-build.biamp.com ([10.21.12.68]) by biampwebapp1.biamp.com over TLS secured channel with Microsoft SMTPSVC(8.5.9600.16384);
         Wed, 15 Feb 2023 15:15:41 -0800
From:   David Sands <david.sands@biamp.com>
To:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, david.sands3@gmail.com,
        David Sands <david.sands@biamp.com>
Subject: [PATCH RFC] USB: gadget: f_hid: Add GET_REPORT via userspace IOCTL
Date:   Thu, 16 Feb 2023 09:15:29 +1000
Message-Id: <20230215231529.2513236-1-david.sands@biamp.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 15 Feb 2023 23:15:42.0338 (UTC) FILETIME=[6CAC7620:01D94193]
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3NAM02FT012:EE_|MW4PR17MB6008:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 2f9b028b-aa97-4aac-66ad-08db0faa95c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R6XEVeg9gdmSbEphmc0gM//AhFJDJzlvE3jk87Y1MJ27YdIRMQ+8vpl+ZbjGeKXgRvhJ7/bq0+EfT/k+M1SL0vNa5i0Ob5h4FgA6zjNCJFRbufvs0US0dTPBlvmB+4NiAxIUcx1UNNm4b9Vt1VQ6th5MVqu3/gaUQoK28ApW1DpbIluqB+QaOxKNnYFtNFVLIAnh6iTSuLoVNH6mNzudsEdPMGdZ74YBZ1hoWUajT0IEmvX/3lI+ygRtONtX75ZZTM75rjyJflK3OzKrVUHsMjiQfNUuqEjoY0x6WCTXxzagb1UO8LeVse63vl5vJKL/hWlR98nvWgRN/cSo8RlEqLCv6daAQ9UTbdKMzP0aAXkPv6H34XUw7d/nJnBV6LsfHsK+JV4F/I25GMwgIR/WGM5uFGi8Z+pTPM/ty/iE9DkqMarIGy1XvjHxRGz75SXkW+B1FKxvDg3b0tx42a2c+3EcXGwS5ZEyCYNPuUzu5QrOQTg0nz8pSJEEN5npgXJY4fbRvlj0OoneFWXGHtij0bs8kcldBlfq/ZvcEU6DZT3myNbCawy0dCoT03X++qNCqDEf7t4dASrB6xZ1+/fjHp28R7myEzFb3Y9qRe1VRZMwM1qET7g8V4L188X9KfUzoiK9In1C51TesheB7vKBXFCg27lnB2kL43DE9wYLV0UjPluHmq4W/injT0nw/y1u
X-Forefront-Antispam-Report: CIP:50.203.150.150;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:biampwebapp1.biamp.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(39850400004)(346002)(396003)(376002)(136003)(451199018)(36840700001)(46966006)(82310400005)(2616005)(336012)(83380400001)(44832011)(2906002)(30864003)(36756003)(186003)(7696005)(478600001)(966005)(41300700001)(6666004)(107886003)(4326008)(1076003)(26005)(356005)(40480700001)(86362001)(426003)(36860700001)(81166007)(47076005)(316002)(8676002)(5660300002)(8936002)(82740400003)(70586007)(70206006)(450100002)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: biamp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2023 23:15:53.3355
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f9b028b-aa97-4aac-66ad-08db0faa95c9
X-MS-Exchange-CrossTenant-Id: 341ac572-066c-46f6-bf06-b2d0c7ddf1be
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=341ac572-066c-46f6-bf06-b2d0c7ddf1be;Ip=[50.203.150.150];Helo=[biampwebapp1.biamp.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT012.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR17MB6008
X-Proofpoint-GUID: P8-AUTg1Xof9fUEfUaQLsK9DXTgj7zgs
X-Proofpoint-ORIG-GUID: P8-AUTg1Xof9fUEfUaQLsK9DXTgj7zgs
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While supporting GET_REPORT is a mandatory request per the HID
specification the current implementation of the GET_REPORT request responds
to the USB Host with an empty reply of the request length. However, some
USB Hosts will request the contents of feature reports via the GET_REPORT
request. In addition, some proprietary HID 'protocols' will expect
different data, for the same report ID, to be to become available in the
feature report by sending a preceding SET_REPORT to the USB Device that
defines what data is to be presented when that feature report is
subsequently retrieved via GET_REPORT (with a very fast < 5ms turn around
between the SET_REPORT and the GET_REPORT).

There are two other patch sets already submitted for adding GET_REPORT
support. The first [1] allows for pre-priming a list of reports via IOCTLs
which then allows the USB Host to perform the request, with no further
userspace interaction possible during the GET_REPORT request. And another
[2] which allows for a single report to be setup by userspace via IOCTL,
which will be fetched and returned by the kernel for subsequent GET_REPORT
requests by the USB Host, also with no further userspace interaction
possible.

This patch, while loosely based on both the patch sets, differs by allowing
the option for userspace to respond to each GET_REPORT request by setting
up a poll to notify userspace that a new GET_REPORT request has arrived. To
support this, two extra IOCTLs are supplied. The first of which is used to
retrieve the report ID of the GET_REPORT request (in the case of having
non-zero report IDs in the HID descriptor). The second IOCTL allows for
storing report responses in a list for responding to requests.

The report responses are stored in a list (it will be either added if it
does not exist or updated if it exists already). A flag (userspace_req) can
be set to whether subsequent requests notify userspace or not.

Basic operation when a GET_REPORT request arrives from USB Host:

- If the report ID exists in the list and it is set for immediate return
  (i.e. userspace_req == false) then response is sent immediately,
userspace is not notified

- The report ID does not exist, or exists but is set to notify userspace
  (i.e. userspace_req == true) then notify userspace via poll:

	- If userspace responds, and either adds or update the response in
	  the list and respond to the host with the contents

	- If userspace does not respond within the fixed timeout (2500ms)
	  but the report has been set prevously, then send 'old' report
contents

	- If userspace does not respond within the fixed timeout (2500ms)
	  and the report does not exist in the list then send an empty
report

Note that userspace could 'prime' the report list at any other time.

While this patch allows for flexibility in how the system responds to
requests, and therefore the HID 'protocols' that could be supported, a
drawback is the time it takes to service the requests and therefore the
maximum throughput that would be achievable. The USB HID Specification
v1.11 itself states that GET_REPORT is not intended for periodic data
polling, so this limitation is not severe.

Testing on an iMX8M Nano Ultra Lite with a heavy multi-core CPU loading
showed that userspace can typically respond to the GET_REPORT request
within 1200ms - which is well within the 5000ms most operating systems seem
to allow, and within the 2500ms set by this patch.

[1] https://marc.info/?t=165968296600006 [2]
https://marc.info/?t=165879768900004

Signed-off-by: David Sands <david.sands@biamp.com>
---
 drivers/usb/gadget/function/f_hid.c | 234 +++++++++++++++++++++++++++-
 include/uapi/linux/usb/g_hid.h      |  26 ++++
 include/uapi/linux/usb/gadgetfs.h   |   2 +-
 3 files changed, 254 insertions(+), 8 deletions(-)
 create mode 100644 include/uapi/linux/usb/g_hid.h

diff --git a/drivers/usb/gadget/function/f_hid.c b/drivers/usb/gadget/function/f_hid.c
index ca0a7d9eaa34..a597864521be 100644
--- a/drivers/usb/gadget/function/f_hid.c
+++ b/drivers/usb/gadget/function/f_hid.c
@@ -15,18 +15,29 @@
 #include <linux/uaccess.h>
 #include <linux/wait.h>
 #include <linux/sched.h>
+#include <linux/workqueue.h>
 #include <linux/usb/g_hid.h>
+#include <uapi/linux/usb/g_hid.h>
 
 #include "u_f.h"
 #include "u_hid.h"
 
 #define HIDG_MINORS	4
 
+// Most operating systems seem to allow for 5000ms timeout, we will allow
+// userspace half that time to respond before we return an empty report.
+#define GET_REPORT_TIMEOUT_MS 2500
+
 static int major, minors;
 static struct class *hidg_class;
 static DEFINE_IDA(hidg_ida);
 static DEFINE_MUTEX(hidg_ida_lock); /* protects access to hidg_ida */
 
+struct report_entry {
+	struct usb_hidg_report report_data;
+	struct list_head node;
+};
+
 /*-------------------------------------------------------------------------*/
 /*                            HID gadget struct                            */
 
@@ -71,6 +82,18 @@ struct f_hidg {
 	wait_queue_head_t		write_queue;
 	struct usb_request		*req;
 
+	/* get report */
+	struct usb_request		*get_req;
+	struct usb_hidg_report		get_report;
+	bool				get_report_returned;
+	int				get_report_req_report_id;
+	int				get_report_req_report_length;
+	spinlock_t			get_report_spinlock;
+	wait_queue_head_t		get_queue;
+	struct work_struct		work;
+	struct workqueue_struct		*workqueue;
+	struct list_head		report_list;
+
 	int				minor;
 	struct cdev			cdev;
 	struct usb_function		func;
@@ -511,6 +534,155 @@ static ssize_t f_hidg_write(struct file *file, const char __user *buffer,
 	return status;
 }
 
+static struct report_entry *f_hidg_search_for_report(struct f_hidg *hidg, u8 report_id)
+{
+	struct list_head	*ptr;
+	struct report_entry	*entry;
+
+	list_for_each(ptr, &hidg->report_list) {
+		entry = list_entry(ptr, struct report_entry, node);
+		if (entry->report_data.report_id == report_id)
+			return entry;
+	}
+
+	return NULL;
+}
+
+void get_report_workqueue_handler(struct work_struct *work)
+{
+	struct f_hidg *hidg = container_of(work, struct f_hidg, work);
+	struct usb_composite_dev *cdev = hidg->func.config->cdev;
+	struct usb_request		*req  = hidg->get_req;
+	struct report_entry *ptr;
+	unsigned long	flags;
+
+	int status = 0;
+
+	req->zero = 0;
+	req->length = min_t(unsigned, hidg->get_report_req_report_length, hidg->report_length);
+
+	spin_lock_irqsave(&hidg->get_report_spinlock, flags);
+	// Check if there is a response available for immediate response
+	ptr = f_hidg_search_for_report(hidg, hidg->get_report_req_report_id);
+	if (ptr && !ptr->report_data.userspace_req) {
+		// Report exists in list and it is to be used for immediate response
+		req->buf = ptr->report_data.data;
+		status = usb_ep_queue(cdev->gadget->ep0, req, GFP_ATOMIC);
+		hidg->get_report_returned = true;
+		spin_unlock_irqrestore(&hidg->get_report_spinlock, flags);
+	} else {
+		// Report does not exist in list or should not be immediately sent
+		// i.e. give userspace time to respond
+		hidg->get_report_returned = false;
+		spin_unlock_irqrestore(&hidg->get_report_spinlock, flags);
+#define GET_REPORT_COND (!hidg->get_report_returned)
+		// Wait until userspace has responded or timeout
+		status = wait_event_interruptible_timeout(hidg->get_queue, !GET_REPORT_COND,
+					msecs_to_jiffies(GET_REPORT_TIMEOUT_MS));
+		spin_lock_irqsave(&hidg->get_report_spinlock, flags);
+		if (status == 0 && !hidg->get_report_returned) {
+			// GET_REPORT request was not serviced by userspace within timeout period
+			VDBG(cdev, "get_report : userspace timeout.\n");
+			hidg->get_report_returned = true;
+		}
+
+		// Search again for report ID in list and respond to GET_REPORT request
+		ptr = f_hidg_search_for_report(hidg, hidg->get_report_req_report_id);
+		if (ptr) {
+			// Either get an updated response just serviced by userspace
+			// or send the latest response in the list
+			req->buf = ptr->report_data.data;
+		} else {
+			// If there are no prevoiusly sent reports send empty report
+			req->buf = hidg->get_report.data;
+			memset(req->buf, 0x0, req->length);
+		}
+
+		status = usb_ep_queue(cdev->gadget->ep0, req, GFP_ATOMIC);
+		spin_unlock_irqrestore(&hidg->get_report_spinlock, flags);
+	}
+
+	if (status < 0)
+		VDBG(cdev, "usb_ep_queue error on ep0 responding to GET_REPORT\n");
+}
+
+static int f_hidg_get_report_id(struct file *file, __u8 __user *buffer)
+{
+	struct f_hidg			*hidg = file->private_data;
+	int ret = 0;
+
+	ret = put_user(hidg->get_report_req_report_id, buffer);
+
+	return ret;
+}
+
+static int f_hidg_get_report(struct file *file, struct usb_hidg_report __user *buffer)
+{
+	struct f_hidg			*hidg = file->private_data;
+	struct usb_composite_dev	*cdev = hidg->func.config->cdev;
+	unsigned long	flags;
+	struct report_entry *entry;
+	struct report_entry *ptr;
+	__u8 report_id;
+
+	entry = kmalloc(sizeof(*entry), GFP_KERNEL);
+	if (!entry)
+		return -ENOMEM;
+
+	if (copy_from_user(&entry->report_data, buffer,
+				sizeof(struct usb_hidg_report))) {
+		ERROR(cdev, "copy_from_user error\n");
+		kfree(entry);
+		return -EINVAL;
+	}
+
+	report_id = entry->report_data.report_id;
+
+	spin_lock_irqsave(&hidg->get_report_spinlock, flags);
+	ptr = f_hidg_search_for_report(hidg, report_id);
+
+	if (ptr) {
+		// Report already exists in list - update it
+		if (copy_from_user(&ptr->report_data, buffer,
+				sizeof(struct usb_hidg_report))) {
+			ERROR(cdev, "copy_from_user error\n");
+			kfree(entry);
+			return -EINVAL;
+		}
+		kfree(entry);
+	} else {
+		// Report does not exist in list - add it
+		list_add_tail(&entry->node, &hidg->report_list);
+	}
+
+	// If there is no response pending then do nothing further
+	if (hidg->get_report_returned) {
+		spin_unlock_irqrestore(&hidg->get_report_spinlock, flags);
+		return 0;
+	}
+
+	// If this userspace response serves the current pending report
+	if (hidg->get_report_req_report_id == report_id) {
+		hidg->get_report_returned = true;
+		wake_up(&hidg->get_queue);
+	}
+
+	spin_unlock_irqrestore(&hidg->get_report_spinlock, flags);
+	return 0;
+}
+
+static long f_hidg_ioctl(struct file *file, unsigned int code, unsigned long arg)
+{
+	switch (code) {
+	case GADGET_HID_READ_GET_REPORT_ID:
+		return f_hidg_get_report_id(file, (__u8 __user *)arg);
+	case GADGET_HID_WRITE_GET_REPORT:
+		return f_hidg_get_report(file, (struct usb_hidg_report __user *)arg);
+	default:
+		return -ENOTTY;
+	}
+}
+
 static __poll_t f_hidg_poll(struct file *file, poll_table *wait)
 {
 	struct f_hidg	*hidg  = file->private_data;
@@ -518,6 +690,7 @@ static __poll_t f_hidg_poll(struct file *file, poll_table *wait)
 
 	poll_wait(file, &hidg->read_queue, wait);
 	poll_wait(file, &hidg->write_queue, wait);
+	poll_wait(file, &hidg->get_queue, wait);
 
 	if (WRITE_COND)
 		ret |= EPOLLOUT | EPOLLWRNORM;
@@ -530,12 +703,16 @@ static __poll_t f_hidg_poll(struct file *file, poll_table *wait)
 			ret |= EPOLLIN | EPOLLRDNORM;
 	}
 
+	if (GET_REPORT_COND)
+		ret |= EPOLLPRI;
+
 	return ret;
 }
 
 #undef WRITE_COND
 #undef READ_COND_SSREPORT
 #undef READ_COND_INTOUT
+#undef GET_REPORT_COND
 
 static int f_hidg_release(struct inode *inode, struct file *fd)
 {
@@ -628,6 +805,10 @@ static void hidg_ssreport_complete(struct usb_ep *ep, struct usb_request *req)
 	wake_up(&hidg->read_queue);
 }
 
+static void hidg_get_report_complete(struct usb_ep *ep, struct usb_request *req)
+{
+}
+
 static int hidg_setup(struct usb_function *f,
 		const struct usb_ctrlrequest *ctrl)
 {
@@ -636,6 +817,7 @@ static int hidg_setup(struct usb_function *f,
 	struct usb_request		*req  = cdev->req;
 	int status = 0;
 	__u16 value, length;
+	unsigned long	flags;
 
 	value	= __le16_to_cpu(ctrl->wValue);
 	length	= __le16_to_cpu(ctrl->wLength);
@@ -647,14 +829,18 @@ static int hidg_setup(struct usb_function *f,
 	switch ((ctrl->bRequestType << 8) | ctrl->bRequest) {
 	case ((USB_DIR_IN | USB_TYPE_CLASS | USB_RECIP_INTERFACE) << 8
 		  | HID_REQ_GET_REPORT):
-		VDBG(cdev, "get_report\n");
+		VDBG(cdev, "get_report | wLength=%d\n", ctrl->wLength);
 
-		/* send an empty report */
-		length = min_t(unsigned, length, hidg->report_length);
-		memset(req->buf, 0x0, length);
+		// Update GET_REPORT ID so that an ioctl can be used to determine what
+		// GET_REPORT the request was actually for.
+		spin_lock_irqsave(&hidg->get_report_spinlock, flags);
+		hidg->get_report_req_report_id = value & 0xff;
+		hidg->get_report_req_report_length = length;
+		spin_unlock_irqrestore(&hidg->get_report_spinlock, flags);
 
-		goto respond;
-		break;
+		queue_work(hidg->workqueue, &hidg->work);
+
+		return status;
 
 	case ((USB_DIR_IN | USB_TYPE_CLASS | USB_RECIP_INTERFACE) << 8
 		  | HID_REQ_GET_PROTOCOL):
@@ -780,6 +966,13 @@ static void hidg_disable(struct usb_function *f)
 		spin_unlock_irqrestore(&hidg->read_spinlock, flags);
 	}
 
+	spin_lock_irqsave(&hidg->get_report_spinlock, flags);
+	if (!hidg->get_report_returned) {
+		usb_ep_free_request(f->config->cdev->gadget->ep0, hidg->get_req);
+		hidg->get_report_returned = true;
+	}
+	spin_unlock_irqrestore(&hidg->get_report_spinlock, flags);
+
 	spin_lock_irqsave(&hidg->write_spinlock, flags);
 	if (!hidg->write_pending) {
 		free_ep_req(hidg->in_ep, hidg->req);
@@ -896,6 +1089,7 @@ static const struct file_operations f_hidg_fops = {
 	.write		= f_hidg_write,
 	.read		= f_hidg_read,
 	.poll		= f_hidg_poll,
+	.unlocked_ioctl	= f_hidg_ioctl,
 	.llseek		= noop_llseek,
 };
 
@@ -908,6 +1102,15 @@ static int hidg_bind(struct usb_configuration *c, struct usb_function *f)
 	int			status;
 	dev_t			dev;
 
+	hidg->get_req = usb_ep_alloc_request(c->cdev->gadget->ep0, GFP_ATOMIC);
+	if (!hidg->get_req)
+		return -ENOMEM;
+
+	hidg->get_req->zero = 0;
+	hidg->get_req->complete = hidg_get_report_complete;
+	hidg->get_req->context = hidg;
+	hidg->get_report_returned = true;
+
 	/* maybe allocate device-global string IDs, and patch descriptors */
 	us = usb_gstrings_attach(c->cdev, ct_func_strings,
 				 ARRAY_SIZE(ct_func_string_defs));
@@ -993,9 +1196,23 @@ static int hidg_bind(struct usb_configuration *c, struct usb_function *f)
 	hidg->write_pending = 1;
 	hidg->req = NULL;
 	spin_lock_init(&hidg->read_spinlock);
+	spin_lock_init(&hidg->get_report_spinlock);
 	init_waitqueue_head(&hidg->write_queue);
 	init_waitqueue_head(&hidg->read_queue);
+	init_waitqueue_head(&hidg->get_queue);
 	INIT_LIST_HEAD(&hidg->completed_out_req);
+	INIT_LIST_HEAD(&hidg->report_list);
+
+	INIT_WORK(&hidg->work, get_report_workqueue_handler);
+	hidg->workqueue = alloc_workqueue("report_work",
+					  WQ_FREEZABLE |
+					  WQ_MEM_RECLAIM,
+					  1);
+
+	if (!hidg->workqueue) {
+		status = -ENOMEM;
+		goto fail;
+	}
 
 	/* create char device */
 	cdev_init(&hidg->cdev, &f_hidg_fops);
@@ -1015,12 +1232,15 @@ static int hidg_bind(struct usb_configuration *c, struct usb_function *f)
 del:
 	cdev_del(&hidg->cdev);
 fail_free_descs:
+	destroy_workqueue(hidg->workqueue);
 	usb_free_all_descriptors(f);
 fail:
 	ERROR(f->config->cdev, "hidg_bind FAILED\n");
 	if (hidg->req != NULL)
 		free_ep_req(hidg->in_ep, hidg->req);
 
+	usb_ep_free_request(c->cdev->gadget->ep0, hidg->get_req);
+
 	return status;
 }
 
@@ -1258,7 +1478,7 @@ static void hidg_unbind(struct usb_configuration *c, struct usb_function *f)
 
 	device_destroy(hidg_class, MKDEV(major, hidg->minor));
 	cdev_del(&hidg->cdev);
-
+	destroy_workqueue(hidg->workqueue);
 	usb_free_all_descriptors(f);
 }
 
diff --git a/include/uapi/linux/usb/g_hid.h b/include/uapi/linux/usb/g_hid.h
new file mode 100644
index 000000000000..d48b33a1d5bd
--- /dev/null
+++ b/include/uapi/linux/usb/g_hid.h
@@ -0,0 +1,26 @@
+/* SPDX-License-Identifier: GPL-2.0+ WITH Linux-syscall-note */
+
+#ifndef __UAPI_LINUX_USB_G_HID_H
+#define __UAPI_LINUX_USB_G_HID_H
+
+#include <linux/types.h>
+
+// Maximum HID report length for High-Speed USB (i.e. USB 2.0)
+#define MAX_REPORT_LENGTH 64
+
+struct usb_hidg_report {
+	__u8 report_id;
+	bool userspace_req;
+	__u16 length;
+	__u8 data[MAX_REPORT_LENGTH];
+};
+
+/* The 'g' code is also used by gadgetfs and hid gadget ioctl requests.
+ * Don't add any colliding codes to either driver, and keep
+ * them in unique ranges (size 0x20 for now).
+ */
+
+#define GADGET_HID_READ_GET_REPORT_ID   _IOR('g', 0x41, __u8)
+#define GADGET_HID_WRITE_GET_REPORT     _IOW('g', 0x42, struct usb_hidg_report)
+
+#endif /* __UAPI_LINUX_USB_G_HID_H */
diff --git a/include/uapi/linux/usb/gadgetfs.h b/include/uapi/linux/usb/gadgetfs.h
index 835473910a49..9754822b2a40 100644
--- a/include/uapi/linux/usb/gadgetfs.h
+++ b/include/uapi/linux/usb/gadgetfs.h
@@ -62,7 +62,7 @@ struct usb_gadgetfs_event {
 };
 
 
-/* The 'g' code is also used by printer gadget ioctl requests.
+/* The 'g' code is also used by printer and hid gadget ioctl requests.
  * Don't add any colliding codes to either driver, and keep
  * them in unique ranges (size 0x20 for now).
  */
-- 
2.34.1

