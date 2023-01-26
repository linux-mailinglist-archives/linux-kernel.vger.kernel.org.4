Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B72367D6C3
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 21:48:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbjAZUsc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 15:48:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231558AbjAZUs2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 15:48:28 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85A5E76B5
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 12:48:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=xYyn6gE7F+Ay1oJHev/ISGq5X5rN9LDnA4hf9TFZmgs=; b=C79SkTkUXPHdY1rqmNll246qpm
        BcZ9KxjPV6sjmvUDLBIB2PCuHKi6e70JMG5bU/DY0o8KZKFsEczGwkoqEvPn/wDajtV0GS8FQJUpt
        TSg9FVIbJh82hHe3RKQhuIWAIO2jq4CSf5Ixcgl0Tj7f08tplSbFSCdmilzJZ3rcwAEEzZUfWFRFj
        y+or7Xbh6k9W10ac2Y+sHXZmOffE7BnFb/peBUVwtEK8QQnogKQroWYHb5aOSHXtUsfxU8FQtjig0
        mBMvtH7AjprYmdoq50OoqLKC9ezBgz+hHVJW0sNvX7HkaA+6A9JwlkQFURfoL12p0zR556EilTHvH
        iEKJlKdA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pL9AB-0074fm-Ky; Thu, 26 Jan 2023 20:48:03 +0000
Date:   Thu, 26 Jan 2023 20:48:03 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
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
Message-ID: <Y9LnAzUP2K/cmqa5@casper.infradead.org>
References: <20230126143346.12086-1-fmdefrancesco@gmail.com>
 <20230126123858.42d9377ad6e352a58c81668b@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230126123858.42d9377ad6e352a58c81668b@linux-foundation.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 26, 2023 at 12:38:58PM -0800, Andrew Morton wrote:
> On Thu, 26 Jan 2023 15:33:46 +0100 "Fabio M. De Francesco" <fmdefrancesco@gmail.com> wrote:
> 
> > If ARCH_HAS_FLUSH_ON_KUNMAP is defined (PA-RISC case), __kunmap_local()
> > calls kunmap_flush_on_unmap(). The latter currently flushes the wrong
> > address (as confirmed by Matthew Wilcox and Helge Deller). Al Viro
> > proposed to call kunmap_flush_on_unmap() on an aligned-down to page
> > address in order to fix this issue. Consensus has been reached on this
> > solution.
> 
> What are the user-visible runtime effects of this flaw?

The version of this patch I sent out includes this information,
as well as the missed alignment for kunmap_atomic().
