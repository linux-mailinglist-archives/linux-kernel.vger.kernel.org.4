Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C1336C4A05
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 13:12:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230141AbjCVMMh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 08:12:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjCVMMe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 08:12:34 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33BEB5FE92;
        Wed, 22 Mar 2023 05:12:33 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 206D56602082;
        Wed, 22 Mar 2023 12:12:31 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1679487152;
        bh=9doOzJyd9fFmX+9Yoaki4COv1r9LdIU7GBsQjNllgtE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=E27CT/55MjVU2wSRf8vkTCAhya+qZWo7nYmKjg18K7LU7da0VOxhwaI7BALV58VcB
         oYcJDlD47cSxVDlGOjr7g7q8fzrsXhrgURcmZAdKoqBnu8Yd5s0jLHSzVxJv2y/Gue
         SQqW8OeGpAF5nL0icXU+POmVhXRGdM4Bu+RyZF7qyOzjXqtL2o6wL7orynUKQtMtgv
         EgVbj/3JBTH8bw2W2GfviI0/SH/bozQtxkTFc/0b7EQwVzKQi3Ow2oxTAtqq2lQx2L
         yYkd/SYQKkCJgsb/oKisC7WlKiGGkbUE0qdK/V372X9x4MQ61DD7m5MzeOMVIOSBBd
         A2M9A0mCVrckg==
Message-ID: <94b128b7-e492-f704-71b6-87fd156646be@collabora.com>
Date:   Wed, 22 Mar 2023 13:12:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2,3/7] media: mediatek: vcodec: Add a debugfs file to get
 different useful information
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
References: <20230322094617.19410-1-yunfei.dong@mediatek.com>
 <20230322094617.19410-4-yunfei.dong@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230322094617.19410-4-yunfei.dong@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 22/03/23 10:46, Yunfei Dong ha scritto:
> In oder to get each instance information according to test command, adding
> one file node "vdec".
> 
> Can use echo command to set different string value as 'echo -picinfo > vdec'.
> 
> Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>
> ---
>   .../mediatek/vcodec/mtk_vcodec_dbgfs.c        | 64 +++++++++++++++++++
>   .../mediatek/vcodec/mtk_vcodec_dbgfs.h        | 32 ++++++++++
>   .../mediatek/vcodec/mtk_vcodec_dec_drv.c      |  2 +
>   3 files changed, 98 insertions(+)
> 

> diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dbgfs.h b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dbgfs.h
> index 5eec2211cbbe..47c0a986877d 100644
> --- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dbgfs.h
> +++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dbgfs.h
> @@ -8,19 +8,51 @@
>   #define __MTK_VCODEC_DBGFS_H__
>   
>   struct mtk_vcodec_dev;
> +struct mtk_vcodec_ctx;
> +
> +/**
> + * struct mtk_vcodec_dbgfs_inst  - debugfs informatiaoin for each inst

There's a typo: "information"

> + * @node: list node for each inst
> + * @vcodec_ctx: struct mtk_vcodec_ctx
> + * @inst_id: index of the context that the same with ctx->id
> + */
> +struct mtk_vcodec_dbgfs_inst {
> +	struct list_head node;
> +	struct mtk_vcodec_ctx *vcodec_ctx;
> +	int inst_id;
> +};
>   
>   /**
>    * struct mtk_vcodec_dbgfs  - dbgfs information
> + * @dbgfs_head: list head used to link each instance
>    * @vcodec_root: vcodec dbgfs entry
> + * @dbgfs_lock: dbgfs lock used to protect dbgfs_buf
> + * @dbgfs_buf: dbgfs buf used to store dbgfs cmd
> + * @inst_count: the count of total instance
>    */
>   struct mtk_vcodec_dbgfs {
> +	struct list_head dbgfs_head;
>   	struct dentry *vcodec_root;
> +	/* dbgfs lock used to protect dbgfs_buf */

This comment is duplicated, you're already documenting it in kerneldoc above! :-)

> +	struct mutex dbgfs_lock;
> +	char dbgfs_buf[1024];
> +	int inst_count;
>   };
>   

Regards,
Angelo

