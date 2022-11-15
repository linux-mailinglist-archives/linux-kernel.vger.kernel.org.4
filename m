Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1A1C6290FA
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 04:52:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232708AbiKODwj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 22:52:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232093AbiKODwh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 22:52:37 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40A5838AC;
        Mon, 14 Nov 2022 19:52:37 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C304F1F88D;
        Tue, 15 Nov 2022 03:52:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1668484355; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=F68rcKpvQBDy4nKu9n/1sp/nPoHRcsFqu67ojS0Ng6E=;
        b=ZKsK2tXxTn8uMekhf7Yx4oFilvEr4W58doFTwYAWqtFRGGsYTTB1NwJ2/kILVCReVOr9S1
        U7o6whBN2KKw1NvkX1BiNVW+73POuCxzfWdt9GRPtIlS3HXcZ5l9U7SriNDNeg/hfubtIT
        HksODj8/pCbg9upZrHhs8oB1FObTScw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1668484355;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=F68rcKpvQBDy4nKu9n/1sp/nPoHRcsFqu67ojS0Ng6E=;
        b=59gI+r6Uk0DyFD7O9xcqJxSoNSJdP/TiSRrWQ+JHbBVP/uTB8X5hYGKuQdYVQ9/zlpxd47
        Oq5NBCuqoV9D4wDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4A11713A18;
        Tue, 15 Nov 2022 03:52:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id sh1mAAMNc2PeVgAAMHmgww
        (envelope-from <krisman@suse.de>); Tue, 15 Nov 2022 03:52:35 +0000
From:   Gabriel Krisman Bertazi <krisman@suse.de>
To:     Jan Kara <jack@suse.cz>
Cc:     axboe@kernel.dk, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, Hugh Dickins <hughd@google.com>,
        Keith Busch <kbusch@kernel.org>,
        Liu Song <liusong@linux.alibaba.com>
Subject: Re: [PATCH] sbitmap: Use single per-bitmap counting to wake up
 queued tags
Organization: SUSE
References: <20221105231055.25953-1-krisman@suse.de>
        <20221114132313.5cqhvzxarm7rwvmt@quack3>
Date:   Mon, 14 Nov 2022 22:52:32 -0500
In-Reply-To: <20221114132313.5cqhvzxarm7rwvmt@quack3> (Jan Kara's message of
        "Mon, 14 Nov 2022 14:23:13 +0100")
Message-ID: <87cz9odgcf.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Kara <jack@suse.cz> writes:

> Now this may be also problematic - when we were checking the number of woken
> waiters in the older version of the patch (for others: internal version of
> the patch) this was fine but now it may happen that the 'ws' we have
> selected has no waiters anymore. And in that case we need to find another
> waitqueue because otherwise we'd be loosing too many wakeups and we could
> deadlock. So I think this rather needs to be something like:
>
> 	do {
> 		if (atomic_read(&sbq->completion_cnt) - wakeups < wake_batch)
> 			return;
> 	} while (!atomic_try_cmpxchg(&sbq->wakeup_cnt,
> 				     &wakeups, wakeups + wake_batch));
>
> 	do {
> 		ws = sbq_wake_ptr(sbq);
> 		if (!ws)
> 			return;

Jan,

Does this really solve it? There is no guarantee there will be another
waiter in the queues when we check here.  So, once again we could not
wake up anyone and return it this if leg.  If that is the case, don't we
end up overshooting wakeups and end up again with less completions than
required to wake up an incoming io?

-- 
Gabriel Krisman Bertazi
