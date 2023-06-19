Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F21E735ACB
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 17:07:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230308AbjFSPH2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 11:07:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbjFSPHR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 11:07:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0773610FE;
        Mon, 19 Jun 2023 08:06:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BCD2360CA0;
        Mon, 19 Jun 2023 15:06:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 219B1C433C8;
        Mon, 19 Jun 2023 15:06:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687187207;
        bh=68pHvNEjGgMDZeKdqaK5OhjSf82d8Kjku7zDW9PYkYw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SImQxy688z/P6cKz+8EDhzhPPkamlzmTFEfskk0yD6TwyTkX5JPVltFh13aPGaXKr
         X1BLNeMGMsh6Q6C85ZZ6rVDW5orAS27eyvkp+ezoZuho1aAb3tZZeo7yAwGpzrw8s6
         3cTgPf3245a3OlrXMEynIqwKKa9sS78dblHlaPQQNfrpSKNtBFCoZLIU/To8L/jF95
         Dn9BhKmlfThsYnpYRHThoCEaaCDC5b6DHqVelzEIRZ3sY9mS4iruOHIozcYqc+aGMM
         98fgaelS/YDCKcqlu8fOvPEdmeCJIKVNBlDDs2xXv5tPax40DV9rXAUJFA20ctLSle
         2YZ6wYbKGz5Gg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1qBGSq-0003ZO-Ul; Mon, 19 Jun 2023 17:06:45 +0200
Date:   Mon, 19 Jun 2023 17:06:44 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
Cc:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_ppratap@quicinc.com, quic_wcheng@quicinc.com,
        quic_jackp@quicinc.com, quic_ugoswami@quicinc.com
Subject: Re: [PATCH v3] usb: dwc3: gadget: Propagate core init errors to UDC
 during pullup
Message-ID: <ZJBvBE-xy2X_wWO0@hovoldconsulting.com>
References: <20230618120949.14868-1-quic_kriskura@quicinc.com>
 <ZI_-c5g20DSJOSu2@hovoldconsulting.com>
 <fca531e0-88ec-ba19-2c11-e8965ac653b2@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fca531e0-88ec-ba19-2c11-e8965ac653b2@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 19, 2023 at 06:20:43PM +0530, Krishna Kurapati PSSNV wrote:
> On 6/19/2023 12:36 PM, Johan Hovold wrote:
> > On Sun, Jun 18, 2023 at 05:39:49PM +0530, Krishna Kurapati wrote:

> >> @@ -2747,7 +2747,9 @@ static int dwc3_gadget_pullup(struct usb_gadget *g, int is_on)
> >>   	ret = pm_runtime_get_sync(dwc->dev);
> >>   	if (!ret || ret < 0) {
> >>   		pm_runtime_put(dwc->dev);
> >> -		return 0;
> >> +		if (ret < 0)
> >> +			pm_runtime_set_suspended(dwc->dev);
> > 
> > This bit is broken and is also not mentioned or explained in the commit
> > message. What are you trying to achieve here?
> > 
> > You cannot set the state like this after runtime PM is enabled and the
> > above call will always fail.

> The reason why I an returning ret is because, when the first get_sync 
> fails because of core_init failure and we return 0 instead of ret, the 
> UDC thinks that controller has started successfully but we never set the 
> run stop bit.

That bit is clear.

> So when we plug out the cable,  the disconnect event won't 
> be generated and we never send on systems like android the user space 
> will never clear the UDC upon disconnect. Its a sort of mismatch between 
> controller and udc.

Ok, but the controller is an error state after the resume failure. And
here you rely on user space to retry gadget activation in order to
eventually detect the disconnect event?
 
> Also once the first get_sync fails, the dwc->dev->power.runtime_error 
> flag is set and successive calls to get_sync always return -EINVAL. In 
> this situation even if UDC/configfs retry pullup, resume_common will 
> never be called and we never actually start the controller or resume 
> dwc->dev.
> 
> By calling set_suspended, I am trying to clear the runtime_error flag so 
> that the next retry to pullup will call resume_common and retry 
> core_init and set run_stop.

Ok, thanks, that's the bit I was missing in the commit message.

First, I perhaps mistakingly thought pm_runtime_set_suspended() may only
be called with PM runtime disabled, but it appears it may indeed be
valid to call also after an error but with the caveat that the device
must then actually be in the suspended state.

The documentation and implementation is inconsistent here as the kernel
doc for pm_runtime_set_suspended() clearly states:

	It is not valid to call this function for devices with runtime
	PM enabled.

and it also looks like we'd end up with an active-child counter
imbalance if anyone actually tries to do so.

But either way, it also seems like the controller is not guaranteed to
be suspended here as pm_runtime_get_sync() may also fail after a
previous errors that have left the controller in the active state?

Also, what kind of errors would cause core_init and resume to fail here?

If this is something that you see during normal operation then this
seems to suggest that something is wrong with the runtime pm
implementation.

Note that virtually all drivers treat resume failures as fatal errors
and do not implement any recovery from that.

In fact, the only other example of this kind of usage that I could find
is also for a Qualcomm driver...

Johan
