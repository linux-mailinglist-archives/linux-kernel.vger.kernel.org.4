Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29483715B0D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 12:06:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231390AbjE3KGN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 06:06:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231368AbjE3KGG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 06:06:06 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46F5D93;
        Tue, 30 May 2023 03:06:05 -0700 (PDT)
Received: from [IPV6:2001:b07:2ed:14ed:a962:cd4d:a84:1eab] (unknown [IPv6:2001:b07:2ed:14ed:a962:cd4d:a84:1eab])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 4B2EB66059A8;
        Tue, 30 May 2023 11:06:03 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1685441164;
        bh=h0G8aacKqdBgS5C1qg9jRMOSlWZ7H/k7T1lOosYm1Mc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=j8cGkxrJY6l2EEhgjzw1vbKYkXTrr+ION8Bu6BWlrU/yaGtexhg0Af7H2oZuoSzDj
         P/IwJvxngRCz9TDCE9OE/rVMxbEqudQIhmQx6BrdLDO6yLecvozQkuLjX84d+UXjZD
         9tyUYFI7jooiBTv7y0yh44QSly4ehpCwV072VZJfgDxRNJxkoGRfAQOKYb+GNC3SMK
         bRkrTD4GEbKOEEVF/fN5brgAoZMnUkLf+jJzWfpEnl+XUAHHh0/tWpXvYdsaELF4WT
         lCSUDbGIwJc9XEJQpfbDot+qVr5eEuBR3xV1FPdefWoWbPQxKeYr4jBYiy4CQtNh1s
         U0Ok3OPj2Z5ZA==
Message-ID: <f3322e41-1891-a33b-daaa-731ec548ec4e@collabora.com>
Date:   Tue, 30 May 2023 12:06:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v5,8/8] media: mediatek: vcodec: Add dbgfs help function
Content-Language: en-US
To:     Yunfei Dong <yunfei.dong@mediatek.com>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        =?UTF-8?Q?N=c3=adcolas_F_=2e_R_=2e_A_=2e_Prado?= 
        <nfraprado@collabora.com>, Nathan Hebert <nhebert@chromium.org>
Cc:     Hsin-Yi Wang <hsinyi@chromium.org>,
        Fritz Koenig <frkoenig@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Steve Cho <stevecho@chromium.org>, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20230525021219.23638-1-yunfei.dong@mediatek.com>
 <20230525021219.23638-9-yunfei.dong@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230525021219.23638-9-yunfei.dong@mediatek.com>
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

Il 25/05/23 04:12, Yunfei Dong ha scritto:
> Getting dbgfs help information with command "echo -help > vdec".
> 
> Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>
> ---
>   .../mediatek/vcodec/mtk_vcodec_dbgfs.c        | 24 ++++++++++++++++++-
>   1 file changed, 23 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dbgfs.c b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dbgfs.c
> index 237d0dc8a1fc..2372fc449b45 100644
> --- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dbgfs.c
> +++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dbgfs.c
> @@ -52,6 +52,23 @@ static void mtk_vdec_dbgfs_get_format_type(struct mtk_vcodec_ctx *ctx, char *buf
>   	*used += curr_len;
>   }
>   
> +static void mtk_vdec_dbgfs_get_help(char *buf, int *used, int total)
> +{
> +	int curr_len;
> +
> +	curr_len = snprintf(buf + *used, total - *used,
> +			    "help: (1: echo -'info' > vdec 2: cat vdec)\n");
> +	*used += curr_len;
> +
> +	curr_len = snprintf(buf + *used, total - *used,
> +			    "\t-picinfo: get resolution\n");
> +	*used += curr_len;
> +
> +	curr_len = snprintf(buf + *used, total - *used,
> +			    "\t-format: get output & capture queue format\n");
> +	*used += curr_len;
> +}
> +
>   static ssize_t mtk_vdec_dbgfs_write(struct file *filp, const char __user *ubuf,
>   				    size_t count, loff_t *ppos)
>   {
> @@ -84,6 +101,11 @@ static ssize_t mtk_vdec_dbgfs_read(struct file *filp, char __user *ubuf,
>   	if (!buf)
>   		return -ENOMEM;
>   
> +	if (strstr(dbgfs->dbgfs_buf, "-help")) {

I would print the help strings in two conditions:
1. -help
2. (nothing)

...so that if you don't echo anything to vdec (no params), you get the help text.
Otherwise, you would have to know that "-help" is a parameter that gives you help
text in the first place.

As for this commit "as is", it works as intended and it is useful to retrieve
the help text; you can either send a followup commit that extends the help to
the corner case that I've explained, or send a v6 adding that to this same commit.

I would prefer to see a v6 -- BUT -- since this series was sent a long time ago,
you will get my R-b and I will leave the final choice to Hans.

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


