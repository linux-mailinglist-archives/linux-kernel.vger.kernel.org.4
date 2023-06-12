Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0199772BCE9
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 11:42:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231654AbjFLJmM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 05:42:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233203AbjFLJlo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 05:41:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EA0A76BE;
        Mon, 12 Jun 2023 02:30:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 10B8862267;
        Mon, 12 Jun 2023 09:30:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F8E9C433D2;
        Mon, 12 Jun 2023 09:30:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686562257;
        bh=WbY/B6Q3ozR2xTABptQ4x506EjsUcTEnB64Q34jdZiQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vOQbT4kLz546JuZehBh0+qAAJZgNnPPPBqK45UaaUioMGRHkVAxcjAMVvvYCAwIXm
         6QP8oIkTF/wOyGwh16+i09h5E/Q42cNy1PLWlF2dI/S8500ki6+iaFtxieLjz96r6J
         toL+iJCzDQxX3UlnowwCD28iFAoAZl+In8DMDhZxI32A7r3N85C6Rr9ST7ijdAI9Ww
         OGAgGRwUx/2tCG7H4aLyVYU+MNNLmuwvVXDDAuqzJ68O9JX6r3LkN38DjMQrGpHLuy
         BxC7ThbCcK1dwZKAMJiLOW/RJUS4LtRPTitsAX61SC7hOVKluhFcSfONGD6jZcjw9D
         uhUMcjlMy1LnA==
Date:   Mon, 12 Jun 2023 17:30:51 +0800
From:   Zorro Lang <zlang@kernel.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Dave Chinner <david@fromorbit.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Zorro Lang <zlang@redhat.com>, linux-xfs@vger.kernel.org,
        Mike Christie <michael.christie@oracle.com>,
        "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [6.5-rc5 regression] core dump hangs (was Re: [Bug report]
 fstests generic/051 (on xfs) hang on latest linux v6.5-rc5+)
Message-ID: <20230612093051.c5tkj3jwitwehyxd@zlang-mailbox>
References: <20230611124836.whfktwaumnefm5z5@zlang-mailbox>
 <ZIZSPyzReZkGBEFy@dread.disaster.area>
 <20230612015145.GA11441@frogsfrogsfrogs>
 <ZIaBQnCKJ6NsqGhd@dread.disaster.area>
 <CAHk-=whJqZLKPR-cpX-V4wJTXVX-_tG5Vjuj2q9knvKGCPdfkg@mail.gmail.com>
 <ZIaqMpGISWKgHLK6@dread.disaster.area>
 <CAHk-=wgwJptCbaHwt+TpGgh04fTVAHd60AY3Jj1rX+Spf0fVyg@mail.gmail.com>
 <ZIax1FLfNajWk25A@dread.disaster.area>
 <CAHk-=wj0NuJaRNC4o6FVAJgKAFJ5HWcBV5VJw6RGV0ZahqOOZA@mail.gmail.com>
 <87r0qhrrvr.fsf@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87r0qhrrvr.fsf@email.froward.int.ebiederm.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 12, 2023 at 03:45:12AM -0500, Eric W. Biederman wrote:
> Linus Torvalds <torvalds@linux-foundation.org> writes:
> 
> > On Sun, Jun 11, 2023 at 10:49 PM Dave Chinner <david@fromorbit.com> wrote:
> >>
> >> On Sun, Jun 11, 2023 at 10:34:29PM -0700, Linus Torvalds wrote:
> >> >
> >> > So that "!=" should obviously have been a "==".
> >>
> >> Same as without the condition - all the fsstress tasks hang in
> >> do_coredump().
> >
> > Ok, that at least makes sense. Your "it made things worse" made me go
> > "What?" until I noticed the stupid backwards test.
> >
> > I'm not seeing anything else that looks odd in that commit
> > f9010dbdce91 ("fork, vhost: Use CLONE_THREAD to fix freezer/ps
> > regression").
> >
> > Let's see if somebody else goes "Ahh" when they wake up tomorrow...
> 
> It feels like there have been about half a dozen bugs pointed out in
> that version of the patch.  I am going to have to sleep before I can get
> as far as "Ahh"
> 
> One thing that really stands out for me is.
> 
> if (test_if_loop_should_continue) {
> 	set_current_state(TASK_INTERRUPTIBLE);
>         schedule();
> }
> 
> /* elsewhere */
> llist_add(...);
> wake_up_process()
> 
> So it is possible that the code can sleep indefinitely waiting for a
> wake-up that has already come, because the order of set_current_state
> and the test are in the wrong order.
> 
> Unfortunately I don't see what would effect a coredump on a process that
> does not trigger the vhost_worker code.
> 
> 
> 
> About the only thing I can image is if io_uring is involved.  Some of
> the PF_IO_WORKER code was changed, and the test
> "((t->flags & (PF_USER_WORKER | PF_IO_WORKER)) != PF_USER_WORKER)"
> was sprinkled around.
> 
> That is the only code outside of vhost specific code that was changed.
> 
> 
> Is io_uring involved in the cases that hang?

Oh, right, I involved io_uring into in fstests' fsstress.c, and I built kernel
with CONFIG_IO_URING=y. If Darrick (said he didn't hit this issue) didn't enable
io_uring, that might mean it's io_uring related.

> 
> 
> Eric
> 
