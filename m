Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 625936E082B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 09:48:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230070AbjDMHsr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 03:48:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjDMHsp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 03:48:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E1E48A4F;
        Thu, 13 Apr 2023 00:48:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 415EF638E9;
        Thu, 13 Apr 2023 07:47:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 514B0C433EF;
        Thu, 13 Apr 2023 07:47:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1681372073;
        bh=Ds+MxkKs0/lIPSgCrnQJry+1qiKWouiibiaJxitKFcY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FrJeJ2G8SKvoCPcCuWPYZfhj7odZs0u6zB+pSOYFbSjaOjrkw2lp9Rkh+OIsLrqLg
         TgOeFPkMtSawjkV3w9hZCqvUVNiJLX0fyjuxo6El0ujvZuaSkcsHVqZNWYuiBV+0Rr
         QBNbcEvB0EkFQRN5DwlQGLEfZVGK1IdQiDloMXjY=
Date:   Thu, 13 Apr 2023 09:47:50 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Wesley Cheng <quic_wcheng@quicinc.com>
Cc:     Thinh.Nguyen@synopsys.com, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, quic_jackp@quicinc.com,
        quic_ugoswami@quicinc.com
Subject: Re: [PATCH v3 2/3] usb: dwc3: gadget: Stall and restart EP0 if host
 is unresponsive
Message-ID: <2023041310-absolute-task-8ba6@gregkh>
References: <20230410231954.437-1-quic_wcheng@quicinc.com>
 <20230410231954.437-3-quic_wcheng@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230410231954.437-3-quic_wcheng@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 10, 2023 at 04:19:53PM -0700, Wesley Cheng wrote:
> It was observed that there are hosts that may complete pending SETUP
> transactions before the stop active transfers and controller halt occurs,
> leading to lingering endxfer commands on DEPs on subsequent pullup/gadget
> start iterations.
> 
>   dwc3_gadget_ep_disable   name=ep8in flags=0x3009  direction=1
>   dwc3_gadget_ep_disable   name=ep4in flags=1  direction=1
>   dwc3_gadget_ep_disable   name=ep3out flags=1  direction=0
>   usb_gadget_disconnect   deactivated=0  connected=0  ret=0
> 
> The sequence shows that the USB gadget disconnect (dwc3_gadget_pullup(0))
> routine completed successfully, allowing for the USB gadget to proceed with
> a USB gadget connect.  However, if this occurs the system runs into an
> issue where:
> 
>   BUG: spinlock already unlocked on CPU
>   spin_bug+0x0
>   dwc3_remove_requests+0x278
>   dwc3_ep0_out_start+0xb0
>   __dwc3_gadget_start+0x25c
> 
> This is due to the pending endxfers, leading to gadget start (w/o lock
> held) to execute the remove requests, which will unlock the dwc3
> spinlock as part of giveback.
> 
> To mitigate this, resolve the pending endxfers on the pullup disable
> path by re-locating the SETUP phase check after stop active transfers, since
> that is where the DWC3_EP_DELAY_STOP is potentially set.  This also allows
> for handling of a host that may be unresponsive by using the completion
> timeout to trigger the stall and restart for EP0.
> 
> Fixes: c96683798e27 ("usb: dwc3: ep0: Don't prepare beyond Setup stage")

I'm confused.  You have a Fixes: tag here, yet this patch depends on
patch 1/3, right?  This implies that you do not want or need this to be
backported to any stable kernels, right?

Or do you?  If so, put the bug fixes first, and properly add a cc:
stable tag, so that they will get backported correctly.

If not, then don't even put a fixes tag on it as obviously it isn't a
bugfix that is relevant to track anywhere, and then this is just a
normal new feature to be added to the driver.

Please resolve this and submit a new series based on your decision.

thanks,

greg k-h
