Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EC7B63A662
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 11:51:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230418AbiK1KvI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 05:51:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230422AbiK1KvD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 05:51:03 -0500
Received: from metanate.com (unknown [IPv6:2001:8b0:1628:5005::111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14BF165C5
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 02:50:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=metanate.com; s=stronger; h=In-Reply-To:Content-Type:References:Message-ID:
        Subject:To:From:Date:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
        Content-Description; bh=rkH4EDzFj5GJH/oZZwg9Xi75afujMR0gQt8dEe9YYLI=; b=StGmS
        K0ahOhPDsedu2XVpS4qA7mxW25pQt+Bj/H+sLEbWNdphHaKe28AHetDF8ZJ1iKnLFbRCGhbunG/1P
        nEtII5K2CEyCD4mlLcjO9W0KbwjDg5rHmwQ52KHUGN9tc1N/6fngh/sm44wzWBQpj+R5IPjLTFS3W
        tmri3aBeI+dUvg7ziKOE5MCMXSigSWLPFt/5l3716ZnbyWq5L+hHAU0gVhfkP7luhv3P3OJhST/Xb
        TkpK4km2FmmcrE45m6LYSLlKKgYHm1rgehEZS+FQltP0zHJyxnPCk6mjrFeEdD8tLNzGqmuUePnMO
        9XrKFSURFeau9RZOKs2/pkXc080ow==;
Received: from [81.174.171.191] (helo=donbot)
        by email.metanate.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <john@metanate.com>)
        id 1ozbiv-0004Ry-79;
        Mon, 28 Nov 2022 10:50:53 +0000
Date:   Mon, 28 Nov 2022 10:50:52 +0000
From:   John Keeping <john@metanate.com>
To:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Takashi Iwai <tiwai@suse.com>
Subject: Re: [PATCH] ALSA: pcm: fix tracing reason in hw_ptr_error
Message-ID: <Y4SSjO8gnIz22vt3@donbot>
References: <20221125162327.297440-1-john@metanate.com>
 <Y4GNWYcQBUKn3KSa@workstation>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y4GNWYcQBUKn3KSa@workstation>
X-Authenticated: YES
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_NONE,SPF_HELO_PASS,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 26, 2022 at 12:51:53PM +0900, Takashi Sakamoto wrote:
> Hi,
> 
> On Fri, Nov 25, 2022 at 04:23:26PM +0000, John Keeping wrote:
> > Strings need to be specially marked in trace events to ensure the
> > content is captured, othewise the trace just shows the value of the
> > pointer.
> > 
> > Signed-off-by: John Keeping <john@metanate.com>
> > ---
> >  sound/core/pcm_trace.h | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
>  
> Thanks for the patch, while I have a slight concern about the intension
> of change.
> 
> Let's see message in below commit to add 'trace_safe_str()' in
> 'kernel/trace/trace.c':
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=9a6944fee68
> 
> "The proper way to handle displaying any string that is not guaranteed to be
> in the kernel core rodata section, is to copy it into the ring buffer via
> the __string(), __assign_str() and __get_str() helper macros."
> 
> Additionally, the macros looks to be alias to __dynamic_array() or so.
> 
> In our case, the pointer of 'why' argument should points to two
> hardcoded strings; "hw_ptr skipping" and "Unexpected hw_ptr". As long as
> I know, they are put into any of .rodata section.
> 
> ```
> $ objdump -s sound/core/snd-pcm.ko -j .rodata.str1.1
> ```
>  0830 74757265 20436861 6e6e656c 204d6170  ture Channel Map
>  0840 00585255 4e3a2025 730a0055 6e657870  .XRUN: %s..Unexp
>  0850 65637465 64206877 5f707472 0068775f  ected hw_ptr.hw_
>  0860 70747220 736b6970 70696e67 004c6f73  ptr skipping.Los
>  0870 7420696e 74657272 75707473 3f00756e  t interrupts?.un
> ```
> 
> I think current implementation is enough safe.

Thanks for this analysis - I hadn't looked into the history of this.

It seems that trace-cmd's record/report functionality does not support
rodata strings in this way though.  Without this patch, the trace log is
not very informative:

	$ trace-cmd record -e snd_pcm:hw_ptr_error
	^C
	$ trace-cmd report
	 irq/49-ehci_hcd-111   [002]    65.785147: hw_ptr_error:         pcmC1D0p/sub0: ERROR: c0b1b3c7

With this patch applied this becomes:

	 irq/49-ehci_hcd-111   [002]   435.758754: hw_ptr_error:         pcmC2D0p/sub0: ERROR: Lost interrupts?

> Nevertheless, explicit usage of the macros are developer friendly in my
> opinion since string buffer in C language tends to bring problems and
> the usage of macro would reduce careless future mistakes. In the case,
> when probing the event, the string is copied to memory for event
> structure, thus it adds slight overhead than current implementation. I
> leave the decision to maintainer.
> 
> To maintainer, if you apply the patch to your tree, feel free to add my
> review tag.
> 
> Reviewed-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
> 
> > diff --git a/sound/core/pcm_trace.h b/sound/core/pcm_trace.h
> > index f18da2050772..350b40b906ca 100644
> > --- a/sound/core/pcm_trace.h
> > +++ b/sound/core/pcm_trace.h
> > @@ -88,19 +88,19 @@ TRACE_EVENT(hw_ptr_error,
> >  		__field( unsigned int, device )
> >  		__field( unsigned int, number )
> >  		__field( unsigned int, stream )
> > -		__field( const char *, reason )
> > +		__string( reason, why )
> >  	),
> >  	TP_fast_assign(
> >  		__entry->card = (substream)->pcm->card->number;
> >  		__entry->device = (substream)->pcm->device;
> >  		__entry->number = (substream)->number;
> >  		__entry->stream = (substream)->stream;
> > -		__entry->reason = (why);
> > +		__assign_str(reason, why);
> >  	),
> >  	TP_printk("pcmC%dD%d%s/sub%d: ERROR: %s",
> >  		  __entry->card, __entry->device,
> >  		  __entry->stream == SNDRV_PCM_STREAM_PLAYBACK ? "p" : "c",
> > -		  __entry->number, __entry->reason)
> > +		  __entry->number, __get_str(reason))
> >  );
> >  
> >  TRACE_EVENT(applptr,
> > -- 
> > 2.38.1
