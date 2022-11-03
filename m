Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7B6961832F
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 16:44:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232207AbiKCPoc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 11:44:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231744AbiKCPoM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 11:44:12 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DBC61B7BA;
        Thu,  3 Nov 2022 08:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667490251; x=1699026251;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Z/HJ+bj6Eo7qiPd6yeWolEz7ykFhuBQJvEbNeL9/IcA=;
  b=dWpMi6y41EeVuh3OS1hVLK+6SfkyzuztoUw7lAJJJJ7l4XRX+fB82o0b
   RP/i9RmColt7BB54k/KP4KQCQUnj3Infx7X0UBq20aHvbBMzr2aNshxbv
   IyaEB1pawMj3lc1O+FxiLy5wbBjt4uQr4CE8IGV0CWo5zqb2wRsxVvZCi
   D2/PdgGLNUhsIKzYUGj02g9OO8l0V/guQnMO9dKbz15i3jMpy21RVeWig
   HebCeLktc+8/mz0B18y6k6e+zHGvlisWohpvgryAF8K/8wQj/hlsoiJRW
   03cf5VWHhgk6yNCr8DkptItewsT/QmQvzzKWr3o7tPMJKRMsfhCE99vIg
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10520"; a="308436630"
X-IronPort-AV: E=Sophos;i="5.96,235,1665471600"; 
   d="scan'208";a="308436630"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2022 08:44:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10520"; a="777351032"
X-IronPort-AV: E=Sophos;i="5.96,134,1665471600"; 
   d="scan'208";a="777351032"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 03 Nov 2022 08:43:53 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Thu, 03 Nov 2022 17:43:52 +0200
Date:   Thu, 3 Nov 2022 17:43:52 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Sven Peter <sven@svenpeter.dev>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hector Martin <marcan@marcan.st>,
        Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        asahi@lists.linux.dev
Subject: Re: [PATCH] usb: typec: tipd: Prevent uninitialized event{1,2} in
 IRQ handler
Message-ID: <Y2PhuIM7OJ/Xjsf8@kuha.fi.intel.com>
References: <20221102161542.30669-1-sven@svenpeter.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221102161542.30669-1-sven@svenpeter.dev>
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 02, 2022 at 05:15:42PM +0100, Sven Peter wrote:
> If reading TPS_REG_INT_EVENT1/2 fails in the interrupt handler event1
> and event2 may be uninitialized when they are used to determine
> IRQ_HANDLED vs. IRQ_NONE in the error path.
> 
> Fixes: c7260e29dd20 ("usb: typec: tipd: Add short-circuit for no irqs")
> Fixes: 45188f27b3d0 ("usb: typec: tipd: Add support for Apple CD321X")
> Signed-off-by: Sven Peter <sven@svenpeter.dev>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/tipd/core.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
> index b637e8b378b3..2a77bab948f5 100644
> --- a/drivers/usb/typec/tipd/core.c
> +++ b/drivers/usb/typec/tipd/core.c
> @@ -474,7 +474,7 @@ static void tps6598x_handle_plug_event(struct tps6598x *tps, u32 status)
>  static irqreturn_t cd321x_interrupt(int irq, void *data)
>  {
>  	struct tps6598x *tps = data;
> -	u64 event;
> +	u64 event = 0;
>  	u32 status;
>  	int ret;
>  
> @@ -519,8 +519,8 @@ static irqreturn_t cd321x_interrupt(int irq, void *data)
>  static irqreturn_t tps6598x_interrupt(int irq, void *data)
>  {
>  	struct tps6598x *tps = data;
> -	u64 event1;
> -	u64 event2;
> +	u64 event1 = 0;
> +	u64 event2 = 0;
>  	u32 status;
>  	int ret;
>  

thanks,

-- 
heikki
