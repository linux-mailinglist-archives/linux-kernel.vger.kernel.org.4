Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF4F473BB9E
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 17:26:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232468AbjFWP0E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 11:26:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232532AbjFWPZy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 11:25:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28E692129;
        Fri, 23 Jun 2023 08:25:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B4AE461A9D;
        Fri, 23 Jun 2023 15:25:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D02DBC433C0;
        Fri, 23 Jun 2023 15:25:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687533946;
        bh=NvWgTGjsHRqDtvBYDx/2FZ7WiFRdFqxIOJ2GEgQdP5s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jjSV3khYn7DQtMsuDg9EoNpKhthnIYHAR3qxDpF7Arr09pVBiSIRwUoI5OImA8F3s
         qmlveYBP11wTA/VaTOeOK/7UPuOJpMlPgbxtyOfpAb7MCX8PGdeVw8AX2mWpyCMGL/
         pkngpeZ4JGYxGMlzpLK1o860FrlWOZPNVFSi7u08r2V15VEqmBbkab00TOFCACUWYH
         qtq0Jf3f/vajbOgUJdUm+WzWV7Ycb5rkdLKbMJIkjBXxGD5sCB3mTP3mKs5YT28mI7
         8dwmjH+dAP0xRobOCLzn27EAfNnGTez82/9NOZJ5i1Hx9WiBXLPIU4DNp17r5a4SQV
         4BuY8MkMhjXJg==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Christian Lamparter <chunkeey@googlemail.com>,
        Kalle Valo <kvalo@kernel.org>,
        Johannes Berg <johannes.berg@intel.com>,
        Kees Cook <keescook@chromium.org>,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Gregory Greenman <gregory.greenman@intel.com>,
        Benjamin Berg <benjamin.berg@intel.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Ilan Peer <ilan.peer@intel.com>, Felix Fietkau <nbd@nbd.name>,
        Aloka Dixit <quic_alokad@quicinc.com>,
        Avraham Stern <avraham.stern@intel.com>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        netdev@vger.kernel.org
Subject: [PATCH 2/2] mac80211: make ieee80211_tx_info padding explicit
Date:   Fri, 23 Jun 2023 17:24:00 +0200
Message-Id: <20230623152443.2296825-2-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230623152443.2296825-1-arnd@kernel.org>
References: <20230623152443.2296825-1-arnd@kernel.org>
MIME-Version: 1.0
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

From: Arnd Bergmann <arnd@arndb.de>

While looking at a bug, I got rather confused by the layout of the
'status' field in ieee80211_tx_info. Apparently, the intention is that
status_driver_data[] is used for driver specific data, and fills up the
size of the union to 40 bytes, just like the other ones.

This is indeed what actually happens, but only because of the
combination of two mistakes:

 - "void *status_driver_data[18 / sizeof(void *)];" is intended
   to be 18 bytes long but is actually two bytes shorter because of
   rounding-down in the division, to a multiple of the pointer
   size (4 bytes or 8 bytes).

 - The other fields combined are intended to be 22 bytes long, but
   are actually 24 bytes because of padding in front of the
   unaligned tx_time member, and in front of the pointer array.

The two mistakes cancel out. so the size ends up fine, but it seems
more helpful to make this explicit, by having a multiple of 8 bytes
in the size calculation and explicitly describing the padding.

Fixes: ea5907db2a9cc ("mac80211: fix struct ieee80211_tx_info size")
Fixes: 02219b3abca59 ("mac80211: add WMM admission control support")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/net/mac80211.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 3a8a2d2c58c38..ca4dc8a14f1bb 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -1192,9 +1192,11 @@ struct ieee80211_tx_info {
 			u8 ampdu_ack_len;
 			u8 ampdu_len;
 			u8 antenna;
+			u8 pad;
 			u16 tx_time;
 			u8 flags;
-			void *status_driver_data[18 / sizeof(void *)];
+			u8 pad2;
+			void *status_driver_data[16 / sizeof(void *)];
 		} status;
 		struct {
 			struct ieee80211_tx_rate driver_rates[
-- 
2.39.2

