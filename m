Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B78E969DEE9
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 12:35:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234265AbjBULfE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 06:35:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233794AbjBULem (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 06:34:42 -0500
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3781925B93
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 03:34:41 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D64C31EC067E;
        Tue, 21 Feb 2023 12:34:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1676979279;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IYyR0+BccWAZu5naODrqJjalGeVpYFKs8LsqRBbFls0=;
        b=V/S64JpQrPEnqV250KVXVQRNMRPqMIqPonbf6qQxcaH8JO7DLiKIsClOy29TDN/QmOOIox
        dA5CXj+2i+Q0g6if//P0LcCDz/y2m//YkAP2uGlgN+Kyk+FSgtHWjuib8dSB7QRuTqiPYU
        oyRua31voVHEt79/UQyFo1pyY4gVakE=
From:   Borislav Petkov <bp@alien8.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Dionna Glaze <dionnaglaze@google.com>,
        Joerg Roedel <jroedel@suse.de>,
        Michael Roth <michael.roth@amd.com>,
        Nikunj A Dadhania <nikunj@amd.com>,
        Peter Gonda <pgonda@google.com>,
        Tom Lendacky <Thomas.Lendacky@amd.com>,
        linux-coco@lists.linux.dev, x86@kernel.org
Subject: [PATCH -v2 08/11] crypto: ccp: Get rid of __sev_platform_init_locked()'s local function pointer
Date:   Tue, 21 Feb 2023 12:34:25 +0100
Message-Id: <20230221113428.19324-9-bp@alien8.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230221113428.19324-1-bp@alien8.de>
References: <20230221113428.19324-1-bp@alien8.de>
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

