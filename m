Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1197266B017
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Jan 2023 10:07:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230338AbjAOJHg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Jan 2023 04:07:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230211AbjAOJHR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jan 2023 04:07:17 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7722BC15F;
        Sun, 15 Jan 2023 01:07:07 -0800 (PST)
Date:   Sun, 15 Jan 2023 09:07:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1673773625;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jpEYCeQRkhvKftDnA3JJ5lal4ivPiXjM45+cvc1Q25A=;
        b=EPQ698DlMzRjFQiOeVJ84HEHi79z8oZFVpB5fS2Xxk6icztoD2xcmOdNhyl2/VJh2Dy4rL
        /9jDIEyfzEEd4NC03gMWu4obj++kqaFFkeokvCtxpyKw4sif+h1k5MDMLfj7hj5YovSoFj
        HNiOOcOebgyMOlyRrl7W8C6ZHZYTflb1B6mf2LvxolGTrWFaAbeypgQmLtEY54aRWd0wqH
        pvPWgVNDpQRgnNLGvI/+slXXuRTQwy8pHiexwzlL+rq8/iBYvRvypxnc9sGUoU/UPpHNcv
        vwex1SGYF82fND2qkKdp9IG5AaA4Ulu/41pd5J+Sy/o7TVpKDsh5ZG/stRWkZA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1673773625;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jpEYCeQRkhvKftDnA3JJ5lal4ivPiXjM45+cvc1Q25A=;
        b=+ZW9/HVF4YvZ/rfJIiKue8EMm2OgtrOorpkFsc22aO1xqyM1Mzk8p/TwKT++aaiVUxYitK
        Uvi1r3WsNqfX+xBw==
From:   "tip-bot2 for Christophe JAILLET" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86/signal: Fix the value returned by strict_sas_size()
Cc:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C73882d43ebe420c9d8fb82d0560021722b243000=2E16737?=
 =?utf-8?q?17552=2Egit=2Echristophe=2Ejaillet=40wanadoo=2Efr=3E?=
References: =?utf-8?q?=3C73882d43ebe420c9d8fb82d0560021722b243000=2E167371?=
 =?utf-8?q?7552=2Egit=2Echristophe=2Ejaillet=40wanadoo=2Efr=3E?=
MIME-Version: 1.0
Message-ID: <167377362509.4906.11170062722666722678.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     ef6dfc4b238a435ab552207ec09e4a82b6426d31
Gitweb:        https://git.kernel.org/tip/ef6dfc4b238a435ab552207ec09e4a82b6426d31
Author:        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
AuthorDate:    Sat, 14 Jan 2023 18:33:09 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sun, 15 Jan 2023 09:54:27 +01:00

x86/signal: Fix the value returned by strict_sas_size()

Functions used with __setup() return 1 when the argument has been
successfully parsed.

Reverse the returned value so that 1 is returned when kstrtobool() is
successful (i.e. returns 0).

My understanding of these __setup() functions is that returning 1 or 0
does not change much anyway - so this is more of a cleanup than a
functional fix.

I spot it and found it spurious while looking at something else.
Even if the output is not perfect, you'll get the idea with:

   $ git grep -B2 -A10 retu.*kstrtobool | grep __setup -B10

Fixes: 3aac3ebea08f ("x86/signal: Implement sigaltstack size validation")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/73882d43ebe420c9d8fb82d0560021722b243000.1673717552.git.christophe.jaillet@wanadoo.fr
---
 arch/x86/kernel/signal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/signal.c b/arch/x86/kernel/signal.c
index 1504eb8..004cb30 100644
--- a/arch/x86/kernel/signal.c
+++ b/arch/x86/kernel/signal.c
@@ -360,7 +360,7 @@ static bool strict_sigaltstack_size __ro_after_init = false;
 
 static int __init strict_sas_size(char *arg)
 {
-	return kstrtobool(arg, &strict_sigaltstack_size);
+	return kstrtobool(arg, &strict_sigaltstack_size) == 0;
 }
 __setup("strict_sas_size", strict_sas_size);
 
