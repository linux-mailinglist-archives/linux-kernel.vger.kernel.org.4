Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2982D616540
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 15:38:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231558AbiKBOiz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 10:38:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231251AbiKBOix (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 10:38:53 -0400
Received: from msg-1.mailo.com (msg-1.mailo.com [213.182.54.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A34822B03
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 07:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1667399924; bh=a+lbhjlM/Clh3MESLWcfowPkdKKBuiCL3z35uR4rf6Y=;
        h=X-EA-Auth:Date:From:To:Subject:Message-ID:References:MIME-Version:
         Content-Type:In-Reply-To;
        b=ZnA9QGhjUSQ5viKRQRMf4c73AcSoIYaiiw3Hz/WVuXxLk6QpDqCnmbHnktSjZKf8q
         tI+01YoPwtkUXD4bfR2yz/B91Xu3XtrdoxyPjzcy6y/GMu4wuiHZPkjy0M+Z2ciU/6
         R2171vvX5OwricK3/KJ9cW4KwKO+U8Krh7IcuGEI=
Received: by b-3.in.mailobj.net [192.168.90.13] with ESMTP
        via [213.182.55.206]
        Wed,  2 Nov 2022 15:38:44 +0100 (CET)
X-EA-Auth: 6fDWgS1NtTpdMFGN+VfdARZYuh/a30ONUIBcDez9O8HMA39YFUQarhU+xG0nZs0aEzQ7onOJLnfxyxdMEq3dJcL9OOUVX0p4
Date:   Wed, 2 Nov 2022 20:08:42 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     outreachy@lists.linux.dev, gregkh@linuxfoundation.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/2] staging: rtl8192u: remove redundant macro definitions
Message-ID: <3c66c1c4d79fdacad70f590433dd3c374119d375.1667398621.git.drv@mailo.com>
References: <cover.1667398621.git.drv@mailo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1667398621.git.drv@mailo.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Several ieee80211_* symbol names are extended with _rsl tag using
macros. This is done to avoid a conflict when a similar symbol is
already in use in another part of kernel and may lead to conflicts.
However, most of these base symbol names are not found to being used
anywhere in the code and hence are not useful today. These symbols
are not used outside of the module and hence can be safely removed.
The code continues to use the original symbol names.

Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Deepak R Varma <drv@mailo.com>
---

Changes in v3:
   1. The patch caused a build failure due to EXPORT_SYMBOL conflict across
      modules. Retain macro defines for ieee80211_wake_queue and ieee80211_stop_queue
      to avoid EXPORT_SYMBOL conflict caused by similar function names from
      net/mac80211 module.
      Correction and resubmission asked by gregkh@linuxfoundation.org

Changes in v2:
   1. Review other similar macro defines and clean those up as well.
      Suggested by gregkh@linuxfoundation.org
   2. Revise patch log to explain impact of the patch
      Suggested by julia.lawall@inria.fr

 .../staging/rtl8192u/ieee80211/ieee80211.h    | 61 -------------------
 1 file changed, 61 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211.h b/drivers/staging/rtl8192u/ieee80211/ieee80211.h
index 00c07455cbb3..c5c43d2fb93e 100644
--- a/drivers/staging/rtl8192u/ieee80211/ieee80211.h
+++ b/drivers/staging/rtl8192u/ieee80211/ieee80211.h
@@ -223,71 +223,10 @@ struct cb_desc {
 #define MAX_IE_LEN  0xff

 // added for kernel conflict
-#define ieee80211_crypt_deinit_entries	ieee80211_crypt_deinit_entries_rsl
-#define ieee80211_crypt_deinit_handler	ieee80211_crypt_deinit_handler_rsl
-#define ieee80211_crypt_delayed_deinit	ieee80211_crypt_delayed_deinit_rsl
-#define ieee80211_register_crypto_ops	ieee80211_register_crypto_ops_rsl
-#define ieee80211_unregister_crypto_ops ieee80211_unregister_crypto_ops_rsl
-#define ieee80211_get_crypto_ops	ieee80211_get_crypto_ops_rsl
-
-#define ieee80211_ccmp_null		ieee80211_ccmp_null_rsl
-
-#define free_ieee80211			free_ieee80211_rsl
-#define alloc_ieee80211			alloc_ieee80211_rsl
-
-#define ieee80211_rx			ieee80211_rx_rsl
-#define ieee80211_rx_mgt		ieee80211_rx_mgt_rsl
-
-#define ieee80211_get_beacon		ieee80211_get_beacon_rsl
 #define ieee80211_wake_queue		ieee80211_wake_queue_rsl
 #define ieee80211_stop_queue		ieee80211_stop_queue_rsl
-#define ieee80211_reset_queue		ieee80211_reset_queue_rsl
-#define ieee80211_softmac_stop_protocol	ieee80211_softmac_stop_protocol_rsl
-#define ieee80211_softmac_start_protocol ieee80211_softmac_start_protocol_rsl
-#define ieee80211_is_shortslot		ieee80211_is_shortslot_rsl
-#define ieee80211_is_54g		ieee80211_is_54g_rsl
-#define ieee80211_wpa_supplicant_ioctl	ieee80211_wpa_supplicant_ioctl_rsl
-#define ieee80211_ps_tx_ack		ieee80211_ps_tx_ack_rsl
-#define ieee80211_softmac_xmit		ieee80211_softmac_xmit_rsl
-#define ieee80211_stop_send_beacons	ieee80211_stop_send_beacons_rsl
 #define notify_wx_assoc_event		notify_wx_assoc_event_rsl
 #define SendDisassociation		SendDisassociation_rsl
-#define ieee80211_disassociate		ieee80211_disassociate_rsl
-#define ieee80211_start_send_beacons	ieee80211_start_send_beacons_rsl
-#define ieee80211_stop_scan		ieee80211_stop_scan_rsl
-#define ieee80211_send_probe_requests	ieee80211_send_probe_requests_rsl
-#define ieee80211_softmac_scan_syncro	ieee80211_softmac_scan_syncro_rsl
-#define ieee80211_start_scan_syncro	ieee80211_start_scan_syncro_rsl
-
-#define ieee80211_wx_get_essid		ieee80211_wx_get_essid_rsl
-#define ieee80211_wx_set_essid		ieee80211_wx_set_essid_rsl
-#define ieee80211_wx_set_rate		ieee80211_wx_set_rate_rsl
-#define ieee80211_wx_get_rate		ieee80211_wx_get_rate_rsl
-#define ieee80211_wx_set_wap		ieee80211_wx_set_wap_rsl
-#define ieee80211_wx_get_wap		ieee80211_wx_get_wap_rsl
-#define ieee80211_wx_set_mode		ieee80211_wx_set_mode_rsl
-#define ieee80211_wx_get_mode		ieee80211_wx_get_mode_rsl
-#define ieee80211_wx_set_scan		ieee80211_wx_set_scan_rsl
-#define ieee80211_wx_get_freq		ieee80211_wx_get_freq_rsl
-#define ieee80211_wx_set_freq		ieee80211_wx_set_freq_rsl
-#define ieee80211_wx_set_rawtx		ieee80211_wx_set_rawtx_rsl
-#define ieee80211_wx_get_name		ieee80211_wx_get_name_rsl
-#define ieee80211_wx_set_power		ieee80211_wx_set_power_rsl
-#define ieee80211_wx_get_power		ieee80211_wx_get_power_rsl
-#define ieee80211_wlan_frequencies	ieee80211_wlan_frequencies_rsl
-#define ieee80211_wx_set_rts		ieee80211_wx_set_rts_rsl
-#define ieee80211_wx_get_rts		ieee80211_wx_get_rts_rsl
-
-#define ieee80211_txb_free		ieee80211_txb_free_rsl
-
-#define ieee80211_wx_set_gen_ie		ieee80211_wx_set_gen_ie_rsl
-#define ieee80211_wx_get_scan		ieee80211_wx_get_scan_rsl
-#define ieee80211_wx_set_encode		ieee80211_wx_set_encode_rsl
-#define ieee80211_wx_get_encode		ieee80211_wx_get_encode_rsl
-#define ieee80211_wx_set_mlme		ieee80211_wx_set_mlme_rsl
-#define ieee80211_wx_set_auth		ieee80211_wx_set_auth_rsl
-#define ieee80211_wx_set_encode_ext	ieee80211_wx_set_encode_ext_rsl
-#define ieee80211_wx_get_encode_ext	ieee80211_wx_get_encode_ext_rsl


 struct ieee_param {
--
2.30.2



