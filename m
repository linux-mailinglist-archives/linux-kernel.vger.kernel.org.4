Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9F0D6DE5BB
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 22:27:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbjDKU1D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 16:27:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbjDKU05 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 16:26:57 -0400
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id ED63B4C31;
        Tue, 11 Apr 2023 13:26:43 -0700 (PDT)
Received: (from willy@localhost)
        by mail.home.local (8.17.1/8.17.1/Submit) id 33BKQWvN011451;
        Tue, 11 Apr 2023 22:26:32 +0200
Date:   Tue, 11 Apr 2023 22:26:32 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Hans Verkuil <hverkuil@xs4all.nl>,
        Daniel Almeida <daniel.almeida@collabora.com>,
        wedsonaf@gmail.com, ojeda@kernel.org, mchehab@kernel.org,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, kernel@collabora.com
Subject: Re: [PATCH 0/6] Initial Rust V4L2 support
Message-ID: <ZDXCeKkbPoZi5k6t@1wt.eu>
References: <20230406215615.122099-1-daniel.almeida@collabora.com>
 <136035a4-26df-1c14-e51e-406b4ee5fe33@xs4all.nl>
 <CANiq72kzgopREcNcAnjCBk2u9b9cJ4f_jPix6LWYSkcOV5kubw@mail.gmail.com>
 <ZDVXbw/097jvjKvK@1wt.eu>
 <CANiq72n8ZV_bs_xp5rNtar4vmfknJtZg4OHJW6vHuhVFmGs8mg@mail.gmail.com>
 <ZDWQXDRknzFhngyk@1wt.eu>
 <CANiq72n=s23naD4-UkmuLesekDTf4b5bsmWc+fYANYPq+X1R9w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72n=s23naD4-UkmuLesekDTf4b5bsmWc+fYANYPq+X1R9w@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 11, 2023 at 09:27:35PM +0200, Miguel Ojeda wrote:
> On Tue, Apr 11, 2023 at 6:52 PM Willy Tarreau <w@1wt.eu> wrote:
> >
> > But if that code is only under a module, there's no need to turn all
> > that code off if it's sufficient to be certain the module was no loaded.
> > Plus it's more friendly to the user who doesn't have to rebuild a kernel,
> > just blacklist a module and check that the kernel doesn't get tainted
> > again.
> 
> That could apply to any foreign-to-us subsystems, including C code
> too. Should we taint per subsystem so that we can easily check for
> those that we may not trust?

I don't know, maybe that would be a bit too fine. But at least a tainted
flag is much less intrusive than forcing a user to rebuild and disable
possibly important features that they would only be willing to disable
for just a test.

> I see one could argue for an experimental taint or making it depend on
> something like `STAGING`, i.e. based on grounds of being new code.

It could also be an idea.

> But
> I don't see why that should be grounded on just being a different
> language or not being able to read the code.

Because being a different language means some maintainers will always
have a hard time understanding that code that interacts with their
subsystems, even if they try hard. It's exactly the same reason why
25 years ago Linus asked to stop abusing assembly code. If a language
is only understood by a subset of developers, by nature it becomes
more difficult to maintain in some areas.

> > It could depend on the layer where it plugs and the level of intimacy
> > with the core. Sometimes you need a deep understanding of all interactions
> > between elements to imagine possible scenarios.
> 
> Please note that the policy for submitting new Rust code is that the
> respective kernel maintainers and their lists are contacted. We also
> request that maintainers take the code through their tree if they can,
> rather than going through the Rust tree, precisely so that maintainers
> are aware of these potential interactions. See
> https://rust-for-linux.com/contributing#the-rust-subsystem for
> details.

Sure, but as you said, "if they can". I thought that it could be both
elegant, lightweight and convenient. But I'm not trying to sell this
idea, just sharing it.

Cheers,
Willy
