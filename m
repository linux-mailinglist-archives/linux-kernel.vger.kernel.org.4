Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 108497220E0
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 10:22:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbjFEIWF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 04:22:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjFEIWA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 04:22:00 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8A26B7;
        Mon,  5 Jun 2023 01:21:59 -0700 (PDT)
Received: from [IPV6:2001:b07:2ed:14ed:a962:cd4d:a84:1eab] (unknown [IPv6:2001:b07:2ed:14ed:a962:cd4d:a84:1eab])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id B133066056AC;
        Mon,  5 Jun 2023 09:21:57 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1685953318;
        bh=VJJ5TugID6Q4W6b8RgUTwaQaM+UQcpqFmZpmE6t57EI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=c9Ck2tFBEAWtO399BEwFs1Yx0a6XkEl2E3oKh6tn7Q2OBeSI6MfSvGQ0ke/yUSRXj
         rSbfCLVzUMnrv5WvJK9KRhgERLPJFtFmRAgIZhYRCHJTbHdO4AOqMov1kYDCu1g91c
         akCSyrW7GspMYhDLgxL10cQDF/BzJr00mXnF6gQsl4EFD3xXZbnxvI6chKN65AKo4p
         WCqfaZmCaHTqI7AldbLAGHTWTxeLqMe9ebPTJjdhL7X8SgnREYSKQZh3DeBqtXXxMe
         Hs8MCZQmuezlwKPtDxljhKfvpwMW3wjJzmJwmjmUr3tKpqnLdv/T/NVqxnqfvdjL6L
         mW+KO9Qg7twfg==
Message-ID: <01c88a42-274c-f8cf-73a6-29741579d9db@collabora.com>
Date:   Mon, 5 Jun 2023 10:21:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH] arm64: dts: mediatek: mt8192: Fix CPUs capacity-dmips-mhz
Content-Language: en-US
To:     =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     kernel@collabora.com, Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Seiya Wang <seiya.wang@mediatek.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
References: <20230602183515.3778780-1-nfraprado@collabora.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230602183515.3778780-1-nfraprado@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 02/06/23 20:35, Nícolas F. R. A. Prado ha scritto:
> The capacity-dmips-mhz parameter was miscalculated: this SoC runs
> the first (Cortex-A55) cluster at a maximum of 2000MHz and the
> second (Cortex-A76) cluster at a maximum of 2200MHz.
> 
> In order to calculate the right capacity-dmips-mhz, the following
> test was performed:
> 1. CPUFREQ governor was set to 'performance' on both clusters
> 2. Ran dhrystone with 500000000 iterations for 10 times on each cluster
> 3. Calculated the mean result for each cluster
> 4. Calculated DMIPS/MHz: dmips_mhz = dmips_per_second / cpu_mhz
> 5. Scaled results to 1024:
>     result_c0 = dmips_mhz_c0 / dmips_mhz_c1 * 1024
> 
> The mean results for this SoC are:
> Cluster 0 (LITTLE): 12016411 Dhry/s
> Cluster 1 (BIG): 31702034 Dhry/s
> 
> The calculated scaled results are:
> Cluster 0: 426.953226899238 (rounded to 427)
> Cluster 1: 1024
> 
> Fixes: 48489980e27e ("arm64: dts: Add Mediatek SoC MT8192 and evaluation board dts and Makefile")
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> 

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


