Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E247699369
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 12:43:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229541AbjBPLnJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 06:43:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230448AbjBPLnE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 06:43:04 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 011603C2BD;
        Thu, 16 Feb 2023 03:43:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 90D1161F9B;
        Thu, 16 Feb 2023 11:43:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4746C4339B;
        Thu, 16 Feb 2023 11:43:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1676547781;
        bh=JgsxLNy3EStMHUkIrduc9xOwjZIjmp6lKYwNiGQvzhc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=m9RSQ3div2cJc4CfrDUe8b+1Q8fwWyhBMvK3RSpRAOCUrvHH8Us2lg1M6pHnkE4L1
         X09I0yjY1oZqZWk+qfSet5SVUijV38zZcg9ScSMbncJp06j6jt+VxknEjTdKyjobG5
         C3CCMVt839M7ONlOCej/8AewOk2V+lRqCFOERjgE=
Date:   Thu, 16 Feb 2023 12:42:58 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     David Sands <david.sands@biamp.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        david.sands3@gmail.com
Subject: Re: [PATCH RFC] USB: gadget: f_hid: Add GET_REPORT via userspace
 IOCTL
Message-ID: <Y+4Wwm1kFTUEED89@kroah.com>
References: <20230215231529.2513236-1-david.sands@biamp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230215231529.2513236-1-david.sands@biamp.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 16, 2023 at 09:15:29AM +1000, David Sands wrote:
> While supporting GET_REPORT is a mandatory request per the HID
> specification the current implementation of the GET_REPORT request responds
> to the USB Host with an empty reply of the request length. However, some
> USB Hosts will request the contents of feature reports via the GET_REPORT
> request. In addition, some proprietary HID 'protocols' will expect
> different data, for the same report ID, to be to become available in the
> feature report by sending a preceding SET_REPORT to the USB Device that
> defines what data is to be presented when that feature report is
> subsequently retrieved via GET_REPORT (with a very fast < 5ms turn around
> between the SET_REPORT and the GET_REPORT).
> 
> There are two other patch sets already submitted for adding GET_REPORT
> support. The first [1] allows for pre-priming a list of reports via IOCTLs
> which then allows the USB Host to perform the request, with no further
> userspace interaction possible during the GET_REPORT request. And another
> [2] which allows for a single report to be setup by userspace via IOCTL,
> which will be fetched and returned by the kernel for subsequent GET_REPORT
> requests by the USB Host, also with no further userspace interaction
> possible.
> 
> This patch, while loosely based on both the patch sets, differs by allowing
> the option for userspace to respond to each GET_REPORT request by setting
> up a poll to notify userspace that a new GET_REPORT request has arrived. To
> support this, two extra IOCTLs are supplied. The first of which is used to
> retrieve the report ID of the GET_REPORT request (in the case of having
> non-zero report IDs in the HID descriptor). The second IOCTL allows for
> storing report responses in a list for responding to requests.
> 
> The report responses are stored in a list (it will be either added if it
> does not exist or updated if it exists already). A flag (userspace_req) can
> be set to whether subsequent requests notify userspace or not.
> 
> Basic operation when a GET_REPORT request arrives from USB Host:
> 
> - If the report ID exists in the list and it is set for immediate return
>   (i.e. userspace_req == false) then response is sent immediately,
> userspace is not notified
> 
> - The report ID does not exist, or exists but is set to notify userspace
>   (i.e. userspace_req == true) then notify userspace via poll:
> 
> 	- If userspace responds, and either adds or update the response in
> 	  the list and respond to the host with the contents
> 
> 	- If userspace does not respond within the fixed timeout (2500ms)
> 	  but the report has been set prevously, then send 'old' report
> contents
> 
> 	- If userspace does not respond within the fixed timeout (2500ms)
> 	  and the report does not exist in the list then send an empty
> report

Odd line-wrapping.

And what will take this to go from a RFC to a real submission?

Do you have any example userspace code for this?

One note on the user/kernel api:

> --- /dev/null
> +++ b/include/uapi/linux/usb/g_hid.h
> @@ -0,0 +1,26 @@
> +/* SPDX-License-Identifier: GPL-2.0+ WITH Linux-syscall-note */
> +
> +#ifndef __UAPI_LINUX_USB_G_HID_H
> +#define __UAPI_LINUX_USB_G_HID_H
> +
> +#include <linux/types.h>
> +
> +// Maximum HID report length for High-Speed USB (i.e. USB 2.0)
> +#define MAX_REPORT_LENGTH 64
> +
> +struct usb_hidg_report {
> +	__u8 report_id;
> +	bool userspace_req;

bool is not a valid type to cross the user/kernel boundry.  Make it __u8
please.

And document this structure with kerneldoc so that people know how to
use it.

thanks,

greg k-h


> +	__u16 length;
> +	__u8 data[MAX_REPORT_LENGTH];
> +};
> +
> +/* The 'g' code is also used by gadgetfs and hid gadget ioctl requests.
> + * Don't add any colliding codes to either driver, and keep
> + * them in unique ranges (size 0x20 for now).

0x20?

> + */
> +
> +#define GADGET_HID_READ_GET_REPORT_ID   _IOR('g', 0x41, __u8)
> +#define GADGET_HID_WRITE_GET_REPORT     _IOW('g', 0x42, struct usb_hidg_report)

You are using 0x41 and 0x42 here...

thanks,

greg k-h
