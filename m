Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0628725665
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 09:51:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235494AbjFGHvl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 03:51:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239393AbjFGHvC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 03:51:02 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C24A10D7;
        Wed,  7 Jun 2023 00:49:37 -0700 (PDT)
Received: from [IPV6:2001:b07:2ed:14ed:a962:cd4d:a84:1eab] (unknown [IPv6:2001:b07:2ed:14ed:a962:cd4d:a84:1eab])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 1FA686606EF8;
        Wed,  7 Jun 2023 08:49:35 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1686124175;
        bh=btdp22YPcE4rcsqawF/Dzg9wpsgaMB/+rd1QkI94JJs=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=YB4veNFvvKChhZJyxJdNkRiWGLv0BqdmQ2Jvm3MluU20wVsRbStjIAdp0YBsMIO1s
         UAmp5RRx0zee1Mj5aSasJlPssCpjLjs36+rwXH6g8L8h725EaOR+7J5o87rtgtNfSV
         p5Q6Vt6RVOkxeMQMju4jD81D56lvNb3FjvN7P+QAko0nbMF5plJk1JnYRgJx83+q7R
         jZtzKDNObC0D6o4zdZKJQNqiJTzFcoYhVJCTOVC5JRqoYPJn+oWMK45ykvmlYpZKC2
         z3dfrTXRMsUYW1edEUalyb/rpyZa4V932lwbR6M8ZJNdmXyps6tLE1NE1Jn9CgAWGQ
         uJytNuNohHNnw==
Message-ID: <3024a2a8-8e64-dfab-a9a3-0d4f51b345d9@collabora.com>
Date:   Wed, 7 Jun 2023 09:49:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v13 07/11] remoteproc: mediatek: Add scp_boot_peers and
 scp_shutdown_peers operations
Content-Language: en-US
To:     Tinghan Shen <tinghan.shen@mediatek.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20230607072222.8628-1-tinghan.shen@mediatek.com>
 <20230607072222.8628-8-tinghan.shen@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230607072222.8628-8-tinghan.shen@mediatek.com>
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

Il 07/06/23 09:22, Tinghan Shen ha scritto:
> Due to that SCP core 0 controls the SCP clock and SRAM power, add two
> new mtk_scp_of_data operations, scp_boot_peers and scp_shutdown_peers,
> to manage the boot sequence and watchdog timeout handling of SCP core 1.
> It ensures that core 1 boots after or shuts down before core 0 for
> maintaining the proper control flow over SCP core 1.
> 
> Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
> ---
>   drivers/remoteproc/mtk_common.h |  3 ++
>   drivers/remoteproc/mtk_scp.c    | 55 +++++++++++++++++++++++++++++++++
>   2 files changed, 58 insertions(+)
> 
> diff --git a/drivers/remoteproc/mtk_common.h b/drivers/remoteproc/mtk_common.h
> index 56395e8664cb..0bfd242c41cc 100644
> --- a/drivers/remoteproc/mtk_common.h
> +++ b/drivers/remoteproc/mtk_common.h
> @@ -93,6 +93,8 @@ struct mtk_scp_of_data {
>   	void (*scp_reset_deassert)(struct mtk_scp *scp);
>   	void (*scp_stop)(struct mtk_scp *scp);
>   	void *(*scp_da_to_va)(struct mtk_scp *scp, u64 da, size_t len);
> +	void (*scp_boot_peers)(struct mtk_scp *scp);
> +	void (*scp_shutdown_peers)(struct mtk_scp *scp);
>   
>   	u32 host_to_scp_reg;
>   	u32 host_to_scp_int_bit;
> @@ -130,6 +132,7 @@ struct mtk_scp {
>   	struct rproc_subdev *rpmsg_subdev;
>   
>   	struct list_head elem;
> +	struct list_head *cluster;
>   };
>   
>   /**
> diff --git a/drivers/remoteproc/mtk_scp.c b/drivers/remoteproc/mtk_scp.c
> index d644e232dfec..edbf71f4c21e 100644
> --- a/drivers/remoteproc/mtk_scp.c
> +++ b/drivers/remoteproc/mtk_scp.c
> @@ -74,8 +74,21 @@ void scp_put(struct mtk_scp *scp)
>   }
>   EXPORT_SYMBOL_GPL(scp_put);
>   
> +static void mt8195_scp_shutdown_peers(struct mtk_scp *scp)
> +{
> +	struct mtk_scp *next_scp;
> +
> +	next_scp = list_next_entry(scp, elem);
> +	list_for_each_entry_from(next_scp, scp->cluster, elem) {
> +		rproc_shutdown(next_scp->rproc);
> +	}

braces are not needed here; after fixing that,

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


