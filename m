Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FBA5725136
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 02:44:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240223AbjFGAox (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 20:44:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240199AbjFGAow (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 20:44:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A642189;
        Tue,  6 Jun 2023 17:44:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 05FC563883;
        Wed,  7 Jun 2023 00:44:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26C02C433D2;
        Wed,  7 Jun 2023 00:44:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1686098689;
        bh=3EeHZ4T5sQYFK1X65ZcRtfRnTzjIOr2uear3tASVXN0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=PPdlf6pcwZN6x7/s/Op8E7m9lBP4cBra/8eILhxHxOP3HSHyRQ62T1r31Gy9qqi6C
         9eDK0CcB4/pKaItcoIMILjKdue0f528MQJyQVtyYm7xSS6Dn02JT6a2q5yXASCmjtP
         ABpdXgJvg4gYjsmHrNSOz9XxkPPUvW8JziaxczMQ=
Date:   Tue, 6 Jun 2023 17:44:48 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Rafael Aquini <aquini@redhat.com>
Cc:     Yafang Shao <laoar.shao@gmail.com>, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, linux-mm@kvack.org,
        stable@vger.kernel.org, Aristeu Rozanski <aris@redhat.com>
Subject: Re: [PATCH] writeback: fix dereferencing NULL mapping->host on
 writeback_page_template
Message-Id: <20230606174448.ba45510067bcb35b9ac7e739@linux-foundation.org>
In-Reply-To: <20230606233613.1290819-1-aquini@redhat.com>
References: <20230606233613.1290819-1-aquini@redhat.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  6 Jun 2023 19:36:13 -0400 Rafael Aquini <aquini@redhat.com> wrote:

> When commit 19343b5bdd16 ("mm/page-writeback: introduce tracepoint for
> wait_on_page_writeback()") repurposed the writeback_dirty_page trace event
> as a template to create its new wait_on_page_writeback trace event, it
> ended up opening a window to NULL pointer dereference crashes due to
> the (infrequent) occurrence of a race where an access to a page in the
> swap-cache happens concurrently with the moment this page is being
> written to disk and the tracepoint is enabled:

I don't see what the race is, or why a race is involved.

>     BUG: kernel NULL pointer dereference, address: 0000000000000040
>     #PF: supervisor read access in kernel mode
>     #PF: error_code(0x0000) - not-present page
>     PGD 800000010ec0a067 P4D 800000010ec0a067 PUD 102353067 PMD 0
>     Oops: 0000 [#1] PREEMPT SMP PTI
>     CPU: 1 PID: 1320 Comm: shmem-worker Kdump: loaded Not tainted 6.4.0-rc5+ #13
>     Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS edk2-20230301gitf80f052277c8-1.fc37 03/01/2023
>     RIP: 0010:trace_event_raw_event_writeback_folio_template+0x76/0xf0
>     Code: 4d 85 e4 74 5c 49 8b 3c 24 e8 06 98 ee ff 48 89 c7 e8 9e 8b ee ff ba 20 00 00 00 48 89 ef 48 89 c6 e8 fe d4 1a 00 49 8b 04 24 <48> 8b 40 40 48 89 43 28 49 8b 45 20 48 89 e7 48 89 43 30 e8 a2 4d
>     RSP: 0000:ffffaad580b6fb60 EFLAGS: 00010246
>     RAX: 0000000000000000 RBX: ffff90e38035c01c RCX: 0000000000000000
>     RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff90e38035c044
>     RBP: ffff90e38035c024 R08: 0000000000000002 R09: 0000000000000006
>     R10: ffff90e38035c02e R11: 0000000000000020 R12: ffff90e380bac000
>     R13: ffffe3a7456d9200 R14: 0000000000001b81 R15: ffffe3a7456d9200
>     FS:  00007f2e4e8a15c0(0000) GS:ffff90e3fbc80000(0000) knlGS:0000000000000000
>     CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>     CR2: 0000000000000040 CR3: 00000001150c6003 CR4: 0000000000170ee0
>     Call Trace:
>      <TASK>
>      ? __die+0x20/0x70
>      ? page_fault_oops+0x76/0x170
>      ? kernelmode_fixup_or_oops+0x84/0x110
>      ? exc_page_fault+0x65/0x150
>      ? asm_exc_page_fault+0x22/0x30
>      ? trace_event_raw_event_writeback_folio_template+0x76/0xf0
>      folio_wait_writeback+0x6b/0x80
>      shmem_swapin_folio+0x24a/0x500

shmem_swapin_folio->folio_wait_writeback will always pass in a page
which has ->mapping==NULL, won't it?  So why doesn't it crash every
time?

>      ? filemap_get_entry+0xe3/0x140
>      shmem_get_folio_gfp+0x36e/0x7c0
>      ? find_busiest_group+0x43/0x1a0
>      shmem_fault+0x76/0x2a0
>      ? __update_load_avg_cfs_rq+0x281/0x2f0
>      __do_fault+0x33/0x130
>      do_read_fault+0x118/0x160
>      do_pte_missing+0x1ed/0x2a0
>      __handle_mm_fault+0x566/0x630
>      handle_mm_fault+0x91/0x210
>      do_user_addr_fault+0x22c/0x740
>      exc_page_fault+0x65/0x150
>      asm_exc_page_fault+0x22/0x30
> 
> This problem arises from the fact that the repurposed writeback_dirty_page
> trace event code was written assuming that every pointer to mapping
> (struct address_space) would come from a file-mapped page-cache object,
> thus mapping->host would always be populated, and that was a valid case
> before commit 19343b5bdd16. The swap-cache address space (swapper_spaces),
> however, doesn't populate its ->host (struct inode) pointer, thus leading
> to the crashes in the corner-case aforementioned.
> 
> commit 19343b5bdd16 ended up breaking the assignment of __entry->name and
> __entry->ino for the wait_on_page_writeback tracepoint -- both dependent
> on mapping->host carrying a pointer to a valid inode. The assignment of
> __entry->name was fixed by commit 68f23b89067f ("memcg: fix a crash in
> wb_workfn when a device disappears"), and this commit fixes the remaining
> case, for __entry->ino.

