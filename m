Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FD7167A4A0
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 22:11:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234657AbjAXVLe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 16:11:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234662AbjAXVLb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 16:11:31 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 779094B744
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 13:11:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2C10BB816B0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 21:11:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89A16C433EF;
        Tue, 24 Jan 2023 21:11:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1674594683;
        bh=6FV8fZUyx9UIT2B/NjKf+b+AZwI+qTujj+rXUvmQIgU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=CKExzjS4d7IXI/NiqujPvAen6pYz1n0k0ul13G+wziuLYNkU7pRc3T9LK6UK2CMpL
         yZF0E1NiC6sP+7JbDcyGUONH5NPH5y3ZfC+W9+ERe/aLGGevFz2wHchLIDJT7pr81o
         zjZF87+f+qL33+nM8eDRzTzre6RQ7pmP2OYDAluQ=
Date:   Tue, 24 Jan 2023 13:11:22 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Andrey Konovalov <andreyknvl@gmail.com>
Cc:     andrey.konovalov@linux.dev, Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>,
        Peter Collingbourne <pcc@google.com>
Subject: Re: [PATCH mm] kasan: reset page tags properly with sampling
Message-Id: <20230124131122.fdbf6ae3069e6b0d05d14361@linux-foundation.org>
In-Reply-To: <CA+fCnZeDWxFB0BgUy_tEybtagth=bcGcqqu9LPSOEjKr5j-o8A@mail.gmail.com>
References: <24ea20c1b19c2b4b56cf9f5b354915f8dbccfc77.1674592496.git.andreyknvl@google.com>
        <20230124124504.2b21f0fde58af208a4f4e290@linux-foundation.org>
        <CA+fCnZeDWxFB0BgUy_tEybtagth=bcGcqqu9LPSOEjKr5j-o8A@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Jan 2023 21:46:51 +0100 Andrey Konovalov <andreyknvl@gmail.com> wrote:

> On Tue, Jan 24, 2023 at 9:45 PM Andrew Morton <akpm@linux-foundation.org> wrote:
> >
> > On Tue, 24 Jan 2023 21:35:26 +0100 andrey.konovalov@linux.dev wrote:
> >
> > > The implementation of page_alloc poisoning sampling assumed that
> > > tag_clear_highpage resets page tags for __GFP_ZEROTAGS allocations.
> > > However, this is no longer the case since commit 70c248aca9e7
> > > ("mm: kasan: Skip unpoisoning of user pages").
> > >
> > > This leads to kernel crashes when MTE-enabled userspace mappings are
> > > used with Hardware Tag-Based KASAN enabled.
> > >
> > > Reset page tags for __GFP_ZEROTAGS allocations in post_alloc_hook().
> > >
> > > Also clarify and fix related comments.
> >
> > I assume this is a fix against 44383cef54c0 ("kasan: allow sampling
> > page_alloc allocations for HW_TAGS") which is presently in mm-stable,
> > yes?
> 
> Correct. I assumed I shouldn't include a Fixes tag, as the patch is
> not in the mainline.

I think it's best to add the Fixes: if it's known.  If the patch was in
mm-unstable then I'd just fold the fix into the base patch, but a
Fixes: is still helpful because it tells people (especially me) which
patch needs the fix.

If the patch is in mm-stable then the SHA is stable and the Fixes: is
desirable for people who are backporting the base patch into earlier
kernels - hopefully when doing this they know to search the tree for
other patches which fix the patch which they are backporting.
