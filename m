Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 457486E41E3
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 10:02:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229669AbjDQICQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 04:02:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230128AbjDQIBt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 04:01:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2DAC46AB;
        Mon, 17 Apr 2023 01:01:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8194761408;
        Mon, 17 Apr 2023 08:01:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDF9EC433EF;
        Mon, 17 Apr 2023 08:01:30 +0000 (UTC)
Message-ID: <0341924c-7f0a-28aa-eeae-f7de69ab36d8@xs4all.nl>
Date:   Mon, 17 Apr 2023 10:01:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] media: mediatek: vcodec: Move a variable assignment
 behind condition checks in vdec_vp9_slice_single_decode()
Content-Language: en-US
To:     Markus Elfring <Markus.Elfring@web.de>,
        kernel-janitors@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Guo Zhengkui <guozhengkui@vivo.com>,
        Haowen Bai <baihaowen@meizu.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Mingjia Zhang <mingjia.zhang@mediatek.com>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Xiaoyong Lu <xiaoyong.lu@mediatek.com>,
        Yunfei Dong <yunfei.dong@mediatek.com>
Cc:     cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>
References: <40c60719-4bfe-b1a4-ead7-724b84637f55@web.de>
 <1a11455f-ab57-dce0-1677-6beb8492a257@web.de>
 <b98dcc94-13f3-a6cb-f5bd-f1f8644d87d1@web.de>
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
In-Reply-To: <b98dcc94-13f3-a6cb-f5bd-f1f8644d87d1@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/04/2023 20:30, Markus Elfring wrote:
> Date: Fri, 14 Apr 2023 20:07:01 +0200
> 
> The address of a data structure member was determined before
> a corresponding null pointer check in the implementation of
> the function “vdec_vp9_slice_single_decode”.
> 
> Thus avoid the risk for undefined behaviour by moving the assignment
> for the variable “pfc” behind some condition checks.
> 
> This issue was detected by using the Coccinelle software.
> 
> Fixes: b0f407c19648ae9110c932c91d6e1b9381ec0aeb ("media: mediatek: vcodec: add vp9 decoder driver for mt8186")

Not a fix, it was never broken.

> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  .../media/platform/mediatek/vcodec/vdec/vdec_vp9_req_lat_if.c  | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp9_req_lat_if.c b/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp9_req_lat_if.c
> index cf16cf2807f0..22b27f7b57bf 100644
> --- a/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp9_req_lat_if.c
> +++ b/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp9_req_lat_if.c
> @@ -1990,7 +1990,7 @@ static int vdec_vp9_slice_single_decode(void *h_vdec, struct mtk_vcodec_mem *bs,
>  					struct vdec_fb *fb, bool *res_chg)
>  {
>  	struct vdec_vp9_slice_instance *instance = h_vdec;

Just drop these lines instead:

        if (!instance || !instance->ctx)
                return -EINVAL;

That can never happen.

Regards,

	Hans

> -	struct vdec_vp9_slice_pfc *pfc = &instance->sc_pfc;
> +	struct vdec_vp9_slice_pfc *pfc;
>  	struct vdec_vp9_slice_vsi *vsi;
>  	struct mtk_vcodec_ctx *ctx;
>  	int ret;
> @@ -2007,6 +2007,7 @@ static int vdec_vp9_slice_single_decode(void *h_vdec, struct mtk_vcodec_mem *bs,
>  	if (!fb)
>  		return -EBUSY;
> 
> +	pfc = &instance->sc_pfc;
>  	vsi = &pfc->vsi;
> 
>  	ret = vdec_vp9_slice_setup_single(instance, bs, fb, pfc);
> --
> 2.40.0
> 

