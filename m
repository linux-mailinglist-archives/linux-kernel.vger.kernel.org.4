Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02C8A6FFF64
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 05:45:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239813AbjELDpD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 23:45:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239718AbjELDpB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 23:45:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A87644EC8
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 20:45:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3BA0364EA4
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 03:45:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E916C433EF;
        Fri, 12 May 2023 03:44:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1683863099;
        bh=10DaO0lGOkMyOmCE2RbgGjIgBZk/Z7vqVLApmhZ0NEQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=NzFAgIx9MLyl86zLymF+9gdeksJokq03KCZB+W3c0/G5eT0prnoV+rJYABMx8GfIA
         sfu3G/VFzm8zI9tMacpB7Al8liEOax1d7TBpAdoStzy7itpLJg0WuSfOekpGO2oPhg
         exsWdDI7j04QVnlcwOHIX6TDTg7rk+O8T6Idj0/U=
Date:   Thu, 11 May 2023 20:44:58 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc:     syzbot <syzbot+fe0c72f0ccbb93786380@syzkaller.appspotmail.com>,
        syzkaller-bugs@googlegroups.com, Ingo Molnar <mingo@elte.hu>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-mm <linux-mm@kvack.org>
Subject: Re: [PATCH] debugobject: don't wake up kswapd from fill_pool()
Message-Id: <20230511204458.819f9009d2ef8b46cc163191@linux-foundation.org>
In-Reply-To: <6577e1fa-b6ee-f2be-2414-a2b51b1c5e30@I-love.SAKURA.ne.jp>
References: <000000000000008ddb05fb5e2576@google.com>
        <6577e1fa-b6ee-f2be-2414-a2b51b1c5e30@I-love.SAKURA.ne.jp>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 May 2023 22:47:32 +0900 Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp> wrote:

> syzbot is reporting lockdep warning in fill_pool(), for GFP_ATOMIC is
> (__GFP_HIGH | __GFP_KSWAPD_RECLAIM) which wakes up kswapd.
> Since fill_pool() might be called with arbitrary locks held,
> fill_pool() should not assume that holding pgdat->kswapd_wait is safe.

hm.  But many GFP_ATOMIC allocation attempts are made with locks held. 
Why aren't all such callers buggy, by trying to wake kswapd with locks
held?  What's special about this one?

> Also, __GFP_NORETRY is pointless for !__GFP_DIRECT_RECLAIM allocation
> 
> Reported-by: syzbot <syzbot+fe0c72f0ccbb93786380@syzkaller.appspotmail.com>
> Closes: https://syzkaller.appspot.com/bug?extid=fe0c72f0ccbb93786380
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Fixes: 3ac7fe5a4aab ("infrastructure to debug (dynamic) objects")
> ---
>  lib/debugobjects.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/lib/debugobjects.c b/lib/debugobjects.c
> index 003edc5ebd67..986adca357b4 100644
> --- a/lib/debugobjects.c
> +++ b/lib/debugobjects.c
> @@ -126,7 +126,7 @@ static const char *obj_states[ODEBUG_STATE_MAX] = {
>  
>  static void fill_pool(void)
>  {
> -	gfp_t gfp = GFP_ATOMIC | __GFP_NORETRY | __GFP_NOWARN;
> +	gfp_t gfp = __GFP_HIGH | __GFP_NOWARN;

Does this weaken fill_pool()'s allocation attempt more than necessary? 
We can still pass __GFP_HIGH?
