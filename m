Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 231AB68C828
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 22:01:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230433AbjBFVBv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 16:01:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230235AbjBFVBn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 16:01:43 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD05629162
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 13:01:42 -0800 (PST)
Received: from ipservice-092-217-084-033.092.217.pools.vodafone-ip.de ([92.217.84.33] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1pP8cK-000876-Rq; Mon, 06 Feb 2023 22:01:36 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 3/3] staging: r8188eu: remove change_rfpwrstate
Date:   Mon,  6 Feb 2023 22:01:24 +0100
Message-Id: <20230206210124.150142-4-martin@kaiser.cx>
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

Remove the change_rfpwrstate component in struct pwrctrl_priv.

change_rfpwrstate is set to rf_off directly before each ips_enter call and
then checked in ips_enter. This makes no sense.

change_rfpwrstate might have been used to avoid conflicts between
suspend and resume operations. If a driver has to do this at all,
pwrpriv->ps_processing will do this job.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/core/rtw_pwrctrl.c    | 19 ++++++++-----------
 drivers/staging/r8188eu/include/rtw_pwrctrl.h |  1 -
 2 files changed, 8 insertions(+), 12 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_pwrctrl.c b/drivers/staging/r8188eu/core/rtw_pwrctrl.c
index 702a29f96d74..051cdcb11ff5 100644
--- a/drivers/staging/r8188eu/core/rtw_pwrctrl.c
+++ b/drivers/staging/r8188eu/core/rtw_pwrctrl.c
@@ -25,15 +25,14 @@ static void ips_enter(struct adapter *padapter)
 	pwrpriv->ips_mode = pwrpriv->ips_mode_req;
 
 	pwrpriv->ips_enter_cnts++;
-	if (rf_off == pwrpriv->change_rfpwrstate) {
-		pwrpriv->bpower_saving = true;
+	pwrpriv->bpower_saving = true;
 
-		if (pwrpriv->ips_mode == IPS_LEVEL_2)
-			pwrpriv->bkeepfwalive = true;
+	if (pwrpriv->ips_mode == IPS_LEVEL_2)
+		pwrpriv->bkeepfwalive = true;
+
+	rtw_ips_pwr_down(padapter);
+	pwrpriv->rf_pwrstate = rf_off;
 
-		rtw_ips_pwr_down(padapter);
-		pwrpriv->rf_pwrstate = rf_off;
-	}
 	pwrpriv->bips_processing = false;
 
 	mutex_unlock(&pwrpriv->lock);
@@ -51,7 +50,6 @@ static int ips_leave(struct adapter *padapter)
 
 	if ((pwrpriv->rf_pwrstate == rf_off) && (!pwrpriv->bips_processing)) {
 		pwrpriv->bips_processing = true;
-		pwrpriv->change_rfpwrstate = rf_on;
 		pwrpriv->ips_leave_cnts++;
 
 		result = rtw_ips_pwr_up(padapter);
@@ -133,10 +131,9 @@ void rtw_ps_processor(struct adapter *padapter)
 	if (!rtw_pwr_unassociated_idle(padapter))
 		goto exit;
 
-	if (pwrpriv->rf_pwrstate == rf_on) {
-		pwrpriv->change_rfpwrstate = rf_off;
+	if (pwrpriv->rf_pwrstate == rf_on)
 		ips_enter(padapter);
-	}
+
 exit:
 	rtw_set_pwr_state_check_timer(&padapter->pwrctrlpriv);
 	pwrpriv->ps_processing = false;
diff --git a/drivers/staging/r8188eu/include/rtw_pwrctrl.h b/drivers/staging/r8188eu/include/rtw_pwrctrl.h
index f7aeac262fad..9f5cffd8bfb1 100644
--- a/drivers/staging/r8188eu/include/rtw_pwrctrl.h
+++ b/drivers/staging/r8188eu/include/rtw_pwrctrl.h
@@ -71,7 +71,6 @@ struct pwrctrl_priv {
 	int		pwr_state_check_interval;
 
 	enum rt_rf_power_state	rf_pwrstate;/* cur power state */
-	enum rt_rf_power_state	change_rfpwrstate;
 
 	u8		bkeepfwalive;
 };
-- 
2.30.2

