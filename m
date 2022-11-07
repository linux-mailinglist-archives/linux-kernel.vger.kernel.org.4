Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07F9961F9C6
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 17:30:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232280AbiKGQal (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 11:30:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232024AbiKGQaO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 11:30:14 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DDA662D4;
        Mon,  7 Nov 2022 08:28:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667838509; x=1699374509;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5Dh3fRjsl8pAe1P7xzifpSAyBwnCJbEPf3YfnGJ20vc=;
  b=Dv6XiDZbrZSaTkc9vKl8nZh/ul0K+x0smKid7vsbu/lGQk45YgkL4VGE
   q8oc7D/GVnae1i/aCElvTCHGJHE24NPyrwThLk6T0P5eK3hhieugqfXGT
   ezrrAGq166pJd5NfFF9jRKpfvzZy+EC2a8gJAIfDyDw10LrdtFE8KW0/v
   vuqI+h283kIksAWLHL+l0l2Iu2lWEhJPHKVtbi3yyFP7dbaJtTP4LY1mb
   Ri7aI1ysqDxy5S3cvBWczlWCFmw7+Ky5JT9erlAhGQ5E1IPkSXBLDNAcz
   SWE5mfuXhcE/Wgi2Mn7TJ1N7/Oj6ZOFqkv6HXrAawxNTjN4Oupk6msXNH
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10524"; a="290176906"
X-IronPort-AV: E=Sophos;i="5.96,145,1665471600"; 
   d="scan'208";a="290176906"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2022 08:28:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10524"; a="778549564"
X-IronPort-AV: E=Sophos;i="5.96,145,1665471600"; 
   d="scan'208";a="778549564"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 07 Nov 2022 08:28:23 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 07 Nov 2022 18:28:22 +0200
Date:   Mon, 7 Nov 2022 18:28:22 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Yassine Oudjana <yassine.oudjana@gmail.com>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Alvin =?utf-8?Q?=C5=A0ipraga?= <alsi@bang-olufsen.dk>,
        Marek Vasut <marex@denx.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yassine Oudjana <y.oudjana@protonmail.com>
Subject: Re: [PATCH v2] extcon: usbc-tusb320: Call the Type-C IRQ handler
 only if a port is registered
Message-ID: <Y2kyJqfhB4DXt7Te@kuha.fi.intel.com>
References: <20221107153317.657803-1-y.oudjana@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221107153317.657803-1-y.oudjana@protonmail.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 07, 2022 at 06:33:17PM +0300, Yassine Oudjana wrote:
> From: Yassine Oudjana <y.oudjana@protonmail.com>
> 
> Commit bf7571c00dca ("extcon: usbc-tusb320: Add USB TYPE-C support")
> added an optional Type-C interface to the driver but missed to check
> if it is in use when calling the IRQ handler. This causes an oops on
> devices currently using the old extcon interface. Check if a Type-C
> port is registered before calling the Type-C IRQ handler.
> 
> Fixes: bf7571c00dca ("extcon: usbc-tusb320: Add USB TYPE-C support")
> Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
> Reviewed-by: Marek Vasut <marex@denx.de>

Looks good to me. FWIW:

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
> Changes since v1:
> - Drop "for backward compatibility" from comment to avoid confusion on
>   whether Type-C is meant to be the old or new interface.
> 
>  drivers/extcon/extcon-usbc-tusb320.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/extcon/extcon-usbc-tusb320.c b/drivers/extcon/extcon-usbc-tusb320.c
> index 41041ff0fadb..2a120d8d3c27 100644
> --- a/drivers/extcon/extcon-usbc-tusb320.c
> +++ b/drivers/extcon/extcon-usbc-tusb320.c
> @@ -327,7 +327,13 @@ static irqreturn_t tusb320_irq_handler(int irq, void *dev_id)
>  		return IRQ_NONE;
>  
>  	tusb320_extcon_irq_handler(priv, reg);
> -	tusb320_typec_irq_handler(priv, reg);
> +
> +	/*
> +	 * Type-C support is optional. Only call the Type-C handler if a
> +	 * port had been registered previously.
> +	 */
> +	if (priv->port)
> +		tusb320_typec_irq_handler(priv, reg);
>  
>  	regmap_write(priv->regmap, TUSB320_REG9, reg);
>  
> -- 
> 2.38.1

thanks,

-- 
heikki
