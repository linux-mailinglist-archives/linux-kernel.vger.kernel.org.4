Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C74516EEFF3
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 10:10:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233710AbjDZIKJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 04:10:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240120AbjDZIJ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 04:09:59 -0400
Received: from smtp.smtpout.orange.fr (smtp-19.smtpout.orange.fr [80.12.242.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A563170A
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 01:09:57 -0700 (PDT)
Received: from [192.168.1.18] ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id raDnpA1yS5yGNraDnpJfQb; Wed, 26 Apr 2023 10:09:55 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1682496595;
        bh=LAH0ATvyqMIb5cRVxJ4q6wIOaOYd7NEbV2R9rOtQO/k=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=NwYy5HYlxehL5uwgIHgDaEMuDSSsnez3Al6jf9JWsoWmBoISrbZLVpSLfMvBDATqB
         eVnLakwyQZdTumiRLZWWokP+E9Um4hQ23HzKGC03YM5cCW1Dnga0UK9WrSqMnBXXMP
         TgOytrWjmUNNXyKR4cTdfo+sE5y40g0v0ixOIWl/Sy+d6orkmto54kOLjip2LvtCzi
         V2t99F+/tezNTsR/g4r76eboJ2ej7FiknryDPpC4FOQSr4PSvqXHLHpvkfT6ZwJiSj
         A58XZxkk6uujn9lPs9RwzxxFqD2KyUrDC2i+/3+1FigA8NUWmYMEhyv9vhlX6iV7GK
         nFMyJGeTs2rPQ==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Wed, 26 Apr 2023 10:09:55 +0200
X-ME-IP: 86.243.2.178
Message-ID: <67846b76-1ade-c253-e50b-1c0a0dd0a84a@wanadoo.fr>
Date:   Wed, 26 Apr 2023 10:09:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v6 4/4] crypto: starfive - Add hash and HMAC support
Content-Language: fr
To:     jiajie.ho@starfivetech.com
Cc:     davem@davemloft.net, devicetree@vger.kernel.org,
        herbert@gondor.apana.org.au, kernel@esmil.dk,
        krzysztof.kozlowski+dt@linaro.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        palmer@dabbelt.com, robh+dt@kernel.org
References: <20230426065848.842221-1-jiajie.ho@starfivetech.com>
 <20230426065848.842221-5-jiajie.ho@starfivetech.com>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20230426065848.842221-5-jiajie.ho@starfivetech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 26/04/2023 à 08:58, Jia Jie Ho a écrit :
> Adding hash/HMAC support for SHA-2 and SM3 to StarFive cryptographic
> module.
> 
> Co-developed-by: Huan Feng <huan.feng-bONrM45KWFOXmMXjJBpWqg@public.gmane.org>
> Signed-off-by: Huan Feng <huan.feng-bONrM45KWFOXmMXjJBpWqg@public.gmane.org>
> Signed-off-by: Jia Jie Ho <jiajie.ho-bONrM45KWFOXmMXjJBpWqg@public.gmane.org>
> ---
>   drivers/crypto/starfive/Kconfig       |   4 +
>   drivers/crypto/starfive/Makefile      |   2 +-
>   drivers/crypto/starfive/jh7110-cryp.c |  38 ++
>   drivers/crypto/starfive/jh7110-cryp.h |  70 +-
>   drivers/crypto/starfive/jh7110-hash.c | 896 ++++++++++++++++++++++++++
>   5 files changed, 1006 insertions(+), 4 deletions(-)
>   create mode 100644 drivers/crypto/starfive/jh7110-hash.c
> 

[...]

> +int starfive_hash_register_algs(void)
> +{
> +	int ret = 0;
> +
> +	ret = crypto_register_ahashes(algs_sha2_sm3, ARRAY_SIZE(algs_sha2_sm3));
> +
> +	return ret;

Nit: return crypto_register_ahashes(algs_sha2_sm3, 
ARRAY_SIZE(algs_sha2_sm3));

?

> +}
> +
> +void starfive_hash_unregister_algs(void)
> +{
> +	crypto_unregister_ahashes(algs_sha2_sm3, ARRAY_SIZE(algs_sha2_sm3));
> +}

