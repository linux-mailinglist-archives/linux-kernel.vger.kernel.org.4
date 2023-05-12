Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79D1A700885
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 14:55:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240776AbjELMy7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 08:54:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241183AbjELMyn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 08:54:43 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3208413C23
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 05:54:22 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1683896061;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=s7JHgIguqRXAi/OOLsL9tLfDPiNsGDXsRJUcq20WaIk=;
        b=C3XQh+kz3xteIU5uowOEhCIW+jYH2i8gBVJHfMTRgtorG68FUEIvolz7NC8szqBhPNIP29
        c9YHMpTwjnO0c6REJkSD5JRbF+zoHghyYE4S8vGW42L9mXlCBUM2fONswlxgRf8ti8KZr8
        EQXLLB2ZvVCCTk+PHq2uBiOCusRoGZ1T6TjFHbCocbeMONnRbb8VaDJDP2p25d/pqxW1yq
        kKqugiCqwlng8F9aKQuo7KPrRwk4d+zLWk3flBODmL1znajeQDGSlj61Zzc1uL+tDIIIUp
        c8lHJFTv4TaYQd84xdVWFnaqRiUDqTQ9pSpuC0BLa7GoPY8jAGx9wRzYNsZ0Hg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1683896061;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=s7JHgIguqRXAi/OOLsL9tLfDPiNsGDXsRJUcq20WaIk=;
        b=VyR+NflhJ1vjl28Qm9YvkCNyRr/xRDH7jDQOnIglSHrZJ1bZjN66PP3h72oy+k2KWjesoY
        jeO5/Q61Z3H46MBg==
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     syzbot <syzbot+fe0c72f0ccbb93786380@syzkaller.appspotmail.com>,
        syzkaller-bugs@googlegroups.com, Ingo Molnar <mingo@elte.hu>,
        linux-kernel@vger.kernel.org, linux-mm <linux-mm@kvack.org>
Subject: Re: [PATCH] debugobject: don't wake up kswapd from fill_pool()
In-Reply-To: <d642e597-cf7d-b410-16ce-22dff483fd8e@I-love.SAKURA.ne.jp>
References: <000000000000008ddb05fb5e2576@google.com>
 <6577e1fa-b6ee-f2be-2414-a2b51b1c5e30@I-love.SAKURA.ne.jp>
 <20230511204458.819f9009d2ef8b46cc163191@linux-foundation.org>
 <d642e597-cf7d-b410-16ce-22dff483fd8e@I-love.SAKURA.ne.jp>
Date:   Fri, 12 May 2023 14:54:20 +0200
Message-ID: <87v8gxbthf.ffs@tglx>
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

On Fri, May 12 2023 at 19:57, Tetsuo Handa wrote:
> On 2023/05/12 12:44, Andrew Morton wrote:
>> On Thu, 11 May 2023 22:47:32 +0900 Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp> wrote:
>> 
>>> syzbot is reporting lockdep warning in fill_pool(), for GFP_ATOMIC is
>>> (__GFP_HIGH | __GFP_KSWAPD_RECLAIM) which wakes up kswapd.
>>> Since fill_pool() might be called with arbitrary locks held,
>>> fill_pool() should not assume that holding pgdat->kswapd_wait is safe.

https://lore.kernel.org/lkml/871qjldbes.ffs@tglx/
