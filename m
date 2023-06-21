Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD413737DA0
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 10:40:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231164AbjFUIXp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 04:23:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230093AbjFUIXl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 04:23:41 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69B11BC
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 01:23:40 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 35L8NVVS017505;
        Wed, 21 Jun 2023 03:23:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1687335811;
        bh=7qJOY+Amzwz8yZfUfEoE6qN1GmbOBZaC7WF4l2NdgGg=;
        h=From:To:CC:Subject:Date;
        b=V3dsNnMmemStoa0D4314MyMZ0/QO8lmYi1WR/BMmCwIrWmD+kiH59aGFefEj6JHhC
         eFtW4VoLp4xg3TINHg5IVLSS41Q2TPSb8CRfCUlyEoG4VOG5FIAncLIk+h8wVHXJK1
         DkVx+fFojgG/lqD6hlHLm/b3y/ldz1mAth7lvgvU=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 35L8NVpa042154
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 21 Jun 2023 03:23:31 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 21
 Jun 2023 03:23:30 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 21 Jun 2023 03:23:30 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 35L8NTIq069520;
        Wed, 21 Jun 2023 03:23:30 -0500
From:   Dhruva Gole <d-gole@ti.com>
To:     Nishanth Menon <nm@ti.com>
CC:     Praneeth <praneeth@ti.com>, Vignesh <vigneshr@ti.com>,
        Dhruva Gole <d-gole@ti.com>, Tero Kristo <kristo@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] firmware: ti_sci: Fix few compiler warnings
Date:   Wed, 21 Jun 2023 13:53:09 +0530
Message-ID: <20230621082309.1569239-1-d-gole@ti.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix below warnings:

 CC      drivers/firmware/ti_sci.o
drivers/firmware/ti_sci.c:1988: warning: Excess function parameter 'vint_irq' description in 'ti_sci_cmd_set_irq'
drivers/firmware/ti_sci.c:2036: warning: Excess function parameter 'vint_irq' description in 'ti_sci_cmd_free_irq'
drivers/firmware/ti_sci.c:2632: warning: Function parameter or member
...
drivers/firmware/ti_sci.c:2748: warning: expecting prototype for ti_sci_cmd_get_boot_status(). Prototype was for ti_sci_cmd_proc_get_status() instead
drivers/firmware/ti_sci.c:3267: warning: Function parameter or member 'sub_type' not described in 'devm_ti_sci_get_resource'
drivers/firmware/ti_sci.c:3267: warning: Excess function parameter 'suub_type' description in 'devm_ti_sci_get_resource'

Fixes: 1e407f337f40 ("firmware: ti_sci: Add support for processor control")
Signed-off-by: Dhruva Gole <d-gole@ti.com>
---
 drivers/firmware/ti_sci.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/firmware/ti_sci.c b/drivers/firmware/ti_sci.c
index 039d92a595ec..eca947bb35b9 100644
--- a/drivers/firmware/ti_sci.c
+++ b/drivers/firmware/ti_sci.c
@@ -1978,8 +1978,6 @@ static int ti_sci_free_irq(const struct ti_sci_handle *handle, u32 valid_params,
  * @src_index:		IRQ source index within the source device
  * @dst_id:		Device ID of the IRQ destination
  * @dst_host_irq:	IRQ number of the destination device
- * @vint_irq:		Boolean specifying if this interrupt belongs to
- *			Interrupt Aggregator.
  *
  * Return: 0 if all went fine, else return appropriate error.
  */
@@ -2026,8 +2024,6 @@ static int ti_sci_cmd_set_event_map(const struct ti_sci_handle *handle,
  * @src_index:		IRQ source index within the source device
  * @dst_id:		Device ID of the IRQ destination
  * @dst_host_irq:	IRQ number of the destination device
- * @vint_irq:		Boolean specifying if this interrupt belongs to
- *			Interrupt Aggregator.
  *
  * Return: 0 if all went fine, else return appropriate error.
  */
@@ -2736,7 +2732,7 @@ static int ti_sci_cmd_proc_set_control(const struct ti_sci_handle *handle,
 }
 
 /**
- * ti_sci_cmd_get_boot_status() - Command to get the processor boot status
+ * ti_sci_cmd_proc_get_status() - Command to get the processor boot status
  * @handle:	Pointer to TI SCI handle
  * @proc_id:	Processor ID this request is for
  *
@@ -3256,7 +3252,7 @@ EXPORT_SYMBOL_GPL(devm_ti_sci_get_of_resource);
  * @handle:	TISCI handle
  * @dev:	Device pointer to which the resource is assigned
  * @dev_id:	TISCI device id to which the resource is assigned
- * @suub_type:	TISCI resource subytpe representing the resource.
+ * @sub_type:	TISCI resource subytpe representing the resource.
  *
  * Return: Pointer to ti_sci_resource if all went well else appropriate
  *	   error pointer.
-- 
2.25.1

