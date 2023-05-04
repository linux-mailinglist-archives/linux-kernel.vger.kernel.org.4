Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D1E86F73E8
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 21:47:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230311AbjEDTqw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 15:46:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230254AbjEDTqO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 15:46:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 490A717DDD;
        Thu,  4 May 2023 12:44:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4F05663768;
        Thu,  4 May 2023 19:44:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2079C433EF;
        Thu,  4 May 2023 19:44:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683229462;
        bh=jjQTqmOKNEtS/VKcrSmq1QghYJenfYvKy9UVYjhSXZU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pJYdgrso4JCNu+NC5uWyow01tH6yoBSzpTTgG2C4dJo/ZmsSpZ93yAr4G9Kvigal1
         vbkA93prDj+nNpSAzr3VTUUqAdqRsvVsHJOYl0YmaDFEWqOxWL7v+6gZSE/fNEKxX8
         T/tE5JEtIDel4u4dqlop/4vYu7b5q7N4vybfqMxNavbQq8w3bvaDuAUlx+Rnn45VEt
         qye5xeZu8CWpzSExBri/voyTDKz4o555WyzN38mYNaZ7WsU+RxlBOJ5ybtmxC3ibCW
         DU3WiBZYUAmgCeJw/Hth2EZbes6SX2uMMGwPxfbjloT6UFySKa9n141HAKp3KCUfGA
         8TxqD9mHvs6kg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Hector Martin <marcan@marcan.st>,
        Linus Walleij <linus.walleij@linaro.org>,
        Julian Calaby <julian.calaby@gmail.com>,
        Kalle Valo <kvalo@kernel.org>, Sasha Levin <sashal@kernel.org>,
        aspriel@gmail.com, franky.lin@broadcom.com,
        hante.meuleman@broadcom.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        rmk+kernel@armlinux.org.uk, wright.feng@cypress.com,
        linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        SHA-cyfmac-dev-list@infineon.com, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.2 03/53] wifi: brcmfmac: pcie: Provide a buffer of random bytes to the device
Date:   Thu,  4 May 2023 15:43:23 -0400
Message-Id: <20230504194413.3806354-3-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230504194413.3806354-1-sashal@kernel.org>
References: <20230504194413.3806354-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hector Martin <marcan@marcan.st>

[ Upstream commit 91918ce88d9fef408bb12c46a27c73d79b604c20 ]

Newer Apple firmwares on chipsets without a hardware RNG require the
host to provide a buffer of 256 random bytes to the device on
initialization. This buffer is present immediately before NVRAM,
suffixed by a footer containing a magic number and the buffer length.

This won't affect chips/firmwares that do not use this feature, so do it
unconditionally for all Apple platforms (those with an Apple OTP).

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Hector Martin <marcan@marcan.st>
Reviewed-by: Julian Calaby <julian.calaby@gmail.com>
Signed-off-by: Kalle Valo <kvalo@kernel.org>
Link: https://lore.kernel.org/r/20230214080034.3828-3-marcan@marcan.st
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../broadcom/brcm80211/brcmfmac/pcie.c        | 32 +++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
index a9b9b2dc62d4f..2835ef4edb18f 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
@@ -15,6 +15,7 @@
 #include <linux/sched/signal.h>
 #include <linux/kthread.h>
 #include <linux/io.h>
+#include <linux/random.h>
 #include <asm/unaligned.h>
 
 #include <soc.h>
@@ -1653,6 +1654,13 @@ brcmf_pcie_init_share_ram_info(struct brcmf_pciedev_info *devinfo,
 	return 0;
 }
 
+struct brcmf_random_seed_footer {
+	__le32 length;
+	__le32 magic;
+};
+
+#define BRCMF_RANDOM_SEED_MAGIC		0xfeedc0de
+#define BRCMF_RANDOM_SEED_LENGTH	0x100
 
 static int brcmf_pcie_download_fw_nvram(struct brcmf_pciedev_info *devinfo,
 					const struct firmware *fw, void *nvram,
@@ -1689,6 +1697,30 @@ static int brcmf_pcie_download_fw_nvram(struct brcmf_pciedev_info *devinfo,
 			  nvram_len;
 		memcpy_toio(devinfo->tcm + address, nvram, nvram_len);
 		brcmf_fw_nvram_free(nvram);
+
+		if (devinfo->otp.valid) {
+			size_t rand_len = BRCMF_RANDOM_SEED_LENGTH;
+			struct brcmf_random_seed_footer footer = {
+				.length = cpu_to_le32(rand_len),
+				.magic = cpu_to_le32(BRCMF_RANDOM_SEED_MAGIC),
+			};
+			void *randbuf;
+
+			/* Some Apple chips/firmwares expect a buffer of random
+			 * data to be present before NVRAM
+			 */
+			brcmf_dbg(PCIE, "Download random seed\n");
+
+			address -= sizeof(footer);
+			memcpy_toio(devinfo->tcm + address, &footer,
+				    sizeof(footer));
+
+			address -= rand_len;
+			randbuf = kzalloc(rand_len, GFP_KERNEL);
+			get_random_bytes(randbuf, rand_len);
+			memcpy_toio(devinfo->tcm + address, randbuf, rand_len);
+			kfree(randbuf);
+		}
 	} else {
 		brcmf_dbg(PCIE, "No matching NVRAM file found %s\n",
 			  devinfo->nvram_name);
-- 
2.39.2

