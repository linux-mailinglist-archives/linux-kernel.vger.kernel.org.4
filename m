Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D9EB693285
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 17:37:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbjBKQhS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Feb 2023 11:37:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbjBKQhM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Feb 2023 11:37:12 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 137B7234CB;
        Sat, 11 Feb 2023 08:37:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A97CFB80952;
        Sat, 11 Feb 2023 16:37:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2D7FC433A0;
        Sat, 11 Feb 2023 16:37:02 +0000 (UTC)
Date:   Sat, 11 Feb 2023 11:37:00 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Mukesh Ojha <quic_mojha@quicinc.com>
Cc:     <zhengyejian1@huawei.com>, <linux-kernel@vger.kernel.org>,
        <linux-trace-kernel@vger.kernel.org>, <wanghai38@huawei.com>
Subject: Re: [PATCH] tracing/ring-buffer: Remove integrity check at end of
 iter read
Message-ID: <20230211113700.40728a05@gandalf.local.home>
In-Reply-To: <1676042556-737-1-git-send-email-quic_mojha@quicinc.com>
References: <20230208090814.869242-1-zhengyejian1@huawei.com>
        <1676042556-737-1-git-send-email-quic_mojha@quicinc.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Feb 2023 20:52:36 +0530
Mukesh Ojha <quic_mojha@quicinc.com> wrote:

> >> 		return -1;
> >> 
> >> 	list_for_each_entry_safe(bpage, tmp, head, list) {  
> >
> >I'd like to know if there is a case that "head" happens to be a
> >"reader_page", and the ring buffer is not exactly being traversed?  

No, the way it works is that the reader page is found by searching for the
head pointer, and then it is set when swapped. Basically, the pseudo code
is:

  reader->next = head_page | HEAD_FLAG
  val = head_page->prev->next
  val &= ~FLAGS
  val |= HEAD_FLAG
  cmpxchg(head_page->prev->next, val, reader)

The HEAD_FLAG is always on the pointer that points to the head page that
gets swapped. This will never point to the reader page, as that would mean
the writer has access to it.

> 
> In my issue, i see below callstack and it seem to be spinning inside rb_list_head_clear() as
> cpu_buffer->pages has duplicate entry in the list.
> 
> -00 |rb_list_head_clear(inline)
> -00 |rb_head_page_deactivate(inline)
> -00 |rb_check_pages(cpu_buffer = 0xFFFFFF89E0C3B200)
> -01 |atomic_try_cmpxchg_acquire(inline)
> -01 |queued_spin_lock(inline)
> -01 |do_raw_spin_lock_flags(inline)
> -01 |__raw_spin_lock_irqsave(inline)
> -01 |_raw_spin_lock_irqsave(inline)
> -01 |ring_buffer_read_finish(iter = 0xFFFFFF8006FE3780)
> -02 |cpumask_next(inline)
> -02 |tracing_release(inode = ?, file = 0xFFFFFF8A53A63F00)
> -03 |__fput(file = 0xFFFFFF8A53A63F00)
> -04 |____fput(work = ?)
> -05 |_raw_spin_unlock_irq(inline)
> -05 |task_work_run()
> -06 |tracehook_notify_resume(inline)
> -06 |do_notify_resume(regs = 0xFFFFFFC06ADC8EB0, thread_flags = 67108868)
> -07 |prepare_exit_to_user_mode(inline)
> -07 |exit_to_user_mode(inline)
> -07 |el0_svc(regs = 0xFFFFFFC06ADC8EB0)
> -08 |el0t_64_sync_handler(regs = ?)
> -09 |el0t_64_sync(asm)
> 
> ...
> ..
> ffffff80359eeb00 --> Duplicate entry 
> ffffff80359ee300
> ffffff80359ee180
> ffffff80359eeec0
> ffffff80359eec00
> ffffff80359ee800 -- Tail page
> ffffff80359eedc0 -- Head page
> ffffff80359ee640
> ffffff80359ee080
> ffffff80359ee700
> ffffff80359ee7c0
> ffffff80359eed80
> ffffff80359ee900
> ffffff80359ee9c0
> ffffff80359eea00
> ffffff80359eea80
> ffffff80359eec80
> ffffff80359ee240
> ffffff80359ee6c0
> ffffff80359ee0c0
> ffffff80359ee8c0
> ffffff80359ee940
> ffffff80359eee00
> ffffff80359ee000
> ffffff80359eeb00 ---> Duplicate entry 

So this is a separate issue where the ring buffer is corrupted?

-- Steve
