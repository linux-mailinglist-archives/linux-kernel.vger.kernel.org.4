Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4703702230
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 05:28:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238477AbjEOD2o convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 14 May 2023 23:28:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238405AbjEOD2Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 May 2023 23:28:16 -0400
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04D35270F;
        Sun, 14 May 2023 20:27:49 -0700 (PDT)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id 8885180B2;
        Mon, 15 May 2023 11:27:43 +0800 (CST)
Received: from EXMBX168.cuchost.com (172.16.6.78) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 15 May
 2023 11:27:43 +0800
Received: from [192.168.155.85] (202.188.176.82) by EXMBX168.cuchost.com
 (172.16.6.78) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 15 May
 2023 11:27:40 +0800
Message-ID: <2ae2d187-5db7-9207-7846-1a80e87047b2@starfivetech.com>
Date:   Mon, 15 May 2023 11:27:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v7 4/4] crypto: starfive - Add hash and HMAC support
To:     Herbert Xu <herbert@gondor.apana.org.au>
CC:     "David S . Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Conor Dooley <conor@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        <linux-crypto@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>
References: <20230504073400.1170979-1-jiajie.ho@starfivetech.com>
 <20230504073400.1170979-5-jiajie.ho@starfivetech.com>
 <ZF4bKe0YkpcQakLs@gondor.apana.org.au>
Content-Language: en-US
From:   Jia Jie Ho <jiajie.ho@starfivetech.com>
In-Reply-To: <ZF4bKe0YkpcQakLs@gondor.apana.org.au>
Content-Type: text/plain; charset="UTF-8"
X-Originating-IP: [202.188.176.82]
X-ClientProxiedBy: EXCAS062.cuchost.com (172.16.6.22) To EXMBX168.cuchost.com
 (172.16.6.78)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/5/2023 6:55 pm, Herbert Xu wrote:
> On Thu, May 04, 2023 at 03:34:00PM +0800, Jia Jie Ho wrote:
>>
>> +	writel(~STARFIVE_IE_MASK_HASH_DONE, cryp->base + STARFIVE_IE_MASK_OFFSET);
>> +	writel(csr.v, cryp->base + STARFIVE_HASH_SHACSR);
> 
> With compile testing I get
> 
> ../drivers/crypto/starfive/jh7110-hash.c: In function ‘starfive_hash_start’:
> ../drivers/crypto/starfive/jh7110-hash.c:110:9: warning: conversion from ‘long unsigned int’ to ‘unsigned int’ changes value from ‘18446744073709551611’ to ‘4294967291’ [-Woverflow]
> 

Hi Herbert,
I've added COMPILE_TEST in the Kconfig, then ran make W=1, sparse and smatch.
However it did not produce the error message.

+config CRYPTO_DEV_JH7110
+       tristate "StarFive JH7110 cryptographic engine driver"
+       depends on SOC_STARFIVE || COMPILE_TEST
+       select CRYPTO_ENGINE

Symbol: COMPILE_TEST [=y]
Type  : bool
Defined at init/Kconfig:142

make C=2 drivers/crypto/
make W=1 drivers/crypto/
~/smatch/smatch_scripts/kchecker drivers/crypto/

Am I missing something?

Thanks,
Jia Jie
