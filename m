Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 267885B6933
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 10:09:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231348AbiIMIJU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 04:09:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230521AbiIMIJS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 04:09:18 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 104FD5A82F
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 01:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=G4K0VJQumircKHw/dO+AhQJVTW8SIk4Eb+pSObyC7wY=; b=XnxfubmhzAX1jY2QhYQzvcdOIW
        zuxHv1GLKIZ5jlrGE1O71Ynm6mJBQpfqL6A1ylMRcdVIttdQZnsa6iky4dn47YPf3KNiF6OX5nNf4
        FlgKDZUtYYhwkCNdm1ncHs26r+47cN5nH571DhDPXzpRuA7pYBvfNDbL4LEx+ro0Z5pNLhdqSdook
        aB91qBKQd/bJsvzW1otIzEnoQkzT+Y9usqMA8uZFWk726R3Teu5LhXJWqq932W7zRkVK0/JiP+AqJ
        sU8lAPQwi4lyfvXQxxAVMKSSQeTmJhHfctxaiQaLwLmFEfKPKPi5KJtrX7GBXnZ9469B4nSTUFXOU
        Pyl+xAqQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oY0yF-00C1b8-Na; Tue, 13 Sep 2022 08:08:39 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 296A230030F;
        Tue, 13 Sep 2022 10:08:36 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E0353206F9F7C; Tue, 13 Sep 2022 10:08:35 +0200 (CEST)
Date:   Tue, 13 Sep 2022 10:08:35 +0200
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
Message-ID: <YyA6gwtAKRwmJR53@hirez.programming.kicks-ass.net>
References: <20220902130625.217071627@infradead.org>
 <20220902130947.190618587@infradead.org>
 <CAHk-=whdvPcHmH5eG+FUrbQw1e-05n__EWobMqbxcCTP7dtZAg@mail.gmail.com>
 <YxI+K8Y+f/FHSQCU@hirez.programming.kicks-ass.net>
 <CAHk-=wjRLehUO=u8HDJGRFv+wz7hakSc=z6eTg547pAmb0UKHg@mail.gmail.com>
 <YxXJswK9QjhCGmPN@hirez.programming.kicks-ass.net>
 <CAHk-=whRetwx+5Bjiee+T+Nyyi8EiZ17SM3AL8jJnXuA+WjQyQ@mail.gmail.com>
 <Yx+MBXvGLhbd7dHH@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yx+MBXvGLhbd7dHH@worktop.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 12, 2022 at 09:44:05PM +0200, Peter Zijlstra wrote:
> On Mon, Sep 12, 2022 at 10:09:38AM -0400, Linus Torvalds wrote:
> 
> > The patch looks sane, the only thing I worry a bit about is
> > 
> > > +config FUNCTION_ALIGNMENT
> > > +       int
> > > +       default 64 if FUNCTION_ALIGNMENT_64B
> > ..
> > > +       default 0
> > 
> > Is '0' even a valid value then for things like
> 
> At the time I thought to have read that 0 alignment effectively no-ops
> the statement, but now I can't find it in a hurry, happy to make it
> default to 4.

Found it: https://sourceware.org/binutils/docs-2.39/as/Balign.html

7.8 .balign[wl] [abs-expr[, abs-expr[, abs-expr]]]

Pad the location counter (in the current subsection) to a particular
storage boundary. The first expression (which must be absolute) is the
alignment request in bytes. ...  If the expression is omitted then a
default value of 0 is used, effectively disabling alignment
requirements.

(for some raisin google served me a very old binutils document last
night that doesn't have mention the 0 thing)
