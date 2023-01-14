Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A30266AD12
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Jan 2023 18:33:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbjANRd1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Jan 2023 12:33:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229973AbjANRdY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jan 2023 12:33:24 -0500
Received: from smtp.smtpout.orange.fr (smtp-16.smtpout.orange.fr [80.12.242.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B18BCA5FC
        for <linux-kernel@vger.kernel.org>; Sat, 14 Jan 2023 09:33:22 -0800 (PST)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id GkP6p29fEI2kPGkP6pk30A; Sat, 14 Jan 2023 18:33:21 +0100
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 14 Jan 2023 18:33:21 +0100
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Chang S. Bae" <chang.seok.bae@intel.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Borislav Petkov <bp@suse.de>
Subject: [PATCH] x86/signal: Fix the value returned by strict_sas_size()
Date:   Sat, 14 Jan 2023 18:33:09 +0100
Message-Id: <73882d43ebe420c9d8fb82d0560021722b243000.1673717552.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Functions used with __setup() return 1 when the argument has been
successfully parsed.

Reverse the returned value so that 1 is returned when kstrtobool() is
successful (i.e. returns 0)

Fixes: 3aac3ebea08f ("x86/signal: Implement sigaltstack size validation")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
This patch is completely speculative. Review with care!

My understanding of these __setup() functions is that returning 1 or 0
does not change much anyway.

I spot it and found it spurious while looking at something else.
Even if the output is not perfect, you'll get the idea with:
   git grep -B2 -A10 retu.*kstrtobool | grep __setup -B10
---
 arch/x86/kernel/signal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/signal.c b/arch/x86/kernel/signal.c
index 1504eb8d25aa..004cb30b7419 100644
--- a/arch/x86/kernel/signal.c
+++ b/arch/x86/kernel/signal.c
@@ -360,7 +360,7 @@ static bool strict_sigaltstack_size __ro_after_init = false;
 
 static int __init strict_sas_size(char *arg)
 {
-	return kstrtobool(arg, &strict_sigaltstack_size);
+	return kstrtobool(arg, &strict_sigaltstack_size) == 0;
 }
 __setup("strict_sas_size", strict_sas_size);
 
-- 
2.34.1

