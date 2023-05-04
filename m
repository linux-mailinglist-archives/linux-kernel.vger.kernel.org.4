Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 784356F7496
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 21:51:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231712AbjEDTvq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 15:51:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231643AbjEDTuV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 15:50:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DE4C150C3;
        Thu,  4 May 2023 12:46:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B894B637C0;
        Thu,  4 May 2023 19:46:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D34CDC433EF;
        Thu,  4 May 2023 19:46:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683229590;
        bh=Wn4gTbf57LwpDRCHeR+QJZofpS9uoSncq21OSvW/Kd4=;
        h=From:To:Cc:Subject:Date:From;
        b=BsrZBQe7OwLK7GQ2QigABoltvwm/4jzzfF7pDWyHNMZYmkTWqZOaRhlin4K0a4k0J
         1x/SX6kl/JcFAcTYLO9NK6STkIiUaPYPxfWmrVrZ1E/H3L+f98a2BWYnGcUdC5oxQk
         BSSqWNJKppo2qsHWI3RM9VkXJNK7uJf7yYIWWiB9017nCShOULjjwsyxwhJozShC2s
         xmu0Q2b8dr/iXbO31uljOfX9dFfy+RGSdMmCoWX8s+NboeLkCPIeCwvL/hF34QjD+q
         UCXiylUKJENX+yhkYCY+BhN6vYHhbX6HaQ0kQeU1pdHpZ44ElVSqnM/u++rs4BeIaH
         2Pnuf86hgYpNg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>, Kalle Valo <kvalo@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        Kalle Valo <quic_kvalo@quicinc.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 6.1 01/49] wifi: ath: Silence memcpy run-time false positive warning
Date:   Thu,  4 May 2023 15:45:38 -0400
Message-Id: <20230504194626.3807438-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kees Cook <keescook@chromium.org>

[ Upstream commit bfcc8ba45eb87bfaaff900bbad2b87b204899d41 ]

The memcpy() in ath_key_config() was attempting to write across
neighboring struct members in struct ath_keyval. Introduce a wrapping
struct_group, kv_values, to be the addressable target of the memcpy
without overflowing an individual member. Silences the false positive
run-time warning:

  memcpy: detected field-spanning write (size 32) of single field "hk.kv_val" at drivers/net/wireless/ath/key.c:506 (size 16)

Link: https://bbs.archlinux.org/viewtopic.php?id=282254
Cc: Kalle Valo <kvalo@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: linux-wireless@vger.kernel.org
Cc: netdev@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
Link: https://lore.kernel.org/r/20230210054310.never.554-kees@kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/ath/ath.h | 12 +++++++-----
 drivers/net/wireless/ath/key.c |  2 +-
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/ath/ath.h b/drivers/net/wireless/ath/ath.h
index f083fb9038c36..f02a308a9ffc5 100644
--- a/drivers/net/wireless/ath/ath.h
+++ b/drivers/net/wireless/ath/ath.h
@@ -96,11 +96,13 @@ struct ath_keyval {
 	u8 kv_type;
 	u8 kv_pad;
 	u16 kv_len;
-	u8 kv_val[16]; /* TK */
-	u8 kv_mic[8]; /* Michael MIC key */
-	u8 kv_txmic[8]; /* Michael MIC TX key (used only if the hardware
-			 * supports both MIC keys in the same key cache entry;
-			 * in that case, kv_mic is the RX key) */
+	struct_group(kv_values,
+		u8 kv_val[16]; /* TK */
+		u8 kv_mic[8]; /* Michael MIC key */
+		u8 kv_txmic[8]; /* Michael MIC TX key (used only if the hardware
+				 * supports both MIC keys in the same key cache entry;
+				 * in that case, kv_mic is the RX key) */
+	);
 };
 
 enum ath_cipher {
diff --git a/drivers/net/wireless/ath/key.c b/drivers/net/wireless/ath/key.c
index 61b59a804e308..b7b61d4f02bae 100644
--- a/drivers/net/wireless/ath/key.c
+++ b/drivers/net/wireless/ath/key.c
@@ -503,7 +503,7 @@ int ath_key_config(struct ath_common *common,
 
 	hk.kv_len = key->keylen;
 	if (key->keylen)
-		memcpy(hk.kv_val, key->key, key->keylen);
+		memcpy(&hk.kv_values, key->key, key->keylen);
 
 	if (!(key->flags & IEEE80211_KEY_FLAG_PAIRWISE)) {
 		switch (vif->type) {
-- 
2.39.2

