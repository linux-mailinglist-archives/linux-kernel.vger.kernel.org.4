Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAD3C67D5EE
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 21:08:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbjAZUIK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 15:08:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232724AbjAZUII (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 15:08:08 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A31BC13DE4
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 12:08:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=yLIeRegKr0X7vGwXYffh/Se/fwvXPCTq8z1VBVpsZ3M=; b=wO8H0zWv4XC0Lj0qhFP+52HnYB
        8DXzNRfWpx1zYL08jWrsf70m8NGRhRdK6jLsdd4Czh3tApW8svxijyo+oVVVUqNPO5lKItdzEGhz4
        Dxw3mPAUIC5QykqHl6IyToLpYf9VM699EY4ORgT32Hc/FlA7waQEbdyJJ+okQsWcugiGlavaUspmd
        1slmPM0Oex0M5RKlT64rC67QJtNVn92C0oAYuaGfnnFvFtDuOohVMhomWy0KSJ5JTEEHANxy2ncHC
        Dp1pBMkh2VBcaWpJBwMpD0U2RSrgX98v670VRWk6P/MnRS/QwzlVrKB9uehpbm7tu3Yd5xYcs3+tO
        2XjrcLkg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pL8XJ-0073AH-5o; Thu, 26 Jan 2023 20:07:53 +0000
Date:   Thu, 26 Jan 2023 20:07:53 +0000
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
Message-ID: <Y9LdmUw8TkoJOWvM@casper.infradead.org>
References: <20230126143346.12086-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230126143346.12086-1-fmdefrancesco@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 26, 2023 at 03:33:46PM +0100, Fabio M. De Francesco wrote:
> If ARCH_HAS_FLUSH_ON_KUNMAP is defined (PA-RISC case), __kunmap_local()
> calls kunmap_flush_on_unmap(). The latter currently flushes the wrong
> address (as confirmed by Matthew Wilcox and Helge Deller). Al Viro
> proposed to call kunmap_flush_on_unmap() on an aligned-down to page
> address in order to fix this issue. Consensus has been reached on this
> solution.
> 
> Therefore, if ARCH_HAS_FLUSH_ON_KUNMAP is defined, call
> kunmap_flush_on_unmap() on an aligned-down to page address computed with
> the PTR_ALIGN_DOWN() macro.

You missed a spot.  Sent the version I've had in my tree for a few days.
