Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 154CD741EF1
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 05:54:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231169AbjF2Dyc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 23:54:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231989AbjF2DyC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 23:54:02 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59E242D7D
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 20:54:00 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id 41be03b00d2f7-55b1238a024so217864a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 20:54:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1688010840; x=1690602840;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PgRCWuAL+JILQAuJVgnpzN1VGDR5+ycwundGmuPsvAc=;
        b=Zp7/05od1Hzmg3DamsY4xVwfn6tMykIurlQXX5Rz4Xuof4ze/XQSv561GpHeqSpoKh
         2v+EzzaIXKRz/2+ZwPdbePYm00aj+7lpLYrNJ4hAYEhBfPYw1efyvEasC85ra7aPmZY2
         HvVIPX6DZQ3ldkpxDKKby+eFfCylabLuTSQA0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688010840; x=1690602840;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PgRCWuAL+JILQAuJVgnpzN1VGDR5+ycwundGmuPsvAc=;
        b=FULKJ4nMjDsJEx9bzeGx81UiA9Dqi/EqYr3jMs3vfx0OxRKJlrdrA4Gs8PpPk81HAu
         WCf4gtDtTEq5alKKALVCWp+Or7k3+GdMCrgKTEGTB66KSDztzLGGfXul/w7jthmzquXN
         hPCXgsVP0MyN33/EKjPNza2kdWfUjDf9Z0YNIlWE7P+ZYNiSWoboKozYNOQWrcUvdJor
         gW9rz1aNBR9XKvAS8haLi73y05rApuW6ULgEg0KLgqwpMTWDlpfQ7abvscVBrv3lrQer
         veKD9YxFshyEbUm2Q0DlpSJojWvzF8cuSb12OhRh+YD/SKmkdxDWTgRhVdx1wAybeBYf
         Gsbg==
X-Gm-Message-State: AC+VfDyuvCl/EiqWYyJe6dfNndNFYUonC+bRCAeGsEhHantrBh00503Q
        euZTkdd19YYqFCF0OIXT6/BnfA==
X-Google-Smtp-Source: ACHHUZ6y8ticW17Bm2FXqsOoVj+oMchk8icLpia+Wu94tK8W+NMrPIcN6NkM7fNXF21kuk4TIlr51g==
X-Received: by 2002:a05:6a20:1605:b0:115:83f:fce1 with SMTP id l5-20020a056a20160500b00115083ffce1mr48159642pzj.5.1688010839715;
        Wed, 28 Jun 2023 20:53:59 -0700 (PDT)
Received: from kuabhs-cdev.c.googlers.com.com (242.67.247.35.bc.googleusercontent.com. [35.247.67.242])
        by smtp.gmail.com with ESMTPSA id r19-20020a634413000000b005579f12a238sm7019842pga.86.2023.06.28.20.53.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 20:53:59 -0700 (PDT)
From:   Abhishek Kumar <kuabhs@chromium.org>
To:     johannes.berg@intel.com, kvalo@kernel.org
Cc:     linux-kernel@vger.kernel.org, kuabhs@chromium.org,
        netdev@vger.kernel.org, ath10k@lists.infradead.org,
        linux-wireless@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH 1/2] wifi: cfg80211: call reg_call_notifier on beacon hints
Date:   Thu, 29 Jun 2023 03:52:54 +0000
Message-ID: <20230629035254.1.I059fe585f9f9e896c2d51028ef804d197c8c009e@changeid>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the channel property updates are not propagated to
driver. This causes issues in the discovery of hidden SSIDs and
fails to connect to them.
This change defines a new wiphy flag which when enabled by vendor
driver, the reg_call_notifier callback will be trigger on beacon
hints. This ensures that the channel property changes are visible
to the vendor driver. The vendor changes the channels for active
scans. This fixes the discovery issue of hidden SSID.

Signed-off-by: Abhishek Kumar <kuabhs@chromium.org>
---

 include/net/cfg80211.h |  3 +++
 net/wireless/reg.c     | 20 ++++++++++++--------
 2 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 9e04f69712b1..48e6ebcdacb3 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -4783,6 +4783,8 @@ struct cfg80211_ops {
  * @WIPHY_FLAG_SUPPORTS_EXT_KCK_32: The device supports 32-byte KCK keys.
  * @WIPHY_FLAG_NOTIFY_REGDOM_BY_DRIVER: The device could handle reg notify for
  *	NL80211_REGDOM_SET_BY_DRIVER.
+ * @WIPHY_FLAG_CHANNEL_CHANGE_ON_BEACON: reg_call_notifier() is called if driver
+ *	set this flag to update channels on beacon hints.
  */
 enum wiphy_flags {
 	WIPHY_FLAG_SUPPORTS_EXT_KEK_KCK		= BIT(0),
@@ -4809,6 +4811,7 @@ enum wiphy_flags {
 	WIPHY_FLAG_SUPPORTS_5_10_MHZ		= BIT(22),
 	WIPHY_FLAG_HAS_CHANNEL_SWITCH		= BIT(23),
 	WIPHY_FLAG_NOTIFY_REGDOM_BY_DRIVER	= BIT(24),
+	WIPHY_FLAG_CHANNEL_CHANGE_ON_BEACON     = BIT(25),
 };
 
 /**
diff --git a/net/wireless/reg.c b/net/wireless/reg.c
index 26f11e4746c0..c76bfaad650b 100644
--- a/net/wireless/reg.c
+++ b/net/wireless/reg.c
@@ -2149,6 +2149,13 @@ static bool reg_is_world_roaming(struct wiphy *wiphy)
 	return false;
 }
 
+static void reg_call_notifier(struct wiphy *wiphy,
+			      struct regulatory_request *request)
+{
+	if (wiphy->reg_notifier)
+		wiphy->reg_notifier(wiphy, request);
+}
+
 static void handle_reg_beacon(struct wiphy *wiphy, unsigned int chan_idx,
 			      struct reg_beacon *reg_beacon)
 {
@@ -2156,6 +2163,7 @@ static void handle_reg_beacon(struct wiphy *wiphy, unsigned int chan_idx,
 	struct ieee80211_channel *chan;
 	bool channel_changed = false;
 	struct ieee80211_channel chan_before;
+	struct regulatory_request *lr = get_last_request();
 
 	sband = wiphy->bands[reg_beacon->chan.band];
 	chan = &sband->channels[chan_idx];
@@ -2181,8 +2189,11 @@ static void handle_reg_beacon(struct wiphy *wiphy, unsigned int chan_idx,
 		channel_changed = true;
 	}
 
-	if (channel_changed)
+	if (channel_changed) {
 		nl80211_send_beacon_hint_event(wiphy, &chan_before, chan);
+		if (wiphy->flags & WIPHY_FLAG_CHANNEL_CHANGE_ON_BEACON)
+			reg_call_notifier(wiphy, lr);
+	}
 }
 
 /*
@@ -2325,13 +2336,6 @@ static void reg_process_ht_flags(struct wiphy *wiphy)
 		reg_process_ht_flags_band(wiphy, wiphy->bands[band]);
 }
 
-static void reg_call_notifier(struct wiphy *wiphy,
-			      struct regulatory_request *request)
-{
-	if (wiphy->reg_notifier)
-		wiphy->reg_notifier(wiphy, request);
-}
-
 static bool reg_wdev_chan_valid(struct wiphy *wiphy, struct wireless_dev *wdev)
 {
 	struct cfg80211_chan_def chandef = {};
-- 
2.41.0.162.gfafddb0af9-goog

