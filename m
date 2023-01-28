Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F85167F7E3
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 13:59:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233631AbjA1M7E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Jan 2023 07:59:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231263AbjA1M7C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 07:59:02 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0E93241E5
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jan 2023 04:58:58 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id hw16so20272073ejc.10
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jan 2023 04:58:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pqrs.dk; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uuROj3nyp7dV3iUSTum+d5PMx4QdIcb7izQQJDYftSI=;
        b=Y5p2WTisAeifCG8baObGN6r1dVANpjO/mIRa21zkmSiDA8qQH7zbFhb82+MR79bHbA
         mUHOTvHoKK6mnTCXN3BpelI/UYoB0RIS8s42fv62X1Ob45HaCjFx31sDV7z+XL3S8oIT
         QgtoVO4lBOt86t7bsHEmB96Aa19A83qQ8tGXw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uuROj3nyp7dV3iUSTum+d5PMx4QdIcb7izQQJDYftSI=;
        b=ScFD/UZc8OZFx3m6uP+3j1NwtyvL3KpVDA5DeoPgE/gHGeR9Rbwk58XWps+IckX8Pj
         NqyyiLu9sH8UOONoqZgnFAyJ2EWZItitfiPlWoyu1fmA8H1Xok1RvpIR7RB506d76Wnb
         nyMi6js3A9dtY4fl6MXYhiafq4gxolwlFhkCBf68vjpqfx2rdZH09Jhr91m6WY7j5JwL
         71lQdV07u1rbejO7PsNVTRYm6YV08TIylpQ+wlj9B3+j5XHxBTH4jGZONDwNqp8z03Ap
         Wx1lrj2Wu7T2dT6YRJ635DHVikAXX6Gnj07v/0uzKhlGgNqS9AJc8lS+V4HTpzsEIcz0
         6Qag==
X-Gm-Message-State: AO0yUKWjqBWOFfO3yYPifVsLb/znIgcUy8OcUWbhBdOa7qVuz0COPj6Q
        SEAw0p7kXCYTpp6HsllrhEheOg==
X-Google-Smtp-Source: AK7set8V49ATRxWsDpSNlAwGdqeIi+XmJsbTndGlwz/dbBHyC3DwaoCXy4hBkhEk1UwTNsPPUwzhpg==
X-Received: by 2002:a17:907:a42a:b0:84d:4be4:aa2b with SMTP id sg42-20020a170907a42a00b0084d4be4aa2bmr3122116ejc.68.1674910737282;
        Sat, 28 Jan 2023 04:58:57 -0800 (PST)
Received: from localhost.localdomain (80.71.142.18.ipv4.parknet.dk. [80.71.142.18])
        by smtp.gmail.com with ESMTPSA id f25-20020a170906139900b0087b3d555d2esm2730051ejc.33.2023.01.28.04.58.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Jan 2023 04:58:56 -0800 (PST)
From:   =?UTF-8?q?Alvin=20=C5=A0ipraga?= <alvin@pqrs.dk>
To:     Johannes Berg <johannes@sipsolutions.net>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     =?UTF-8?q?Alvin=20=C5=A0ipraga?= <alsi@bang-olufsen.dk>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 next 1/2] wifi: nl80211: emit CMD_START_AP on multicast group when an AP is started
Date:   Sat, 28 Jan 2023 13:58:43 +0100
Message-Id: <20230128125844.2407135-1-alvin@pqrs.dk>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alvin Šipraga <alsi@bang-olufsen.dk>

Userspace processes such as network daemons may wish to be informed when
any AP interface is brought up on the system, for example to initiate a
(re)configuration of IP settings or to start a DHCP server.

Currently nl80211 does not broadcast any such event on its multicast
groups, leaving userspace only two options:

1. the process must be the one that actually issued the
   NL80211_CMD_START_AP request, so that it can react on the response to
   that request;

2. the process must react to RTM_NEWLINK events indicating a change in
   carrier state, and may query for further information about the AP and
   react accordingly.

Option (1) is robust, but it does not cover all scenarios. It is easy to
imagine a situation where this is not the case (e.g. hostapd +
systemd-networkd).

Option (2) is not robust, because RTM_NEWLINK events may be silently
discarded by the linkwatch logic (cf. linkwatch_fire_event()).
Concretely, consider a scenario in which the carrier state flip-flops in
the following way:

 ^ carrier state (high/low = carrier/no carrier)
 |
 |        _______      _______ ...
 |       |       |    |
 | ______| "foo" |____| "bar"             (SSID in "quotes")
 |
 +-------A-------B----C---------> time

If the time interval between (A) and (C) is less than 1 second, then
linkwatch may emit only a single RTM_NEWLINK event indicating carrier
gain.

This is problematic because it is possible that the network
configuration that should be applied is a function of the AP's
properties such as SSID (cf. SSID= in systemd.network(5)). As
illustrated in the above diagram, it may be that the AP with SSID "bar"
ends up being configured as though it had SSID "foo".

Address the above issue by having nl80211 emit an NL80211_CMD_START_AP
message on the MLME nl80211 multicast group. This allows for arbitrary
processes to be reliably informed.

Signed-off-by: Alvin Šipraga <alsi@bang-olufsen.dk>
---
v1 -> v2: add MLO link ID to the event per Johannes' comments
---
 net/wireless/nl80211.c | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 64cf6110ce9d..7370ddf84fd3 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -5770,6 +5770,42 @@ static bool nl80211_valid_auth_type(struct cfg80211_registered_device *rdev,
 	}
 }
 
+static void nl80211_send_ap_started(struct wireless_dev *wdev,
+				    unsigned int link_id)
+{
+	struct wiphy *wiphy = wdev->wiphy;
+	struct cfg80211_registered_device *rdev = wiphy_to_rdev(wiphy);
+	struct sk_buff *msg;
+	void *hdr;
+
+	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
+	if (!msg)
+		return;
+
+	hdr = nl80211hdr_put(msg, 0, 0, 0, NL80211_CMD_START_AP);
+	if (!hdr)
+		goto out;
+
+	if (nla_put_u32(msg, NL80211_ATTR_WIPHY, rdev->wiphy_idx) ||
+	    nla_put_u32(msg, NL80211_ATTR_IFINDEX, wdev->netdev->ifindex) ||
+	    nla_put_u64_64bit(msg, NL80211_ATTR_WDEV, wdev_id(wdev),
+			      NL80211_ATTR_PAD) ||
+	    (wdev->u.ap.ssid_len &&
+	     nla_put(msg, NL80211_ATTR_SSID, wdev->u.ap.ssid_len,
+		     wdev->u.ap.ssid)) ||
+	    (wdev->valid_links &&
+	     nla_put_u8(msg, NL80211_ATTR_MLO_LINK_ID, link_id)))
+		goto out;
+
+	genlmsg_end(msg, hdr);
+
+	genlmsg_multicast_netns(&nl80211_fam, wiphy_net(wiphy), msg, 0,
+				NL80211_MCGRP_MLME, GFP_KERNEL);
+	return;
+out:
+	nlmsg_free(msg);
+}
+
 static int nl80211_start_ap(struct sk_buff *skb, struct genl_info *info)
 {
 	struct cfg80211_registered_device *rdev = info->user_ptr[0];
@@ -6050,6 +6086,8 @@ static int nl80211_start_ap(struct sk_buff *skb, struct genl_info *info)
 
 		if (info->attrs[NL80211_ATTR_SOCKET_OWNER])
 			wdev->conn_owner_nlportid = info->snd_portid;
+
+		nl80211_send_ap_started(wdev, link_id);
 	}
 out_unlock:
 	wdev_unlock(wdev);
-- 
2.39.0

