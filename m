Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B00A67ED04
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 19:04:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234935AbjA0SE1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 13:04:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232618AbjA0SEZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 13:04:25 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BEE97579A
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 10:04:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=i0d/AHnGAZVOoNC1mrYJHLs0fJVxQCxbSeSlNV+00YU=; b=FW/URsj5aCPLSd0Fca58A0zfgv
        2u80XboKatxu/hsKTqxNhuBQsXerU36oaLy32OLWbwnueAI6u8XIMshWxZIhG119o+jE/0q2t8X/B
        Jvj3v/eAzGgr+5WWjfjqlgSR3NWAMBa6cpHs+9NPwDZcbGXvpSgC+e2wBYmj/UMhZyR6p6VwNftYB
        HanRO+LSvbL3BTE4T3S86cDjiB6yobAASOVTDDgVA9lhHqJIEVzFY3DbM/lsy6a2U+7wNoQFcjaVW
        IojaQ+N3awDu7PgOy5zJB/VPZVx4rFD2mXf637HJj7sj3FvRWeK9TDnLw2Mw+w5QbGhZasCPd97KH
        mf9y8VOg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pLT4r-007vKQ-Uv; Fri, 27 Jan 2023 18:03:53 +0000
Date:   Fri, 27 Jan 2023 18:03:53 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Tony Luck <tony.luck@intel.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        David Sterba <dsterba@suse.com>,
        Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Al Viro <viro@zeniv.linux.org.uk>, Helge Deller <deller@gmx.de>
Subject: Re: [PATCH] mm/highmem: Align-down to page the address for
 kunmap_flush_on_unmap()
Message-ID: <Y9QSCWrijb0R1lnu@casper.infradead.org>
References: <20230126143346.12086-1-fmdefrancesco@gmail.com>
 <Y9LdmUw8TkoJOWvM@casper.infradead.org>
 <1920277.PYKUYFuaPT@suse>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1920277.PYKUYFuaPT@suse>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 27, 2023 at 06:58:55PM +0100, Fabio M. De Francesco wrote:
> On giovedì 26 gennaio 2023 21:07:53 CET Matthew Wilcox wrote:
> > On Thu, Jan 26, 2023 at 03:33:46PM +0100, Fabio M. De Francesco wrote:
> > > If ARCH_HAS_FLUSH_ON_KUNMAP is defined (PA-RISC case), __kunmap_local()
> > > calls kunmap_flush_on_unmap(). The latter currently flushes the wrong
> > > address (as confirmed by Matthew Wilcox and Helge Deller). Al Viro
> > > proposed to call kunmap_flush_on_unmap() on an aligned-down to page
> > > address in order to fix this issue. Consensus has been reached on this
> > > solution.
> > > 
> > > Therefore, if ARCH_HAS_FLUSH_ON_KUNMAP is defined, call
> > > kunmap_flush_on_unmap() on an aligned-down to page address computed with
> > > the PTR_ALIGN_DOWN() macro.
> > 
> > You missed a spot.  Sent the version I've had in my tree for a few days.
> 
> I'm sorry for missing the other call site.
> Furthermore, your patch has a better commit message. 
> 
> However, I'm also sorry because I would have expected a different kind of 
> support from you. My patch could have been improved with v2.
> 
> Anyway, I assume that you missed that I had asked you and Al if anybody were 
> interested in doing these changes and probably you missed also that Ira 
> encouraged me to send a patch, whereas you did not show any interest...
> https://lore.kernel.org/lkml/3146373.5fSG56mABF@suse/

Sorry; I get too much email and I missed the last six emails in that
thread (just went back and read them).  According to git, I committed
this patch to my tree on Jan 20th, so if I'd read your email, I would
have told you to not bother.
