Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1967664DC2
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 21:57:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231682AbjAJU5B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 15:57:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233891AbjAJU4r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 15:56:47 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A51CB12A94
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 12:56:44 -0800 (PST)
Received: from dslb-178-004-206-224.178.004.pools.vodafone-ip.de ([178.4.206.224] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1pFLfi-0001pw-NV; Tue, 10 Jan 2023 21:56:38 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 1/4] staging: r8188eu: refactor status handling in usb_write_port_complete
Date:   Tue, 10 Jan 2023 21:56:23 +0100
Message-Id: <20230110205626.183516-2-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230110205626.183516-1-martin@kaiser.cx>
References: <20230110205626.183516-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Refactor the satus handling in usb_write_port_complete. Make it clearer
what happens for each status and avoid all the goto statements.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 .../staging/r8188eu/os_dep/usb_ops_linux.c    | 29 +++++++++----------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/drivers/staging/r8188eu/os_dep/usb_ops_linux.c b/drivers/staging/r8188eu/os_dep/usb_ops_linux.c
index 257bcf496012..8494b80a08e5 100644
--- a/drivers/staging/r8188eu/os_dep/usb_ops_linux.c
+++ b/drivers/staging/r8188eu/os_dep/usb_ops_linux.c
@@ -48,21 +48,20 @@ static void usb_write_port_complete(struct urb *purb, struct pt_regs *regs)
 	    padapter->bWritePortCancel)
 		goto check_completion;
 
-	if (purb->status) {
-		if (purb->status == -EINPROGRESS) {
-			goto check_completion;
-		} else if (purb->status == -ENOENT) {
-			goto check_completion;
-		} else if (purb->status == -ECONNRESET) {
-			goto check_completion;
-		} else if (purb->status == -ESHUTDOWN) {
-			padapter->bDriverStopped = true;
-			goto check_completion;
-		} else if ((purb->status != -EPIPE) && (purb->status != -EPROTO)) {
-			padapter->bSurpriseRemoved = true;
-
-			goto check_completion;
-		}
+	switch (purb->status) {
+	case 0:
+	case -EINPROGRESS:
+	case -ENOENT:
+	case -ECONNRESET:
+	case -EPIPE:
+	case -EPROTO:
+		break;
+	case -ESHUTDOWN:
+		padapter->bDriverStopped = true;
+		break;
+	default:
+		padapter->bSurpriseRemoved = true;
+		break;
 	}
 
 check_completion:
-- 
2.30.2

