Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C5C3613CAA
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 18:55:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231976AbiJaRzu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 13:55:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231924AbiJaRzs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 13:55:48 -0400
Received: from msg-2.mailo.com (msg-2.mailo.com [213.182.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B590F64FC
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 10:55:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1667238938; bh=rB87oAJR+6lb1gKdfEfCEm/RmF0Is3m3yYVI7ot8vx0=;
        h=X-EA-Auth:Date:From:To:Subject:Message-ID:References:MIME-Version:
         Content-Type:In-Reply-To;
        b=KZKH+6roVodEooS1YF1kl+SWTCwkdoMVQ5aHl5KGAiuB7rTSCWhUdIsHC23VOzX1p
         7+pvH5CqgHMNrxCmmf+kpTWYcNSfuWfhnJ9Su7zAd9lGsXaoWctHkBXAxA2I0vQKLa
         niRR8a/yb0Y5bc3X9bA/Trmjp1azTOsg+8hXxcXE=
Received: by b-1.in.mailobj.net [192.168.90.11] with ESMTP
        via [213.182.55.206]
        Mon, 31 Oct 2022 18:55:38 +0100 (CET)
X-EA-Auth: PgDpDwzFshbn/ZqZmKx0JNAGDk/e4QHXzFtZGcbc6j3l1nQBmXrEpRJUryRiVusuTaoIzVQP1pHX4nxvjFt9KpGnpdU9qE2E
Date:   Mon, 31 Oct 2022 23:25:39 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     outreachy@lists.linux.dev, gregkh@linuxfoundation.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] staging: rtl8192u: remove unnecessary function
 implementation
Message-ID: <6f5a4313fc21365bf733c25385aef79554ffb253.1667237959.git.drv@mailo.com>
References: <cover.1667237959.git.drv@mailo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1667237959.git.drv@mailo.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver is a single standalone driver and does not have any loading
dependencies on another associated drivers. The build results in one
single .ko object. The current implementation of the function
ieee80211_tkip_null simply returns back to the caller without any useful
instruction executions. It does not lead to auto-loading of any other
associated modules as the initial design implementation appears to be.

Hence the call to ieee80211_tkip_null() and its implementation is
unnecessary and should be removed.

Signed-off-by: Deepak R Varma <drv@mailo.com>
---

Changes in v2:
   1. Patch log revised to explain the impact of proposed changes.
      Suggested by gregkh@linuxfoundation.org


 drivers/staging/rtl8192u/ieee80211/ieee80211.h            | 3 ---
 drivers/staging/rtl8192u/ieee80211/ieee80211_crypt_tkip.c | 6 ------
 drivers/staging/rtl8192u/ieee80211/ieee80211_module.c     | 3 ---
 3 files changed, 12 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211.h b/drivers/staging/rtl8192u/ieee80211/ieee80211.h
index 9cd4b1896745..00c07455cbb3 100644
--- a/drivers/staging/rtl8192u/ieee80211/ieee80211.h
+++ b/drivers/staging/rtl8192u/ieee80211/ieee80211.h
@@ -232,8 +232,6 @@ struct cb_desc {

 #define ieee80211_ccmp_null		ieee80211_ccmp_null_rsl

-#define ieee80211_tkip_null		ieee80211_tkip_null_rsl
-
 #define free_ieee80211			free_ieee80211_rsl
 #define alloc_ieee80211			alloc_ieee80211_rsl

@@ -2256,7 +2254,6 @@ void ieee80211_ps_tx_ack(struct ieee80211_device *ieee, short success);
 void softmac_mgmt_xmit(struct sk_buff *skb, struct ieee80211_device *ieee);

 /* ieee80211_crypt_ccmp&tkip&wep.c */
-void ieee80211_tkip_null(void);

 int ieee80211_crypto_init(void);
 void ieee80211_crypto_deinit(void);
diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211_crypt_tkip.c b/drivers/staging/rtl8192u/ieee80211/ieee80211_crypt_tkip.c
index 7b120b8cb982..9bfd24ad46b6 100644
--- a/drivers/staging/rtl8192u/ieee80211/ieee80211_crypt_tkip.c
+++ b/drivers/staging/rtl8192u/ieee80211/ieee80211_crypt_tkip.c
@@ -716,9 +716,3 @@ void ieee80211_crypto_tkip_exit(void)
 {
 	ieee80211_unregister_crypto_ops(&ieee80211_crypt_tkip);
 }
-
-void ieee80211_tkip_null(void)
-{
-//    printk("============>%s()\n", __func__);
-	return;
-}
diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211_module.c b/drivers/staging/rtl8192u/ieee80211/ieee80211_module.c
index b94fe9b449b6..3f93939bc4ee 100644
--- a/drivers/staging/rtl8192u/ieee80211/ieee80211_module.c
+++ b/drivers/staging/rtl8192u/ieee80211/ieee80211_module.c
@@ -159,9 +159,6 @@ struct net_device *alloc_ieee80211(int sizeof_priv)
 		ieee->last_packet_time[i] = 0;
 	}

-/* These function were added to load crypte module autoly */
-	ieee80211_tkip_null();
-
 	return dev;

  failed:
--
2.30.2



