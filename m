Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07BEB6E85F2
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 01:32:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231612AbjDSXcl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 19:32:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbjDSXcj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 19:32:39 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B03811FD3;
        Wed, 19 Apr 2023 16:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+4elBgltmv+lMcD+HupshMFkFMDfWM+9W5HQXxOjaa4=; b=g+CBeEM+lA6Rsj0oHYQvwzXj+b
        1llNLt64NJTdOIv8eaVlV8JM40rHT30TLRZoLjUGLLZ0DhMIWVPvo85zsIUIb2Z5L/SGKtopab160
        Tl1aD9MteoqR8n9Df/76QnvZzPVi64Ykc8rqD8J2czOBH6m211ANBEj4WOQ5zG+z1hBt7r5EX3dGD
        eLI5c70SzPFEXKlF76bDhKPDqD12Ol4JztS5SRIRaGxqaPggpxsgtZyeCuCAKG85HU3V6XJjBXE/N
        /4ZVLAj/yFt+uibSeqRlQrTxCM1ucOhqw41XCCZOthnTGVLmbrx7vw/51IYD3eDmz/tFU2PiTdhBR
        fDkkbspg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1ppHHq-006fP7-2r;
        Wed, 19 Apr 2023 23:32:30 +0000
Date:   Wed, 19 Apr 2023 16:32:30 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     david@redhat.com, patches@lists.linux.dev,
        linux-modules@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, pmladek@suse.com,
        petr.pavlu@suse.com, prarit@redhat.com,
        torvalds@linux-foundation.org, rafael@kernel.org,
        christophe.leroy@csgroup.eu, tglx@linutronix.de,
        peterz@infradead.org, song@kernel.org, rppt@kernel.org,
        dave@stgolabs.net, willy@infradead.org, vbabka@suse.cz,
        mhocko@suse.com, dave.hansen@linux.intel.com,
        colin.i.king@gmail.com, jim.cromie@gmail.com,
        catalin.marinas@arm.com, jbaron@akamai.com,
        rick.p.edgecombe@intel.com
Subject: Re: [PATCH] module: add debugging auto-load duplicate module support
Message-ID: <ZEB6DmF+l3LVrpFI@bombadil.infradead.org>
References: <20230418204636.791699-1-mcgrof@kernel.org>
 <2023041951-evolution-unwitting-1791@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023041951-evolution-unwitting-1791@gregkh>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 19, 2023 at 09:15:11AM +0200, Greg KH wrote:
> On Tue, Apr 18, 2023 at 01:46:36PM -0700, Luis Chamberlain wrote:
> You get 72 columns for changelog text, so you can use it :)

Sure! I forget what the limit is, but now I won't forget, new vimrc
settings:

set textwidth=100
autocmd FileType gitcommit set textwidth=72 
set colorcolumn=+1

> > +config MODULE_AUTOLOAD_SUPRESS_DUPS
> 
> MODULE_DEBUG_DUPLICATE perhaps?  It has nothing to do with autoloading
> (other than that is what userspace is doing)

I refer to module auto-loading as the kernel's use of the *request_module()
APIs. This code is used by the module auto-loading request_module() API
callers, prior to us even dealing with userspace.

> and you aren't suppressing anything except throwing up warnings, right?

Actually the code does converge duplicate auto-loading requests into one, but'll
just rename to MODULE_DEBUG_AUTOLOAD_DUPS.

> > +	bool "Debug duplicate modules with auto-loading"
> > +	help
> > +	  Module autoloading allows in-kernel code to request modules through
> > +	  the *request_module*() API calls. This in turn just calls userspace
> > +	  modprobe. Although modprobe checks to see if a module is already
> > +	  loaded before trying to load a module there is a small time window in
> > +	  which multiple duplicate requests can end up in userspace and multiple
> > +	  modprobe calls race calling finit_module() around the same time for
> > +	  duplicate modules. The finit_module() system call can consume in the
> > +	  worst case more than twice the respective module size in virtual
> > +	  memory for each duplicate module requests. Although duplicate module
> > +	  requests are non-fatal virtual memory is a limited resource and each
> > +	  duplicate module request ends up just wasting virtual memory.
> 
> It's not "wasted", as it is returned when the module is determined to be
> a duplicate.  Otherwise everyone will want this enabled as they think it
> will actually save memory.

I'll change the language to be clear the issue is memory pressure early
on boot. I'll also add a bit of language to help at least guide people
to realize that the real value-add for this, ie, I'll have to mention we
suspect issue is udev and not module auto-loading and that this however
may still help find a few cases we can optimize for.

  Luis
