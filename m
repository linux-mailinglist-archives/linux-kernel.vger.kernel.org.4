Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEEA7642840
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 13:19:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231717AbiLEMTJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 07:19:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231390AbiLEMTG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 07:19:06 -0500
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2888BF51
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 04:19:04 -0800 (PST)
Received: from zn.tnic (p200300ea9733e72f329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e72f:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 705F41EC0426;
        Mon,  5 Dec 2022 13:19:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1670242743;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=pW9cEUKFzxdsaAe+csAOijweWep/oZrdZo3lE2A/UvU=;
        b=WFtbj6ehix5u0MqKvQpYZ49AFkfAYcagu7sswVMUKUJyZ2+AKfCpiv/wCpQqYkhz6/ecpk
        5FRgCXY0KIjnhTrgq61+0Zp0mB3RX80oHNzCB7CMzrWVBMw9Rs9A+E0Cp190gUqTmpFuaj
        Joe8UjMqo5hi1X90lnSQwYAzJXr2sOc=
Date:   Mon, 5 Dec 2022 13:18:58 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Ashok Raj <ashok.raj@intel.com>
Cc:     X86-kernel <x86@kernel.org>,
        LKML Mailing List <linux-kernel@vger.kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>, alison.schofield@intel.com,
        reinette.chatre@intel.com
Subject: Re: [Patch V1 2/7] x86/microcode/intel: Remove retries on early
 microcode load
Message-ID: <Y43hstW6oL4naReu@zn.tnic>
References: <20221129210832.107850-1-ashok.raj@intel.com>
 <20221129210832.107850-3-ashok.raj@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221129210832.107850-3-ashok.raj@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 29, 2022 at 01:08:27PM -0800, Ashok Raj wrote:
> There is no direct evidence that these end user issues were caused by this
> retry loop. However, the early boot hangs along with reverting the
> microcode update workaround provide strong circumstantial evidence to
> support the theory that they are linked.

A "circumstantial" reason for why something "might" be broken has no
place in a commit message.

If you still wanna chase this and *actually* give me a sane,
comprehensible reason of why this could cause an endless loop with
officially released microcode, then I'm willing to listen.

Otherwise, I'll apply this:

---
From: Ashok Raj <ashok.raj@intel.com>
Date: Tue, 29 Nov 2022 13:08:27 -0800
Subject: x86/microcode/intel: Remove retries on early microcode load

The retries in load_ucode_intel_ap() were in place to support systems
with mixed steppings. Mixed steppings are no longer supported and there is
only one microcode image at a time. Any retries will simply reattempt to
apply the same image over and over without making progress.

Fixes: 06b8534cb728 ("x86/microcode: Rework microcode loading")
Signed-off-by: Ashok Raj <ashok.raj@intel.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20221129210832.107850-3-ashok.raj@intel.com
---
 arch/x86/kernel/cpu/microcode/intel.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/intel.c b/arch/x86/kernel/cpu/microcode/intel.c
index 4f93875f57b4..d68b084a17e7 100644
--- a/arch/x86/kernel/cpu/microcode/intel.c
+++ b/arch/x86/kernel/cpu/microcode/intel.c
@@ -495,7 +495,6 @@ void load_ucode_intel_ap(void)
 	else
 		iup = &intel_ucode_patch;
 
-reget:
 	if (!*iup) {
 		patch = __load_ucode_intel(&uci);
 		if (!patch)
@@ -505,13 +504,7 @@ void load_ucode_intel_ap(void)
 	}
 
 	uci.mc = *iup;
-
-	if (apply_microcode_early(&uci, true)) {
-		/* Mixed-silicon system? Try to refetch the proper patch: */
-		*iup = NULL;
-
-		goto reget;
-	}
+	apply_microcode_early(&uci, true);
 }
 
 static struct microcode_intel *find_patch(struct ucode_cpu_info *uci)

-- 
2.34.1


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
