Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB1D55FFAFB
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Oct 2022 17:25:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229745AbiJOPZ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Oct 2022 11:25:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbiJOPZN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Oct 2022 11:25:13 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 574E5175B8
        for <linux-kernel@vger.kernel.org>; Sat, 15 Oct 2022 08:25:00 -0700 (PDT)
Received: from ipservice-092-217-066-135.092.217.pools.vodafone-ip.de ([92.217.66.135] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1ojj1z-000722-Cb; Sat, 15 Oct 2022 17:24:55 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 8/9] staging: r8188eu: summarize two flags checks
Date:   Sat, 15 Oct 2022 17:24:39 +0200
Message-Id: <20221015152440.232281-9-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221015152440.232281-1-martin@kaiser.cx>
References: <20221015152440.232281-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Summarize the two statements to check if either WIFI_FW_AUTH_STATE or
WIFI_FW_ASSOC_STATE is set.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/core/rtw_mlme_ext.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_mlme_ext.c b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
index 465f51bce0e3..09ffecc5b2b3 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme_ext.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
@@ -1500,8 +1500,7 @@ unsigned int OnDeAuth(struct adapter *padapter, struct recv_frame *precv_frame)
 		 *	However, the Win8.1 with BRCM Wi-Fi will send the deauth with reason code 6 to us after receieving our deauth.
 		 *	Added the following code to avoid this case.
 		 */
-		if ((pmlmeinfo->state & WIFI_FW_AUTH_STATE) ||
-		    (pmlmeinfo->state & WIFI_FW_ASSOC_STATE)) {
+		if (pmlmeinfo->state & (WIFI_FW_AUTH_STATE | WIFI_FW_ASSOC_STATE)) {
 			if (reason == WLAN_REASON_CLASS2_FRAME_FROM_NONAUTH_STA) {
 				ignore_received_deauth = 1;
 			} else if (reason == WLAN_REASON_PREV_AUTH_NOT_VALID) {
-- 
2.30.2

