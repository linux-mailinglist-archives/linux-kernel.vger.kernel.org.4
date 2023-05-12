Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74ECB700E63
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 20:08:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238294AbjELSIB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 14:08:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231574AbjELSH7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 14:07:59 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4806310F6
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 11:07:58 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1683914876;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nxedla5WIOuVTxDfzDbD5hmB6vdEj1u0Wyu1rqHtvfs=;
        b=fmEnlP+GLRn3um3cql8aaV+i5MQmtHc0dMsuiC0uglKDo2qCdf6EtEF/viioXyadX9eM8p
        lz4iOAAoKjDt04Osljgk0/SeVzibUBRLcCBgfcKHL0ApU0oIskFwusZlX8kd63MGBA+Ink
        u84pSBAGm/SVoi1+6QSVz3y2xhKYazRW6W0OLsKYrE9eI71Xyv8TQunMHEdnIQK+olfGXe
        0oKHRguXDHp/XiyVhvdVmvMF3bkGZeBOHITN+PcxgyCJUlMuIeuDR49+mQPG3WDmj+RjmX
        pyuPRsrfHd3osWEvFdSqlxOOMCI23TzBXyU9M8je9BSzL/ekbaqD+bDANU0kJg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1683914876;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nxedla5WIOuVTxDfzDbD5hmB6vdEj1u0Wyu1rqHtvfs=;
        b=KP3WEVY/OXcnilm3hs2r59d5+WyKUVR8uAWXxi25sJlhfFlMlLKlvFjGLZYjJ0kHt7n5qL
        wqMCjXOE6niCLDBA==
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     syzbot <syzbot+fe0c72f0ccbb93786380@syzkaller.appspotmail.com>,
        syzkaller-bugs@googlegroups.com, Ingo Molnar <mingo@elte.hu>,
        linux-kernel@vger.kernel.org, linux-mm <linux-mm@kvack.org>
Subject: Re: [PATCH] debugobject: don't wake up kswapd from fill_pool()
In-Reply-To: <39c79d27-73ea-06a8-62fe-2b64d0fd8db5@I-love.SAKURA.ne.jp>
References: <000000000000008ddb05fb5e2576@google.com>
 <6577e1fa-b6ee-f2be-2414-a2b51b1c5e30@I-love.SAKURA.ne.jp>
 <20230511204458.819f9009d2ef8b46cc163191@linux-foundation.org>
 <d642e597-cf7d-b410-16ce-22dff483fd8e@I-love.SAKURA.ne.jp>
 <87v8gxbthf.ffs@tglx>
 <39c79d27-73ea-06a8-62fe-2b64d0fd8db5@I-love.SAKURA.ne.jp>
Date:   Fri, 12 May 2023 20:07:56 +0200
Message-ID: <87bkipbeyr.ffs@tglx>
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

On Fri, May 12 2023 at 22:09, Tetsuo Handa wrote:
> On 2023/05/12 21:54, Thomas Gleixner wrote:
>> On Fri, May 12 2023 at 19:57, Tetsuo Handa wrote:
>>> On 2023/05/12 12:44, Andrew Morton wrote:
>>>> On Thu, 11 May 2023 22:47:32 +0900 Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp> wrote:
>>>>
>>>>> syzbot is reporting lockdep warning in fill_pool(), for GFP_ATOMIC is
>>>>> (__GFP_HIGH | __GFP_KSWAPD_RECLAIM) which wakes up kswapd.
>>>>> Since fill_pool() might be called with arbitrary locks held,
>>>>> fill_pool() should not assume that holding pgdat->kswapd_wait is safe.
>> 
>> https://lore.kernel.org/lkml/871qjldbes.ffs@tglx/
>
> .config says IS_ENABLED(CONFIG_PREEMPT_RT) == false, and lockdep says about
> base->lock => pgdat->kswapd_wait => p->pi_lock => rq->__lock => base->lock
> dependency but does not say about db->lock.
>
> How can your patch fix this problem?

It's described in the changelog, no?

The main change is to make the refill invocation conditional when the
lookup fails. That's how that code has been from day one.

The patch which closed the race recently wreckaged those refill
oportunities and the fix for that introduced this problem.

Thanks,

        tglx
