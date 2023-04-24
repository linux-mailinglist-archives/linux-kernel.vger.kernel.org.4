Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C9E26EC804
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 10:43:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231382AbjDXInI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 04:43:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231344AbjDXInF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 04:43:05 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0822E9F
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 01:43:03 -0700 (PDT)
Date:   Mon, 24 Apr 2023 10:42:59 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1682325780;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=G2i+ANlboexdfsAFGiKAtoCg29pYlUhZil0sgaeWD6g=;
        b=44T8aj2w17DL8PADvxQIJi+aJzRbwyK57xXUOjrFNzD62MXgZWNAdprNvHSlFSgxmYC6Rm
        nAlbEd2+ElKn70k67n+ezUJ8qPl5E9CI+z0NerI5rN89IgZkbVlzC9zkuxV78MiNS+qJS3
        ZfssEdpFtu2pZjMK4E0+xg3ivrP4hje9kIM+d6xvO1SAPsisvFT2laMhWs9M0uX38mQZym
        wvdI+gPSUZiEXSGSQyfuBJ8g5yu4xZ2r4miZXZDTJR6xwoccN2rVHqSA7cJsYYhErnBINN
        WEJJZEny9kYqXpkKHfyNGrZTzG+dOa15AO51zenu6J2WGfcgHvsd0eXZ6LYR1g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1682325780;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=G2i+ANlboexdfsAFGiKAtoCg29pYlUhZil0sgaeWD6g=;
        b=swf6zFmzHIvJjDdOPSileAO766BWKha1ScUkaRR98RpS8w0mCcB/rMNbZ4Y77EihjsDexr
        tNaKKmz13PZGieCg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, Crystal Wood <swood@redhat.com>,
        John Keeping <john@metanate.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Waiman Long <longman@redhat.com>, Will Deacon <will@kernel.org>
Subject: Re: [PATCH] locking/rtmutex: Do the trylock-slowpath with
 DEBUG_RT_MUTEXES enabled.
Message-ID: <20230424084259.txfDjYNV@linutronix.de>
References: <20230322162719.wYG1N0hh@linutronix.de>
 <20230328165430.9eOXd-55@linutronix.de>
 <87zg7115ib.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87zg7115ib.ffs@tglx>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-04-21 19:58:52 [+0200], Thomas Gleixner wrote:
> On Tue, Mar 28 2023 at 18:54, Sebastian Andrzej Siewior wrote:
> > On 2023-03-22 17:27:21 [+0100], To Thomas Gleixner wrote:
> >> > Aside of that for CONFIG_DEBUG_RT_MUTEXES=y builds it flushes on every
> >> > lock operation whether the lock is contended or not.
> >> 
> >> For mutex & ww_mutex operations. rwsem is not affected by
> >> CONFIG_DEBUG_RT_MUTEXES. As for mutex it could be mitigated by invoking
> >> try_to_take_rt_mutex() before blk_flush_plug().
> 
> > I haven't observed anything in the ww-mutex path so we can ignore it or
> > do something similar to this.
> 
> Yay for consistency !
> 
> I fixed it up to the below.

you fixed the ww-mutex path and did with the debug path what I did in
the follow-up patch. Let me fold this then and drop the other one.

> Thanks,
> 
>         tglx

Sebastian
