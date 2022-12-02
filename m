Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 623B464070B
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 13:44:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233354AbiLBMos (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 07:44:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233545AbiLBMoo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 07:44:44 -0500
X-Greylist: delayed 423 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 02 Dec 2022 04:44:37 PST
Received: from mail1.systemli.org (mail1.systemli.org [93.190.126.36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78FA7DC87D
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 04:44:37 -0800 (PST)
Message-ID: <75216e0c-9d36-7ada-1507-1bb4a91a3326@systemli.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=systemli.org;
        s=default; t=1669984648;
        bh=VgZKVlX8mJZVYidqK5M73GMcS0SohrhprD5SzdTqO9U=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=OKlvyaKVTP6rTdMIXGrVpKU+rS+BYHRAm7/JDodazYINJMZ1W2N8UH9EtjrvTgcX0
         yigXPcO8SGlrpsL6BFG6QDTpQZ9N3k/sQWfOczz0YAvYCkXOOJCNsa//dy6sY/4z9C
         BrLIVJnT/PsfnCiRtn7ijhVM/0DsruXG5um1shac3ciCmvcO5IlibE9tvyHyHq4CiM
         TpW3PHXPM+BQThl41Oht9nffLEEAtPdqtbNr1u8nfQTRUNLwS4SOe/uIMLTPbwOIaQ
         GaxsXEryMId8/8pOzQSH3iUKCg8N6RpNslkgzxjrusxjacmymc3CsXOAFLO+WH5ZUr
         wUsj1OlWVnIig==
Date:   Fri, 2 Dec 2022 13:37:26 +0100
MIME-Version: 1.0
Subject: Re: [PATCH] cpufreq: mediatek: Raise proc and sram max voltage for
 MT7622/7623
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, viresh.kumar@linaro.org
Cc:     rafael@kernel.org, matthias.bgg@gmail.com,
        jia-wei.chang@mediatek.com, rex-bc.chen@mediatek.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, frank-w@public-files.de,
        daniel@makrotopia.org
References: <20221202095227.167492-1-angelogioacchino.delregno@collabora.com>
From:   Nick <vincent@systemli.org>
In-Reply-To: <20221202095227.167492-1-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It now starts, however, with a lot of those messages (I applied the 
patch to linux/master and not to linux-next, because next is currently 
not compiling anymore for me):

> [   10.777041] cpufreq: __target_index: Failed to change cpu 
> frequency: -22
> [   10.791577] cpu cpu0: cpu0: failed to scale up voltage!
The complete log:
https://gist.githubusercontent.com/PolynomialDivision/267c83c7a21a359cbb4e8d99d0303201/raw/28d3568a26634bebef2d91ebe37fc5f76ae58add/mt7622-patch-cpufreq.log

Bests
Nick

On 12/2/22 10:52, AngeloGioacchino Del Regno wrote:
> During the addition of SRAM voltage tracking for CCI scaling, this
> driver got some voltage limits set for the vtrack algorithm: these
> were moved to platform data first, then enforced in a later commit
> 6a17b3876bc8 ("cpufreq: mediatek: Refine mtk_cpufreq_voltage_tracking()")
> using these as max values for the regulator_set_voltage() calls.
>
> In this case, the vsram/vproc constraints for MT7622 and MT7623
> were supposed to be the same as MT2701 (and a number of other SoCs),
> but that turned out to be a mistake because the aforementioned two
> SoCs' maximum voltage for both VPROC and VPROC_SRAM is 1.36V.
>
> Fix that by adding new platform data for MT7622/7623 declaring the
> right {proc,sram}_max_volt parameter.
>
> Fixes: ead858bd128d ("cpufreq: mediatek: Move voltage limits to platform data")
> Fixes: 6a17b3876bc8 ("cpufreq: mediatek: Refine mtk_cpufreq_voltage_tracking()")
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>   drivers/cpufreq/mediatek-cpufreq.c | 13 +++++++++++--
>   1 file changed, 11 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/cpufreq/mediatek-cpufreq.c b/drivers/cpufreq/mediatek-cpufreq.c
> index 7f2680bc9a0f..f9a9f08c75c4 100644
> --- a/drivers/cpufreq/mediatek-cpufreq.c
> +++ b/drivers/cpufreq/mediatek-cpufreq.c
> @@ -695,6 +695,15 @@ static const struct mtk_cpufreq_platform_data mt2701_platform_data = {
>   	.ccifreq_supported = false,
>   };
>   
> +static const struct mtk_cpufreq_platform_data mt7622_platform_data = {
> +	.min_volt_shift = 100000,
> +	.max_volt_shift = 200000,
> +	.proc_max_volt = 1360000,
> +	.sram_min_volt = 0,
> +	.sram_max_volt = 1360000,
> +	.ccifreq_supported = false,
> +};
> +
>   static const struct mtk_cpufreq_platform_data mt8183_platform_data = {
>   	.min_volt_shift = 100000,
>   	.max_volt_shift = 200000,
> @@ -717,8 +726,8 @@ static const struct mtk_cpufreq_platform_data mt8186_platform_data = {
>   static const struct of_device_id mtk_cpufreq_machines[] __initconst = {
>   	{ .compatible = "mediatek,mt2701", .data = &mt2701_platform_data },
>   	{ .compatible = "mediatek,mt2712", .data = &mt2701_platform_data },
> -	{ .compatible = "mediatek,mt7622", .data = &mt2701_platform_data },
> -	{ .compatible = "mediatek,mt7623", .data = &mt2701_platform_data },
> +	{ .compatible = "mediatek,mt7622", .data = &mt7622_platform_data },
> +	{ .compatible = "mediatek,mt7623", .data = &mt7622_platform_data },
>   	{ .compatible = "mediatek,mt8167", .data = &mt2701_platform_data },
>   	{ .compatible = "mediatek,mt817x", .data = &mt2701_platform_data },
>   	{ .compatible = "mediatek,mt8173", .data = &mt2701_platform_data },
