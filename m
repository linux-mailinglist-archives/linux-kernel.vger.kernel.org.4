Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A4A16FC70D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 14:50:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234716AbjEIMuw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 08:50:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230119AbjEIMuu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 08:50:50 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 298A94C31
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 05:50:49 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1683636647;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4Uh4jLOK44sbSg0Nb75DjvHgNO2JDLb4jbcWIYet/JI=;
        b=hgOcw7XF4xOjLIWJToCM+L/7RqVmUwz85PD9XnEESMOdaXfd0i9sIv3/L7FqeRtwTPyGFr
        0TlC4QeMJGfeiW7+gsfT2WXzKQFbpJxYuPHytmlzVWA3Za6eylJysDnRb2rNePFysMxNdQ
        JV7NMCm3KFA/cMWhFV9qyQ7BzvKkHIXQHVHXGYO5ChltBQ29edccSOLkArqUqjlNr739JE
        J+RWpGoBRt/hsVAb9ZJXqHHNDvgS2mN5+W05CxyhZK9ZdCrV1BnBuJ3pMOdfTMwAvQ/7Wh
        HfAszd2/peN1bN14buu8KFCYCNHmpsQHSxeNabYuDqBgN3AXfcJBpAV+yycZng==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1683636647;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4Uh4jLOK44sbSg0Nb75DjvHgNO2JDLb4jbcWIYet/JI=;
        b=GgIQecjNf2QB3cZ4HKd6HgY3iQOwZCCcXKHFD1+bREYhrmlVe93l15Aa7/oudLhNyfgUY1
        eT9WIUJ1PtFfRYBA==
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        syzbot+5c54bd3eb218bb595aa9@syzkaller.appspotmail.com,
        Dmitry Vyukov <dvyukov@google.com>,
        Sebastian Siewior <bigeasy@linutronix.de>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Andrei Vagin <avagin@openvz.org>
Subject: Re: [patch 02/20] posix-timers: Ensure timer ID search-loop limit
 is valid
In-Reply-To: <87v8h126p2.ffs@tglx>
References: <20230425181827.219128101@linutronix.de>
 <20230425183312.932345089@linutronix.de> <ZFUXrCZtWyNG3Esi@lothringen>
 <87zg6i2xn3.ffs@tglx> <87v8h62vwp.ffs@tglx> <878rdy32ri.ffs@tglx>
 <87v8h126p2.ffs@tglx>
Date:   Tue, 09 May 2023 14:50:47 +0200
Message-ID: <875y911xeg.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 09 2023 at 11:30, Thomas Gleixner wrote:
> On Mon, May 08 2023 at 23:57, Thomas Gleixner wrote:
>> More thoughts on this. If we go there and accept the extra page of
>> memory then we can just go all the way and make the xarray per process,
>> actually per signal.
>
> Thinking more about it. The current scheme how timer ID allocation works
> is really interesting vs. CRIU.
>
> Assume a process creates/deletes timers frequently. It's not hard to
> move the next ID close to INT_MAX, i.e. 2G
>
> Now checkpoint that thing and restore it which means to do the
> create/delete dance to move next ID up to the last one-1. Will only take
> a couple of hours....

I'm cursing myself for overlooking this back then when the CRIU changes
to the timer ID management were made. Why?

   Because that created an ABI which CRIU relies on.

The proper solution for this would be to make it possible to create a
timer with a given ID. That's not rocket science, but we need buy in
from the CRIU folks. Otherwise we are up the regression creek without a
paddle.

Thanks,

        tglx



