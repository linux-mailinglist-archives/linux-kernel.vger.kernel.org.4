Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B93CF74C5E1
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jul 2023 17:20:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233839AbjGIPUc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jul 2023 11:20:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233810AbjGIPT1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jul 2023 11:19:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F98AC2;
        Sun,  9 Jul 2023 08:16:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0C33A60C3A;
        Sun,  9 Jul 2023 15:16:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54A14C433C7;
        Sun,  9 Jul 2023 15:16:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688915788;
        bh=xAjnnjtKgsqBNirUt8fPoThn3ipjvoEV7IxJoqGNg0E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cQsPgW8eCf2TL+nbapHiyFQ5a339EdphENpsMVgzHiFglzbJLDBDOQKrUijjwBDpb
         izt+9C8UhNecx6z+16UAYyF41c7ShtDJ4z7KrRtFPL2SPWKH0rwN628fWO29TIB7ir
         yf/owpn7v5vVx6DBmLYP3tP8WN9KSLAMkc8YgA5yBKyh2Jc2H3t7fBotBTogPbXGf+
         /Xj8dfUc9Z4HKDMPQq2V4Q6vsJoX9dVGGDvaj+vuAggDHNYIsq2WEV+G7gpnX67wTZ
         3Rc3r6yMdF1gu2G5VXrcijxCVF7eZEbrE4PrS4kBVyRHs4KmeD0saGmVg0nhG8EEIc
         ZrCRIlOvU1Dnw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>,
        Roee Goldfiner <roee.h.goldfiner@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>,
        Sasha Levin <sashal@kernel.org>, kvalo@kernel.org,
        miriam.rachel.korenblit@intel.com, avraham.stern@intel.com,
        benjamin.berg@intel.com, jtornosm@redhat.com,
        linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 5/6] wifi: iwlwifi: mvm: avoid baid size integer overflow
Date:   Sun,  9 Jul 2023 11:16:12 -0400
Message-Id: <20230709151615.514009-5-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230709151615.514009-1-sashal@kernel.org>
References: <20230709151615.514009-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.249
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

From: Johannes Berg <johannes.berg@intel.com>

[ Upstream commit 1a528ab1da324d078ec60283c34c17848580df24 ]

Roee reported various hard-to-debug crashes with pings in
EHT aggregation scenarios. Enabling KASAN showed that we
access the BAID allocation out of bounds, and looking at
the code a bit shows that since the reorder buffer entry
(struct iwl_mvm_reorder_buf_entry) is 128 bytes if debug
such as lockdep is enabled, then staring from an agg size
512 we overflow the size calculation, and allocate a much
smaller structure than we should, causing slab corruption
once we initialize this.

Fix this by simply using u32 instead of u16.

Reported-by: Roee Goldfiner <roee.h.goldfiner@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
Link: https://lore.kernel.org/r/20230620125813.f428c856030d.I2c2bb808e945adb71bc15f5b2bac2d8957ea90eb@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
index a3255100e3fee..7befb92b5159c 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
@@ -2557,7 +2557,7 @@ int iwl_mvm_sta_rx_agg(struct iwl_mvm *mvm, struct ieee80211_sta *sta,
 	}
 
 	if (iwl_mvm_has_new_rx_api(mvm) && start) {
-		u16 reorder_buf_size = buf_size * sizeof(baid_data->entries[0]);
+		u32 reorder_buf_size = buf_size * sizeof(baid_data->entries[0]);
 
 		/* sparse doesn't like the __align() so don't check */
 #ifndef __CHECKER__
-- 
2.39.2

