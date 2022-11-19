Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C343630F73
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Nov 2022 17:24:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234501AbiKSQYj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Nov 2022 11:24:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233833AbiKSQYJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Nov 2022 11:24:09 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17DE0326D9;
        Sat, 19 Nov 2022 08:24:08 -0800 (PST)
Date:   Sat, 19 Nov 2022 16:24:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668875046;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TmkVH4IHiR0BDbAwS7+j1XEqwboBpYRabMZXz71Svvg=;
        b=2VP5lPR5WnWZrbgjW1PTdNZAFH1eMFHUKpBsUK1sYJFAtwT/FOc0kCTdVK8GETf4aESUMl
        Q8dnFeweN2cyWP48p3vRa1CYLehYcTN79xshqrfmP5qM9XFtwt5WVyrxBrnlhPSSKfWW5Q
        8m1qe0N9ENsp2+JllcvS7WjF1eAN3sVcTqHz9T5CC/ioUTzippntEUnyzF7pdV4C2ePg6C
        2i7jVQ2JVdk3twLLlsFassCC05k7X2e+8qDKElapVedV8NKhGyW5AU5kzbNZ3rOsMcKnDP
        sCvcCPG9k56nISpsaRo1MTCB+hXhkj4MNLmDX2mwqL7GwuI1bVfxUZJY8f/GwA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668875046;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TmkVH4IHiR0BDbAwS7+j1XEqwboBpYRabMZXz71Svvg=;
        b=/qxqTBMs3VGbgDjMKqPFnFRdQHyndDI0um3egoUZlFI1/xn1y0iSiKB9JPC3p3ThZrGjJa
        xXnperwOI2GMk4Bw==
From:   "tip-bot2 for Jithu Joseph" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/microcode] x86/microcode/intel: Use a reserved field for metasize
Cc:     Jithu Joseph <jithu.joseph@intel.com>,
        Borislav Petkov <bp@suse.de>, Tony Luck <tony.luck@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Sohil Mehta <sohil.mehta@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221117035935.4136738-10-jithu.joseph@intel.com>
References: <20221117035935.4136738-10-jithu.joseph@intel.com>
MIME-Version: 1.0
Message-ID: <166887504551.4906.184513856016744075.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/microcode branch of tip:

Commit-ID:     28377e56ed22ecce60260eb8afdf0c9837b3505f
Gitweb:        https://git.kernel.org/tip/28377e56ed22ecce60260eb8afdf0c9837b3505f
Author:        Jithu Joseph <jithu.joseph@intel.com>
AuthorDate:    Wed, 16 Nov 2022 19:59:28 -08:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Fri, 18 Nov 2022 22:10:12 +01:00

x86/microcode/intel: Use a reserved field for metasize

Intel is using microcode file format for IFS test images too.

IFS test images use one of the existing reserved fields in microcode
header to indicate the size of the region in the file allocated for
metadata structures.

In preparation for this, rename first of the existing reserved fields
in microcode header to metasize. In subsequent patches IFS specific
code will make use of this field while parsing IFS images.

Signed-off-by: Jithu Joseph <jithu.joseph@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Ashok Raj <ashok.raj@intel.com>
Reviewed-by: Sohil Mehta <sohil.mehta@intel.com>
Link: https://lore.kernel.org/r/20221117035935.4136738-10-jithu.joseph@intel.com
---
 arch/x86/include/asm/microcode_intel.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/microcode_intel.h b/arch/x86/include/asm/microcode_intel.h
index 2a999bf..6af1e70 100644
--- a/arch/x86/include/asm/microcode_intel.h
+++ b/arch/x86/include/asm/microcode_intel.h
@@ -14,7 +14,8 @@ struct microcode_header_intel {
 	unsigned int            pf;
 	unsigned int            datasize;
 	unsigned int            totalsize;
-	unsigned int            reserved[3];
+	unsigned int            metasize;
+	unsigned int            reserved[2];
 };
 
 struct microcode_intel {
