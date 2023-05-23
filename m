Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BE2170DC9C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 14:31:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236862AbjEWMbY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 08:31:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236863AbjEWMbW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 08:31:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A516D126;
        Tue, 23 May 2023 05:31:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 33F5C631DA;
        Tue, 23 May 2023 12:31:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4987C433EF;
        Tue, 23 May 2023 12:31:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684845079;
        bh=g2m24cQ4gdROItmruRoaFFe92RJLnSrCp+y/ymODJ8s=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=L+0fOCK34D1zmuin8Wl7I2gS8xbpwc+/hTe4sw9jiQW0h2b20dbAJPF0a34lmLh/F
         XmrAxb1GibB/Dxs3YT6w0dZlJyUOmhUwbidEUmlevoXGzRk38O/ww9tnPxgB0HkyJl
         ae0ROulk07UdRyR5wjzJ2IbmfQhdWXvdaGIfFRJfllboDOkuiBfNj3dUAQ1GESJcxR
         2t2wxumoQwJTHLWFtHU/ZTtOholkBfcBLDm62TGI6it7X1TYjcZWCPeR9PnSccK4nH
         MgoI7Mi7VM5x6dPhpms9OWUTA4srYIpad+p/SuyT8FPt59/rj/vNoR5hulsmjWYKZn
         VSPTIjGlA+krQ==
Date:   Tue, 23 May 2023 14:31:15 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     Linux regressions mailing list <regressions@lists.linux.dev>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?ISO-8859-15?Q?Filipe_La=EDns?= <lains@riseup.net>,
        Bastien Nocera <hadess@hadess.net>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, guy.b@bluewin.ch
Subject: Re: [regression] Since kernel 6.3.1 logitech unify receiver not
 working properly
In-Reply-To: <CAHk-=whvhkSk6m8_AidhofgR9nq0Md+HbNad5r1RE69tZgbv6Q@mail.gmail.com>
Message-ID: <nycvar.YFH.7.76.2305231422180.29760@cbobk.fhfr.pm>
References: <9b987585-0834-bb8c-3414-283c29f3f2ab@leemhuis.info> <bec024d5-4088-00ae-f7b5-7188868b1707@leemhuis.info> <b7717c43-74bf-b91d-d3ce-874493df602c@gmail.com> <CAO-hwJ+At1J_yUpX2q_dJekzZ-PoTDAvxmkTk_e4Yu0Z338bEA@mail.gmail.com>
 <55dda0bb-fe42-6dee-28ea-00121554d092@leemhuis.info> <CAHk-=whvhkSk6m8_AidhofgR9nq0Md+HbNad5r1RE69tZgbv6Q@mail.gmail.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 May 2023, Linus Torvalds wrote:

> > FWIW, in case anybody is interested in a status update: one reporter
> > bisected the problem down to 586e8fede79 ("HID: logitech-hidpp: Retry
> > commands when device is busy"); reverting that commit on-top of 6.3
> > fixes the problem for that reporter. For that reporter things also work
> > on 6.4-rc; but for someone else that is affected that's not the case.

FWIW, I was pretty much away for past few weeks as well, same as Benjamin 
as Bastien. Which is unfortunate timing, but that's how things pan out 
sometimes.

> Hmm. It's likely timing-dependent.
> 
> But that code is clearly buggy.
> 
> If the wait_event_timeout() returns early, the device hasn't replied,
> but the code does
> 
>                 if (!wait_event_timeout(hidpp->wait, hidpp->answer_available,
>                                         5*HZ)) {
>                         dbg_hid("%s:timeout waiting for response\n", __func__);
>                         memset(response, 0, sizeof(struct hidpp_report));
>                         ret = -ETIMEDOUT;
>                 }
> 
> and then continues to look at the response _anyway_.

Yeah; we are zeroing it out, but that doesn't really make things any 
better in principle, given all the dereferences later.

The issue seems to be existing ever since 2f31c52529 ("HID: Introduce 
hidpp, a module to handle Logitech hid++ devices") when this whole driver 
was introduced, as far as I can tell.

> Now, depending on out hardening options, that response may have been 
> initialized by the compiler, or may just be random stack contents.

Again, as in case of timeout the buffer is just zeroed out, I'd just much 
more expect NULL pointer dereference in such case. Which is not what we 
are seeing here.

> That bug is pre-existing (ie the problem was not introduced by that 
> commit), but who knows if the retry makes things worse (ie if it then 
> triggers on a retry, the response data will be the *previous* response).
> 
> The whole "goto exit" games should be removed too, because we're in a
> for-loop, and instead of "goto exit" it should just do "break".
> 
> IOW, something like this might be worth testing.
> 
> That said, while I think the code is buggy, I doubt this is the actual
> cause of the problem people are reporting. But it would be lovely to
> hear if the attached patch makes any difference, and I think this is
> fixing a real - but unlikely - problem anyway.
> 
> And obviously it might be helpful to actually enable those dbg_hid()
> messages, but I didn't look at what the magic config option to do so
> was.

dbg_hid() is just pr_debug(), which means that on kernels with 
CONFIG_DYNAMIC_DEBUG, this makes use of the dynamic debug facility; 
otherwsie it just becomes printk(KERN_DEBUG...).

Thanks,

-- 
Jiri Kosina
SUSE Labs

