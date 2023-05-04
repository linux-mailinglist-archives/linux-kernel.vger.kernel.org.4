Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B722F6F75BF
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 22:01:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbjEDUBX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 16:01:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232141AbjEDUBF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 16:01:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 610FE203CA;
        Thu,  4 May 2023 12:51:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7D94E63841;
        Thu,  4 May 2023 19:49:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68267C43321;
        Thu,  4 May 2023 19:49:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683229786;
        bh=gtO/lNBe1/rIlYFWWjfDYNKh0iIDgPyOfjU4FgD7AHA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=psN7ly1XzBHGJxJVG3U3tayekf5MSP2ZZE6VQzXJyGP8qiVRteOxxJ3xZlXoSGqmH
         ntrMh85aoQZkxZ6Fio2z1FUf0hrD/q/BgrNZl1YHXityGtT38QFN5eu3msdjkG4SP0
         A+N1i7S515KDmb7gJB55Wv7rnfKfc8WiJXgz8qE3fIfE1bD8g/LZFS2vJlTouTuDRS
         iQUdV9wsnlbe+iq8k/V3IsG+VjzZZrJI3nHeMB74Sl4Mr7nhb6oSqVfuCQGac8pCdn
         N187BvhBkSnniBNFNV62jNc0v612XSYztSXJPtSnh/DW/3dODNMaZBmX6DdVLYAqfd
         xdn4IYtoB8UHQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Hector Martin <marcan@marcan.st>,
        Linus Walleij <linus.walleij@linaro.org>,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Kalle Valo <kvalo@kernel.org>, Sasha Levin <sashal@kernel.org>,
        aspriel@gmail.com, franky.lin@broadcom.com,
        hante.meuleman@broadcom.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        ian.lin@infineon.com, chi-hsien.lin@infineon.com,
        johannes.berg@intel.com, wright.feng@cypress.com,
        ramesh.rangavittal@infineon.com, wataru.gohda@cypress.com,
        prasanna.kerekoppa@cypress.com, linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        SHA-cyfmac-dev-list@infineon.com, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 03/24] wifi: brcmfmac: cfg80211: Pass the PMK in binary instead of hex
Date:   Thu,  4 May 2023 15:49:16 -0400
Message-Id: <20230504194937.3808414-3-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230504194937.3808414-1-sashal@kernel.org>
References: <20230504194937.3808414-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hector Martin <marcan@marcan.st>

[ Upstream commit 89b89e52153fda2733562776c7c9d9d3ebf8dd6d ]

Apparently the hex passphrase mechanism does not work on newer
chips/firmware (e.g. BCM4387). It seems there was a simple way of
passing it in binary all along, so use that and avoid the hexification.

OpenBSD has been doing it like this from the beginning, so this should
work on all chips.

Also clear the structure before setting the PMK. This was leaking
uninitialized stack contents to the device.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Arend van Spriel <arend.vanspriel@broadcom.com>
Signed-off-by: Hector Martin <marcan@marcan.st>
Signed-off-by: Kalle Valo <kvalo@kernel.org>
Link: https://lore.kernel.org/r/20230214092423.15175-6-marcan@marcan.st
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../wireless/broadcom/brcm80211/brcmfmac/cfg80211.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
index 0a069bc7f1567..24dda3762768d 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
@@ -1350,13 +1350,14 @@ static int brcmf_set_pmk(struct brcmf_if *ifp, const u8 *pmk_data, u16 pmk_len)
 {
 	struct brcmf_pub *drvr = ifp->drvr;
 	struct brcmf_wsec_pmk_le pmk;
-	int i, err;
+	int err;
+
+	memset(&pmk, 0, sizeof(pmk));
 
-	/* convert to firmware key format */
-	pmk.key_len = cpu_to_le16(pmk_len << 1);
-	pmk.flags = cpu_to_le16(BRCMF_WSEC_PASSPHRASE);
-	for (i = 0; i < pmk_len; i++)
-		snprintf(&pmk.key[2 * i], 3, "%02x", pmk_data[i]);
+	/* pass pmk directly */
+	pmk.key_len = cpu_to_le16(pmk_len);
+	pmk.flags = cpu_to_le16(0);
+	memcpy(pmk.key, pmk_data, pmk_len);
 
 	/* store psk in firmware */
 	err = brcmf_fil_cmd_data_set(ifp, BRCMF_C_SET_WSEC_PMK,
-- 
2.39.2

