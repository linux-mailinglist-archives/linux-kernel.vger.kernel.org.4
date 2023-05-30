Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18DDB7156DA
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 09:33:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230404AbjE3Hdr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 03:33:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230373AbjE3HdJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 03:33:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DD3FE4A;
        Tue, 30 May 2023 00:32:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9293D626F8;
        Tue, 30 May 2023 07:32:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 649C6C433D2;
        Tue, 30 May 2023 07:32:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685431963;
        bh=d/OQC623C020own5jXPNP8Wrr5LphZTC2y5V5K1Fmlc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RUzZ3/pbtf1Fbdww88A1RZ8YBfAcq8BaUwdgGXriVxL0DEN+13cFIA0iX0k3OXCn2
         hJGgE4ffVxBs/Ow9a5QzZwTelBq0j7ZHfm0NdPLnKcedM+o/G1p5I4AuAwjvk2aX6V
         hYnulYpqINz3wyanB+OvLJfmNPla0W0GQvca2B/g=
Date:   Tue, 30 May 2023 08:32:40 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Stanley =?utf-8?B?Q2hhbmdb5piM6IKy5b63XQ==?= 
        <stanley_chang@realtek.com>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Michael Grzeschik <m.grzeschik@pengutronix.de>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Flavio Suligoi <f.suligoi@asem.it>,
        Matthias Kaehlcke <mka@chromium.org>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Ray Chi <raychi@google.com>,
        "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
Subject: Re: [PATCH v2 1/3] usb: phy: add usb phy notify port status API
Message-ID: <2023053014-reassure-footwork-f51c@gregkh>
References: <20230525022617.30537-1-stanley_chang@realtek.com>
 <2023052905-maimed-studied-3563@gregkh>
 <647ded70ff024a3081cbf5c45f5da12c@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <647ded70ff024a3081cbf5c45f5da12c@realtek.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 30, 2023 at 02:19:45AM +0000, Stanley Chang[昌育德] wrote:
> Hi Greg,
> 
> > > --- a/include/linux/usb/phy.h
> > > +++ b/include/linux/usb/phy.h
> > > @@ -144,6 +144,10 @@ struct usb_phy {
> > >        */
> > >       int     (*set_wakeup)(struct usb_phy *x, bool enabled);
> > >
> > > +     /* notify phy port status change */
> > > +     int     (*notify_port_status)(struct usb_phy *x,
> > > +             int port, u16 portstatus, u16 portchange);
> > > +
> > >       /* notify phy connect status change */
> > >       int     (*notify_connect)(struct usb_phy *x,
> > >                       enum usb_device_speed speed);
> > 
> > Why can't this be part of the same notify_connect() callback?
> 
> The notify connect is at device ready. But I want notify port status change before port reset.
> 
> > What makes it different somehow?  Please document this much better.
> 
> In Realtek phy driver, we have designed to dynamically adjust disconnection level and calibrate phy parameters.
> So we do this when the device connected bit changes and when the disconnected bit changes.
> Port status change notification:
> 1. Check if portstatus is USB_PORT_STAT_CONNECTION and portchange is USB_PORT_STAT_C_CONNECTION.
>   The device is connected, the driver lowers the disconnection level and calibrates the phy parameters.
> 2. The device disconnects, the driver increases the disconnect level and calibrates the phy parameters.
> 
> If we adjust the disconnection level in notify_connect , the disconnect may have been triggered at this stage. 
> So we need to change that as early as possible.

Please put this type of information in the changelog and in the comments
for the callback when you resubmit it.

thanks,

greg k-h
