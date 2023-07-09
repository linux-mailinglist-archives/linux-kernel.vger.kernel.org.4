Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7571E74C534
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jul 2023 17:15:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233348AbjGIPO5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jul 2023 11:14:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233258AbjGIPOf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jul 2023 11:14:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 472411731;
        Sun,  9 Jul 2023 08:14:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 54EC460C1F;
        Sun,  9 Jul 2023 15:14:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB19BC433CB;
        Sun,  9 Jul 2023 15:13:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688915639;
        bh=0eFe3KRCvz+ys88CHld0g81ComcntN9akzS7FOdbrYw=;
        h=From:To:Cc:Subject:Date:From;
        b=SMt4UKXMWpyTlWR1aB3VKFtP2FpUdVf86PdSAUySz2iH8qKBB3PsW9aefC+SshKl1
         HQHIU7QFPdgb7j03e9e2APfqdI17E3NSEUL/ItPLUTGFHAo1wUweFgN7DCpUlkBU86
         OCX5TS4LRH7Si9gzyb+juRlS98toxDgVUoxVLCitZzSCxFlAOUSsWakLfvDfF37//Q
         AbEVbczPdUrm61/Bi5G6s2Ee5SluenS6BbF6z5C1CDY4LOQBZw257dLaNf+/19EPU7
         D/xxa+N5K7BZNep5oHLHEniOHyFqW9u6oE/Hr319vartUy/2jkQfE9PEdpdd7ZXUsB
         YIy+92ti05etQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Maxime Bizon <mbizon@freebox.fr>,
        Kalle Valo <quic_kvalo@quicinc.com>,
        Sasha Levin <sashal@kernel.org>, kvalo@kernel.org,
        ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.3 01/22] wifi: ath11k: fix registration of 6Ghz-only phy without the full channel range
Date:   Sun,  9 Jul 2023 11:13:35 -0400
Message-Id: <20230709151356.513279-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.3.12
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Maxime Bizon <mbizon@freebox.fr>

[ Upstream commit e2ceb1de2f83aafd8003f0b72dfd4b7441e97d14 ]

Because of what seems to be a typo, a 6Ghz-only phy for which the BDF
does not allow the 7115Mhz channel will fail to register:

  WARNING: CPU: 2 PID: 106 at net/wireless/core.c:907 wiphy_register+0x914/0x954
  Modules linked in: ath11k_pci sbsa_gwdt
  CPU: 2 PID: 106 Comm: kworker/u8:5 Not tainted 6.3.0-rc7-next-20230418-00549-g1e096a17625a-dirty #9
  Hardware name: Freebox V7R Board (DT)
  Workqueue: ath11k_qmi_driver_event ath11k_qmi_driver_event_work
  pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
  pc : wiphy_register+0x914/0x954
  lr : ieee80211_register_hw+0x67c/0xc10
  sp : ffffff800b123aa0
  x29: ffffff800b123aa0 x28: 0000000000000000 x27: 0000000000000000
  x26: 0000000000000000 x25: 0000000000000006 x24: ffffffc008d51418
  x23: ffffffc008cb0838 x22: ffffff80176c2460 x21: 0000000000000168
  x20: ffffff80176c0000 x19: ffffff80176c03e0 x18: 0000000000000014
  x17: 00000000cbef338c x16: 00000000d2a26f21 x15: 00000000ad6bb85f
  x14: 0000000000000020 x13: 0000000000000020 x12: 00000000ffffffbd
  x11: 0000000000000208 x10: 00000000fffffdf7 x9 : ffffffc009394718
  x8 : ffffff80176c0528 x7 : 000000007fffffff x6 : 0000000000000006
  x5 : 0000000000000005 x4 : ffffff800b304284 x3 : ffffff800b304284
  x2 : ffffff800b304d98 x1 : 0000000000000000 x0 : 0000000000000000
  Call trace:
   wiphy_register+0x914/0x954
   ieee80211_register_hw+0x67c/0xc10
   ath11k_mac_register+0x7c4/0xe10
   ath11k_core_qmi_firmware_ready+0x1f4/0x570
   ath11k_qmi_driver_event_work+0x198/0x590
   process_one_work+0x1b8/0x328
   worker_thread+0x6c/0x414
   kthread+0x100/0x104
   ret_from_fork+0x10/0x20
  ---[ end trace 0000000000000000 ]---
  ath11k_pci 0002:01:00.0: ieee80211 registration failed: -22
  ath11k_pci 0002:01:00.0: failed register the radio with mac80211: -22
  ath11k_pci 0002:01:00.0: failed to create pdev core: -22

Signed-off-by: Maxime Bizon <mbizon@freebox.fr>
Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
Link: https://lore.kernel.org/r/20230421145445.2612280-1-mbizon@freebox.fr
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/ath/ath11k/mac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index 110a38cce0a71..850ef35c1f75e 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -8778,7 +8778,7 @@ static int ath11k_mac_setup_channels_rates(struct ath11k *ar,
 	}
 
 	if (supported_bands & WMI_HOST_WLAN_5G_CAP) {
-		if (reg_cap->high_5ghz_chan >= ATH11K_MAX_6G_FREQ) {
+		if (reg_cap->high_5ghz_chan >= ATH11K_MIN_6G_FREQ) {
 			channels = kmemdup(ath11k_6ghz_channels,
 					   sizeof(ath11k_6ghz_channels), GFP_KERNEL);
 			if (!channels) {
-- 
2.39.2

