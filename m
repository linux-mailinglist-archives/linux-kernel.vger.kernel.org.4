Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82DDA61E22E
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Nov 2022 13:49:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbiKFMt3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 07:49:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229967AbiKFMtR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 07:49:17 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9E0464E0
        for <linux-kernel@vger.kernel.org>; Sun,  6 Nov 2022 04:49:16 -0800 (PST)
Received: from ipservice-092-217-068-220.092.217.pools.vodafone-ip.de ([92.217.68.220] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1orf5M-0008Dj-PQ; Sun, 06 Nov 2022 13:49:12 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 6/9] staging: r8188eu: clean up rtw_hal_init
Date:   Sun,  6 Nov 2022 13:48:58 +0100
Message-Id: <20221106124901.720785-7-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221106124901.720785-1-martin@kaiser.cx>
References: <20221106124901.720785-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clean up the rtw_hal_init function.

Remove the status variable. Exit immediately for errors.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/hal/hal_intf.c | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/hal_intf.c b/drivers/staging/r8188eu/hal/hal_intf.c
index 37935aef71ea..13790e32f11c 100644
--- a/drivers/staging/r8188eu/hal/hal_intf.c
+++ b/drivers/staging/r8188eu/hal/hal_intf.c
@@ -6,24 +6,19 @@
 #include "../include/drv_types.h"
 #include "../include/hal_intf.h"
 
-uint	 rtw_hal_init(struct adapter *adapt)
+uint rtw_hal_init(struct adapter *adapt)
 {
-	uint	status = _SUCCESS;
-
 	adapt->hw_init_completed = false;
 
-	status = rtl8188eu_hal_init(adapt);
+	if (rtl8188eu_hal_init(adapt) != _SUCCESS)
+		return _FAIL;
 
-	if (status == _SUCCESS) {
-		adapt->hw_init_completed = true;
+	adapt->hw_init_completed = true;
 
-		if (adapt->registrypriv.notch_filter == 1)
-			hal_notch_filter_8188e(adapt, 1);
-	} else {
-		adapt->hw_init_completed = false;
-	}
+	if (adapt->registrypriv.notch_filter == 1)
+		hal_notch_filter_8188e(adapt, 1);
 
-	return status;
+	return _SUCCESS;
 }
 
 uint rtw_hal_deinit(struct adapter *adapt)
-- 
2.30.2

