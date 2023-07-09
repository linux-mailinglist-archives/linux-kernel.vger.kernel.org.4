Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E88F774C521
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jul 2023 17:14:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233195AbjGIPOT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jul 2023 11:14:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233184AbjGIPOG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jul 2023 11:14:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 307041BB;
        Sun,  9 Jul 2023 08:13:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9DBC160BC9;
        Sun,  9 Jul 2023 15:13:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E7F6C433C7;
        Sun,  9 Jul 2023 15:13:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688915611;
        bh=sB+XtJAYpsxpgs8eSEbivLDZHx106L5FQ9mAbaQJbvE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YqtOpYBtCVs8ntmAofPDLeI249mW/4gBC72w61uj3z897T228Eqhq8zsy4sJvu5uy
         RnR4MxSwer9PrW7/W2VO7CPASPYA9CukSD/Oyjc2qUuluyhr86IHeRHVwo2LeVavC4
         VwzZGrgB4zUTDI7ZSkY/MhMUqmmnSXFD8uxgZolqvrIEwXTuUidXflAcP5fY4bHUnm
         MnydT5t9Q6hzrL9kGanQHO6JMuhHi6E0AXr2Mr0ddlUiEZz3cZZjNT0GImh+QP4Qyh
         4unEh9LOSzmzCuY/DrG8k3zkJctpUzznEaTxKNYfCUeBLsrHS9kcQIlhykmjX4i02p
         tFEJF0WNadgpQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Gregory Greenman <gregory.greenman@intel.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <sashal@kernel.org>, kvalo@kernel.org,
        ilan.peer@intel.com, avraham.stern@intel.com,
        linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.4 17/26] wifi: iwlwifi: mvm: fix potential array out of bounds access
Date:   Sun,  9 Jul 2023 11:12:46 -0400
Message-Id: <20230709151255.512931-17-sashal@kernel.org>
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
index 8853821b37168..1e659bd07392a 100644
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
@@ -179,9 +179,14 @@ int iwl_mvm_sec_key_add(struct iwl_mvm *mvm,
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
 
 	if (WARN_ON(!sta_mask))
-- 
2.39.2

