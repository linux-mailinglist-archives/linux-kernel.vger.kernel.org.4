Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A4A8686B8D
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 17:26:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231503AbjBAQ0h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 11:26:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjBAQ0f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 11:26:35 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B383E77517;
        Wed,  1 Feb 2023 08:26:34 -0800 (PST)
Date:   Wed, 01 Feb 2023 16:26:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1675268793;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZHa29J7fJfvVDrJh+OJqnvehQZwLvuS2I7HxcjmkPxY=;
        b=h6WlmtyuT4yS4/ifrE4tkm36RJZwaEBFLMEP5JA32UIpMykLZmRuKEX1PTxKCZMUkSNaUU
        P5ZcsY4pzRxJ0QScJFBZX2+o5hPwDAnchbgiAxuUuMQcsU0UcnHiu9Q8+YW1/KI4e3mtTV
        zZ+iLr7PQuDSy40E9DXQi8ztIoImfBdyjWwYnj9tGV2bMJS+9sl8Schnr0OsfVAYlf11Tf
        s6/l41OmaX5zViKs/oThy1fn6rquXWyyi/+ryb0viv+deUBDRzdX7QzuhgJPpkjiJZYVfR
        cF1u756H9UVHQnC4ZHj/9t+5zgUVA7Mhw8QoUhRkeUb+4T6MlYQTTG51FBjcHg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1675268793;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZHa29J7fJfvVDrJh+OJqnvehQZwLvuS2I7HxcjmkPxY=;
        b=CJwcJBt6qdTYfba46yHY6Dvt8S3ulSYeD4g5IfJ861bvoQdOQRTz3LnwvFsJCiDxiAr7Vh
        JP5b5d/0kLS1W3CA==
From:   tip-bot2 for Thomas =?utf-8?q?Wei=C3=9Fschuh?= 
        <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Optimize layout of struct special_alt
Cc:     linux@weissschuh.net, Josh Poimboeuf <jpoimboe@kernel.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20221216-objtool-memory-v2-7-17968f85a464@weissschuh.net>
References: <20221216-objtool-memory-v2-7-17968f85a464@weissschuh.net>
MIME-Version: 1.0
Message-ID: <167526879285.4906.9411259266925630445.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     391e6d2abd652b460d9017b2f8a8ded508c09558
Gitweb:        https://git.kernel.org/tip/391e6d2abd652b460d9017b2f8a8ded508c=
09558
Author:        Thomas Wei=C3=9Fschuh <linux@weissschuh.net>
AuthorDate:    Tue, 27 Dec 2022 16:01:03=20
Committer:     Josh Poimboeuf <jpoimboe@kernel.org>
CommitterDate: Mon, 30 Jan 2023 16:28:20 -08:00

objtool: Optimize layout of struct special_alt

Reduce the size of struct special_alt from 72 to 64 bytes.

Signed-off-by: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>
Link: https://lore.kernel.org/r/20221216-objtool-memory-v2-7-17968f85a464@wei=
ssschuh.net
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 tools/objtool/include/objtool/special.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/objtool/include/objtool/special.h b/tools/objtool/include/=
objtool/special.h
index dc4721e..86d4af9 100644
--- a/tools/objtool/include/objtool/special.h
+++ b/tools/objtool/include/objtool/special.h
@@ -19,6 +19,7 @@ struct special_alt {
 	bool skip_orig;
 	bool skip_alt;
 	bool jump_or_nop;
+	u8 key_addend;
=20
 	struct section *orig_sec;
 	unsigned long orig_off;
@@ -27,7 +28,6 @@ struct special_alt {
 	unsigned long new_off;
=20
 	unsigned int orig_len, new_len; /* group only */
-	u8 key_addend;
 };
=20
 int special_get_alts(struct elf *elf, struct list_head *alts);
