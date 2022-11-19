Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D843630F94
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Nov 2022 17:46:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234467AbiKSQp7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Nov 2022 11:45:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234463AbiKSQpw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Nov 2022 11:45:52 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AFEC8F;
        Sat, 19 Nov 2022 08:45:51 -0800 (PST)
Date:   Sat, 19 Nov 2022 16:45:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668876350;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=plrm+xmykYAoNg4a8w8hWmbbNHyol+PQH2YoAgui7nk=;
        b=uWZ6azFF/+JU7kz1vdz4gQXkCeOKj/tJulY2q2Ee8WArXfLu5LwGH3kdfm1lMtbl/nE6wJ
        oxLpoIbmukCyT0HaYcRTB31Sr1mkyOZsGjzy0nVGm58dLTAlKtSJkWRLUjWugg2mhpJHUF
        gN8vhg3SEUkZcW4q/aq5t7xr3kcxNwV2dMbHtwHGI7PfqlL84q0FAjx1nYCUikk2n0I0Td
        SB9OOjDizonRjBxXQUfJOwQubGuPfaS6An7YdjEiLbywyFe3q5aAvqpefYC0iL2S5TLrsL
        VH/H/J8hUXSysAon1rf1HP6dWyh7RjA0hXQ6PN0VAx5oKwj5VA/XFz/xkvtE5g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668876350;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=plrm+xmykYAoNg4a8w8hWmbbNHyol+PQH2YoAgui7nk=;
        b=dI3IO8rXU+lpkblq0oTd1IelvE/rM5qTRCCQGnORjqXSU3k2uQkIWx/qtLInHsf3WQikN6
        CsfSHpP9hNKofTCw==
From:   "tip-bot2 for Jiapeng Chong" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86/kaslr: Fix process_mem_region()'s return value
Cc:     Abaci Robot <abaci@linux.alibaba.com>,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220421202556.129799-1-jiapeng.chong@linux.alibaba.com>
References: <20220421202556.129799-1-jiapeng.chong@linux.alibaba.com>
MIME-Version: 1.0
Message-ID: <166887634865.4906.2868849268609528843.tip-bot2@tip-bot2>
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

Commit-ID:     ee92fa03918d114d3ac9c36a8bf2c032ede75a3b
Gitweb:        https://git.kernel.org/tip/ee92fa03918d114d3ac9c36a8bf2c032ede75a3b
Author:        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
AuthorDate:    Fri, 22 Apr 2022 04:25:56 +08:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Sat, 19 Nov 2022 17:35:10 +01:00

x86/kaslr: Fix process_mem_region()'s return value

Fix the following coccicheck warning:

  ./arch/x86/boot/compressed/kaslr.c:670:8-9: WARNING: return of 0/1 in
  function 'process_mem_region' with return type bool.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lore.kernel.org/r/20220421202556.129799-1-jiapeng.chong@linux.alibaba.com
---
 arch/x86/boot/compressed/kaslr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
index e476bcb..454757f 100644
--- a/arch/x86/boot/compressed/kaslr.c
+++ b/arch/x86/boot/compressed/kaslr.c
@@ -668,7 +668,7 @@ static bool process_mem_region(struct mem_vector *region,
 		}
 	}
 #endif
-	return 0;
+	return false;
 }
 
 #ifdef CONFIG_EFI
