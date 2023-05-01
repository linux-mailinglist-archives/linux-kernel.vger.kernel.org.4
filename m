Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D122B6F2F1F
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 09:22:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232218AbjEAHWi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 03:22:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbjEAHWf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 03:22:35 -0400
X-Greylist: delayed 308 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 01 May 2023 00:22:33 PDT
Received: from bluemchen.kde.org (bluemchen.kde.org [IPv6:2001:470:142:8::100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D1A3B6
        for <linux-kernel@vger.kernel.org>; Mon,  1 May 2023 00:22:33 -0700 (PDT)
Received: from ugly.fritz.box (localhost [127.0.0.1])
        by bluemchen.kde.org (Postfix) with ESMTP id 5F62024179;
        Mon,  1 May 2023 03:17:20 -0400 (EDT)
Received: by ugly.fritz.box (masqmail 0.3.4, from userid 1000)
        id 1ptNmi-FyQ-00; Mon, 01 May 2023 09:17:20 +0200
Date:   Mon, 1 May 2023 09:17:20 +0200
From:   Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To:     Jeff Chua <jeff.chua.linux@gmail.com>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Takashi Iwai <tiwai@suse.de>
Subject: Re: linux-6.4 alsa sound broken
Message-ID: <ZE9ngFLRqLkN6faH@ugly>
Mail-Followup-To: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>,
        Jeff Chua <jeff.chua.linux@gmail.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>, Takashi Iwai <tiwai@suse.de>
References: <CAAJw_ZsbTVd3Es373x_wTNDF7RknGhCD0r+NKUSwAO7HpLAkYA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAAJw_ZsbTVd3Es373x_wTNDF7RknGhCD0r+NKUSwAO7HpLAkYA@mail.gmail.com>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 01, 2023 at 11:59:12AM +0800, Jeff Chua wrote:
>Latest git pull from Linus's tree ... playing a simple sound file will
>resulted in a lot of echo.
>
how _exactly_ does it sound?
have you recorded a file through loopback for us to investigate? best 
would be a short sample of a clean wave (sine or sawtooth) with some 
leading and trailing silence.

>Running on Lenovo X1 with ..
>00:1f.3 Audio device: Intel Corporation Alder Lake PCH-P High
>Definition Audio Controller (rev 01)
>
>I've bisected and reverted the following patch fixed the problem.
>
this seems weird. so my first thought is: are you _sure_ that your 
bisect isn't "contaminated" somehow? is the effect consistent across 
several reboots with the same build? does re-applying my patch 
immediately re-introduce the problem?

- this code is about silencing. getting dropouts or no playback at all 
   would be plausible, while echo (that is, repetition) seems surprising.
   theoretically, the driver may be setting a bad fill_silence() callback 
   which copies some garbage instead of zeroing, but the HDA driver 
   doesn't set one at all (i.e., uses the default one).
- this code must be explicitly enabled, which for all i know is done by 
   almost nothing. what players did you try? did you get consistent 
   results? did you try taking out audio servers from the equation?
- the affected hardware belongs to the extremely widely used HDA family, 
   which at the layer the patch is even remotely connected with is 
   completely standardized. so _a lot_ of people should be affected, and 
   we should be getting reports like yours by the dozen. are we?

of course i can't exclude the possibility that my patch is affected by 
an uninitialized variable or memory corruption (or in the worst case 
causes it), which would of course have very hard to predict effects. but 
that should be investigated properly instead of just reverting, lest we 
might be papering over a much more serious problem.

-- ossi

>commit 9f656705c5faa18afb26d922cfc64f9fd103c38d
>Author: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
>Date:   Thu Apr 20 13:33:23 2023 +0200
>
>    ALSA: pcm: rewrite snd_pcm_playback_silence()
>
>    The auto-silencer supports two modes: "thresholded" to fill up "just
>    enough", and "top-up" to fill up "as much as possible". The two modes
>    used rather distinct code paths, which this patch unifies. The only
>    remaining distinction is how much we actually want to fill.
>
>    This fixes a bug in thresholded mode, where we failed to use new_hw_ptr,
>    resulting in under-fill.
>
>    Top-up mode is now more well-behaved and much easier to understand in
>    corner cases.
>
>    This also updates comments in the proximity of silencing-related data
>    structures.
>
>    Signed-off-by: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
>    Reviewed-by: Jaroslav Kysela <perex@perex.cz>
>    Link: https://lore.kernel.org/r/20230420113324.877164-1-oswald.buddenhagen@gmx.de
>    Signed-off-by: Takashi Iwai <tiwai@suse.de>
