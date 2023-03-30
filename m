Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7CE26D0264
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 13:02:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231451AbjC3LB7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 07:01:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231381AbjC3LB5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 07:01:57 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C38AA83DA;
        Thu, 30 Mar 2023 04:01:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5D6D6B8280A;
        Thu, 30 Mar 2023 11:01:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABEA7C433EF;
        Thu, 30 Mar 2023 11:01:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1680174114;
        bh=sVMwGdwUmnVMf+r89KBJ9wybHtCCSvQ110fsfy2IX38=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FBqHCOUt19e3CNoMUMxAIpxbOVJiJRJDmUFDPXMc2BipFPQsxzVBJvRT7mX22+HUX
         ObcxlMbd0EtBMqDE8Cgt859JO0rORItDNWUkH06Z/sOnXOP/ybL5bityHBtGfNKTTY
         2vIdlWjjYp7kiBIA93LXsc5jRlbiIR7oj5RCvteg=
Date:   Thu, 30 Mar 2023 13:01:51 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Rajat Khandelwal <rajat.khandelwal@linux.intel.com>
Cc:     heikki.krogerus@linux.intel.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: typec: intel_pmc_mux: Expose IOM port status to
 debugfs
Message-ID: <ZCVsH2KkfcMA86hJ@kroah.com>
References: <20230330104821.773053-1-rajat.khandelwal@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230330104821.773053-1-rajat.khandelwal@linux.intel.com>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 30, 2023 at 04:18:21PM +0530, Rajat Khandelwal wrote:
> IOM status has a crucial role during debugging to check the
> current state of the type-C port.
> There are ways to fetch the status, but all those require the
> IOM port status offset, which could change with platform.
> 
> Make a debugfs directory for intel_pmc_mux and expose the status
> under it per port basis.
> 
> Signed-off-by: Rajat Khandelwal <rajat.khandelwal@linux.intel.com>
> Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> ---
>  drivers/usb/typec/mux/intel_pmc_mux.c | 44 +++++++++++++++++++++++++++
>  1 file changed, 44 insertions(+)
> 
> diff --git a/drivers/usb/typec/mux/intel_pmc_mux.c b/drivers/usb/typec/mux/intel_pmc_mux.c
> index 34e4188a40ff..c99d20888f5d 100644
> --- a/drivers/usb/typec/mux/intel_pmc_mux.c
> +++ b/drivers/usb/typec/mux/intel_pmc_mux.c
> @@ -15,6 +15,7 @@
>  #include <linux/usb/typec_mux.h>
>  #include <linux/usb/typec_dp.h>
>  #include <linux/usb/typec_tbt.h>
> +#include <linux/debugfs.h>
>  
>  #include <asm/intel_scu_ipc.h>
>  
> @@ -145,6 +146,8 @@ struct pmc_usb {
>  	u32 iom_port_status_offset;
>  };
>  
> +static struct dentry *pmc_mux_debugfs_root;

Why not just look up the dentry and delete it when you want it with a
call to debugfs_lookup_and_remove() instead?  That way you don't have to
keep it around (hint, pass it back from your call to
pmc_mux_debugfs_init() or better yet, don't even have a
pmc_mux_debugfs_init() function as it only contains one line and is
only called in one place.

This will save you the storage space of this variable if debugfs is not
enabled in your kernel.  A small amount, yes, but it's nicer, right?

thanks,

greg k-h
