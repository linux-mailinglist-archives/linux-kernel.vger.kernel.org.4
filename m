Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA73260747F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 11:54:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229456AbiJUJyR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 05:54:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230488AbiJUJyF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 05:54:05 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 652112582E9
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 02:54:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=R8aE+fUxsekh1JIzAY8ZsHZpAn2ZOjI/KXf7Nvom+7c=; b=gkYmsgDCCJygDYM8W8VySaUn7s
        xP3aFyNNAjNMxtS/KAF0p2XZgEQ5Jd0mmq18Qp1jomav9gPu+atfCuUMkMDfaa+rbK6pJqbXWZzXk
        xaAMR5wmSMfdudbCAVZY9qzim3QXd6RzUVyzQQ0oFD/ciUN37AepShZbQboxpL/3W+wSktKqh5br2
        m1S4fhR+Ukekn2Zjkmc3oqxqbL0+G6uCyxQH/eKuwXqje/Y/+CjjSCFPGvoMQN0P47rr4ousho/Mo
        mDkfYS93P7b3gDd4/dE2GCXejqvxIbDC9QMOaSWUyv8OjfsoRxVt24EUxp/AkAZvebPUAQ/bmwuz4
        /pVF/13g==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oloiJ-00D30Q-M1; Fri, 21 Oct 2022 09:53:15 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 59907300110;
        Fri, 21 Oct 2022 11:53:09 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 327682099A9E9; Fri, 21 Oct 2022 11:53:09 +0200 (CEST)
Date:   Fri, 21 Oct 2022 11:53:09 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        x86@kernel.org, Linus Torvalds <torvalds@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Johannes Wikner <kwikner@ethz.ch>,
        Alyssa Milburn <alyssa.milburn@linux.intel.com>,
        Jann Horn <jannh@google.com>, "H.J. Lu" <hjl.tools@gmail.com>,
        Joao Moreira <joao.moreira@intel.com>,
        Joseph Nuzman <joseph.nuzman@intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Juergen Gross <jgross@suse.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH v3 48/59] x86/retbleed: Add SKL return thunk
Message-ID: <Y1JsBQAhDFB2C0OE@hirez.programming.kicks-ass.net>
References: <20220915111039.092790446@infradead.org>
 <20220915111147.890071690@infradead.org>
 <Y1HVZKW4o0KRsMtq@dev-arch.thelio-3990X>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1HVZKW4o0KRsMtq@dev-arch.thelio-3990X>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 20, 2022 at 04:10:28PM -0700, Nathan Chancellor wrote:
> This commit is now in -next as commit 5d8213864ade ("x86/retbleed: Add
> SKL return thunk"). I just bisected an immediate reboot on my AMD test
> system when starting a virtual machine with QEMU + KVM to it (see the
> bisect log below). My Intel test systems do not show this.
> Unfortunately, I do not have much more information, as there are no logs
> in journalctl, which makes sense as the reboot occurs immediately after
> I hit the enter key for the QEMU command.
> 
> If there is any further information I can provide or patches I can test
> for further debugging, I am more than happy to do so.

Moo :-(

you happen to have a .config for me?
