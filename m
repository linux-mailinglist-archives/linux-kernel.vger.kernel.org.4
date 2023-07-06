Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 111F87498B9
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 11:50:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232203AbjGFJuu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 05:50:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjGFJuo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 05:50:44 -0400
X-Greylist: delayed 599 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 06 Jul 2023 02:50:41 PDT
Received: from mail.wsbck.net (unknown [IPv6:2a03:4000:6:f837:b87d:beff:fe7a:4fa2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AACF31998;
        Thu,  6 Jul 2023 02:50:41 -0700 (PDT)
From:   Johannes Wiesboeck <johannes.wiesboeck@aisec.fraunhofer.de>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     Johannes Wiesboeck <johannes.wiesboeck@aisec.fraunhofer.de>,
        =?UTF-8?q?Michael=20Wei=C3=9F?= <michael.weiss@aisec.fraunhofer.de>,
        Amitkumar Karwar <amitkarwar@gmail.com>,
        Ganapathi Bhat <ganapathi017@gmail.com>,
        Sharvari Harisangam <sharvari.harisangam@nxp.com>,
        Xinming Hu <huxinming820@gmail.com>,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] wifi: mwifiex: Set WIPHY_FLAG_NETNS_OK flag
Date:   Thu,  6 Jul 2023 11:34:36 +0200
Message-ID: <20230706093437.3380526-1-johannes.wiesboeck@aisec.fraunhofer.de>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow moving the wiphy device for mwififex to a non-inital network
namespace. Many wireless drivers enable this flag implicitly by
initializing through the generic ieee80211_alloc_hw_nm function. As
mwifiex does not utilize this function WIPHY_FLAG_NETNS_OK must be set
explicitly.

Moving to network namespace and working connection tested using
wpa_supplicant from a network namespace as well as from a container on
GyroidOS. The hardware was the Toradex Apalis i.MX8QM Board using the
Azurewave AW-CM276NF wireless module.

Signed-off-by: Johannes Wiesboeck <johannes.wiesboeck@aisec.fraunhofer.de>
Reviewed-by: Michael Weiß <michael.weiss@aisec.fraunhofer.de>
---
 drivers/net/wireless/marvell/mwifiex/cfg80211.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/marvell/mwifiex/cfg80211.c b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
index 813d1cbebe19b..ba4e29713a8c9 100644
--- a/drivers/net/wireless/marvell/mwifiex/cfg80211.c
+++ b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
@@ -4395,6 +4395,7 @@ int mwifiex_register_cfg80211(struct mwifiex_adapter *adapter)
 			WIPHY_FLAG_AP_UAPSD |
 			WIPHY_FLAG_HAS_REMAIN_ON_CHANNEL |
 			WIPHY_FLAG_HAS_CHANNEL_SWITCH |
+			WIPHY_FLAG_NETNS_OK |
 			WIPHY_FLAG_PS_ON_BY_DEFAULT;
 
 	if (ISSUPP_TDLS_ENABLED(adapter->fw_cap_info))
-- 
2.41.0

