Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44C0E72FEB2
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 14:31:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236233AbjFNMbg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 08:31:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244343AbjFNMbc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 08:31:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54FF61FF5;
        Wed, 14 Jun 2023 05:31:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 09241641C7;
        Wed, 14 Jun 2023 12:29:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8092EC433C0;
        Wed, 14 Jun 2023 12:29:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686745773;
        bh=zxon5NMoXVL9mnY8tEa3It+ebZ+D6nHuTWhO9EgoumY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PGW8va75zggAvLloAWsaTQpOBvwXYUx4r1KKPd6PuY3ODIaPou42Cydpt4yxcT6iJ
         md9kWIaFgJfN4xtuvokWOPLOAPhhERR90OtsB62lxvdMh7zeR5hGma6g952DkM2NNW
         +/POYYcIvMoNCF5XuTCvQIQPmXXxGcayQTz25Q0YrzariIv/BvADoDhLNE03uudCGe
         HuV2xvhfxv5sk7zxPThGJYtkdHVguFY6T2+QXpYuXs6RZ0zDldnTIkbm/0vm6gr6eL
         w7JWX6Imhk36P7NmkLcbPuiP6GyCmJYttoVoXyzB5iylf8njKdAX+kqWXSGlyoPvyK
         UsPUxJCPyzgsw==
Date:   Wed, 14 Jun 2023 17:59:28 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Takashi Iwai <tiwai@suse.de>, broonie@kernel.org, tiwai@suse.com,
        corbet@lwn.net, alsa-devel@alsa-project.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_plai@quicinc.com, quic_mohs@quicinc.com
Subject: Re: [PATCH v2] ALSA: compress: allow setting codec params after next
 track
Message-ID: <ZImyqMsNUrzqjuk/@matsya>
References: <20230609150416.24525-1-srinivas.kandagatla@linaro.org>
 <87edmebk2w.wl-tiwai@suse.de>
 <5e9e525a-690d-38ce-d80f-da433d4062fd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5e9e525a-690d-38ce-d80f-da433d4062fd@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14-06-23, 12:55, Srinivas Kandagatla wrote:
> Thanks Takashi for review,
> 
> On 14/06/2023 08:04, Takashi Iwai wrote:
> > On Fri, 09 Jun 2023 17:04:16 +0200,
> > Srinivas Kandagatla wrote:
> > > 
> > > For gapless playback it is possible that each track can have different
> > > codec profile with same decoder, for example we have WMA album,
> > > we may have different tracks as WMA v9, WMA v10 and so on
> > > 
> > > Or if DSP's like QDSP have abililty to switch decoders on single stream
> > > for each track, then this call could be used to set new codec parameters.
> > > 
> > > Existing code does not allow to change this profile while doing gapless
> > > playback.
> > > 
> > > Reuse existing SNDRV_COMPRESS_SET_PARAMS to set this new track params along
> > > some additional checks to enforce proper state machine.
> > > 
> > > With this new changes now the user can call SNDRV_COMPRESS_SET_PARAMS
> > > anytime after setting next track and additional check in write should
> > > also ensure that params are set before writing new data.
> > > 
> > > Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> > > ---
> > > Changes since v1/RFC:
> > > 	- removed introduction of new IOCTL, as suggested.
> > > 	- update the state-machine doc.
> > > 
> > >   .../sound/designs/compress-offload.rst        | 52 +++++++++----------
> > >   sound/core/compress_offload.c                 | 10 ++--
> > >   2 files changed, 33 insertions(+), 29 deletions(-)
> > > 
> > > diff --git a/Documentation/sound/designs/compress-offload.rst b/Documentation/sound/designs/compress-offload.rst
> > > index 935f325dbc77..205cadcabe70 100644
> > > --- a/Documentation/sound/designs/compress-offload.rst
> > > +++ b/Documentation/sound/designs/compress-offload.rst
> > > @@ -256,32 +256,32 @@ Gapless Playback SM
> > >   For Gapless, we move from running state to partial drain and back, along
> > >   with setting of meta_data and signalling for next track ::
> > > -
> > > -                                        +----------+
> > > -                compr_drain_notify()    |          |
> > > -              +------------------------>|  RUNNING |
> > > -              |                         |          |
> > > -              |                         +----------+
> > > -              |                              |
> > > -              |                              |
> > > -              |                              | compr_next_track()
> > > -              |                              |
> > > -              |                              V
> > > -              |                         +----------+
> > > -              |                         |          |
> > > -              |                         |NEXT_TRACK|
> > > -              |                         |          |
> > > -              |                         +----------+
> > > -              |                              |
> > > -              |                              |
> > > -              |                              | compr_partial_drain()
> > > -              |                              |
> > > -              |                              V
> > > -              |                         +----------+
> > > -              |                         |          |
> > > -              +------------------------ | PARTIAL_ |
> > > -                                        |  DRAIN   |
> > > -                                        +----------+
> > > +                            +----------+
> > > +     compr_drain_notify()   |          | compr_set_params() iff next-track set.
> > > +  +------------------------>|  RUNNING |----------------------+
> > > +  |                         |          |                      |
> > > +  |                         +----------+                      |
> > > +  |                              |                            |
> > > +  |                              |                            |
> > > +  |                              | compr_next_track()         |
> > > +  |                              |                            V
> > > +  |                              V                            |
> > > +  |                         +----------+                      |
> > > +  |                         |          |                      |
> > > +  |                         |NEXT_TRACK|                      |
> > > +  |                         |          |                      |
> > > +  |                         +----------+                      |
> > > +  |                              |                            |
> > > +  |                              +----------------------------+
> > > +  |                              |
> > > +  |                              | compr_partial_drain()
> > > +  |                              |
> > > +  |                              V
> > > +  |                         +----------+
> > > +  |                         |          |
> > > +  +------------------------ | PARTIAL_ |
> > > +                            |  DRAIN   |
> > > +                            +----------+
> > >   Not supported
> > >   =============
> > > diff --git a/sound/core/compress_offload.c b/sound/core/compress_offload.c
> > > index 243acad89fd3..fe67228e74b3 100644
> > > --- a/sound/core/compress_offload.c
> > > +++ b/sound/core/compress_offload.c
> > > @@ -294,6 +294,9 @@ static ssize_t snd_compr_write(struct file *f, const char __user *buf,
> > >   	case SNDRV_PCM_STATE_SETUP:
> > >   	case SNDRV_PCM_STATE_PREPARED:
> > >   	case SNDRV_PCM_STATE_RUNNING:
> > > +		/* Make sure next track params are set before writing new data */
> > > +		if (stream->next_track)
> > > +			return -EPERM;
> > 
> > Hm, does this logic correctly match with the comment above?
> Yes I agree, it bit confusing and also going to break the partial drain
> path.
> > Also, this misses the mutex unlock.
> 
> Thinking about this again, Its not required have this check here to start
> with.
> 
> Something like below works, I can send this as v3, if this looks fine.
> 
> ------------------------->cut<----------------------------------
> 
> diff --git a/Documentation/sound/designs/compress-offload.rst
> b/Documentation/sound/designs/compress-offload.rst
> index 935f325dbc77..655624f77092 100644
> --- a/Documentation/sound/designs/compress-offload.rst
> +++ b/Documentation/sound/designs/compress-offload.rst
> @@ -268,11 +268,12 @@ with setting of meta_data and signalling for next
> track ::
>                |                              |
>                |                              V
>                |                         +----------+
> -              |                         |          |
> -              |                         |NEXT_TRACK|
> -              |                         |          |
> -              |                         +----------+
> -              |                              |
> +              |    compr_set_params()   |          |
> +              |             +-----------|NEXT_TRACK|
> +              |             |           |          |
> +              |             |           +--+-------+
> +              |             |              | |
> +              |             +--------------+ |
>                |                              |
>                |                              | compr_partial_drain()
>                |                              |
> diff --git a/sound/core/compress_offload.c b/sound/core/compress_offload.c
> index 243acad89fd3..30f73097447b 100644
> --- a/sound/core/compress_offload.c
> +++ b/sound/core/compress_offload.c
> @@ -589,7 +589,7 @@ snd_compr_set_params(struct snd_compr_stream *stream,
> unsigned long arg)
>         struct snd_compr_params *params;
>         int retval;
> 
> -       if (stream->runtime->state == SNDRV_PCM_STATE_OPEN) {
> +       if (stream->runtime->state == SNDRV_PCM_STATE_OPEN ||
> stream->next_track) {

Yes this would be my idea for this as well, allow params to be set when
we have signalled partial drain

>                 /*
>                  * we should allow parameter change only when stream has
> been
>                  * opened not in other cases
> @@ -612,6 +612,9 @@ snd_compr_set_params(struct snd_compr_stream *stream,
> unsigned long arg)
>                 if (retval)
>                         goto out;
> 
> +               if (stream->next_track)
> +                       goto out;
> +
>                 stream->metadata_set = false;
>                 stream->next_track = false;
> ------------------------->cut<----------------------------------
> 
> > 
> > 
> > thanks,
> > 
> > Takashi

-- 
~Vinod
