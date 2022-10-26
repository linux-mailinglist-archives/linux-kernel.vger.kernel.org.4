Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49CCD60DEE9
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 12:36:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233328AbiJZKgl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 06:36:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231877AbiJZKgj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 06:36:39 -0400
Received: from msg-4.mailo.com (msg-4.mailo.com [213.182.54.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 001477AB36
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 03:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1666780585; bh=Nu1SWNtGRTsJcwbwP/PERGl+2UsXTpRN4McY4HN8/lU=;
        h=X-EA-Auth:Date:From:To:Subject:Message-ID:References:MIME-Version:
         Content-Type:In-Reply-To;
        b=hzqCngcJ3D74gZj2HTKcDVabu5ff2OFAjuk8kImoZz+jEtFE+iwW1IBX3K423H1Bx
         cweHeqCgkWRRqyj4jAdN04YoI2ECGCtYm/0mCjWlnZe8g4pCHpJS2dU6UypT96UwVZ
         7lzzs2Qn5/qLLLrDACdUuZglS3sOqS1ByrhaqdTE=
Received: by b-2.in.mailobj.net [192.168.90.12] with ESMTP
        via [213.182.55.206]
        Wed, 26 Oct 2022 12:36:25 +0200 (CEST)
X-EA-Auth: y/mb8iDgGK/LUCLB3d9Yyf+f8YvHkDUOK07o/RseykjYFs9uRR5y5S+zFb7fRulsBZmvsdLjVduxZR90zqY1ubUqOpWVaCBA
Date:   Wed, 26 Oct 2022 08:57:48 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     outreachy@lists.linux.dev,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] staging: rtl8192u: remove unnecessary function
 implementation
Message-ID: <a15fe9f6167e76e4422d303ceafbd4d9b432dd13.1666754500.git.drv@mailo.com>
References: <cover.1666754500.git.drv@mailo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1666754500.git.drv@mailo.com>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current implementation of function ieee80211_tkip_null simply returns
back to the caller without any useful instruction executions. This makes
the function call and its implementation unnecessary and should be
removed.

Signed-off-by: Deepak R Varma <drv@mailo.com>
---
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



