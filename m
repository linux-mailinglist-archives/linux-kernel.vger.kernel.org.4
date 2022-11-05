Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6D3661D92A
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Nov 2022 10:39:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbiKEJji (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Nov 2022 05:39:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbiKEJjf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Nov 2022 05:39:35 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54C541019
        for <linux-kernel@vger.kernel.org>; Sat,  5 Nov 2022 02:39:33 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id 13so18927706ejn.3
        for <linux-kernel@vger.kernel.org>; Sat, 05 Nov 2022 02:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UxXjh/HXZsln6nQHph//YT1hNRabli6WZS407CAMang=;
        b=f4IyhMYOp03CFxrRgNeKLddDWgkauptTZj7+gxlIkLrb9whUDtzfgfIpy6ONi/MiqS
         tSLL/T3aazcnY69xJ943JhUSfAu7lLzTpFI0i5CqB5EkzAlz1+3WeQHxi79ohmXLs00X
         eSqMGfp2Xjxkrw3p2wvUlmy0XwDYaqaTbnXLXcLuT3+DrjZ6ePaYuykFs/Y7AJ5kcYd3
         u1b2F50Q53it1RkhDz+eD89oyIxrg+N4vMyJq3x/ppSoOpqbpBosEpC12MAjSXy1Wh/p
         +xWU66UJrWo7XPjQh+JtvSAxYlpSNybXeYlCkSmbvmj6v+EDgqc95aW/+PnIeXo55EaE
         wv2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UxXjh/HXZsln6nQHph//YT1hNRabli6WZS407CAMang=;
        b=LLswxjdzPWIEe7v1adgjIOW3JhTjDOccCRSUt+n56z3ZPLFfw6OjrpZ+rp7T8wnnob
         vf2J6n3uFxR1XY5/HUyn6+K+mJx5Xd22OCYCFSzIjF2EZt3MQSaaeLyffBelEqHCp1y7
         pYfu5Mdrr0LUVH5lv4kYM93jMDl7TlzC9tGegVOEly+IBfvSrN7cgH05H+qftyv/lEr5
         LtVAY9/oxnW78kagsbcq3NX6s5np5OpBRE5PBe/Iv+MA6Yc71PT1yxc5a/d/tSdMa4w6
         EaqWJRCWVslkXPkGc8+T3c3xxFBiahfPstMO1yCSYkHvDptW4l+9IcqUQY9Y50s+saxT
         x8pQ==
X-Gm-Message-State: ACrzQf2J9S5EcNo2gMctKt2f68K7svggiXZ8ebtHVjoxwyPjj7Qh+4Yi
        8DVHC7mxo48/GELh5IPWlLI=
X-Google-Smtp-Source: AMsMyM5bA1LSd/16G4FnFVoCoTM6RZnj54TViEhaWb7U2tF8IRKd6e3O1yHLR66KgiVEnAIzLrzFkA==
X-Received: by 2002:a17:907:a40f:b0:7ad:b9b7:582c with SMTP id sg15-20020a170907a40f00b007adb9b7582cmr36685920ejc.347.1667641171813;
        Sat, 05 Nov 2022 02:39:31 -0700 (PDT)
Received: from localhost.localdomain (ip5f5abba7.dynamic.kabel-deutschland.de. [95.90.187.167])
        by smtp.gmail.com with ESMTPSA id lj18-20020a170906f9d200b007adade0e9easm677549ejb.85.2022.11.05.02.39.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Nov 2022 02:39:31 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH] staging: r8188eu: convert three functions to bool
Date:   Sat,  5 Nov 2022 10:39:16 +0100
Message-Id: <20221105093916.8255-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.38.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The functions

is_client_associated_to_ap()
is_client_associated_to_ibss()
is_IBSS_empty()

return boolean values. Convert their return type to bool and replace
_FAIL, which is defined as 0, with false. Another step to get rid of
_SUCCESS / _FAIL.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_wlan_util.c   | 18 +++++++++---------
 drivers/staging/r8188eu/include/rtw_mlme_ext.h |  6 +++---
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_wlan_util.c b/drivers/staging/r8188eu/core/rtw_wlan_util.c
index e50631848cab..c95438a12b59 100644
--- a/drivers/staging/r8188eu/core/rtw_wlan_util.c
+++ b/drivers/staging/r8188eu/core/rtw_wlan_util.c
@@ -331,35 +331,35 @@ u16 get_beacon_interval(struct wlan_bssid_ex *bss)
 	return le16_to_cpu(val);
 }
 
-int is_client_associated_to_ap(struct adapter *padapter)
+bool is_client_associated_to_ap(struct adapter *padapter)
 {
 	struct mlme_ext_priv	*pmlmeext;
 	struct mlme_ext_info	*pmlmeinfo;
 
 	if (!padapter)
-		return _FAIL;
+		return false;
 
 	pmlmeext = &padapter->mlmeextpriv;
 	pmlmeinfo = &pmlmeext->mlmext_info;
 
 	if ((pmlmeinfo->state & WIFI_FW_ASSOC_SUCCESS) && ((pmlmeinfo->state & 0x03) == WIFI_FW_STATION_STATE))
 		return true;
-	else
-		return _FAIL;
+
+	return false;
 }
 
-int is_client_associated_to_ibss(struct adapter *padapter)
+bool is_client_associated_to_ibss(struct adapter *padapter)
 {
 	struct mlme_ext_priv	*pmlmeext = &padapter->mlmeextpriv;
 	struct mlme_ext_info	*pmlmeinfo = &pmlmeext->mlmext_info;
 
 	if ((pmlmeinfo->state & WIFI_FW_ASSOC_SUCCESS) && ((pmlmeinfo->state & 0x03) == WIFI_FW_ADHOC_STATE))
 		return true;
-	else
-		return _FAIL;
+
+	return false;
 }
 
-int is_IBSS_empty(struct adapter *padapter)
+bool is_IBSS_empty(struct adapter *padapter)
 {
 	unsigned int i;
 	struct mlme_ext_priv	*pmlmeext = &padapter->mlmeextpriv;
@@ -367,7 +367,7 @@ int is_IBSS_empty(struct adapter *padapter)
 
 	for (i = IBSS_START_MAC_ID; i < NUM_STA; i++) {
 		if (pmlmeinfo->FW_sta_info[i].status == 1)
-			return _FAIL;
+			return false;
 	}
 	return true;
 }
diff --git a/drivers/staging/r8188eu/include/rtw_mlme_ext.h b/drivers/staging/r8188eu/include/rtw_mlme_ext.h
index e234a3b9af6f..7652e72a03f4 100644
--- a/drivers/staging/r8188eu/include/rtw_mlme_ext.h
+++ b/drivers/staging/r8188eu/include/rtw_mlme_ext.h
@@ -432,9 +432,9 @@ void update_network(struct wlan_bssid_ex *dst, struct wlan_bssid_ex *src,
 u8 *get_my_bssid(struct wlan_bssid_ex *pnetwork);
 u16 get_beacon_interval(struct wlan_bssid_ex *bss);
 
-int is_client_associated_to_ap(struct adapter *padapter);
-int is_client_associated_to_ibss(struct adapter *padapter);
-int is_IBSS_empty(struct adapter *padapter);
+bool is_client_associated_to_ap(struct adapter *padapter);
+bool is_client_associated_to_ibss(struct adapter *padapter);
+bool is_IBSS_empty(struct adapter *padapter);
 
 unsigned char check_assoc_AP(u8 *pframe, uint len);
 
-- 
2.38.0

