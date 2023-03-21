Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B11896C35AC
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 16:28:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231696AbjCUP24 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 11:28:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230021AbjCUP2k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 11:28:40 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 779EC17CED;
        Tue, 21 Mar 2023 08:28:28 -0700 (PDT)
Date:   Tue, 21 Mar 2023 15:28:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1679412507;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Se6GzeIkbinvFUQpe0kWnURIikbXuEwA1tJrGqSZZFk=;
        b=2++pG2A/J5TbbZS09j3FFHP2kGrtrjnC36T58sztuB6a9aEZv/34Pz9ijbGo+MBv8H19uD
        2ciKGyHYpB8cDLJ3OdGRZQRZVSHGV6J8Ki8Ou60epMtAxFyrXaBElnqo7Pg1OGXmthj01h
        rrqgKJOpfcg7XW63yeygMzK5KAKu2z45+pTas8WiG7q4iS2u6uQBpCuhRrWTp3f8zlUmzn
        vs/EUIQOg6G2qjC3QQd3DZU8oLYOlzG/yLH6BL4EQQAan81dqkl9qSZfJ34hpMxI8e680h
        N5iL+WspxH2fH/q+rAn4lj1GwfSTgN+iN0AdbGJdlQrGY3GvQKg36DrH3s0MDw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1679412507;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Se6GzeIkbinvFUQpe0kWnURIikbXuEwA1tJrGqSZZFk=;
        b=mbcOmPSKc84qxW8Hap53VowpmHtvvy978B8mkm2saihDyW8xblo4bWjVeLnZrRqaLa6ZtU
        4/QZemY5eX4JEeAA==
From:   "tip-bot2 for Borislav Petkov (AMD)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sev] crypto: ccp: Get rid of __sev_platform_init_locked()'s
 local function pointer
Cc:     "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230307192449.24732-9-bp@alien8.de>
References: <20230307192449.24732-9-bp@alien8.de>
MIME-Version: 1.0
Message-ID: <167941250671.5837.15169735247960456185.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/sev branch of tip:

Commit-ID:     dbf07b544ca12c0ab8bd3fc1ea3509ea713a8bf5
Gitweb:        https://git.kernel.org/tip/dbf07b544ca12c0ab8bd3fc1ea3509ea713a8bf5
Author:        Borislav Petkov (AMD) <bp@alien8.de>
AuthorDate:    Tue, 07 Mar 2023 20:24:46 +01:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 21 Mar 2023 12:08:07 +01:00

crypto: ccp: Get rid of __sev_platform_init_locked()'s local function pointer

Add a wrapper instead.

No functional changes.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20230307192449.24732-9-bp@alien8.de
---
 drivers/crypto/ccp/sev-dev.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/crypto/ccp/sev-dev.c b/drivers/crypto/ccp/sev-dev.c
index 823c67a..e346c00 100644
--- a/drivers/crypto/ccp/sev-dev.c
+++ b/drivers/crypto/ccp/sev-dev.c
@@ -442,11 +442,18 @@ static int __sev_init_ex_locked(int *error)
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
@@ -458,15 +465,12 @@ static int __sev_platform_init_locked(int *error)
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
@@ -477,7 +481,7 @@ static int __sev_platform_init_locked(int *error)
 		 */
 		dev_err(sev->dev,
 "SEV: retrying INIT command because of SECURE_DATA_INVALID error. Retrying once to reset PSP SEV state.");
-		rc = init_function(&psp_ret);
+		rc = __sev_do_init_locked(&psp_ret);
 	}
 
 	if (error)
