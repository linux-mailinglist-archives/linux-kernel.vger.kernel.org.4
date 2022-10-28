Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AF806111AB
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 14:38:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229923AbiJ1Mih (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 08:38:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbiJ1Mie (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 08:38:34 -0400
Received: from msg-4.mailo.com (msg-4.mailo.com [213.182.54.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B26C01D4DCC
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 05:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1666960698; bh=B5OaSZ8HsPRmrMQQFyz9KT8sdbr9Ub7sfHqu4Tovee8=;
        h=X-EA-Auth:Date:From:To:Subject:Message-ID:MIME-Version:
         Content-Type;
        b=Ekxlr7DrdfyemSZ0COtOM0B0w5kwQriCAHGa4y4lvSmfe4CMBWu+DzjOc2Hl7+uLx
         GUoK3UGw7L/9luMrAgX2ObKa0rHloNNIQUS0OpZgc6j1JN2XzpoMHrSqZUt9xDZzOX
         E4ODFRtppCXlPDwyGcimnB9fHbSgiGVvzisG62Xs=
Received: by b-2.in.mailobj.net [192.168.90.12] with ESMTP
        via [213.182.55.206]
        Fri, 28 Oct 2022 14:38:18 +0200 (CEST)
X-EA-Auth: VkRt+j6nGRWQq6EtMOp8yVWLs+3ZU5k2Lm4NBQLPnnZrKfXl+WSKVQSq7rMV6nqg+He7Dm8gvOBToPU9ngJiMtCWFCKBgdLm
Date:   Fri, 28 Oct 2022 18:08:13 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     outreachy@lists.linux.dev,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: wlan-ng: Use flexible-array for one / zero-length
 arrays
Message-ID: <Y1vNNSSWK1EkcohT@ubunlion>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Flexible-array member should be used instead of one or zero member to
meet the need for having a dynamically sized trailing elements in a
structure. Refer to links [1] and [2] for detailed guidance on this
suggestion.

[1] https://en.wikipedia.org/wiki/Flexible_array_member
[2] https://www.kernel.org/doc/html/v5.16/process/deprecated.html#zero-length-and-one-element-arrays

Issue identified using coccicheck.

Signed-off-by: Deepak R Varma <drv@mailo.com>
---
 drivers/staging/wlan-ng/p80211mgmt.h  | 8 ++++----
 drivers/staging/wlan-ng/p80211types.h | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/wlan-ng/p80211mgmt.h b/drivers/staging/wlan-ng/p80211mgmt.h
index 1ef30d3f3159..d6fe52de2c8f 100644
--- a/drivers/staging/wlan-ng/p80211mgmt.h
+++ b/drivers/staging/wlan-ng/p80211mgmt.h
@@ -229,14 +229,14 @@ struct wlan_ie {
 struct wlan_ie_ssid {
 	u8 eid;
 	u8 len;
-	u8 ssid[1];		/* may be zero, ptrs may overlap */
+	u8 ssid[];		/* may be zero, ptrs may overlap */
 } __packed;

 /*-- Supported Rates  -----------------------------*/
 struct wlan_ie_supp_rates {
 	u8 eid;
 	u8 len;
-	u8 rates[1];		/* had better be at LEAST one! */
+	u8 rates[];		/* had better be at LEAST one! */
 } __packed;

 /*-- FH Parameter Set  ----------------------------*/
@@ -274,7 +274,7 @@ struct wlan_ie_tim {
 	u8 dtim_cnt;
 	u8 dtim_period;
 	u8 bitmap_ctl;
-	u8 virt_bm[1];
+	u8 virt_bm[];
 } __packed;

 /*-- IBSS Parameter Set ---------------------------*/
@@ -288,7 +288,7 @@ struct wlan_ie_ibss_parms {
 struct wlan_ie_challenge {
 	u8 eid;
 	u8 len;
-	u8 challenge[1];
+	u8 challenge[];
 } __packed;

 /*-------------------------------------------------*/
diff --git a/drivers/staging/wlan-ng/p80211types.h b/drivers/staging/wlan-ng/p80211types.h
index 6486612a8f31..b2ffd09881b0 100644
--- a/drivers/staging/wlan-ng/p80211types.h
+++ b/drivers/staging/wlan-ng/p80211types.h
@@ -234,7 +234,7 @@ struct p80211pstr32 {
 /* MAC address array */
 struct p80211macarray {
 	u32 cnt;
-	u8 data[1][MAXLEN_PSTR6];
+	u8 data[][MAXLEN_PSTR6];
 } __packed;

 /* prototype template */
--
2.34.1



