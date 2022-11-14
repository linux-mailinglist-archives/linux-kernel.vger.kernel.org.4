Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DC026286D1
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 18:19:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237675AbiKNRSq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 12:18:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238019AbiKNRSi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 12:18:38 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CB876451
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 09:18:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ql613pbqTJT9TiI9Y2fFhHM6ApdTv4v7ssNkZGKmx7k=; b=mVyMtD0qreFfnVJJNe177jMyrf
        roJacqoyrbLTVaD2OTqtG7KGkwNfLVE437ccLGJmD4pxkJrBFLKYWucHxDYrSfM3uSXEtEw/gH6vg
        3UeUr0CEhbounBXTJxVTkyL8CrKrXaNJspxi16nRuIYNkFHIoHnkliI7lZAgQXcQB6wSFMs5eT2ul
        f0lwGeEAPxZtqB9AUS/J+5XzRoojeLooBION5nP43v3i8e7rbivMy+jpWHDwWRQiYYZ7jMo3ict6l
        Va+ABfrmTxWPXhVC3/4V1Y7VSDjWjpBfjrHVBjoQoRkQcT2byd3Ez3rde9M8qAID+E1RokzEKPlIm
        eJXX4YzA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oud6N-00FaHh-QL; Mon, 14 Nov 2022 17:18:32 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 6DFE0300422;
        Mon, 14 Nov 2022 16:23:45 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5207822361755; Mon, 14 Nov 2022 16:23:45 +0100 (CET)
Date:   Mon, 14 Nov 2022 16:23:45 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     kernel test robot <lkp@intel.com>,
        Kees Cook <keescook@chromium.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: [PATCH] lkdtm: Avoid objtool/ibt warning
Message-ID: <Y3JdgbXRV0MNZ+9h@hirez.programming.kicks-ass.net>
References: <202211142027.0E3ISIZr-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202211142027.0E3ISIZr-lkp@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 14, 2022 at 08:26:17PM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   094226ad94f471a9f19e8f8e7140a09c2625abaa
> commit: 656d054e0a15ec327bd82801ccd58201e59f6896 jump_label,noinstr: Avoid instrumentation for JUMP_LABEL=n builds
> date:   6 months ago
> config: x86_64-buildonly-randconfig-r001-20221114
> compiler: gcc-11 (Debian 11.3.0-8) 11.3.0
> reproduce (this is a W=1 build):
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=656d054e0a15ec327bd82801ccd58201e59f6896
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout 656d054e0a15ec327bd82801ccd58201e59f6896
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash


> >> vmlinux.o: warning: objtool: lkdtm_UNSET_SMEP+0x1c3: relocation to !ENDBR: native_write_cr4+0x41

---
Subject: lkdtm: Avoid objtool/ibt warning
From: Peter Zijlstra <peterz@infradead.org>
Date: Mon Nov 14 16:17:50 CET 2022

For certain configs objtool will complain like:

  vmlinux.o: warning: objtool: lkdtm_UNSET_SMEP+0x1c3: relocation to !ENDBR: native_write_cr4+0x41

What happens is that GCC optimizes the loop:

	insn = (unsigned char *)native_write_cr4;
	for (i = 0; i < MOV_CR4_DEPTH; i++)

to read something like:

	for (insn = (unsigned char *)native_write_cr4;
	     insn < (unsigned char *)native_write_cr4 + MOV_CR4_DEPTH;
	     insn++)

Which then obviously generates the text reference
native_write_cr4+041. Since none of this is a fast path, simply
confuse GCC enough to inhibit this optimization.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 drivers/misc/lkdtm/bugs.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/misc/lkdtm/bugs.c
+++ b/drivers/misc/lkdtm/bugs.c
@@ -487,6 +487,7 @@ static void lkdtm_UNSET_SMEP(void)
 	 * the cr4 writing instruction.
 	 */
 	insn = (unsigned char *)native_write_cr4;
+	OPTIMIZER_HIDE_VAR(insn);
 	for (i = 0; i < MOV_CR4_DEPTH; i++) {
 		/* mov %rdi, %cr4 */
 		if (insn[i] == 0x0f && insn[i+1] == 0x22 && insn[i+2] == 0xe7)
