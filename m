Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5B9E64268D
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 11:17:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230332AbiLEKQz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 05:16:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230184AbiLEKQr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 05:16:47 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB1FE18E24;
        Mon,  5 Dec 2022 02:16:46 -0800 (PST)
Date:   Mon, 05 Dec 2022 10:16:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1670235404;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eUABA7cTiUpkbff/4pIrajUwqXIfq2KxpOg7kH+gkCM=;
        b=YV7MIHP/p2gLYRD+BaTkP3eGWZLoNbImnTocOj5NUeaydwQWffx7hg+2GG/tTu9jdi3cVy
        lMEgciIVCX9dqsSVdoZsKOSjwCTIjlIcaoAD0KU/2JRW26AuYTszvN61dLydAGJtYF/GwF
        Jn1Bdjfl+Nt506/2IZ6c7F3ghNk39c0oYIMSvIRc2y7g6C640Zct4wvyZwt+c59JaJAuHD
        MTgH028yhvcLyb9XbVfYsIflireK3sFauk9qyq5lQ5OeFNrvzkGxb53YzJIWOGnhO8nWPw
        XirCBIW+or3vugc5XQWoJ4cKKpWRooojHX2Giim3M/vOhvtVzpvmg6Dl42/c1Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1670235404;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eUABA7cTiUpkbff/4pIrajUwqXIfq2KxpOg7kH+gkCM=;
        b=xPN4u2F+74gXC9suJ9NrdnnYe/zgRlB6WASedm8E9/SqQ1t2xD4aiCXhLvvGQAiCrEpcXG
        eNcQCGZbof+2s9DA==
From:   "tip-bot2 for Juergen Gross" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/mtrr: Make message for disabled MTRRs more descriptive
Cc:     Juergen Gross <jgross@suse.com>,
        "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221205080433.16643-3-jgross@suse.com>
References: <20221205080433.16643-3-jgross@suse.com>
MIME-Version: 1.0
Message-ID: <167023540385.4906.769505168034496699.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     7882b69eb6cdf6288a89d831d95c8547400a8b4d
Gitweb:        https://git.kernel.org/tip/7882b69eb6cdf6288a89d831d95c8547400a8b4d
Author:        Juergen Gross <jgross@suse.com>
AuthorDate:    Mon, 05 Dec 2022 09:04:33 +01:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 05 Dec 2022 11:08:25 +01:00

x86/mtrr: Make message for disabled MTRRs more descriptive

Instead of just saying "Disabled" when MTRRs are disabled for any
reason, tell what is disabled and why.

Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20221205080433.16643-3-jgross@suse.com
---
 arch/x86/kernel/cpu/mtrr/mtrr.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/mtrr/mtrr.c b/arch/x86/kernel/cpu/mtrr/mtrr.c
index 6432abc..783f321 100644
--- a/arch/x86/kernel/cpu/mtrr/mtrr.c
+++ b/arch/x86/kernel/cpu/mtrr/mtrr.c
@@ -629,6 +629,7 @@ int __initdata changed_by_mtrr_cleanup;
  */
 void __init mtrr_bp_init(void)
 {
+	const char *why = "(not available)";
 	u32 phys_addr;
 
 	phys_addr = 32;
@@ -705,12 +706,13 @@ void __init mtrr_bp_init(void)
 				changed_by_mtrr_cleanup = mtrr_cleanup(phys_addr);
 			} else {
 				mtrr_if = NULL;
+				why = "by BIOS";
 			}
 		}
 	}
 
 	if (!mtrr_enabled())
-		pr_info("Disabled\n");
+		pr_info("MTRRs disabled %s\n", why);
 }
 
 /**
