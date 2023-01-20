Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 514E8675782
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 15:40:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbjATOkP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 09:40:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230077AbjATOkF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 09:40:05 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B540E42BFA
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 06:39:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1674225569; x=1705761569;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FCOl+T+5C62VF4k5ASrJAWhazXtjeEzsINHVVaIW+hk=;
  b=BZGfal6b9V7vhVSLhQo9C76kBTqnV/Lh3b2O8YQ924WEB8UOF+T0+RIn
   hkMuRXLsl1+PCPcxjZlMpntouM3laDJpHrATZlGqGrhnaaTLpM+Q0eB6y
   D5XjB06rHLnfm2CsMcWKkem1B7bnpPWIQxs9iidqfrhRHXn5+lz7BlmYo
   v8MiEKuBrNQ0Uja9vi8oSd/YdyxViwptlTRYQhwx56r3ean4x7KWcsiOQ
   rmMvMDIDoFsNMIIBBAoUKNibrzvb7Pd9pMyQ7ca/IW76wBzBSXv13aBva
   RNTLMBfILYtd/qE68yxei4pf/kYErvt8dl0hgX0WQvU6oJaTdNn+kKJ+y
   Q==;
X-IronPort-AV: E=Sophos;i="5.97,232,1669100400"; 
   d="scan'208";a="196713305"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 20 Jan 2023 07:38:14 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 20 Jan 2023 07:38:14 -0700
Received: from wendy.microchip.com (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.16 via Frontend
 Transport; Fri, 20 Jan 2023 07:38:13 -0700
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Jassi Brar <jassisinghbrar@gmail.com>
CC:     Conor Dooley <conor.dooley@microchip.com>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 3/7] mailbox: mpfs: ditch a useless busy check
Date:   Fri, 20 Jan 2023 14:37:31 +0000
Message-ID: <20230120143734.3438755-4-conor.dooley@microchip.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230120143734.3438755-1-conor.dooley@microchip.com>
References: <20230120143734.3438755-1-conor.dooley@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mpfs_mbox_rx_data() already checks if the system controller is busy
before attempting to do anything, so drop the second check before
reading any data.

No functional change intended.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 drivers/mailbox/mailbox-mpfs.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/mailbox/mailbox-mpfs.c b/drivers/mailbox/mailbox-mpfs.c
index e0e825bdbad9..0d176aba3462 100644
--- a/drivers/mailbox/mailbox-mpfs.c
+++ b/drivers/mailbox/mailbox-mpfs.c
@@ -170,12 +170,10 @@ static void mpfs_mbox_rx_data(struct mbox_chan *chan)
 	if (response->resp_status)
 		return;
 
-	if (!mpfs_mbox_busy(mbox)) {
-		for (i = 0; i < num_words; i++) {
-			response->resp_msg[i] =
-				readl_relaxed(mbox->mbox_base
-					      + mbox->resp_offset + i * 0x4);
-		}
+	for (i = 0; i < num_words; i++) {
+		response->resp_msg[i] =
+			readl_relaxed(mbox->mbox_base
+				      + mbox->resp_offset + i * 0x4);
 	}
 
 	mbox_chan_received_data(chan, response);
-- 
2.39.0

