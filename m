Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4052771155E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 20:49:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242423AbjEYSnz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 14:43:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242389AbjEYSnj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 14:43:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C59E31733;
        Thu, 25 May 2023 11:40:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 523F460B52;
        Thu, 25 May 2023 18:38:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA45FC433A0;
        Thu, 25 May 2023 18:38:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685039899;
        bh=H2VwrVzS+U9B6jNfgMZ8PZWDi0r+a9pquf7BqrvT6iU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ioc6s5CVDaAkgGbSRbfTB5r7dSphwwNLdwEbRTugmrevSf5PHE3VgxgMQxGAhXLwZ
         5Wgl6Df6s58z27pm5gDT9lidmBiqBH21u06x+0jL9JBbRqhR/F89PmQxMR0oqLYuU1
         R0C8j+eLwVkbc5U+Gpy+lQrqPKmDWoaBQPFLAlSRUdV3lI/bMkAM1Q3i0yWrs76Ckm
         UURwo+OOWJ1z8j8TfT+u61ezjs4meU5xtarhStdPbYhstn8kRHSrhgeFS3ac6VQaGK
         5CcducthLXdnvwQxyPgg31lRqVzVF4QJYjKdc3s0j/BaxRSCP2iOWPZngCoQg8HKv9
         Bs3iof0X1MNNw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Ariel Malamud <ariel.malamud@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <sashal@kernel.org>, kvalo@kernel.org,
        benjamin.berg@intel.com, trix@redhat.com,
        mordechay.goodstein@intel.com, linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 42/57] wifi: iwlwifi: mvm: Add locking to the rate read flow
Date:   Thu, 25 May 2023 14:35:52 -0400
Message-Id: <20230525183607.1793983-42-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230525183607.1793983-1-sashal@kernel.org>
References: <20230525183607.1793983-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ariel Malamud <ariel.malamud@intel.com>

[ Upstream commit a8938bc881d2a03f9b77f19fae924fe798a01285 ]

The rs_drv_get_rate flow reads the lq_sta to return the optimal rate
for tx frames. This read flow is not protected thereby leaving
a small window, a few instructions wide, open to contention by an
asynchronous rate update. Indeed this race condition was hit and the
update occurred in the middle of the read.

Fix this by locking the lq_sta struct during read.

Signed-off-by: Ariel Malamud <ariel.malamud@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
Link: https://lore.kernel.org/r/20230514120631.b52c9ed5c379.I15290b78e0d966c1b68278263776ca9de841d5fe@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/intel/iwlwifi/mvm/rs.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rs.c b/drivers/net/wireless/intel/iwlwifi/mvm/rs.c
index 0b50b816684a0..2be6801d48aca 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rs.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rs.c
@@ -2692,6 +2692,8 @@ static void rs_drv_get_rate(void *mvm_r, struct ieee80211_sta *sta,
 		return;
 
 	lq_sta = mvm_sta;
+
+	spin_lock(&lq_sta->pers.lock);
 	iwl_mvm_hwrate_to_tx_rate_v1(lq_sta->last_rate_n_flags,
 				     info->band, &info->control.rates[0]);
 	info->control.rates[0].count = 1;
@@ -2706,6 +2708,7 @@ static void rs_drv_get_rate(void *mvm_r, struct ieee80211_sta *sta,
 		iwl_mvm_hwrate_to_tx_rate_v1(last_ucode_rate, info->band,
 					     &txrc->reported_rate);
 	}
+	spin_unlock(&lq_sta->pers.lock);
 }
 
 static void *rs_drv_alloc_sta(void *mvm_rate, struct ieee80211_sta *sta,
-- 
2.39.2

