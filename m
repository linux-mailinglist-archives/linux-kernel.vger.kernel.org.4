Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 872EF74C51C
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jul 2023 17:14:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233092AbjGIPON (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jul 2023 11:14:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233097AbjGIPN4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jul 2023 11:13:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E7271FE1;
        Sun,  9 Jul 2023 08:13:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6945260BCC;
        Sun,  9 Jul 2023 15:13:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4BD7C433CA;
        Sun,  9 Jul 2023 15:13:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688915602;
        bh=ScanU+BhgmWJdTldgcCupwA3PbZWDh9RwbCKDblNdPE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BLzeRVvZo6QFJh6BlKpVSQPuGjEaf5DXU1qi8XuaCN9EVFwxlo79ibH88ycMxaxfj
         3tmcF58JJotepSWpN9yzkl0ViZODn7ZFOAd+Aghn7tRr68t9+R0iJ2q66rDjEj+CR2
         B2uQ7o3WEiXSg/7otmOs2tDpm4a3KeTQaXxryWT3zEP5qlEFz8QdALmYuJog7MZIN3
         BF+iDZeTWSkelOc0B8UmLG8O2WvCcGqGnxj3kVnkLKOen17toJ4Xk51Qof67d5lRYG
         c9k9IF97m8UhHkfgMD2lp2qakTFQRARs4YCQge7++qYRqWCN0NW7I3coc7sVuZgScG
         fUAwMrh1pshTw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     P Praneesh <quic_ppranees@quicinc.com>,
        Aditya Kumar Singh <quic_adisi@quicinc.com>,
        Kalle Valo <quic_kvalo@quicinc.com>,
        Sasha Levin <sashal@kernel.org>, kvalo@kernel.org,
        ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.4 16/26] wifi: ath11k: fix memory leak in WMI firmware stats
Date:   Sun,  9 Jul 2023 11:12:45 -0400
Message-Id: <20230709151255.512931-16-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230709151255.512931-1-sashal@kernel.org>
References: <20230709151255.512931-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.4.2
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

From: P Praneesh <quic_ppranees@quicinc.com>

[ Upstream commit 6aafa1c2d3e3fea2ebe84c018003f2a91722e607 ]

Memory allocated for firmware pdev, vdev and beacon statistics
are not released during rmmod.

Fix it by calling ath11k_fw_stats_free() function before hardware
unregister.

While at it, avoid calling ath11k_fw_stats_free() while processing
the firmware stats received in the WMI event because the local list
is getting spliced and reinitialised and hence there are no elements
in the list after splicing.

Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.7.0.1-01744-QCAHKSWPL_SILICONZ-1

Signed-off-by: P Praneesh <quic_ppranees@quicinc.com>
Signed-off-by: Aditya Kumar Singh <quic_adisi@quicinc.com>
Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
Link: https://lore.kernel.org/r/20230606091128.14202-1-quic_adisi@quicinc.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/ath/ath11k/mac.c | 1 +
 drivers/net/wireless/ath/ath11k/wmi.c | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index 05920ad413c55..01ff197b017f7 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -9468,6 +9468,7 @@ void ath11k_mac_destroy(struct ath11k_base *ab)
 		if (!ar)
 			continue;
 
+		ath11k_fw_stats_free(&ar->fw_stats);
 		ieee80211_free_hw(ar->hw);
 		pdev->ar = NULL;
 	}
diff --git a/drivers/net/wireless/ath/ath11k/wmi.c b/drivers/net/wireless/ath/ath11k/wmi.c
index d0b59bc2905a9..42d9b29623a47 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.c
+++ b/drivers/net/wireless/ath/ath11k/wmi.c
@@ -8103,6 +8103,11 @@ static void ath11k_update_stats_event(struct ath11k_base *ab, struct sk_buff *sk
 	rcu_read_unlock();
 	spin_unlock_bh(&ar->data_lock);
 
+	/* Since the stats's pdev, vdev and beacon list are spliced and reinitialised
+	 * at this point, no need to free the individual list.
+	 */
+	return;
+
 free:
 	ath11k_fw_stats_free(&stats);
 }
-- 
2.39.2

