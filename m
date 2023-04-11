Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB7B26DE1D8
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 19:06:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229574AbjDKRGe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 13:06:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjDKRGd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 13:06:33 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 133FBE4B;
        Tue, 11 Apr 2023 10:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=qXSUqs709mPoEWjhPkPxBY4/Kitrc5N1pONlGUnsnHA=; b=QLRkeFhpxsne1oCl6QAgwIwzp6
        aCHOnrke4Z1SB9hoa5DBA5mm2fNNpv/M3zSFkCNNFYIq4toApNrJS15LwBMq4c8FodZKIOn3VWZWo
        GmZ4fGADGdzdER6+LL9Gyj1HJtE3x9cMwUGWsY40ru+kE1tP1mjeYdtvovZYEEJi2v3pE5ZqKb0CR
        s4i+AmQUhYYrHuq4LjE7jFdXBL0f9SKS+xMHfAEDqo5eBstMD5gQIZiXvzVVFzNnKROsZaNtkO4RO
        lgaq0tI3F3kwPNYohTGZaLgUhbC/d++NEqjsBFvD4FFNrd03XYZ91MaI8uue2wfiHz0bH8zaqvYd/
        WtLvYIaw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pmHRo-000fLj-2K;
        Tue, 11 Apr 2023 17:06:24 +0000
Date:   Tue, 11 Apr 2023 10:06:24 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     david@redhat.com, patches@lists.linux.dev,
        linux-modules@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, pmladek@suse.com,
        petr.pavlu@suse.com, prarit@redhat.com,
        torvalds@linux-foundation.org, gregkh@linuxfoundation.org,
        rafael@kernel.org, christophe.leroy@csgroup.eu, tglx@linutronix.de,
        peterz@infradead.org, song@kernel.org, rppt@kernel.org,
        dave@stgolabs.net, willy@infradead.org, vbabka@suse.cz,
        mhocko@suse.com, dave.hansen@linux.intel.com,
        colin.i.king@gmail.com, jim.cromie@gmail.com, jbaron@akamai.com,
        rick.p.edgecombe@intel.com
Subject: Re: [PATCH v2 1/6] module: fix kmemleak annotations for non init ELF
 sections
Message-ID: <ZDWTkL/0w4PXNMfw@bombadil.infradead.org>
References: <20230405022702.753323-1-mcgrof@kernel.org>
 <20230405022702.753323-2-mcgrof@kernel.org>
 <ZDV6DzePHI3KLISY@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZDV6DzePHI3KLISY@arm.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 11, 2023 at 04:17:35PM +0100, Catalin Marinas wrote:
> On Tue, Apr 04, 2023 at 07:26:57PM -0700, Luis Chamberlain wrote:
> > diff --git a/kernel/module/main.c b/kernel/module/main.c
> > index 5cc21083af04..d8bb23fa6989 100644
> > --- a/kernel/module/main.c
> > +++ b/kernel/module/main.c
> > @@ -2233,11 +2233,23 @@ static int move_module(struct module *mod, struct load_info *info)
> >  		ptr = module_memory_alloc(mod->mem[type].size, type);
> >  
> >  		/*
> > -		 * The pointer to this block is stored in the module structure
> > -		 * which is inside the block. Just mark it as not being a
> > -		 * leak.
> > +		 * The pointer to these blocks of memory are stored on the module
> > +		 * structure and we keep that around so long as the module is
> > +		 * around. We only free that memory when we unload the module.
> > +		 * Just mark them as not being a leak then. The .init* ELF
> > +		 * sections *do* get freed after boot so we treat them slightly
> > +		 * differently and only grey them out -- they work as typical
> > +		 * memory allocations which *do* eventually get freed.
> >  		 */
> > -		kmemleak_ignore(ptr);
> > +		switch (type) {
> > +		case MOD_INIT_TEXT: /* fallthrough */
> > +		case MOD_INIT_DATA: /* fallthrough */
> > +		case MOD_INIT_RODATA: /* fallthrough */
> > +			kmemleak_ignore(ptr);
> > +			break;
> > +		default:
> > +			kmemleak_not_leak(ptr);
> > +		}
> 
> This works as well but if you want to keep it simple, just call
> kmemleak_not_leak() in all cases. When freeing the init sections, they
> would be removed from the kmemleak tracing anyway.

It is up to you as you were the one who originally used different calls
here, so I didn't want to change the old mechanism. Changing it to use
kmemleak_not_leak() would be a functional change, do we loose anything
for using kmemleak_not_leak() for all? Ie, why had you used a different
set of calls when you first added this depending on the if its init or
not? Is the value no longer there?

  Luis
