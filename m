Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF91D65904B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 19:24:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233945AbiL2SYN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 13:24:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233771AbiL2SX7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 13:23:59 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9394C13F5F
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 10:23:58 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CBE10165C;
        Thu, 29 Dec 2022 10:24:39 -0800 (PST)
Received: from e120937-lin.. (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 66F0C3F71A;
        Thu, 29 Dec 2022 10:23:56 -0800 (PST)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@Huawei.com, f.fainelli@gmail.com,
        etienne.carriere@linaro.org, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com, wleavitt@marvell.com,
        peter.hilber@opensynergy.com, nicola.mazzucato@arm.com,
        tarek.el-sherbiny@arm.com, quic_kshivnan@quicinc.com,
        cristian.marussi@arm.com
Subject: [PATCH v6 04/17] firmware: arm_scmi: Add flags field to xfer
Date:   Thu, 29 Dec 2022 18:22:40 +0000
Message-Id: <20221229182253.948175-5-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221229182253.948175-1-cristian.marussi@arm.com>
References: <20221229182253.948175-1-cristian.marussi@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a flags field to xfer and define a flagbit and related macro to easily
identify xfers originated from Raw transmissions.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
v5 --> v6
- convert is_raw boolean to a bitflag
---
 drivers/firmware/arm_scmi/protocols.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/firmware/arm_scmi/protocols.h b/drivers/firmware/arm_scmi/protocols.h
index 2f3bf691db7c..b5941beb8b03 100644
--- a/drivers/firmware/arm_scmi/protocols.h
+++ b/drivers/firmware/arm_scmi/protocols.h
@@ -115,6 +115,7 @@ struct scmi_msg_hdr {
  *	    - SCMI_XFER_SENT_OK -> SCMI_XFER_RESP_OK [ -> SCMI_XFER_DRESP_OK ]
  *	    - SCMI_XFER_SENT_OK -> SCMI_XFER_DRESP_OK
  *	      (Missing synchronous response is assumed OK and ignored)
+ * @flags: Optional flags associated to this xfer.
  * @lock: A spinlock to protect state and busy fields.
  * @priv: A pointer for transport private usage.
  */
@@ -135,6 +136,9 @@ struct scmi_xfer {
 #define SCMI_XFER_RESP_OK	1
 #define SCMI_XFER_DRESP_OK	2
 	int state;
+#define SCMI_XFER_FLAG_IS_RAW	BIT(0)
+#define SCMI_XFER_IS_RAW(x)	((x)->flags & SCMI_XFER_FLAG_IS_RAW)
+	int flags;
 	/* A lock to protect state and busy fields */
 	spinlock_t lock;
 	void *priv;
-- 
2.34.1

