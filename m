Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52A32613B0E
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 17:16:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231465AbiJaQQA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 12:16:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbiJaQP6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 12:15:58 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60C8711158;
        Mon, 31 Oct 2022 09:15:57 -0700 (PDT)
Date:   Mon, 31 Oct 2022 16:15:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1667232956;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zA73xcDWFZhtNZg9/6CkneYyLOUaAXtkq8I2ETRFB48=;
        b=rCwNiCcyv8gApg8QGfVc1O12RctcIthU7YxM0qtrNCdzeqX94+mTWyK8fXAnfHh1vdi2YB
        xeL1qnG/cdyEXT0UypjJmft0afn3Fel3l/cm+Clh3WFwqSc2FMaN1JH2GAbDpSZc7p7D+x
        s7syW4S7x5opoWIN6R5NZX6MDZ4NE5pf4BzjN7bOvzaYPeXnl2KNuNJ1MCnD1kGdszc5ZT
        ehO6kpcTqvDANyz4vrid1YJmDPXbI23nKCSHR+rtKL3PCy9gVt8fVUYwdRsTMk2rJu9WmE
        4XIPGPKtIkN1DXaMRNILoXQxlxTcdPC1vgktRwZdYXfkca4nt+nMbIe87cMN1A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1667232956;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zA73xcDWFZhtNZg9/6CkneYyLOUaAXtkq8I2ETRFB48=;
        b=O1CT8q2gtpZL33dORPyLThN62+03VrPo6boVDn7Y5mGE9e3lDYMn216VJndUs/HjZriRHv
        5RoDgSOB7hColGBw==
From:   "tip-bot2 for Tony Luck" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: ras/core] x86/mce: Use severity table to handle uncorrected
 errors in kernel
Cc:     Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@suse.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20220922195136.54575-2-tony.luck@intel.com>
References: <20220922195136.54575-2-tony.luck@intel.com>
MIME-Version: 1.0
Message-ID: <166723295340.7716.5561469678054696498.tip-bot2@tip-bot2>
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

The following commit has been merged into the ras/core branch of tip:

Commit-ID:     a51cbd0d86d3fa9ecc6ddf186dd1cb66a4fefa87
Gitweb:        https://git.kernel.org/tip/a51cbd0d86d3fa9ecc6ddf186dd1cb66a4fefa87
Author:        Tony Luck <tony.luck@intel.com>
AuthorDate:    Thu, 22 Sep 2022 12:51:35 -07:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 31 Oct 2022 17:01:19 +01:00

x86/mce: Use severity table to handle uncorrected errors in kernel

mce_severity_intel() has a special case to promote UC and AR errors
in kernel context to PANIC severity.

The "AR" case is already handled with separate entries in the severity
table for all instruction fetch errors, and those data fetch errors that
are not in a recoverable area of the kernel (i.e. have an extable fixup
entry).

Add an entry to the severity table for UC errors in kernel context that
reports severity = PANIC. Delete the special case code from
mce_severity_intel().

Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lore.kernel.org/r/20220922195136.54575-2-tony.luck@intel.com
---
 arch/x86/kernel/cpu/mce/severity.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/severity.c b/arch/x86/kernel/cpu/mce/severity.c
index 00483d1..c447716 100644
--- a/arch/x86/kernel/cpu/mce/severity.c
+++ b/arch/x86/kernel/cpu/mce/severity.c
@@ -203,6 +203,11 @@ static struct severity {
 		BITSET(MCI_STATUS_OVER|MCI_STATUS_UC)
 		),
 	MCESEV(
+		PANIC, "Uncorrected in kernel",
+		BITSET(MCI_STATUS_UC),
+		KERNEL
+		),
+	MCESEV(
 		UC, "Uncorrected",
 		BITSET(MCI_STATUS_UC)
 		),
@@ -391,9 +396,6 @@ static noinstr int mce_severity_intel(struct mce *m, struct pt_regs *regs, char 
 			*msg = s->msg;
 		s->covered = 1;
 
-		if (s->sev >= MCE_UC_SEVERITY && ctx == IN_KERNEL)
-			return MCE_PANIC_SEVERITY;
-
 		return s->sev;
 	}
 }
