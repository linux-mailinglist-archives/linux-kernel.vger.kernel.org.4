Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDEBB6E06D7
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 08:22:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbjDMGWY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 02:22:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229836AbjDMGWV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 02:22:21 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D66B61A1;
        Wed, 12 Apr 2023 23:22:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681366940; x=1712902940;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cZESwgIlk1I8vfBOGAvQXzooT82QEWSameprF1BTFBU=;
  b=MhmFIszDQD0M34YSpH8O82a+wpBihnwM9u/GyoirSDpnh+N/ItlzGJTj
   r0VOAntdGEElDj39/nrRmTbLPOtURU54ZrQwgMEYvpMxBuLq9dTzhJFdJ
   r1XN4EwYYmGRmFPj7OaWqEV21jYNJUxqktMCcOrEBdZSkjuTOgS/oOWXj
   TCiYHL1SUtfBAhI/1TDRttOaMO4fzeSgoZiM9tOrkPS67sa7YZbLIGRw8
   H9VKqvv17IcVT7Y9GKgya2b2S70fT+bvuKfqe6lGtKfhgqpz7G89wM5D4
   IQ6kDaf6FMfq+nkMnAX/NefXxClG+OitVfSJ25iECR3kWGKHPbFjFesW3
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="406936203"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="406936203"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2023 23:22:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="832996332"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="832996332"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 12 Apr 2023 23:22:16 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Thu, 13 Apr 2023 09:22:15 +0300
Date:   Thu, 13 Apr 2023 09:22:15 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH] usb: typec: ucsi: don't print PPM init deferred errors
Message-ID: <ZDeflxzawVNxhsL7@kuha.fi.intel.com>
References: <20230412161734.3425090-1-fabrice.gasnier@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230412161734.3425090-1-fabrice.gasnier@foss.st.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 12, 2023 at 06:17:34PM +0200, Fabrice Gasnier wrote:
> ucsi_init() may be deferred as usb_role_sw may be deferred in
> ucsi_register_port(). This results in several PPM init failed (-517)
> messages maybe printed several times upon boot, like on stm32mp135f-dk
> board, until the role_switch driver gets probed.
> 
> [   19.880945] dwc2 49000000.usb: supply vusb_d not found, using dummy regulator
> [   19.887136] dwc2 49000000.usb: supply vusb_a not found, using dummy regulator
> [   19.975432] ucsi-stm32g0-i2c 0-0053: PPM init failed (-517)
> [   20.155746] dwc2 49000000.usb: EPs: 9, dedicated fifos, 952 entries in SPRAM
> [   20.175429] ucsi-stm32g0-i2c 0-0053: PPM init failed (-517)
> [   20.184242] dwc2 49000000.usb: DWC OTG Controller
> 
> Adopt dev_err_probe() instead of dev_err(), to only print other errors.
> Also print an error in case the wait count has expired.
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/ucsi/ucsi.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
> index f632350f6dcb..4d809e0d7761 100644
> --- a/drivers/usb/typec/ucsi/ucsi.c
> +++ b/drivers/usb/typec/ucsi/ucsi.c
> @@ -1447,11 +1447,13 @@ static void ucsi_init_work(struct work_struct *work)
>  
>  	ret = ucsi_init(ucsi);
>  	if (ret)
> -		dev_err(ucsi->dev, "PPM init failed (%d)\n", ret);
> +		dev_err_probe(ucsi->dev, ret, "PPM init failed\n");
>  
>  	if (ret == -EPROBE_DEFER) {
> -		if (ucsi->work_count++ > UCSI_ROLE_SWITCH_WAIT_COUNT)
> +		if (ucsi->work_count++ > UCSI_ROLE_SWITCH_WAIT_COUNT) {
> +			dev_err(ucsi->dev, "PPM init failed, stop trying\n");
>  			return;
> +		}
>  
>  		queue_delayed_work(system_long_wq, &ucsi->work,
>  				   UCSI_ROLE_SWITCH_INTERVAL);
> -- 
> 2.25.1

-- 
heikki
