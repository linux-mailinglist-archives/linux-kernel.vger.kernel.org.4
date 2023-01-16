Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5987666BF90
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 14:19:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbjAPNS4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 08:18:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230417AbjAPNSZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 08:18:25 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17F193C24;
        Mon, 16 Jan 2023 05:17:20 -0800 (PST)
Received: from kwepemm600009.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4NwXZb4M7nznVlD;
        Mon, 16 Jan 2023 21:15:35 +0800 (CST)
Received: from [10.67.101.184] (10.67.101.184) by
 kwepemm600009.china.huawei.com (7.193.23.164) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Mon, 16 Jan 2023 21:17:17 +0800
Subject: Re: [PATCH] crypto: hisilicon - remove redundant config PCI
 dependency for some CRYPTO_DEV_HISI configs
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        <linux-crypto@vger.kernel.org>
References: <20230111120203.822-1-lukas.bulwahn@gmail.com>
CC:     <kernel-janitors@vger.kernel.org>, <linux-kernel@vger.kernel.org>
From:   Weili Qian <qianweili@huawei.com>
Message-ID: <e1a19c92-9162-1696-5974-99aecd86989b@huawei.com>
Date:   Mon, 16 Jan 2023 21:17:12 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <20230111120203.822-1-lukas.bulwahn@gmail.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.101.184]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600009.china.huawei.com (7.193.23.164)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/1/11 20:02, Lukas Bulwahn wrote:
> While reviewing dependencies in some Kconfig files, I noticed the redundant
> dependency "depends on PCI && PCI_MSI". The config PCI_MSI has always,
> since its introduction, been dependent on the config PCI. So, it is
> sufficient to just depend on PCI_MSI, and know that the dependency on PCI
> is implicitly implied.
> 
> Reduce the dependencies of configs CRYPTO_DEV_HISI_SEC2,
> CRYPTO_DEV_HISI_QM, CRYPTO_DEV_HISI_ZIP and CRYPTO_DEV_HISI_HPRE.
> 
> No functional change and effective change of Kconfig dependendencies.
> 
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---
>  drivers/crypto/hisilicon/Kconfig | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
Acked-by: Weili Qian <qianweili@huawei.com>

> diff --git a/drivers/crypto/hisilicon/Kconfig b/drivers/crypto/hisilicon/Kconfig
> index 743ce4fc3158..4137a8bf131f 100644
> --- a/drivers/crypto/hisilicon/Kconfig
> +++ b/drivers/crypto/hisilicon/Kconfig
> @@ -27,7 +27,7 @@ config CRYPTO_DEV_HISI_SEC2
>  	select CRYPTO_SHA256
>  	select CRYPTO_SHA512
>  	select CRYPTO_SM4_GENERIC
> -	depends on PCI && PCI_MSI
> +	depends on PCI_MSI
>  	depends on UACCE || UACCE=n
>  	depends on ARM64 || (COMPILE_TEST && 64BIT)
>  	depends on ACPI
> @@ -42,7 +42,7 @@ config CRYPTO_DEV_HISI_SEC2
>  config CRYPTO_DEV_HISI_QM
>  	tristate
>  	depends on ARM64 || COMPILE_TEST
> -	depends on PCI && PCI_MSI
> +	depends on PCI_MSI
>  	depends on UACCE || UACCE=n
>  	depends on ACPI
>  	help
> @@ -51,7 +51,7 @@ config CRYPTO_DEV_HISI_QM
>  
>  config CRYPTO_DEV_HISI_ZIP
>  	tristate "Support for HiSilicon ZIP accelerator"
> -	depends on PCI && PCI_MSI
> +	depends on PCI_MSI
>  	depends on ARM64 || (COMPILE_TEST && 64BIT)
>  	depends on !CPU_BIG_ENDIAN || COMPILE_TEST
>  	depends on UACCE || UACCE=n
> @@ -62,7 +62,7 @@ config CRYPTO_DEV_HISI_ZIP
>  
>  config CRYPTO_DEV_HISI_HPRE
>  	tristate "Support for HISI HPRE accelerator"
> -	depends on PCI && PCI_MSI
> +	depends on PCI_MSI
>  	depends on UACCE || UACCE=n
>  	depends on ARM64 || (COMPILE_TEST && 64BIT)
>  	depends on ACPI
> 
