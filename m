Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 949F772F8E1
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 11:18:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243928AbjFNJSS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 05:18:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243925AbjFNJSA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 05:18:00 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB7211FD2;
        Wed, 14 Jun 2023 02:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=6/QGPhD9pS4hznW7Cj0df209+j0Esgdq+5bHbabIU64=; b=DC4rzTkM2ERgFddKMIkzrpqyiJ
        QgKZJkUDLcUTWeFAghzUOHwJylznH5a2xO8XAOrPIXfBoaTsK3Yb7RnJpUeg+1+0DzApxCnOdtLGi
        IShe5ELZqPTX6tDJMP7zdFmkHNO3kjCgGmrETDuF/Ih1y4fPXEAtUxgHEpGz4R9/FMwH3ETs4UCUl
        ydAWLy2rjiKBUDURaZRb+dOlVXZdrlvygoHYPaH/IzjQ8MG0TVdHKpYxn2NHcs+EZv78gRqtgjsNh
        26EanVjhHwBQqbHxguApHXpTO09zYNeQJ+72dHBwVigDgMbNFxCO3Kpq7/2Hkl3uxnu37CXi26qqd
        nZyUi0vw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1q9MdU-0062Nx-3m; Wed, 14 Jun 2023 09:17:52 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 961F63002A9;
        Wed, 14 Jun 2023 11:17:51 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 777222C676971; Wed, 14 Jun 2023 11:17:51 +0200 (CEST)
Date:   Wed, 14 Jun 2023 11:17:51 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Omar Sandoval <osandov@osandov.com>
Cc:     Josh Poimboeuf <jpoimboe@kernel.org>, linux-kernel@vger.kernel.org,
        linux-debuggers@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v2] x86/unwind/orc: add ELF section with ORC version
 identifier
Message-ID: <20230614091751.GE1639749@hirez.programming.kicks-ass.net>
References: <aef9c8dc43915b886a8c48509a12ec1b006ca1ca.1686690801.git.osandov@osandov.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aef9c8dc43915b886a8c48509a12ec1b006ca1ca.1686690801.git.osandov@osandov.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 13, 2023 at 02:14:56PM -0700, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
> 
> Commits ffb1b4a41016 ("x86/unwind/orc: Add 'signal' field to ORC
> metadata") and fb799447ae29 ("x86,objtool: Split UNWIND_HINT_EMPTY in
> two") changed the ORC format. Although ORC is internal to the kernel,
> it's the only way for external tools to get reliable kernel stack traces
> on x86-64. In particular, the drgn debugger [1] uses ORC for stack
> unwinding, and these format changes broke it [2]. As the drgn
> maintainer, I don't care how often or how much the kernel changes the
> ORC format as long as I have a way to detect the change.
> 
> It suffices to store a version identifier in the vmlinux and kernel
> module ELF files (to use when parsing ORC sections from ELF), and in
> kernel memory (to use when parsing ORC from a core dump+symbol table).
> Rather than hard-coding a version number that needs to be manually
> bumped, Peterz suggested hashing the definitions from orc_types.h. If
> there is a format change that isn't caught by this, the hashing script
> can be updated.
> 
> This patch adds an .orc_header allocated ELF section containing the
> 20-byte hash to vmlinux and kernel modules, along with the corresponding
> __start_orc_header and __stop_orc_header symbols in vmlinux.
> 
> 1: https://github.com/osandov/drgn
> 2: https://github.com/osandov/drgn/issues/303
> 
> Signed-off-by: Omar Sandoval <osandov@fb.com>

Patch looks good to me; as a follow up I suppose we could verify the orc
hash on module load, to ensure the module and main kernel agree on the
ORC version used -- but we can do that later.

> ---
> Hi,
> 
> This is v2 of my patch to make it possible for external tools like drgn
> to identify versions of the ORC format. As stated in v1 [1], I don't
> want ORC to be stable ABI; I just need a way to identify the format
> being used.
> 
> This version incorporates Peter's suggestion to hash the ORC definitions
> instead of requiring a manual version number; this is easier to maintain
> and more resilient to backports.
> 
> I would love to get this in before 6.4 is released, and then hopefully
> backport it to 6.3-stable.

So we're fairly late in the cycle and it would need justification to go
into objtool/urgent -- preferably only fixes at this point.

But given we 'broke' the ORC layout this cycle, we can mark this with
Fixes: for the two mentioned commits.

Josh?
