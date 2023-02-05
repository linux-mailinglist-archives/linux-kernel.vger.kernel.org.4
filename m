Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6B4568AFEE
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Feb 2023 14:20:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229538AbjBENUY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Feb 2023 08:20:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjBENUX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Feb 2023 08:20:23 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF64B11E97
        for <linux-kernel@vger.kernel.org>; Sun,  5 Feb 2023 05:20:20 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id F337A1EC06F0;
        Sun,  5 Feb 2023 14:20:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1675603219;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=ay3kfPvYsRLBE8nBle1Vb9IVSFgTMMllKyY+0VBTznY=;
        b=FplXfxBmqD9vnAcT5mxDJE1BW45a2dekq0GUJifMicCn+Z/MAqRt1jLLGDK0RdSZSW+HMv
        JI09mZFo6h1KspTC9wXFm9k7QSoOLGXxgdisb3VOyYCKfGnJBHxAxK89A7xQjNg8iMiIgv
        CSFGCw0CckhXZ846ztcLPKC9+JKo1uM=
Date:   Sun, 5 Feb 2023 14:20:14 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Christian Kujau <lists@nerdbynature.de>,
        Juergen Gross <jgross@suse.com>,
        Michael Kelley <mikelley@microsoft.com>,
        linux-kernel@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Linux regressions mailing list <regressions@lists.linux.dev>
Subject: Re: External USB disks not recognized with v6.1.8 when using Xen
Message-ID: <Y9+tDmLAlqg37TS+@zn.tnic>
References: <4fe9541e-4d4c-2b2a-f8c8-2d34a7284930@nerdbynature.de>
 <f22551ea-0694-2838-4a3f-f60d8d93fa64@leemhuis.info>
 <8f132803-f496-f33a-d2ab-b47fd5af0b88@nerdbynature.de>
 <0f441adb-f565-7a37-d9e5-3b14f6f7aea6@suse.com>
 <f02c49da-0377-97b9-9438-9e0ddbfbcc6d@nerdbynature.de>
 <CAHk-=wg1yXaX+Ut4uctf7x1WrZ4WW9hjSCr1VACwZtkZT9frFw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wg1yXaX+Ut4uctf7x1WrZ4WW9hjSCr1VACwZtkZT9frFw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 02, 2023 at 12:24:30PM -0800, Linus Torvalds wrote:
> So I think that commit should be reverted as broken, and then people
> should *maybe* look at something like this (intentionally whitespace
> damaged, and people should *really* think about what the
> MTRR_TYPE_INVALID case should be - returning UC- is probably what is
> closest to "this is what the hardware does",

Yes, it is actually even documented that by default, all memory is UC-
if MTRRs are disabled.

> but maybe doesn't make sense for the largepage case, which might as
> well just always use largepages in that case?)

See below. I think it should be this way but I might be missing an
angle...

---
diff --git a/arch/x86/include/asm/mtrr.h b/arch/x86/include/asm/mtrr.h
index f0eeaf6e5f5f..4061f1e8d34c 100644
--- a/arch/x86/include/asm/mtrr.h
+++ b/arch/x86/include/asm/mtrr.h
@@ -53,7 +53,8 @@ static inline u8 mtrr_type_lookup(u64 addr, u64 end, u8 *uniform)
 	/*
 	 * Return no-MTRRs:
 	 */
-	return MTRR_TYPE_INVALID;
+	*uniform = 1;
+	return MTRR_TYPE_UNCACHABLE;
 }
 #define mtrr_save_fixed_ranges(arg) do {} while (0)
 #define mtrr_save_state() do {} while (0)
diff --git a/arch/x86/kernel/cpu/mtrr/generic.c b/arch/x86/kernel/cpu/mtrr/generic.c
index ee09d359e08f..2a1ed63d2b24 100644
--- a/arch/x86/kernel/cpu/mtrr/generic.c
+++ b/arch/x86/kernel/cpu/mtrr/generic.c
@@ -255,17 +255,25 @@ static u8 mtrr_type_lookup_variable(u64 start, u64 end, u64 *partial_end,
 u8 mtrr_type_lookup(u64 start, u64 end, u8 *uniform)
 {
 	u8 type, prev_type, is_uniform = 1, dummy;
-	int repeat;
 	u64 partial_end;
+	int repeat;
 
 	/* Make end inclusive instead of exclusive */
 	end--;
 
+	/*
+	 * UC- by default because " [i]f the MTRRs are disabled in implementations
+	 * that support the MTRR mechanism, the default memory type is set to
+	 * uncacheable (UC)".
+	 */
+	 type = MTRR_TYPE_UNCACHABLE;
+
 	if (!mtrr_state_set)
-		return MTRR_TYPE_INVALID;
+		goto out;
 
+	type = mtrr_state.def_type;
 	if (!(mtrr_state.enabled & MTRR_STATE_MTRR_ENABLED))
-		return MTRR_TYPE_INVALID;
+		goto out;
 
 	/*
 	 * Look up the fixed ranges first, which take priority over
diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
index e4f499eb0f29..ed914bc95345 100644
--- a/arch/x86/mm/pgtable.c
+++ b/arch/x86/mm/pgtable.c
@@ -721,8 +721,9 @@ int pud_set_huge(pud_t *pud, phys_addr_t addr, pgprot_t prot)
 	u8 mtrr, uniform;
 
 	mtrr = mtrr_type_lookup(addr, addr + PUD_SIZE, &uniform);
-	if ((mtrr != MTRR_TYPE_INVALID) && (!uniform) &&
-	    (mtrr != MTRR_TYPE_WRBACK))
+	if (mtrr != MTRR_TYPE_UNCACHABLE &&
+	    mtrr != MTRR_TYPE_WRBACK &&
+	    !uniform)
 		return 0;
 
 	/* Bail out if we are we on a populated non-leaf entry: */
@@ -748,8 +749,9 @@ int pmd_set_huge(pmd_t *pmd, phys_addr_t addr, pgprot_t prot)
 	u8 mtrr, uniform;
 
 	mtrr = mtrr_type_lookup(addr, addr + PMD_SIZE, &uniform);
-	if ((mtrr != MTRR_TYPE_INVALID) && (!uniform) &&
-	    (mtrr != MTRR_TYPE_WRBACK)) {
+	if (mtrr != MTRR_TYPE_UNCACHABLE &&
+	    mtrr != MTRR_TYPE_WRBACK &&
+	    !uniform) {
 		pr_warn_once("%s: Cannot satisfy [mem %#010llx-%#010llx] with a huge-page mapping due to MTRR override.\n",
 			     __func__, addr, addr + PMD_SIZE);
 		return 0;

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
