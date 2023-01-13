Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B528C66A4F0
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 22:14:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230452AbjAMVOQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 16:14:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231358AbjAMVNX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 16:13:23 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5DB0F8CBEA
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 13:12:42 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E039EFEC;
        Fri, 13 Jan 2023 13:13:23 -0800 (PST)
Received: from e120937-lin.. (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ED8D83F587;
        Fri, 13 Jan 2023 13:12:39 -0800 (PST)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@Huawei.com, f.fainelli@gmail.com,
        etienne.carriere@linaro.org, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com, wleavitt@marvell.com,
        peter.hilber@opensynergy.com, nicola.mazzucato@arm.com,
        tarek.el-sherbiny@arm.com, quic_kshivnan@quicinc.com,
        cristian.marussi@arm.com
Subject: [PATCH v7 14/17] firmware: arm_scmi: Reject SCMI drivers while in Raw mode
Date:   Fri, 13 Jan 2023 21:11:32 +0000
Message-Id: <20230113211135.2530064-15-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230113211135.2530064-1-cristian.marussi@arm.com>
References: <20230113211135.2530064-1-cristian.marussi@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reject SCMI driver registration when SCMI Raw mode support is configured,
so as to avoid interferences between the SCMI Raw mode transactions and the
normal SCMI stack operations.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 drivers/firmware/arm_scmi/bus.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/firmware/arm_scmi/bus.c b/drivers/firmware/arm_scmi/bus.c
index 6228f1581fe3..8601d75f5b9b 100644
--- a/drivers/firmware/arm_scmi/bus.c
+++ b/drivers/firmware/arm_scmi/bus.c
@@ -59,6 +59,12 @@ static int scmi_protocol_device_request(const struct scmi_device_id *id_table)
 	pr_debug("Requesting SCMI device (%s) for protocol %x\n",
 		 id_table->name, id_table->protocol_id);
 
+	if (IS_ENABLED(CONFIG_ARM_SCMI_RAW_MODE_SUPPORT)) {
+		pr_warn("SCMI Raw mode active. Rejecting '%s'/0x%02X\n",
+			id_table->name, id_table->protocol_id);
+		return -EINVAL;
+	}
+
 	/*
 	 * Search for the matching protocol rdev list and then search
 	 * of any existent equally named device...fails if any duplicate found.
-- 
2.34.1

