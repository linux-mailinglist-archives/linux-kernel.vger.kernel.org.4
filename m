Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CFF46E8DDF
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 11:21:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234285AbjDTJVx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 05:21:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234201AbjDTJVm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 05:21:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C139D270D;
        Thu, 20 Apr 2023 02:21:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5DBE16467C;
        Thu, 20 Apr 2023 09:21:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F4F3C433D2;
        Thu, 20 Apr 2023 09:21:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1681982499;
        bh=41zp8s6DCKF1QkFeef3TFkstg6ARPYXBn9weK4WnGrg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fEd72hLA74Www24YA1rQYRidBlnLEEmVWy2Lg7OnI3BHzsIttJPqtYSTbbjEKSWyR
         cz813b79HxGJ3mKHWquMTrWpHD2D3ysOQER6DUDUVRne1v8Lq10B4fiXr1R/W75sFM
         bxnjGLJavPhRBmTauowsUsrdmR1IFRYHdC2aANto=
Date:   Thu, 20 Apr 2023 11:21:37 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Wesley Cheng <quic_wcheng@quicinc.com>
Cc:     Thinh.Nguyen@synopsys.com, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH v5 0/3] Avoid having pending end transfers on soft
 disconnect
Message-ID: <ZEEEIfqTKiM6CKAR@kroah.com>
References: <20230413195742.11821-1-quic_wcheng@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230413195742.11821-1-quic_wcheng@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 13, 2023 at 12:57:39PM -0700, Wesley Cheng wrote:
> In case there is a host which takes time to complete a SETUP transaction,
> during the soft disconnect sequence multiple DWC3 EPs will have their
> DWC3_EP_DELAY_STOP flag set w/o issuing the end transfer command.  Once the
> controller halt sequence occurs, the soft disconnect is successful, and
> the subsequent soft connect will attempt to flush the pending end transfers.
> 
> Soft disconnect sequence:
>   dwc3_gadget_ep_disable   name=ep8in flags=0x3009  direction=1
>   dwc3_gadget_ep_disable   name=ep4in flags=1  direction=1
>   dwc3_gadget_ep_disable   name=ep3out flags=1  direction=0
>   usb_gadget_disconnect   deactivated=0  connected=0  ret=0
> 
> Soft connect bug:
>   BUG: spinlock already unlocked on CPU
>   spin_bug+0x0
>   dwc3_remove_requests+0x278
>   dwc3_ep0_out_start+0xb0
>   __dwc3_gadget_start+0x25c
> 
> The bug occurs due to the flush of the pending end transfers, as the gadget
> start routine is not held with a spinlock.  However, if the DWC3_EP_DELAY_STOP
> is set, it will call the giveback API, which attempts to unlock the dwc->lock.
> Ideally, the DWC3 gadget should not have pending end transfers on a soft
> connect, so fix this by:
> 
>  1. Re-locating the SETUP phase check after stop active transfers, since
>  that is where the DWC3_EP_DELAY_STOP is potentially set.  This also allows
>  for handling of a host that may be unresponsive by using the completion
>  timeout to trigger the stall and restart for EP0.
> 
>  2. Do not call gadget stop until the poll for controller halt is
>  completed.  DEVTEN is cleared as part of gadget stop, so the intention to
>  allow ep0 events to continue while waiting for controller halt is not
>  happening.

Only patch 1 applied, can you rebase the rest and resend with the acks
applied?

thanks,

greg k-h

