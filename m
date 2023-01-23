Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03FC86788C3
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 21:54:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232318AbjAWUyd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 15:54:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232029AbjAWUyO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 15:54:14 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA8DE36085
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 12:54:11 -0800 (PST)
Received: from ipservice-092-217-089-134.092.217.pools.vodafone-ip.de ([92.217.89.134] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1pK3pN-0000Lk-GG; Mon, 23 Jan 2023 21:54:05 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 13/23] staging: r8188eu: make rtw_chk_hi_queue_cmd a void function
Date:   Mon, 23 Jan 2023 21:53:32 +0100
Message-Id: <20230123205342.229589-14-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230123205342.229589-1-martin@kaiser.cx>
References: <20230123205342.229589-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both callers of rtw_chk_hi_queue_cmd do not check the return value.
Convert rtw_chk_hi_queue_cmd to a void function.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/core/rtw_cmd.c    | 16 +++++-----------
 drivers/staging/r8188eu/include/rtw_cmd.h |  2 +-
 2 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_cmd.c b/drivers/staging/r8188eu/core/rtw_cmd.c
index eb79435da355..d57360a68fb3 100644
--- a/drivers/staging/r8188eu/core/rtw_cmd.c
+++ b/drivers/staging/r8188eu/core/rtw_cmd.c
@@ -1197,24 +1197,20 @@ static void rtw_chk_hi_queue_hdl(struct adapter *padapter)
 	}
 }
 
-u8 rtw_chk_hi_queue_cmd(struct adapter *padapter)
+void rtw_chk_hi_queue_cmd(struct adapter *padapter)
 {
 	struct cmd_obj	*ph2c;
 	struct drvextra_cmd_parm	*pdrvextra_cmd_parm;
 	struct cmd_priv	*pcmdpriv = &padapter->cmdpriv;
-	u8	res = _SUCCESS;
 
 	ph2c = kzalloc(sizeof(*ph2c), GFP_ATOMIC);
-	if (!ph2c) {
-		res = _FAIL;
-		goto exit;
-	}
+	if (!ph2c)
+		return;
 
 	pdrvextra_cmd_parm = kzalloc(sizeof(*pdrvextra_cmd_parm), GFP_ATOMIC);
 	if (!pdrvextra_cmd_parm) {
 		kfree(ph2c);
-		res = _FAIL;
-		goto exit;
+		return;
 	}
 
 	pdrvextra_cmd_parm->ec_id = CHECK_HIQ_WK_CID;
@@ -1223,9 +1219,7 @@ u8 rtw_chk_hi_queue_cmd(struct adapter *padapter)
 
 	init_h2fwcmd_w_parm_no_rsp(ph2c, pdrvextra_cmd_parm, GEN_CMD_CODE(_Set_Drv_Extra));
 
-	res = rtw_enqueue_cmd(pcmdpriv, ph2c);
-exit:
-	return res;
+	rtw_enqueue_cmd(pcmdpriv, ph2c);
 }
 
 u8 rtw_c2h_wk_cmd(struct adapter *padapter, u8 *c2h_evt)
diff --git a/drivers/staging/r8188eu/include/rtw_cmd.h b/drivers/staging/r8188eu/include/rtw_cmd.h
index 9df7d4bf441d..e8eecd52d1d8 100644
--- a/drivers/staging/r8188eu/include/rtw_cmd.h
+++ b/drivers/staging/r8188eu/include/rtw_cmd.h
@@ -743,7 +743,7 @@ u8 rtw_rpt_timer_cfg_cmd(struct adapter *padapter, u16 minRptTime);
 u8 rtw_antenna_select_cmd(struct adapter *padapter, u8 antenna, u8 enqueue);
 u8 rtw_ps_cmd(struct adapter *padapter);
 
-u8 rtw_chk_hi_queue_cmd(struct adapter *padapter);
+void rtw_chk_hi_queue_cmd(struct adapter *padapter);
 
 u8 rtw_set_chplan_cmd(struct adapter *padapter, u8 chplan);
 
-- 
2.30.2

