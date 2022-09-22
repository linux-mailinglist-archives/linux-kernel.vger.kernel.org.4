Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4AB85E5E7A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 11:25:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230257AbiIVJYn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 05:24:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230352AbiIVJYh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 05:24:37 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45BD6E9A;
        Thu, 22 Sep 2022 02:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663838671; x=1695374671;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4rHLvmUqFVt4gfxqMwdL+4dyQc082zWVkAFCrM4mv+g=;
  b=OXE40tCr7sCVNAyQ/lJn1yCQM/epA0vOCofLAcce3X1CD/oC6q5ukYkx
   3UCrQ1JyKjM2tgE1YbXaYwdnqV2FqIH1myGpa2pMw1n77dmL7sVUiSkVg
   mLRJ5GitPlx31ug6eE3i9YsoxU7MyDqKIZbfYnO96FUR6WwlpE/Q0pfZ7
   HqKIFJXHAFDWsT+KdcvmqlxmHx9aUFAAe45sJAeR8VjDv7I6tr9crRBM+
   ERygTA0mwjvsdvOACGwwwfy/lWANXF2hHSoLsbbfzkoMbbxe2BSh+BM4h
   V/6933IieKLegRO0dYN2xKckRmYuDkann1Hv2KP9qfVlx1yuqmGpJY0PV
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10477"; a="386537136"
X-IronPort-AV: E=Sophos;i="5.93,335,1654585200"; 
   d="scan'208";a="386537136"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2022 02:24:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,335,1654585200"; 
   d="scan'208";a="762114086"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 22 Sep 2022 02:24:28 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Thu, 22 Sep 2022 12:24:27 +0300
Date:   Thu, 22 Sep 2022 12:24:27 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Ren Zhijie <renzhijie2@huawei.com>
Cc:     gregkh@linuxfoundation.org, xji@analogixsemi.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] usb: typec: anx7411: Fix build error without
 CONFIG_POWER_SUPPLY
Message-ID: <Yywpy8X2YuqB1qdQ@kuha.fi.intel.com>
References: <20220920084431.196258-1-renzhijie2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220920084431.196258-1-renzhijie2@huawei.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 20, 2022 at 04:44:31PM +0800, Ren Zhijie wrote:
> Building without CONFIG_POWER_SUPPLY will fail:
> 
> drivers/usb/typec/anx7411.o: In function `anx7411_detect_power_mode':
> anx7411.c:(.text+0x527): undefined reference to `power_supply_changed'
> drivers/usb/typec/anx7411.o: In function `anx7411_psy_set_prop':
> anx7411.c:(.text+0x90d): undefined reference to `power_supply_get_drvdata'
> anx7411.c:(.text+0x930): undefined reference to `power_supply_changed'
> drivers/usb/typec/anx7411.o: In function `anx7411_psy_get_prop':
> anx7411.c:(.text+0x94d): undefined reference to `power_supply_get_drvdata'
> drivers/usb/typec/anx7411.o: In function `anx7411_i2c_probe':
> anx7411.c:(.text+0x111d): undefined reference to
> `devm_power_supply_register'
> drivers/usb/typec/anx7411.o: In function `anx7411_work_func':
> anx7411.c:(.text+0x167c): undefined reference to `power_supply_changed'
> anx7411.c:(.text+0x1b55): undefined reference to `power_supply_changed'
> 
> Add POWER_SUPPLY dependency to Kconfig.
> 
> Fixes: fe6d8a9c8e64 ("usb: typec: anx7411: Add Analogix PD ANX7411 support")
> Signed-off-by: Ren Zhijie <renzhijie2@huawei.com>

Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/usb/typec/Kconfig b/drivers/usb/typec/Kconfig
> index 5defdfead653..831e7049977d 100644
> --- a/drivers/usb/typec/Kconfig
> +++ b/drivers/usb/typec/Kconfig
> @@ -56,6 +56,7 @@ config TYPEC_ANX7411
>  	tristate "Analogix ANX7411 Type-C DRP Port controller driver"
>  	depends on I2C
>  	depends on USB_ROLE_SWITCH
> +	depends on POWER_SUPPLY
>  	help
>  	  Say Y or M here if your system has Analogix ANX7411 Type-C DRP Port
>  	  controller driver.
> -- 
> 2.17.1

-- 
heikki
