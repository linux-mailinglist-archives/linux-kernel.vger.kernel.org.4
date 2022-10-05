Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A41025F5D46
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 01:38:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229463AbiJEXis (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 19:38:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbiJEXio (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 19:38:44 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E446D85AAF
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 16:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1665013123; x=1696549123;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=r/lHLgkhhm2u5z9noISdUoAVCFjS4As6oslcwJQUah8=;
  b=gYg/D+n3mJzf01aUuo/KrEjb4fbkd0EdfLiiIPIx1ouZKxxt5nnPWChe
   w+qRj38rbUVoiWlX5E3D5VmupcxLYVGSPFwJ1ZFLUlxb02gFjyqVdtiqI
   gJYECRsbLqg3ZWlbfDSIHfp+RV/lVrKCMWbJQ6HA46EgqT1ikPTQLelQr
   qnyI50EHRRB3Mvh3P3sGx7BjL6UXZOGbQ4neSA8SR4eDZszLmW9sN3JAk
   B3nNYKwtYnUyKGmJnbFPrYN5h6+PnnlB+nHRXcw3GGgvt/wXnmzqhHwsH
   OhAiiDz+2rpGKB/Qq4hGH2mOvTQwgiyJnzAubcyc1XoqBsCcRjfZwkKE0
   w==;
X-IronPort-AV: E=Sophos;i="5.95,162,1661788800"; 
   d="scan'208";a="213486755"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 06 Oct 2022 07:38:41 +0800
IronPort-SDR: P7jIjsaMcYW7dfbyD8cn1QWTbbHaLVuEL0XpkKRe1xduq5iv7boDv9xbUAupLcYzAqXMnW/URL
 NXcZRoKd+POQbzL98xoW1Iu1KHVSyiqLnCCOzCvSoeJU90pZOCB489Fh7eu2DK9NH/UA1KpYpF
 ZG5F4qIQUZiFviyBBFJoDXxP8pkpEdTwd8TqPptK0sgg/qDv3INcu0sLfDdu/p3PM2stVSjbP+
 00MfcoWQUQr0v6vTT8c4SkHsj0rRqf5w7fPg1MsC4w3B1Jo8kVrmkMCG950I96JRPOy9Y3ygwl
 tyjOecHwL2snAMmBf3b29czG
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Oct 2022 15:58:28 -0700
IronPort-SDR: 90S8hEIAPYRDO+ZCqyyyQ62nqe5X7zftmwQPdDu+tOY7mtRPMDUR5T9wXywfKn+gJnFHcyGmDa
 j8XgUb4+dy1GJAe+isYXvUf0imy9aM3ryZczw7j2Fh4EYxN7x7b8oqjXHLmz+9CpIiACF3wndW
 z3ou3pMp42kqT+5QFcK1VAbCDhmvrx96UF//nhm/68O5gN6o/+nZenpUIQn27A3OGJgTNmR/qE
 KZ8+MeCM0TrmtzwvoMaQmIuGze5PQqWf4jgNMuwGKQmTjAU0Q4TkouicVkFssCg2Yux5cl83gB
 n2w=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Oct 2022 16:38:42 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4MjWH51Fvqz1RwqL
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 16:38:41 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1665013120; x=1667605121; bh=r/lHLgkhhm2u5z9noISdUoAVCFjS4As6osl
        cwJQUah8=; b=CqwLeFxJMNbCnsy5/5z2OFsqVa8eN4qAtgcp9xRQ4FIDdU4Kap+
        /Ru6QQHbLhzUPXgUAkPH5axozd8Zxh5s2op7owGfzjsOaM1/FVqkepl6vu31e0/U
        V/3XaGfLTHhBVgQ93j5zIKWza1Dj9tYomJa/O/jpydNqNcPIDjeExDGd+OQNN5QZ
        gFq9gVsonWyM/jIk5mFCr6blHdAynER09wOaTMuZSL6xtVe2m3cDkaJMmBfl5MwG
        5FA+yFH3aftDONLvsJRLVkRTILuKWK/WXwnbRtGkUlxK2EzlzbJWpdClvHaFsmGX
        44ajE8YrzwW8NA5ydrF1MvCdCAZlW/FH+UQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id UKYQ2iuc3B1G for <linux-kernel@vger.kernel.org>;
        Wed,  5 Oct 2022 16:38:40 -0700 (PDT)
Received: from [10.225.163.106] (unknown [10.225.163.106])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4MjWH36m1dz1RvLy;
        Wed,  5 Oct 2022 16:38:39 -0700 (PDT)
Message-ID: <24a48f71-8a79-6311-1e43-494df0458a32@opensource.wdc.com>
Date:   Thu, 6 Oct 2022 08:38:38 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH 2/2] ata: allow enabling FUA support in Kconfig
Content-Language: en-US
To:     "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <ed1c179cff84b49e22cf229cc69751fa4d357d9a.1664221825.git.maciej.szmigiero@oracle.com>
 <df8701f3905c1a394863e57c7a2d30c5b5dc3503.1664221825.git.maciej.szmigiero@oracle.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <df8701f3905c1a394863e57c7a2d30c5b5dc3503.1664221825.git.maciej.szmigiero@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/27/22 04:51, Maciej S. Szmigiero wrote:
> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
> 
> Currently, if one wants to make use of FUA support in libata it is
> necessary to provide an explicit kernel command line parameter in order to
> enable it (for drives that report such support).
> 
> In terms of Git archaeology: FUA support was enabled by default in early
> libata versions but was disabled soon after.
> Since then there were a few attempts to enable this support by default:
> [1] (for NCQ drives only), [2] (for all drives).
> However, the second change had to be reverted after a report came of
> an incompatibility with the HDD in 2011 Mac Mini.
> 
> Enabling FUA avoids having to emulate it by issuing an extra drive cache
> flush for every request that have this flag set.
> Since FUA support is required by the ATA/ATAPI spec for any drive that
> supports LBA48 and so these days should be pretty widespread let's provide
> an ability to enable it by default in Kconfig.

This can be done by adding "libata.fua=1" to the CONFIG_CMDLINE option. So
I do not see the need to add yet another config option.

Patch 1 looks good. I will queue it up once rc1 is out.

> 
> [1]: https://lore.kernel.org/lkml/45CFFF82.4030301@shaw.ca/
> [2]: https://lore.kernel.org/lkml/1336447443-4685-1-git-send-email-wenqing.lz@taobao.com/
> 
> Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
> ---
>  drivers/ata/Kconfig       | 15 +++++++++++++++
>  drivers/ata/libata-core.c |  5 +++--
>  2 files changed, 18 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
> index 36833a8629980..fd39bb22963a3 100644
> --- a/drivers/ata/Kconfig
> +++ b/drivers/ata/Kconfig
> @@ -102,6 +102,21 @@ config SATA_PMP
>  	  This option adds support for SATA Port Multipliers
>  	  (the SATA version of an ethernet hub, or SAS expander).
>  
> +config ATA_FUA
> +	bool "ATA FUA support"
> +	help
> +	  Enables Forced Unit Access (FUA) support by default for drives that
> +	  have it.
> +	  Otherwise the FUA flag has to be emulated by flushing the drive cache.
> +
> +	  Regardless of this option, you can enable or disable such support at
> +	  kernel boot time by providing libata.fua=1 or libata.fua=0 kernel
> +	  command line parameter.
> +
> +	  If building a kernel for yourself, say Y.
> +	  If building a kernel for a distro that's supposed to run out of the
> +	  box on old and broken hardware say N.
> +
>  if HAS_DMA
>  
>  comment "Controllers with non-SFF native interface"
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index b322006c85806..941836c4b5eda 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -127,9 +127,10 @@ int atapi_passthru16 = 1;
>  module_param(atapi_passthru16, int, 0444);
>  MODULE_PARM_DESC(atapi_passthru16, "Enable ATA_16 passthru for ATAPI devices (0=off, 1=on [default])");
>  
> -int libata_fua = 0;
> +int libata_fua = IS_ENABLED(CONFIG_ATA_FUA);
>  module_param_named(fua, libata_fua, int, 0644);
> -MODULE_PARM_DESC(fua, "FUA support (0=off [default], 1=on)");
> +MODULE_PARM_DESC(fua,
> +		 "FUA support (0=off, 1=on), default " __stringify(IS_ENABLED(CONFIG_ATA_FUA)));
>  
>  static int ata_ignore_hpa;
>  module_param_named(ignore_hpa, ata_ignore_hpa, int, 0644);

-- 
Damien Le Moal
Western Digital Research

