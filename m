Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2A76640089
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 07:25:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232339AbiLBGZN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 01:25:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232398AbiLBGYv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 01:24:51 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B195398548;
        Thu,  1 Dec 2022 22:24:28 -0800 (PST)
Received: from dggpeml100012.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4NNjZ75nsczRpXQ;
        Fri,  2 Dec 2022 14:23:43 +0800 (CST)
Received: from [10.67.103.212] (10.67.103.212) by
 dggpeml100012.china.huawei.com (7.185.36.121) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 2 Dec 2022 14:24:26 +0800
Subject: Re: [PATCH] crypto: ccree,hisilicon - Fix dependencies to correct
 algorithm
To:     Tianjia Zhang <tianjia.zhang@linux.alibaba.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Weili Qian <qianweili@huawei.com>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20221125121811.88031-1-tianjia.zhang@linux.alibaba.com>
From:   "yekai (A)" <yekai13@huawei.com>
Message-ID: <53826413-e638-a75f-242f-656cc2744e9c@huawei.com>
Date:   Fri, 2 Dec 2022 14:24:26 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <20221125121811.88031-1-tianjia.zhang@linux.alibaba.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.103.212]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml100012.china.huawei.com (7.185.36.121)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/11/25 20:18, Tianjia Zhang wrote:
> Commit d2825fa9365d ("crypto: sm3,sm4 - move into crypto directory") moves
> the SM3 and SM4 stand-alone library and the algorithm implementation for
> the Crypto API into the same directory, and the corresponding relationship
> of Kconfig is modified, CONFIG_CRYPTO_SM3/4 corresponds to the stand-alone
> library of SM3/4, and CONFIG_CRYPTO_SM3/4_GENERIC corresponds to the
> algorithm implementation for the Crypto API. Therefore, it is necessary
> for this module to depend on the correct algorithm.
>
> Fixes: d2825fa9365d ("crypto: sm3,sm4 - move into crypto directory")
> Cc: Jason A. Donenfeld <Jason@zx2c4.com>
> Cc: stable@vger.kernel.org # v5.19+
> Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
> ---
>  drivers/crypto/Kconfig           | 4 ++--
>  drivers/crypto/hisilicon/Kconfig | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/crypto/Kconfig b/drivers/crypto/Kconfig
> index 2947888d3b82..dfb103f81a64 100644
> --- a/drivers/crypto/Kconfig
> +++ b/drivers/crypto/Kconfig
> @@ -800,8 +800,8 @@ config CRYPTO_DEV_CCREE
>  	select CRYPTO_ECB
>  	select CRYPTO_CTR
>  	select CRYPTO_XTS
> -	select CRYPTO_SM4
> -	select CRYPTO_SM3
> +	select CRYPTO_SM4_GENERIC
> +	select CRYPTO_SM3_GENERIC
>  	help
>  	  Say 'Y' to enable a driver for the REE interface of the Arm
>  	  TrustZone CryptoCell family of processors. Currently the
> diff --git a/drivers/crypto/hisilicon/Kconfig b/drivers/crypto/hisilicon/Kconfig
> index 27e1fa912063..743ce4fc3158 100644
> --- a/drivers/crypto/hisilicon/Kconfig
> +++ b/drivers/crypto/hisilicon/Kconfig
> @@ -26,7 +26,7 @@ config CRYPTO_DEV_HISI_SEC2
>  	select CRYPTO_SHA1
>  	select CRYPTO_SHA256
>  	select CRYPTO_SHA512
> -	select CRYPTO_SM4
> +	select CRYPTO_SM4_GENERIC
>  	depends on PCI && PCI_MSI
>  	depends on UACCE || UACCE=n
>  	depends on ARM64 || (COMPILE_TEST && 64BIT)
Hisilicon sec2 module is ok.

Thanks
Kai
