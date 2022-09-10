Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 314375B4846
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Sep 2022 21:45:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229853AbiIJToI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Sep 2022 15:44:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbiIJTnn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Sep 2022 15:43:43 -0400
Received: from mail.baikalelectronics.com (mail.baikalelectronics.com [87.245.175.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5CA1D48E8A;
        Sat, 10 Sep 2022 12:43:25 -0700 (PDT)
Received: from mail (mail.baikal.int [192.168.51.25])
        by mail.baikalelectronics.com (Postfix) with ESMTP id A097ADBF;
        Sat, 10 Sep 2022 22:46:38 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.baikalelectronics.com A097ADBF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baikalelectronics.ru; s=mail; t=1662839198;
        bh=ku2sYIdDCpIzYeNMqu4LiBoNWiaOdD7lQuvBRvoz8cw=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=bh7GFqDwmtOgZWT3v9J1eVEQxt93og8lBZ5aJ77yF7uDTvhI8Uqs+ASZ2R+TNvdNL
         V1B1fAngHN1NQlDj86v6K2lPMPmMT9pwEsiQE74iFrZd5UDp0EycwOh81iLpbSB/6C
         LlKya7/4XZo4cpkBrHo32vLGW4fgpl/XR84WnhB0=
Received: from localhost (192.168.168.10) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Sat, 10 Sep 2022 22:42:47 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rric@kernel.org>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Michail Ivanov <Michail.Ivanov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Punnaiah Choudary Kalluri 
        <punnaiah.choudary.kalluri@xilinx.com>,
        Manish Narani <manish.narani@xilinx.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 11/19] EDAC/synopsys: Drop redundant info from error message
Date:   Sat, 10 Sep 2022 22:42:29 +0300
Message-ID: <20220910194237.10142-12-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20220910194237.10142-1-Sergey.Semin@baikalelectronics.ru>
References: <20220910194237.10142-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the custom error message is too long so the corresponding log
messages printed in several lines. There is some duplicated/redundant
information we can remove from it. First of all we can shorten it out by
dropping the message prefix "DDR ECC error type:%s". Indeed the text
printed to the console later by the edac_mc_printk() method will contain
the error type and the memory controller id referring to the device
detected the error. So having the same info in the custom part of the
same message is useless especially seeing the string has got too long
already. Secondly referring to the corrected bit as "Bit Position" is
redundant since saying just "Bit" is not that less descriptive. Let's
drop all of these parts of the error message then so to have a shorter
but still informative enough log message.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
---
 drivers/edac/synopsys_edac.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/edac/synopsys_edac.c b/drivers/edac/synopsys_edac.c
index 2740f6c8c249..5088634bc213 100644
--- a/drivers/edac/synopsys_edac.c
+++ b/drivers/edac/synopsys_edac.c
@@ -484,13 +484,13 @@ static void handle_error(struct mem_ctl_info *mci, struct synps_ecc_status *p)
 		pinf = &p->ceinfo;
 		if (priv->p_data->quirks & DDR_ECC_INTR_SUPPORT) {
 			snprintf(priv->message, SYNPS_EDAC_MSG_SIZE,
-				 "DDR ECC error type:%s Row %d Col %d Bank %d Bank Group %d Bit Position: %d Data: 0x%08x",
-				 "CE", pinf->row, pinf->col, pinf->bank,
-				 pinf->bankgrp, pinf->bitpos, pinf->data);
+				 "Row %d Col %d Bank %d Bank Group %d Bit %d Data 0x%08x",
+				 pinf->row, pinf->col, pinf->bank, pinf->bankgrp,
+				 pinf->bitpos, pinf->data);
 		} else {
 			snprintf(priv->message, SYNPS_EDAC_MSG_SIZE,
-				 "DDR ECC error type:%s Row %d Bank %d Col %d Bit Position: %d Data: 0x%08x",
-				 "CE", pinf->row, pinf->bank, pinf->col,
+				 "Row %d Bank %d Col %d Bit: %d Data: 0x%08x",
+				 pinf->row, pinf->bank, pinf->col,
 				 pinf->bitpos, pinf->data);
 		}
 
@@ -503,13 +503,12 @@ static void handle_error(struct mem_ctl_info *mci, struct synps_ecc_status *p)
 		pinf = &p->ueinfo;
 		if (priv->p_data->quirks & DDR_ECC_INTR_SUPPORT) {
 			snprintf(priv->message, SYNPS_EDAC_MSG_SIZE,
-				 "DDR ECC error type :%s Row %d Col %d Bank %d Bank Group %d",
-				 "UE", pinf->row, pinf->col, pinf->bank,
-				 pinf->bankgrp);
+				 "Row %d Col %d Bank %d Bank Group %d",
+				 pinf->row, pinf->col, pinf->bank, pinf->bankgrp);
 		} else {
 			snprintf(priv->message, SYNPS_EDAC_MSG_SIZE,
-				 "DDR ECC error type :%s Row %d Bank %d Col %d ",
-				 "UE", pinf->row, pinf->bank, pinf->col);
+				 "Row %d Bank %d Col %d",
+				 pinf->row, pinf->bank, pinf->col);
 		}
 
 		edac_mc_handle_error(HW_EVENT_ERR_UNCORRECTED, mci,
-- 
2.37.2

