Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBE6E656B6B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 14:45:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231743AbiL0NpX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 08:45:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231448AbiL0NpS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 08:45:18 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 353F7DC7;
        Tue, 27 Dec 2022 05:45:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BCD616115E;
        Tue, 27 Dec 2022 13:45:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9ECE7C433D2;
        Tue, 27 Dec 2022 13:45:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1672148716;
        bh=rz3uMAjXUtgjTO4lgVlXOKO3ue1KZ7jGfnmeuq3J5Js=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XapDBzzd/bZ8Mr9cF8NgX64eOKDfmSw6Y7ERRkuEXsBO/tp7dvnoLIqb9N/2kPSJc
         qT9nqMH3v+uDUffDXLsLvnW/Pz48nhnGeHVXohon9StxTJS5DYKaU719Vo61VE7/Hr
         bAyImdXoGvBG3/HEw82VNV5VHPD0AYBixeNBMbbY=
Date:   Tue, 27 Dec 2022 14:45:13 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Wesley Cheng <quic_wcheng@quicinc.com>,
        srinivas.kandagatla@linaro.org, mathias.nyman@intel.com,
        perex@perex.cz, lgirdwood@gmail.com, andersson@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, Thinh.Nguyen@synopsys.com,
        bgoswami@quicinc.com, tiwai@suse.com, robh+dt@kernel.org,
        agross@kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-usb@vger.kernel.org,
        quic_jackp@quicinc.com, quic_plai@quicinc.com
Subject: Re: [RFC PATCH 03/14] ASoC: qcom: Add USB backend ASoC driver for Q6
Message-ID: <Y6r26VfIfpE8zpPY@kroah.com>
References: <20221223233200.26089-1-quic_wcheng@quicinc.com>
 <20221223233200.26089-4-quic_wcheng@quicinc.com>
 <Y6bAQ8hDLkvrvjQQ@kroah.com>
 <Y6rtdy4NPfi/KOqd@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y6rtdy4NPfi/KOqd@sirena.org.uk>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 27, 2022 at 01:04:55PM +0000, Mark Brown wrote:
> On Sat, Dec 24, 2022 at 10:02:59AM +0100, Greg KH wrote:
> > On Fri, Dec 23, 2022 at 03:31:49PM -0800, Wesley Cheng wrote:
> 
> > > + * struct q6usb_offload
> > > + * @dev - dev handle to usb be
> 
> > "be"?  What is that?
> 
> Back end.  This is a concept in DPCM which should be reasonably
> discoverable to people working on the audio portions of this code.

Ok, then how is the reference counting logic handled here?  USB devices
can be removed from the system at any point in time...

> > > +// SPDX-License-Identifier: GPL-2.0
> > > +/*
> > > + * Copyright (c) 2022 Qualcomm Innovation Center, Inc. All rights reserved.
> 
> > All of the code in this patch series is older than 2022 as I know it has
> > been in shipping devices for many years.  Please use the proper
> > copyright year to make your lawyers happy...
> 
> Are you *positive* about this.  Based on some preparatory discussions
> the Qualcomm people had with Takashi and I it seemed like this was a new
> version of existing concepts.  I'm sure they had something already but
> it's not obvious to me that they're just posting the same code.

I thought that this same code has been shipping in devices for a few
years now in the last few Samsung phone models.  Is this not the same
code that is in those devices?

If not, why not, what happened to that codebase that makes it not worthy
of being submitted upstream?

> > > +static const struct snd_soc_dapm_route q6usb_dapm_routes[] = {
> > > +	{"USB Playback", NULL, "USB_RX_BE"},
> > > +};
> 
> > No terminating entry?  How does this not break?  Why do you need to
> > specify the size of the array, that feels like a design bug somewhere.
> 
> It's how the interface works, the number of entries is passed in when
> adding routes.

Ah, you all might want to change that to make it simpler :)

thanks,

greg k-h
