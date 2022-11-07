Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC96D61F97B
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 17:22:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232248AbiKGQW1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 11:22:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232835AbiKGQVK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 11:21:10 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 419C621E3C
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 08:20:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=oCZ/nMUN/7C6KeSZtw+vpEn8Cw/FfofNU7HRtG+t0rA=; b=XYwAxJ8DzyQAkyaAXqc7IgvdVj
        HrBx/ism/pUCdiQp1jOTWPUMxY1qyZMaY09ofG7f0gWvri/1WA0cZsFGl2Ocomrl4nZcEfqHOTruZ
        j4hzdUhmTvKONN39aICfWPZ5+vy/Bdb2DOIxcpMP5PJh8VGjBinH7pmmlWoIkbEamsc0uILJrCY6H
        379cqheJaAZQbDkfUIvBnT7nK1WofTs5qxQNPhxFiaxPBM4sI4ddi7E/JK1/dXH9fNCSSDJo+hiBc
        h4piDACrpQwGkdZ+vwwuz5M+b6LZKogX3orSfKwxpKL2DFbEYI47+nYhQ1z78Nkd+Fcl2gu0Jpbo/
        uNRsF8Ew==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1os4r1-009Up3-LY; Mon, 07 Nov 2022 16:20:07 +0000
Date:   Mon, 7 Nov 2022 16:20:07 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Oded Gabbay <ogabbay@kernel.org>
Cc:     =?utf-8?Q?Micha=C5=82?= Winiarski <michal.winiarski@intel.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        intel-gfx@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Simon Ser <contact@emersion.fr>
Subject: Re: [PATCH v5 1/3] drm: Use XArray instead of IDR for minors
Message-ID: <Y2kwN5TRsAKTZmsN@casper.infradead.org>
References: <20220911211443.581481-1-michal.winiarski@intel.com>
 <20220911211443.581481-2-michal.winiarski@intel.com>
 <CAFCwf11=hKGm93oF1A5PLhdvdo2ujYJWyt4qAqK-KQQqe6ngDA@mail.gmail.com>
 <CAFCwf12+piEABvv=nxFJCzUU4XdZw5Pu=r=i3aKQGZrBeraFqw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFCwf12+piEABvv=nxFJCzUU4XdZw5Pu=r=i3aKQGZrBeraFqw@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 06, 2022 at 04:51:39PM +0200, Oded Gabbay wrote:
> I tried executing the following code in a dummy driver I wrote:

You don't need to write a dummy driver; you can write test-cases
entirely in userspace.  Just add them to lib/test_xarray.c and then
make -C tools/testing/radix-tree/

> static DEFINE_XARRAY_ALLOC(xa_dummy);
> void check_xa(void *pdev)
> {
>   void *entry;
>   int ret, index;
> 
>   ret = xa_alloc(&xa_dummy, &index, NULL, XA_LIMIT(0, 63), GFP_NOWAIT);
>   if (ret < 0)
>       return ret;
> 
>   entry = xa_cmpxchg(&xa_dummy, index, NULL, pdev, GFP_KERNEL);
>   if (xa_is_err(entry))
>        return;
> 
>   xa_lock(&xa_dummy);
>   xa_dev = xa_load(&xa_dummy, index);
>   xa_unlock(&xa_dummy);
> }
> 
> And to my surprise xa_dev is always NULL, when it should be pdev.
> I believe that because we first allocate the entry with NULL, it is
> considered a "zero" entry in the XA.
> And when we replace it, this attribute doesn't change so when we do
> xa_load, the xa code thinks the entry is a "zero" entry and returns
> NULL.

There's no "attribute" to mark a zero entry.  It's just a zero entry.
The problem is that you're cmpxchg'ing against NULL, and it's not NULL,
it's the ZERO entry.  This is even documented in the test code:

        /* cmpxchg sees a reserved entry as ZERO */
        XA_BUG_ON(xa, xa_reserve(xa, 12345678, GFP_KERNEL) != 0);
        XA_BUG_ON(xa, xa_cmpxchg(xa, 12345678, XA_ZERO_ENTRY,
                                xa_mk_value(12345678), GFP_NOWAIT) != NULL);

I'm not quite sure why you're using xa_cmpxchg() here anyway; if you
allocated it, it's yours and you can just xa_store() to it.

