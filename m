Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C46E68F88C
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 21:01:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231852AbjBHUBk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 15:01:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231685AbjBHUBi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 15:01:38 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0757E30E9D
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 12:01:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=jZpjgI7oR1GmkqaZBmQz0lN2Ldys8lYvjTRh92ABKU0=; b=u+esxRDShQXZp58IG3NZFhEt6Y
        GVCLEz0HOB/QRSbgbbJPKdKhboEKqtS2ILrXUX4mr/F5gttfbRBCCejui1Y67aMktsUSVOMtOOrya
        J6/LaCwOkKowpJQ8TBCCHC9qBwtoZlbW2TNq3iKC/G8nFNbSTrBVWE5s7EwV7AaSOIg5A6O/BWHsl
        JHDrod4TCg229iuZVycCn7CD2rdwt0OQEnBS1VWDcj98NDJBOLid8aelJdz2ytkLZnVh2bZMNhleW
        XtcefAsHBPE172P/Bwd4wYnpdXwGCOLvSwHNtTsCfMBlxycdVcv9ghmzanrYG1KQBcyke5bDB/69k
        sx5anZtg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pPqd6-001VZo-Pk; Wed, 08 Feb 2023 20:01:21 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 65DDA3001CB;
        Wed,  8 Feb 2023 21:01:19 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 522C920F194A5; Wed,  8 Feb 2023 21:01:19 +0100 (CET)
Date:   Wed, 8 Feb 2023 21:01:19 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Nadav Amit <nadav.amit@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Nadav Amit <namit@vmware.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH v2] x86/kprobes: Fix 1 byte conditional jump target
Message-ID: <Y+P/j0FiocmavHTL@hirez.programming.kicks-ass.net>
References: <20230208071708.4048-1-namit@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230208071708.4048-1-namit@vmware.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 08, 2023 at 07:17:08AM +0000, Nadav Amit wrote:
> From: Nadav Amit <namit@vmware.com>
> 
> Commit 3bc753c06dd0 ("kbuild: treat char as always unsigned") broke
> kprobes.  Setting a probe-point on 1 byte conditional jump can cause the
> kernel to crash, as the branch target is not sign-extended and instead
> zero-extended.
> 
> In fact, there is no need for any casting of immediate.value since sign
> extension is already done during its decoding in insn_get_immediate().
> 
> Fix by removing the casting of the 1 byte conditional jump target.
> Future patches can also remove the casting (and sign extension) in other
> cases in which immediate.value is being used.
> 
> Fixes: 3bc753c06dd0 ("kbuild: treat char as always unsigned")
> Suggested-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> Suggested-by: Dave Hansen <dave.hansen@intel.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Nadav Amit <namit@vmware.com>

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
