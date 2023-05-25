Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D5DF71143D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 20:38:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241957AbjEYShe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 14:37:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241589AbjEYShP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 14:37:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA5311FFA;
        Thu, 25 May 2023 11:35:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1C343648C7;
        Thu, 25 May 2023 18:34:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41741C433A7;
        Thu, 25 May 2023 18:34:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685039680;
        bh=EVL78Ns4lTPHqkzujyH14kgCSqILNOTIj3vn96MbkNU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pfS7qnWUJAkdoaFE8Uy6SsxZZQ7lHmDU/uQbDnoZI8OrramvT9s6dH3+tMBytLfPA
         de7GLehOmg9PLkFXD3ArA933YcJknpYv1IVI1hnIWTQe84vWa+efmhEqK+8dkGPH9o
         g2FH3CIqsGbZPCy0TolJ5R2RO6j8bjidSmiTx+mDrKaTvtvN5kqFmSXvLBf/HdjPHK
         Bw7fSrOYBPSz2vGdHXDgmiHMRPrJzEn6X9chss7w5RubfovTaLD4yWsGUMENDYDi5N
         1prp3W+E8gp1QYLEaMKQAg6yEDCm3EnP7EK5fPdJyZwTD9W/0NqT2zfbgXMNeDC4tm
         +2yiK3V5Rv3HQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>,
        Sasha Levin <sashal@kernel.org>, johannes@sipsolutions.net,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.3 47/67] wifi: mac80211: recalc chanctx mindef before assigning
Date:   Thu, 25 May 2023 14:31:24 -0400
Message-Id: <20230525183144.1717540-47-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230525183144.1717540-1-sashal@kernel.org>
References: <20230525183144.1717540-1-sashal@kernel.org>
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
index 1b182cf9d6610..77c90ed8f5d7d 100644
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

