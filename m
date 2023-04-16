Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 669E16E3578
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 08:41:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbjDPGlj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 02:41:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbjDPGlh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 02:41:37 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A56F8FB;
        Sat, 15 Apr 2023 23:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=feNbonEkJBZpWgMwe8jt6vuLvISXrUj/SEXS0kUAnlc=; b=uI2vWvZiRzbowyrTuwWuv3DGFt
        wJPQJ+LEhJc1KTs+6wAShf2paCygyaRrvABmu2+l1jqQNg3PhICDLlhr50BtqIoL9D5mnXRCDCmVh
        dUzkbSV0gkiuxdN0MWKYXzIiqiJXk6at5GkEiw/0CeJ8IFzH9R92b9QO8L3YR6OJAU0sTwO1mMjpP
        KoF2uPLBtgHoqzG/vDxlgkUqzer3SIp30WRSrnF3AgP2b05g7mzOZrm3GEtkFGHhDLQ2DTi5GmUXP
        amW2thIB4qoG7Rr/csp8axVft5ZI+cm1c2Ix6nBhjiM2fdNh3Sfwk+izpgnFjejiMctGJRn/d6+TV
        wKqo2Hsg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pnw4m-00DFIg-2j;
        Sun, 16 Apr 2023 06:41:28 +0000
Date:   Sat, 15 Apr 2023 23:41:28 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Christoph Hellwig <hch@infradead.org>,
        Kees Cook <keescook@chromium.org>
Cc:     david@redhat.com, patches@lists.linux.dev,
        linux-modules@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, pmladek@suse.com,
        petr.pavlu@suse.com, prarit@redhat.com,
        torvalds@linux-foundation.org, gregkh@linuxfoundation.org,
        rafael@kernel.org, christophe.leroy@csgroup.eu, tglx@linutronix.de,
        peterz@infradead.org, song@kernel.org, rppt@kernel.org,
        dave@stgolabs.net, willy@infradead.org, vbabka@suse.cz,
        mhocko@suse.com, dave.hansen@linux.intel.com,
        colin.i.king@gmail.com, jim.cromie@gmail.com,
        catalin.marinas@arm.com, jbaron@akamai.com,
        rick.p.edgecombe@intel.com
Subject: Re: [RFC 2/2] kread: avoid duplicates
Message-ID: <ZDuYmPB5oqKQLcQd@bombadil.infradead.org>
References: <20230414052840.1994456-1-mcgrof@kernel.org>
 <20230414052840.1994456-3-mcgrof@kernel.org>
 <ZDuP3OCzN3x4NxRZ@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZDuP3OCzN3x4NxRZ@infradead.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 15, 2023 at 11:04:12PM -0700, Christoph Hellwig wrote:
> On Thu, Apr 13, 2023 at 10:28:40PM -0700, Luis Chamberlain wrote:
> > With this we run into 0 wasted virtual memory bytes.
> 
> Avoid what duplicates?

David Hildenbrand had reported that with over 400 CPUs vmap space
runs out and it seems it was related to module loading. I took a
look and confirmed it. Module loading ends up requiring in the
worst case 3 vmalloc allocations, so typically at least twice
the size of the module size and in the worst case just add
the decompressed module size:

a) initial kernel_read*() call
b) optional module decompression
c) the actual module data copy we will keep

Duplicate module requests that come from userspace end up being thrown
in the trash bin, as only one module will be allocated.  Although there
are checks for a module prior to requesting a module udev still doesn't
do the best of a job to avoid that and so we end up with tons of
duplicate module requests. We're talking about gigabytes of vmalloc
bytes just lost because of this for large systems and megabytes for
average systems. So for example with just 255 CPUs we can loose about
13.58 GiB, and for 8 CPUs about 226.53 MiB.

I have patches to curtail 1/2 of that space by doing a check in kernel
before we do the allocation in c) if the module is already present. For
a) it is harder because userspace just passes a file descriptor. But
since we can get the file path without the vmalloc this RFC suggest
maybe we can add a new kernel_read*() for module loading where it makes
sense to have only one read happen at a time.

  Luis
