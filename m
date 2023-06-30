Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BEDB743C19
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 14:48:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232292AbjF3Msg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 08:48:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230427AbjF3Mse (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 08:48:34 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 828A5E77;
        Fri, 30 Jun 2023 05:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688129313; x=1719665313;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3XOUS0bUC7kw2hFofc1b/QjEbORwS7xFFD05ImPuD0Y=;
  b=DwOafFxUlr9H/4QLj23Kk1ZE2wEXO11XVyOnbFxCes6r6CJAhDb5ZCwX
   50Tft9EokaH30gP0tNUp8TXzPwTWsCNhc1NTLiIk7RaaZ9G8NPEJstKGt
   zScfssp+wQyVANG/fAufjj75pulo3SfOuKsq37u6wNabr6SH2rpZG1C42
   GPNqM4zNYSkloGPjy9r1+7R7J7R3eOPo1n74x9T3DAdZfu/z7olUAuaWw
   CrH6j4mUxB39AGleUt3gdX1OpoSdy5RkqanNzzzeLGU2p8ahhC9ykrU/w
   Mth4uQ/0fTzvzC9m7U+KXGo/jxXiR1g2wiLDfp/c8Gj9Yc4747loajTjH
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10756"; a="347166201"
X-IronPort-AV: E=Sophos;i="6.01,170,1684825200"; 
   d="scan'208";a="347166201"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2023 05:48:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10756"; a="862281280"
X-IronPort-AV: E=Sophos;i="6.01,170,1684825200"; 
   d="scan'208";a="862281280"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 30 Jun 2023 05:48:30 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Fri, 30 Jun 2023 15:48:29 +0300
Date:   Fri, 30 Jun 2023 15:48:29 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     You Kangren <youkangren@vivo.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open list:USB TYPEC PORT CONTROLLER DRIVERS" 
        <linux-usb@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        opensource.kernel@vivo.com
Subject: Re: [PATCH] usb: typec: tcpm: Replace the ternary conditional
 operator with max()
Message-ID: <ZJ7PHcDXEJHGBwWc@kuha.fi.intel.com>
References: <20230626121105.3252-1-youkangren@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230626121105.3252-1-youkangren@vivo.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 26, 2023 at 08:11:05PM +0800, You Kangren wrote:
> Replace the ternary conditional operator with max() to make the code clean
> 
> Signed-off-by: You Kangren <youkangren@vivo.com>
> ---
>  drivers/usb/typec/tcpm/tcpm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> index 829d75ebab42..2a0b33bd2eb8 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -6353,7 +6353,7 @@ static int tcpm_psy_get_input_power_limit(struct tcpm_port *port,
>  			src_mv = pdo_fixed_voltage(pdo);
>  			src_ma = pdo_max_current(pdo);
>  			tmp = src_mv * src_ma;
> -			max_src_uw = tmp > max_src_uw ? tmp : max_src_uw;
> +			max_src_uw = max(tmp, max_src_uw);

Is that "tmp" useful anymore - why not drop it while at it?

thanks,

-- 
heikki
