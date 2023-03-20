Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F8F66C158E
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 15:52:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231909AbjCTOwC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 10:52:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232026AbjCTOvb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 10:51:31 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A340265B9;
        Mon, 20 Mar 2023 07:50:08 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 13979660212C;
        Mon, 20 Mar 2023 14:49:39 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1679323779;
        bh=b0evVStbmjbebTg7JnPsa981Y/oOfL5M+cclKuYMXd0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=GYRb86+aryGONKFjqeSPCtp73ReTpHeVIYtvviGDWsTH85KWMsUYqYnxQeCg3aQfQ
         LbtIYr46t3CCTuc4NYj/IDFtKOihGcpIDDx5Bcd1q0Fppui5Rm1R5d8ShoIiz6UnFu
         c2rfcOoIwdMpmS4ykyWz0btoUYbvzUThzpE/S8KlpYcbBOAxKP2Py5dbVsH29RzJMJ
         0CVtWOpDblwdhVl6HBrby6IAxqJiXk/CONk8s/QbWPBV/EthJFJk3ZPEUC4s4BQo0o
         MWQCjk4MztswjODewvbHJvFTY1ElNGP9aIF2uM0vDiwYOcRQtPLHDGTQce551QC27j
         8YOxLMiOO/j4g==
Message-ID: <100a6c2e-f65f-5297-919a-06b8f73444fa@collabora.com>
Date:   Mon, 20 Mar 2023 15:49:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 3/6 RESEND] media: mediatek: vcodec: Add a debugfs file to
 get different useful information
Content-Language: en-US
To:     Yunfei Dong <yunfei.dong@mediatek.com>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Nicolas Dufresne <nicolas@ndufresne.ca>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        =?UTF-8?Q?N=c3=adcolas_F_=2e_R_=2e_A_=2e_Prado?= 
        <nfraprado@collabora.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Fritz Koenig <frkoenig@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Steve Cho <stevecho@chromium.org>, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20230320102838.8313-1-yunfei.dong@mediatek.com>
 <20230320102838.8313-4-yunfei.dong@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230320102838.8313-4-yunfei.dong@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 20/03/23 11:28, Yunfei Dong ha scritto:
> In oder to get each instance information according to test command, adding
> one file node "vdec".
> 
> Can use echo command to set different string value as 'echo -picinfo > vdec'
> to get real and aligned resolution.
> 
> Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>
> ---
>   .../mediatek/vcodec/mtk_vcodec_dbgfs.c        | 85 +++++++++++++++++++
>   .../mediatek/vcodec/mtk_vcodec_dbgfs.h        | 20 +++++
>   .../mediatek/vcodec/mtk_vcodec_dec_drv.c      |  2 +
>   3 files changed, 107 insertions(+)
> 
> diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dbgfs.c b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dbgfs.c
> index bef78c028a75..9e7d57d21cea 100644
> --- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dbgfs.c
> +++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dbgfs.c
> @@ -10,6 +10,86 @@
>   #include "mtk_vcodec_drv.h"
>   #include "mtk_vcodec_util.h"
>   
> +static ssize_t mtk_vdec_dbgfs_write(struct file *filp, const char __user *ubuf,
> +				    size_t count, loff_t *ppos)
> +{
> +	struct mtk_vcodec_dev *vcodec_dev = filp->private_data;
> +	char buf[32] = { 0 };
> +	int len, str_count = 0;
> +	struct mtk_vcodec_dbgfs_inst *dbgfs_inst;
> +	struct mtk_vcodec_ctx *ctx;
> +
> +	len = simple_write_to_buffer(buf, sizeof(buf) - 1, ppos, ubuf, count);
> +	if (len <= 0)
> +		return len;
> +
> +	list_for_each_entry(dbgfs_inst, &vcodec_dev->dbgfs.dbgfs_head, node) {
> +		pr_info("dbgfs_inst id: %d\n", dbgfs_inst->inst_id);
> +		ctx = dbgfs_inst->vcodec_ctx;
> +
> +		if (strstr(buf, "-picinfo")) {
> +			str_count++;
> +			pr_info("resolution: real(%dx%d)=>align(%dx%d)\n",
> +				ctx->picinfo.pic_w, ctx->picinfo.pic_h,
> +				ctx->picinfo.buf_w, ctx->picinfo.buf_h);

If you want to use debugfs (which is a good choice!), you should use debugfs!
This means that you shouldn't print this kind of information to the kernel,
but rather to a debugfs entry.

Example:

$ echo "-picinfo" > vdec
$ cat vdec

resolution: real(1024x768)=>align(something)

This is the same for all of the commits of this series, so, please properly
use debugfs.


Regards,
Angelo

