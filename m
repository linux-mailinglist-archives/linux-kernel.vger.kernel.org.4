Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD576609714
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 00:41:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbiJWWln (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 18:41:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiJWWll (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 18:41:41 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0E5B60694
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 15:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1666564900; x=1698100900;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=8Lk9SjiREb+/bIe0/7XJtdgfr9vwppj9RZi/VQ68B3I=;
  b=YwMXpLlrCbWGY++bShF30+bVnB8AYEPBpb8s/xg6biPJFYU7PmkXakY0
   brH2EMkzhPUU8Dr++SvSsHGCt0LBc/sN592m4RGW6AfyKLtR9He2DFKNW
   PT/uAykNwlcgyCrKqKPX5t6Ap8r1ZFGptVpYHlm1BMPFqVd1A21YAwGY+
   JFDefXgw9Fem78mv3iXuuCmJe1ysYcDZWQeLKnbF84vIJGuE6W6yvDFF9
   NmKWeiv2gbJdQzNkNEDWlmst9uCbRusrKFBUCYw7/KedQB9ib6aucG9mH
   YJteW6uAPBvsIY0B/hrSQACpZrYyJgtNLMklPHoRX2qqXbbYUHlp0BtHV
   Q==;
X-IronPort-AV: E=Sophos;i="5.95,207,1661788800"; 
   d="scan'208";a="219708990"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 24 Oct 2022 06:41:40 +0800
IronPort-SDR: UMNyF1tSZRqvWjjUo631PtaBve+FoVn7vV6iUre/YdGJUe8JemyjAO1hhBv4t67VlnVVpUXjfW
 JKcTnJ1i+lGTM2nq82GqbCzrXY296F6T/hwO++BYw9ytZfuszmODiLsZBcUyATM3c5P6hjwUrO
 L4CrCwPkzgQe40F2M3RQb9SWmxPvxe/3TCGzaWOtgQ/DBu6kV6G43Pvsr5q5PH0qNJEl/jtLXL
 MDpGAA3cqm3dsnLVByDjAc7DRzS/uR8nJzg5Vml6SnBqTSubdThYnkIqWwWgw4WLTOjMhLeoFp
 D6e9DIIGFZPDebXcMfXlSl/w
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Oct 2022 14:55:23 -0700
IronPort-SDR: I3PAWXqvc3XnFKE64wx52eolyc1LBfFzk5YbnTfQXRCSepvyDaUSL72W8aiiQpdPXnpwgyc65R
 JC4rrkFnJkX5J5ADJjD6+fNh+cBMYqqoccFphCJ235yEYia64W45HkUDIfexGSF1kkixKVK9Vr
 psRkWSfBAmArShzRh4RGnHrIivYj+HZWSD29i8m7p3H+AGgO4HQ7zaXqW7Hu5uWZFMU4Ic0i2D
 XnPSS1fUCSIK6cjm2ewy1ZJJMOR7fwlAsARue9fLWX5QHRl0m4A2sUmwAiXIpA7W+oiQKJRKtW
 e/Q=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Oct 2022 15:41:40 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4MwY8z3xGHz1Rwrq
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 15:41:39 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1666564898; x=1669156899; bh=8Lk9SjiREb+/bIe0/7XJtdgfr9vwppj9RZi
        /VQ68B3I=; b=fkvh9KLuKE9RFNkCKfK5VLxUWh0xeWG4Xh2vme39ncVZdZt0Bp1
        HWMfmDRcUvCeUkWU4EHTbl75xNwwdqDwNYvD7jRhEWqx2f7YEfS9EsuywXSkE+rs
        /g/szxHGNge1a2MCrwG98p1AXI7oBzVpE1kjv8I9xpzcA+x6GTpw1cLoivI1PYjd
        t0acnJL6gB7T4RKHaapvjyfnWEuFlOh1p8R2qh9WNe8GE4iA/N2CtkpTRwQLsN/b
        rrT4Jn9JF02o+RmXfZpVqz5NjsfkefkvoFf7qF3mpPmhiQjTUef+f0tx8AkJOc8Q
        a1nfu46NToFXBo2h+wEC9MARTD09hQss65Q==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id nxLrkX0AzEzl for <linux-kernel@vger.kernel.org>;
        Sun, 23 Oct 2022 15:41:38 -0700 (PDT)
Received: from [10.225.163.126] (unknown [10.225.163.126])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4MwY8x1Cwmz1RvLy;
        Sun, 23 Oct 2022 15:41:36 -0700 (PDT)
Message-ID: <d458f39c-9927-33e8-b200-51e7cc09f2df@opensource.wdc.com>
Date:   Mon, 24 Oct 2022 07:41:35 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH 09/21] pata: remove samsung_cf driver
Content-Language: en-US
To:     Arnd Bergmann <arnd@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Ben Dooks <ben-linux@fluff.org>,
        Simtec Linux Team <linux@simtec.co.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Hannes Reinecke <hare@suse.de>, linux-ide@vger.kernel.org
References: <20221021202254.4142411-1-arnd@kernel.org>
 <20221021203329.4143397-9-arnd@kernel.org>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20221021203329.4143397-9-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/22/22 05:27, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> This device was only used by the smdk6410 board file that is now
> gone, so the driver can be removed as well.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Arnd,

This patch does not apply to the for-6.2 branch of libata tree. I can fix
that easily, but I am concerned about the fact that this deletes the
header file include/linux/platform_data/ata-samsung_cf.h, which has some
function declarations for gpio used under arch/arm/mach-s3c. So If I apply
this before you queue the other patches for this driver in for-next, we
may endup with build failures. No ?

> ---
>  drivers/ata/Kconfig                          |  10 -
>  drivers/ata/Makefile                         |   1 -
>  drivers/ata/pata_samsung_cf.c                | 662 -------------------
>  include/linux/platform_data/ata-samsung_cf.h |  31 -
>  4 files changed, 704 deletions(-)
>  delete mode 100644 drivers/ata/pata_samsung_cf.c
>  delete mode 100644 include/linux/platform_data/ata-samsung_cf.h
> 
> diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
> index 6b446cfc3455..3b8cb7a29efd 100644
> --- a/drivers/ata/Kconfig
> +++ b/drivers/ata/Kconfig
> @@ -1136,16 +1136,6 @@ config PATA_RZ1000
>  
>  	  If unsure, say N.
>  
> -config PATA_SAMSUNG_CF
> -	tristate "Samsung SoC PATA support"
> -	depends on SAMSUNG_DEV_IDE || COMPILE_TEST
> -	select PATA_TIMINGS
> -	help
> -	  This option enables basic support for Samsung's S3C/S5P board
> -	  PATA controllers via the new ATA layer
> -
> -	  If unsure, say N.
> -
>  config PATA_WINBOND_VLB
>  	tristate "Winbond W83759A VLB PATA support (Experimental)"
>  	depends on ISA
> diff --git a/drivers/ata/Makefile b/drivers/ata/Makefile
> index 2cca9f500649..4ee5c0761d90 100644
> --- a/drivers/ata/Makefile
> +++ b/drivers/ata/Makefile
> @@ -109,7 +109,6 @@ obj-$(CONFIG_PATA_PLATFORM)	+= pata_platform.o
>  obj-$(CONFIG_PATA_OF_PLATFORM)	+= pata_of_platform.o
>  obj-$(CONFIG_PATA_RB532)	+= pata_rb532_cf.o
>  obj-$(CONFIG_PATA_RZ1000)	+= pata_rz1000.o
> -obj-$(CONFIG_PATA_SAMSUNG_CF)	+= pata_samsung_cf.o
>  
>  obj-$(CONFIG_PATA_PXA)		+= pata_pxa.o
>  
> diff --git a/drivers/ata/pata_samsung_cf.c b/drivers/ata/pata_samsung_cf.c
> deleted file mode 100644
> index aba1536ddd44..000000000000
> diff --git a/include/linux/platform_data/ata-samsung_cf.h b/include/linux/platform_data/ata-samsung_cf.h
> deleted file mode 100644
> index fccf969dc4da..000000000000

-- 
Damien Le Moal
Western Digital Research

