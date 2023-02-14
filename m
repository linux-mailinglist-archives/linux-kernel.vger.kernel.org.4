Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 931EA69693D
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 17:22:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231726AbjBNQWQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 11:22:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbjBNQWP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 11:22:15 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A84DC5
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 08:22:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=HWzFNmmtoO5OOmwSNQ2pBySNgIBtzs2V1I8xDnvrLP0=; b=NYS0uOxTypVyPmd3YD8gzZB50S
        7ir2htoXGHr28//8y3cnQnTJnK5k8tEmCkDRwwhzV7ENUadlymcQShnZm2oXcWw/WeA4zYWqkV1VS
        pRy+5uYkNbb76pg+zNyFW8DceoS9ZCtQ45574bcGtx0mRbr0trmpin8r33nMAyCnBuFpPXKpmHbog
        YJjf0IJqS1OJo2LCiZkHs2GRWsOw0cPjuaQXtc8hg6xBV9BZp17kVctHfwsTRB5a52jrzx6VVkVa4
        E6opNiKc+czId+EEmogWZlt3dHY9AqvDd2aY366b+r+xEqG/2g/75EfGP90R5UDz5aCIB8EVJdM+S
        CTe7/Nnw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pRy3G-009gSv-0d;
        Tue, 14 Feb 2023 16:21:50 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 55DF9300CC0;
        Tue, 14 Feb 2023 12:35:05 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id F328220B4E943; Tue, 14 Feb 2023 12:35:04 +0100 (CET)
Date:   Tue, 14 Feb 2023 12:35:04 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Chen Zhongjin <chenzhongjin@huawei.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH 2/2] x86/entry: Fix unwinding from kprobe on PUSH/POP
 instruction
Message-ID: <Y+tx6DZyoQ362lUM@hirez.programming.kicks-ass.net>
References: <cover.1676068346.git.jpoimboe@kernel.org>
 <baafcd3cc1abb14cb757fe081fa696012a5265ee.1676068346.git.jpoimboe@kernel.org>
 <20230213234357.1fe194b2767d9bc431202d4c@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230213234357.1fe194b2767d9bc431202d4c@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 13, 2023 at 11:43:57PM +0900, Masami Hiramatsu wrote:

> > Fix it by annotating the #BP exception as a non-signal stack frame,
> > which tells the ORC unwinder to decrement the instruction pointer before
> > looking up the corresponding ORC entry.
> 
> Just to make it clear, this sounds like a 'hack' use of non-signal stack
> frame. If so, can we change the flag name as 'literal' or 'non-literal' etc?
> I concern that the 'signal' flag is used differently in the future.

Oooh, bike-shed :-) Let me suggest trap=1, where a trap is a fault with
a different return address, specifically the instruction after the
faulting instruction.
