Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5750621DB7
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 21:35:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229853AbiKHUfT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 15:35:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229913AbiKHUfO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 15:35:14 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3F8566CA1;
        Tue,  8 Nov 2022 12:35:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 71FBA6175E;
        Tue,  8 Nov 2022 20:35:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A9E9C433D6;
        Tue,  8 Nov 2022 20:35:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667939710;
        bh=Xx+mGAgvbypl1rTYLXJ4XaeL7gpH3pdFmHyagpcxEKE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vGmcrrSZZwovL4jNQyrhPoksEpLagKDTxbkEdYTRlqNOwH8L/5eoiGc1MScOmgQZq
         hogSe69bDz+J/NrAC1S+KOoSwlQKen0ObfwT6b2NoS8KBV1DT159EavitXThk9rgUg
         KoW3Y2/7F1ZIT4xOAb8LHqck3yn3+G5FHCUCj6znOqm8BHhO5z7AHpOVOgeGeyGFMQ
         dGmwyHqmspHJDkVQg2keeU2GSP0wuxZBRT3uAwHuSTID4UKxJpdTLNbWZsHSiNQl+V
         I3byDZWai6t2qGZu1W950ez3IUa6937ZGNbegkFwi0Ir8g6bJ+4YWJXzZXPRjFHiOV
         zNCwEefoqPUEw==
Date:   Tue, 8 Nov 2022 14:34:46 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH v3 7/7] staging: ks7010: Avoid clashing function prototypes
Message-ID: <8d2ceee1248b5a76e9b6c379f578e65482c91168.1667934775.git.gustavoars@kernel.org>
References: <cover.1667934775.git.gustavoars@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1667934775.git.gustavoars@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When built with Control Flow Integrity, function prototypes between
caller and function declaration must match. These mismatches are visible
at compile time with the new -Wcast-function-type-strict in Clang[1].

Fix a total of 27 warnings like these:

drivers/staging/ks7010/ks_wlan_net.c:2415:2: warning: cast from 'int (*)(struct net_device *, struct iw_request_info *, struct iw_point *, char *)' to 'iw_handler' (aka 'int (*)(struct net_device *, struct iw_request_info *, union iwreq_data *, char *)') converts to incompatible function type [-Wcast-function-type-strict]
        (iw_handler)ks_wlan_get_firmware_version,/* 3 KS_WLAN_GET_FIRM_VERSION */
        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The ks_wlan_net Wireless Extension handler callbacks (iw_handler) use a
union for the data argument. Actually use the union and perform explicit
member selection in the function body instead of having a function
prototype mismatch. There are no resulting binary differences
before/after changes.

These changes were made partly manually and partly with the help of
Coccinelle.

Link: https://reviews.llvm.org/D134831 [1]
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
Changes in v3:
 - Remove iw_handler casts from ks_wlan_private_handler[].
 - Update changelog text.

Changes in v2:
 - None. This patch is new in the series.
 - Link: https://lore.kernel.org/linux-hardening/34bf3ce1b1ca2da4c5ec8a6e26f31bbb9ca1c4f5.1666894751.git.gustavoars@kernel.org/

 drivers/staging/ks7010/ks_wlan_net.c | 248 ++++++++++++++-------------
 1 file changed, 126 insertions(+), 122 deletions(-)

diff --git a/drivers/staging/ks7010/ks_wlan_net.c b/drivers/staging/ks7010/ks_wlan_net.c
index 7e8d37c169f0..044c807ca022 100644
--- a/drivers/staging/ks7010/ks_wlan_net.c
+++ b/drivers/staging/ks7010/ks_wlan_net.c
@@ -1763,8 +1763,8 @@ static struct iw_statistics *ks_get_wireless_stats(struct net_device *dev)
 }
 
 static int ks_wlan_set_stop_request(struct net_device *dev,
-				    struct iw_request_info *info, __u32 *uwrq,
-				    char *extra)
+				    struct iw_request_info *info,
+				    union iwreq_data *uwrq, char *extra)
 {
 	struct ks_wlan_private *priv = netdev_priv(dev);
 
@@ -1772,7 +1772,7 @@ static int ks_wlan_set_stop_request(struct net_device *dev,
 		return -EPERM;
 
 	/* for SLEEP MODE */
-	if (!(*uwrq))
+	if (!(uwrq->mode))
 		return -EINVAL;
 
 	hostif_sme_enqueue(priv, SME_STOP_REQUEST);
@@ -1786,7 +1786,9 @@ static int ks_wlan_set_mlme(struct net_device *dev,
 {
 	struct ks_wlan_private *priv = netdev_priv(dev);
 	struct iw_mlme *mlme = (struct iw_mlme *)extra;
-	__u32 mode = 1;
+	union iwreq_data uwrq;
+
+	uwrq.mode = 1;
 
 	if (priv->sleep_mode == SLP_SLEEP)
 		return -EPERM;
@@ -1799,13 +1801,14 @@ static int ks_wlan_set_mlme(struct net_device *dev,
 	    mlme->reason_code == WLAN_REASON_MIC_FAILURE)
 		return 0;
 
-	return ks_wlan_set_stop_request(dev, NULL, &mode, NULL);
+	return ks_wlan_set_stop_request(dev, NULL, &uwrq, NULL);
 }
 
 static int ks_wlan_get_firmware_version(struct net_device *dev,
 					struct iw_request_info *info,
-					struct iw_point *dwrq, char *extra)
+					union iwreq_data *uwrq, char *extra)
 {
+	struct iw_point *dwrq = &uwrq->data;
 	struct ks_wlan_private *priv = netdev_priv(dev);
 
 	dwrq->length = priv->version_size + 1;
@@ -1814,8 +1817,8 @@ static int ks_wlan_get_firmware_version(struct net_device *dev,
 }
 
 static int ks_wlan_set_preamble(struct net_device *dev,
-				struct iw_request_info *info, __u32 *uwrq,
-				char *extra)
+				struct iw_request_info *info,
+				union iwreq_data *uwrq, char *extra)
 {
 	struct ks_wlan_private *priv = netdev_priv(dev);
 
@@ -1823,17 +1826,17 @@ static int ks_wlan_set_preamble(struct net_device *dev,
 		return -EPERM;
 
 	/* for SLEEP MODE */
-	if (*uwrq != LONG_PREAMBLE && *uwrq != SHORT_PREAMBLE)
+	if (uwrq->mode != LONG_PREAMBLE && uwrq->mode != SHORT_PREAMBLE)
 		return -EINVAL;
 
-	priv->reg.preamble = *uwrq;
+	priv->reg.preamble = uwrq->mode;
 	priv->need_commit |= SME_MODE_SET;
 	return -EINPROGRESS;	/* Call commit handler */
 }
 
 static int ks_wlan_get_preamble(struct net_device *dev,
-				struct iw_request_info *info, __u32 *uwrq,
-				char *extra)
+				struct iw_request_info *info,
+				union iwreq_data *uwrq, char *extra)
 {
 	struct ks_wlan_private *priv = netdev_priv(dev);
 
@@ -1841,37 +1844,37 @@ static int ks_wlan_get_preamble(struct net_device *dev,
 		return -EPERM;
 
 	/* for SLEEP MODE */
-	*uwrq = priv->reg.preamble;
+	uwrq->mode = priv->reg.preamble;
 	return 0;
 }
 
 static int ks_wlan_set_power_mgmt(struct net_device *dev,
-				  struct iw_request_info *info, __u32 *uwrq,
-				  char *extra)
+				  struct iw_request_info *info,
+				  union iwreq_data *uwrq, char *extra)
 {
 	struct ks_wlan_private *priv = netdev_priv(dev);
 
 	if (priv->sleep_mode == SLP_SLEEP)
 		return -EPERM;
 
-	if (*uwrq != POWER_MGMT_ACTIVE &&
-	    *uwrq != POWER_MGMT_SAVE1 &&
-	    *uwrq != POWER_MGMT_SAVE2)
+	if (uwrq->mode != POWER_MGMT_ACTIVE &&
+	    uwrq->mode != POWER_MGMT_SAVE1 &&
+	    uwrq->mode != POWER_MGMT_SAVE2)
 		return -EINVAL;
 
-	if ((*uwrq == POWER_MGMT_SAVE1 || *uwrq == POWER_MGMT_SAVE2) &&
+	if ((uwrq->mode == POWER_MGMT_SAVE1 || uwrq->mode == POWER_MGMT_SAVE2) &&
 	    (priv->reg.operation_mode != MODE_INFRASTRUCTURE))
 		return -EINVAL;
 
-	priv->reg.power_mgmt = *uwrq;
+	priv->reg.power_mgmt = uwrq->mode;
 	hostif_sme_enqueue(priv, SME_POW_MNGMT_REQUEST);
 
 	return 0;
 }
 
 static int ks_wlan_get_power_mgmt(struct net_device *dev,
-				  struct iw_request_info *info, __u32 *uwrq,
-				  char *extra)
+				  struct iw_request_info *info,
+				  union iwreq_data *uwrq, char *extra)
 {
 	struct ks_wlan_private *priv = netdev_priv(dev);
 
@@ -1879,13 +1882,13 @@ static int ks_wlan_get_power_mgmt(struct net_device *dev,
 		return -EPERM;
 
 	/* for SLEEP MODE */
-	*uwrq = priv->reg.power_mgmt;
+	uwrq->mode = priv->reg.power_mgmt;
 	return 0;
 }
 
 static int ks_wlan_set_scan_type(struct net_device *dev,
-				 struct iw_request_info *info, __u32 *uwrq,
-				 char *extra)
+				 struct iw_request_info *info,
+				 union iwreq_data *uwrq, char *extra)
 {
 	struct ks_wlan_private *priv = netdev_priv(dev);
 
@@ -1893,39 +1896,39 @@ static int ks_wlan_set_scan_type(struct net_device *dev,
 		return -EPERM;
 	/* for SLEEP MODE */
 
-	if (*uwrq != ACTIVE_SCAN && *uwrq != PASSIVE_SCAN)
+	if (uwrq->mode != ACTIVE_SCAN && uwrq->mode != PASSIVE_SCAN)
 		return -EINVAL;
 
-	priv->reg.scan_type = *uwrq;
+	priv->reg.scan_type = uwrq->mode;
 	return 0;
 }
 
 static int ks_wlan_get_scan_type(struct net_device *dev,
-				 struct iw_request_info *info, __u32 *uwrq,
-				 char *extra)
+				 struct iw_request_info *info,
+				 union iwreq_data *uwrq, char *extra)
 {
 	struct ks_wlan_private *priv = netdev_priv(dev);
 
 	if (priv->sleep_mode == SLP_SLEEP)
 		return -EPERM;
 	/* for SLEEP MODE */
-	*uwrq = priv->reg.scan_type;
+	uwrq->mode = priv->reg.scan_type;
 	return 0;
 }
 
 static int ks_wlan_set_beacon_lost(struct net_device *dev,
-				   struct iw_request_info *info, __u32 *uwrq,
-				   char *extra)
+				   struct iw_request_info *info,
+				   union iwreq_data *uwrq, char *extra)
 {
 	struct ks_wlan_private *priv = netdev_priv(dev);
 
 	if (priv->sleep_mode == SLP_SLEEP)
 		return -EPERM;
 	/* for SLEEP MODE */
-	if (*uwrq > BEACON_LOST_COUNT_MAX)
+	if (uwrq->mode > BEACON_LOST_COUNT_MAX)
 		return -EINVAL;
 
-	priv->reg.beacon_lost_count = *uwrq;
+	priv->reg.beacon_lost_count = uwrq->mode;
 
 	if (priv->reg.operation_mode == MODE_INFRASTRUCTURE) {
 		priv->need_commit |= SME_MODE_SET;
@@ -1936,101 +1939,101 @@ static int ks_wlan_set_beacon_lost(struct net_device *dev,
 }
 
 static int ks_wlan_get_beacon_lost(struct net_device *dev,
-				   struct iw_request_info *info, __u32 *uwrq,
-				   char *extra)
+				   struct iw_request_info *info,
+				   union iwreq_data *uwrq, char *extra)
 {
 	struct ks_wlan_private *priv = netdev_priv(dev);
 
 	if (priv->sleep_mode == SLP_SLEEP)
 		return -EPERM;
 	/* for SLEEP MODE */
-	*uwrq = priv->reg.beacon_lost_count;
+	uwrq->mode = priv->reg.beacon_lost_count;
 	return 0;
 }
 
 static int ks_wlan_set_phy_type(struct net_device *dev,
-				struct iw_request_info *info, __u32 *uwrq,
-				char *extra)
+				struct iw_request_info *info,
+				union iwreq_data *uwrq, char *extra)
 {
 	struct ks_wlan_private *priv = netdev_priv(dev);
 
 	if (priv->sleep_mode == SLP_SLEEP)
 		return -EPERM;
 
-	if (*uwrq != D_11B_ONLY_MODE &&
-	    *uwrq != D_11G_ONLY_MODE &&
-	    *uwrq != D_11BG_COMPATIBLE_MODE)
+	if (uwrq->mode != D_11B_ONLY_MODE &&
+	    uwrq->mode != D_11G_ONLY_MODE &&
+	    uwrq->mode != D_11BG_COMPATIBLE_MODE)
 		return -EINVAL;
 
 	/* for SLEEP MODE */
-	priv->reg.phy_type = *uwrq;
+	priv->reg.phy_type = uwrq->mode;
 	priv->need_commit |= SME_MODE_SET;
 	return -EINPROGRESS;	/* Call commit handler */
 }
 
 static int ks_wlan_get_phy_type(struct net_device *dev,
-				struct iw_request_info *info, __u32 *uwrq,
-				char *extra)
+				struct iw_request_info *info,
+				union iwreq_data *uwrq, char *extra)
 {
 	struct ks_wlan_private *priv = netdev_priv(dev);
 
 	if (priv->sleep_mode == SLP_SLEEP)
 		return -EPERM;
 	/* for SLEEP MODE */
-	*uwrq = priv->reg.phy_type;
+	uwrq->mode = priv->reg.phy_type;
 	return 0;
 }
 
 static int ks_wlan_set_cts_mode(struct net_device *dev,
-				struct iw_request_info *info, __u32 *uwrq,
-				char *extra)
+				struct iw_request_info *info,
+				union iwreq_data *uwrq, char *extra)
 {
 	struct ks_wlan_private *priv = netdev_priv(dev);
 
 	if (priv->sleep_mode == SLP_SLEEP)
 		return -EPERM;
 	/* for SLEEP MODE */
-	if (*uwrq != CTS_MODE_FALSE && *uwrq != CTS_MODE_TRUE)
+	if (uwrq->mode != CTS_MODE_FALSE && uwrq->mode != CTS_MODE_TRUE)
 		return -EINVAL;
 
-	priv->reg.cts_mode = (*uwrq == CTS_MODE_FALSE) ? *uwrq :
+	priv->reg.cts_mode = (uwrq->mode == CTS_MODE_FALSE) ? uwrq->mode :
 			      (priv->reg.phy_type == D_11G_ONLY_MODE ||
 			       priv->reg.phy_type == D_11BG_COMPATIBLE_MODE) ?
-			       *uwrq : !*uwrq;
+			       uwrq->mode : !uwrq->mode;
 
 	priv->need_commit |= SME_MODE_SET;
 	return -EINPROGRESS;	/* Call commit handler */
 }
 
 static int ks_wlan_get_cts_mode(struct net_device *dev,
-				struct iw_request_info *info, __u32 *uwrq,
-				char *extra)
+				struct iw_request_info *info,
+				union iwreq_data *uwrq, char *extra)
 {
 	struct ks_wlan_private *priv = netdev_priv(dev);
 
 	if (priv->sleep_mode == SLP_SLEEP)
 		return -EPERM;
 	/* for SLEEP MODE */
-	*uwrq = priv->reg.cts_mode;
+	uwrq->mode = priv->reg.cts_mode;
 	return 0;
 }
 
 static int ks_wlan_set_sleep_mode(struct net_device *dev,
 				  struct iw_request_info *info,
-				  __u32 *uwrq, char *extra)
+				  union iwreq_data *uwrq, char *extra)
 {
 	struct ks_wlan_private *priv = netdev_priv(dev);
 
-	if (*uwrq != SLP_SLEEP &&
-	    *uwrq != SLP_ACTIVE) {
-		netdev_err(dev, "SET_SLEEP_MODE %d error\n", *uwrq);
+	if (uwrq->mode != SLP_SLEEP &&
+	    uwrq->mode != SLP_ACTIVE) {
+		netdev_err(dev, "SET_SLEEP_MODE %d error\n", uwrq->mode);
 		return -EINVAL;
 	}
 
-	priv->sleep_mode = *uwrq;
+	priv->sleep_mode = uwrq->mode;
 	netdev_info(dev, "SET_SLEEP_MODE %d\n", priv->sleep_mode);
 
-	if (*uwrq == SLP_SLEEP)
+	if (uwrq->mode == SLP_SLEEP)
 		hostif_sme_enqueue(priv, SME_STOP_REQUEST);
 
 	hostif_sme_enqueue(priv, SME_SLEEP_REQUEST);
@@ -2040,52 +2043,53 @@ static int ks_wlan_set_sleep_mode(struct net_device *dev,
 
 static int ks_wlan_get_sleep_mode(struct net_device *dev,
 				  struct iw_request_info *info,
-				  __u32 *uwrq, char *extra)
+				  union iwreq_data *uwrq, char *extra)
 {
 	struct ks_wlan_private *priv = netdev_priv(dev);
 
-	*uwrq = priv->sleep_mode;
+	uwrq->mode = priv->sleep_mode;
 
 	return 0;
 }
 
 static int ks_wlan_set_wps_enable(struct net_device *dev,
-				  struct iw_request_info *info, __u32 *uwrq,
-				  char *extra)
+				  struct iw_request_info *info,
+				  union iwreq_data *uwrq, char *extra)
 {
 	struct ks_wlan_private *priv = netdev_priv(dev);
 
 	if (priv->sleep_mode == SLP_SLEEP)
 		return -EPERM;
 	/* for SLEEP MODE */
-	if (*uwrq != 0 && *uwrq != 1)
+	if (uwrq->mode != 0 && uwrq->mode != 1)
 		return -EINVAL;
 
-	priv->wps.wps_enabled = *uwrq;
+	priv->wps.wps_enabled = uwrq->mode;
 	hostif_sme_enqueue(priv, SME_WPS_ENABLE_REQUEST);
 
 	return 0;
 }
 
 static int ks_wlan_get_wps_enable(struct net_device *dev,
-				  struct iw_request_info *info, __u32 *uwrq,
-				  char *extra)
+				  struct iw_request_info *info,
+				  union iwreq_data *uwrq, char *extra)
 {
 	struct ks_wlan_private *priv = netdev_priv(dev);
 
 	if (priv->sleep_mode == SLP_SLEEP)
 		return -EPERM;
 	/* for SLEEP MODE */
-	*uwrq = priv->wps.wps_enabled;
-	netdev_info(dev, "return=%d\n", *uwrq);
+	uwrq->mode = priv->wps.wps_enabled;
+	netdev_info(dev, "return=%d\n", uwrq->mode);
 
 	return 0;
 }
 
 static int ks_wlan_set_wps_probe_req(struct net_device *dev,
 				     struct iw_request_info *info,
-				     struct iw_point *dwrq, char *extra)
+				     union iwreq_data *uwrq, char *extra)
 {
+	struct iw_point *dwrq = &uwrq->data;
 	u8 *p = extra;
 	unsigned char len;
 	struct ks_wlan_private *priv = netdev_priv(dev);
@@ -2114,76 +2118,76 @@ static int ks_wlan_set_wps_probe_req(struct net_device *dev,
 }
 
 static int ks_wlan_set_tx_gain(struct net_device *dev,
-			       struct iw_request_info *info, __u32 *uwrq,
-			       char *extra)
+			       struct iw_request_info *info,
+			       union iwreq_data *uwrq, char *extra)
 {
 	struct ks_wlan_private *priv = netdev_priv(dev);
 
 	if (priv->sleep_mode == SLP_SLEEP)
 		return -EPERM;
 	/* for SLEEP MODE */
-	if (*uwrq > 0xFF)
+	if (uwrq->mode > 0xFF)
 		return -EINVAL;
 
-	priv->gain.tx_gain = (u8)*uwrq;
+	priv->gain.tx_gain = (u8)uwrq->mode;
 	priv->gain.tx_mode = (priv->gain.tx_gain < 0xFF) ? 1 : 0;
 	hostif_sme_enqueue(priv, SME_SET_GAIN);
 	return 0;
 }
 
 static int ks_wlan_get_tx_gain(struct net_device *dev,
-			       struct iw_request_info *info, __u32 *uwrq,
-			       char *extra)
+			       struct iw_request_info *info,
+			       union iwreq_data *uwrq, char *extra)
 {
 	struct ks_wlan_private *priv = netdev_priv(dev);
 
 	if (priv->sleep_mode == SLP_SLEEP)
 		return -EPERM;
 	/* for SLEEP MODE */
-	*uwrq = priv->gain.tx_gain;
+	uwrq->mode = priv->gain.tx_gain;
 	hostif_sme_enqueue(priv, SME_GET_GAIN);
 	return 0;
 }
 
 static int ks_wlan_set_rx_gain(struct net_device *dev,
-			       struct iw_request_info *info, __u32 *uwrq,
-			       char *extra)
+			       struct iw_request_info *info,
+			       union iwreq_data *uwrq, char *extra)
 {
 	struct ks_wlan_private *priv = netdev_priv(dev);
 
 	if (priv->sleep_mode == SLP_SLEEP)
 		return -EPERM;
 	/* for SLEEP MODE */
-	if (*uwrq > 0xFF)
+	if (uwrq->mode > 0xFF)
 		return -EINVAL;
 
-	priv->gain.rx_gain = (u8)*uwrq;
+	priv->gain.rx_gain = (u8)uwrq->mode;
 	priv->gain.rx_mode = (priv->gain.rx_gain < 0xFF) ? 1 : 0;
 	hostif_sme_enqueue(priv, SME_SET_GAIN);
 	return 0;
 }
 
 static int ks_wlan_get_rx_gain(struct net_device *dev,
-			       struct iw_request_info *info, __u32 *uwrq,
-			       char *extra)
+			       struct iw_request_info *info,
+			       union iwreq_data *uwrq, char *extra)
 {
 	struct ks_wlan_private *priv = netdev_priv(dev);
 
 	if (priv->sleep_mode == SLP_SLEEP)
 		return -EPERM;
 	/* for SLEEP MODE */
-	*uwrq = priv->gain.rx_gain;
+	uwrq->mode = priv->gain.rx_gain;
 	hostif_sme_enqueue(priv, SME_GET_GAIN);
 	return 0;
 }
 
 static int ks_wlan_get_eeprom_cksum(struct net_device *dev,
-				    struct iw_request_info *info, __u32 *uwrq,
-				    char *extra)
+				    struct iw_request_info *info,
+				    union iwreq_data *uwrq, char *extra)
 {
 	struct ks_wlan_private *priv = netdev_priv(dev);
 
-	*uwrq = priv->eeprom_checksum;
+	uwrq->mode = priv->eeprom_checksum;
 	return 0;
 }
 
@@ -2302,7 +2306,7 @@ static void print_hif_event(struct net_device *dev, int event)
 
 /* get host command history */
 static int ks_wlan_hostt(struct net_device *dev, struct iw_request_info *info,
-			 __u32 *uwrq, char *extra)
+			 union iwreq_data *uwrq, char *extra)
 {
 	int i, event;
 	struct ks_wlan_private *priv = netdev_priv(dev);
@@ -2409,38 +2413,38 @@ static const iw_handler ks_wlan_handler[] = {
 
 /* private_handler */
 static const iw_handler ks_wlan_private_handler[] = {
-	(iw_handler)NULL,			/* 0 */
-	(iw_handler)NULL,			/* 1, KS_WLAN_GET_DRIVER_VERSION */
-	(iw_handler)NULL,			/* 2 */
-	(iw_handler)ks_wlan_get_firmware_version,/* 3 KS_WLAN_GET_FIRM_VERSION */
-	(iw_handler)ks_wlan_set_wps_enable,	/* 4 KS_WLAN_SET_WPS_ENABLE */
-	(iw_handler)ks_wlan_get_wps_enable,	/* 5 KS_WLAN_GET_WPS_ENABLE */
-	(iw_handler)ks_wlan_set_wps_probe_req,	/* 6 KS_WLAN_SET_WPS_PROBE_REQ */
-	(iw_handler)ks_wlan_get_eeprom_cksum,	/* 7 KS_WLAN_GET_CONNECT */
-	(iw_handler)ks_wlan_set_preamble,	/* 8 KS_WLAN_SET_PREAMBLE */
-	(iw_handler)ks_wlan_get_preamble,	/* 9 KS_WLAN_GET_PREAMBLE */
-	(iw_handler)ks_wlan_set_power_mgmt,	/* 10 KS_WLAN_SET_POWER_SAVE */
-	(iw_handler)ks_wlan_get_power_mgmt,	/* 11 KS_WLAN_GET_POWER_SAVE */
-	(iw_handler)ks_wlan_set_scan_type,	/* 12 KS_WLAN_SET_SCAN_TYPE */
-	(iw_handler)ks_wlan_get_scan_type,	/* 13 KS_WLAN_GET_SCAN_TYPE */
-	(iw_handler)ks_wlan_set_rx_gain,	/* 14 KS_WLAN_SET_RX_GAIN */
-	(iw_handler)ks_wlan_get_rx_gain,	/* 15 KS_WLAN_GET_RX_GAIN */
-	(iw_handler)ks_wlan_hostt,		/* 16 KS_WLAN_HOSTT */
-	(iw_handler)NULL,			/* 17 */
-	(iw_handler)ks_wlan_set_beacon_lost,	/* 18 KS_WLAN_SET_BECAN_LOST */
-	(iw_handler)ks_wlan_get_beacon_lost,	/* 19 KS_WLAN_GET_BECAN_LOST */
-	(iw_handler)ks_wlan_set_tx_gain,	/* 20 KS_WLAN_SET_TX_GAIN */
-	(iw_handler)ks_wlan_get_tx_gain,	/* 21 KS_WLAN_GET_TX_GAIN */
-	(iw_handler)ks_wlan_set_phy_type,	/* 22 KS_WLAN_SET_PHY_TYPE */
-	(iw_handler)ks_wlan_get_phy_type,	/* 23 KS_WLAN_GET_PHY_TYPE */
-	(iw_handler)ks_wlan_set_cts_mode,	/* 24 KS_WLAN_SET_CTS_MODE */
-	(iw_handler)ks_wlan_get_cts_mode,	/* 25 KS_WLAN_GET_CTS_MODE */
-	(iw_handler)NULL,			/* 26 */
-	(iw_handler)NULL,			/* 27 */
-	(iw_handler)ks_wlan_set_sleep_mode,	/* 28 KS_WLAN_SET_SLEEP_MODE */
-	(iw_handler)ks_wlan_get_sleep_mode,	/* 29 KS_WLAN_GET_SLEEP_MODE */
-	(iw_handler)NULL,			/* 30 */
-	(iw_handler)NULL,			/* 31 */
+	NULL,				/* 0 */
+	NULL,				/* 1, KS_WLAN_GET_DRIVER_VERSION */
+	NULL,				/* 2 */
+	ks_wlan_get_firmware_version,	/* 3 KS_WLAN_GET_FIRM_VERSION */
+	ks_wlan_set_wps_enable,		/* 4 KS_WLAN_SET_WPS_ENABLE */
+	ks_wlan_get_wps_enable,		/* 5 KS_WLAN_GET_WPS_ENABLE */
+	ks_wlan_set_wps_probe_req,	/* 6 KS_WLAN_SET_WPS_PROBE_REQ */
+	ks_wlan_get_eeprom_cksum,	/* 7 KS_WLAN_GET_CONNECT */
+	ks_wlan_set_preamble,		/* 8 KS_WLAN_SET_PREAMBLE */
+	ks_wlan_get_preamble,		/* 9 KS_WLAN_GET_PREAMBLE */
+	ks_wlan_set_power_mgmt,		/* 10 KS_WLAN_SET_POWER_SAVE */
+	ks_wlan_get_power_mgmt,		/* 11 KS_WLAN_GET_POWER_SAVE */
+	ks_wlan_set_scan_type,		/* 12 KS_WLAN_SET_SCAN_TYPE */
+	ks_wlan_get_scan_type,		/* 13 KS_WLAN_GET_SCAN_TYPE */
+	ks_wlan_set_rx_gain,		/* 14 KS_WLAN_SET_RX_GAIN */
+	ks_wlan_get_rx_gain,		/* 15 KS_WLAN_GET_RX_GAIN */
+	ks_wlan_hostt,			/* 16 KS_WLAN_HOSTT */
+	NULL,				/* 17 */
+	ks_wlan_set_beacon_lost,	/* 18 KS_WLAN_SET_BECAN_LOST */
+	ks_wlan_get_beacon_lost,	/* 19 KS_WLAN_GET_BECAN_LOST */
+	ks_wlan_set_tx_gain,		/* 20 KS_WLAN_SET_TX_GAIN */
+	ks_wlan_get_tx_gain,		/* 21 KS_WLAN_GET_TX_GAIN */
+	ks_wlan_set_phy_type,		/* 22 KS_WLAN_SET_PHY_TYPE */
+	ks_wlan_get_phy_type,		/* 23 KS_WLAN_GET_PHY_TYPE */
+	ks_wlan_set_cts_mode,		/* 24 KS_WLAN_SET_CTS_MODE */
+	ks_wlan_get_cts_mode,		/* 25 KS_WLAN_GET_CTS_MODE */
+	NULL,				/* 26 */
+	NULL,				/* 27 */
+	ks_wlan_set_sleep_mode,		/* 28 KS_WLAN_SET_SLEEP_MODE */
+	ks_wlan_get_sleep_mode,		/* 29 KS_WLAN_GET_SLEEP_MODE */
+	NULL,				/* 30 */
+	NULL,				/* 31 */
 };
 
 static const struct iw_handler_def ks_wlan_handler_def = {
@@ -2461,7 +2465,7 @@ static int ks_wlan_netdev_ioctl(struct net_device *dev, struct ifreq *rq,
 
 	switch (cmd) {
 	case SIOCIWFIRSTPRIV + 20:	/* KS_WLAN_SET_STOP_REQ */
-		ret = ks_wlan_set_stop_request(dev, NULL, &wrq->u.mode, NULL);
+		ret = ks_wlan_set_stop_request(dev, NULL, &wrq->u, NULL);
 		break;
 		// All other calls are currently unsupported
 	default:
-- 
2.34.1

