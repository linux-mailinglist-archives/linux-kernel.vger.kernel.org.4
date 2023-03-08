Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5563E6B0E8C
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 17:23:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229927AbjCHQXq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 11:23:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbjCHQXo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 11:23:44 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76C6F968DE;
        Wed,  8 Mar 2023 08:23:34 -0800 (PST)
Date:   Wed, 08 Mar 2023 16:23:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1678292612;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HFiuzNGyE2MZXTYS92ORAfHaB7tViY38+H5/LASSeFE=;
        b=rujE64cWGq/lI9JQ3b7cvWDOVa0reaCVYUt1QLiUkeDAsgNlaSl7hAxe1ZHMQ2sr4RFOHL
        xwd7yNmhO9SRz94a5088DPKZAiLTLJw9NBvL/X7R9uaWlAyDmlr71/mZQLY16jNvqsDh7M
        BHFZUC7+ohK9cI/UkgdUSzPZTsHjwV4oniFrxCupC0kq3DreitSTnxu5yuAgaQK2hrmVdX
        lNKGhpWQOMttpgVI0qrlRthGHisyN9YeuQGFn9oL2Y18s3LK8xXawzDBWj4Vb8KPzmapg8
        tDExzXENNJspLUWEWwMC4SaMnCc7Yqb8wOz0fyxiF/j2m3CUjntW3E7lU8VcOg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1678292612;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HFiuzNGyE2MZXTYS92ORAfHaB7tViY38+H5/LASSeFE=;
        b=lMThGvy+Q1AHni5EPxRNSzMsXbjiev8tM/VtaxRGS4dPQrlUlEZWvgiT+h0lhYuvAOCUKx
        toIWIGFsAK0jXYAg==
From:   "tip-bot2 for Andrew Cooper" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/CPU/AMD: Disable XSAVES on AMD family 0x17
Cc:     Tavis Ormandy <taviso@gmail.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        "Borislav Petkov (AMD)" <bp@alien8.de>, <stable@kernel.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230307174643.1240184-1-andrew.cooper3@citrix.com>
References: <20230307174643.1240184-1-andrew.cooper3@citrix.com>
MIME-Version: 1.0
Message-ID: <167829261190.5837.14765105385267384206.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     b0563468eeac88ebc70559d52a0b66efc37e4e9d
Gitweb:        https://git.kernel.org/tip/b0563468eeac88ebc70559d52a0b66efc37e4e9d
Author:        Andrew Cooper <andrew.cooper3@citrix.com>
AuthorDate:    Tue, 07 Mar 2023 17:46:43 
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Wed, 08 Mar 2023 16:56:08 +01:00

x86/CPU/AMD: Disable XSAVES on AMD family 0x17

AMD Erratum 1386 is summarised as:

  XSAVES Instruction May Fail to Save XMM Registers to the Provided
  State Save Area

This piece of accidental chronomancy causes the %xmm registers to
occasionally reset back to an older value.

Ignore the XSAVES feature on all AMD Zen1/2 hardware.  The XSAVEC
instruction (which works fine) is equivalent on affected parts.

  [ bp: Typos, move it into the F17h-specific function. ]

Reported-by: Tavis Ormandy <taviso@gmail.com>
Signed-off-by: Andrew Cooper <andrew.cooper3@citrix.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Cc: <stable@kernel.org>
Link: https://lore.kernel.org/r/20230307174643.1240184-1-andrew.cooper3@citrix.com
---
 arch/x86/kernel/cpu/amd.c |  9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index 380753b..95cdd08 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -880,6 +880,15 @@ void init_spectral_chicken(struct cpuinfo_x86 *c)
 		}
 	}
 #endif
+	/*
+	 * Work around Erratum 1386.  The XSAVES instruction malfunctions in
+	 * certain circumstances on Zen1/2 uarch, and not all parts have had
+	 * updated microcode at the time of writing (March 2023).
+	 *
+	 * Affected parts all have no supervisor XSAVE states, meaning that
+	 * the XSAVEC instruction (which works fine) is equivalent.
+	 */
+	clear_cpu_cap(c, X86_FEATURE_XSAVES);
 }
 
 static void init_amd_zn(struct cpuinfo_x86 *c)
