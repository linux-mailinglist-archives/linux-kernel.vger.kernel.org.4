Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 812F96CD332
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 09:28:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230146AbjC2H2S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 03:28:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230039AbjC2H1Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 03:27:24 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 941D149D8
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 00:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Yy1wkYgvgMDd/vCl3FW915GQ/MczElW/ywdeEhVnOMg=; b=hB7dDv5JGIB2g3oWXu/AUBFBIf
        0CeoTyQcK7CmnPiismEmt678wOXobpFUwZgGYdxryFCZpTEsBVoCkMAsIYVtp2htoJHJAlaWPnJbs
        c4VnqUgjeTOwL8rJL5COJNeWXwx4QY3OMnxkyGL0sjKWBW0QFvN+R/pBHFvZ6vOWHbbsC9Vtmi2hP
        3en9ltL3jlnM3e5Jk5gimLyQU3xeC65VMhhClj+OLNO+sHio5d6ALTfgX/pu9Vf6xk0xlCVse87HR
        6gVg0412DQOY8cQMgvP5KYcklMR7/LTW4RMY+Pxzc0T/iDnR/qNq8HNZJJpss/RS6VrUFEaxt2SEq
        jds79IyA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1phQBu-009CZH-2z; Wed, 29 Mar 2023 07:25:54 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8E6413000E6;
        Wed, 29 Mar 2023 09:25:53 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 72F2C2CC6DE9A; Wed, 29 Mar 2023 09:25:53 +0200 (CEST)
Date:   Wed, 29 Mar 2023 09:25:53 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Miroslav Benes <mbenes@suse.cz>
Subject: Re: [PATCH 2/5] objtool: Combine '--backtrace' with '--verbose'
Message-ID: <20230329072553.GH4253@hirez.programming.kicks-ass.net>
References: <cover.1679932620.git.jpoimboe@kernel.org>
 <ef477e7cf3f188c623279764e831772eab2a4016.1679932620.git.jpoimboe@kernel.org>
 <20230328080743.GC4253@hirez.programming.kicks-ass.net>
 <20230328201921.ccl7p65le5aysa6j@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230328201921.ccl7p65le5aysa6j@treble>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 28, 2023 at 01:19:21PM -0700, Josh Poimboeuf wrote:
> On Tue, Mar 28, 2023 at 10:07:43AM +0200, Peter Zijlstra wrote:
> > On Mon, Mar 27, 2023 at 09:00:45AM -0700, Josh Poimboeuf wrote:
> > > Get rid of the '--backtrace' option, instead including that
> > > functionality in '--verbose'.  This makes it easy to gather all the
> > > information needed for diagnosing objtool warnings.
> > 
> > Hurmm.. can't we have verbose imply backtrace but keep the separate
> > option? I'm not sure if I always want the objdump thing -- esp with
> > multiple warnings on vmlinux that's going to be really slow -- better to
> > dump the whole of vmlinux.o once at the end.
> 
> That's a good point, vmlinux would be unbearable for multiple warnings.
> 
> We could accumulate a list of affected functions and then supply that to
> objdump-func.sh at the end and dump them all at the same time.
> 
> objdump-func.sh would need to be changed to look for multiple funcs at
> once.
> 
> If I do that, do you still want the separate backtrace option?

For now, lets keep the orthogonal options -- we can always remove it
later if we find they go unused. This automagic stuff is going to take a
bit of getting used to I recon ;-)
