Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AD7B6F74E8
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 21:54:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231811AbjEDTyF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 15:54:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231588AbjEDTwz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 15:52:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFC2214E6B;
        Thu,  4 May 2023 12:47:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 38D7163772;
        Thu,  4 May 2023 19:45:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69AC7C433D2;
        Thu,  4 May 2023 19:45:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683229546;
        bh=YpHymwZ126li0EX1vs23j0jZiKeDcAaTGhI2SvBNA+4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nyVm7IsxUaLbFPjL2dKidFhBGT4X8B+o0tilRRoBHnERNDmhRTtrbXFM7LfgrAaro
         hAirzsLy3QatiQthpCWTAq8h/1GfSuCsl9HVVgFDXQYSvCVs/y0nB1sfVup7BPt/sX
         RIoN1LPADrrtpl+DdR1HyHgYQAhaeUn+ngoXU2keD3G64D2djD91fdBoxZReT/zTtQ
         WfcmubsNOl/hUclBxsVvGsr4htGANvwHVIabOVRpf/z5BzobTzW6Yi/Q3fnRqi7aj9
         DKudz8sr7Sl5pYR3/yZCLoHGZCFvy+Xx1gwnQOJ1S5na+0ie6pagXO4SwYM6vQEJUQ
         Jq+OtxAywbLmg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>,
        Sasha Levin <sashal@kernel.org>, kvalo@kernel.org,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, miriam.rachel.korenblit@intel.com,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.2 34/53] wifi: iwlwifi: mvm: fix ptk_pn memory leak
Date:   Thu,  4 May 2023 15:43:54 -0400
Message-Id: <20230504194413.3806354-34-sashal@kernel.org>
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

From: Johannes Berg <johannes.berg@intel.com>

[ Upstream commit d066a530af8e1833c7ea2cef7784004700c85f79 ]

If adding a key to firmware fails we leak the allocated ptk_pn.
This shouldn't happen in practice, but we should still fix it.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
Link: https://lore.kernel.org/r/20230414130637.99446ffd02bc.I82a2ad6ec1395f188e0a1677cc619e3fcb1feac9@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 1d46a2b345eb3..1cd1a85abc82e 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -3587,7 +3587,7 @@ static int __iwl_mvm_mac_set_key(struct ieee80211_hw *hw,
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
 	struct iwl_mvm *mvm = IWL_MAC80211_GET_MVM(hw);
 	struct iwl_mvm_sta *mvmsta = NULL;
-	struct iwl_mvm_key_pn *ptk_pn;
+	struct iwl_mvm_key_pn *ptk_pn = NULL;
 	int keyidx = key->keyidx;
 	u32 sec_key_id = WIDE_ID(DATA_PATH_GROUP, SEC_KEY_CMD);
 	u8 sec_key_ver = iwl_fw_lookup_cmd_ver(mvm->fw, sec_key_id, 0);
@@ -3739,6 +3739,10 @@ static int __iwl_mvm_mac_set_key(struct ieee80211_hw *hw,
 		if (ret) {
 			IWL_WARN(mvm, "set key failed\n");
 			key->hw_key_idx = STA_KEY_IDX_INVALID;
+			if (ptk_pn) {
+				RCU_INIT_POINTER(mvmsta->ptk_pn[keyidx], NULL);
+				kfree(ptk_pn);
+			}
 			/*
 			 * can't add key for RX, but we don't need it
 			 * in the device for TX so still return 0,
-- 
2.39.2

