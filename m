Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51413710A8B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 13:05:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236535AbjEYLFp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 07:05:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231605AbjEYLFn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 07:05:43 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 218A7C5;
        Thu, 25 May 2023 04:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685012742; x=1716548742;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=TDUuNhwXDmmjarx2uF6dpg1kUSW8MpUrO3mxIEI6THU=;
  b=ZZNY7X2kqd9ybfkJhQBa3jppU1Chu6yeRtGyiyDN+ByEzDEm+kYZKbD5
   MU5CD+yhMnLsPdyg7Jumek907paq+bb0syI1B30Ly3PFz3Gbfne52Xl1L
   QrugO5BAIAc+3E1stOuOombeMqjcz4sTjOfPZ2Scsl3XBTJZGsTvRfVfh
   YTwJW60wfHohfTHOliPVNo4GRMOfIAyg7kjMo+tRk0/RHsvoSGhn9k0mX
   3kvU/CZUyelK9szvXB92prjvSht0j2lG/pvA0mNnZvhjjVd+sx6mTPpOv
   SPey7YlrrxTCdMTLl1OUv/sAPwJ4Ce4P1s/K3nYAvP7FIrRQlA4Yju6ea
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10720"; a="357084326"
X-IronPort-AV: E=Sophos;i="6.00,191,1681196400"; 
   d="scan'208";a="357084326"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2023 04:05:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10720"; a="1034935055"
X-IronPort-AV: E=Sophos;i="6.00,191,1681196400"; 
   d="scan'208";a="1034935055"
Received: from aghiriba-mobl.ger.corp.intel.com ([10.249.40.17])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2023 04:05:37 -0700
Date:   Thu, 25 May 2023 14:05:35 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Hugo Villeneuve <hugo@hugovil.com>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, Jiri Slaby <jirislaby@kernel.org>,
        jringle@gridpoint.com, tomasz.mon@camlingroup.com,
        l.perczak@camlintechnologies.com,
        linux-serial <linux-serial@vger.kernel.org>,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        linux-gpio@vger.kernel.org,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>
Subject: Re: [PATCH v3 04/11] serial: sc16is7xx: add post reset delay
In-Reply-To: <20230525040324.3773741-5-hugo@hugovil.com>
Message-ID: <1ae6fb11-6aa8-66e-86a-a9b5a6403f5e@linux.intel.com>
References: <20230525040324.3773741-1-hugo@hugovil.com> <20230525040324.3773741-5-hugo@hugovil.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 May 2023, Hugo Villeneuve wrote:

> From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> 
> Make sure we wait at least 3us before initiating communication with
> the device after reset.
> 
> Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> ---
>  drivers/tty/serial/sc16is7xx.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
> index a7c4da3cfd2b..af7e66db54b4 100644
> --- a/drivers/tty/serial/sc16is7xx.c
> +++ b/drivers/tty/serial/sc16is7xx.c
> @@ -1428,6 +1428,12 @@ static int sc16is7xx_probe(struct device *dev,
>  	regmap_write(s->regmap, SC16IS7XX_IOCONTROL_REG << SC16IS7XX_REG_SHIFT,
>  			SC16IS7XX_IOCONTROL_SRESET_BIT);
>  
> +	/*
> +	 * After reset, the host must wait at least 3us before initializing a
> +	 * communication with the device.
> +	 */
> +	usleep_range(3, 5);
> +
>  	for (i = 0; i < devtype->nr_uart; ++i) {
>  		s->p[i].line		= i;
>  		/* Initialize port data */

Does this fix a problem? You don't have a Fixes tag nor did you describe
a problem that arises if the is not there in the changelog.

-- 
 i.

