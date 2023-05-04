Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39EC96F7343
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 21:41:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbjEDTlu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 15:41:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjEDTls (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 15:41:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19B9676A0;
        Thu,  4 May 2023 12:41:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A99EB6369F;
        Thu,  4 May 2023 19:41:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4D5DC433EF;
        Thu,  4 May 2023 19:41:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683229306;
        bh=Wn4gTbf57LwpDRCHeR+QJZofpS9uoSncq21OSvW/Kd4=;
        h=From:To:Cc:Subject:Date:From;
        b=lFCENyy11CUnS0wDr6GzZCj1uo29zZOdT0Wp1up9KUZihfZ7ia0OENi+cdTum/sqP
         YvFxU4FR5XVHySmtqxbZGBpst28IQSSS5WXBEp8dMel63ut5z4f/Q9rQtITL6/jaaO
         IbrbmGiy0+ifli2S7FV6fhg2y5+2Bb0tVZEoG1jB0dyT5FNOP9Gi6ysaobDjcfwttb
         PYSiQDCG7GftT9gNAvFc4iCQFv1cK1AvLBENEKwc1hCrPiCoBZuCHAGrEB8jOIGvg9
         BfIIsVfouOvZhwsZgiD5btu0pyxc/Yl2q8ShuWTzjZK1Za67WKzaQLUhwLdB4NQGDU
         y2sKrsiwfSkWg==
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
Subject: [PATCH AUTOSEL 6.3 01/59] wifi: ath: Silence memcpy run-time false positive warning
Date:   Thu,  4 May 2023 15:40:44 -0400
Message-Id: <20230504194142.3805425-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
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

