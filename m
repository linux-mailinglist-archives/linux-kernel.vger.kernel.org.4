Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4556B69921B
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 11:47:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229578AbjBPKrV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 05:47:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjBPKrT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 05:47:19 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18B5F4740F
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 02:46:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=/SzWoosYRHKbKunQA747KopGX7NLQb7jLpvnmhwYHXA=; b=HJwit70ypbZf6r56fYzf/1752W
        YMpfD/1G060/CXXixliIehuwPwIRQNRmFUKhqSQ339UaUSiSUWRlmi391Qy85B+WC0YrUevGwxPhn
        7iuZhGVMUEQ36PP4+Rsl9ONklkHZDCoTx031u+B/j7TWl0formtkZPA/q63Kyzhe9gnigSOgVwHo6
        i4EOO+s1fkuZlCN205BrcNsVGC5iSNoq0ncGBCDtXCVgIUdCUgeXfTQicH8fQc/U1umgRGkJk/Obw
        1PgQp/58LooO80GXj2hBZV+9HmIsrFswDVL1UtxjtPUetcm0IkoZnj+YPuBAyEitIh6tKqaxwY/qQ
        xUmlHxpw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pSbmd-008LJy-KZ; Thu, 16 Feb 2023 10:46:36 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 81CD830056B;
        Thu, 16 Feb 2023 11:46:30 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C521F206B4D30; Thu, 16 Feb 2023 11:46:30 +0100 (CET)
Date:   Thu, 16 Feb 2023 11:46:30 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Chen Zhongjin <chenzhongjin@huawei.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH 2/2] x86/entry: Fix unwinding from kprobe on PUSH/POP
 instruction
Message-ID: <Y+4JhmEGDR16EVpi@hirez.programming.kicks-ass.net>
References: <cover.1676068346.git.jpoimboe@kernel.org>
 <baafcd3cc1abb14cb757fe081fa696012a5265ee.1676068346.git.jpoimboe@kernel.org>
 <20230213234357.1fe194b2767d9bc431202d4c@kernel.org>
 <Y+tx6DZyoQ362lUM@hirez.programming.kicks-ass.net>
 <20230214170552.glhdytvunczyxxao@treble>
 <Y+yzMmL7gUprDru3@hirez.programming.kicks-ass.net>
 <20230215231637.laryjsua5p4wcd57@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230215231637.laryjsua5p4wcd57@treble>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 15, 2023 at 03:16:37PM -0800, Josh Poimboeuf wrote:
> On Wed, Feb 15, 2023 at 11:25:54AM +0100, Peter Zijlstra wrote:

> > Well, I was specifically thinking about #DB, why don't we need to
> > decrement when we put a hardware breakpoint on a stack modifying op?
> 
> I assume you mean the INT1 instruction.  Yeah, maybe we should care
> about that.

Nah, I was thinking #DB from DR7, but ...

> I'm struggling to come up with any decent ideas about how to implement
> that.  Presumably the #DB handler would have to communicate to the
> unwinder somehow whether the given frame is a trap.

... I had forgotten that #DB is not unconditionally trap :/ The worst
part seems to be that code breakpoints are faults while data breakpoints
are traps.

And you so don't want to go decode the DR registers in the unwinder,
quality mess this :/

Put a breakpoint on the stack and you've got PUSH doing a trap, put a
breakpoint on the PUSH instruction and you get a fault, and lo and
behold, you get a different unwind :-(
