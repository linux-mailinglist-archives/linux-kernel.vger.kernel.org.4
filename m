Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25B4C60C605
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 10:03:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230214AbiJYIDb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 04:03:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230138AbiJYID2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 04:03:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E946D10DE71;
        Tue, 25 Oct 2022 01:03:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 79519617B9;
        Tue, 25 Oct 2022 08:03:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72758C433C1;
        Tue, 25 Oct 2022 08:03:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1666685006;
        bh=p8P0GS3FIpwPpYKwBDEQTqKude0DJCIEmUZ9yV9u+t8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JOZmhhCaFcnVG0iHvZ91XDZY6ypIvUKqk7uiGWNCdmRNP4seoPWpI2HegtTcV3o7D
         TgJxFm6O13/jp0sCsSy6+2FmA1TwoouNLbycU3VUWM8iMB8nQyFrMbCSmQ9hw1R0/s
         98WKKqs6hWYjwmt5P7/pCiiJO9B3sCOdwqR+OtdE=
Date:   Tue, 25 Oct 2022 10:04:19 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jeff Vanhoof <jdv1029@gmail.com>
Cc:     linux-usb@vger.kernel.org,
        Daniel Scally <dan.scally@ideasonboard.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Felipe Balbi <balbi@kernel.org>,
        Paul Elder <paul.elder@ideasonboard.com>,
        Michael Grzeschik <m.grzeschik@pengutronix.de>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: uvc gadget performance issues with skip interrupt impl
Message-ID: <Y1eYg1ESBtLJFQ20@kroah.com>
References: <20221025063359.GA19049@qjv001-XeonWs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221025063359.GA19049@qjv001-XeonWs>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 25, 2022 at 01:34:01AM -0500, Jeff Vanhoof wrote:
> Hi,
> 
> During the queuing up of requests from the UVC Gadget Driver to DWC3 for one
> frame, if a missed isoc event occurs then it is possible for the next
> consecutive frame(s) to also see missed isoc related errors as a result,
> presenting to the user as a large video stall.
> 
> This issue appears to have come in with the skip interrupt implementation in
> the UVC Gadget Driver:
> 
> usb: gadget: uvc: decrease the interrupt load to a quarter
> https://lore.kernel.org/r/20210628155311.16762-6-m.grzeschik@pengutronix.de
> 
> Below is an example flow of how the issue can occur (and why).
> 
> For example (ISOC use case):
> 1) DWC3 driver has 4 requests queued up from the UVC Gadget Driver.
> 
> 2) First request has IOC bit set due to no_interrupt=0 also being set, and IMI
> bit is set to detect missed ISOC.
> 
> 3) Requests 2,3,4 do not have IOC bit set due to no_interrupt=1 being set for
> them. (Note: Whether or not the IMI bit is set for these requests does not
> matter, issue can still crop up as there is no guarantee that request 2,3,4
> will see a missed isoc event)
> 
> 4) First request gets a missed isoc event and DWC3 returns the req and error to
> UVC Gadget Driver.
> 
> 5) UVC Gadget Driver, in uvc_video_complete, proceeds to cancel the queue by
> calling uvcg_queue_cancel.
> 
> 6) UVC Gadget Driver stops sending additional requests for the current frame.
> 
> 7) DWC3 will still have requests 2,3,4 queued up and sitting in its
> started_list as these requests are not given back to the UVC gadget driver
> because they each have no_interrupt=1 set, and the DWC3 driver will not have
> any additional interrupts triggered for them as a result.
> 
> 8) Approximately 30-100ms later a new frame enters the UVC Gadget Driver (from
> V4L2), and it proceeds to send additional requests to the DWC3 driver.
> 
> 9) Because requests 2,3,4 are still sitting in the started_list of the dwc3
> driver, the driver does not stop and restart the transmission that normally
> helps it recover from the missed isoc situation (this usually happens in
> between frames).
> 
> 10) Some of the requests from the new frame will have no_interrupt=0 set, but
> these requests will be considered missed/late by the DWC3 controller.
> 
> 11) Because these new requests have the IOC bit set (and possibly IMI),
> interrupts will be triggered causing the DWC3 Driver to return the req and
> error to the UVC Gadget Driver.
> 
> 12) And if the last set of requests sent by the UVC Gadget Driver have
> "no_interrupt=1" set, then DWC3 may not interrupt further until new requests
> come in, and the cycle of frame drops/errors will continue.
> 
> I have briefly mentioned this issue in another conversation with Thinh. At the
> time he mentioned that 3 things could possibly be done to help resolve this
> issue:
> 
> 1) The UVC Gadget Driver should ensure that the last requests queued to DWC3
> must always have "no_interrupt=0" set.
> 
> 2) DWC3 can detect stale requests, stop the transmission and give back the
> requests to the UVC Gadget Driver, and restart the transmission for the new set
> of requests.
> 
> 3) Set "no_interrupt=0" for each request.
>  
> I have tested out various implementations for all 3 possibilities and they each
> seem to work ok. Note that these test implementations are not ready for prime
> time, but served as a way to prove that potential changes in these areas could
> help to resolve this issue.
> 
> I believe that a change for the UVC Gadget Driver should be made, but it also
> makes sense for the DWC3 driver to also attempt to recover from this situation
> if possible.
> 
> Does anyone have an opinion on the best way to proceed?

Please see this set of patches and the discussion around them:
	https://lore.kernel.org/r/20221018215044.765044-1-w36195@motorola.com

Some of them are already queued up in my tree and in linux-next, can you
try that?  There are others for the dwc3 driver on the mailing list as
well, testing those would be wonderful if you could do that.

thanks,

greg k-h
