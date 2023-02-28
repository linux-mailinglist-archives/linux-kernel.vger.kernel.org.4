Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB7126A5BF2
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 16:30:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229899AbjB1PaU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 10:30:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbjB1PaN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 10:30:13 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F84823DA0;
        Tue, 28 Feb 2023 07:29:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C11AA6115D;
        Tue, 28 Feb 2023 15:29:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3C2DC433EF;
        Tue, 28 Feb 2023 15:29:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1677598161;
        bh=hcXafIxHuoahz1Cokb3IrPCYphDo8xRmiIBP8KWMMW8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2bvrZc0hDxg6mbBnAIMY0O72OpR3+QAyiBK3BjlyFb+zHGlH4G23le/063J2XMs6B
         HZpUVrM359GPeSUL2HWAH5PPSpBnCd+DCedkVNH01gdwIvQpcTYFkUOwn+ivo09o8Z
         u0z9zhu58bwTCwgfv2/4hxBK71fsF/L1NIFzK3VY=
Date:   Tue, 28 Feb 2023 16:29:18 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Wesley Cheng <quic_wcheng@quicinc.com>
Cc:     srinivas.kandagatla@linaro.org, mathias.nyman@intel.com,
        perex@perex.cz, lgirdwood@gmail.com, andersson@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, Thinh.Nguyen@synopsys.com,
        broonie@kernel.org, bgoswami@quicinc.com, tiwai@suse.com,
        robh+dt@kernel.org, agross@kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-usb@vger.kernel.org, quic_jackp@quicinc.com,
        quic_plai@quicinc.com
Subject: Re: [RFC PATCH v2 12/22] sound: usb: card: Introduce USB SND
 platform op callbacks
Message-ID: <Y/4dzus7J07quj61@kroah.com>
References: <20230126031424.14582-1-quic_wcheng@quicinc.com>
 <20230126031424.14582-13-quic_wcheng@quicinc.com>
 <Y9Ui82OaI54Qx8Ft@kroah.com>
 <2c062ab0-905c-f1fe-eca2-02e23cc9fa6f@quicinc.com>
 <5e5c6481-8d5d-dc3f-e40e-986e3ac30387@quicinc.com>
 <Y/2tsfGGzAlLzxwd@kroah.com>
 <b38b317e-9c5e-a655-4364-df49c3b64b88@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b38b317e-9c5e-a655-4364-df49c3b64b88@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 28, 2023 at 01:19:33AM -0800, Wesley Cheng wrote:
> Hi Greg,
> 
> On 2/27/2023 11:30 PM, Greg KH wrote:
> > On Mon, Feb 27, 2023 at 06:59:32PM -0800, Wesley Cheng wrote:
> > > Hi Greg,
> > > 
> > > On 2/10/2023 2:49 PM, Wesley Cheng wrote:
> > > > Hi Greg,
> > > > 
> > > > On 1/28/2023 5:28 AM, Greg KH wrote:
> > > > > On Wed, Jan 25, 2023 at 07:14:14PM -0800, Wesley Cheng wrote:
> > > > > > Allow for different platforms to be notified on USB SND
> > > > > > connect/disconnect
> > > > > > seqeunces.  This allows for platform USB SND modules to properly
> > > > > > initialize
> > > > > > and populate internal structures with references to the USB SND chip
> > > > > > device.
> > > > > > 
> > > > > > Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
> > > > > > ---
> > > > > >    sound/usb/card.c | 28 ++++++++++++++++++++++++++++
> > > > > >    sound/usb/card.h | 20 ++++++++++++++++++++
> > > > > >    2 files changed, 48 insertions(+)
> > > > > > 
> > > > > > diff --git a/sound/usb/card.c b/sound/usb/card.c
> > > > > > index 26268ffb8274..803230343c16 100644
> > > > > > --- a/sound/usb/card.c
> > > > > > +++ b/sound/usb/card.c
> > > > > > @@ -117,6 +117,24 @@ MODULE_PARM_DESC(skip_validation, "Skip
> > > > > > unit descriptor validation (default: no)
> > > > > >    static DEFINE_MUTEX(register_mutex);
> > > > > >    static struct snd_usb_audio *usb_chip[SNDRV_CARDS];
> > > > > >    static struct usb_driver usb_audio_driver;
> > > > > > +static struct snd_usb_platform_ops *platform_ops;
> > > > > 
> > > > > You can not have a single "platform_ops" pointer, this HAS to be
> > > > > per-bus.
> > > > > 
> > > > 
> > > > Agreed.
> > > > 
> > > 
> > > I looked at seeing how we could implement this at a per bus level, but the
> > > USB class driver model doesn't exactly have a good framework for supporting
> > > this.  Reason being is because, at the time of the USB SND class driver
> > > initialization, there is a big chance that there isn't a USB bus registered
> > > in the system, so the point of adding the operations is not clear.  However,
> > > we need to ensure that we've added the platform/driver operations before any
> > > USB SND devices are detected.
> > 
> > But the offload "engine" is associated with the specific USB bus
> > controller instance in the system, so perhaps you are just not adding
> > this to the correct location?
> > 
> 
> There are several parts to the offload logic:
> 1.  XHCI interrupter/resource components - fetching addresses to the proper
> event ring and transfer rings for the audio DSP.  This is the part which is
> specific to the controller instance, and APIs are being directly exported
> from the XHCI HCD, as the offloading features utilized are only specific for
> XHCI based controllers.  This is handled in patches 1-6 in this series.
> Each XHCI instance will have its own set of interrupters, and transfer
> resources.
> 
> 2.  USB offload class driver - driver which interacts with USB SND for
> operations like UAC descriptor parsing, USB audio device support params, and
> USB endpoint setup (ie issuing SET_INTERFACE to enable the device to start
> playback this is a SETUP transaction).  It will interact with the USB
> backend and items in #1, to set up the audio playback.
> 
> > The sound core shouldn't care about this at all, add the logic to the
> > USB host controller driver instead, why isn't this just another USB bus
> > function?
> > 
> 
> The intention of the platform ops here is to mainly keep track of USB SND
> card/pcm device creation, and access to the main "struct snd_usb_audio".
> This structure carries all the information about the different substreams
> allocated, as well as the formats supported by the audio device.  This is
> passed onto the USB backend, which will be utilized in my next revision to
> allow userspace to specifically select the proper card/PCM device to enable
> offload on.

Oh, I can't wait to see that user/kernel api :)

It's really hard to answer you here as I don't see any patches, and I
don't know how your hardware really works.  But in general, you should
always be working on the bus level here, and that will get rid of any
static lists or any "single controller pointers" that you all have had
in previous versions.

I'll wait for patches to be able to comment further.

thanks,

greg k-h
