Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8E555B61D3
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 21:44:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbiILToq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 15:44:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbiILTon (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 15:44:43 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0199A6304
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 12:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=nb8rEReRfkZDeENxQWTBlPf4FsiI6l6ZHGQyc4I5xZw=; b=dtMXvc014H+jCYo65RYLLNId2n
        r5Ma3pCGbi5brY/StaScrqieuibtjIBPu6NPWz6gz5VRtvTt3pcWvbLLIFdMml226t9xwJUqwxHHV
        Wq5akLA8yAhXUu4zpqNSfIxDAj87dxCUDckf6W8gj5xDKychTkqErcALWgzGyTOckWm9UYRviIh4b
        3Iz0uldIittkaUx0P8AQPsGPYvSQybEOscBjrGW7c/xGBks5mYTwTmG1tcWZAy+Vtg9P/L0CLTr5H
        CYwVoMWoSLkPk4Cwoxf7lJ+O2Iil6XPk7+qYK7jOMbhc6u00CKFEKgeqnXKJw4pzOnbQ09I0CXAgr
        mF5eWTmw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oXpLj-00GDdx-V3; Mon, 12 Sep 2022 19:44:08 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8026A980269; Mon, 12 Sep 2022 21:44:05 +0200 (CEST)
Date:   Mon, 12 Sep 2022 21:44:05 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        x86@kernel.org, Tim Chen <tim.c.chen@linux.intel.com>,
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
Subject: Re: [PATCH v2 08/59] x86/build: Ensure proper function alignment
Message-ID: <Yx+MBXvGLhbd7dHH@worktop.programming.kicks-ass.net>
References: <20220902130625.217071627@infradead.org>
 <20220902130947.190618587@infradead.org>
 <CAHk-=whdvPcHmH5eG+FUrbQw1e-05n__EWobMqbxcCTP7dtZAg@mail.gmail.com>
 <YxI+K8Y+f/FHSQCU@hirez.programming.kicks-ass.net>
 <CAHk-=wjRLehUO=u8HDJGRFv+wz7hakSc=z6eTg547pAmb0UKHg@mail.gmail.com>
 <YxXJswK9QjhCGmPN@hirez.programming.kicks-ass.net>
 <CAHk-=whRetwx+5Bjiee+T+Nyyi8EiZ17SM3AL8jJnXuA+WjQyQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whRetwx+5Bjiee+T+Nyyi8EiZ17SM3AL8jJnXuA+WjQyQ@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 12, 2022 at 10:09:38AM -0400, Linus Torvalds wrote:

> The patch looks sane, the only thing I worry a bit about is
> 
> > +config FUNCTION_ALIGNMENT
> > +       int
> > +       default 64 if FUNCTION_ALIGNMENT_64B
> ..
> > +       default 0
> 
> Is '0' even a valid value then for things like

At the time I thought to have read that 0 alignment effectively no-ops
the statement, but now I can't find it in a hurry, happy to make it
default to 4.

