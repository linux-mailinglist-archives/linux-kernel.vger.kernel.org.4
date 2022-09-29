Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D14F5EFE2E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 21:50:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbiI2Tue (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 15:50:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbiI2Tuc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 15:50:32 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6724AD8E33
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 12:50:31 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id k12so1542525qkj.8
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 12:50:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date;
        bh=efbnC73xSC5nyFVbESXykdN9LS7+SW97pvdH28kVw1M=;
        b=iCGzJFt32M7BkrnPMou/N8eyMPJhFz8RJNKxnIxc4zudAlpgg0jK4aPyKsH7j5O6MJ
         w+LeuVnuUSik7LXt+QRaZVkJaC/jGnPfAMxYmyk0iiAwsV+fG40ly0kchRryiFXOYE6A
         SPlDZyhdoD6oQMaDEhRCjKtIdctwPxtL07IRMU6Eoa/2uPSnpcmSX7L8hYS+WEiiY0vx
         LOesXLTUWRfypQ8KZ8UEjfqHziwoC90OHbw8Bb423F9BSCQQ7xrJWxaGPj1xQ7DZ/RJY
         Te7llFRnQzKdmWEu5n82FaatSy3sKE6blC+BO/5/AngTYiO+w7SYHKLvj0GsNlw4FOaG
         czmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=efbnC73xSC5nyFVbESXykdN9LS7+SW97pvdH28kVw1M=;
        b=jyJm/e8VL3nvG0WnjwYXIwjejv3aix/CM5nTsrgga1GqYCaa5IMhmG2MxUqxjHPVD9
         ogAPl0/pICMEm+xbWLVoD9qWeGy3pGh/8PbHm0gA0u8Nz3gWJ0E+mRy86k4bzEqp8Vb2
         DBOYKwWLh2gqFimcH/vZGbegSsEaeDvifkK/PV0vfupv6ArKN9MWHglJTQqKirzT3h5i
         77gc/+lfQoSwSuZXlNNhZeiysQFES6Rw+UnROeO/4bmYnibC1A9y0o1bdFbVvLs2WZH9
         6vw1x5V0yHFVTLwiFAgW3sjaK1LhEckbBmExvUgbY2BrP9RYLryEvH2Fl1XzTSjqm/Fr
         WthA==
X-Gm-Message-State: ACrzQf0uYj1bpGhYZ/YUnCkAMxjkZFufgwdbUQGN0yzdupo67ZEjujAg
        br4lpwn6B/c9XWPLF8R2R4kXhw==
X-Google-Smtp-Source: AMsMyM5/Sl+PJNRI6hdQneZVKxkNVKaav+nLJ2+WSjJF8gCHXHY+7ItWZpyRXz5nQZJKMKkedHNUPw==
X-Received: by 2002:a05:620a:bcc:b0:6ce:c077:acf3 with SMTP id s12-20020a05620a0bcc00b006cec077acf3mr3531713qki.263.1664481030386;
        Thu, 29 Sep 2022 12:50:30 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id ea2-20020a05620a488200b006b9526cfe6bsm231354qkb.80.2022.09.29.12.50.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Sep 2022 12:50:29 -0700 (PDT)
Date:   Thu, 29 Sep 2022 12:50:12 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Jens Axboe <axboe@kernel.dk>
cc:     Hugh Dickins <hughd@google.com>, Jan Kara <jack@suse.cz>,
        Keith Busch <kbusch@kernel.org>,
        Yu Kuai <yukuai1@huaweicloud.com>,
        Liu Song <liusong@linux.alibaba.com>,
        Hillf Danton <hdanton@sina.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH next v3] sbitmap: fix lockup while swapping
In-Reply-To: <20220929083939.ioytch563qikyflz@quack3>
Message-ID: <9c2038a7-cdc5-5ee-854c-fbc6168bf16@google.com>
References: <d83885c9-2635-ef45-2ccc-a7e06421e1cc@google.com> <Yy4D54kPpenBkjHz@kbusch-mbp.dhcp.thefacebook.com> <391b1763-7146-857-e3b6-dc2a8e797162@google.com> <929a3aba-72b0-5e-5b80-824a2b7f5dc7@google.com> <20220926114416.t7t65u66ze76aiz7@quack3>
 <4539e48-417-edae-d42-9ef84602af0@google.com> <20220927103123.cvjbdx6lqv7jxa2w@quack3> <2b931ee7-1bc9-e389-9d9f-71eb778dcf1@google.com> <f975dddf-6ec-b3cb-3746-e91f61b22ea@google.com> <9f68731-e699-5679-6a71-77634767b8dd@google.com>
 <20220929083939.ioytch563qikyflz@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 4acb83417cad ("sbitmap: fix batched wait_cnt accounting")
is a big improvement: without it, I had to revert to before commit
040b83fcecfb ("sbitmap: fix possible io hung due to lost wakeup")
to avoid the high system time and freezes which that had introduced.

Now okay on the NVME laptop, but 4acb83417cad is a disaster for heavy
swapping (kernel builds in low memory) on another: soon locking up in
sbitmap_queue_wake_up() (into which __sbq_wake_up() is inlined), cycling
around with waitqueue_active() but wait_cnt 0 .  Here is a backtrace,
showing the common pattern of outer sbitmap_queue_wake_up() interrupted
before setting wait_cnt 0 back to wake_batch (in some cases other CPUs
are idle, in other cases they're spinning for a lock in dd_bio_merge()):

sbitmap_queue_wake_up < sbitmap_queue_clear < blk_mq_put_tag <
__blk_mq_free_request < blk_mq_free_request < __blk_mq_end_request <
scsi_end_request < scsi_io_completion < scsi_finish_command <
scsi_complete < blk_complete_reqs < blk_done_softirq < __do_softirq <
__irq_exit_rcu < irq_exit_rcu < common_interrupt < asm_common_interrupt <
_raw_spin_unlock_irqrestore < __wake_up_common_lock < __wake_up <
sbitmap_queue_wake_up < sbitmap_queue_clear < blk_mq_put_tag <
__blk_mq_free_request < blk_mq_free_request < dd_bio_merge <
blk_mq_sched_bio_merge < blk_mq_attempt_bio_merge < blk_mq_submit_bio <
__submit_bio < submit_bio_noacct_nocheck < submit_bio_noacct <
submit_bio < __swap_writepage < swap_writepage < pageout <
shrink_folio_list < evict_folios < lru_gen_shrink_lruvec <
shrink_lruvec < shrink_node < do_try_to_free_pages < try_to_free_pages <
__alloc_pages_slowpath < __alloc_pages < folio_alloc < vma_alloc_folio <
do_anonymous_page < __handle_mm_fault < handle_mm_fault <
do_user_addr_fault < exc_page_fault < asm_exc_page_fault

See how the process-context sbitmap_queue_wake_up() has been interrupted,
after bringing wait_cnt down to 0 (and in this example, after doing its
wakeups), before advancing wake_index and refilling wake_cnt: an
interrupt-context sbitmap_queue_wake_up() of the same sbq gets stuck.

I have almost no grasp of all the possible sbitmap races, and their
consequences: but __sbq_wake_up() can do nothing useful while wait_cnt 0,
so it is better if sbq_wake_ptr() skips on to the next ws in that case:
which fixes the lockup and shows no adverse consequence for me.

The check for wait_cnt being 0 is obviously racy, and ultimately can lead
to lost wakeups: for example, when there is only a single waitqueue with
waiters.  However, lost wakeups are unlikely to matter in these cases,
and a proper fix requires redesign (and benchmarking) of the batched
wakeup code: so let's plug the hole with this bandaid for now.

Signed-off-by: Hugh Dickins <hughd@google.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
v2: - v1 to __sbq_wake_up() broke out when this happens, but
      v2 to sbq_wake_ptr() does better by skipping on to the next.
    - added more comment and deleted dubious Fixes attribution.
    - and apologies to Mr Axboe and all for my axbod typo
v3: add paragraph of comment and Reviewed-by Jan Kara: thanks.

 lib/sbitmap.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/lib/sbitmap.c
+++ b/lib/sbitmap.c
@@ -587,7 +587,7 @@ static struct sbq_wait_state *sbq_wake_p
 	for (i = 0; i < SBQ_WAIT_QUEUES; i++) {
 		struct sbq_wait_state *ws = &sbq->ws[wake_index];
 
-		if (waitqueue_active(&ws->wait)) {
+		if (waitqueue_active(&ws->wait) && atomic_read(&ws->wait_cnt)) {
 			if (wake_index != atomic_read(&sbq->wake_index))
 				atomic_set(&sbq->wake_index, wake_index);
 			return ws;
