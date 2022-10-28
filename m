Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 108C6611418
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 16:09:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231474AbiJ1OJS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 10:09:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbiJ1OJJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 10:09:09 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1EC7E1E047C
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 07:09:08 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2C6401042;
        Fri, 28 Oct 2022 07:09:14 -0700 (PDT)
Received: from e120937-lin.. (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 312013F534;
        Fri, 28 Oct 2022 07:09:07 -0700 (PDT)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, cristian.marussi@arm.com
Subject: [PATCH 4/8] firmware: arm_scmi: Make RX chan_setup fail on memory errors
Date:   Fri, 28 Oct 2022 15:08:29 +0100
Message-Id: <20221028140833.280091-4-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221028140833.280091-1-cristian.marussi@arm.com>
References: <20221028140833.280091-1-cristian.marussi@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SCMI RX channels are optional and they can fail to be setup when not
present but anyway channels setup routines must bail-out on memory errors.

Make channels setup, and related probing, fail when memory errors are
reported on RX channels.

Fixes: 5c8a47a5a91d ("firmware: arm_scmi: Make scmi core independent of the transport type")
Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 drivers/firmware/arm_scmi/driver.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index 985775f210f9..f818d00bb2c6 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -2045,8 +2045,12 @@ scmi_txrx_setup(struct scmi_info *info, struct device *dev, int prot_id)
 {
 	int ret = scmi_chan_setup(info, dev, prot_id, true);
 
-	if (!ret) /* Rx is optional, hence no error check */
-		scmi_chan_setup(info, dev, prot_id, false);
+	if (!ret) {
+		/* Rx is optional, report only memory errors */
+		ret = scmi_chan_setup(info, dev, prot_id, false);
+		if (ret && ret != -ENOMEM)
+			ret = 0;
+	}
 
 	return ret;
 }
-- 
2.34.1

