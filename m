Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61AD16E59A5
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 08:47:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231184AbjDRGrX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 02:47:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231160AbjDRGrI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 02:47:08 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 078C3525D;
        Mon, 17 Apr 2023 23:46:57 -0700 (PDT)
Received: from pendragon.ideasonboard.com (133-32-181-51.west.xps.vectant.ne.jp [133.32.181.51])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id D0297802;
        Tue, 18 Apr 2023 08:46:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1681800409;
        bh=ig+6uUC/w7eT4P0DWFa+g2Dt6Z8ZjscuBYXNSfTmvvY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gEIY3zI1N+ETxUAi8wmrx++yIEb+5PG8eLcWrtVpsjG/3q9PI1Lo3zvhyvt7FMka3
         XSR0siEZXKGatmpQ7uOGuyPYoNQqxiobyMrX8ftFR15sJoynI42TlcHVK7CG+J6mmI
         +6WHQBjP+vuXOHTLqJYR2g+Zk3IuH8ML/pfGE4jU=
Date:   Tue, 18 Apr 2023 09:47:07 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Jacopo Mondi <jacopo.mondi@ideasonboard.com>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Guoniu Zhou <guoniu.zhou@nxp.com>,
        Christian Hemp <c.hemp@phytec.de>, linux-media@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [v2] media: nxp: imx8-isi: fix buiding on 32-bit
Message-ID: <20230418064707.GC4703@pendragon.ideasonboard.com>
References: <20230418061155.2923515-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230418061155.2923515-1-arnd@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

Thank you for the patch.

On Tue, Apr 18, 2023 at 08:11:43AM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The #if check is wrong, leading to a build failure:
> 
> drivers/media/platform/nxp/imx8-isi/imx8-isi-hw.c: In function 'mxc_isi_channel_set_inbuf':
> drivers/media/platform/nxp/imx8-isi/imx8-isi-hw.c:33:5: error: "CONFIG_ARCH_DMA_ADDR_T_64BIT" is not defined, evaluates to 0 [-Werror=undef]
>    33 | #if CONFIG_ARCH_DMA_ADDR_T_64BIT
>       |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> This could just be an #ifdef, but it seems nicer to just remove
> the check entirely. Apparently the only reason for the #ifdef
> is to avoid another warning:
> 
> drivers/media/platform/nxp/imx8-isi/imx8-isi-hw.c:55:24: error: right shift count >= width of type [-Werror=shift-count-overflow]
> 
> But this is best avoided by using the lower_32_bits()/upper_32_bits()
> helpers.
> 
> Fixes: cf21f328fcaf ("media: nxp: Add i.MX8 ISI driver")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Mauro, could you please pick this up for v6.4 ?

> ---
> v2: whitespace fixup
> ---
>  .../media/platform/nxp/imx8-isi/imx8-isi-hw.c | 41 ++++++++++---------
>  1 file changed, 21 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/media/platform/nxp/imx8-isi/imx8-isi-hw.c b/drivers/media/platform/nxp/imx8-isi/imx8-isi-hw.c
> index db538f3d88ec..19e80b95ffea 100644
> --- a/drivers/media/platform/nxp/imx8-isi/imx8-isi-hw.c
> +++ b/drivers/media/platform/nxp/imx8-isi/imx8-isi-hw.c
> @@ -29,11 +29,10 @@ static inline void mxc_isi_write(struct mxc_isi_pipe *pipe, u32 reg, u32 val)
>  
>  void mxc_isi_channel_set_inbuf(struct mxc_isi_pipe *pipe, dma_addr_t dma_addr)
>  {
> -	mxc_isi_write(pipe, CHNL_IN_BUF_ADDR, dma_addr);
> -#if CONFIG_ARCH_DMA_ADDR_T_64BIT
> +	mxc_isi_write(pipe, CHNL_IN_BUF_ADDR, lower_32_bits(dma_addr));
>  	if (pipe->isi->pdata->has_36bit_dma)
> -		mxc_isi_write(pipe, CHNL_IN_BUF_XTND_ADDR, dma_addr >> 32);
> -#endif
> +		mxc_isi_write(pipe, CHNL_IN_BUF_XTND_ADDR,
> +			      upper_32_bits(dma_addr));
>  }
>  
>  void mxc_isi_channel_set_outbuf(struct mxc_isi_pipe *pipe,
> @@ -45,34 +44,36 @@ void mxc_isi_channel_set_outbuf(struct mxc_isi_pipe *pipe,
>  	val = mxc_isi_read(pipe, CHNL_OUT_BUF_CTRL);
>  
>  	if (buf_id == MXC_ISI_BUF1) {
> -		mxc_isi_write(pipe, CHNL_OUT_BUF1_ADDR_Y, dma_addrs[0]);
> -		mxc_isi_write(pipe, CHNL_OUT_BUF1_ADDR_U, dma_addrs[1]);
> -		mxc_isi_write(pipe, CHNL_OUT_BUF1_ADDR_V, dma_addrs[2]);
> -#if CONFIG_ARCH_DMA_ADDR_T_64BIT
> +		mxc_isi_write(pipe, CHNL_OUT_BUF1_ADDR_Y,
> +			      lower_32_bits(dma_addrs[0]));
> +		mxc_isi_write(pipe, CHNL_OUT_BUF1_ADDR_U,
> +			      lower_32_bits(dma_addrs[1]));
> +		mxc_isi_write(pipe, CHNL_OUT_BUF1_ADDR_V,
> +			      lower_32_bits(dma_addrs[2]));
>  		if (pipe->isi->pdata->has_36bit_dma) {
>  			mxc_isi_write(pipe, CHNL_Y_BUF1_XTND_ADDR,
> -				      dma_addrs[0] >> 32);
> +				      upper_32_bits(dma_addrs[0]));
>  			mxc_isi_write(pipe, CHNL_U_BUF1_XTND_ADDR,
> -				      dma_addrs[1] >> 32);
> +				      upper_32_bits(dma_addrs[1]));
>  			mxc_isi_write(pipe, CHNL_V_BUF1_XTND_ADDR,
> -				      dma_addrs[2] >> 32);
> +				      upper_32_bits(dma_addrs[2]));
>  		}
> -#endif
>  		val ^= CHNL_OUT_BUF_CTRL_LOAD_BUF1_ADDR;
>  	} else  {
> -		mxc_isi_write(pipe, CHNL_OUT_BUF2_ADDR_Y, dma_addrs[0]);
> -		mxc_isi_write(pipe, CHNL_OUT_BUF2_ADDR_U, dma_addrs[1]);
> -		mxc_isi_write(pipe, CHNL_OUT_BUF2_ADDR_V, dma_addrs[2]);
> -#if CONFIG_ARCH_DMA_ADDR_T_64BIT
> +		mxc_isi_write(pipe, CHNL_OUT_BUF2_ADDR_Y,
> +			      lower_32_bits(dma_addrs[0]));
> +		mxc_isi_write(pipe, CHNL_OUT_BUF2_ADDR_U,
> +			      lower_32_bits(dma_addrs[1]));
> +		mxc_isi_write(pipe, CHNL_OUT_BUF2_ADDR_V,
> +			      lower_32_bits(dma_addrs[2]));
>  		if (pipe->isi->pdata->has_36bit_dma) {
>  			mxc_isi_write(pipe, CHNL_Y_BUF2_XTND_ADDR,
> -				      dma_addrs[0] >> 32);
> +				      upper_32_bits(dma_addrs[0]));
>  			mxc_isi_write(pipe, CHNL_U_BUF2_XTND_ADDR,
> -				      dma_addrs[1] >> 32);
> +				      upper_32_bits(dma_addrs[1]));
>  			mxc_isi_write(pipe, CHNL_V_BUF2_XTND_ADDR,
> -				      dma_addrs[2] >> 32);
> +				      upper_32_bits(dma_addrs[2]));
>  		}
> -#endif
>  		val ^= CHNL_OUT_BUF_CTRL_LOAD_BUF2_ADDR;
>  	}
>  

-- 
Regards,

Laurent Pinchart
