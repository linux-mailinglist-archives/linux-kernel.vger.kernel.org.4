Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DDBC73D9E2
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 10:35:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230154AbjFZIfP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 04:35:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjFZIfM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 04:35:12 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEA2C1A1;
        Mon, 26 Jun 2023 01:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687768511; x=1719304511;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8onuanaQNfRRRF00iDqDufDXkTnWdCag9mJHw4FNFiw=;
  b=J8rFdf+nsOMlznX6iTvQnJpNwbnz4y9FoQXj7flldilRzUrtuZ5hlm41
   KqybmkFXLbtO38X6mFipgSq6g1JNBxgf2kwtF9vsWyBlqjoh4UaZsqBOF
   paFOdxaE1Xi9BIOJJPkSpv7njAXP1TTF1kOuoq5tOCnBbPo1CSm8r8EF5
   mZ7dt8h4P6Lb2ajRrR9OBVR534zON0a89b+IGxnYxBToEW4AtPImRENnH
   pnlWMw5V+mPkYQ5xDwKnukaEp+ABud1/x7cPf4QUGtvYoBBjFjeX+8+16
   h5g8TEYlRjUEno0J8/k9W+hRFlRncU0r1V9tuMMnnrQ4DepJayMwryxmo
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10752"; a="447595950"
X-IronPort-AV: E=Sophos;i="6.01,159,1684825200"; 
   d="scan'208";a="447595950"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2023 01:35:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10752"; a="860606274"
X-IronPort-AV: E=Sophos;i="6.01,159,1684825200"; 
   d="scan'208";a="860606274"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 26 Jun 2023 01:35:07 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 26 Jun 2023 11:35:06 +0300
Date:   Mon, 26 Jun 2023 11:35:06 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Frank Wang <frank.wang@rock-chips.com>
Cc:     linux@roeck-us.net, gregkh@linuxfoundation.org,
        sebastian.reichel@collabora.com, heiko@sntech.de,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org, huangtao@rock-chips.com,
        william.wu@rock-chips.com, jianwei.zheng@rock-chips.com,
        yubing.zhang@rock-chips.com, wmc@rock-chips.com
Subject: Re: [v4,1/2] usb: typec: tcpm: fix cc role at port reset
Message-ID: <ZJlNupB/RUYOg74j@kuha.fi.intel.com>
References: <20230616075241.27690-1-frank.wang@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230616075241.27690-1-frank.wang@rock-chips.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 16, 2023 at 03:52:40PM +0800, Frank Wang wrote:
> In the current implementation, the tcpm set CC1/CC2 role to open when
> it do port reset would cause the VBUS removed by the Type-C partner.
> 
> This sets CC1/CC2 according to the default state of port to fix it.
> 
> Signed-off-by: Frank Wang <frank.wang@rock-chips.com>

Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
> Changelog:
> (no changes since v3)
> 
> v2:
>  - Make some tweaking based on the default state of port, commented by Guenter Roeck.
> 
> v1:
>  - https://patchwork.kernel.org/project/linux-usb/patch/20230313025843.17162-2-frank.wang@rock-chips.com/
> 
>  drivers/usb/typec/tcpm/tcpm.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> index 3c6b0c8e2d3ae..9f6aaa3e70ca8 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -4885,7 +4885,8 @@ static void run_state_machine(struct tcpm_port *port)
>  		break;
>  	case PORT_RESET:
>  		tcpm_reset_port(port);
> -		tcpm_set_cc(port, TYPEC_CC_OPEN);
> +		tcpm_set_cc(port, tcpm_default_state(port) == SNK_UNATTACHED ?
> +			    TYPEC_CC_RD : tcpm_rp_cc(port));
>  		tcpm_set_state(port, PORT_RESET_WAIT_OFF,
>  			       PD_T_ERROR_RECOVERY);
>  		break;

thanks,

-- 
heikki
