Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59EA567D72F
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 22:04:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232557AbjAZVEO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 16:04:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbjAZVEM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 16:04:12 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EECD1CAEE
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 13:04:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=WeRZ4ev+cIGFoILzVACqwJK5TvQKgnTXms3rSxBm3Os=; b=gaFXxUy4EjaUAeZyDva/yElV0p
        EdaUMqOQuigNnv2xq2EpY3x0UyDUKjdgg2z1a9pRPnsm71tbWAPoZW6bL6Ykk39km9W4NlFi8eksG
        KXkHWwCZU9oXcPqf9ITvd4q5mW8n9Fa2pUSMIh5Oai9u+PSj2xDM2KCyac0RxDwqTMv7kNJ3Hq4ky
        JL0tkytMJqTGe6xnT1nzlwzdwJB3QEChMsl+qsY+4k8lJqwbg5So3V205ymTt3rU/gzAlIiigQZ+C
        Zclh77KN2yor68DomCPTgk6ES39rDQv38K22daEzWiNBZ+iLs4hJW4sKI0rLtUZPlYzwejkeq/qdL
        FI0qfqCQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pL9Pe-004JgM-32;
        Thu, 26 Jan 2023 21:04:03 +0000
Date:   Thu, 26 Jan 2023 21:04:02 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
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
        Helge Deller <deller@gmx.de>
Subject: Re: [PATCH] mm/highmem: Align-down to page the address for
 kunmap_flush_on_unmap()
Message-ID: <Y9LqwvXy+gpFBerE@ZenIV>
References: <20230126143346.12086-1-fmdefrancesco@gmail.com>
 <20230126123858.42d9377ad6e352a58c81668b@linux-foundation.org>
 <Y9LnAzUP2K/cmqa5@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9LnAzUP2K/cmqa5@casper.infradead.org>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 26, 2023 at 08:48:03PM +0000, Matthew Wilcox wrote:
> On Thu, Jan 26, 2023 at 12:38:58PM -0800, Andrew Morton wrote:
> > On Thu, 26 Jan 2023 15:33:46 +0100 "Fabio M. De Francesco" <fmdefrancesco@gmail.com> wrote:
> > 
> > > If ARCH_HAS_FLUSH_ON_KUNMAP is defined (PA-RISC case), __kunmap_local()
> > > calls kunmap_flush_on_unmap(). The latter currently flushes the wrong
> > > address (as confirmed by Matthew Wilcox and Helge Deller). Al Viro
> > > proposed to call kunmap_flush_on_unmap() on an aligned-down to page
> > > address in order to fix this issue. Consensus has been reached on this
> > > solution.
> > 
> > What are the user-visible runtime effects of this flaw?
> 
> The version of this patch I sent out includes this information,
> as well as the missed alignment for kunmap_atomic().

One point: AFAICS, the situation right now is
	* all callers of kunmap_local() pass page-aligned pointers
	* all callers of kunmap_atomic() seem to do the same
	* there's nothing in documentation that would say one can
pass anything other than the return value of original kmap_local_page()
or kmap_atomic() call to those.
	* there's nothing that would outright ban doing that.

So these patches really ought to touch Documentation/mm/highmem.rst
saying that from now on kunmap_local() and kunmap_atomic() callers
are allowed to pass any pointer within the mapped area.  And yes,
we want it in -stable before anything that relies upon that sucker
gets backported.
