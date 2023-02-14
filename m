Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BDCB696AC4
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 18:06:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231833AbjBNRGB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 12:06:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231351AbjBNRF6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 12:05:58 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A3E810FF
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 09:05:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1153EB81E26
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 17:05:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A391C433EF;
        Tue, 14 Feb 2023 17:05:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676394354;
        bh=BRKMqKGtfotLoWSzmiIU7CxG6DtW1Qk0Qa2LcFX/ovY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qNRE09ww5bKN8AqBFVMsYVJs6q/R/ISyDe32juo2bWEflbr98UjCxI4MBRbcmDjSs
         d/Pi4NCWcQ7ZPDaqWFE+q/QJlhlz2WoVbGmCLuYMHnVpAfDPZBA/UIQ7r3IW62sB8N
         YBzWXH/243M9BUNY6xHZcBHbp4FQeVCEpf+ZF/igLFRWblGeneNws463Mw7xET+PqN
         6RoWApGJ/JbQMPCDb4YXSTCOKygyY1TNoOPnRt7VxwZariNsznIqCuF5s475TX6ZhS
         nF/m38vGgl/y63v/DMGI4dhsgGwV90vzAOfbFFf6MuS2vE4Xby3Eno0yTtrh6gG7jr
         e1RikIjyXrSmg==
Date:   Tue, 14 Feb 2023 09:05:52 -0800
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Chen Zhongjin <chenzhongjin@huawei.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH 2/2] x86/entry: Fix unwinding from kprobe on PUSH/POP
 instruction
Message-ID: <20230214170552.glhdytvunczyxxao@treble>
References: <cover.1676068346.git.jpoimboe@kernel.org>
 <baafcd3cc1abb14cb757fe081fa696012a5265ee.1676068346.git.jpoimboe@kernel.org>
 <20230213234357.1fe194b2767d9bc431202d4c@kernel.org>
 <Y+tx6DZyoQ362lUM@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y+tx6DZyoQ362lUM@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 14, 2023 at 12:35:04PM +0100, Peter Zijlstra wrote:
> On Mon, Feb 13, 2023 at 11:43:57PM +0900, Masami Hiramatsu wrote:
> 
> > > Fix it by annotating the #BP exception as a non-signal stack frame,
> > > which tells the ORC unwinder to decrement the instruction pointer before
> > > looking up the corresponding ORC entry.
> > 
> > Just to make it clear, this sounds like a 'hack' use of non-signal stack
> > frame. If so, can we change the flag name as 'literal' or 'non-literal' etc?
> > I concern that the 'signal' flag is used differently in the future.

Agreed, though I'm having trouble coming up with a succinct yet
scrutable name.  If length wasn't an issue it would be something like

  "decrement_return_address_when_looking_up_the_next_orc_entry"

> Oooh, bike-shed :-) Let me suggest trap=1, where a trap is a fault with
> a different return address, specifically the instruction after the
> faulting instruction.

I think "trap" doesn't work because

 1) It's more than just traps, it's also function calls.  We have
    traps/calls in one bucket (decrement IP); and everything else
    (faults, aborts, irqs) in the other (don't decrement IP).

 2) It's not necessarily all traps which need the flag, just those that
    affect a previously-but-now-overwritten stack-modifying instruction.
    So #OF (which we don't use?) and trap-class #DB don't seem to be
    affected.  In practice maybe this distinction doesn't matter, but
    for example there's no reason for ORC try to distinguish trap #DB
    from non-trap #DB at runtime.

-- 
Josh
