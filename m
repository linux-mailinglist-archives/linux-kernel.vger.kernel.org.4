Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4F076C3C19
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 21:45:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbjCUUpG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 16:45:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229700AbjCUUpE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 16:45:04 -0400
X-Greylist: delayed 448 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 21 Mar 2023 13:45:01 PDT
Received: from forward104j.mail.yandex.net (forward104j.mail.yandex.net [5.45.198.247])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CEC952921
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 13:45:01 -0700 (PDT)
Received: from forward203b.mail.yandex.net (forward203b.mail.yandex.net [IPv6:2a02:6b8:c02:900:1:45:d181:d203])
        by forward104j.mail.yandex.net (Yandex) with ESMTP id E7F782F98F24;
        Tue, 21 Mar 2023 23:37:29 +0300 (MSK)
Received: from myt5-18b0513eae63.qloud-c.yandex.net (myt5-18b0513eae63.qloud-c.yandex.net [IPv6:2a02:6b8:c12:571f:0:640:18b0:513e])
        by forward203b.mail.yandex.net (Yandex) with ESMTP id 81195600C6;
        Tue, 21 Mar 2023 23:37:25 +0300 (MSK)
Received: by myt5-18b0513eae63.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA id GbwJmeEbJW21-wW9oWXc5;
        Tue, 21 Mar 2023 23:37:24 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1679431044;
        bh=5RPP7d79oVWCJLIfd/IJsuehUgySJej4tOZFP01Hr5A=;
        h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
        b=pudVMKPTagxtNTJwDhf1rYMX7mnJSOiJ2bN4Ztgt2ZJI/T3i9Lrc1smcB/4Lidnat
         SgJ17Cig5jHf3P+QWEkP6K1Qi59EE1XNPrNtetjWIualDr89V+rxVqquNZiFvYf8f5
         xBSekx1liTZocndD+I7Q/yfuHlHGqJbB3AlcmEBk=
Authentication-Results: myt5-18b0513eae63.qloud-c.yandex.net; dkim=pass header.i=@yandex.ru
From:   Georgii Kruglov <georgy.kruglov@yandex.ru>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Georgii Kruglov <georgy.kruglov@yandex.ru>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Yangbo Lu <yangbo.lu@nxp.com>, Yinbo Zhu <yinbo.zhu@nxp.com>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        lvc-project@linuxtesting.org
Subject: [PATCH v2] mmc: sdhci-of-esdhc: fix quirk to ignore command inhibit for data
Date:   Tue, 21 Mar 2023 23:37:15 +0300
Message-Id: <20230321203715.3975-1-georgy.kruglov@yandex.ru>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230314220619.41242-1-georgy.kruglov@yandex.ru>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If spec_reg is equal to 'SDHCI_PRESENT_STATE', esdhc_readl_fixup()
fixes up register value and returns it immediately. As a result, the
further block
(spec_reg == SDHCI_PRESENT_STATE)
    &&(esdhc->quirk_ignore_data_inhibit == true),
is never executed.

The patch merges the second block into the first one.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 1f1929f3f2fa ("mmc: sdhci-of-esdhc: add quirk to ignore command inhibit for data")
Signed-off-by: Georgii Kruglov <georgy.kruglov@yandex.ru>
---
v2: Drop the redundant '== true' as Adrian Hunter <adrian.hunter@intel.com> suggested.
 drivers/mmc/host/sdhci-of-esdhc.c | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
index 4712adac7f7c..48ca1cf15b19 100644
--- a/drivers/mmc/host/sdhci-of-esdhc.c
+++ b/drivers/mmc/host/sdhci-of-esdhc.c
@@ -133,6 +133,7 @@ static u32 esdhc_readl_fixup(struct sdhci_host *host,
 			return ret;
 		}
 	}
+
 	/*
 	 * The DAT[3:0] line signal levels and the CMD line signal level are
 	 * not compatible with standard SDHC register. The line signal levels
@@ -144,6 +145,16 @@ static u32 esdhc_readl_fixup(struct sdhci_host *host,
 		ret = value & 0x000fffff;
 		ret |= (value >> 4) & SDHCI_DATA_LVL_MASK;
 		ret |= (value << 1) & SDHCI_CMD_LVL;
+
+		/*
+		 * Some controllers have unreliable Data Line Active
+		 * bit for commands with busy signal. This affects
+		 * Command Inhibit (data) bit. Just ignore it since
+		 * MMC core driver has already polled card status
+		 * with CMD13 after any command with busy siganl.
+		 */
+		if (esdhc->quirk_ignore_data_inhibit)
+			ret &= ~SDHCI_DATA_INHIBIT;
 		return ret;
 	}
 
@@ -158,19 +169,6 @@ static u32 esdhc_readl_fixup(struct sdhci_host *host,
 		return ret;
 	}
 
-	/*
-	 * Some controllers have unreliable Data Line Active
-	 * bit for commands with busy signal. This affects
-	 * Command Inhibit (data) bit. Just ignore it since
-	 * MMC core driver has already polled card status
-	 * with CMD13 after any command with busy siganl.
-	 */
-	if ((spec_reg == SDHCI_PRESENT_STATE) &&
-	(esdhc->quirk_ignore_data_inhibit == true)) {
-		ret = value & ~SDHCI_DATA_INHIBIT;
-		return ret;
-	}
-
 	ret = value;
 	return ret;
 }
-- 
2.34.1

