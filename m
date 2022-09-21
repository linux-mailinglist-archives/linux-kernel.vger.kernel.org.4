Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A3965BFCC3
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 13:08:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230028AbiIULIu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 07:08:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbiIULIs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 07:08:48 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25699883FA;
        Wed, 21 Sep 2022 04:08:47 -0700 (PDT)
Date:   Wed, 21 Sep 2022 11:08:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1663758525;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=R6IdUAA72JC+9QspugHblhVYOSavYtHKl6EUF8PcDRA=;
        b=vMC3w7M3b4Ux2k5MObbwT8dQjZC/Qsit6sM1sC6LMhUC6aUZiiCSViHsxx6YvOfNry6tqP
        h7kCloQ/9yQc5ZW47wsExZfGIgjh0TTCeS4j760d/dZ73bHFQsRpVvSrozgFLwrsoy4spM
        gL8mevH/xHIuGy45kOZXRkTqFZfjBT33b9/2aLchcBYGBCtmvsTvQufHx/oW3D670nJy7c
        +6Hw0pXwdjhekV7JJqmK0+R8VEcGNwUv7JWnsTxTYx/Tu8cl7G5ToqMbRP9nMUSh1NFYda
        c6kUDz6mvMsQ+aE9g7PYZc51DRT1JCkNS1U9p8xuEqq2uJ10gaRoXCba52CfeQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1663758525;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=R6IdUAA72JC+9QspugHblhVYOSavYtHKl6EUF8PcDRA=;
        b=Ptexk5Huf90i4Nb2m8z+bxmk5a6KRkm/+2beKQhaZIiw7ldCWVoDUKDT3VM9yQHxwK5SgZ
        KQLs/B+Ft3GVUjCA==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/paravirt] x86/paravirt: Ensure proper alignment
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Borislav Petkov <bp@suse.de>, Juergen Gross <jgross@suse.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20220915111142.992398801@infradead.org>
References: <20220915111142.992398801@infradead.org>
MIME-Version: 1.0
Message-ID: <166375852413.401.16417392487442437882.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/paravirt branch of tip:

Commit-ID:     f92ff8f5dca2acfa475842c71212657b0703c3be
Gitweb:        https://git.kernel.org/tip/f92ff8f5dca2acfa475842c71212657b0703c3be
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Thu, 15 Sep 2022 13:10:40 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 21 Sep 2022 12:30:16 +02:00

x86/paravirt: Ensure proper alignment

The entries in the .parainstructions sections are 8 byte aligned and the
corresponding C struct paravirt_patch_site makes the array offset 16
bytes.

Though the pushed entries are only using 12 bytes, __parainstructions_end
is therefore 4 bytes short.

That works by chance because it's only used in a loop:

     for (p = start; p < end; p++)

But this falls flat when calculating the number of elements:

    n = end - start

That's obviously off by one.

Ensure that the gap is filled and the last entry is occupying 16 bytes.

  [ bp: Add the proper struct and section names. ]

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Juergen Gross <jgross@suse.com>
Link: https://lore.kernel.org/r/20220915111142.992398801@infradead.org
---
 arch/x86/include/asm/paravirt.h       | 1 +
 arch/x86/include/asm/paravirt_types.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
index 964442b..2a0b8dd 100644
--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -743,6 +743,7 @@ extern void default_banner(void);
 	 word 771b;				\
 	 .byte ptype;				\
 	 .byte 772b-771b;			\
+	 _ASM_ALIGN;				\
 	.popsection
 
 
diff --git a/arch/x86/include/asm/paravirt_types.h b/arch/x86/include/asm/paravirt_types.h
index 89df6c6..27b036a 100644
--- a/arch/x86/include/asm/paravirt_types.h
+++ b/arch/x86/include/asm/paravirt_types.h
@@ -294,6 +294,7 @@ extern struct paravirt_patch_template pv_ops;
 	"  .byte " type "\n"				\
 	"  .byte 772b-771b\n"				\
 	"  .short " clobber "\n"			\
+	_ASM_ALIGN "\n"					\
 	".popsection\n"
 
 /* Generate patchable code, with the default asm parameters. */
