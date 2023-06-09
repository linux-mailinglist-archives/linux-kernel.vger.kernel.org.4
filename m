Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97D4172940D
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 11:03:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240706AbjFIJDY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 05:03:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241099AbjFIJDJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 05:03:09 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D414210C;
        Fri,  9 Jun 2023 02:03:08 -0700 (PDT)
Received: from [IPV6:2001:b07:2ed:14ed:a962:cd4d:a84:1eab] (unknown [IPv6:2001:b07:2ed:14ed:a962:cd4d:a84:1eab])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id C71A66606F1D;
        Fri,  9 Jun 2023 10:03:05 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1686301386;
        bh=yn37R8118HR0BWMGyAsYVW73MuZTJZ0eQLcGqFaWCxI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=DnG7fJ2FZJyNXpevDVjEleH74QQB5w6SZroDRC3AX08rO8yM34reQu8gthn7AN5P6
         F4Be5HRWL7qwGHccPs3v1Q0f/BXPJglvq0M3WIeeLeWITPk9eSvrZF9bEv6A2kRcLc
         POfgKeSNKdjD4nAbABFk2Nb16ONCsSIvtMM6u8tSVKo0L3EVi7/3PyXQd/0V6SXZ+G
         F/vo4OjEj1tVJirEsOTN+WVNPmJFZHsqXc89ypgc6dEFhya+Xm1lccm6/v6PJ/nFuS
         Q4hiHUQ/EHwbnqFvc+vKfisw8nhu01+sGKDLNjhwi0GkNXL6lW+mmJP8ppn2uEtOY7
         tduwyPrZCDN5g==
Message-ID: <a7b7476d-3bbd-5503-db3d-5d57356764f8@collabora.com>
Date:   Fri, 9 Jun 2023 11:03:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 4/9] regulator: mt6358: Drop *_SSHUB regulators
Content-Language: en-US
To:     Chen-Yu Tsai <wenst@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Gene Chen <gene_chen@richtek.com>,
        Johnson Wang <johnson.wang@mediatek.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230609083009.2822259-1-wenst@chromium.org>
 <20230609083009.2822259-5-wenst@chromium.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230609083009.2822259-5-wenst@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 09/06/23 10:30, Chen-Yu Tsai ha scritto:
> The *_SSHUB regulators are actually alternate configuration interfaces
> for their non *_SSHUB counterparts. They are not separate regulator
> outputs. These registers are intended for the companion processor to
> use to configure the power rails while the main processor is sleeping.
> They are not intended for the main operating system to use.
> 
> Since they are not real outputs they shouldn't be modeled separately.
> Remove them. Luckily no device tree actually uses them.
> 

I'm not sure that MT6358/6366 are used only on Chromebook SoCs, and that this SSHUB
mechanism (companion processor) is the same across all firmwares.

I'd like someone from MediaTek to confirm that this is valid for both Chromebook
and Smartphone firmwares.

Regards,
Angelo

> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> ---
>   drivers/regulator/mt6358-regulator.c       | 14 --------------
>   include/linux/regulator/mt6358-regulator.h |  4 ----
>   2 files changed, 18 deletions(-)
> 
> diff --git a/drivers/regulator/mt6358-regulator.c b/drivers/regulator/mt6358-regulator.c
> index faf6b0757019..946a251a8b3a 100644
> --- a/drivers/regulator/mt6358-regulator.c
> +++ b/drivers/regulator/mt6358-regulator.c
> @@ -505,9 +505,6 @@ static struct mt6358_regulator_info mt6358_regulators[] = {
>   	MT6358_BUCK("buck_vcore", VCORE, 500000, 1293750, 6250,
>   		    buck_volt_range1, 0x7f, MT6358_BUCK_VCORE_DBG0, 0x7f,
>   		    MT6358_VCORE_VGPU_ANA_CON0, 1),
> -	MT6358_BUCK("buck_vcore_sshub", VCORE_SSHUB, 500000, 1293750, 6250,
> -		    buck_volt_range1, 0x7f, MT6358_BUCK_VCORE_SSHUB_ELR0, 0x7f,
> -		    MT6358_VCORE_VGPU_ANA_CON0, 1),
>   	MT6358_BUCK("buck_vpa", VPA, 500000, 3650000, 50000,
>   		    buck_volt_range3, 0x3f, MT6358_BUCK_VPA_DBG0, 0x3f,
>   		    MT6358_VPA_ANA_CON0, 3),
> @@ -583,10 +580,6 @@ static struct mt6358_regulator_info mt6358_regulators[] = {
>   	MT6358_LDO1("ldo_vsram_others", VSRAM_OTHERS, 500000, 1293750, 6250,
>   		    buck_volt_range1, MT6358_LDO_VSRAM_OTHERS_DBG0, 0x7f00,
>   		    MT6358_LDO_VSRAM_CON2, 0x7f),
> -	MT6358_LDO1("ldo_vsram_others_sshub", VSRAM_OTHERS_SSHUB, 500000,
> -		    1293750, 6250, buck_volt_range1,
> -		    MT6358_LDO_VSRAM_OTHERS_SSHUB_CON1, 0x7f,
> -		    MT6358_LDO_VSRAM_OTHERS_SSHUB_CON1, 0x7f),
>   	MT6358_LDO1("ldo_vsram_gpu", VSRAM_GPU, 500000, 1293750, 6250,
>   		    buck_volt_range1, MT6358_LDO_VSRAM_GPU_DBG0, 0x7f00,
>   		    MT6358_LDO_VSRAM_CON3, 0x7f),
> @@ -603,9 +596,6 @@ static struct mt6358_regulator_info mt6366_regulators[] = {
>   	MT6366_BUCK("buck_vcore", VCORE, 500000, 1293750, 6250,
>   		    buck_volt_range1, 0x7f, MT6358_BUCK_VCORE_DBG0, 0x7f,
>   		    MT6358_VCORE_VGPU_ANA_CON0, 1),
> -	MT6366_BUCK("buck_vcore_sshub", VCORE_SSHUB, 500000, 1293750, 6250,
> -		    buck_volt_range1, 0x7f, MT6358_BUCK_VCORE_SSHUB_ELR0, 0x7f,
> -		    MT6358_VCORE_VGPU_ANA_CON0, 1),
>   	MT6366_BUCK("buck_vpa", VPA, 500000, 3650000, 50000,
>   		    buck_volt_range3, 0x3f, MT6358_BUCK_VPA_DBG0, 0x3f,
>   		    MT6358_VPA_ANA_CON0, 3),
> @@ -670,10 +660,6 @@ static struct mt6358_regulator_info mt6366_regulators[] = {
>   	MT6366_LDO1("ldo_vsram_others", VSRAM_OTHERS, 500000, 1293750, 6250,
>   		    buck_volt_range1, MT6358_LDO_VSRAM_OTHERS_DBG0, 0x7f00,
>   		    MT6358_LDO_VSRAM_CON2, 0x7f),
> -	MT6366_LDO1("ldo_vsram_others_sshub", VSRAM_OTHERS_SSHUB, 500000,
> -		    1293750, 6250, buck_volt_range1,
> -		    MT6358_LDO_VSRAM_OTHERS_SSHUB_CON1, 0x7f,
> -		    MT6358_LDO_VSRAM_OTHERS_SSHUB_CON1, 0x7f),
>   	MT6366_LDO1("ldo_vsram_gpu", VSRAM_GPU, 500000, 1293750, 6250,
>   		    buck_volt_range1, MT6358_LDO_VSRAM_GPU_DBG0, 0x7f00,
>   		    MT6358_LDO_VSRAM_CON3, 0x7f),
> diff --git a/include/linux/regulator/mt6358-regulator.h b/include/linux/regulator/mt6358-regulator.h
> index a4307cd9edd6..c71a6a9fce7a 100644
> --- a/include/linux/regulator/mt6358-regulator.h
> +++ b/include/linux/regulator/mt6358-regulator.h
> @@ -47,8 +47,6 @@ enum {
>   	MT6358_ID_VLDO28,
>   	MT6358_ID_VAUD28,
>   	MT6358_ID_VSIM2,
> -	MT6358_ID_VCORE_SSHUB,
> -	MT6358_ID_VSRAM_OTHERS_SSHUB,
>   	MT6358_ID_RG_MAX,
>   };
>   
> @@ -88,8 +86,6 @@ enum {
>   	MT6366_ID_VMC,
>   	MT6366_ID_VAUD28,
>   	MT6366_ID_VSIM2,
> -	MT6366_ID_VCORE_SSHUB,
> -	MT6366_ID_VSRAM_OTHERS_SSHUB,
>   	MT6366_ID_RG_MAX,
>   };
>   

