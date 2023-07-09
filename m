Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FAD374C55D
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jul 2023 17:15:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233397AbjGIPPy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jul 2023 11:15:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233403AbjGIPPQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jul 2023 11:15:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52527E5A;
        Sun,  9 Jul 2023 08:14:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D330260C04;
        Sun,  9 Jul 2023 15:14:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 578BDC433C8;
        Sun,  9 Jul 2023 15:14:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688915664;
        bh=V9tsOpSCYIA4Vuhac+vGUHs11DEQjZn7b/T/TAOvcGM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YCJbvYqdFnW+1SFgZ/Sy+7DHL6YnYPqANv6iTkfudM0gF1+5pcV9wclwdKIUcPM0I
         SEzfNk0m1ERBmtBwbXhzYyxju9IcLw6zE60p2VtGjVPddFKauY0QRAEhtk9aZR2glc
         s/wtj7nrQ+tx4y45uxFJ5kjIhvQjcP0nzZA34HQwyaRvKS5CjbsTlstqvFa9Kpzz5y
         Rnc8b+KKuoEchfFeV7EPW1dsFcmgiFPte3zHcI0vN/TAcU7x9/tGZVTHBELiOkIaIn
         gLQeTrXTugjzKHtMqS5vzn248ckLIMBi5Vtvm67xnsujKtwcknmppjF+D6fSGqbVoI
         SXUH414NIqudg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Gregory Greenman <gregory.greenman@intel.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <sashal@kernel.org>, kvalo@kernel.org,
        avraham.stern@intel.com, ilan.peer@intel.com,
        linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.3 14/22] wifi: iwlwifi: mvm: fix potential array out of bounds access
Date:   Sun,  9 Jul 2023 11:13:48 -0400
Message-Id: <20230709151356.513279-14-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230709151356.513279-1-sashal@kernel.org>
References: <20230709151356.513279-1-sashal@kernel.org>
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

From: Gregory Greenman <gregory.greenman@intel.com>

[ Upstream commit 637452360ecde9ac972d19416e9606529576b302 ]

Account for IWL_SEC_WEP_KEY_OFFSET when needed while verifying
key_len size in iwl_mvm_sec_key_add().

Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
Link: https://lore.kernel.org/r/20230613155501.f193b7493a93.I6948ba625b9318924b96a5e22602ac75d2bd0125@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mld-key.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-key.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-key.c
index e27c893502f70..de288e048b2c7 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-key.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-key.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright (C) 2022 Intel Corporation
+ * Copyright (C) 2022 - 2023 Intel Corporation
  */
 #include <linux/kernel.h>
 #include <net/mac80211.h>
@@ -113,9 +113,14 @@ int iwl_mvm_sec_key_add(struct iwl_mvm *mvm,
 		.u.add.key_flags = cpu_to_le32(key_flags),
 		.u.add.tx_seq = cpu_to_le64(atomic64_read(&keyconf->tx_pn)),
 	};
+	int max_key_len = sizeof(cmd.u.add.key);
 	int ret;
 
-	if (WARN_ON(keyconf->keylen > sizeof(cmd.u.add.key)))
+	if (keyconf->cipher == WLAN_CIPHER_SUITE_WEP40 ||
+	    keyconf->cipher == WLAN_CIPHER_SUITE_WEP104)
+		max_key_len -= IWL_SEC_WEP_KEY_OFFSET;
+
+	if (WARN_ON(keyconf->keylen > max_key_len))
 		return -EINVAL;
 
 	if (keyconf->cipher == WLAN_CIPHER_SUITE_WEP40 ||
-- 
2.39.2

