Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D7645EA6F5
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 15:19:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234960AbiIZNTM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 09:19:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235538AbiIZNSq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 09:18:46 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74FA212636;
        Mon, 26 Sep 2022 04:45:35 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C2D811F8AA;
        Mon, 26 Sep 2022 11:44:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1664192656; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CqSXH5j7wLypgTtW8quzgrqoNG+t/F+4SqgHayo/knc=;
        b=HDJm4MLCdDct087pWEvc+k9wsLS//GBd2cmiHIxGkFgJqa3j4RikzYogZ+522Usg7wzCtt
        SSlIhpnH2WdLDR7eLdQGQwZMmR7fCHgb5HmKB155FkTSpty6VoxVCb9qET3puhYUCgURha
        zvjDNJnTiHp44/HBhFbJIt6y3E4UU08=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1664192656;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CqSXH5j7wLypgTtW8quzgrqoNG+t/F+4SqgHayo/knc=;
        b=RiZKcFGfR1OxHKCTb6ZcGrfyko2XNw3TO6dUjyulTIwg3aKzNDbVqXsXSm74rIodZXc5zx
        1bnZGw3iUf2Zv9BQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B3CBD139BD;
        Mon, 26 Sep 2022 11:44:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Y5rYK5CQMWO9OgAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 26 Sep 2022 11:44:16 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 49BA1A0685; Mon, 26 Sep 2022 13:44:16 +0200 (CEST)
Date:   Mon, 26 Sep 2022 13:44:16 +0200
From:   Jan Kara <jack@suse.cz>
To:     Hugh Dickins <hughd@google.com>
Cc:     Keith Busch <kbusch@kernel.org>, Jan Kara <jack@suse.cz>,
        Jens Axboe <axboe@kernel.dk>,
        Yu Kuai <yukuai1@huaweicloud.com>,
        Liu Song <liusong@linux.alibaba.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH next] sbitmap: fix lockup while swapping
Message-ID: <20220926114416.t7t65u66ze76aiz7@quack3>
References: <aef9de29-e9f5-259a-f8be-12d1b734e72@google.com>
 <YyjdiKC0YYUkI+AI@kbusch-mbp>
 <f2d130d2-f3af-d09d-6fd7-10da28d26ba9@google.com>
 <20220921164012.s7lvklp2qk6occcg@quack3>
 <20220923144303.fywkmgnkg6eken4x@quack3>
 <d83885c9-2635-ef45-2ccc-a7e06421e1cc@google.com>
 <Yy4D54kPpenBkjHz@kbusch-mbp.dhcp.thefacebook.com>
 <391b1763-7146-857-e3b6-dc2a8e797162@google.com>
 <929a3aba-72b0-5e-5b80-824a2b7f5dc7@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <929a3aba-72b0-5e-5b80-824a2b7f5dc7@google.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 23-09-22 16:15:29, Hugh Dickins wrote:
> On Fri, 23 Sep 2022, Hugh Dickins wrote:
> > On Fri, 23 Sep 2022, Keith Busch wrote:
> > 
> > > Does the following fix the observation? Rational being that there's no reason
> > > to spin on the current wait state that is already under handling; let
> > > subsequent clearings proceed to the next inevitable wait state immediately.
> > 
> > It's running fine without lockup so far; but doesn't this change merely
> > narrow the window?  If this is interrupted in between atomic_try_cmpxchg()
> > setting wait_cnt to 0 and sbq_index_atomic_inc() advancing wake_index,
> > don't we run the same risk as before, of sbitmap_queue_wake_up() from
> > the interrupt handler getting stuck on that wait_cnt 0?
> 
> Yes, it ran successfully for 50 minutes, then an interrupt came in
> immediately after the cmpxchg, and it locked up just as before.
> 
> Easily dealt with by disabling interrupts, no doubt, but I assume it's a
> badge of honour not to disable interrupts here (except perhaps in waking).

I don't think any magic with sbq_index_atomic_inc() is going to reliably
fix this. After all the current waitqueue may be the only one that has active
waiters so sbq_wake_ptr() will always end up returning this waitqueue
regardless of the current value of sbq->wake_index.

Honestly, this whole code needs a serious redesign. I have some
simplifications in mind but it will take some thinking and benchmarking so
we need some fix for the interim. I was pondering for quite some time about
some band aid to the problem you've found but didn't find anything
satisfactory.

In the end I see two options: 

1) Take your patch (as wrong as it is ;). Yes, it can lead to lost wakeups
but we were living with those for a relatively long time so probably we can
live with them for some longer.

2) Revert Yu Kuai's original fix 040b83fcecfb8 ("sbitmap: fix possible io
hung due to lost wakeup") and my fixup 48c033314f37 ("sbitmap: Avoid leaving
waitqueue in invalid state in __sbq_wake_up()"). But then Keith would have
to redo his batched accounting patches on top.

> Some clever way to make the wait_cnt and wake_index adjustments atomic?
> 
> Or is this sbitmap_queue_wake_up() interrupting sbitmap_queue_wake_up()
> just supposed never to happen, the counts preventing it: but some
> misaccounting letting it happen by mistake?

No, I think that is in principle a situation that we have to accommodate.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
