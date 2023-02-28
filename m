Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F2296A53B6
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 08:31:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230196AbjB1Hbj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 02:31:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbjB1Hbd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 02:31:33 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F4851167F;
        Mon, 27 Feb 2023 23:31:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4CD9460FF9;
        Tue, 28 Feb 2023 07:31:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D778C4339B;
        Tue, 28 Feb 2023 07:30:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1677569459;
        bh=e6s4tpTO5in76O06wuyEcoiAxV018g78W3FW7CWNMG8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JmEu1GdtX8gza/6UTwGHjaJOKfGTpyVRZty6nHoB8l3XBYVjcnHFvZuVD8uvAxHWu
         dvRJX31VrceN5IU2JK5gI4TmGk0hJy8ACiJJyk4+FAjShY4+Rg1xxlVx7K4AkHVlNh
         9CLm3iCWZAZcdGukKvVwqxtbOhrftl2jqQBTKcAE=
Date:   Tue, 28 Feb 2023 08:30:57 +0100
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
Message-ID: <Y/2tsfGGzAlLzxwd@kroah.com>
References: <20230126031424.14582-1-quic_wcheng@quicinc.com>
 <20230126031424.14582-13-quic_wcheng@quicinc.com>
 <Y9Ui82OaI54Qx8Ft@kroah.com>
 <2c062ab0-905c-f1fe-eca2-02e23cc9fa6f@quicinc.com>
 <5e5c6481-8d5d-dc3f-e40e-986e3ac30387@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5e5c6481-8d5d-dc3f-e40e-986e3ac30387@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 27, 2023 at 06:59:32PM -0800, Wesley Cheng wrote:
> Hi Greg,
> 
> On 2/10/2023 2:49 PM, Wesley Cheng wrote:
> > Hi Greg,
> > 
> > On 1/28/2023 5:28 AM, Greg KH wrote:
> > > On Wed, Jan 25, 2023 at 07:14:14PM -0800, Wesley Cheng wrote:
> > > > Allow for different platforms to be notified on USB SND
> > > > connect/disconnect
> > > > seqeunces.  This allows for platform USB SND modules to properly
> > > > initialize
> > > > and populate internal structures with references to the USB SND chip
> > > > device.
> > > > 
> > > > Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
> > > > ---
> > > >   sound/usb/card.c | 28 ++++++++++++++++++++++++++++
> > > >   sound/usb/card.h | 20 ++++++++++++++++++++
> > > >   2 files changed, 48 insertions(+)
> > > > 
> > > > diff --git a/sound/usb/card.c b/sound/usb/card.c
> > > > index 26268ffb8274..803230343c16 100644
> > > > --- a/sound/usb/card.c
> > > > +++ b/sound/usb/card.c
> > > > @@ -117,6 +117,24 @@ MODULE_PARM_DESC(skip_validation, "Skip
> > > > unit descriptor validation (default: no)
> > > >   static DEFINE_MUTEX(register_mutex);
> > > >   static struct snd_usb_audio *usb_chip[SNDRV_CARDS];
> > > >   static struct usb_driver usb_audio_driver;
> > > > +static struct snd_usb_platform_ops *platform_ops;
> > > 
> > > You can not have a single "platform_ops" pointer, this HAS to be
> > > per-bus.
> > > 
> > 
> > Agreed.
> > 
> 
> I looked at seeing how we could implement this at a per bus level, but the
> USB class driver model doesn't exactly have a good framework for supporting
> this.  Reason being is because, at the time of the USB SND class driver
> initialization, there is a big chance that there isn't a USB bus registered
> in the system, so the point of adding the operations is not clear.  However,
> we need to ensure that we've added the platform/driver operations before any
> USB SND devices are detected.

But the offload "engine" is associated with the specific USB bus
controller instance in the system, so perhaps you are just not adding
this to the correct location?

The sound core shouldn't care about this at all, add the logic to the
USB host controller driver instead, why isn't this just another USB bus
function?

> To add to the above, in case of OTG/DRD (dual role) designs, the USB HCD/bus
> isn't created until we move into the host role.  At that time, using DWC3 as
> an example, we will create the XHCI platform device, and probe the USB HCD,
> where a USB bus is created.

Great, again, tie it to the specific xhci host controler instance.

> In general, we currently think this USB offload driver should co-exist with
> the USB SND class driver, which handles all devices connected across every
> bus.

And that is incorrect, please do not do that.

> We can add a check to the platform connect routine to ensure that
> there is a reference to the USB backend.  If so, then that particular USB
> bus/sysdev can be supported by the audio DSP.  That way, we do not falsely
> populate USB SND cards which are present on another USB bus/controller.

You should NEVER be able to populate a USB card unless the USB bus
controller has given you the USB interface structure to control, so I do
not understand how this is an issue.

thanks,

greg k-h
