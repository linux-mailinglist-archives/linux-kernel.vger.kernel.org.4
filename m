Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8D745E6029
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 12:47:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229909AbiIVKrz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 06:47:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiIVKrx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 06:47:53 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07FCFCC8F8
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 03:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=2kibY8Nweftx04FK9m7D/xvB+s41KyG8kSahRJmzDQY=; b=jCtnGGAc5yEixTV4V7CKVVFf4z
        p7PDW+oF3EFFQBk1Wuq0fLwjqzvbK0J4DYUW3Z10xUoKpUkkAVTQ4MOdDXUuOe0QI3fVVqIJ9O9sm
        BoO/N/T7wPulTLsSDJQ8+obKeuzj1D4sSNtw4YqX8yWDzXMpmSGJImzz6tRR7uHtBC01r/fHA1Dgp
        QBrJAdIaJcywC45PYPIfcPL3LckK0hQG1kdldxB5LHECyBMyAISaro5gtzK/g32Tjq3Z3eW+OAtN9
        ugcW7SQqRFnP6+LW/v7EP5kfGbbehRJy7TkfiuE5Aac+Xbt3IkNGiHUC499ucX3Ur0sU7OkIcrXec
        Bd77sb/A==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1obJjr-00EwKr-EN; Thu, 22 Sep 2022 10:47:27 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 72F93300074;
        Thu, 22 Sep 2022 12:47:26 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 53FE92BB9BA7A; Thu, 22 Sep 2022 12:47:26 +0200 (CEST)
Date:   Thu, 22 Sep 2022 12:47:26 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        x86@kernel.org, Linus Torvalds <torvalds@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>,
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
Subject: Re: [PATCH v3 32/59] objtool: Allow STT_NOTYPE -> STT_FUNC+0
 tail-calls
Message-ID: <Yyw9Pvo7/7YWoKds@hirez.programming.kicks-ass.net>
References: <20220915111039.092790446@infradead.org>
 <20220915111146.224130589@infradead.org>
 <20220922052750.wux3iykp2pfzi75k@desk>
 <Yyw5JqLtiXcqid3K@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yyw5JqLtiXcqid3K@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 22, 2022 at 12:29:58PM +0200, Peter Zijlstra wrote:
> I managed to reproduce with 12.2.0 -- my 12.1.0 compiler didn't
> reproduce.
> 
> $ ./scripts/objdump-func vmlinux.o ftrace_replace_code

> 0000 0000000000012a83 <ftrace_replace_code.cold>:
> 0000    12a83:	48 89 de             	mov    %rbx,%rsi
> 0003    12a86:	89 c7                	mov    %eax,%edi
> 0005    12a88:	5b                   	pop    %rbx
> 0006    12a89:	5d                   	pop    %rbp
> 0007    12a8a:	41 5c                	pop    %r12
> 0009    12a8c:	41 5d                	pop    %r13
> 000b    12a8e:	41 5e                	pop    %r14
> 000d    12a90:	e9 62 fd ff ff       	jmp    127f7 <ftrace_bug>
> 
> 
> Seems to suggest objtool is actually right; I cannot find a reference to
> that cold symbol.

Ohhhh, ftrace_replace_cold is a weak function, so it could be the
original weak symbol had a reference to the cold thing.

We have some code to deal with crap like that, lemme try and figure out
what went wrong.
