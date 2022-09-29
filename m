Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F36965EF0B7
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 10:40:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235176AbiI2Ijt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 04:39:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235578AbiI2Ijq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 04:39:46 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 764E8175B6;
        Thu, 29 Sep 2022 01:39:42 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 351E721BE6;
        Thu, 29 Sep 2022 08:39:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1664440781; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=edxlyO0DI/XbqT4f94AuU5/d2duw9Yhmd6WUepUXs+M=;
        b=CdYlBh0R4T8C4JQSnr4ybe6PJuDRU1jSW+8CJbnXwHv88aUpErLnpZLxIEJTnSWslBBxSo
        pp3FS2cvmCCXDwtjEOKO7DgJR3KTn+yU3se7bc+/mnngAMEXWwNm3r8te6tcD2XvBY9swV
        9tfOVOT0CGLzuhEe4nkMyE06yrc0cC0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1664440781;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=edxlyO0DI/XbqT4f94AuU5/d2duw9Yhmd6WUepUXs+M=;
        b=DouwamspXNxBSjKfFx/GGJArug1SbCVLlg3Vj4yp469JdgG9YYrmF7ftTnGj61Ff9nILzj
        twgeNYOY1gF4rGBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 137F613A71;
        Thu, 29 Sep 2022 08:39:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id L8u6BM1ZNWPEHwAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 29 Sep 2022 08:39:41 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id CEC40A0680; Thu, 29 Sep 2022 10:39:39 +0200 (CEST)
Date:   Thu, 29 Sep 2022 10:39:39 +0200
From:   Jan Kara <jack@suse.cz>
To:     Hugh Dickins <hughd@google.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        Keith Busch <kbusch@kernel.org>,
        Yu Kuai <yukuai1@huaweicloud.com>,
        Liu Song <liusong@linux.alibaba.com>,
        Hillf Danton <hdanton@sina.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH next v2] sbitmap: fix lockup while swapping
Message-ID: <20220929083939.ioytch563qikyflz@quack3>
References: <d83885c9-2635-ef45-2ccc-a7e06421e1cc@google.com>
 <Yy4D54kPpenBkjHz@kbusch-mbp.dhcp.thefacebook.com>
 <391b1763-7146-857-e3b6-dc2a8e797162@google.com>
 <929a3aba-72b0-5e-5b80-824a2b7f5dc7@google.com>
 <20220926114416.t7t65u66ze76aiz7@quack3>
 <4539e48-417-edae-d42-9ef84602af0@google.com>
 <20220927103123.cvjbdx6lqv7jxa2w@quack3>
 <2b931ee7-1bc9-e389-9d9f-71eb778dcf1@google.com>
 <f975dddf-6ec-b3cb-3746-e91f61b22ea@google.com>
 <9f68731-e699-5679-6a71-77634767b8dd@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9f68731-e699-5679-6a71-77634767b8dd@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 27-09-22 21:07:46, Hugh Dickins wrote:
> Commit 4acb83417cad ("sbitmap: fix batched wait_cnt accounting")
> is a big improvement: without it, I had to revert to before commit
> 040b83fcecfb ("sbitmap: fix possible io hung due to lost wakeup")
> to avoid the high system time and freezes which that had introduced.
> 
> Now okay on the NVME laptop, but 4acb83417cad is a disaster for heavy
> swapping (kernel builds in low memory) on another: soon locking up in
> sbitmap_queue_wake_up() (into which __sbq_wake_up() is inlined), cycling
> around with waitqueue_active() but wait_cnt 0 .  Here is a backtrace,
> showing the common pattern of outer sbitmap_queue_wake_up() interrupted
> before setting wait_cnt 0 back to wake_batch (in some cases other CPUs
> are idle, in other cases they're spinning for a lock in dd_bio_merge()):
> 
> sbitmap_queue_wake_up < sbitmap_queue_clear < blk_mq_put_tag <
> __blk_mq_free_request < blk_mq_free_request < __blk_mq_end_request <
> scsi_end_request < scsi_io_completion < scsi_finish_command <
> scsi_complete < blk_complete_reqs < blk_done_softirq < __do_softirq <
> __irq_exit_rcu < irq_exit_rcu < common_interrupt < asm_common_interrupt <
> _raw_spin_unlock_irqrestore < __wake_up_common_lock < __wake_up <
> sbitmap_queue_wake_up < sbitmap_queue_clear < blk_mq_put_tag <
> __blk_mq_free_request < blk_mq_free_request < dd_bio_merge <
> blk_mq_sched_bio_merge < blk_mq_attempt_bio_merge < blk_mq_submit_bio <
> __submit_bio < submit_bio_noacct_nocheck < submit_bio_noacct <
> submit_bio < __swap_writepage < swap_writepage < pageout <
> shrink_folio_list < evict_folios < lru_gen_shrink_lruvec <
> shrink_lruvec < shrink_node < do_try_to_free_pages < try_to_free_pages <
> __alloc_pages_slowpath < __alloc_pages < folio_alloc < vma_alloc_folio <
> do_anonymous_page < __handle_mm_fault < handle_mm_fault <
> do_user_addr_fault < exc_page_fault < asm_exc_page_fault
> 
> See how the process-context sbitmap_queue_wake_up() has been interrupted,
> after bringing wait_cnt down to 0 (and in this example, after doing its
> wakeups), before advancing wake_index and refilling wake_cnt: an
> interrupt-context sbitmap_queue_wake_up() of the same sbq gets stuck.
> 
> I have almost no grasp of all the possible sbitmap races, and their
> consequences: but __sbq_wake_up() can do nothing useful while wait_cnt 0,
> so it is better if sbq_wake_ptr() skips on to the next ws in that case:
> which fixes the lockup and shows no adverse consequence for me.
> 
> Signed-off-by: Hugh Dickins <hughd@google.com>

Perhaps we could add a note here like: "The check for wait_cnt being 0 is
obviously racy and ultimately can lead to lost wakeups for example when
there is only single waitqueue with waiters. However in these cases lost
wakeups are unlikely to matter and proper fix requires redesign (and
benchmarking) of batched wakeup code so let's plug the hole with this band
aid for now."

Otherwise feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
> v2: - v1 to __sbq_wake_up() broke out when this happens, but
>       v2 to sbq_wake_ptr() does better by skipping on to the next.
>     - added more comment and deleted dubious Fixes attribution.
>     - and apologies to Mr Axboe and all for my axbod typo
> 
>  lib/sbitmap.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- a/lib/sbitmap.c
> +++ b/lib/sbitmap.c
> @@ -587,7 +587,7 @@ static struct sbq_wait_state *sbq_wake_p
>  	for (i = 0; i < SBQ_WAIT_QUEUES; i++) {
>  		struct sbq_wait_state *ws = &sbq->ws[wake_index];
>  
> -		if (waitqueue_active(&ws->wait)) {
> +		if (waitqueue_active(&ws->wait) && atomic_read(&ws->wait_cnt)) {
>  			if (wake_index != atomic_read(&sbq->wake_index))
>  				atomic_set(&sbq->wake_index, wake_index);
>  			return ws;
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
