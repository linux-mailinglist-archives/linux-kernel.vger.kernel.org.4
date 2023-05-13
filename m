Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 621AB701546
	for <lists+linux-kernel@lfdr.de>; Sat, 13 May 2023 10:33:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232182AbjEMIdy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 May 2023 04:33:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjEMIdv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 May 2023 04:33:51 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55DE74C25
        for <linux-kernel@vger.kernel.org>; Sat, 13 May 2023 01:33:50 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1683966827;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=upafpHfSofvA8jLog1yJSjP3+mjtBPHf215cSKnKmkw=;
        b=03JA2DdbUjhdsrNQv/c11zzVIyTbqS2EFOod1SeyF1nm6WYCoe9eorXz77Y1I26w2AvYJ0
        7O2ooEtxe6DvH0RPJrqAjv8PqIiNVQ6JhmvAl7L2W3NoERrnXf/hb34vzsQT5PFCbk5lNG
        AQ2BLs1xOM3aZ1vEUQ1E3S6iOUa97iMBVICAcHctYf/q9csZqAe88Ur9Th8lsW2TnLkB+A
        qaYstRSpO885rD/2tBO0srRYTSA6BP65TZxD9qohHwJINCVOFJRgghzcdsdJDwUd/qF5hM
        faXXNDIBznlDgZCOgRQ1gYQomUZVz9BSXmn046PJt47hyegl/teKXG09bST63w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1683966827;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=upafpHfSofvA8jLog1yJSjP3+mjtBPHf215cSKnKmkw=;
        b=v0mb7MEHh3lIRKFWHbNyszMXmH6IlZQO4cEkwxYLXCqCaEB5Ts3inpuBelseosdKwh8+do
        SjINwuzFW5bOWpCg==
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     syzbot <syzbot+fe0c72f0ccbb93786380@syzkaller.appspotmail.com>,
        syzkaller-bugs@googlegroups.com, Ingo Molnar <mingo@elte.hu>,
        linux-kernel@vger.kernel.org, linux-mm <linux-mm@kvack.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] debugobject: don't wake up kswapd from fill_pool()
In-Reply-To: <61d7ac52-3352-b7cd-8908-890a29a007d9@I-love.SAKURA.ne.jp>
References: <000000000000008ddb05fb5e2576@google.com>
 <6577e1fa-b6ee-f2be-2414-a2b51b1c5e30@I-love.SAKURA.ne.jp>
 <20230511204458.819f9009d2ef8b46cc163191@linux-foundation.org>
 <d642e597-cf7d-b410-16ce-22dff483fd8e@I-love.SAKURA.ne.jp>
 <87v8gxbthf.ffs@tglx>
 <39c79d27-73ea-06a8-62fe-2b64d0fd8db5@I-love.SAKURA.ne.jp>
 <87bkipbeyr.ffs@tglx>
 <61d7ac52-3352-b7cd-8908-890a29a007d9@I-love.SAKURA.ne.jp>
Date:   Sat, 13 May 2023 10:33:47 +0200
Message-ID: <87lehsaavo.ffs@tglx>
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

On Sat, May 13 2023 at 08:13, Tetsuo Handa wrote:
> On 2023/05/13 3:07, Thomas Gleixner wrote:
>> The main change is to make the refill invocation conditional when the
>> lookup fails. That's how that code has been from day one.
>
> Making refill conditional helps reducing frequency of doing allocations.
> I want a proof that allocations never happens in the worst scenario.
>
> Are you saying that some debugobject function other than debug_object_activate()
> guarantees that memory for that object was already allocated before
> debug_object_activate() is called for the first time for that object,
> _and_ such debugobject function is called without locks held?

The point is that the allocation in activate() only happens when the
tracked entity was not initialized _before_ activate() is invoked.

That's a bug for dynamically allocated entities, but a valid scenario
for statically initialized entities as they can be activated without
prior init() obviously.

For dynamically allocated entities the init() function takes care of the
tracking object allocation and that's where the pool is refilled. So for
those the lookup will never fail.

Now I just stared at __alloc_pages_slowpath() and looked at the
condition for wakeup_all_kswapds(). ALLOC_KSWAPD is set because
debugobject uses GFP_ATOMIC which contains __GFP_KSWAPD_RECLAIM.

So debug objects needs to have s/GFP_ATOMIC/__GFP_HIGH/ to prevent that
wakeup path.

Thanks,

        tglx



