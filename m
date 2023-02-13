Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D595C69497E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 15:59:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231282AbjBMO7Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 09:59:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbjBMO7H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 09:59:07 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0086F1CAF5;
        Mon, 13 Feb 2023 06:58:47 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 0071366020A2;
        Mon, 13 Feb 2023 14:58:17 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1676300298;
        bh=PkIWF/Cyn6UlA44s0dkS/hV7U5qDNxMSgfRSqY/J2pk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ZqFi3akZlnEI2lSSS4H0R3KzwCjL7eS7a2Kpt8GZ19xp1ckAIoeSI91Hhr3Fadfl9
         lKpZUivoFfiXrqfg2MqYTp+1u7+XQYfaq/JqH06CH8DuTn9fqjLOJMHddFPPnui+b4
         LXKEDNXso7+jZAESiosJEXkf/eyuvwnVNtrGba7l2lTvQltUwuFbjCmBEOxmiYGD5r
         KusCo+ocwTuuH775rK9n1gvyDByW4o8Tc3LfC9HnRP1gZS4rpuP2cY3HoA38sm4oqr
         JmbAWcZg9orp2yPGobZ4ILzaHes7xxioZ0U68df8vijmHEyDs5wskSgSYpMawWhUb8
         TspQv3uLvnfcw==
Message-ID: <407e8e4e-fdcc-26ab-0bb3-e03b59f0d25c@collabora.com>
Date:   Mon, 13 Feb 2023 15:58:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH v6 07/12] remoteproc: mediatek: Probe multi-core SCP
Content-Language: en-US
To:     Tinghan Shen <tinghan.shen@mediatek.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20230213033758.16681-1-tinghan.shen@mediatek.com>
 <20230213033758.16681-8-tinghan.shen@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230213033758.16681-8-tinghan.shen@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 13/02/23 04:37, Tinghan Shen ha scritto:
> The difference of single-core SCP and multi-core SCP device tree is
> the presence of child device nodes described SCP cores. The SCP
> driver populates the platform device and checks the child nodes
> to identify whether it's a single-core SCP or a multi-core SCP.
> 
> The resource structure of the multi-core SCP is a list of remoteproc
> instances which is different to the single-core SCP. The corresponding
> resource releasing action is based on the type of SCP.
> 
> Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
> ---
>   drivers/remoteproc/mtk_common.h |   7 ++
>   drivers/remoteproc/mtk_scp.c    | 177 +++++++++++++++++++++++++++++---
>   2 files changed, 169 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/remoteproc/mtk_common.h b/drivers/remoteproc/mtk_common.h
> index 3778894c96f3..635b17676de8 100644
> --- a/drivers/remoteproc/mtk_common.h
> +++ b/drivers/remoteproc/mtk_common.h
> @@ -112,6 +112,10 @@ struct mtk_scp_of_data {
>   	size_t ipi_buf_offset;
>   };
>   
> +struct mtk_scp_cluster {
> +	struct list_head cores;

You don't need this structure... it's just one element inside, so you can
simply add it to `struct mtk_scp` instead: for readability purposes, you
can call this list `cluster_cores`.

After which

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


