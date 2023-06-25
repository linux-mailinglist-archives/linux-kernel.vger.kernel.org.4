Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 754D773D154
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 16:13:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbjFYONP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 10:13:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjFYONN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 10:13:13 -0400
Received: from mail.horus.com (mail.horus.com [78.46.148.228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D2A9E43
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 07:13:11 -0700 (PDT)
Received: from [192.168.1.22] (193-81-115-8.adsl.highway.telekom.at [193.81.115.8])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by mail.horus.com (Postfix) with ESMTPSA id E77DE640B4;
        Sun, 25 Jun 2023 16:13:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=horus.com;
        s=20180324; t=1687702389;
        bh=7qJlAOheByQuos5Kt2MzKqpl7IodNTD/r1Gg6wvW1f4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jX1M9Kbq91C7ABFAHT2oWf+t0lV7BHptwiDILsSo5U/HLtYiT186oci1gZ/8BTA+Y
         ov/uJ7/Ob06iCt6yw40TB22lzIH9O9jtGqTZN1Drs15HJMbqGSiqo3nAIPqLmZSdCX
         eTwRjPyW/+Kv5ln7eG6LwWGCCPON6gNDec1/ypb4=
Received: by camel3.lan (Postfix, from userid 1000)
        id 20C345401CD; Sun, 25 Jun 2023 16:13:08 +0200 (CEST)
Date:   Sun, 25 Jun 2023 16:13:08 +0200
From:   Matthias Reichl <hias@horus.com>
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org,
        Dom Cobley <popcornmix@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ALSA: pcm: fix ELD constraints for (E)AC3, DTS(-HD) and
 MLP formats
Message-ID: <ZJhLdE7oXAvIi1Yi@camel3.lan>
Mail-Followup-To: Matthias Reichl <hias@horus.com>,
        Markus Elfring <Markus.Elfring@web.de>, alsa-devel@alsa-project.org,
        kernel-janitors@vger.kernel.org, Dom Cobley <popcornmix@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        LKML <linux-kernel@vger.kernel.org>
References: <20230624165216.5719-1-hias@horus.com>
 <08b8fa18-9520-2959-a6c9-6ea6132d9b46@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <08b8fa18-9520-2959-a6c9-6ea6132d9b46@web.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 25, 2023 at 02:10:21PM +0200, Markus Elfring wrote:
> …
> > This patch fixes the constraints for the common AC3 and DTS formats,
> …
> 
> Please add an imperative change suggestion.

I assumed the motivation was pretty clear from the paragraph above which you
snipped off:

> The SADs of compressed formats contain the channel and sample rate
> info of the audio data inside the compressed stream, but when
> building constraints we must use the rates and channels used to
> transport the compressed streams.
>
> eg 48kHz 6ch EAC3 needs to be transmitted as a 2ch 192kHz stream.

The previous implementation added constraints that could be both too broad
and incomplete at the same time, leading to the audio device accepting
channel/rate combinations that are not supported by the sink while rejecting
combinations that are required to transmit the compressed bitstream.

Typical impact on users is eg "Dolby TrueHD passthrough does not work".

Consider this EDID audio block of a 2020 Sony TV which rejected Dolby TrueHD
passthrough:

    Linear PCM:
      Max channels: 6
      Supported sample rates (kHz): 192 176.4 96 88.2 48 44.1 32
      Supported sample sizes (bits): 24 20 16
    AC-3:
      Max channels: 6
      Supported sample rates (kHz): 48 44.1 32
      Maximum bit rate: 640 kb/s
    DTS:
      Max channels: 6
      Supported sample rates (kHz): 48 44.1 32
      Maximum bit rate: 1504 kb/s
    Enhanced AC-3 (DD+):
      Max channels: 8
      Supported sample rates (kHz): 48 44.1
      Supports Joint Object Coding
    MAT (MLP):
      Max channels: 8
      Supported sample rates (kHz): 48
      Supports Dolby TrueHD, object audio PCM and channel-based PCM
      Hash calculation not required for object audio PCM or channel-based PCM

The old implementation didn't add the 192kHz / 8ch combination that's required
to transport the MLP TrueHD bitstream, so opening the device in 8ch 192kHz mode
failed.

> How do you think about to add the tag “Fixes”?

I've thought about that but decided against it as adding exact constraints
has the chance of breaking existing applications that accidentally relied on
the (incorrect) previous behaviour of adding rather broad constraints.

Consider the following EDID of a 2009 Sony TV:

    Linear PCM:
      Max channels: 2
      Supported sample rates (kHz): 48 44.1 32
      Supported sample sizes (bits): 24 20 16
    AC-3:
      Max channels: 6
      Supported sample rates (kHz): 48 44.1 32
      Maximum bit rate: 640 kb/s
    Enhanced AC-3 (DD+):
      Max channels: 6
      Supported sample rates (kHz): 48 44.1 32

The old implementation would have constraints that allowed up to 6ch output at
32/44.1/48kHz while the correct setup would be to only allow max 2ch output
(both AC3 and EAC3 bitstreams are transmitted in 2ch mode).

So you could successfully output eg 6ch audio (which the sink likely wouldn't accept
and/or only output the first 2 channels) before but now this will get rejected.

so long,

Hias
