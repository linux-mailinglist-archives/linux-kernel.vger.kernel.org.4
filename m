Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F25D749622
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 09:17:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233455AbjGFHRW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 03:17:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230115AbjGFHRU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 03:17:20 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74685DA;
        Thu,  6 Jul 2023 00:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=/N9m/RBB0QGzQkwDbP4GCT1KFtzjUK9VRs7KqannIP8=; b=g08gj94rfjIcMPuK9eTk2813+K
        betHSkguZs0j12mlpX1Rp4T1YyhlvNTbG1w/l/DpFwXi8mi3SNOE1eeQOS7rc7os5rWYDn4Hi2c5+
        4o9R4kwphxjXXNYCKHiBkXn8qzx5/IJSA7V/53gyA6OFVmUB81d1tOoJN5fL24DP4Z223ZZXB0QIe
        FtQQ2uyZ/UiwfYdcwxerKkD0ghL25mnPsyXSl/JIOu7VsMhnFSMq6cvkjcqyiA1/OOknowqHwwff8
        /rjnfplFww/6dSiqIYJKEi9ui0H3tYaC7qllRJGv248B0KG+iqHOWDone0ApVVfFUKfj7p5DJus9R
        UoC6WClg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qHJEh-00Aq7c-75; Thu, 06 Jul 2023 07:17:07 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 1272B300222;
        Thu,  6 Jul 2023 09:17:06 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id EBB7F2007F070; Thu,  6 Jul 2023 09:17:05 +0200 (CEST)
Date:   Thu, 6 Jul 2023 09:17:05 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Petr Pavlu <petr.pavlu@suse.com>, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, samitolvanen@google.com, x86@kernel.org,
        linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] x86/retpoline,kprobes: Avoid treating rethunk as an
 indirect jump
Message-ID: <20230706071705.GD2833176@hirez.programming.kicks-ass.net>
References: <20230705081547.25130-1-petr.pavlu@suse.com>
 <20230705081547.25130-3-petr.pavlu@suse.com>
 <20230705085857.GG462772@hirez.programming.kicks-ass.net>
 <20230705232038.3a6d03e18f7bafb14cdfed42@kernel.org>
 <20230705145017.GC4253@hirez.programming.kicks-ass.net>
 <20230706094723.6934105e03f652923796bf7e@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230706094723.6934105e03f652923796bf7e@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 06, 2023 at 09:47:23AM +0900, Masami Hiramatsu wrote:

> > > If I understand correctly, all indirect jump will be replaced with JMP_NOSPEC.
> > > If you read the insn_jump_into_range, I onlu jecks the jump code, not call.
> > > So the functions only have indirect call still allow optprobe.
> > 
> > With the introduction of kCFI JMP_NOSPEC is no longer an equivalent to a
> > C indirect jump.
> 
> If I understand correctly, kCFI is enabled by CFI_CLANG, and clang is not
> using jump-tables by default, so we can focus on gcc. In that case
> current check still work, correct?

IIRC clang can use jump tables, but like GCC needs RETPOLINE=n and
IBT=n, so effectively nobody has them.

The reason I did mention kCFI though is that kCFI has a larger 'indirect
jump' sequence, and I'm not sure we've thought about what can go
sideways if that's optprobed.

I suspect the UD2 that's in there will go 'funny' if it's relocated into
an optprobe, as in, it'll not be recognised as a CFI fail.
