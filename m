Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 855FC65B452
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 16:38:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236165AbjABPhq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 10:37:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232151AbjABPhn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 10:37:43 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ABEF9591
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 07:37:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=v1FPN1zhOA/rNihICtkkoeofxrQJhRo5+wZftDoLpWA=; b=daE4OMDE5CSo0420kntsgynIKZ
        8ngW24zDqHnfLO2wI09Qf+5ya79iclgI7eOOjaEju0oK9R5Hb2uxrAFgIaGkwHINKCZmHXQVeRONs
        UXIvlh4vV/BTKF03gvjMbj1IIGRpiSzFARP1zycXb3UFcJiRlcFH3XTT53erQvUTo8sFQ5ewnOBLB
        lc1QgYJWik8pnUnaXAh2ExPTdbeFBMPPKWbPPvxTiJbsyx6ZS/6giFtmE75cfgdDYfu82Y7yQG2dk
        Uv7q3ftQ7VC5r/aIHi3v4Lguv22h/5+/zy0pxRC1t2jA4F/6dW5zHWQiT6A4UOnO9BHyEVahDUXRT
        CIuPihEQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pCMsW-00DGpH-9K; Mon, 02 Jan 2023 15:37:32 +0000
Date:   Mon, 2 Jan 2023 15:37:32 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Hillf Danton <hdanton@sina.com>,
        syzbot <syzbot+bed15dbf10294aa4f2ae@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Waiman Long <longman@redhat.com>,
        syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [ntfs3?] INFO: task hung in do_user_addr_fault (3)
Message-ID: <Y7L6PJuMVtEJUsj6@casper.infradead.org>
References: <00000000000060d41f05f139aa44@google.com>
 <20230102005409.3474-1-hdanton@sina.com>
 <CAHk-=wim+_xutuWdeykqM34EQxbE3As7+91L5uEVLUCXbUL1CA@mail.gmail.com>
 <6383cde5-cf4b-facf-6e07-1378a485657d@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6383cde5-cf4b-facf-6e07-1378a485657d@I-love.SAKURA.ne.jp>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 02, 2023 at 05:24:24PM +0900, Tetsuo Handa wrote:
> Since no lockdep annotation is used for e.g. PG_locked bit, this deadlock
> cannot be detected by lockdep...

lockdep, unfortunately, cannot track PG_locked.  Lockdep requires that
the lock is released by the acquirer, and sometimes that's true for
PG_locked, but when it's used to do I/O, the PG_locked bit is released
in interrupt/BH context.  We could maybe fake it by pretending we release
the folio lock when we submit the I/O.  Then we'll have to figure out
how to tell lockdep that it's OK to grab the folio lock multiple times
(if within the same inode, ordered by folio->index; if in different
inodes, ordered by in-memory address of those inodes), and that
submitting an I/O will unlock all of the folios in that I/O.  Oh, but
there's cases where we only submit part of a folio in an I/O, and the
lock will only be released when all of the I/Os targetting that folio
have been completed.

It's not impossible, but it is a lot of work and needs a lot of
understanding of filesystems/mm/io.
