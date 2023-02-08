Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 733FB68F035
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 14:56:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230421AbjBHN4b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 08:56:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229724AbjBHN4a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 08:56:30 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C4AC25B9E
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 05:56:29 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id m2so19339322plg.4
        for <linux-kernel@vger.kernel.org>; Wed, 08 Feb 2023 05:56:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MbjCxpd1Xp38e5yEBPXCZTJ4aQSxWow0JH4h9SbLGXs=;
        b=lXSTV9mPU2L37vQpxhlnyhmClaA15XL3GB9jC0eY/OX6tInDYTWyHXNYu+83r5y9mz
         XInocONldXyN+odjFGXSObiCLl/55ZqQb//SjAHL0qqU2Elepv98yyeG9hZLijNZzP6d
         YvE+GSI+5rX2NJYTTDthQa77m54ctlwFDzAsw+PeHlEbk4YW9vNEkdBPjY2MdPV6hDSP
         QbOa/wHvRpO6QgMLJR8tQUrV90E5Uco2LgOuBZm5PPYr0iYafESvWArTLbHqNCQ+ecBA
         mbNBe8+w6Upoh/3MywUfMiRQc0vawmdy1AHiYGy4sGbSb8FOh6FLuPIvyjuAxNr1TzqD
         Z2nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MbjCxpd1Xp38e5yEBPXCZTJ4aQSxWow0JH4h9SbLGXs=;
        b=fGwUvxCLZ9dy1k2emflmLljlliwxgM99r9ioE+MrlMEJBCl4QP9V6tLKVokrokUeTF
         6v34vu/WBsaiqDvYyP42JMTJ5oHeocsllllPuCCQuwu+Rk4BXLvsWSVyOZVAn3ohf4zH
         K9NUzVuO/qVW8T6oZwDnSj+nOKCFN5PZEItYpNyDoQ1JgdSvxmSAuAGqCv9oN/OYJY0U
         CTJSMQ4UgDyl8r3t3Yztg0qnZ4SQHJY36QvVQtgEIaW/MYD5bPWHL7BF3VVplKtXnXES
         GY8WwzrY+RL2X2V0/zoOreHRyCSBU/2V2BYOrXXFEkaklvMxi7GnXCnugG1rVgaL5ema
         j/Jw==
X-Gm-Message-State: AO0yUKU5xnSWOhrnu1TVyFh2bpyg2W8dDfveVjCNN39D/0gsyf3Ofx5M
        VWuDxIUEFy6KlOKh+dbKgeg=
X-Google-Smtp-Source: AK7set95H8ek/YM3KqQNTOzMLrRwgIEGY5xHgnTz1DP/okx0woSEjQjF6dbp8nw39TEoplPkT9mkmw==
X-Received: by 2002:a17:902:cad1:b0:198:f2a9:a973 with SMTP id y17-20020a170902cad100b00198f2a9a973mr5723274pld.17.1675864588513;
        Wed, 08 Feb 2023 05:56:28 -0800 (PST)
Received: from localhost ([2400:8902::f03c:93ff:fe27:642a])
        by smtp.gmail.com with ESMTPSA id jj9-20020a170903048900b00198bc9ba510sm5794042plb.71.2023.02.08.05.56.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Feb 2023 05:56:26 -0800 (PST)
Date:   Wed, 8 Feb 2023 13:56:16 +0000
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Vlastimil Babka <vbabka@suse.cz>, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        HORIGUCHI =?utf-8?B?TkFPWUEo5aCA5Y+jIOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>, Joe Perches <joe@perches.com>,
        Petr Mladek <pmladek@suse.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>
Subject: Re: [RFC v3 2/4] mm: move PG_slab flag to page_type
Message-ID: <Y+OqAFReSIIgQqqy@localhost>
References: <20221218101901.373450-1-42.hyeyoo@gmail.com>
 <20221218101901.373450-3-42.hyeyoo@gmail.com>
 <15fda061-72d9-2ee9-0e9f-6f0f732a7382@suse.cz>
 <Y9dI88l2YJZfZ8ny@hyeyoo>
 <Y9dRlNhh6O99tg4E@casper.infradead.org>
 <Y90viPlfxzq8UKKq@localhost>
 <Y900FATQ+jlT72Md@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y900FATQ+jlT72Md@casper.infradead.org>
X-Spam-Status: No, score=2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 03, 2023 at 04:19:32PM +0000, Matthew Wilcox wrote:
> On Fri, Feb 03, 2023 at 04:00:08PM +0000, Hyeonggon Yoo wrote:
> > On Mon, Jan 30, 2023 at 05:11:48AM +0000, Matthew Wilcox wrote:
> > > On Mon, Jan 30, 2023 at 01:34:59PM +0900, Hyeonggon Yoo wrote:
> > > > > Seems like quite some changes to page_type to accomodate SLAB, which is
> > > > > hopefully going away soon(TM). Could we perhaps avoid that?
> > > > 
> > > > If it could be done with less changes, I'll try to avoid that.
> > > 
> > > Let me outline the idea I had for removing PG_slab:
> > > 
> > > Observe that PG_reserved and PG_slab are mutually exclusive.  Also,
> > > if PG_reserved is set, no other flags are set.  If PG_slab is set, only
> > > PG_locked is used.  Many of the flags are only for use by anon/page
> > > cache pages (eg referenced, uptodate, dirty, lru, active, workingset,
> > > waiters, error, owner_priv_1, writeback, mappedtodisk, reclaim,
> > > swapbacked, unevictable, mlocked).
> > > 
> > > Redefine PG_reserved as PG_kernel.  Now we can use the other _15_
> > > flags to indicate pagetype, as long as PG_kernel is set. 
> > 
> > So PG_kernel is a new special flag, I thought it indicates
> > "not usermappable pages", but considering PG_vmalloc it's not.
> 
> Right, it means "The kernel allocated this page for its own purposes;
> what that purpose is might be available by looking at PG_type".  ie
> it's not-anon, not-page-cache.
>
> > > So, eg
> > > PageSlab() can now be (page->flags & PG_type) == PG_slab where
> > 
> > But if PG_xxx and PG_slab shares same bit, PG_xxx would be confused?
> 
> Correct.  Ideally those tests wouldn't be used on arbitrary pages,
> only pages which are already confirmed to be anon or file.  I suspect
> we haven't been super-careful about that in the past, and so there
> would be some degree of "Oh, we need to fix this up".  But flags like
> PG_mappedtodisk, PG_mlocked, PG_unevictable, PG_workingset should be
> all gated behind "We know this is anon/file".

Okay. let's just try then!

> > > PG_dirty	0x000008
> > > PG_owner_priv_1	0x000010
> > > PG_arch_1	0x000020
> > > PG_private	0x000040
> > > PG_waiters	0x000080
> > > PG_kernel	0x000100
> > > PG_referenced	0x000200
> > > PG_uptodate	0x000400
> > > PG_lru		0x000800
> > > PG_active	0x001000
> > > PG_workingset	0x002000
> > > PG_error	0x004000
> > > PG_private_2	0x008000
> > > PG_mappedtodisk	0x010000
> > > PG_reclaim	0x020000
> > > PG_swapbacked	0x040000
> > > PG_unevictable	0x080000
> > > PG_mlocked	0x100000
> > > 
> > > ... or something.  There are a number of constraints and it may take
> > > a few iterations to get this right.  Oh, and if this is the layout
> > > we use, then:
> > > 
> > > PG_type		0x1fff00
> > > PG_reserved	(PG_kernel | 0x200)
> > > PG_slab		(PG_kernel | 0x400)
> > > PG_buddy	(PG_kernel | 0x600)
> > > PG_offline	(PG_kernel | 0x800)
> > > PG_table	(PG_kernel | 0xa00)
> > > PG_guard	(PG_kernel | 0xc00)
> > > PG_vmalloc	(PG_kernel | 0xe00)
> > 
> > what is PG_vmalloc for, is it just an example for
> > explaining possible layout?
> 
> I really want to mark pages as being allocated from vmalloc.  It's
> one of the things we could do to make debugging better.

Got it. Anyway, the proposed approach is not compatible with this series
so I'll try implementing new series based on your outline. 

Thanks!
