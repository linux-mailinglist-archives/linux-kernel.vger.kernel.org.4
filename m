Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1751B6D4472
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 14:32:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231285AbjDCMcC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 08:32:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232370AbjDCMb5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 08:31:57 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAE4A1D843;
        Mon,  3 Apr 2023 05:31:50 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id DC9506602040;
        Mon,  3 Apr 2023 13:31:47 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1680525109;
        bh=GKT610DcFF8LIpWhcPXHkIz0Hgg2flPufm9V1ZMqTtw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=L4hb3pVXMMNIueWs8IubjUT/LPpKKhwX3e9d3OPZ3RaqkOGO7sIuTxmIXMZ1d9i+O
         2e0r5seRD+kegGiAcMO7h6GwPPP4uH5HkdYJqBILz7UTA9ZIsFl8AwDPi/qqU0OYRa
         kJw4ohKjEAzIb+fnBbEZx8pcS7Cq1/d4mP9flA+3hCjfJQYq5D0ul50sg4aC1/YGsC
         pilF4XRAG6jryJHi++hmifO11fZkYclijhcOqR77VDiLoS341jzkNPlGM1be+Fh6et
         AhB9QZZzQ/i1ro/oTl1sn4Ub4AEulhGo2HX6yjnrntLFsxq5sqKS9eCApXW2M86FFk
         7Z4uHPf1M0iuA==
Message-ID: <6626cb88-9d9e-593f-f4c9-44c3035bad43@collabora.com>
Date:   Mon, 3 Apr 2023 14:31:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 1/7] usb: mtu3: give back request when rx error happens
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Eddie Hung <eddie.hung@mediatek.com>,
        Tianping Fang <tianping.fang@mediatek.com>
References: <20230403025230.25035-1-chunfeng.yun@mediatek.com>
Content-Language: en-US
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230403025230.25035-1-chunfeng.yun@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 03/04/23 04:52, Chunfeng Yun ha scritto:
> When the Rx enconnter errors, currently, only print error logs, that
> may cause class driver's RX halt, shall give back the request with
> error status meanwhile.
> 
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>

 From what I understand, this is not a new feature, but a fix for a unwanted QMU
halt.
This means that this commit needs a Fixes tag.

> ---
>   drivers/usb/mtu3/mtu3_qmu.c | 39 ++++++++++++++++++++++++++++++++++++-
>   1 file changed, 38 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/mtu3/mtu3_qmu.c b/drivers/usb/mtu3/mtu3_qmu.c
> index a2fdab8b63b2..7be4e4be1a6a 100644
> --- a/drivers/usb/mtu3/mtu3_qmu.c
> +++ b/drivers/usb/mtu3/mtu3_qmu.c
> @@ -466,6 +466,39 @@ static void qmu_tx_zlp_error_handler(struct mtu3 *mtu, u8 epnum)
>   	mtu3_qmu_resume(mep);
>   }
>   
> +/*
> + * when rx error happens (except zlperr), QMU will stop, and RQCPR saves
> + * the GPD encountered error, Done irq will arise after resuming QMU again.
> + */
> +static void qmu_error_rx(struct mtu3 *mtu, u8 epnum)
> +{
> +	struct mtu3_ep *mep = mtu->out_eps + epnum;
> +	struct mtu3_gpd_ring *ring = &mep->gpd_ring;
> +	struct qmu_gpd *gpd_current = NULL;
> +	struct usb_request *req = NULL;
> +	struct mtu3_request *mreq;
> +	dma_addr_t cur_gpd_dma;
> +
> +	cur_gpd_dma = read_rxq_cur_addr(mtu->mac_base, epnum);
> +	gpd_current = gpd_dma_to_virt(ring, cur_gpd_dma);
> +
> +	mreq = next_request(mep);
> +	if (!mreq || mreq->gpd != gpd_current) {
> +		dev_err(mtu->dev, "no correct RX req is found\n");
> +		return;
> +	}
> +
> +	req = &mreq->request;
> +	req->status = -EAGAIN;

You don't need a *req pointer for just one simple assignment.

	mreq->request.status = -EAGAIN;

that'll do.

> +
> +	/* by pass the current GDP */
> +	gpd_current->dw0_info |= cpu_to_le32(GPD_FLAGS_BPS | GPD_FLAGS_HWO);
> +	mtu3_qmu_resume(mep);
> +
> +	dev_dbg(mtu->dev, "%s EP%d, current=%p, req=%p\n",
> +		__func__, epnum, gpd_current, mreq);
> +}
> +
>   /*
>    * NOTE: request list maybe is already empty as following case:
>    * queue_tx --> qmu_interrupt(clear interrupt pending, schedule tasklet)-->
> @@ -571,14 +604,18 @@ static void qmu_exception_isr(struct mtu3 *mtu, u32 qmu_status)
>   
>   	if ((qmu_status & RXQ_CSERR_INT) || (qmu_status & RXQ_LENERR_INT)) {
>   		errval = mtu3_readl(mbase, U3D_RQERRIR0);
> +		mtu3_writel(mbase, U3D_RQERRIR0, errval);

Please mention in the commit description the reason why you're moving this register
write here.

Regards,
Angelo
