Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 759D76DE17D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 18:53:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229961AbjDKQw7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 12:52:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbjDKQw4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 12:52:56 -0400
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 678781991;
        Tue, 11 Apr 2023 09:52:54 -0700 (PDT)
Received: (from willy@localhost)
        by mail.home.local (8.17.1/8.17.1/Submit) id 33BGqie2009276;
        Tue, 11 Apr 2023 18:52:44 +0200
Date:   Tue, 11 Apr 2023 18:52:44 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Hans Verkuil <hverkuil@xs4all.nl>,
        Daniel Almeida <daniel.almeida@collabora.com>,
        wedsonaf@gmail.com, ojeda@kernel.org, mchehab@kernel.org,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, kernel@collabora.com
Subject: Re: [PATCH 0/6] Initial Rust V4L2 support
Message-ID: <ZDWQXDRknzFhngyk@1wt.eu>
References: <20230406215615.122099-1-daniel.almeida@collabora.com>
 <136035a4-26df-1c14-e51e-406b4ee5fe33@xs4all.nl>
 <CANiq72kzgopREcNcAnjCBk2u9b9cJ4f_jPix6LWYSkcOV5kubw@mail.gmail.com>
 <ZDVXbw/097jvjKvK@1wt.eu>
 <CANiq72n8ZV_bs_xp5rNtar4vmfknJtZg4OHJW6vHuhVFmGs8mg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72n8ZV_bs_xp5rNtar4vmfknJtZg4OHJW6vHuhVFmGs8mg@mail.gmail.com>
X-Spam-Status: No, score=-0.0 required=5.0 tests=SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 11, 2023 at 04:13:36PM +0200, Miguel Ojeda wrote:
> On Tue, Apr 11, 2023 at 2:49 PM Willy Tarreau <w@1wt.eu> wrote:
> >
> > This might sound strange, but I suspect that having a TAINT_RUST flag
> > could possibly help maintainers that are already lacking time, because
> > it may quickly allow some of them to ask "please try again without the
> > Rust code to see if the problem is still there", just like happens with
> > out-of-tree code for which the knowledge is limited to null. This could
> > allow to route issue reports to one maintainer when an issue is confirmed
> > in both cases or to another one when it only happens in a single case.
> >
> > Of course it will not help with code reviews but we know that a great
> > part of maintainers' time it spent trying to analyse problem reports
> > that happen under vague conditions. All the time not spent debugging
> > something not well understood is more time available for reviews.
> 
> You can already ask to disable `CONFIG_RUST`.
> 
> In fact, we asked that a few times, when people reported a problem
> that looked unrelated to Rust, to confirm that was the case and thus
> redirect the report.
> 
> So it is definitely a good idea to ask for that when you get a report
> with `RUST=y` and you suspect it may be related to that, especially in
> the beginning where `RUST=y` should not be common.

But if that code is only under a module, there's no need to turn all
that code off if it's sufficient to be certain the module was no loaded.
Plus it's more friendly to the user who doesn't have to rebuild a kernel,
just blacklist a module and check that the kernel doesn't get tainted
again.

> However, I think Rust in-tree code is different to out-of-tree code,
> since you do have the code, and thus (in general) you should be able
> to reproduce the build, and you can ask for help to the given
> maintainers to understand it.

It could depend on the layer where it plugs and the level of intimacy
with the core. Sometimes you need a deep understanding of all interactions
between elements to imagine possible scenarios.

Cheers,
Willy
