Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 581C863B21A
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 20:20:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233437AbiK1TUW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 14:20:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233471AbiK1TUQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 14:20:16 -0500
Received: from metanate.com (unknown [IPv6:2001:8b0:1628:5005::111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5DB86245
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 11:20:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=metanate.com; s=stronger; h=In-Reply-To:Content-Type:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description; bh=r137AssrJXVYmY3OjLXheXtN7yuxhyQR1OJqI3kZFPs=; b=PNmxF
        pSKb6RMRGqzzuajMCDJpv4MhkotfpWGbHMtdu9kol4N9HnrlbDQkgygbJlwCCX2tJHzPdoh5/Wjhe
        B77atnoQ9p58XZGXkaKb+Saz93tJmdVMPlk66jibn5maA+Ek7mEp6P6NEW7LVmLUWQFnJNB5K/lBL
        L7xCqufNay6viLEjQkf4ZqMoYDjPMEpB5TC0JgjvGRuYfXEvNCfyCLF8C6BKyAC7TqAZUY/qmNKb3
        uMmWdyoqPsnxGR/plKnDaLQauLniyXOdLFd0CmNkz+CAlkbc5nCuoSvh1aUnvigfmq+mF6/9G1zTw
        p8AiY0rq3oZGo7tPcRslpM/iWaXiQ==;
Received: from [81.174.171.191] (helo=donbot)
        by email.metanate.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <john@metanate.com>)
        id 1ozjfi-0006Ll-Ip;
        Mon, 28 Nov 2022 19:20:07 +0000
Date:   Mon, 28 Nov 2022 19:20:05 +0000
From:   John Keeping <john@metanate.com>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     alsa-devel@alsa-project.org, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ALSA: usb-audio: Add quirk for Tascam Model 12
Message-ID: <Y4UJ5VcgR4/uOgWL@donbot>
References: <20221128122353.763696-1-john@metanate.com>
 <87lenvyyp8.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87lenvyyp8.wl-tiwai@suse.de>
X-Authenticated: YES
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_NONE,SPF_HELO_PASS,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 28, 2022 at 02:51:15PM +0100, Takashi Iwai wrote:
> On Mon, 28 Nov 2022 13:23:52 +0100,
> John Keeping wrote:
> > 
> > Tascam's Model 12 is a mixer which can also operate as a USB audio
> > interface.  The audio interface uses explicit feedback but it seems that
> > it does not correctly handle missing isochronous frames.
> > 
> > When injecting an xrun (or doing anything else that pauses the playback
> > stream) the feedback rate climbs (for example, at 44,100Hz nominal, I
> > see a stable rate around 44,099 but xrun injection sees this peak at
> > around 44,135 in most cases) and glitches are heard in the audio stream
> > for several seconds - this is significantly worse than the single glitch
> > expected for an underrun.
> > 
> > While the stream does normally recover and the feedback rate returns to
> > a stable value, I have seen some occurrences where this does not happen
> > and the rate continues to increase while no audio is heard from the
> > output.  I have not found a solid reproduction for this.
> > 
> > This misbehaviour can be avoided by totally resetting the stream state
> > by switching the interface to alt 0 and back before restarting the
> > playback stream.
> > 
> > Add a new quirk flag which forces the endpoint and interface to be
> > reconfigured whenever the stream is stopped, and use this for the Tascam
> > Model 12.
> > 
> > Signed-off-by: John Keeping <john@metanate.com>
> 
> Thanks for the patch, it's an interesting case.
> About the code change:
> 
> > --- a/sound/usb/endpoint.c
> > +++ b/sound/usb/endpoint.c
> > @@ -1673,6 +1673,13 @@ void snd_usb_endpoint_stop(struct snd_usb_endpoint *ep, bool keep_pending)
> >  		stop_urbs(ep, false, keep_pending);
> >  		if (ep->clock_ref)
> >  			atomic_dec(&ep->clock_ref->locked);
> > +
> > +		if (ep->chip->quirk_flags & QUIRK_FLAG_FORCE_IFACE_RESET &&
> > +		    usb_pipeout(ep->pipe)) {
> > +			ep->need_setup = true;

It seems I missed this when forward porting the patch from 5.15 - this
should be setting ep->need_prepare and will change in v2.

> > +			if (ep->iface_ref)
> > +				ep->iface_ref->need_setup = true;
> > +		}
> 
> Is this the forced reset always safe?  Imagine that you have
> individual playback and capture streams, and what if only one of them
> gets stopped and restarted while another keeps running?

I /think/ this is okay because the interfaces for capture & playback are
separate (although the clock is shared).

There are two endpoints on the playback interface - the playback data
and explicit feedback endpoints - but these are always stopped and
started at the same time so I can't see any problem here.  (Only the
data endpoint will trigger the reset request here due to the
usb_pipeout() check.) 
