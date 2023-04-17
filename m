Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F7466E3F5A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 08:05:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbjDQGFi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 02:05:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjDQGFg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 02:05:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B87A2116;
        Sun, 16 Apr 2023 23:05:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ECEAE61E24;
        Mon, 17 Apr 2023 06:05:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0DCDC433D2;
        Mon, 17 Apr 2023 06:05:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1681711534;
        bh=NwGailapraVjI3JxBj0hy2nPk+sbOBpvNBegUBFYK60=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NaVp702ncCjgvIBQuBUWkcim7cOoz9Cwe0ShV77d9SaBO8XpvXvpMCnZPzCqbX7/h
         craG63gOX8mL5t6mVrSxVDRLyqNvD23VPPqXzDs3S9SVnNWbD6L65Yz2uKJGbut4RU
         F/l9kAWcIA2TQO429FaSTKVa8ffpaWZo68MT8GkU=
Date:   Mon, 17 Apr 2023 08:05:31 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Kees Cook <keescook@chromium.org>, david@redhat.com,
        patches@lists.linux.dev, linux-modules@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org, pmladek@suse.com,
        petr.pavlu@suse.com, prarit@redhat.com,
        torvalds@linux-foundation.org, rafael@kernel.org,
        christophe.leroy@csgroup.eu, tglx@linutronix.de,
        peterz@infradead.org, song@kernel.org, rppt@kernel.org,
        dave@stgolabs.net, willy@infradead.org, vbabka@suse.cz,
        mhocko@suse.com, dave.hansen@linux.intel.com,
        colin.i.king@gmail.com, jim.cromie@gmail.com,
        catalin.marinas@arm.com, jbaron@akamai.com,
        rick.p.edgecombe@intel.com
Subject: Re: [RFC 2/2] kread: avoid duplicates
Message-ID: <ZDzhqxShqmmQOKjU@kroah.com>
References: <20230414052840.1994456-1-mcgrof@kernel.org>
 <20230414052840.1994456-3-mcgrof@kernel.org>
 <ZDuP3OCzN3x4NxRZ@infradead.org>
 <ZDuYmPB5oqKQLcQd@bombadil.infradead.org>
 <2023041637-glamorous-appetite-dc12@gregkh>
 <ZDxClHwnTNqtuSbD@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZDxClHwnTNqtuSbD@bombadil.infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 16, 2023 at 11:46:44AM -0700, Luis Chamberlain wrote:
> On Sun, Apr 16, 2023 at 02:50:01PM +0200, Greg KH wrote:
> > On Sat, Apr 15, 2023 at 11:41:28PM -0700, Luis Chamberlain wrote:
> > > On Sat, Apr 15, 2023 at 11:04:12PM -0700, Christoph Hellwig wrote:
> > > > On Thu, Apr 13, 2023 at 10:28:40PM -0700, Luis Chamberlain wrote:
> > > > > With this we run into 0 wasted virtual memory bytes.
> > > > 
> > > > Avoid what duplicates?
> > > 
> > > David Hildenbrand had reported that with over 400 CPUs vmap space
> > > runs out and it seems it was related to module loading. I took a
> > > look and confirmed it. Module loading ends up requiring in the
> > > worst case 3 vmalloc allocations, so typically at least twice
> > > the size of the module size and in the worst case just add
> > > the decompressed module size:
> > > 
> > > a) initial kernel_read*() call
> > > b) optional module decompression
> > > c) the actual module data copy we will keep
> > > 
> > > Duplicate module requests that come from userspace end up being thrown
> > > in the trash bin, as only one module will be allocated.  Although there
> > > are checks for a module prior to requesting a module udev still doesn't
> > > do the best of a job to avoid that and so we end up with tons of
> > > duplicate module requests. We're talking about gigabytes of vmalloc
> > > bytes just lost because of this for large systems and megabytes for
> > > average systems. So for example with just 255 CPUs we can loose about
> > > 13.58 GiB, and for 8 CPUs about 226.53 MiB.
> > 
> > How does the memory get "lost"?  Shouldn't it be properly freed when the
> > duplicate module load fails?
> 
> Yes memory gets freed, but since virtual memory space can be limitted it
> also means you can end up eventually getting to the point -ENOMEMs will
> happen as you have more CPUS and you cannot use virtual memory for other
> things during kernel bootup and bootup fails. This is apparently
> exacerbated with KASAN enabled.

Then why not just rate-limit the module loader in userspace on such
large systems if that's an issue?  No kernel changes needed to do that.

thanks,

greg k-h
