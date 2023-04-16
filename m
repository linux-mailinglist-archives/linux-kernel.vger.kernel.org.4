Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C1266E3860
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 14:50:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230452AbjDPMuH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 08:50:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230390AbjDPMuF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 08:50:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6FF291;
        Sun, 16 Apr 2023 05:50:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5E13960F93;
        Sun, 16 Apr 2023 12:50:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51E98C433D2;
        Sun, 16 Apr 2023 12:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1681649403;
        bh=PwY8QWEnWV0M5kBQ/d61GJUA7etUYjtwdP2PeGi83jg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WVwshLYWCaDWOj6I/QRtAs/yHt1ux/16OP37Q3wiITFXaf7+bxrYH3clC8fGicqQr
         HaIExs38ECYGHaOFFGiq/E0UMNEGl30mUc1+Y/qm7LVe1V8YRt4j+QAqyHrzS1B2jV
         sspAKw1EkdCgNXBZXsE0iip8qskxYPygTi/2b4Wc=
Date:   Sun, 16 Apr 2023 14:50:01 +0200
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
Message-ID: <2023041637-glamorous-appetite-dc12@gregkh>
References: <20230414052840.1994456-1-mcgrof@kernel.org>
 <20230414052840.1994456-3-mcgrof@kernel.org>
 <ZDuP3OCzN3x4NxRZ@infradead.org>
 <ZDuYmPB5oqKQLcQd@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZDuYmPB5oqKQLcQd@bombadil.infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 15, 2023 at 11:41:28PM -0700, Luis Chamberlain wrote:
> On Sat, Apr 15, 2023 at 11:04:12PM -0700, Christoph Hellwig wrote:
> > On Thu, Apr 13, 2023 at 10:28:40PM -0700, Luis Chamberlain wrote:
> > > With this we run into 0 wasted virtual memory bytes.
> > 
> > Avoid what duplicates?
> 
> David Hildenbrand had reported that with over 400 CPUs vmap space
> runs out and it seems it was related to module loading. I took a
> look and confirmed it. Module loading ends up requiring in the
> worst case 3 vmalloc allocations, so typically at least twice
> the size of the module size and in the worst case just add
> the decompressed module size:
> 
> a) initial kernel_read*() call
> b) optional module decompression
> c) the actual module data copy we will keep
> 
> Duplicate module requests that come from userspace end up being thrown
> in the trash bin, as only one module will be allocated.  Although there
> are checks for a module prior to requesting a module udev still doesn't
> do the best of a job to avoid that and so we end up with tons of
> duplicate module requests. We're talking about gigabytes of vmalloc
> bytes just lost because of this for large systems and megabytes for
> average systems. So for example with just 255 CPUs we can loose about
> 13.58 GiB, and for 8 CPUs about 226.53 MiB.

How does the memory get "lost"?  Shouldn't it be properly freed when the
duplicate module load fails?

thanks,

greg k-h
