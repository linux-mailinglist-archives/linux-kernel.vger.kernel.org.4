Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8CC56028D2
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 11:55:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230045AbiJRJzy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 05:55:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbiJRJzu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 05:55:50 -0400
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com [IPv6:2607:f8b0:4864:20::e2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07869B0B1E
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 02:55:49 -0700 (PDT)
Received: by mail-vs1-xe2b.google.com with SMTP id p7so14159674vsr.7
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 02:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fHxePj/mZk3CsytYYPoDZH/iNdYUG/Ul5xfu8zN39CE=;
        b=OYyvIRNLbIXwMu8B/GP88pxXrBL1rTVN9OKaaVp/yCjYwxp2DiR8uf2cHv99SQhhbP
         ovobN81Sc9Ab+x8TgvH+gt2GR5hbwNAMQg0nTIJtF0QSR75P6jA1F51PqRneDvCrwdWr
         eSLd9+3CKgZGM+8HyndN0MCQ3By0MhOjASV9Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fHxePj/mZk3CsytYYPoDZH/iNdYUG/Ul5xfu8zN39CE=;
        b=TO1bINICpc/djWh3uLw5LSUWTn08ugdjhcIA9OH+5LS3iClocSvBBaACebLnE9Fbc5
         EcugW8cN4dP2Bxj3nx86pix2YZoDXT64BCriKNBK232WnrTAywrgKvsZLwHBayE79fFi
         UsaU1GUHatWoHsjsEnU4HNZRQVODAdyKgA8//0H8cbzG7Tq97BCnyq7FEnBmG/3q4WU3
         Jmw40Be4/mwcxRu4j61xjjD/bPkMOB0LO514dKFUR/9XFN2URGmvldxkNBw3F5g9ySAQ
         2ZO9M/eiV2ga/J+IGWmsQ9A4jKfqRz0SLOQFPaleukh88s4FwPlYPRwqJNem4Pi+7aLH
         xTdQ==
X-Gm-Message-State: ACrzQf0oZZP7/J7VMvqyuBFsaLVDYnaXQ+dhLmTQth9d1c0TqGXM0dXl
        EPoIdxyRtXxIhJqS0tFd90GYKd7uSiY5txxdadMCiw==
X-Google-Smtp-Source: AMsMyM6GgD/Ll61bSvxwgEJyCP26sucK9tDFdq9CCdZxSHx2TzvQOlTTAReK+eEoO6lxWQgVsRzgtN68ZiTGLSBKSFA=
X-Received: by 2002:a67:f684:0:b0:392:ac17:f9b0 with SMTP id
 n4-20020a67f684000000b00392ac17f9b0mr926868vso.85.1666086948130; Tue, 18 Oct
 2022 02:55:48 -0700 (PDT)
MIME-Version: 1.0
References: <20221017090208.19041-1-yunfei.dong@mediatek.com>
In-Reply-To: <20221017090208.19041-1-yunfei.dong@mediatek.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Tue, 18 Oct 2022 17:55:36 +0800
Message-ID: <CAGXv+5G5Lr6rCB0D+q9egRFmhAzpGL49dNrQeCT8JpeUT+OiAA@mail.gmail.com>
Subject: Re: [PATCH] media: mediatek: vcodec: fix h264 cavlc bitstream fail
To:     Yunfei Dong <yunfei.dong@mediatek.com>
Cc:     Nicolas Dufresne <nicolas@ndufresne.ca>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        George Sun <george.sun@mediatek.com>,
        Xiaoyong Lu <xiaoyong.lu@mediatek.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Fritz Koenig <frkoenig@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Steve Cho <stevecho@chromium.org>, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 17, 2022 at 5:02 PM Yunfei Dong <yunfei.dong@mediatek.com> wrote:
>
> Some cavlc bistream will decode fail when the frame size is small than
> 20 bytes. Need to add pending data at the end of the bitstream.

"magic terminating pattern" instead of "pending data"?

> For the size of mapped memory is at least one page, adding four bytes data
> won't lead to access unknown virtual memory.

Actually we can narrow this down a bit. The minimum dimension (16x16)
sets the minimum size of the buffer at 256 bytes.

> Fixes: 59fba9eed5a7 ("media: mediatek: vcodec: support stateless H.264 decoding for mt8192")
> Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>
> ---
>  .../vcodec/vdec/vdec_h264_req_multi_if.c      | 27 ++++++++++++++++---
>  1 file changed, 24 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_req_multi_if.c b/drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_req_multi_if.c
> index 4cc92700692b..c1583dddcb04 100644
> --- a/drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_req_multi_if.c
> +++ b/drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_req_multi_if.c
> @@ -539,6 +539,24 @@ static int vdec_h264_slice_core_decode(struct vdec_lat_buf *lat_buf)
>         return 0;
>  }
>
> +static void vdec_h264_insert_startcode(struct mtk_vcodec_dev *vcodec_dev, unsigned char *buf,
> +                                      size_t *bs_size, struct mtk_h264_pps_param *pps)
> +{
> +       struct device *dev = &vcodec_dev->plat_dev->dev;
> +
> +       /* cavlc bitstream when entropy_coding_mode_flag is false. */
> +       if (pps->entropy_coding_mode_flag || *bs_size > 20 ||
> +           !(of_device_is_compatible(dev->of_node, "mediatek,mt8192-vcodec-dec") ||
> +           of_device_is_compatible(dev->of_node, "mediatek,mt8195-vcodec-dec")))
> +               return;
> +

There should be a comment here describing what is added.


ChenYu

> +       buf[*bs_size] = 0;
> +       buf[*bs_size + 1] = 0;
> +       buf[*bs_size + 2] = 1;
> +       buf[*bs_size + 3] = 0xff;
> +       (*bs_size) += 4;
> +}
> +
>  static int vdec_h264_slice_lat_decode(void *h_vdec, struct mtk_vcodec_mem *bs,
>                                       struct vdec_fb *fb, bool *res_chg)
>  {
> @@ -582,9 +600,6 @@ static int vdec_h264_slice_lat_decode(void *h_vdec, struct mtk_vcodec_mem *bs,
>         }
>
>         inst->vsi->dec.nal_info = buf[nal_start_idx];
> -       inst->vsi->dec.bs_buf_addr = (u64)bs->dma_addr;
> -       inst->vsi->dec.bs_buf_size = bs->size;
> -
>         lat_buf->src_buf_req = src_buf_info->m2m_buf.vb.vb2_buf.req_obj.req;
>         v4l2_m2m_buf_copy_metadata(&src_buf_info->m2m_buf.vb, &lat_buf->ts_info, true);
>
> @@ -592,6 +607,12 @@ static int vdec_h264_slice_lat_decode(void *h_vdec, struct mtk_vcodec_mem *bs,
>         if (err)
>                 goto err_free_fb_out;
>
> +       vdec_h264_insert_startcode(inst->ctx->dev, buf, &bs->size,
> +                                  &share_info->h264_slice_params.pps);
> +
> +       inst->vsi->dec.bs_buf_addr = (uint64_t)bs->dma_addr;
> +       inst->vsi->dec.bs_buf_size = bs->size;
> +
>         *res_chg = inst->resolution_changed;
>         if (inst->resolution_changed) {
>                 mtk_vcodec_debug(inst, "- resolution changed -");
> --
> 2.25.1
>
