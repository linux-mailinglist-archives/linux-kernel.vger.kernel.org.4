Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5CD96E3301
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Apr 2023 19:58:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230142AbjDOR4k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Apr 2023 13:56:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229967AbjDOR4j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Apr 2023 13:56:39 -0400
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AC6C82D7E
        for <linux-kernel@vger.kernel.org>; Sat, 15 Apr 2023 10:56:37 -0700 (PDT)
Received: (from willy@localhost)
        by mail.home.local (8.17.1/8.17.1/Submit) id 33FHu1vT020633;
        Sat, 15 Apr 2023 19:56:01 +0200
Date:   Sat, 15 Apr 2023 19:56:01 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Jingbo Xu <jefflexu@linux.alibaba.com>, tglx@linutronix.de,
        mingo@redhat.com, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [BUG REPORT] arch/x86/include/asm/uaccess_64.h:119: Error: junk
 at end of line
Message-ID: <ZDrlMfy+OcDjXwvn@1wt.eu>
References: <a9aae568-3046-306c-bd71-92c1fc8eeddc@linux.alibaba.com>
 <20230314102316.GAZBBLFHKqQr9RSeM+@fat_crate.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230314102316.GAZBBLFHKqQr9RSeM+@fat_crate.local>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris!

On Tue, Mar 14, 2023 at 11:23:16AM +0100, Borislav Petkov wrote:
> On Tue, Mar 14, 2023 at 11:12:13AM +0800, Jingbo Xu wrote:
> > 	gcc (GCC) 6.5.1 20181026 (Alibaba 6.5.1-1)
> 
> Looks like you should complain to whoever patched this gcc and broke it
> in the process. Unless you can reproduce the issue with an official
> compiler...

I got the exact same issue today when building over distcc using locally-
built gcc-7.5 and gcc-6.5 here, though the one from kernel.org/crosstool
didn't have the problem. The only difference I found is the binutils that
the asm comes from. Mine rely on 2.27 while the one from kernel.org is on
2.32.

I produced the .s file then tried to build it and compared. Both .s files
are identical, and only one asm (2.32) assembles it fine. The error is
triggered here:

663:
.pushsection .altinstructions,"a"
 .long 661b - .
 .long 6641f - .
 .4byte ((((((1UL))) << (0)) << 16) | ((18*32+ 4)))
                ^
This is the "L" the asm complains about. If I change it to "1U" it's
happy. Indeed, the difference is here in the introduction of the BIT()
macro in the definition of ALT_FLAG_NOT in your commit 5d1dd961e743
("x86/alternatives: Add alt_instr.flags") merged into 6.3-rc1:

  -#define ALTINSTR_FLAG_INV      (1 << 15)
  -#define ALT_NOT(feat)          ((feat) | ALTINSTR_FLAG_INV)
  +#define ALT_FLAGS_SHIFT                16
  +
  +#define ALT_FLAG_NOT           BIT(0)
  +#define ALT_NOT(feature)       ((ALT_FLAG_NOT << ALT_FLAGS_SHIFT) | (feature))

And I can confirm that the following patch fixes it for me, now the kernel
builds fine:

diff --git a/arch/x86/include/asm/alternative.h b/arch/x86/include/asm/alternative.h
index e2975a32d443..d7da28fada87 100644
--- a/arch/x86/include/asm/alternative.h
+++ b/arch/x86/include/asm/alternative.h
@@ -8,7 +8,7 @@
 
 #define ALT_FLAGS_SHIFT                16
 
-#define ALT_FLAG_NOT           BIT(0)
+#define ALT_FLAG_NOT           (1 << 0)
 #define ALT_NOT(feature)       ((ALT_FLAG_NOT << ALT_FLAGS_SHIFT) | (feature))
 
 #ifndef __ASSEMBLY__

May I send you a cleaner patch for this ?

Thanks!
Willy
