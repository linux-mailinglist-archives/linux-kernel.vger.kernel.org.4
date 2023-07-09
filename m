Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E51B74C50F
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jul 2023 17:13:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233147AbjGIPNx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jul 2023 11:13:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233077AbjGIPNi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jul 2023 11:13:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8BC6130;
        Sun,  9 Jul 2023 08:13:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 77BFD60C16;
        Sun,  9 Jul 2023 15:13:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD481C43391;
        Sun,  9 Jul 2023 15:13:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688915598;
        bh=wKXr/dlvuwhoqG7NTqfII2N83LeUQF7/ue+SLfqzCUc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TL90ukOUpFqcjYoC9ZBM5emjXcURCe1SWsnB7+FZYhiwrO0DiO0U/CwW6sX3HQuLh
         vL7me4F6sCu7sVSVQiOq4PFUnLqD1rXjzcF8GnPUbTTftEnV8HjkhD801wBIxL6PGL
         5yuCqSGKGcBdFMzQCVMGnPr58iB26+Pl7xP1/ShItHezrv1EgcKTzvAQjmUZtpiHpz
         IV4LmBxydLrzC7yAzBIAfR9N/FoDgCQk13Sq93qicyrguZKRLWaQjJDagq3n8EJrNo
         3at24ZAk1L19p8Nl4Tct0ZvJE1sDrkko32bjrhLXDDZcuKxmKfTZrsc82OVWJHmlNb
         xn4wjXlLbh5+A==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Ilan Peer <ilan.peer@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <sashal@kernel.org>, johannes@sipsolutions.net,
        kvalo@kernel.org, linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.4 13/26] wifi: mac80211_hwsim: Fix possible NULL dereference
Date:   Sun,  9 Jul 2023 11:12:42 -0400
Message-Id: <20230709151255.512931-13-sashal@kernel.org>
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

From: Ilan Peer <ilan.peer@intel.com>

[ Upstream commit 0cc80943ef518a1c51a1111e9346d1daf11dd545 ]

In a call to mac80211_hwsim_select_tx_link() the sta pointer might
be NULL, thus need to check that it is not NULL before accessing it.

Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
Link: https://lore.kernel.org/r/20230604120651.f4d889fc98c4.Iae85f527ed245a37637a874bb8b8c83d79812512@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/virtual/mac80211_hwsim.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/virtual/mac80211_hwsim.c b/drivers/net/wireless/virtual/mac80211_hwsim.c
index 89c7a1420381d..ed5af63025979 100644
--- a/drivers/net/wireless/virtual/mac80211_hwsim.c
+++ b/drivers/net/wireless/virtual/mac80211_hwsim.c
@@ -4,7 +4,7 @@
  * Copyright (c) 2008, Jouni Malinen <j@w1.fi>
  * Copyright (c) 2011, Javier Lopez <jlopex@gmail.com>
  * Copyright (c) 2016 - 2017 Intel Deutschland GmbH
- * Copyright (C) 2018 - 2022 Intel Corporation
+ * Copyright (C) 2018 - 2023 Intel Corporation
  */
 
 /*
@@ -1864,7 +1864,7 @@ mac80211_hwsim_select_tx_link(struct mac80211_hwsim_data *data,
 
 	WARN_ON(is_multicast_ether_addr(hdr->addr1));
 
-	if (WARN_ON_ONCE(!sta->valid_links))
+	if (WARN_ON_ONCE(!sta || !sta->valid_links))
 		return &vif->bss_conf;
 
 	for (i = 0; i < ARRAY_SIZE(vif->link_conf); i++) {
-- 
2.39.2

