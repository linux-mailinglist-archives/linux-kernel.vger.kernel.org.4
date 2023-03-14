Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AAB46BA279
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 23:29:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231260AbjCNW3J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 18:29:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229838AbjCNW3H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 18:29:07 -0400
X-Greylist: delayed 805 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 14 Mar 2023 15:29:05 PDT
Received: from forward103p.mail.yandex.net (forward103p.mail.yandex.net [IPv6:2a02:6b8:0:1472:2741:0:8b7:106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B3B31ADD8;
        Tue, 14 Mar 2023 15:29:04 -0700 (PDT)
Received: from iva8-4b0477eb80e1.qloud-c.yandex.net (iva8-4b0477eb80e1.qloud-c.yandex.net [IPv6:2a02:6b8:c0c:77a0:0:640:4b04:77eb])
        by forward103p.mail.yandex.net (Yandex) with ESMTP id 7A6C75A118E;
        Wed, 15 Mar 2023 01:06:52 +0300 (MSK)
Received: by iva8-4b0477eb80e1.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA id Z6r8MvDbiiE1-1EkHqEpy;
        Wed, 15 Mar 2023 01:06:52 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1678831612;
        bh=jDnjsEUda+wiSFbwcT/y+rvtVfXL9qpJJ3OUX6+g0mE=;
        h=Message-Id:Date:Cc:Subject:To:From;
        b=WId4pbG/TsrVCyxMuUt+e5UwtGIwfVDtJTt+wwj8R+ZKrbl8UxLSPcFMb2Yzvqw3n
         PW3V8s4LgPYLs6+Td/W7mJMVHqyaStsYTnoEWXGtXqawWOMtvOMy8gHbC2ELMRSY8n
         eNyicym35AEI6wY8JynfUXbkb9on0pTV36t8yJ0Y=
Authentication-Results: iva8-4b0477eb80e1.qloud-c.yandex.net; dkim=pass header.i=@yandex.ru
From:   Georgii Kruglov <georgy.kruglov@yandex.ru>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Georgii Kruglov <georgy.kruglov@yandex.ru>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Yinbo Zhu <yinbo.zhu@nxp.com>, Yangbo Lu <yangbo.lu@nxp.com>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mmc: sdhci-of-esdhc: fix quirk to ignore command inhibit for data
Date:   Wed, 15 Mar 2023 01:06:19 +0300
Message-Id: <20230314220619.41242-1-georgy.kruglov@yandex.ru>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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
 drivers/mmc/host/sdhci-of-esdhc.c | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
index 4712adac7f7c..cdbf1b6e1313 100644
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
+		if (esdhc->quirk_ignore_data_inhibit == true)
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

