Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 045276CFCCF
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 09:32:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231236AbjC3Hca (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 03:32:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230085AbjC3HcK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 03:32:10 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96B165FEC
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 00:32:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0CE73B8264A
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 07:32:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D3DAC433D2;
        Thu, 30 Mar 2023 07:32:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1680161525;
        bh=l35S4EXcqcuAh4e7eAIc+wd5V2Xl7YPJll9iNb2GwPI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yKFZSYToWUOLnfpOoF2JBuzlQdiz5PiCVtmwZUfPbnWZHqFdYIc6LzAmY+jQv6CGC
         fTkP5Q6oZdqnWXye6PXtNgIUBiUI6HRIAfmoXlhkbfc2hgm1mYSU00CGeiKxvRNPYK
         ieqRUdErdzriYJfQ6+mWaQMebi230EImlYKxZCwE=
Date:   Thu, 30 Mar 2023 09:32:02 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Alexander Komrakov <alexander.komrakov@broadcom.com>
Cc:     linux-kernel@vger.kernel.org, giometti@enneenne.com
Subject: Re: [PATCH v5] [PATCH v5] pps: Add elapsed realtime timestamping
Message-ID: <ZCU68tMu10hhsHgB@kroah.com>
References: <20230330072013.393245-1-alexander.komrakov@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230330072013.393245-1-alexander.komrakov@broadcom.com>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 30, 2023 at 12:20:13AM -0700, Alexander Komrakov wrote:
> Some applications like Android needs elapsed realtime timestamping
> to PPS pulse for its clock management. Add sysfs node for this.

Where is the Android code that needs this?  Have a pointer to it
anywhere?

> 
> Signed-off-by: Alexander Komrakov <alexander.komrakov@broadcom.com>
> ---
>  Documentation/ABI/testing/sysfs-pps | 27 +++++++++++++++++++++++
>  Documentation/driver-api/pps.rst    | 19 ++++++++++++++++
>  drivers/pps/kapi.c                  | 24 +++++++++++++++++---
>  drivers/pps/sysfs.c                 | 34 +++++++++++++++++++++++++++++
>  include/linux/pps_kernel.h          |  2 ++
>  5 files changed, 103 insertions(+), 3 deletions(-)

My bot will remind you that you dropped the version information off :(

> diff --git a/Documentation/ABI/testing/sysfs-pps b/Documentation/ABI/testing/sysfs-pps
> index 25028c7bc37d..031ec89e1ed6 100644
> --- a/Documentation/ABI/testing/sysfs-pps
> +++ b/Documentation/ABI/testing/sysfs-pps
> @@ -1,3 +1,30 @@
> +What:		/sys/class/pps/pps0/assert_elapsed

That should be "ppsX" right?

> +Date:		October 2021
> +Contact:	Alexander Komrakov <alexander.komrakov@broadcom.com>
> +Description:
> +		The /sys/class/pps/ppsX/assert_elapsed file reports the
> +		elapsed real-time assert events and the elapsed
> +		real-time assert sequence number of the X-th source
> +		in the form:
> +
> +			<secs>.<nsec>#<sequence>
> +
> +		If the source has no elapsed real-time assert events
> +		the content of this file is empty.
> +
> +What:		/sys/class/pps/ppsX/clear_elapsed
> +Date:		October 2021
> +Contact:	Alexander Komrakov <alexander.komrakov@broadcom.com>
> +Description:
> +		The /sys/class/pps/ppsX/clear_elapsed file reports the elapsed
> +		real-time clear events and the elapsed real-time clear
> +		sequence number of the X-th source in the form:
> +
> +			<secs>.<nsec>#<sequence>
> +
> +		If the source has no elapsed real-time clear events the
> +		content of this file is empty.
> +
>  What:		/sys/class/pps/

Why are your new entries above the main pps entry?  Shouldn't they be
below it?

thanks,

greg k-h
