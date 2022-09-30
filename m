Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D32D95F0B73
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 14:13:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231534AbiI3MNA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 08:13:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231191AbiI3MM5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 08:12:57 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1415E1794A0;
        Fri, 30 Sep 2022 05:12:56 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 7AC7666022C7;
        Fri, 30 Sep 2022 13:12:53 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1664539973;
        bh=S/w2ZgDqdlLU+Y5Jz0E2rWA2oIr8YVBO+H3Z2byFScQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=hevf7fljW2fs3JHeop1tzitdLhD8iz5jrvS7rn8C/rOSMgWjZRC1Q4lLTJ0mP7CI8
         /8Qi8JZUNjqKWTyeQepFo0BGGdmrDWmKfUFDZ/GLVQ+GaO7NGULQQKyLELx+vah0Pk
         ZCkZVykNQA3PB+GlOgmkayfWBlGopjGyizLGZCm6pZu03exvacZbXE9eW+Bh9iihpz
         aJ5TNK1jiHC/w0ULE6VFqYXSYCegkqrNfvR4yXBUnJzNOX8mxg+8YuVSnnrt4YpwuX
         UoPrv90Gm8hGWsWj1iMvh/aNYSO2O1UKLcdu+cr92ZVIdRWtfH5rlPjyWvvqYVLkH0
         f+0wlhOZm0mYQ==
Message-ID: <8afa9c8e-079e-6e50-a8d7-21e0b1698f76@collabora.com>
Date:   Fri, 30 Sep 2022 14:12:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v1 2/2] media: platform: mtk-mdp3: fix error handling
 about components clock_on
Content-Language: en-US
To:     Moudy Ho <moudy.ho@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     linux-media@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220930102306.13201-1-moudy.ho@mediatek.com>
 <20220930102306.13201-3-moudy.ho@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220930102306.13201-3-moudy.ho@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 30/09/22 12:23, Moudy Ho ha scritto:
> Add goto statement in mdp_comp_clock_on() to avoid error code not being
> propagated or returning positive values.
> This change also performs a well-timed clock_off when an error occurs, and
> reduces unnecessary error logging in mdp_cmdq_send().
> 
> Fixes: 61890ccaefaf ("media: platform: mtk-mdp3: add MediaTek MDP3 driver")
> Signed-off-by: Moudy Ho <moudy.ho@mediatek.com>
> ---
>   .../platform/mediatek/mdp3/mtk-mdp3-cmdq.c    |  4 +---
>   .../platform/mediatek/mdp3/mtk-mdp3-comp.c    | 24 ++++++++++++++-----
>   2 files changed, 19 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-cmdq.c b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-cmdq.c
> index e194dec8050a..124c1b96e96b 100644
> --- a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-cmdq.c
> +++ b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-cmdq.c
> @@ -433,10 +433,8 @@ int mdp_cmdq_send(struct mdp_dev *mdp, struct mdp_cmdq_param *param)
>   	cmd->mdp_ctx = param->mdp_ctx;
>   
>   	ret = mdp_comp_clocks_on(&mdp->pdev->dev, cmd->comps, cmd->num_comps);
> -	if (ret) {
> -		dev_err(dev, "comp %d failed to enable clock!\n", ret);
> +	if (ret)
>   		goto err_free_path;
> -	}
>   
>   	dma_sync_single_for_device(mdp->cmdq_clt->chan->mbox->dev,
>   				   cmd->pkt.pa_base, cmd->pkt.cmd_buf_size,
> diff --git a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-comp.c b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-comp.c
> index d3eaf8884412..fe6a39315e88 100644
> --- a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-comp.c
> +++ b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-comp.c
> @@ -699,12 +699,22 @@ int mdp_comp_clock_on(struct device *dev, struct mdp_comp *comp)
>   			dev_err(dev,
>   				"Failed to enable clk %d. type:%d id:%d\n",
>   				i, comp->type, comp->id);
> -			pm_runtime_put(comp->comp_dev);
> -			return ret;
> +			goto err_unwind;
>   		}
>   	}
>   
>   	return 0;
> +
> +err_unwind:

For this label to be clearer, I would rename it as `err_revert`, or
`clocks_off`, or even simply `err`, as the `unwind` word may create
some confusion here.

> +	while (--i >= 0) {
> +		if (IS_ERR_OR_NULL(comp->clks[i]))
> +			continue;
> +		clk_disable_unprepare(comp->clks[i]);
> +	}
> +	if (comp->comp_dev)
> +		pm_runtime_put_sync(comp->comp_dev);
> +
> +	return ret;
>   }
>   
>   void mdp_comp_clock_off(struct device *dev, struct mdp_comp *comp)
> @@ -723,11 +733,13 @@ void mdp_comp_clock_off(struct device *dev, struct mdp_comp *comp)
>   
>   int mdp_comp_clocks_on(struct device *dev, struct mdp_comp *comps, int num)
>   {
> -	int i;
> +	int i, ret;
>   
> -	for (i = 0; i < num; i++)
> -		if (mdp_comp_clock_on(dev, &comps[i]) != 0)
> -			return ++i;
> +	for (i = 0; i < num; i++) {
> +		ret = mdp_comp_clock_on(dev, &comps[i]);
> +		if (ret)
> +			return ret;
> +	}
>   
>   	return 0;
>   }
> 
