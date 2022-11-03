Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B987618907
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 20:54:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230336AbiKCTyE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 15:54:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230340AbiKCTxR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 15:53:17 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1ADFA20BD4
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 12:53:08 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2D3F123A;
        Thu,  3 Nov 2022 12:53:14 -0700 (PDT)
Received: from e120937-lin.fritz.box (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DFEA53F534;
        Thu,  3 Nov 2022 12:53:05 -0700 (PDT)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@Huawei.com, f.fainelli@gmail.com,
        etienne.carriere@linaro.org, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com, wleavitt@marvell.com,
        peter.hilber@opensynergy.com, nicola.mazzucato@arm.com,
        tarek.el-sherbiny@arm.com, quic_kshivnan@quicinc.com,
        cristian.marussi@arm.com
Subject: [PATCH v5 08/14] firmware: arm_scmi: Move errors defs and code to common.h
Date:   Thu,  3 Nov 2022 19:52:19 +0000
Message-Id: <20221103195225.1028864-9-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221103195225.1028864-1-cristian.marussi@arm.com>
References: <20221103195225.1028864-1-cristian.marussi@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move SCMI error codes definitions and helper to the common.h header
together with the delayed response timeout define.

No functional change.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 drivers/firmware/arm_scmi/common.h | 40 ++++++++++++++++++++++++++++++
 drivers/firmware/arm_scmi/driver.c | 40 ------------------------------
 2 files changed, 40 insertions(+), 40 deletions(-)

diff --git a/drivers/firmware/arm_scmi/common.h b/drivers/firmware/arm_scmi/common.h
index 2a08c2c50bf8..bb0763197ad6 100644
--- a/drivers/firmware/arm_scmi/common.h
+++ b/drivers/firmware/arm_scmi/common.h
@@ -27,6 +27,46 @@
 #include "protocols.h"
 #include "notify.h"
 
+#define SCMI_MAX_RESPONSE_TIMEOUT	(2 * MSEC_PER_SEC)
+
+enum scmi_error_codes {
+	SCMI_SUCCESS = 0,	/* Success */
+	SCMI_ERR_SUPPORT = -1,	/* Not supported */
+	SCMI_ERR_PARAMS = -2,	/* Invalid Parameters */
+	SCMI_ERR_ACCESS = -3,	/* Invalid access/permission denied */
+	SCMI_ERR_ENTRY = -4,	/* Not found */
+	SCMI_ERR_RANGE = -5,	/* Value out of range */
+	SCMI_ERR_BUSY = -6,	/* Device busy */
+	SCMI_ERR_COMMS = -7,	/* Communication Error */
+	SCMI_ERR_GENERIC = -8,	/* Generic Error */
+	SCMI_ERR_HARDWARE = -9,	/* Hardware Error */
+	SCMI_ERR_PROTOCOL = -10,/* Protocol Error */
+};
+
+static const int scmi_linux_errmap[] = {
+	/* better than switch case as long as return value is continuous */
+	0,			/* SCMI_SUCCESS */
+	-EOPNOTSUPP,		/* SCMI_ERR_SUPPORT */
+	-EINVAL,		/* SCMI_ERR_PARAM */
+	-EACCES,		/* SCMI_ERR_ACCESS */
+	-ENOENT,		/* SCMI_ERR_ENTRY */
+	-ERANGE,		/* SCMI_ERR_RANGE */
+	-EBUSY,			/* SCMI_ERR_BUSY */
+	-ECOMM,			/* SCMI_ERR_COMMS */
+	-EIO,			/* SCMI_ERR_GENERIC */
+	-EREMOTEIO,		/* SCMI_ERR_HARDWARE */
+	-EPROTO,		/* SCMI_ERR_PROTOCOL */
+};
+
+static inline int scmi_to_linux_errno(int errno)
+{
+	int err_idx = -errno;
+
+	if (err_idx >= SCMI_SUCCESS && err_idx < ARRAY_SIZE(scmi_linux_errmap))
+		return scmi_linux_errmap[err_idx];
+	return -EIO;
+}
+
 #define MSG_ID_MASK		GENMASK(7, 0)
 #define MSG_XTRACT_ID(hdr)	FIELD_GET(MSG_ID_MASK, (hdr))
 #define MSG_TYPE_MASK		GENMASK(9, 8)
diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index c4fd29f81b1e..9dcfe096cb2b 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -37,20 +37,6 @@
 #define CREATE_TRACE_POINTS
 #include <trace/events/scmi.h>
 
-enum scmi_error_codes {
-	SCMI_SUCCESS = 0,	/* Success */
-	SCMI_ERR_SUPPORT = -1,	/* Not supported */
-	SCMI_ERR_PARAMS = -2,	/* Invalid Parameters */
-	SCMI_ERR_ACCESS = -3,	/* Invalid access/permission denied */
-	SCMI_ERR_ENTRY = -4,	/* Not found */
-	SCMI_ERR_RANGE = -5,	/* Value out of range */
-	SCMI_ERR_BUSY = -6,	/* Device busy */
-	SCMI_ERR_COMMS = -7,	/* Communication Error */
-	SCMI_ERR_GENERIC = -8,	/* Generic Error */
-	SCMI_ERR_HARDWARE = -9,	/* Hardware Error */
-	SCMI_ERR_PROTOCOL = -10,/* Protocol Error */
-};
-
 /* List of all SCMI devices active in system */
 static LIST_HEAD(scmi_list);
 /* Protection for the entire list */
@@ -170,30 +156,6 @@ struct scmi_info {
 
 #define handle_to_scmi_info(h)	container_of(h, struct scmi_info, handle)
 
-static const int scmi_linux_errmap[] = {
-	/* better than switch case as long as return value is continuous */
-	0,			/* SCMI_SUCCESS */
-	-EOPNOTSUPP,		/* SCMI_ERR_SUPPORT */
-	-EINVAL,		/* SCMI_ERR_PARAM */
-	-EACCES,		/* SCMI_ERR_ACCESS */
-	-ENOENT,		/* SCMI_ERR_ENTRY */
-	-ERANGE,		/* SCMI_ERR_RANGE */
-	-EBUSY,			/* SCMI_ERR_BUSY */
-	-ECOMM,			/* SCMI_ERR_COMMS */
-	-EIO,			/* SCMI_ERR_GENERIC */
-	-EREMOTEIO,		/* SCMI_ERR_HARDWARE */
-	-EPROTO,		/* SCMI_ERR_PROTOCOL */
-};
-
-static inline int scmi_to_linux_errno(int errno)
-{
-	int err_idx = -errno;
-
-	if (err_idx >= SCMI_SUCCESS && err_idx < ARRAY_SIZE(scmi_linux_errmap))
-		return scmi_linux_errmap[err_idx];
-	return -EIO;
-}
-
 void scmi_notification_instance_data_set(const struct scmi_handle *handle,
 					 void *priv)
 {
@@ -1115,8 +1077,6 @@ static void reset_rx_to_maxsz(const struct scmi_protocol_handle *ph,
 	xfer->rx.len = info->desc->max_msg_size;
 }
 
-#define SCMI_MAX_RESPONSE_TIMEOUT	(2 * MSEC_PER_SEC)
-
 /**
  * do_xfer_with_response() - Do one transfer and wait until the delayed
  *	response is received
-- 
2.34.1

