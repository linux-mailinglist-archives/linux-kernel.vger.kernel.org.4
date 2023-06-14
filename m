Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D0527304D7
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 18:24:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233199AbjFNQYM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 12:24:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbjFNQYK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 12:24:10 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09E28ED
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 09:24:08 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id af79cd13be357-75d5051fad3so225230585a.3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 09:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1686759847; x=1689351847;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qDOHQI8bWafZ1bNMq81NOk5r9CB0D7gMPZXAIEA5R7o=;
        b=WdiRsHNlI+Fu3JtDCQm15d4yPmVYL+8VhHpUV6nnn0S2HvWTYsV4DO2PjgSg1LkVEh
         K/3ihDzdsRCdNumVLNESn4rYZeB33/hpQwEofhUiGWmxSqVLMWXr4nmlZv5ufOB9Dd7d
         3hY2rSL93S5jnZPFO3WmwJcFp9FP7i+6qndkw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686759847; x=1689351847;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qDOHQI8bWafZ1bNMq81NOk5r9CB0D7gMPZXAIEA5R7o=;
        b=H3w7PEepczkrbYb44lWLZzmFIhiZp78cJAgqN3iR7d+rvfXdDqDMfswhJWMbmBvdX8
         h95a8EEdvDEIzaFxrPh12uyO7aXayWDFXQhTw9MQ8ceyJJVRhjwRt3FVrMSVc3k/vCqr
         I+ROPiQF4/w8+H2buczT0hHls3mMXsUoT2cw0FY00UzmI/fGJLyoe9ipVS1KYVwsMdEy
         AtfQ5x6vJ0IZgBH+Zpd2WBw+nhaFHd2dDZLhUKe4TMw3OgevPkAh0pdIFY8eLWQ+RiLG
         jHYooKVYdgxtfEy7tsaJ0X5lynaolu27R9IsFA5GvLntnbyNXAWlPIvfomE3l8XV3lUE
         EqGw==
X-Gm-Message-State: AC+VfDwD3pDd+fTs65sYJBOVtujvO9egTsGpDrIP1j2yD2MdqB1U7lrO
        7DML3Rf2PvtmzlN4lCKDbmLV4CKs8fTk2/smPTO+qg==
X-Google-Smtp-Source: ACHHUZ7uHWml6xAfmVf+f3BOqpSPM/LYA/UKTkIoP31VNljxT+w66KcpjSvBsgLOSCmxcA+OinxJkg==
X-Received: by 2002:a05:620a:2694:b0:75e:9967:4007 with SMTP id c20-20020a05620a269400b0075e99674007mr16867009qkp.3.1686759847094;
        Wed, 14 Jun 2023 09:24:07 -0700 (PDT)
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com. [209.85.160.181])
        by smtp.gmail.com with ESMTPSA id m17-20020ae9e011000000b0075b0c1f4ad6sm4444726qkk.0.2023.06.14.09.24.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Jun 2023 09:24:04 -0700 (PDT)
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-3f9e5c011cfso20727881cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 09:24:04 -0700 (PDT)
X-Received: by 2002:a05:622a:1902:b0:3f5:c9f:1b27 with SMTP id
 w2-20020a05622a190200b003f50c9f1b27mr3883593qtc.1.1686759844040; Wed, 14 Jun
 2023 09:24:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230328092608.523933-1-harperchen1110@gmail.com>
In-Reply-To: <20230328092608.523933-1-harperchen1110@gmail.com>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Thu, 15 Jun 2023 01:23:52 +0900
X-Gmail-Original-Message-ID: <CAAFQd5CqhZgtCJ_-6M0=dYAfVs0TFeBjPURvosS_24qgour=Ow@mail.gmail.com>
Message-ID: <CAAFQd5CqhZgtCJ_-6M0=dYAfVs0TFeBjPURvosS_24qgour=Ow@mail.gmail.com>
Subject: Re: [PATCH] media: vcodec: Fix potential array out-of-bounds in vb2ops_venc_queue_setup
To:     Wei Chen <harperchen1110@gmail.com>
Cc:     tiffany.lin@mediatek.com, andrew-ct.chen@mediatek.com,
        yunfei.dong@mediatek.com, mchehab@kernel.org,
        matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 28, 2023 at 6:26=E2=80=AFPM Wei Chen <harperchen1110@gmail.com>=
 wrote:
>
> variable *nplanes is provided by user via system call argument. The
> possible value of q_data->fmt->num_planes is 1-3, while the value
> of *nplanes can be 1-8. The array access by index i can cause array
> out-of-bounds.
>
> Fix this bug by checking *nplanes against the array size.
>
> Signed-off-by: Wei Chen <harperchen1110@gmail.com>
> ---
>  drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc.c b/dr=
ivers/media/platform/mediatek/vcodec/mtk_vcodec_enc.c
> index d65800a3b89d..1ea02f9136f6 100644
> --- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc.c
> +++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc.c
> @@ -821,6 +821,8 @@ static int vb2ops_venc_queue_setup(struct vb2_queue *=
vq,
>                 return -EINVAL;
>
>         if (*nplanes) {
> +               if (*nplanes !=3D q_data->fmt->num_planes)
> +                       return -EINVAL;
>                 for (i =3D 0; i < *nplanes; i++)
>                         if (sizes[i] < q_data->sizeimage[i])
>                                 return -EINVAL;
> --
> 2.25.1
>

Thanks for the patch, it makes sense indeed.

Reviewed-by: Tomasz Figa <tfiga@chromium.org>

Best regards,
Tomasz
