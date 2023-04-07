Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97B866DB2EB
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 20:36:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230112AbjDGSgW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 14:36:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbjDGSgU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 14:36:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97DD7A24F
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 11:36:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 333826539E
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 18:36:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C7FBC433EF;
        Fri,  7 Apr 2023 18:36:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680892578;
        bh=D2xQwPruUZnmP/3BgSjgMwUM09Rl4bUBfKl16ynyjks=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=d0a4D1bH+MV78nNRrY1x+Fqw2CMHB48rcCHbl3e0eGSYwPXhUH/w5IvYHJZgSmAYk
         QDFb1fWOYTmrFDGCEe5bXkimjROMELPv2udchVH4GDaed60FLDeNAjiz7AbdknhxXZ
         0myneUo+LZHvy/U/qe+RJgan7GZnwYncmPkOd3em2b/FiP2PVLgtD6DvqR7Co9mfoP
         wQAsIbHJc9mzk3/d8RHxdAIkf5JtZZG5fRSw/pahePWBqWZeg5IADVai+oMxNZSesC
         hdk+CDxCZwq3Q/TIzdCa6FM6mCX6J1P4BQJWqM5N6bOBhcroqrp8bADDZ+iIymB+rY
         mctETlCbVMmuA==
Date:   Fri, 7 Apr 2023 20:36:15 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Marco Elver <elver@google.com>,
        syzbot <syzbot+3b14b2ed9b3d06dcaa07@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Jacob Keller <jacob.e.keller@intel.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: WARNING in timer_wait_running
Message-ID: <ZDBin2ZQwc69hGX4@lothringen>
References: <87h6tsred7.ffs@tglx>
 <874jpsqdy1.ffs@tglx>
 <ZDADdMnY0oW2k5BV@lothringen>
 <87lej3twhv.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87lej3twhv.ffs@tglx>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 07, 2023 at 07:47:40PM +0200, Thomas Gleixner wrote:
> On Fri, Apr 07 2023 at 13:50, Frederic Weisbecker wrote:
> > On Fri, Apr 07, 2023 at 10:44:22AM +0200, Thomas Gleixner wrote:
> >> Now memory came back. The problem with posix CPU timers is that it is
> >> not really known to the other side which task is actually doing the
> >> expiry. For process wide timers this could be any task in the process.
> >> 
> >> For hrtimers this works because the expiring context is known.
> >
> > So if posix_cpu_timer_del() were to clear ctmr->pid to NULL and then
> > delay put_pid() with RCU, we could retrieve that information without
> > holding the timer lock (with appropriate RCU accesses all around).
> 
> No, you can't. This only gives you the process, but the expiry might run
> on any task of that. To make that work you need a mutex in sighand.

Duh right missed that. Ok will try.
