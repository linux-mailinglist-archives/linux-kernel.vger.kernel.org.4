Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5EAD624134
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 12:16:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230210AbiKJLQt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 06:16:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbiKJLQl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 06:16:41 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A36521E0D;
        Thu, 10 Nov 2022 03:16:38 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 3C1C31F90A;
        Thu, 10 Nov 2022 11:16:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1668078997; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xHmb3oZbqQEN2yJ2OZBtB3fE443Vekbcfy5OMkh4FoU=;
        b=faa5aXYuwYMSFIRpCm0mRYfKg/dMt92rAPxzwNsqqtNEQYdUYTbbEs/fWgbJGxApkqAVVi
        QqwBbnDWPGk7EOIQ9wGWw8n6PGZvjsgz1ZwoTpvNV7YoOxqX6ergWgJsTaTABwTSCqTDGv
        QYQ55us6gBk3Y3JrexkeVSCu4cWSU+4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1668078997;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xHmb3oZbqQEN2yJ2OZBtB3fE443Vekbcfy5OMkh4FoU=;
        b=WbGADlX1QvbVwk2hD1MKzKbt8f7UerQ+VGfdBWDd+6jjfCsO1U56p1159vLpTmPIE9I1Mt
        fzjOHSxeLcdmSwCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2A7B913B58;
        Thu, 10 Nov 2022 11:16:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id RlB6CpXdbGOZKwAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 10 Nov 2022 11:16:37 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 985C7A0704; Thu, 10 Nov 2022 12:16:36 +0100 (CET)
Date:   Thu, 10 Nov 2022 12:16:36 +0100
From:   Jan Kara <jack@suse.cz>
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     Gabriel Krisman Bertazi <krisman@suse.de>, axboe@kernel.dk,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Hugh Dickins <hughd@google.com>,
        Keith Busch <kbusch@kernel.org>,
        Liu Song <liusong@linux.alibaba.com>, Jan Kara <jack@suse.cz>,
        "yukuai (C)" <yukuai3@huawei.com>
Subject: Re: [PATCH] sbitmap: Use single per-bitmap counting to wake up
 queued tags
Message-ID: <20221110111636.ufgyp4tkbzexugk2@quack3>
References: <20221105231055.25953-1-krisman@suse.de>
 <2a445c5c-fd15-c0bf-8655-2fb5bde3fe67@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2a445c5c-fd15-c0bf-8655-2fb5bde3fe67@huaweicloud.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On Thu 10-11-22 17:42:49, Yu Kuai wrote:
> 在 2022/11/06 7:10, Gabriel Krisman Bertazi 写道:
> > +void sbitmap_queue_wake_up(struct sbitmap_queue *sbq, int nr)
> >   {
> > -	struct sbq_wait_state *ws;
> > -	unsigned int wake_batch;
> > -	int wait_cnt, cur, sub;
> > -	bool ret;
> > +	unsigned int wake_batch = READ_ONCE(sbq->wake_batch);
> > +	struct sbq_wait_state *ws = NULL;
> > +	unsigned int wakeups;
> > -	if (*nr <= 0)
> > -		return false;
> > +	if (!atomic_read(&sbq->ws_active))
> > +		return;
> > -	ws = sbq_wake_ptr(sbq);
> > -	if (!ws)
> > -		return false;
> > +	atomic_add(nr, &sbq->completion_cnt);
> > +	wakeups = atomic_read(&sbq->wakeup_cnt);
> > -	cur = atomic_read(&ws->wait_cnt);
> >   	do {
> > -		/*
> > -		 * For concurrent callers of this, callers should call this
> > -		 * function again to wakeup a new batch on a different 'ws'.
> > -		 */
> > -		if (cur == 0)
> > -			return true;
> > -		sub = min(*nr, cur);
> > -		wait_cnt = cur - sub;
> > -	} while (!atomic_try_cmpxchg(&ws->wait_cnt, &cur, wait_cnt));
> > -
> > -	/*
> > -	 * If we decremented queue without waiters, retry to avoid lost
> > -	 * wakeups.
> > -	 */
> > -	if (wait_cnt > 0)
> > -		return !waitqueue_active(&ws->wait);
> > +		if (atomic_read(&sbq->completion_cnt) - wakeups < wake_batch)
> > +			return;
> 
> Should it be considered that completion_cnt overflow and becomes
> negtive?

Yes, the counters can (and will) certainly overflow but since we only care
about (completion_cnt - wakeups), we should be fine - this number is always
sane (and relatively small) and in the kernel we do compile with signed
overflows being well defined.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
