Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4545E6EEB71
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 02:32:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238436AbjDZAcH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 20:32:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236413AbjDZAcE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 20:32:04 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18BE2B236;
        Tue, 25 Apr 2023 17:32:03 -0700 (PDT)
Received: from pendragon.ideasonboard.com (133-32-181-51.west.xps.vectant.ne.jp [133.32.181.51])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id DA23A2CF;
        Wed, 26 Apr 2023 02:31:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1682469108;
        bh=J0H/I3MHC57rloZ2Y3S5PUrNrgy8f/8EJ9VwOYm2S10=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YREWwOIE7IwcRZFehUJe5hzIshER8rKPV/zBWdvqT8YRPhPwcwWEK2/kKpnYy/oPD
         0MHQFIDqEDkHAmxevwQ4vwN3JYfCvefeSzL2eHvLmjPQmgcbaTJi3A9ygbFDxmUWXd
         VfqZrWUcKvyUZZRdADk7kX7VfKWQ/Rs73vhD6Fu8=
Date:   Wed, 26 Apr 2023 03:32:10 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Hans Verkuil <hverkuil@xs4all.nl>,
        Daniel Almeida <daniel.almeida@collabora.com>,
        wedsonaf@gmail.com, ojeda@kernel.org, mchehab@kernel.org,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, kernel@collabora.com
Subject: Re: [PATCH 0/6] Initial Rust V4L2 support
Message-ID: <20230426003210.GA31260@pendragon.ideasonboard.com>
References: <20230406215615.122099-1-daniel.almeida@collabora.com>
 <136035a4-26df-1c14-e51e-406b4ee5fe33@xs4all.nl>
 <CANiq72kzgopREcNcAnjCBk2u9b9cJ4f_jPix6LWYSkcOV5kubw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72kzgopREcNcAnjCBk2u9b9cJ4f_jPix6LWYSkcOV5kubw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 11, 2023 at 02:02:17PM +0200, Miguel Ojeda wrote:
> On Tue, Apr 11, 2023 at 9:51 AM Hans Verkuil <hverkuil@xs4all.nl> wrote:
> >
> > One of my main concerns here is time: as subsystem maintainers we can barely
> > keep up with all the incoming patches. Introducing support for a new language
> > would add only more pressure. Even though these are mainly bindings (as I
> > understand it), this would still require that every change to a C kAPI is
> > duplicated in rust, requiring someone to do that work, and have maintainers
> > with enough rust knowledge to verify it.

Another issue is that the V4L2 subsystem is plagued with lifetime
management problems. I don't think rust bindings could be safely written
for the MC and V4L2 subdev in-kernel APIs at the moment for instance.
Sakari recently attempted to fix some of those issues (again), see [1].
Progress is slow on this front because V4L2 is generally understaffed.

[1] https://lore.kernel.org//20230201214535.347075-1-sakari.ailus@linux.intel.com

Now, I hope that mentioning "lifetime management problems" will be
enough to nerd-snipe a rust enthusiast or two to help fix the C code in
order to implement proper rust bindings on top ;-)

> Indeed, that is one of the main costs.
> 
> One potential solution is to have somebody step up as the maintainer
> of the Rust side (e.g. the author of the abstractions).

That would certainly be a required step, but I don't think it would be
enough. On good days I see the media subsystem as barely able to cope
with the current load, on bad days it feels it's completely collapsing.

We have homework to do when it comes to maintenance for the media
subsystem, we're doing *really* badly at the moment regarding community
management and attracting (and retaining) new core contributors. This is
a topic I really want to discuss face to face during the media workshop
in Prague (and I know that many people are looking forward to that
discussion).

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

-- 
Regards,

Laurent Pinchart
