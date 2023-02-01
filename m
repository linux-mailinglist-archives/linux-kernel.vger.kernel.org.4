Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74ED468663B
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 13:49:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231704AbjBAMth (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 07:49:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231334AbjBAMtf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 07:49:35 -0500
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ED633A9D
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 04:49:31 -0800 (PST)
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 311A0wms027548;
        Wed, 1 Feb 2023 13:49:17 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=ykVZBSfUaKtHAVdHpteiSjeg5R8rG3k7gVn9nx7vxbI=;
 b=ioh1MoiGNxuFAeSZmWHcB+IjcA00w8RVZdcxVNQ15Ha28lKSueTryBOBFt/0wUhGnLAK
 BnFcwu8suuYaV8t+52GitOBMOAXXY/LA/kO9ygtJQYah2jgHX1RA0QT8w8yBNPTVfEmT
 CCHcNyu63DjIHGJzV762/vFgtwCAVSC/uspbOpbNWwjMxXg8drI3PmvVBvsb2qSNEUX8
 8qk/Ma7KQKAmVPvrWTW5KLdkK4Fd0TI5QCfvTEjsEBOxC/YhX6PwFtNks79s1gX320XX
 w3VlV1OKGEE/OueH5aNYEdX+lQBtyTAQndj4Da/RXsIi8u4gzBQOeYQYSE250o8hxt+M gg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3nfny50ymy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Feb 2023 13:49:17 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 82E0610002A;
        Wed,  1 Feb 2023 13:49:15 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 36771218619;
        Wed,  1 Feb 2023 13:49:15 +0100 (CET)
Received: from [10.48.0.157] (10.48.0.157) by SHFDAG1NODE3.st.com
 (10.75.129.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.13; Wed, 1 Feb
 2023 13:49:12 +0100
Message-ID: <12172517-87d4-ad2c-536d-68b9541e9a6b@foss.st.com>
Date:   Wed, 1 Feb 2023 13:49:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] nvmem: stm32: fix OPTEE dependency
Content-Language: en-US
To:     Arnd Bergmann <arnd@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Etienne Carriere <etienne.carriere@linaro.org>
CC:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>
References: <20230127094200.2451839-1-arnd@kernel.org>
From:   Patrick DELAUNAY <patrick.delaunay@foss.st.com>
In-Reply-To: <20230127094200.2451839-1-arnd@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.48.0.157]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-01_04,2023-01-31_01,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On 1/27/23 10:41, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>
> The stm32 nvmem driver fails to link as built-in when OPTEE
> is a loadable module:
>
> aarch64-linux-ld: drivers/nvmem/stm32-bsec-optee-ta.o: in function `stm32_bsec:
> stm32-bsec-optee-ta.c:(.text+0xc8): undefined reference to `tee_client_open_session'
> aarch64-linux-ld: drivers/nvmem/stm32-bsec-optee-ta.o: in function `stm32_bsec:
> stm32-bsec-optee-ta.c:(.text+0x1fc): undefined reference to `tee_client_open_context'
>
> Change the CONFIG_NVMEM_STM32_ROMEM definition so it can only
> be built-in if OPTEE is either built-in or disabled, and
> make NVMEM_STM32_BSEC_OPTEE_TA a hidden symbol instead.
>
> Fixes: acdf68bdf2d4 ("nvmem: stm32: add OP-TEE support for STM32MP13x")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>   drivers/nvmem/Kconfig | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/nvmem/Kconfig b/drivers/nvmem/Kconfig
> index ed8ef7460be2..ae2c5257ed97 100644
> --- a/drivers/nvmem/Kconfig
> +++ b/drivers/nvmem/Kconfig
> @@ -295,8 +295,7 @@ config NVMEM_SPRD_EFUSE
>   	  will be called nvmem-sprd-efuse.
>   
>   config NVMEM_STM32_BSEC_OPTEE_TA
> -	bool "STM32MP BSEC OP-TEE TA support for nvmem-stm32-romem driver"
> -	depends on OPTEE
> +	def_bool NVMEM_STM32_ROMEM && OPTEE
>   	help
>   	  Say y here to enable the accesses to STM32MP SoC OTPs by the OP-TEE
>   	  trusted application STM32MP BSEC.
> @@ -307,7 +306,7 @@ config NVMEM_STM32_BSEC_OPTEE_TA
>   config NVMEM_STM32_ROMEM
>   	tristate "STMicroelectronics STM32 factory-programmed memory support"
>   	depends on ARCH_STM32 || COMPILE_TEST
> -	imply NVMEM_STM32_BSEC_OPTEE_TA
> +	depends on OPTEE || !OPTEE
>   	help
>   	  Say y here to enable read-only access for STMicroelectronics STM32
>   	  factory-programmed memory area.


Thanks for the fix,


I test several case....

  at least the logical configurations:

OP-TEE=n and NVMEM_STM32_ROMEM=m

OP-TEE=y and NVMEM_STM32_ROMEM=m

OP-TEE=n and NVMEM_STM32_ROMEM=y

OP-TEE=y and NVMEM_STM32_ROMEM=y


but I miss this case

OP-TEE=m and NVMEM_STM32_ROMEM=y




Reviewed-by: Patrick Delaunay <patrick.delaunay@foss.st.com>

Thanks
Patrick




