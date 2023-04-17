Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B11D6E548F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 00:08:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230347AbjDQWIr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 18:08:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229838AbjDQWIq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 18:08:46 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 108DA1B4;
        Mon, 17 Apr 2023 15:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
        bh=Cl/KOggIUYwh125y+9YwbpbwhMMF2Br/gvzyehMp5l4=; b=oeViYi4RB8m0SpCud7goSGJLhY
        p9mePiQHwRTyX2C9LAmhxB6gnq7TJJIDRzwaAKAeDCt8WsuoaEVbjrwb1G3OIFH9HsUtWwnTCEVi8
        3xHbCv2+vpPhAahrADkj0pPHkhPXmTvr/uf2Cof/fVZAMBSe/Fe8/FyHnxKQGuZzy081Yan/kdI2W
        wAN2iF6yC2b9JekfZ8nftG5JzEJisniUBvCNvaD7cKVxg8ctSATi682rFhbTjAdRWelfJYesO1AaN
        HEz9Gwcrgw1WyOaMMIDblI+04xI67UexrokU28LEWBtVKVzn3yLnErnYVGk8BXNI6dXZGBqxNmNr9
        a3K6ijWA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1poX1W-000Emt-2k;
        Mon, 17 Apr 2023 22:08:34 +0000
Date:   Mon, 17 Apr 2023 15:08:34 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc:     "keescook@chromium.org" <keescook@chromium.org>,
        "hch@infradead.org" <hch@infradead.org>,
        "prarit@redhat.com" <prarit@redhat.com>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "Torvalds, Linus" <torvalds@linux-foundation.org>,
        "willy@infradead.org" <willy@infradead.org>,
        "song@kernel.org" <song@kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>,
        "pmladek@suse.com" <pmladek@suse.com>,
        "david@redhat.com" <david@redhat.com>,
        "colin.i.king@gmail.com" <colin.i.king@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "jim.cromie@gmail.com" <jim.cromie@gmail.com>,
        "vbabka@suse.cz" <vbabka@suse.cz>,
        "christophe.leroy@csgroup.eu" <christophe.leroy@csgroup.eu>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "jbaron@akamai.com" <jbaron@akamai.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "petr.pavlu@suse.com" <petr.pavlu@suse.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "Hocko, Michal" <mhocko@suse.com>,
        "dave@stgolabs.net" <dave@stgolabs.net>
Subject: Re: [RFC 2/2] kread: avoid duplicates
Message-ID: <ZD3DYqYE4DOiJQaS@bombadil.infradead.org>
References: <20230414052840.1994456-1-mcgrof@kernel.org>
 <20230414052840.1994456-3-mcgrof@kernel.org>
 <ZDuP3OCzN3x4NxRZ@infradead.org>
 <ZDuYmPB5oqKQLcQd@bombadil.infradead.org>
 <be5182b65384f6a7667c239134037649a468033d.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <be5182b65384f6a7667c239134037649a468033d.camel@intel.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 17, 2023 at 05:33:49PM +0000, Edgecombe, Rick P wrote:
> On Sat, 2023-04-15 at 23:41 -0700, Luis Chamberlain wrote:
> > On Sat, Apr 15, 2023 at 11:04:12PM -0700, Christoph Hellwig wrote:
> > > On Thu, Apr 13, 2023 at 10:28:40PM -0700, Luis Chamberlain wrote:
> > > > With this we run into 0 wasted virtual memory bytes.
> > > 
> > > Avoid what duplicates?
> > 
> > David Hildenbrand had reported that with over 400 CPUs vmap space
> > runs out and it seems it was related to module loading. I took a
> > look and confirmed it. Module loading ends up requiring in the
> > worst case 3 vmalloc allocations, so typically at least twice
> > the size of the module size and in the worst case just add
> > the decompressed module size:
> > 
> > a) initial kernel_read*() call
> > b) optional module decompression
> > c) the actual module data copy we will keep
> > 
> > Duplicate module requests that come from userspace end up being
> > thrown
> > in the trash bin, as only one module will be allocated.  Although
> > there
> > are checks for a module prior to requesting a module udev still
> > doesn't
> > do the best of a job to avoid that and so we end up with tons of
> > duplicate module requests. We're talking about gigabytes of vmalloc
> > bytes just lost because of this for large systems and megabytes for
> > average systems. So for example with just 255 CPUs we can loose about
> > 13.58 GiB, and for 8 CPUs about 226.53 MiB.
> > 
> > I have patches to curtail 1/2 of that space by doing a check in
> > kernel
> > before we do the allocation in c) if the module is already present.
> > For
> > a) it is harder because userspace just passes a file descriptor. But
> > since we can get the file path without the vmalloc this RFC suggest
> > maybe we can add a new kernel_read*() for module loading where it
> > makes
> > sense to have only one read happen at a time.
> 
> I'm wondering how difficult it would be to just try to remove the
> vmallocs in (a) and (b) and operate on a list of pages.

Yes I think it's worth long term to do that, if possible with seq reads.

  Luis
