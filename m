Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50239714F83
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 21:01:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbjE2TBJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 15:01:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjE2TBI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 15:01:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE838BE;
        Mon, 29 May 2023 12:01:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 427F461CF2;
        Mon, 29 May 2023 19:01:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CDD4C433D2;
        Mon, 29 May 2023 19:01:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685386866;
        bh=T+5R6lxbnuo+r+DOxgiHvINIJHvsFc4xC+EMiDuzDTc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=W5TU1hUnj0wtvHQYLnOTZtlxCUwEWu7kG/96xchiAr4xX11dj9Icqw7QfVhOMF6Sa
         RNfnyRjwxT6YL2pi1eVsCcIMd5DtBPp5h9HzONwPiUjHrhREwM8O1VI9b+2ZOWiMjB
         MR8oWsGTJToppTAMuEl4Aha3dM/mUDl8/MvG2kFc=
Date:   Mon, 29 May 2023 20:01:03 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Prashanth K <quic_prashk@quicinc.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] usb: common: usb-conn-gpio: Set last role to unknown
 before initial detection
Message-ID: <2023052943-headfirst-satchel-6d90@gregkh>
References: <1685004825-30157-1-git-send-email-quic_prashk@quicinc.com>
 <2023052513-gestate-tartar-bf15@gregkh>
 <5f144d80-0439-d014-c845-1cfb1adb840a@quicinc.com>
 <2023052801-immersion-venus-ad0f@gregkh>
 <a86f3bd4-8c87-de67-bdb6-fbe88dc23a56@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a86f3bd4-8c87-de67-bdb6-fbe88dc23a56@quicinc.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 30, 2023 at 12:00:15AM +0530, Prashanth K wrote:
> 
> 
> On 28-05-23 05:03 pm, Greg Kroah-Hartman wrote:
> > > > > diff --git a/drivers/usb/common/usb-conn-gpio.c b/drivers/usb/common/usb-conn-gpio.c
> > > > > index e20874c..30bdb81 100644
> > > > > --- a/drivers/usb/common/usb-conn-gpio.c
> > > > > +++ b/drivers/usb/common/usb-conn-gpio.c
> > > > > @@ -257,6 +257,9 @@ static int usb_conn_probe(struct platform_device *pdev)
> > > > >    	platform_set_drvdata(pdev, info);
> > > > >    	device_set_wakeup_capable(&pdev->dev, true);
> > > > > +	/* Set last role to unknown before performing the initial detection */
> > > > > +	info->last_role = USB_ROLE_UNKNOWN;
> > > > 
> > > > Shouldn't last_role have already been set to 0?  If so, why not just
> > > > have this enum value be 0?
> > > Last role would be 0 during first detection, that's the problem here.
> > > During initial detection, if the the new role is detected as USB_ROLE_NONE
> > > (0), then we wouldn't call the set_role(). But it should send the current
> > > role to gadget after the inital detection.
> > 
> > So you are hoping that the old enum type is still assigned to 0?  That's
> > brave, please make it explicit otherwise it's very hard to follow or
> > ensure that this really will happen.  And most of all, document it so
> > that that value remains 0 in the future, otherwise a list of enum types
> > without explicit values are seen as if the values do not matter.
> > 
> > thanks,
> > 
> > greg k-h
> 
> So I think it would be better to add USB_ROLE_UNKNOWN towards the end of
> enum usb_role, so that we can avoid explicit declaration. Is that fine?
> 
>  enum usb_role {
>  	USB_ROLE_NONE,
>  	USB_ROLE_HOST,
>  	USB_ROLE_DEVICE,
> +	USB_ROLE_UNKNOWN,

Either is fine, be explicit, or not, just don't mix the two please.

thanks,

greg k-h
