Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B72762BD48
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 13:12:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233199AbiKPMMY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 07:12:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238814AbiKPML7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 07:11:59 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11AE8C7;
        Wed, 16 Nov 2022 04:05:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668600347; x=1700136347;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZEzeXOg/8KU5GCB+dlcVcysuMwxKjq6Ze02vnWC84VM=;
  b=e7bUhimGnN443Asg4/+rgTKV4wW6tlZiMQgQs3GX+fjRr2rK8LjO52Z8
   PAiPdZvV6VmVCGo+e9AiOQfeDXPw/CQXhjEB0k8f0Jmabw7yfzrTE/uMT
   Ua9+WJOKMxzrkihkp+9b3rwNS28Xv2AX3y3k5Qew4t3WpWvTfMrqiwh4j
   rqoa2UWgy+gLDY152JGqSAF+/gBqj2X7HeQix9ALRIVdjtzCf/NnkfqjF
   kJ3t18ymwJdcbDELvcdX6seYraBiuahNyZeSqUKlGrmAS0lLNwYQeAZti
   EMBFeSa/RdCSQx/mAYBpprJv3D+Ep8uo229TqMg/+oZDCuaVq8TAVxih2
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="374660330"
X-IronPort-AV: E=Sophos;i="5.96,167,1665471600"; 
   d="scan'208";a="374660330"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2022 04:05:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="781743266"
X-IronPort-AV: E=Sophos;i="5.96,167,1665471600"; 
   d="scan'208";a="781743266"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 16 Nov 2022 04:05:43 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Wed, 16 Nov 2022 14:05:43 +0200
Date:   Wed, 16 Nov 2022 14:05:43 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Sven Peter <sven@svenpeter.dev>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: typec: Check for ops->exit instead of ops->enter in
 altmode_exit
Message-ID: <Y3TSF+2XkejIk8UG@kuha.fi.intel.com>
References: <20221114165924.33487-1-sven@svenpeter.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221114165924.33487-1-sven@svenpeter.dev>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 14, 2022 at 05:59:24PM +0100, Sven Peter wrote:
> typec_altmode_exit checks if ops->enter is not NULL but then calls
> ops->exit a few lines below. Fix that and check for the function
> pointer it's about to call instead.
> 
> Fixes: 8a37d87d72f0 ("usb: typec: Bus type for alternate modes")
> Signed-off-by: Sven Peter <sven@svenpeter.dev>

No Cc: stable@...?

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/bus.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/typec/bus.c b/drivers/usb/typec/bus.c
> index 26ea2fdec17d..31c2a3130cad 100644
> --- a/drivers/usb/typec/bus.c
> +++ b/drivers/usb/typec/bus.c
> @@ -134,7 +134,7 @@ int typec_altmode_exit(struct typec_altmode *adev)
>  	if (!adev || !adev->active)
>  		return 0;
>  
> -	if (!pdev->ops || !pdev->ops->enter)
> +	if (!pdev->ops || !pdev->ops->exit)
>  		return -EOPNOTSUPP;
>  
>  	/* Moving to USB Safe State */

thanks,

-- 
heikki
