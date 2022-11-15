Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B75016295BA
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 11:24:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229903AbiKOKYz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 05:24:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbiKOKYx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 05:24:53 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D033F11C36;
        Tue, 15 Nov 2022 02:24:49 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 8DFAF22C74;
        Tue, 15 Nov 2022 10:24:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1668507888; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=e1DgsCnkMcZHvcQI5AjlxgUruHk8XD8H13tIJ0676Kk=;
        b=GN6QhCaj8IG/k/12dLkr0GJhKTv6TSfLXTcvmOerKPRhOWBCebrDNP8hBA6DjqS75xAB5H
        GhG/5yftJhxo39t6ox01jDdiV0sN6p7sPSLZsq7lSkNCF+JRJ6fvFydazJ4JdCG7AhOteR
        txetRTgO6c3lG/aULsS0qL0i+oLs6SI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1668507888;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=e1DgsCnkMcZHvcQI5AjlxgUruHk8XD8H13tIJ0676Kk=;
        b=xhv0Tc3ubZXce2qKM84vdBqD0OmKyhfHCiGjqjW+qS8PCADAySeh1lmblB+OXnf276iUZb
        HJZywXO7oWLnBLCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6DFAD13A91;
        Tue, 15 Nov 2022 10:24:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id BVLQGvBoc2MUfAAAMHmgww
        (envelope-from <jack@suse.cz>); Tue, 15 Nov 2022 10:24:48 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id EADF5A0709; Tue, 15 Nov 2022 11:24:47 +0100 (CET)
Date:   Tue, 15 Nov 2022 11:24:47 +0100
From:   Jan Kara <jack@suse.cz>
To:     Gabriel Krisman Bertazi <krisman@suse.de>
Cc:     Jan Kara <jack@suse.cz>, axboe@kernel.dk,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Hugh Dickins <hughd@google.com>,
        Keith Busch <kbusch@kernel.org>,
        Liu Song <liusong@linux.alibaba.com>
Subject: Re: [PATCH] sbitmap: Use single per-bitmap counting to wake up
 queued tags
Message-ID: <20221115102447.tg3tx5dofu3qalhq@quack3>
References: <20221105231055.25953-1-krisman@suse.de>
 <20221114132313.5cqhvzxarm7rwvmt@quack3>
 <87cz9odgcf.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87cz9odgcf.fsf@suse.de>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 14-11-22 22:52:32, Gabriel Krisman Bertazi wrote:
> Jan Kara <jack@suse.cz> writes:
> 
> > Now this may be also problematic - when we were checking the number of woken
> > waiters in the older version of the patch (for others: internal version of
> > the patch) this was fine but now it may happen that the 'ws' we have
> > selected has no waiters anymore. And in that case we need to find another
> > waitqueue because otherwise we'd be loosing too many wakeups and we could
> > deadlock. So I think this rather needs to be something like:
> >
> > 	do {
> > 		if (atomic_read(&sbq->completion_cnt) - wakeups < wake_batch)
> > 			return;
> > 	} while (!atomic_try_cmpxchg(&sbq->wakeup_cnt,
> > 				     &wakeups, wakeups + wake_batch));
> >
> > 	do {
> > 		ws = sbq_wake_ptr(sbq);
> > 		if (!ws)
> > 			return;
> 
> Does this really solve it? There is no guarantee there will be another
> waiter in the queues when we check here.  So, once again we could not
> wake up anyone and return it this if leg.  If that is the case, don't we
> end up overshooting wakeups and end up again with less completions than
> required to wake up an incoming io?

Well, if we don't find any waiter in any of the wait queues, it sure does
not matter we just discard wakeups? And sure, these checks are racy as the
waiters can be constantly added but the invariant is: if some waiter is
added after the atomic_try_cmpxchg(), then all tags are used so as many
completions as there are tags are coming. So that is enough to wake the
new waiter (due to batch size). So all what matters is: If there's any
waiter in the waitqueue by the time atomic_try_cmpxchg() is called, we'll
consider it in the wakeup loop. And that is fulfilled by the code AFAICT.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
