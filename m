Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BF0971586F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 10:26:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230302AbjE3I04 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 04:26:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230287AbjE3I0w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 04:26:52 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86720F1;
        Tue, 30 May 2023 01:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685435203; x=1716971203;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Nb6ku5hLPe/6ITYKwhYehWWwfKCYlCrGiz48NGA7ZLk=;
  b=d8ulIDjJtiQy2xHcAY9PZqrXtpffEx4W2ObEP1gFN5vTa9XIXV4zk63x
   Oj/IO7Bf1JILIv8Rx1MagA2AKcrDcfnbI79kFENcfYyezCYzmvhjqW1yU
   NywcoTqVCgGZWHlDs96XF+rD0NDjuiDTGDgtkfADcj/diBsKwxG2seKzP
   4541Jgb0NQDtZTAkyCIGLtPwdV9WI9/JT49SuZJIsubo+A5+qUABAGbo9
   ZLzgoNXzCj4SjOTGSL+WqfPDOxPxagpqdjVCDAaXIBCUR1Uz2Kt9aKmsp
   unz7eRs2y1vM3zUEMsOAs7Sfy9JZEuyd/Ti2prIvNaJVfvCzr1ScY6/D3
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10725"; a="344353041"
X-IronPort-AV: E=Sophos;i="6.00,203,1681196400"; 
   d="scan'208";a="344353041"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2023 01:26:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10725"; a="850673533"
X-IronPort-AV: E=Sophos;i="6.00,203,1681196400"; 
   d="scan'208";a="850673533"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 30 May 2023 01:26:40 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 30 May 2023 11:26:39 +0300
Date:   Tue, 30 May 2023 11:26:39 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Roger Quadros <rogerq@kernel.org>
Cc:     gregkh@linuxfoundation.org, r-gunasekaran@ti.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: typec: tps6598x: Fix broken polling mode after
 system suspend/resume
Message-ID: <ZHWzP6qsgzSayhIO@kuha.fi.intel.com>
References: <20230530065926.6161-1-rogerq@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230530065926.6161-1-rogerq@kernel.org>
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 30, 2023 at 09:59:26AM +0300, Roger Quadros wrote:
> During system resume we need to resume the polling workqueue
> if client->irq is not set else polling will no longer work.
> 
> Fixes: 0d6a119cecd7 ("usb: typec: tps6598x: Add support for polling interrupts status")
> Signed-off-by: Roger Quadros <rogerq@kernel.org>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/tipd/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
> index 438cc40660a1..603dbd44deba 100644
> --- a/drivers/usb/typec/tipd/core.c
> +++ b/drivers/usb/typec/tipd/core.c
> @@ -920,7 +920,7 @@ static int __maybe_unused tps6598x_resume(struct device *dev)
>  		enable_irq(client->irq);
>  	}
>  
> -	if (client->irq)
> +	if (!client->irq)
>  		queue_delayed_work(system_power_efficient_wq, &tps->wq_poll,
>  				   msecs_to_jiffies(POLL_INTERVAL));
>  
> -- 
> 2.34.1

-- 
heikki
