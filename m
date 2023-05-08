Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 984EA6FB245
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 16:10:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234433AbjEHOKR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 10:10:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234292AbjEHOKK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 10:10:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E8542FA2D
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 07:10:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2A12A63E13
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 14:10:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE777C433D2;
        Mon,  8 May 2023 14:10:05 +0000 (UTC)
Date:   Mon, 8 May 2023 15:10:02 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Florent Revest <revest@chromium.org>
Cc:     Peter Xu <peterx@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, akpm@linux-foundation.org,
        anshuman.khandual@arm.com, joey.gouly@arm.com, mhocko@suse.com,
        keescook@chromium.org, david@redhat.com, izbyshev@ispras.ru,
        nd@arm.com, broonie@kernel.org, szabolcs.nagy@arm.com,
        toiwoton@gmail.com, lennart@poettering.net
Subject: Re: [PATCH 0/4] MDWE without inheritance
Message-ID: <ZFkCugTkQmZh3sJo@arm.com>
References: <20230504170942.822147-1-revest@chromium.org>
 <ZFQQSKijXQHWlYaI@x1n>
 <CABRcYmJFcUs=3QYXz8iq7qvu2orJ4HL-cHdBKg9o7=Ma=nfPLw@mail.gmail.com>
 <ZFhQcwDBFWcRCC4N@x1n>
 <CABRcYm+RquNGYUyfCEmLrcaoMSKagzwXgto-24ZCaLAdFUKUjg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABRcYm+RquNGYUyfCEmLrcaoMSKagzwXgto-24ZCaLAdFUKUjg@mail.gmail.com>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 08, 2023 at 02:12:21PM +0200, Florent Revest wrote:
> On Mon, May 8, 2023 at 3:29 AM Peter Xu <peterx@redhat.com> wrote:
> > On Fri, May 05, 2023 at 06:42:08PM +0200, Florent Revest wrote:
> > > On Thu, May 4, 2023 at 10:06 PM Peter Xu <peterx@redhat.com> wrote:
> > > > And, what's the difference of this comparing to disabling MDWE after being
> > > > enabled (which seems to be forbidden for now, but it seems fork() can play
> > > > a similar role of disabling it)?
> > >
> > > That would be functionally somewhat similar, yes. I think it mostly
> > > comes down to ease of adoption. I imagine that users who would opt
> > > into NO_INHERIT are those who are interested in MDWE for the binary
> > > they are writing but aren't 100% confident in what subprocesses they
> > > will run and so they don't have to think about disabling it after
> > > every fork.
> >
> > Okay, that makes sense to me.  Thanks.
> >
> > Since the original MDWE was for systemd, I'm wondering what will happen if
> > some program like what you said is invoked by systemd and with MDWE enabled
> > already.
> 
> Good question

I think JITs work around this by creating two separate mappings of the
same pages, one RX and the other RW (rather than toggling the permission
with mprotect()). I had the impression Chromium can use memfd to do
something similar but I never checked.

> > Currently in your patch IIUC MDWE_NO_INHERIT will fail directly on MDWE
> > enabled process,
> 
> Yes, I tried to stay close to the spirit of the existing logic (which
> doesn't allow any sort of privilege gains) but this is not
> particularly a requirement on our side so I'm quite flexible here.

I think we should keep the original behaviour of systemd here, otherwise
they won't transition to the new interface and keep using the SECCOMP
BPF approach (which, in addition, prevents glibc from setting PROT_BTI
on an already executable mapping).

To me MDWE is not about preventing JITs but rather ensuring buggy
programs don't end up with WX mappings. We ended up this way because of
the SECCOMP BPF limitations (just guessing, I haven't been involved in
its design). With a no-inherit MDWE, one can introduce an additional
policy for systemd. It would be a sysadmin decision which one to enable
and maybe current (inherit) MDWE will disappear in time.

x86 has protection keys and arm64 will soon have permission overlays
that allow user-space to toggle between RX and RW (Joey is looking at
the arm64 support). I'm not sure how we'll end up implemented this on
arm64 (and haven't looked at x86) but I have a suspicion MDWE will get
in the way as the base page table permission will probably need
PROT_WRITE|PROT_EXEC.

-- 
Catalin
