Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E942461029C
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 22:22:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236963AbiJ0UWy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 16:22:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236837AbiJ0UWw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 16:22:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21BF68D233;
        Thu, 27 Oct 2022 13:22:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A6A82624E3;
        Thu, 27 Oct 2022 20:22:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 493E0C433D6;
        Thu, 27 Oct 2022 20:22:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666902170;
        bh=qNWH0Mj9EV6KWOBrM1nSFfRrqpnHhdgAOSQGLJl090U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Jbmc01aw+lNn+2ABpVBYXuNzVDgN1iUKu2xNzTA6Pj90FzztZH5IzqDqvXIRCVWFF
         EngleDxEP/eObYt+pbI9MZ5GfOs5fswUEeqEIg61uW3vSPwuCGujh13BHLoeVwJiJ1
         2JAk8bGs3G/t71GClD3FEYpAbAglZyy3RGUIhs7exV73rFmgjmRt2Bl77HNsY9CZJr
         1M9XUris4WodKznX32qnG0oCGjplEhlSsKACRxY0ESkBW/12d/wL8uhMHY81vC5HR1
         DBwsjGG/BLSfVrXiROZTrNDOUITZdNjDCEevEaw7OS/29m5SPWPY5SJh3lCDuq7LEM
         P1QSAk/Ri3Eog==
Date:   Thu, 27 Oct 2022 15:22:46 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH v2 6/6] staging: ks7010: Avoid clashing function prototypes
Message-ID: <34bf3ce1b1ca2da4c5ec8a6e26f31bbb9ca1c4f5.1666894751.git.gustavoars@kernel.org>
References: <cover.1666894751.git.gustavoars@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1666894751.git.gustavoars@kernel.org>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

Link: https://reviews.llvm.org/D134831 [1]
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
Changes in v2:
 - None. This patch is new in the series.

 drivers/staging/ks7010/ks_wlan_net.c | 184 ++++++++++++++-------------
 1 file changed, 94 insertions(+), 90 deletions(-)

diff --git a/drivers/staging/ks7010/ks_wlan_net.c b/drivers/staging/ks7010/ks_wlan_net.c
index 7e8d37c169f0..835fa3637bd8 100644
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

