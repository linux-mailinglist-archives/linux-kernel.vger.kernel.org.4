Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B54D74C622
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jul 2023 17:28:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233433AbjGIP2e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jul 2023 11:28:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234002AbjGIP2B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jul 2023 11:28:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D379E3C24;
        Sun,  9 Jul 2023 08:25:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F3B0260B83;
        Sun,  9 Jul 2023 15:15:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A1E7C433AD;
        Sun,  9 Jul 2023 15:15:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688915749;
        bh=Agt2o5MhbYx1WXqAb8FIJLTnyrtArEek6c0NS3eWVDA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K/KTWxQYuLrywj9IShmrRIdoW6fifQw6iIsTju7QlWRLohIg2YmkhxcQQ7UftXwlv
         Du7MVC+9UsTSq6zLvYZxWT2QVsvsSyKvKbw0c0aweXoPcK1zUEFeTImt7Q8KhUQWRX
         MoxOj1h6CUKE9gDPWIDX423OuePhneiNch3NyPO022wymJ9+5gYc1JfwllKrrZX8I7
         J8hFOW2AIWHTNxpm8WCmTCawJ08Yv6FWKrM1zOg34e3QUrmcTAbQx0TJEhaFr4But7
         k+lJHZ8Q4Z/GDP94m1DUzj8r5Brp14cn4cmMlCAozBDYPuV/X04xHxZXIJhQ0ERm7G
         Y/xECISQ3Yq6Q==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>,
        Roee Goldfiner <roee.h.goldfiner@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>,
        Sasha Levin <sashal@kernel.org>, kvalo@kernel.org,
        miriam.rachel.korenblit@intel.com, avraham.stern@intel.com,
        benjamin.berg@intel.com, jtornosm@redhat.com,
        linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 08/10] wifi: iwlwifi: mvm: avoid baid size integer overflow
Date:   Sun,  9 Jul 2023 11:15:26 -0400
Message-Id: <20230709151528.513775-8-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230709151528.513775-1-sashal@kernel.org>
References: <20230709151528.513775-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.120
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
index 45dfee3ad8c60..2d1755598b475 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
@@ -2544,7 +2544,7 @@ int iwl_mvm_sta_rx_agg(struct iwl_mvm *mvm, struct ieee80211_sta *sta,
 	}
 
 	if (iwl_mvm_has_new_rx_api(mvm) && start) {
-		u16 reorder_buf_size = buf_size * sizeof(baid_data->entries[0]);
+		u32 reorder_buf_size = buf_size * sizeof(baid_data->entries[0]);
 
 		/* sparse doesn't like the __align() so don't check */
 #ifndef __CHECKER__
-- 
2.39.2

