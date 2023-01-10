Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 398E8664622
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 17:32:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238827AbjAJQcX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 11:32:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238880AbjAJQcD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 11:32:03 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 328ED84099;
        Tue, 10 Jan 2023 08:32:01 -0800 (PST)
Date:   Tue, 10 Jan 2023 16:31:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1673368319;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ttxt13H5J51Gqr1Xn/jMJHwCS/g2F1Jlbgm/N+cRYAM=;
        b=GziND44NHtHJpTpTJI4rkQlAVdumD7TbsumT9wqcOvkijawpUThT5zg7u9calm0ntwPLG2
        Vs9sg/Xdr/waj3vi5xdUf6suWHFVHEYSute4Sot8/jszcw8p8cO0iqIW0GJYNpwY4yJHEv
        x3nqSJQGTiBYbBk8LbaYf1YUQbr2ez2qmjPZ9U4ruVOVM8rlP1RotXmCeYIIFIjFYC0qvH
        tOjPL5zkgRrPff0sxhEnNKOV8jEtIgUfJWyDfhA6G/G5SK6TJkJnJXVo6fCGx+jtYLutYa
        3meVv/zZe5SUnkyir2aOc72Ve8izqmGWRFrleuOp+1IdP3QiFcOLql9GS/8r/w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1673368319;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ttxt13H5J51Gqr1Xn/jMJHwCS/g2F1Jlbgm/N+cRYAM=;
        b=wZF48rBvO2VBvLT70dlkh7zQyyD0v5rNFM1p8m+F6n+LZ7qD6INSMJ5MdcXD7ifVL6ztpu
        myMdW2zdLUZtEEBA==
From:   "tip-bot2 for Juergen Gross" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/pat: Fix pat_x_mtrr_type() for MTRR disabled case
Cc:     "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        Juergen Gross <jgross@suse.com>,
        "Borislav Petkov (AMD)" <bp@alien8.de>, <stable@kernel.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230110065427.20767-1-jgross@suse.com>
References: <20230110065427.20767-1-jgross@suse.com>
MIME-Version: 1.0
Message-ID: <167336831878.4906.1036202649956155536.tip-bot2@tip-bot2>
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

Commit-ID:     90b926e68f500844dff16b5bcea178dc55cf580a
Gitweb:        https://git.kernel.org/tip/90b926e68f500844dff16b5bcea178dc55cf580a
Author:        Juergen Gross <jgross@suse.com>
AuthorDate:    Tue, 10 Jan 2023 07:54:27 +01:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 10 Jan 2023 17:21:53 +01:00

x86/pat: Fix pat_x_mtrr_type() for MTRR disabled case

Since

  72cbc8f04fe2 ("x86/PAT: Have pat_enabled() properly reflect state when running on Xen")

PAT can be enabled without MTRR.

This has resulted in problems e.g. for a SEV-SNP guest running under Hyper-V,
when trying to establish a new mapping via memremap() with WB caching mode, as
pat_x_mtrr_type() will call mtrr_type_lookup(), which in turn is returning
MTRR_TYPE_INVALID due to MTRR being disabled in this configuration.

The result is a mapping with UC- caching, leading to severe performance
degradation.

Fix that by handling MTRR_TYPE_INVALID the same way as MTRR_TYPE_WRBACK
in pat_x_mtrr_type() because MTRR_TYPE_INVALID means MTRRs are disabled.

  [ bp: Massage commit message. ]

Fixes: 72cbc8f04fe2 ("x86/PAT: Have pat_enabled() properly reflect state when running on Xen")
Reported-by: Michael Kelley (LINUX) <mikelley@microsoft.com>
Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Michael Kelley <mikelley@microsoft.com>
Tested-by: Michael Kelley <mikelley@microsoft.com>
Cc: <stable@kernel.org>
Link: https://lore.kernel.org/r/20230110065427.20767-1-jgross@suse.com
---
 arch/x86/mm/pat/memtype.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/mm/pat/memtype.c b/arch/x86/mm/pat/memtype.c
index 46de9cf..fb4b1b5 100644
--- a/arch/x86/mm/pat/memtype.c
+++ b/arch/x86/mm/pat/memtype.c
@@ -387,7 +387,8 @@ static unsigned long pat_x_mtrr_type(u64 start, u64 end,
 		u8 mtrr_type, uniform;
 
 		mtrr_type = mtrr_type_lookup(start, end, &uniform);
-		if (mtrr_type != MTRR_TYPE_WRBACK)
+		if (mtrr_type != MTRR_TYPE_WRBACK &&
+		    mtrr_type != MTRR_TYPE_INVALID)
 			return _PAGE_CACHE_MODE_UC_MINUS;
 
 		return _PAGE_CACHE_MODE_WB;
