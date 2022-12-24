Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4592465597F
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Dec 2022 09:55:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbiLXIzt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Dec 2022 03:55:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230449AbiLXIzX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Dec 2022 03:55:23 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAF50140CA;
        Sat, 24 Dec 2022 00:55:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 83A2CB82153;
        Sat, 24 Dec 2022 08:55:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8AA0C433EF;
        Sat, 24 Dec 2022 08:55:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1671872120;
        bh=viKmcZzp/wbu7S0+5GGw6FGqvwbKp//GP5BtC8Z10i4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZIGB8jc0yvSmiOk9c8oe4uC1zDW6silh0FxTmk15X8AA3AEpWqb57gAbmeKB4bsb8
         GeALnFg45+4CrqaPmZiDvzF+sImgyOaApGiXGhqKDCmCwtJyVR+Eqlepi36rnuH2Op
         xnSqdAYzBZK0e6kUlG09ozOUFwzj0eWOjJyyfdgY=
Date:   Sat, 24 Dec 2022 09:55:17 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Wesley Cheng <quic_wcheng@quicinc.com>
Cc:     srinivas.kandagatla@linaro.org, mathias.nyman@intel.com,
        perex@perex.cz, broonie@kernel.org, lgirdwood@gmail.com,
        andersson@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        Thinh.Nguyen@synopsys.com, bgoswami@quicinc.com, tiwai@suse.com,
        robh+dt@kernel.org, agross@kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-usb@vger.kernel.org, quic_jackp@quicinc.com,
        quic_plai@quicinc.com
Subject: Re: [RFC PATCH 07/14] usb: host: xhci: Add XHCI secondary
 interrupter support
Message-ID: <Y6a+daSIEZaHhz6b@kroah.com>
References: <20221223233200.26089-1-quic_wcheng@quicinc.com>
 <20221223233200.26089-8-quic_wcheng@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221223233200.26089-8-quic_wcheng@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 23, 2022 at 03:31:53PM -0800, Wesley Cheng wrote:
> Implement the XHCI operations for allocating and requesting for a secondary
> interrupter.  The secondary interrupter can allow for events for a
> particular endpoint to be routed to a separate event ring.  The event
> routing is defined when submitting a transfer descriptor to the USB HW.
> There is a specific field which denotes which interrupter ring to route the
> event to when the transfer is completed.
> 
> An example use case, such as audio packet offloading can utilize a separate
> event ring, so that these events can be routed to a different processor
> within the system.  The processor would be able to independently submit
> transfers and handle its completions without intervention from the main
> processor.
> 
> Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
> ---
>  drivers/usb/host/xhci-mem.c  | 219 ++++++++++++++++++++++++++++-------
>  drivers/usb/host/xhci-plat.c |   2 +
>  drivers/usb/host/xhci.c      | 169 ++++++++++++++++++++++++++-
>  drivers/usb/host/xhci.h      |  15 +++
>  4 files changed, 363 insertions(+), 42 deletions(-)
> 
> diff --git a/drivers/usb/host/xhci-mem.c b/drivers/usb/host/xhci-mem.c
> index 81ca2bc1f0be..d5cb4b82ad3d 100644
> --- a/drivers/usb/host/xhci-mem.c
> +++ b/drivers/usb/host/xhci-mem.c
> @@ -1835,6 +1835,7 @@ void xhci_free_erst(struct xhci_hcd *xhci, struct xhci_erst *erst)
>  void xhci_mem_cleanup(struct xhci_hcd *xhci)
>  {
>  	struct device	*dev = xhci_to_hcd(xhci)->self.sysdev;
> +	struct xhci_sec *sec, *tmp;
>  	int i, j, num_ports;
>  
>  	cancel_delayed_work_sync(&xhci->cmd_timer);
> @@ -1846,6 +1847,16 @@ void xhci_mem_cleanup(struct xhci_hcd *xhci)
>  	xhci->event_ring = NULL;
>  	xhci_dbg_trace(xhci, trace_xhci_dbg_init, "Freed event ring");
>  
> +	list_for_each_entry_safe(sec, tmp, &xhci->xhci_sec_list, list) {
> +		list_del(&sec->list);
> +		if (sec->event_ring) {
> +			xhci_ring_free(xhci, sec->event_ring);
> +			xhci_dbg_trace(xhci, trace_xhci_dbg_init,
> +						"Freed secondary ring %d", sec->intr_num);

Odd indentation :(

