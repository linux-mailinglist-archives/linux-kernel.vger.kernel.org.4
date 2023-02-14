Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 919EE695F5C
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 10:36:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232487AbjBNJgJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 04:36:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232499AbjBNJgB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 04:36:01 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 870B0768C;
        Tue, 14 Feb 2023 01:35:59 -0800 (PST)
Date:   Tue, 14 Feb 2023 09:35:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1676367357;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AnHUKuwyU2GALNl/FSylj78vAcnU+5Z3BJ7Qbr/o6G0=;
        b=0y5OoRbz7URyNEhfAmt1a3+JoJEpLVuLw5uOK2Vpr1KjBS9Yyi249pLp9oAIXl/4JYAsn5
        YetnnvzESu35QXDA8pnTY97RwMCxy6CuGT15Kb+DZL+x04C4KZgfd1Lug9s2qo1VsuMoCk
        BSnNiUXZ9OTQCrg+APTlL8TrkzCvmp0ujsOa3VMNbX6dYuXjSl8kAHtGbeXsBXklAO4IVG
        MEv5BZ2VBr4q60rwq3ZZ69OIDHMXlAFTF19HRgrmE3xqR7w3KerirmcDCXbho5xIasA2Ir
        YK9PYBS5Ls8OcmoWP+oaVaO7IASRFBaoZrwhNhyV7CvMrPf0noP8x25OERJ/pQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1676367357;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AnHUKuwyU2GALNl/FSylj78vAcnU+5Z3BJ7Qbr/o6G0=;
        b=vFMTTH7snpiDiyAIF5jqVd/pPFxTu5K/CK5fxxWU+zwuB/Dwfem+Xd2i3MVRK1DxqSHEQm
        pwqoETSX92S60cCw==
From:   "tip-bot2 for Juergen Gross" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/mtrr: Revert 90b926e68f50 ("x86/pat: Fix
 pat_x_mtrr_type() for MTRR disabled case")
Cc:     Christian Kujau <lists@nerdbynature.de>,
        Juergen Gross <jgross@suse.com>,
        "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <4fe9541e-4d4c-2b2a-f8c8-2d34a7284930@nerdbynature.de>
References: <4fe9541e-4d4c-2b2a-f8c8-2d34a7284930@nerdbynature.de>
MIME-Version: 1.0
Message-ID: <167636735608.4906.4788207020350311572.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     f9f57da2c2d119dbf109e3f6e1ceab7659294046
Gitweb:        https://git.kernel.org/tip/f9f57da2c2d119dbf109e3f6e1ceab7659294046
Author:        Juergen Gross <jgross@suse.com>
AuthorDate:    Thu, 09 Feb 2023 08:22:17 +01:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 14 Feb 2023 10:16:34 +01:00

x86/mtrr: Revert 90b926e68f50 ("x86/pat: Fix pat_x_mtrr_type() for MTRR disabled case")

Commit

  90b926e68f50 ("x86/pat: Fix pat_x_mtrr_type() for MTRR disabled case")

broke the use case of running Xen dom0 kernels on machines with an
external disk enclosure attached via USB, see Link tag.

What this commit was originally fixing - SEV-SNP guests on Hyper-V - is
a more specialized situation which has other issues at the moment anyway
so reverting this now and addressing the issue properly later is the
prudent thing to do.

So revert it in time for the 6.2 proper release.

  [ bp: Rewrite commit message. ]

Reported-by: Christian Kujau <lists@nerdbynature.de>
Tested-by: Christian Kujau <lists@nerdbynature.de>
Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/4fe9541e-4d4c-2b2a-f8c8-2d34a7284930@nerdbynature.de
---
 arch/x86/mm/pat/memtype.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/x86/mm/pat/memtype.c b/arch/x86/mm/pat/memtype.c
index fb4b1b5..46de9cf 100644
--- a/arch/x86/mm/pat/memtype.c
+++ b/arch/x86/mm/pat/memtype.c
@@ -387,8 +387,7 @@ static unsigned long pat_x_mtrr_type(u64 start, u64 end,
 		u8 mtrr_type, uniform;
 
 		mtrr_type = mtrr_type_lookup(start, end, &uniform);
-		if (mtrr_type != MTRR_TYPE_WRBACK &&
-		    mtrr_type != MTRR_TYPE_INVALID)
+		if (mtrr_type != MTRR_TYPE_WRBACK)
 			return _PAGE_CACHE_MODE_UC_MINUS;
 
 		return _PAGE_CACHE_MODE_WB;
