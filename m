Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E690618424
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 17:21:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231300AbiKCQVa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 12:21:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230341AbiKCQV0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 12:21:26 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAD8A183AE
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 09:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=0pgsoR6kkQjgxI+bNREy0AsEnu3e8l5TxjpkPZ5IsoQ=; b=H0SmUpIA13SzlED0mDkPpr2pF8
        Q71rHK1fFRCG9uT3DnOl4qMQDvZBkWQ/+/bBtzIwqC0oeyKpArlNMaqNY0ON9B40MXkYio9+SRfGi
        u1tS0iFAGQzWM7pYUE9iHwh/J9WvGD4RbU36s17mm9YCJjlAdydYjIYKKxkVGY6AFcXtmJtzvgwXF
        guK398GkHIqgdtRXsaF5TEHICUl+plwgGeOOE4U8D5EMPkJ1xV/nDUDbNwAg2mIuROh+JhcmIFbKW
        Gy46CGjBoXuvD9Z+x/LAvsZU2hnORpXvOg4HKQYckisY7Hl6H9O3dG1sGODMKp2sqjtLI8PAeiJ1b
        kMfPWxAQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oqcy6-006az9-44; Thu, 03 Nov 2022 16:21:26 +0000
Date:   Thu, 3 Nov 2022 16:21:26 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Thorsten Leemhuis <regressions@leemhuis.info>
Cc:     LKML <linux-kernel@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mikhail Pletnev <mmp.dux@gmail.com>
Subject: Re: [REGRESSION] Bug 216646 - having TRANSPARENT_HUGEPAGE enabled
 hangs some applications
Message-ID: <Y2Pqhr1DFgHP1dsg@casper.infradead.org>
References: <37cd0a8d-bbd1-baf3-9c37-0cb8325b4cb3@leemhuis.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <37cd0a8d-bbd1-baf3-9c37-0cb8325b4cb3@leemhuis.info>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 03, 2022 at 02:51:48PM +0100, Thorsten Leemhuis wrote:
> Hi, this is your Linux kernel regression tracker speaking.
> 
> Matthew, I noticed a regression report in bugzilla.kernel.org. As many
> (most?) kernel developer don't keep an eye on it, I decided to forward
> it by mail. Quoting from

Thanks, Thorsten.  I had no idea this issue had been filed.  The sooner
kernel bug tracking switches to something useful like debbugs, the better.

> https://bugzilla.kernel.org/show_bug.cgi?id=216646 :
> 
> >  Mikhail Pletnev 2022-11-01 02:43:59 UTC
> > 
> > Created attachment 303112 [details]
> > dmesg error
> > 
> > After updating kernel past 5.17 (checked in 5.19, 6.06), deluge torrent client began to hang after 1-4 hours of runtime, (when under heavy load - thousands of files mmapped and read at 20+MB/s) with following message in dmesg:
> >   
> > BUG: kernel NULL pointer dereference, address: 0000000000000096
> > #PF: supervisor read access in kernel mode
> > #PF: error_code(0x0000) - not-present page
> > PGD 0 P4D 0
> > Oops: 0000 [#1] PREEMPT SMP NOPTI
> > CPU: 15 PID: 8263 Comm: Disk Not tainted 5.17.0-rc4_ap-00165-g56a4d67c264e-dirty #36
> > Hardware name: Micro-Star International Co., Ltd. MS-7C35/MEG X570 UNIFY (MS-7C35), BIOS A.C3 03/15/2022
> > RIP: 0010:__filemap_get_folio+0x9e/0x350
> > Code: 10 e8 46 06 68 00 48 89 c3 48 3d 02 04 00 00 74 e2 48 3d 06 04 00 00 74 da 48 85 c0 0f 84 3e 02 00 00 a8 01 0f 85 40 02 00 00 <8b> 40 34 85 c0 74 c2 8d 50 01 f0 0f b1 53 34 75 f2 48 8b 54 24 28
> > RSP: 0000:ffffbe1044ad3cb0 EFLAGS: 00010246
> > RAX: 0000000000000062 RBX: 0000000000000062 RCX: 0000000000000002
> > RDX: 000000000000001c RSI: ffffbe1044ad3cc0 RDI: ffff9fca83239ff0
> > RBP: 0000000000000000 R08: ffffbe1044ad3d40 R09: 0000000000000000
> > R10: ffffffffffffffc0 R11: 0000000000000000 R12: 0000000000000000
> > R13: ffff9fcbee9efa78 R14: 000000000004285e R15: fff000003fffffff
> > FS:  00007f0a763fc640(0000) GS:ffff9fd23edc0000(0000) knlGS:0000000000000000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 0000000000000096 CR3: 0000000122c60000 CR4: 0000000000750ee0

Very interesting.  The code disassembles to:

   9:	48 3d 02 04 00 00    	cmp    $0x402,%rax
   f:	74 e2                	je     0xfffffffffffffff3
  11:	48 3d 06 04 00 00    	cmp    $0x406,%rax
  17:	74 da                	je     0xfffffffffffffff3
  19:	48 85 c0             	test   %rax,%rax
  1c:	0f 84 3e 02 00 00    	je     0x260
  22:	a8 01                	test   $0x1,%al
  24:	0f 85 40 02 00 00    	jne    0x26a
  2a:*	8b 40 34             	mov    0x34(%rax),%eax		<-- trapping instruction
  2d:	85 c0                	test   %eax,%eax
  2f:	74 c2                	je     0xfffffffffffffff3

which I recognise as this part of mapping_get_entry() (must have been
inlined into __filemap_get_folio() -- in future, it helps enormously
if you can run the trace through scripts/decode_stacktrace.sh)

        folio = xas_load(&xas);
        if (xas_retry(&xas, folio))
                goto repeat;
        /*
         * A shadow entry of a recently evicted page, or a swap entry from
         * shmem/tmpfs.  Return it without attempting to raise page count.
         */
        if (!folio || xa_is_value(folio))
                goto out;

        if (!folio_try_get_rcu(folio))
                goto repeat;

The trap happens when we attempt to load from offset 0x34 of rax
-- the refcount field of struct folio.  And rax is 0x62 instead of
being a valid pointer.  This should not be possible; 0x62 is used to
represent a "sibling entry" in the XArray that underlies the page cache.
xas_descend() checks if you hit a sibling entry, and if you did, it
loads the canonical entry instead.

The only way I can see this happening is if there's a sibling entry
pointing to another sibling entry.  What I don't know is whether your
machine is experiencing a temporary glitch in the tree (because it's RCU
protected, it might be observing a store in progress) or whether it has
a corrupted tree where one sibling entry is pointing to another and this
will be observable by any future load (until something happens to
overwrite these entries in the cache).

> > git bisect good 1854bc6e2420472676c5c90d3d6b15f6cd640e40

I suspect this is where your bisection went astray.  This should have
been bad and it led you to the wrong commit.

