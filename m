Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A10256DDB31
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 14:50:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230047AbjDKMuN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 08:50:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbjDKMuL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 08:50:11 -0400
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2A0903AAB;
        Tue, 11 Apr 2023 05:50:04 -0700 (PDT)
Received: (from willy@localhost)
        by mail.home.local (8.17.1/8.17.1/Submit) id 33BCnpwX005890;
        Tue, 11 Apr 2023 14:49:51 +0200
Date:   Tue, 11 Apr 2023 14:49:51 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Hans Verkuil <hverkuil@xs4all.nl>,
        Daniel Almeida <daniel.almeida@collabora.com>,
        wedsonaf@gmail.com, ojeda@kernel.org, mchehab@kernel.org,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, kernel@collabora.com
Subject: Re: [PATCH 0/6] Initial Rust V4L2 support
Message-ID: <ZDVXbw/097jvjKvK@1wt.eu>
References: <20230406215615.122099-1-daniel.almeida@collabora.com>
 <136035a4-26df-1c14-e51e-406b4ee5fe33@xs4all.nl>
 <CANiq72kzgopREcNcAnjCBk2u9b9cJ4f_jPix6LWYSkcOV5kubw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72kzgopREcNcAnjCBk2u9b9cJ4f_jPix6LWYSkcOV5kubw@mail.gmail.com>
X-Spam-Status: No, score=-0.0 required=5.0 tests=SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Miguel!

On Tue, Apr 11, 2023 at 02:02:17PM +0200, Miguel Ojeda wrote:
> On Tue, Apr 11, 2023 at 9:51 AM Hans Verkuil <hverkuil@xs4all.nl> wrote:
> >
> > One of my main concerns here is time: as subsystem maintainers we can barely
> > keep up with all the incoming patches. Introducing support for a new language
> > would add only more pressure. Even though these are mainly bindings (as I
> > understand it), this would still require that every change to a C kAPI is
> > duplicated in rust, requiring someone to do that work, and have maintainers
> > with enough rust knowledge to verify it.
> 
> Indeed, that is one of the main costs.
> 
> One potential solution is to have somebody step up as the maintainer
> of the Rust side (e.g. the author of the abstractions).
> 
> Of course, that will not make the work go to zero, since there still
> needs to be some degree of communication even if the new maintainer
> does all the Rust side work, but it may make it feasible, especially
> if the abstracted parts of the C API do not change too frequently.
> 
> It is also an opportunity for existing maintainers to see how the Rust
> side would work meanwhile the work gets done, and potentially a chance
> to get a new maintainer involved with the whole subsystem in the
> future.
> 
> Some subsystems may want to give that maintainer a different
> `MAINTAINERS` entry, e.g. as a child subsystem that sends PRs to the
> main one and may be marked as "experimental". This is also a way to
> see how the new abstractions work or not, giving maintainers more time
> to decide whether to commit to a Rust side or not.
> 
> I don't mean to say it would be doable for the media subsystem, but
> please consider it.

This might sound strange, but I suspect that having a TAINT_RUST flag
could possibly help maintainers that are already lacking time, because
it may quickly allow some of them to ask "please try again without the
Rust code to see if the problem is still there", just like happens with
out-of-tree code for which the knowledge is limited to null. This could
allow to route issue reports to one maintainer when an issue is confirmed
in both cases or to another one when it only happens in a single case.

Of course it will not help with code reviews but we know that a great
part of maintainers' time it spent trying to analyse problem reports
that happen under vague conditions. All the time not spent debugging
something not well understood is more time available for reviews.

Just my two cents,
Willy
