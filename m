Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 352E05E674C
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 17:39:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231698AbiIVPjE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 11:39:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230089AbiIVPjC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 11:39:02 -0400
Received: from maillog.nuvoton.com (maillog.nuvoton.com [202.39.227.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A9CDDEB11B
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 08:39:00 -0700 (PDT)
Received: from NTHCCAS04.nuvoton.com (NTHCCAS04.nuvoton.com [10.1.8.29])
        by maillog.nuvoton.com (Postfix) with ESMTP id D30261C811D1;
        Thu, 22 Sep 2022 23:38:59 +0800 (CST)
Received: from NTHCML01A.nuvoton.com (10.1.8.177) by NTHCCAS04.nuvoton.com
 (10.1.8.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Thu, 22
 Sep 2022 23:38:59 +0800
Received: from NTHCCAS04.nuvoton.com (10.1.8.29) by NTHCML01A.nuvoton.com
 (10.1.8.177) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2176.2; Thu, 22 Sep
 2022 23:38:59 +0800
Received: from taln60.nuvoton.co.il (10.191.1.180) by NTHCCAS04.nuvoton.com
 (10.1.12.25) with Microsoft SMTP Server id 15.1.2176.2 via Frontend
 Transport; Thu, 22 Sep 2022 23:38:59 +0800
Received: by taln60.nuvoton.co.il (Postfix, from userid 10070)
        id 6B8FA637C4; Thu, 22 Sep 2022 18:38:58 +0300 (IDT)
From:   Tomer Maimon <tmaimon77@gmail.com>
To:     <avifishman70@gmail.com>, <tali.perry1@gmail.com>,
        <joel@jms.id.au>, <venture@google.com>, <yuenn@google.com>,
        <benjaminfair@google.com>, <p.zabel@pengutronix.de>,
        <arnd@arndb.de>
CC:     <openbmc@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
        Tomer Maimon <tmaimon77@gmail.com>
Subject: [PATCH v1] reset: npcm: fix iprst2 and iprst4 setting
Date:   Thu, 22 Sep 2022 18:38:56 +0300
Message-ID: <20220922153856.23326-1-tmaimon77@gmail.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.5 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,NML_ADSP_CUSTOM_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In NPCM8XX USB reset sequence, iprst2 register was set with iprst4 value
and iprst4 register wasn´t set.

This fix sets the correct IP reset values in iprst2 and iprst4 registers
in NPCM8XX USB reset sequence.

Fixes: fc5d2a2f4aa5 ("reset: npcm: Add NPCM8XX support")

Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
---
 drivers/reset/reset-npcm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/reset/reset-npcm.c b/drivers/reset/reset-npcm.c
index 24c55efa98e5..f2333506b0a6 100644
--- a/drivers/reset/reset-npcm.c
+++ b/drivers/reset/reset-npcm.c
@@ -291,7 +291,7 @@ static void npcm_usb_reset_npcm8xx(struct npcm_rc_data *rc)
 	iprst2 |= ipsrst2_bits;
 	iprst3 |= (ipsrst3_bits | NPCM_IPSRST3_USBPHY1 |
 		   NPCM_IPSRST3_USBPHY2);
-	iprst2 |= ipsrst4_bits;
+	iprst4 |= ipsrst4_bits;
 
 	writel(iprst1, rc->base + NPCM_IPSRST1);
 	writel(iprst2, rc->base + NPCM_IPSRST2);
-- 
2.33.0

