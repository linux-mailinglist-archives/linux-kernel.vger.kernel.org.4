Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3C95609C38
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 10:15:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230259AbiJXIPV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 04:15:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229937AbiJXIOu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 04:14:50 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE25517A9E
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 01:14:46 -0700 (PDT)
Received: from ipservice-092-217-079-032.092.217.pools.vodafone-ip.de ([92.217.79.32] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1omsbZ-0000nk-1l; Mon, 24 Oct 2022 10:14:41 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 13/17] staging: r8188eu: remove unnecessary label
Date:   Mon, 24 Oct 2022 10:14:13 +0200
Message-Id: <20221024081417.66441-14-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221024081417.66441-1-martin@kaiser.cx>
References: <20221024081417.66441-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove a label on OnAuthClient that just calls return. We can return
directly instead of jumping to this label.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/core/rtw_mlme_ext.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_mlme_ext.c b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
index 074c95f76e27..01fe5019b333 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme_ext.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
@@ -823,7 +823,7 @@ static void OnAuthClient(struct adapter *padapter, struct recv_frame *precv_fram
 		}
 
 		set_link_timer(pmlmeext, 1);
-		goto authclnt_fail;
+		return;
 	}
 
 	if (seq == 2) {
@@ -833,7 +833,7 @@ static void OnAuthClient(struct adapter *padapter, struct recv_frame *precv_fram
 				pkt_len - WLAN_HDR_A3_LEN - _AUTH_IE_OFFSET_);
 
 			if (!p)
-				goto authclnt_fail;
+				return;
 
 			memcpy((void *)(pmlmeinfo->chg_txt), (void *)(p + 2), len);
 			pmlmeinfo->auth_seq = 3;
@@ -849,18 +849,16 @@ static void OnAuthClient(struct adapter *padapter, struct recv_frame *precv_fram
 		if (pmlmeinfo->auth_algo == dot11AuthAlgrthm_Shared)
 			go2asoc = 1;
 		else
-			goto authclnt_fail;
+			return;
 	} else {
 		/*  this is also illegal */
-		goto authclnt_fail;
+		return;
 	}
 
 	if (go2asoc) {
 		start_clnt_assoc(padapter);
 		return;
 	}
-authclnt_fail:
-	return;
 }
 
 static void UpdateBrateTbl(u8 *mbrate)
-- 
2.30.2

