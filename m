Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55A1468C829
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 22:01:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230153AbjBFVBx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 16:01:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230344AbjBFVBs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 16:01:48 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BAE92B2B5
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 13:01:46 -0800 (PST)
Received: from ipservice-092-217-084-033.092.217.pools.vodafone-ip.de ([92.217.84.33] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1pP8cJ-000876-HA; Mon, 06 Feb 2023 22:01:35 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 2/3] staging: r8188eu: make ips_leave static
Date:   Mon,  6 Feb 2023 22:01:23 +0100
Message-Id: <20230206210124.150142-3-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230206210124.150142-1-martin@kaiser.cx>
References: <20230206210124.150142-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ips_leave function is used only in rtw_pwrctrl.c. We can make this
function static.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/core/rtw_pwrctrl.c    | 2 +-
 drivers/staging/r8188eu/include/rtw_pwrctrl.h | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_pwrctrl.c b/drivers/staging/r8188eu/core/rtw_pwrctrl.c
index e70d78357bcb..702a29f96d74 100644
--- a/drivers/staging/r8188eu/core/rtw_pwrctrl.c
+++ b/drivers/staging/r8188eu/core/rtw_pwrctrl.c
@@ -39,7 +39,7 @@ static void ips_enter(struct adapter *padapter)
 	mutex_unlock(&pwrpriv->lock);
 }
 
-int ips_leave(struct adapter *padapter)
+static int ips_leave(struct adapter *padapter)
 {
 	struct pwrctrl_priv *pwrpriv = &padapter->pwrctrlpriv;
 	struct security_priv *psecuritypriv = &padapter->securitypriv;
diff --git a/drivers/staging/r8188eu/include/rtw_pwrctrl.h b/drivers/staging/r8188eu/include/rtw_pwrctrl.h
index 56492ab0f78d..f7aeac262fad 100644
--- a/drivers/staging/r8188eu/include/rtw_pwrctrl.h
+++ b/drivers/staging/r8188eu/include/rtw_pwrctrl.h
@@ -99,7 +99,6 @@ void rtw_set_firmware_ps_mode(struct adapter *adapter, u8 mode);
 void rtw_set_ps_mode(struct adapter *adapter, u8 ps_mode, u8 smart_ps,
 		     u8 bcn_ant_mode);
 void LeaveAllPowerSaveMode(struct adapter *adapter);
-int ips_leave(struct adapter *padapter);
 
 void rtw_ps_processor(struct adapter *padapter);
 
-- 
2.30.2

