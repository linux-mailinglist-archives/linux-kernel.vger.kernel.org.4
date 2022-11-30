Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7CFD63D43E
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 12:18:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234264AbiK3LSt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 06:18:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234472AbiK3LSP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 06:18:15 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D7415D6A0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 03:18:09 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id C2A646602B30;
        Wed, 30 Nov 2022 11:18:07 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1669807088;
        bh=9JEnVvXe2AQJQov5NPbbhdvIIlOh1SEvzItB2gAZFRY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ktQ4RZvTH0cBoti3WzmZNxvL8tQ+tAlFo9sE+bCLBS0wS1ObWNaeDxhXkmN0Dj+ru
         rYQxEoESupCn+BsTroZW2kn9jB18up9s2SFnGF68a8vNf5vpr2tXush7xknPUPtPaO
         Jk8WIJS2y55a/HADTPm/ceZYek2Qa1myeWBPE+LKnUqFsiGNcbstZm28e8L/aC9+kN
         6qHXXvnX9N4mbazRJs1VLTPnhLBgZ8KxI++m7qOTTyO6FvJRW3QkJdeJ6G53MlH3sk
         BERczJSRIkMVz+8tpAprDkbJDITSih4/lfsx9Lh8eFNftyx5KvnFluvP3SIrsWFkct
         KrFqHlnBOxHUQ==
Message-ID: <d63e9f81-abe7-9017-d62a-6beb3f39fbd0@collabora.com>
Date:   Wed, 30 Nov 2022 12:18:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH] mailbox: mtk-cmdq: Do not request irq until we are ready
Content-Language: en-US
To:     Ricardo Ribalda <ribalda@chromium.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20221125-mtk-mailbox-v1-0-2e3ee120850c@chromium.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20221125-mtk-mailbox-v1-0-2e3ee120850c@chromium.org>
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

Il 25/11/22 17:19, Ricardo Ribalda ha scritto:
> If the system comes from kexec() the peripheral might trigger an IRQ
> befoe we are ready for it. Triggering a crash due to an access to
> invalid memory.
> 
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>

I agree on this change, but I've already sent a patch that's been reviewed
by multiple people (hence ready to be picked), on top of which this patch
will not apply.

Can you please rebase this patch on top of [1]?

Thanks,
Angelo

[1]: 
https://patchwork.kernel.org/project/linux-mediatek/patch/20221102100736.37815-1-angelogioacchino.delregno@collabora.com/

> ---
> To: Jassi Brar <jassisinghbrar@gmail.com>
> To: Matthias Brugger <matthias.bgg@gmail.com>
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-mediatek@lists.infradead.org
> ---
>   drivers/mailbox/mtk-cmdq-mailbox.c | 13 +++++++------
>   1 file changed, 7 insertions(+), 6 deletions(-)
> 
> 
> ---
> base-commit: 4312098baf37ee17a8350725e6e0d0e8590252d4
> change-id: 20221125-mtk-mailbox-ba6cbd1d91b6
> 
> Best regards,
> 
> diff --git a/drivers/mailbox/mtk-cmdq-mailbox.c b/drivers/mailbox/mtk-cmdq-mailbox.c
> index 9465f9081515..829f1ef3309f 100644
> --- a/drivers/mailbox/mtk-cmdq-mailbox.c
> +++ b/drivers/mailbox/mtk-cmdq-mailbox.c
> @@ -545,12 +545,6 @@ static int cmdq_probe(struct platform_device *pdev)
>   	cmdq->control_by_sw = plat_data->control_by_sw;
>   	cmdq->gce_num = plat_data->gce_num;
>   	cmdq->irq_mask = GENMASK(cmdq->thread_nr - 1, 0);
> -	err = devm_request_irq(dev, cmdq->irq, cmdq_irq_handler, IRQF_SHARED,
> -			       "mtk_cmdq", cmdq);
> -	if (err < 0) {
> -		dev_err(dev, "failed to register ISR (%d)\n", err);
> -		return err;
> -	}
>   
>   	dev_dbg(dev, "cmdq device: addr:0x%p, va:0x%p, irq:%d\n",
>   		dev, cmdq->base, cmdq->irq);
> @@ -613,6 +607,13 @@ static int cmdq_probe(struct platform_device *pdev)
>   
>   	platform_set_drvdata(pdev, cmdq);
>   
> +	err = devm_request_irq(dev, cmdq->irq, cmdq_irq_handler, IRQF_SHARED,
> +			       "mtk_cmdq", cmdq);
> +	if (err < 0) {
> +		dev_err(dev, "failed to register ISR (%d)\n", err);
> +		return err;
> +	}
> +
>   	WARN_ON(clk_bulk_prepare(cmdq->gce_num, cmdq->clocks));
>   
>   	cmdq_init(cmdq);
> 

