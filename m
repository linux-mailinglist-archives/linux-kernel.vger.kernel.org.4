Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D1D57114FA
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 20:42:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242312AbjEYSmR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 14:42:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242281AbjEYSlr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 14:41:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAD381BE4;
        Thu, 25 May 2023 11:38:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EF1276492A;
        Thu, 25 May 2023 18:38:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F0F7C4339C;
        Thu, 25 May 2023 18:38:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685039895;
        bh=EA7EnyBO8cmCNPcf02dhIWL9dadcEv0qdxkRF7doZKc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JAqVzC2HAGhcfAxE2MW5GyrQmArqWiXHiOrxlsvjCLzxj+tXVMpbsAxS1d/E1qU+I
         8JaCb5hhgrdB/4Nf3oouNFbBxQXhSCODAK5hKZ+6Xj6fj2gEsjdBgO2GIVzrIPJdN4
         zy80wLyGhi6xzEkkhlvBLigszqvsKK+FPIi6ndINT73o4KDxls1LL471lASFUnYohy
         Hp2Tjg+pjNjOpit1kmKl4KzqbFnoYy9YTCQHxG2dGMOfNSMuyhBt9Vt6FzcV6qkas8
         ueohZvjZtYfWcMXh+NV1Vevct4hwZGqrx/5rUnpUdB9DE7sEfYX0qK8bMyscNExCGl
         LbFfJBqez9PJQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>,
        Sasha Levin <sashal@kernel.org>, johannes@sipsolutions.net,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 41/57] wifi: mac80211: recalc chanctx mindef before assigning
Date:   Thu, 25 May 2023 14:35:51 -0400
Message-Id: <20230525183607.1793983-41-sashal@kernel.org>
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

From: Johannes Berg <johannes.berg@intel.com>

[ Upstream commit 04312de4ced4b152749614e8179f3978a20a992f ]

When we allocate a new channel context, or find an existing one
that is compatible, we currently assign it to a link before its
mindef is updated. This leads to strange situations, especially
in link switching where you switch to an 80 MHz link and expect
it to be active immediately, but the mindef is still configured
to 20 MHz while assigning.  Also, it's strange that the chandef
passed to the assign method's argument is wider than the one in
the context.

Fix this by calculating the mindef with the new link considered
before calling the driver.

In particular, this fixes an iwlwifi problem during link switch
where the firmware would assert because the (link) station that
was added for the AP is configured to transmit at a bandwidth
that's wider than the channel context that it's configured on.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
Link: https://lore.kernel.org/r/20230504134511.828474-5-gregory.greenman@intel.com
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mac80211/chan.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/mac80211/chan.c b/net/mac80211/chan.c
index c5d345e53056a..f07e34bed8f3a 100644
--- a/net/mac80211/chan.c
+++ b/net/mac80211/chan.c
@@ -871,6 +871,9 @@ static int ieee80211_assign_link_chanctx(struct ieee80211_link_data *link,
 	}
 
 	if (new_ctx) {
+		/* recalc considering the link we'll use it for now */
+		ieee80211_recalc_chanctx_min_def(local, new_ctx, link);
+
 		ret = drv_assign_vif_chanctx(local, sdata, link->conf, new_ctx);
 		if (ret)
 			goto out;
-- 
2.39.2

