Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF4F370E242
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 18:49:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237623AbjEWQdn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 12:33:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237609AbjEWQdl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 12:33:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAD411A1;
        Tue, 23 May 2023 09:33:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5276E62367;
        Tue, 23 May 2023 16:33:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FED8C433D2;
        Tue, 23 May 2023 16:33:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684859606;
        bh=WU8wuUmy21MK4qAdJrmBCBcvjo7GpSO/DkD02Z+SpZI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tGAyu2ndussgTOBNRGv7f91QfPhfaQJuLmNRlkwBs0UrAnb+ccgG0w9jCEYyCFO1c
         Zk8FNdt/0CcViZWPjgcC9bBdSHgWAfpwbjpmAdv7/rHhAIq+dQj3LKgyzD75FabzlU
         3t99TypKUxTm7sSdsFsCJYe7dMEtptHHZ8JfX5fE=
Date:   Tue, 23 May 2023 17:33:22 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Sergey Shtylyov <s.shtylyov@omp.ru>
Cc:     Wesley Cheng <quic_wcheng@quicinc.com>, mathias.nyman@intel.com,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        quic_jackp@quicinc.com
Subject: Re: [PATCH] usb: host: xhci: Do not re-initialize the XHCI HC if
 being removed
Message-ID: <2023052303-dreaded-professed-d259@gregkh>
References: <20230523015354.18497-1-quic_wcheng@quicinc.com>
 <f34927c3-7f23-3971-9f16-88cb5773f973@omp.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f34927c3-7f23-3971-9f16-88cb5773f973@omp.ru>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 23, 2023 at 11:45:27AM +0300, Sergey Shtylyov wrote:
> Hello!
> 
> On 5/23/23 4:53 AM, Wesley Cheng wrote:
> 
> > During XHCI resume, if there was a host controller error detected the
> > routine will attempt to re-initialize the XHCI HC, so that it can return
> > back to an operational state.  If the XHCI host controller is being
> > removed, this sequence would be already handled within the XHCI halt path,
> > leading to a duplicate set of reg ops/calls.  In addition, since the XHCI
> > bus is being removed, the overhead added in restarting the HCD is
> > unnecessary.  Check for the XHC state before setting the reinit_xhc
> > parameter, which is responsible for triggering the restart.
> > 
> > Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
> > ---
> >  drivers/usb/host/xhci.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
> > index b81313ffeb76..2017ed3ae4a7 100644
> > --- a/drivers/usb/host/xhci.c
> > +++ b/drivers/usb/host/xhci.c
> > @@ -1028,7 +1028,8 @@ int xhci_resume(struct xhci_hcd *xhci, pm_message_t msg)
> >  	temp = readl(&xhci->op_regs->status);
> >  
> >  	/* re-initialize the HC on Restore Error, or Host Controller Error */
> > -	if (temp & (STS_SRE | STS_HCE)) {
> > +	if ((temp & (STS_SRE | STS_HCE)) &&
> > +		!(xhci->xhc_state & XHCI_STATE_REMOVING)) {
> 
>   Please add one more tab here in order not to blend it with the following lines.

Ick, no, please do not do that, it needs to move left instead.

greg k-h
