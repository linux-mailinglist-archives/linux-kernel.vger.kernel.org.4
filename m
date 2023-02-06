Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9377868C757
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 21:14:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbjBFUOw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 15:14:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230189AbjBFUOt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 15:14:49 -0500
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 9C53E1E1FF
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 12:14:48 -0800 (PST)
Received: (qmail 669114 invoked by uid 1000); 6 Feb 2023 15:14:47 -0500
Date:   Mon, 6 Feb 2023 15:14:47 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Elson Roy Serrao <quic_eserrao@quicinc.com>
Cc:     gregkh@linuxfoundation.org, Thinh.Nguyen@synopsys.com,
        balbi@kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, quic_wcheng@quicinc.com,
        quic_jackp@quicinc.com
Subject: Re: [PATCH v3 1/5] usb: gadget: Properly configure the device for
 remote wakeup
Message-ID: <Y+Fft/vGfHxGrvC0@rowland.harvard.edu>
References: <1675710806-9735-1-git-send-email-quic_eserrao@quicinc.com>
 <1675710806-9735-2-git-send-email-quic_eserrao@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1675710806-9735-2-git-send-email-quic_eserrao@quicinc.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 06, 2023 at 11:13:22AM -0800, Elson Roy Serrao wrote:
> The wakeup bit in the bmAttributes field indicates whether the device
> is configured for remote wakeup. But this field should be allowed to
> set only if the UDC supports such wakeup mechanism. So configure this
> field based on UDC capability. Also inform the UDC whether the device
> is configured for remote wakeup by implementing a gadget op.
> 
> Signed-off-by: Elson Roy Serrao <quic_eserrao@quicinc.com>
> ---
>  drivers/usb/gadget/composite.c | 24 +++++++++++++++++++++++-
>  drivers/usb/gadget/udc/core.c  | 27 +++++++++++++++++++++++++++
>  drivers/usb/gadget/udc/trace.h |  5 +++++
>  include/linux/usb/gadget.h     |  8 ++++++++
>  4 files changed, 63 insertions(+), 1 deletion(-)

> diff --git a/include/linux/usb/gadget.h b/include/linux/usb/gadget.h
> index dc3092c..05d1449 100644
> --- a/include/linux/usb/gadget.h
> +++ b/include/linux/usb/gadget.h
> @@ -309,6 +309,7 @@ struct usb_udc;
>  struct usb_gadget_ops {
>  	int	(*get_frame)(struct usb_gadget *);
>  	int	(*wakeup)(struct usb_gadget *);
> +	int	(*set_remotewakeup)(struct usb_gadget *, int set);
>  	int	(*set_selfpowered) (struct usb_gadget *, int is_selfpowered);
>  	int	(*vbus_session) (struct usb_gadget *, int is_active);
>  	int	(*vbus_draw) (struct usb_gadget *, unsigned mA);
> @@ -383,6 +384,8 @@ struct usb_gadget_ops {
>   * @connected: True if gadget is connected.
>   * @lpm_capable: If the gadget max_speed is FULL or HIGH, this flag
>   *	indicates that it supports LPM as per the LPM ECN & errata.
> + * @rw_capable: True if gadget is capable of sending remote wakeup.
> + * @rw_armed: True if gadget is armed by the host for remote wakeup.

Minor stylistic request: Could you choose something other than "rw" to 
start these field names?  For too many people, that abbreviation is 
firmly associated with "read/write".  Maybe just "wakeup"?

Alan Stern
