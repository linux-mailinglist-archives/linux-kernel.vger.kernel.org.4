Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 137D970198A
	for <lists+linux-kernel@lfdr.de>; Sat, 13 May 2023 21:45:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbjEMTmz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 May 2023 15:42:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjEMTmx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 May 2023 15:42:53 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DEBD1BC7
        for <linux-kernel@vger.kernel.org>; Sat, 13 May 2023 12:42:53 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1684006971;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xhIUhkm/3QxY0cQ35omU8A+ztIuN9wN4GJw2r9D9N8c=;
        b=4j5yDWsZaysSy25nQ55wrWrPJWnm9WFsLnteMJ92iU+X5vqMz9/sgIOgPPvscoCmFxAPlT
        xGfKRi0hHldOz9J/TvQaTfle2Bv5h8nra2WAiAi3BtCuT9nHAt1DRCXaV6ZNoSiwKNplq2
        b/SJXx4cpr4wgmI8ESC0x/5uCwASHEvIdILO6MKFEeLy1YZY1KD3gs5z0cxENJDCzLNZzu
        FxRCtgCg9stdEZdWfd2F8PUJMl+V0LPdJeW03wq8+oPqzHdmeHIccIhUMjU2sPY0LkJqJH
        cOnKrhRXBCXB8IMhJNoIkm654+v3PSaqPeCOW5g/a5aMBNgKWi9OELsi6P+t/w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1684006971;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xhIUhkm/3QxY0cQ35omU8A+ztIuN9wN4GJw2r9D9N8c=;
        b=FuUB6NJJ8piz48iH2rmyp4RMcQPrmrPihGRisRlSDu9P0zpwEuq2dlrdvoje3pqAVOz17d
        9Exm3eB02HcJtSAA==
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     syzbot <syzbot+fe0c72f0ccbb93786380@syzkaller.appspotmail.com>,
        syzkaller-bugs@googlegroups.com, Ingo Molnar <mingo@elte.hu>,
        linux-kernel@vger.kernel.org, linux-mm <linux-mm@kvack.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] debugobject: don't wake up kswapd from fill_pool()
In-Reply-To: <aaff0a39-3dd1-5efb-bb7b-c2c241ac9c06@I-love.SAKURA.ne.jp>
References: <000000000000008ddb05fb5e2576@google.com>
 <6577e1fa-b6ee-f2be-2414-a2b51b1c5e30@I-love.SAKURA.ne.jp>
 <20230511204458.819f9009d2ef8b46cc163191@linux-foundation.org>
 <d642e597-cf7d-b410-16ce-22dff483fd8e@I-love.SAKURA.ne.jp>
 <87v8gxbthf.ffs@tglx>
 <39c79d27-73ea-06a8-62fe-2b64d0fd8db5@I-love.SAKURA.ne.jp>
 <87bkipbeyr.ffs@tglx>
 <61d7ac52-3352-b7cd-8908-890a29a007d9@I-love.SAKURA.ne.jp>
 <87lehsaavo.ffs@tglx>
 <aaff0a39-3dd1-5efb-bb7b-c2c241ac9c06@I-love.SAKURA.ne.jp>
Date:   Sat, 13 May 2023 21:42:51 +0200
Message-ID: <87fs809fwk.ffs@tglx>
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

On Sat, May 13 2023 at 18:33, Tetsuo Handa wrote:
> On 2023/05/13 17:33, Thomas Gleixner wrote:
>> Now I just stared at __alloc_pages_slowpath() and looked at the
>> condition for wakeup_all_kswapds(). ALLOC_KSWAPD is set because
>> debugobject uses GFP_ATOMIC which contains __GFP_KSWAPD_RECLAIM.
>> 
>> So debug objects needs to have s/GFP_ATOMIC/__GFP_HIGH/ to prevent that
>> wakeup path.
>
> Yes. That is exactly what my patch does.

Indeed. For some reason your patch (though you cc'ed me) did not show up
in my inbox. I've grabbed it from lore so no need to resend.

Actually we want both changes.

  - Your's to fix the underlying ancient problem.

  - The one I did which restores the performance behaviour

Thanks,

        tglx

