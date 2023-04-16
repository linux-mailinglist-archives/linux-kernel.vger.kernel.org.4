Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3242D6E3616
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 10:37:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230378AbjDPIhB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 04:37:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbjDPIhA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 04:37:00 -0400
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8BFC32D59
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 01:36:58 -0700 (PDT)
Received: (from willy@localhost)
        by mail.home.local (8.17.1/8.17.1/Submit) id 33G8aakP023010;
        Sun, 16 Apr 2023 10:36:36 +0200
Date:   Sun, 16 Apr 2023 10:36:36 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Jingbo Xu <jefflexu@linux.alibaba.com>, tglx@linutronix.de,
        mingo@redhat.com, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [BUG REPORT] arch/x86/include/asm/uaccess_64.h:119: Error: junk
 at end of line
Message-ID: <ZDuzlNOmIT0Gd7fF@1wt.eu>
References: <a9aae568-3046-306c-bd71-92c1fc8eeddc@linux.alibaba.com>
 <20230314102316.GAZBBLFHKqQr9RSeM+@fat_crate.local>
 <ZDrlMfy+OcDjXwvn@1wt.eu>
 <E8CB02C5-E18C-42F6-93D8-2CC7CB4CB3FF@alien8.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E8CB02C5-E18C-42F6-93D8-2CC7CB4CB3FF@alien8.de>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris,

On Sat, Apr 15, 2023 at 08:56:47PM +0200, Borislav Petkov wrote:
> On April 15, 2023 7:56:01 PM GMT+02:00, Willy Tarreau <w@1wt.eu> wrote:
> >May I send you a cleaner patch for this ?
> 
> Can you pls first send a minimal reproducer so that we can show it to gcc folks?

Oh it's not even gcc, it's really just a matter of compatibility with
binutils. Documentation/Changes says binutils minimum is 2.25. This
toolchain I'm using in distcc was made against 2.27, I'm reproducing
the error with it:

  $ cat repro.s
  .4byte (1U)
  .4byte (1UL)

  $ /f/tc/x86_64-gcc75_glibc228-linux-gnu/bin/x86_64-gcc75_glibc228-linux-gnu-ld -v     
  GNU ld (crosstool-NG 1.24.0.500_645889f) 2.27
  $ /f/tc/x86_64-gcc75_glibc228-linux-gnu/bin/x86_64-gcc75_glibc228-linux-gnu-as repro.s
  repro.s: Assembler messages:
  repro.s:2: Error: found 'L', expected: ')'
  repro.s:2: Error: junk at end of line, first unrecognized character is `L'

This other one relying on 2.26 fails both on 1U and 1UL:

  $ ld -v
  GNU ld version 2.26.20160125
  $ as repro.s
  repro.s: Assembler messages:
  repro.s:1: Error: missing ')'
  repro.s:1: Error: junk at end of line, first unrecognized character is `U'
  repro.s:2: Error: missing ')'
  repro.s:2: Error: junk at end of line, first unrecognized character is `U'

And this one based on 2.29 works for both:

  $ /dev/shm/gcc-5.5.0-nolibc/x86_64-linux/bin/x86_64-linux-ld -v
  GNU ld (GNU Binutils) 2.29.1.20170915
  $ /dev/shm/gcc-5.5.0-nolibc/x86_64-linux/bin/x86_64-linux-as repro.s

So it just means that the support for the "U" suffix on numbers was
added in binutils 2.27 and the "L" suffix on numbers was added somewhere
between 2.27 and 2.29.

And given that there's a single occurrence of all this in the whole tree,
that's why I'm proposing to just get back to the good old (1 << 0) instead
of BIT(0).

Thanks!
Willy
