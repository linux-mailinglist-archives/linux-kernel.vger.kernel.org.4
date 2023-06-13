Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E54972DE93
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 11:59:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240590AbjFMJ7J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 05:59:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241969AbjFMJ6p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 05:58:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70A8710EC;
        Tue, 13 Jun 2023 02:58:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EFB4362C31;
        Tue, 13 Jun 2023 09:58:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01512C433EF;
        Tue, 13 Jun 2023 09:58:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686650296;
        bh=alSRdSKi4iSyz9lNBhWcs+tLeICDCUhEkolKyAoeKRM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nCgQsFIifHIMOYFuwGlMe0g6FWyA+5YwJtvnUv8kHw/TG+b6IKruRAsWjbqGvPT+x
         svJrRGAvzR4v5+g183fbAz+ZFHIHZtIXMqOy/fAzP0LfbwW0UOTu2zVGxxBtRI7SsI
         87IkS6sb5V5CkCyDpZPcog9hhLzhmocPSmEFmiWg=
Date:   Tue, 13 Jun 2023 11:58:14 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Prashanth K <quic_prashk@quicinc.com>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7] usb: common: usb-conn-gpio: Set last role to unknown
 before initial detection
Message-ID: <2023061307-unguided-headboard-8ad7@gregkh>
References: <1685544074-17337-1-git-send-email-quic_prashk@quicinc.com>
 <665be8f7-0892-3446-72ca-4c45457c9153@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <665be8f7-0892-3446-72ca-4c45457c9153@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 31, 2023 at 08:17:23PM +0530, Prashanth K wrote:
> 
> 
> On 31-05-23 08:11 pm, Prashanth K wrote:
> > diff --git a/drivers/usb/musb/jz4740.c b/drivers/usb/musb/jz4740.c
> > index 5aabdd7..6d880c4 100644
> > --- a/drivers/usb/musb/jz4740.c
> > +++ b/drivers/usb/musb/jz4740.c
> > @@ -95,6 +95,8 @@ static int jz4740_musb_role_switch_set(struct usb_role_switch *sw,
> >   	case USB_ROLE_HOST:
> >   		atomic_notifier_call_chain(&phy->notifier, USB_EVENT_ID, phy);
> >   		break;
> > +	default:
> > +		break;
> >   	}
> >   	return 0;
> > diff --git a/drivers/usb/roles/intel-xhci-usb-role-switch.c b/drivers/usb/roles/intel-xhci-usb-role-switch.c
> > index 5c96e92..4d6a3dd 100644
> > --- a/drivers/usb/roles/intel-xhci-usb-role-switch.c
> > +++ b/drivers/usb/roles/intel-xhci-usb-role-switch.c
> > @@ -97,6 +97,8 @@ static int intel_xhci_usb_set_role(struct usb_role_switch *sw,
> >   		val |= SW_VBUS_VALID;
> >   		drd_config = DRD_CONFIG_STATIC_DEVICE;
> >   		break;
> > +	default:
> > +		break;
> >   	}
> >   	val |= SW_IDPIN_EN;
> >   	if (data->enable_sw_switch) {
> > diff --git a/include/linux/usb/role.h b/include/linux/usb/role.h
> > index b5deafd..65e790a 100644
> > --- a/include/linux/usb/role.h
> > +++ b/include/linux/usb/role.h
> > @@ -11,6 +11,7 @@ enum usb_role {
> >   	USB_ROLE_NONE,
> >   	USB_ROLE_HOST,
> >   	USB_ROLE_DEVICE,
> > +	USB_ROLE_UNKNOWN,
> >   };
> >   typedef int (*usb_role_switch_set_t)(struct usb_role_switch *sw,
> 
> Hi Greg, I have fixed the drivers that doesn't have default case while using
> usb_role enum. Added the same on intel-xhci-usb-role-switch.c &
> musb/jz4740.c files. I was able to compile successfully. Please check once
> if this fixed the build issue.

Looks good, thanks!

greg k-h
