Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BB2C711447
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 20:38:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229973AbjEYSgb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 14:36:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241835AbjEYSgC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 14:36:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80CD01704;
        Thu, 25 May 2023 11:34:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 60431648C8;
        Thu, 25 May 2023 18:34:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99FA1C4339E;
        Thu, 25 May 2023 18:34:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685039676;
        bh=jsPeEoMdfnjG3yq1yn0CpvtwxmBvoB4aCIMwlK9t67A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nnqMNlztjD3l4AFnKmlCMDtXT/9dQDw/YAVM6BMh+guRZGOPfcMye0P21vwbJJ4qY
         YzbPM9lepGRdjSqJpE2Pp5+2cuawxNZ1Sgp8+5dvsTHgOs5T8kWglOI1r5T69Q0IPp
         UQVCBjnJYLPJuCUlW7mEkR4TEQyPpCruORdW63uDXLz08WidnqXa3FoC36qyn2/kX1
         DFL1V55T7+aW5MmnNDLS/XCHbYcGCVqZNUMQqFM0j+0CDFMieI5TxruDcUP9yzpPtD
         4Jy1xWyz+bbx396+r8GYlmBCZKC2JQrfhcY0TA6Pr6VMxKPRF7ARUM7QepsXpFkgYW
         1nLnaKOzw6opw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>,
        Sasha Levin <sashal@kernel.org>, johannes@sipsolutions.net,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.3 45/67] wifi: mac80211: simplify chanctx allocation
Date:   Thu, 25 May 2023 14:31:22 -0400
Message-Id: <20230525183144.1717540-45-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230525183144.1717540-1-sashal@kernel.org>
References: <20230525183144.1717540-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

[ Upstream commit 860e1b43da94551cd1e73adc36b3c64cc3e5dc01 ]

There's no need to call ieee80211_recalc_chanctx_min_def()
since it cannot and won't call the driver anyway; just use
_ieee80211_recalc_chanctx_min_def() instead.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
Link: https://lore.kernel.org/r/20230504134511.828474-3-gregory.greenman@intel.com
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mac80211/chan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mac80211/chan.c b/net/mac80211/chan.c
index dbc34fbe7c8f4..d23d1a7b4cc39 100644
--- a/net/mac80211/chan.c
+++ b/net/mac80211/chan.c
@@ -638,7 +638,7 @@ ieee80211_alloc_chanctx(struct ieee80211_local *local,
 	ctx->conf.rx_chains_dynamic = 1;
 	ctx->mode = mode;
 	ctx->conf.radar_enabled = false;
-	ieee80211_recalc_chanctx_min_def(local, ctx);
+	_ieee80211_recalc_chanctx_min_def(local, ctx);
 
 	return ctx;
 }
-- 
2.39.2

