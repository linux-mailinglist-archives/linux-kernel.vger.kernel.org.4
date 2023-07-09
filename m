Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 311A074C522
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jul 2023 17:14:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232984AbjGIPOY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jul 2023 11:14:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233189AbjGIPOG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jul 2023 11:14:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79EC0E45;
        Sun,  9 Jul 2023 08:13:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5160460C0F;
        Sun,  9 Jul 2023 15:13:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC4E8C43391;
        Sun,  9 Jul 2023 15:13:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688915617;
        bh=LH2hwoUFKM2bcWoEr3Ue+OY/SGHBF6JkUd2BHQ0tcIo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ahWir//vbjRqGSMU/6bD+fL+CSG9eefXn/CpY0w1gxXIWc7WXcW5t2IEh0Qv4F+lj
         Lc6XiNkqW5K4mgioeqN/oJ+aM68hd58fjt9r6T8U1goQD2Bf9HsoJ0gSG8OzxnTs+K
         YCRJE7BCpuqiH1DzG/XjZfVYXJHmkDcRu9+aKn98w3P9+CK67hcB4D0qOGSc0zLLcZ
         zI9XVUfhjZaI0bW1N7TJ/+g4hV+jVT2zzoJkpcxhe+JD5A+kDCj+B13lJTnOephKq3
         MhhQDTcvv97RTg50IDWumFHMtQ3z6lXsOnfhm2jbmLNeBX277XqeH1Rn/PGyCYOjaK
         JsWqOObMzX3fg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Mukesh Sisodiya <mukesh.sisodiya@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <sashal@kernel.org>, kvalo@kernel.org,
        linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.4 20/26] wifi: iwlwifi: mvm: Add NULL check before dereferencing the pointer
Date:   Sun,  9 Jul 2023 11:12:49 -0400
Message-Id: <20230709151255.512931-20-sashal@kernel.org>
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

From: Mukesh Sisodiya <mukesh.sisodiya@intel.com>

[ Upstream commit 7dd50fd5478056929a012c6bf8b3c6f87c7e9e87 ]

While vif pointers are protected by the corresponding "*active"
fields, static checkers can get confused sometimes. Add an explicit
check.

Signed-off-by: Mukesh Sisodiya <mukesh.sisodiya@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
Link: https://lore.kernel.org/r/20230614154951.78749ae91fb5.Id3c05d13eeee6638f0930f750e93fb928d5c9dee@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/intel/iwlwifi/mvm/power.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/power.c b/drivers/net/wireless/intel/iwlwifi/mvm/power.c
index ac1dae52556f8..19839cc44eb3d 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/power.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/power.c
@@ -647,30 +647,32 @@ static void iwl_mvm_power_set_pm(struct iwl_mvm *mvm,
 		return;
 
 	/* enable PM on bss if bss stand alone */
-	if (vifs->bss_active && !vifs->p2p_active && !vifs->ap_active) {
+	if (bss_mvmvif && vifs->bss_active && !vifs->p2p_active &&
+	    !vifs->ap_active) {
 		bss_mvmvif->pm_enabled = true;
 		return;
 	}
 
 	/* enable PM on p2p if p2p stand alone */
-	if (vifs->p2p_active && !vifs->bss_active && !vifs->ap_active) {
+	if (p2p_mvmvif && vifs->p2p_active && !vifs->bss_active &&
+	    !vifs->ap_active) {
 		p2p_mvmvif->pm_enabled = true;
 		return;
 	}
 
-	if (vifs->bss_active && vifs->p2p_active)
+	if (p2p_mvmvif && bss_mvmvif && vifs->bss_active && vifs->p2p_active)
 		client_same_channel =
 			iwl_mvm_have_links_same_channel(bss_mvmvif, p2p_mvmvif);
 
-	if (vifs->bss_active && vifs->ap_active)
+	if (bss_mvmvif && ap_mvmvif && vifs->bss_active && vifs->ap_active)
 		ap_same_channel =
 			iwl_mvm_have_links_same_channel(bss_mvmvif, ap_mvmvif);
 
 	/* clients are not stand alone: enable PM if DCM */
 	if (!(client_same_channel || ap_same_channel)) {
-		if (vifs->bss_active)
+		if (bss_mvmvif && vifs->bss_active)
 			bss_mvmvif->pm_enabled = true;
-		if (vifs->p2p_active)
+		if (p2p_mvmvif && vifs->p2p_active)
 			p2p_mvmvif->pm_enabled = true;
 		return;
 	}
-- 
2.39.2

