Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 216376994B1
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 13:46:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230369AbjBPMqY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 07:46:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230169AbjBPMqM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 07:46:12 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80F3359C2
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 04:46:06 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 242291EC0939;
        Thu, 16 Feb 2023 13:46:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1676551565;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IYyR0+BccWAZu5naODrqJjalGeVpYFKs8LsqRBbFls0=;
        b=c6yj2Mo7eACRrEU430w1WrLOK3ntY1zESGOlbSkytO76Dk9elQjGbbC7fxGWAcvcRvI7du
        9EZktuhoKJrxsfzEp/lyJmBcM5h+en5shQHXeDfqC07ohyUSE0elnyyUfygZP3Hm4Sgt+Y
        l3MSRt4GtN5B1l7YTBcAsVKJ6QV4XHM=
From:   Borislav Petkov <bp@alien8.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Dionna Glaze <dionnaglaze@google.com>,
        Joerg Roedel <jroedel@suse.de>,
        Michael Roth <michael.roth@amd.com>,
        Nikunj A Dadhania <nikunj@amd.com>,
        Peter Gonda <pgonda@google.com>,
        Tom Lendacky <Thomas.Lendacky@amd.com>,
        linux-coco@lists.linux.dev, x86@kernel.org
Subject: [PATCH 10/11] crypto: ccp: Get rid of __sev_platform_init_locked()'s local function pointer
Date:   Thu, 16 Feb 2023 13:46:01 +0100
Message-Id: <20230216124602.26849-5-bp@alien8.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230216124602.26849-1-bp@alien8.de>
References: <20230216124120.26578-1-bp@alien8.de>
 <20230216124602.26849-1-bp@alien8.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Borislav Petkov (AMD)" <bp@alien8.de>

Add a wrapper instead.

No functional changes.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
---
 drivers/crypto/ccp/sev-dev.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/crypto/ccp/sev-dev.c b/drivers/crypto/ccp/sev-dev.c
index f60bb73edfda..c54cc8f9a284 100644
--- a/drivers/crypto/ccp/sev-dev.c
+++ b/drivers/crypto/ccp/sev-dev.c
@@ -440,11 +440,18 @@ static int __sev_init_ex_locked(int *error)
 	return __sev_do_cmd_locked(SEV_CMD_INIT_EX, &data, error);
 }
 
+static inline int __sev_do_init_locked(int *psp_ret)
+{
+	if (sev_init_ex_buffer)
+		return __sev_init_ex_locked(psp_ret);
+	else
+		return __sev_init_locked(psp_ret);
+}
+
 static int __sev_platform_init_locked(int *error)
 {
 	int rc = 0, psp_ret = SEV_RET_NO_FW_CALL;
 	struct psp_device *psp = psp_master;
-	int (*init_function)(int *error);
 	struct sev_device *sev;
 
 	if (!psp || !psp->sev_data)
@@ -456,15 +463,12 @@ static int __sev_platform_init_locked(int *error)
 		return 0;
 
 	if (sev_init_ex_buffer) {
-		init_function = __sev_init_ex_locked;
 		rc = sev_read_init_ex_file();
 		if (rc)
 			return rc;
-	} else {
-		init_function = __sev_init_locked;
 	}
 
-	rc = init_function(&psp_ret);
+	rc = __sev_do_init_locked(&psp_ret);
 	if (rc && psp_ret == SEV_RET_SECURE_DATA_INVALID) {
 		/*
 		 * Initialization command returned an integrity check failure
@@ -475,7 +479,7 @@ static int __sev_platform_init_locked(int *error)
 		 */
 		dev_err(sev->dev,
 "SEV: retrying INIT command because of SECURE_DATA_INVALID error. Retrying once to reset PSP SEV state.");
-		rc = init_function(&psp_ret);
+		rc = __sev_do_init_locked(&psp_ret);
 	}
 
 	if (error)
-- 
2.35.1

