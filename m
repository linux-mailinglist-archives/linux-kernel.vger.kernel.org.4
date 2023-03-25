Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 168B86C8CB0
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 09:36:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232233AbjCYIgv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Mar 2023 04:36:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232237AbjCYIga (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Mar 2023 04:36:30 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A868B18A84
        for <linux-kernel@vger.kernel.org>; Sat, 25 Mar 2023 01:36:25 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-93075ee221bso14103566b.0
        for <linux-kernel@vger.kernel.org>; Sat, 25 Mar 2023 01:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679733385;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pego/p9EbPQyvAXkY7L5ybuHyA9HZAjsDB9bAcQ4kms=;
        b=aapVrq2/VavaaG/pVw2Cdc5FlASE0YKac34GycF9wfB/uU2GuL2lyUe8sm3fUpY2tH
         1MOnseF8UrPyFaLBUfq13uob6mSvXrvw/hgmk4IkD3ETPvskFZaJZsD3WncmYjFVtaU4
         HFzbviED50eIuTTtFZYyWeW7/M9PrDR15oBomiu0GRNkWtupcLkbxgiHUjaNK3VahVDH
         w/fJypydGVoY3n6ZUubkMZ6zXSQxwppabGgUdPmVwmrdmSgdq5MyzBTNjDRHs3gx9LHp
         cqfiiMqWirzJD1Fnjh7T6dDwt+Pj3GaV9Yag67OysTQ1hI4r4avb7jxMQDAcudbBruAY
         hViw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679733385;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pego/p9EbPQyvAXkY7L5ybuHyA9HZAjsDB9bAcQ4kms=;
        b=3c1ah8qQadttZP5O1QrLo50glk/qkumN0qDbbZTSE+fp28cHCXtLwtVRsT1HKvna1x
         NHOtf/0jusBv3hA1aN4/SU0DPAxvkvwxltC/P9rkijd33wwFrozDxtAYEFK8ojMVojEh
         TFeaxU7DZtDCOtutIjQg+SFEUZpqmrGAvoyj2QwHBySVC6/uF2VnS3p/pU+e/+VM03cX
         KIBrCC9Sae6E5ouxY3bw1aLTiaFR78VRVDu85tkw/gqSKakCBuYelM6KHhW2CWdFuwmW
         B6CuATTeMDf/wApVOSg7dd1V3V3hdsigu/itDParWUFXoBtuIMKZytEYWQAJoQQ0jz+r
         IZuQ==
X-Gm-Message-State: AAQBX9cfDEeRW9fH3WPAXKbTcxJMyQv+wIyPdXT5lQq8lm8cRrIIceUE
        var1scbqhZsmTiGD0N1/2oTaqGhKqTY=
X-Google-Smtp-Source: AKy350aaN3egCdOutVBRtqKYoOpRbKONPxO+0SRpOcMT3o7QNhsygivdwGf9h4ZO1ILBWvXQT3iWew==
X-Received: by 2002:a17:906:748b:b0:8f0:ba09:4abe with SMTP id e11-20020a170906748b00b008f0ba094abemr4117514ejl.2.1679733385189;
        Sat, 25 Mar 2023 01:36:25 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p57935146.dip0.t-ipconnect.de. [87.147.81.70])
        by smtp.gmail.com with ESMTPSA id ot17-20020a170906ccd100b008e51a1fd7bfsm11648296ejb.172.2023.03.25.01.36.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Mar 2023 01:36:24 -0700 (PDT)
Date:   Sat, 25 Mar 2023 09:36:23 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 06/11] staging: rtl8192e: Remove priv->rf_chip in
 _rtl92e_phy_switch_channel_step
Message-ID: <1b9e10de4f539aa24150275c80ec4bbd925c853d.1679732276.git.philipp.g.hortmann@gmail.com>
References: <cover.1679732276.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1679732276.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

priv->rf_chip is initialized to RF_8256 and never changed. Remove
condition in function _rtl92e_phy_switch_channel_step as it is dead code.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 .../staging/rtl8192e/rtl8192e/r8192E_phy.c    | 83 ++++---------------
 1 file changed, 16 insertions(+), 67 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
index b528b8ab4b2b..73e426e052b0 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
@@ -14,24 +14,6 @@
 
 #include "table.h"
 
-static u32 RF_CHANNEL_TABLE_ZEBRA[] = {
-	0,
-	0x085c,
-	0x08dc,
-	0x095c,
-	0x09dc,
-	0x0a5c,
-	0x0adc,
-	0x0b5c,
-	0x0bdc,
-	0x0c5c,
-	0x0cdc,
-	0x0d5c,
-	0x0ddc,
-	0x0e5c,
-	0x0f72,
-};
-
 /*************************Define local function prototype**********************/
 
 static u32 _rtl92e_phy_rf_fw_read(struct net_device *dev,
@@ -608,58 +590,25 @@ static u8 _rtl92e_phy_switch_channel_step(struct net_device *dev, u8 channel,
 						  0, 0, 0);
 
 		RfDependCmdCnt = 0;
-		switch (priv->rf_chip) {
-		case RF_8225:
-			if (!(channel >= 1 && channel <= 14)) {
-				netdev_err(dev,
-					   "Invalid channel requested for 8225: %d\n",
-					   channel);
-				return false;
-			}
-			_rtl92e_phy_set_sw_chnl_cmd_array(dev,
-							  ieee->RfDependCmd,
-							  RfDependCmdCnt++,
-							  MAX_RFDEPENDCMD_CNT,
-							  CmdID_RF_WriteReg,
-							  rZebra1_Channel,
-							  RF_CHANNEL_TABLE_ZEBRA[channel],
-							  10);
-			_rtl92e_phy_set_sw_chnl_cmd_array(dev,
-							  ieee->RfDependCmd,
-							  RfDependCmdCnt++,
-							  MAX_RFDEPENDCMD_CNT,
-							  CmdID_End, 0, 0, 0);
-			break;
-
-		case RF_8256:
-			if (!(channel >= 1 && channel <= 14)) {
-				netdev_err(dev,
-					   "Invalid channel requested for 8256: %d\n",
-					   channel);
-				return false;
-			}
-			_rtl92e_phy_set_sw_chnl_cmd_array(dev,
-							  ieee->RfDependCmd,
-							  RfDependCmdCnt++,
-							  MAX_RFDEPENDCMD_CNT,
-							  CmdID_RF_WriteReg,
-							  rZebra1_Channel,
-							  channel, 10);
-			_rtl92e_phy_set_sw_chnl_cmd_array(dev,
-							  ieee->RfDependCmd,
-							  RfDependCmdCnt++,
-							  MAX_RFDEPENDCMD_CNT,
-							  CmdID_End, 0, 0, 0);
-			break;
-
-		case RF_8258:
-			break;
 
-		default:
-			netdev_warn(dev, "Unknown RF Chip ID\n");
+		if (!(channel >= 1 && channel <= 14)) {
+			netdev_err(dev,
+				   "Invalid channel requested for 8256: %d\n",
+				   channel);
 			return false;
 		}
-
+		_rtl92e_phy_set_sw_chnl_cmd_array(dev,
+						  ieee->RfDependCmd,
+						  RfDependCmdCnt++,
+						  MAX_RFDEPENDCMD_CNT,
+						  CmdID_RF_WriteReg,
+						  rZebra1_Channel,
+						  channel, 10);
+		_rtl92e_phy_set_sw_chnl_cmd_array(dev,
+						  ieee->RfDependCmd,
+						  RfDependCmdCnt++,
+						  MAX_RFDEPENDCMD_CNT,
+						  CmdID_End, 0, 0, 0);
 
 		do {
 			switch (*stage) {
-- 
2.39.2

