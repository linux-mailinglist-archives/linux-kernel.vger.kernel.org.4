Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5660E614C02
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 14:48:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbiKANsY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 09:48:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbiKANsV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 09:48:21 -0400
Received: from msg-4.mailo.com (msg-4.mailo.com [213.182.54.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29107A7
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 06:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1667310493; bh=FNdZHPIXSMqReTu7V7OLhEbcfqLKVeX8EB+0vnG4PBo=;
        h=X-EA-Auth:Date:From:To:Subject:Message-ID:References:MIME-Version:
         Content-Type:In-Reply-To;
        b=h0ytcWHLTY4pkEjjk22m33rTbMiwNeT/jOaOedq7rv0tk7di1ZMX9TjE2sfoO1aMw
         5AE1DenTbi+E8LDHHMvaXR5qyTGXOKJ8HLGNUpIXK5rWDRuB+WwInyNdjWpf0bSLyU
         /8pP+mY+4p08j08SMNi5COMGMDrhLsBZ2xA1P5o4=
Received: by b-3.in.mailobj.net [192.168.90.13] with ESMTP
        via [213.182.55.206]
        Tue,  1 Nov 2022 14:48:13 +0100 (CET)
X-EA-Auth: PONAtjAXCOVWqqpb0fs+8wLWjA/64MWw6vvfq5B0q/Z5Rz/CGiHLJLNDNxnbOIx3Zx1nilKCZZAeewY7zlSTvcQIWt5TMSEA
Date:   Tue, 1 Nov 2022 19:18:10 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     outreachy@lists.linux.dev,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/7] staging: wlan-ng: Remove unused struct wlan_ie_ssid
 references
Message-ID: <6e39ef59d01d65a1e179f6aecfbb0d68b81fa257.1667308828.git.drv@mailo.com>
References: <cover.1667308828.git.drv@mailo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1667308828.git.drv@mailo.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pointer reference to struct wlan_ie_ssid is added as a member variable
to 5 different structures. However, these references are never used.
Remove such unused struct references. The cleanup also renders the
struct useless; so remove it as well.
Issue identified as part of coccicheck based code analysis.

Suggested-by: Dan Carpenter <dan.carpenter@oracle.com>
Suggested-by: Pavel Skripkin <paskripkin@gmail.com>
Signed-off-by: Deepak R Varma <drv@mailo.com>
---

Changes in v2:
   1. Include additional code clean-up opportunities and combine changes in a
      patch set based on impact areas.
   2. The patch changes are compile tested only on X86 arch.


 drivers/staging/wlan-ng/p80211mgmt.h | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/drivers/staging/wlan-ng/p80211mgmt.h b/drivers/staging/wlan-ng/p80211mgmt.h
index 1ef30d3f3159..dcff56d18498 100644
--- a/drivers/staging/wlan-ng/p80211mgmt.h
+++ b/drivers/staging/wlan-ng/p80211mgmt.h
@@ -225,13 +225,6 @@ struct wlan_ie {
 	u8 len;
 } __packed;

-/*-- Service Set Identity (SSID)  -----------------*/
-struct wlan_ie_ssid {
-	u8 eid;
-	u8 len;
-	u8 ssid[1];		/* may be zero, ptrs may overlap */
-} __packed;
-
 /*-- Supported Rates  -----------------------------*/
 struct wlan_ie_supp_rates {
 	u8 eid;
@@ -319,7 +312,6 @@ struct wlan_fr_beacon {
 	u16 *bcn_int;
 	u16 *cap_info;
 	/*-- info elements ----------*/
-	struct wlan_ie_ssid *ssid;
 	struct wlan_ie_supp_rates *supp_rates;
 	struct wlan_ie_fh_parms *fh_parms;
 	struct wlan_ie_ds_parms *ds_parms;
@@ -372,7 +364,6 @@ struct wlan_fr_assocreq {
 	u16 *cap_info;
 	u16 *listen_int;
 	/*-- info elements ----------*/
-	struct wlan_ie_ssid *ssid;
 	struct wlan_ie_supp_rates *supp_rates;

 };
@@ -407,7 +398,6 @@ struct wlan_fr_reassocreq {
 	u16 *listen_int;
 	u8 *curr_ap;
 	/*-- info elements ----------*/
-	struct wlan_ie_ssid *ssid;
 	struct wlan_ie_supp_rates *supp_rates;

 };
@@ -439,7 +429,6 @@ struct wlan_fr_probereq {
 	void *priv;
 	/*-- fixed fields -----------*/
 	/*-- info elements ----------*/
-	struct wlan_ie_ssid *ssid;
 	struct wlan_ie_supp_rates *supp_rates;

 };
@@ -457,7 +446,6 @@ struct wlan_fr_proberesp {
 	u16 *bcn_int;
 	u16 *cap_info;
 	/*-- info elements ----------*/
-	struct wlan_ie_ssid *ssid;
 	struct wlan_ie_supp_rates *supp_rates;
 	struct wlan_ie_fh_parms *fh_parms;
 	struct wlan_ie_ds_parms *ds_parms;
--
2.34.1



