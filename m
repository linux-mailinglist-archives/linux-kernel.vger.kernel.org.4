Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B2246EF885
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 18:35:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233466AbjDZQfM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 12:35:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjDZQfH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 12:35:07 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4A2876A9;
        Wed, 26 Apr 2023 09:35:04 -0700 (PDT)
Received: from pendragon.ideasonboard.com (133-32-181-51.west.xps.vectant.ne.jp [133.32.181.51])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 56A8FD8B;
        Wed, 26 Apr 2023 18:34:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1682526891;
        bh=IlGICYbf2OmcQrRb9AvvNng682xHYM1XcOoTpyp8pVE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rvoao20PXhbOZI7SFOjI1tXqZ5sM8F97vCVmkC28g+MEh1z4VRfthI4m/Yw10BVwR
         c2fSyxoVbW8FPZ0T4RdJPCvR1e9jT8ycHEfZ/ZsJRToJIINCFhLbBBemWFefLKvx8C
         2xoUZMLo1RYWApbSSzw9xLdSnJ2/atEbKy6657og=
Date:   Wed, 26 Apr 2023 19:35:12 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Hans Verkuil <hverkuil@xs4all.nl>,
        Daniel Almeida <daniel.almeida@collabora.com>,
        wedsonaf@gmail.com, ojeda@kernel.org, mchehab@kernel.org,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, kernel@collabora.com,
        Sakari Ailus <sakari.ailus@iki.fi>
Subject: Re: [PATCH 0/6] Initial Rust V4L2 support
Message-ID: <20230426163512.GE18120@pendragon.ideasonboard.com>
References: <20230406215615.122099-1-daniel.almeida@collabora.com>
 <136035a4-26df-1c14-e51e-406b4ee5fe33@xs4all.nl>
 <CANiq72kzgopREcNcAnjCBk2u9b9cJ4f_jPix6LWYSkcOV5kubw@mail.gmail.com>
 <20230426003210.GA31260@pendragon.ideasonboard.com>
 <CANiq72nLtpOn2HcOneoQ6v_TcYAEj_W8z2HCQvF4HmB4+OoSZA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72nLtpOn2HcOneoQ6v_TcYAEj_W8z2HCQvF4HmB4+OoSZA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Miguel,

(CC'ing Sakari Ailus)

On Wed, Apr 26, 2023 at 06:18:35PM +0200, Miguel Ojeda wrote:
> On Wed, Apr 26, 2023 at 2:32 AM Laurent Pinchart wrote:
> >
> > Now, I hope that mentioning "lifetime management problems" will be
> > enough to nerd-snipe a rust enthusiast or two to help fix the C code in
> > order to implement proper rust bindings on top ;-)
> 
> Good idea ;)
> 
> I think it is definitely a good opportunity to consider how Rust could
> fit the new design, and perhaps borrow some ideas from Rust for the
> new design, even. If you feel like a quick meeting could help on that,
> please let us know.

I think we have a fairly good view of what needs to be done, the rules
are the same regardless of the programming language and whether the
compiler or reviewers enforce them (Hans, Sakari, please feel free to
disagree). Thanks for your offer though, it's appreciated.

> > That would certainly be a required step, but I don't think it would be
> > enough. On good days I see the media subsystem as barely able to cope
> > with the current load, on bad days it feels it's completely collapsing.
> >
> > We have homework to do when it comes to maintenance for the media
> > subsystem, we're doing *really* badly at the moment regarding community
> > management and attracting (and retaining) new core contributors. This is
> > a topic I really want to discuss face to face during the media workshop
> > in Prague (and I know that many people are looking forward to that
> > discussion).
> 
> I am sorry to hear that. One idea would be offsetting the extra work
> by having the Rust person also take care of some of the C parts too.
> That way you can also potentially get them to be a full maintainer at
> some point, even if the Rust experiment does not pan out.

That's certainly something I would consider very positive. If anyone is
interested in having a look at (part of) the problem and possible
solutions, [1] is the most recent patch series posted to handle some of
the lifetime issues, and [2] is a more generic version of part of [1].

[1] https://lore.kernel.org/linux-media/20230201214535.347075-1-sakari.ailus@linux.intel.com/
[2] https://lore.kernel.org/linux-kernel/161117153248.2853729.2452425259045172318.stgit@dwillia2-desk3.amr.corp.intel.com/

> Of course, easier said than done, and managing more people always
> takes extra time, but getting more people seems to be part of the
> solution anyway, from what you say.
> 
> In any case, thanks a lot for at least considering it :)

-- 
Regards,

Laurent Pinchart
