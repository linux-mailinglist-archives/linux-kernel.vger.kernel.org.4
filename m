Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C96D6552D3
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 17:28:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231913AbiLWQ2X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 11:28:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231889AbiLWQ2U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 11:28:20 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28D5B11A15
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 08:28:17 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id f16so5515923ljc.8
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 08:28:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vanguardiasur-com-ar.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4N34Q6vegmizYVH/tay3YsZhocDkMZUURFeC6HW8OZY=;
        b=26oprJ2ySY43mmV/tXV+KTU60nkGFIzDG3APBYN9J7MEhdLnpDrnO5HG6WFMBpBBgh
         qFu66TOEn+q+AhINcJOW7GKj+A63DO8IPA+U40QxUdt739fPp4ZY+5++iiVWHE0dGGdS
         t/FUX7GzA49xmUPahdQ/hA4sk1yMNwS3FkBtAQ2rR5Ce8A9e88Z+iotx4hK6U4naZJpV
         3p02qf4nExBet0Qciw3epPpAylNQyalQcrY0Uzz+2IxvZEW8v50GZBZazI+TUbQ/CyZK
         pL+7xggp/WZXVwUFX4/SOCKIVje8q6CdATw1oQtY/XRMLK4dPrZhfQKJTzxUZPo4N1EK
         MF6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4N34Q6vegmizYVH/tay3YsZhocDkMZUURFeC6HW8OZY=;
        b=B13JO6x2WBIjt2fvqjX+dNRJ/eQfsyRSTTszckJq2CQfAhEatDM+rnkNzJHfF5UYcf
         RGa3iAF19A7wp+WCBf4iCcJk4z2gleQA4QGBWOOSbyqyiTCdN7hOcRJ1uCn1I/K21n6U
         q0jT4Y1aFf54wWfnXF5+t2y7b2I2/nejEGZeES0VkDvpas5u4hB6iR+KI9d/TkbOUe2h
         ctlgOAQJfteObe/K5UoVCVmsa7LuX1uKS41Dr3Fm/VEfdBPQlpNjsE8t97Ug+eM546rk
         eC0OyTEWTCHToV7OX3LZcAoO154pByzRWY3olIIi69bTd8dXMa70KP281pwnWDCd/oKq
         SLrQ==
X-Gm-Message-State: AFqh2kotfiX2pq1yJ/1gVwGg5LGJZ5M6cRfzPWhQ9mYRxFjy2lURYEDb
        TlPWwRFEbWnqvxF54y4HueR516T4/sTVProXa5481waXIN8KP92q
X-Google-Smtp-Source: AMrXdXvQ8xwiu63+L+V5Pqox9KrVgec2uYlBwfbs7NXCEyiSJ2RgwpcbUS+Ja1/4Uxtq1XDBtLjCEFylce8Mp/a5INs=
X-Received: by 2002:a2e:7016:0:b0:27a:306:5dfd with SMTP id
 l22-20020a2e7016000000b0027a03065dfdmr741643ljc.72.1671812895550; Fri, 23 Dec
 2022 08:28:15 -0800 (PST)
MIME-Version: 1.0
References: <20221223141644.703088-1-nicolas.dufresne@collabora.com>
In-Reply-To: <20221223141644.703088-1-nicolas.dufresne@collabora.com>
From:   Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Date:   Fri, 23 Dec 2022 13:28:03 -0300
Message-ID: <CAAEAJfATk+jOq3qt-m2CZEbCVumHHWDFfuEXKA7k0NZQXajCRg@mail.gmail.com>
Subject: Re: [PATCH] hantro: Fix JPEG encoder ENUM_FRAMESIZE on RK3399
To:     Nicolas Dufresne <nicolas.dufresne@collabora.com>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>, kernel@collabora.com,
        Robert Mader <robert.mader@collabora.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone,

On Fri, Dec 23, 2022 at 11:17 AM Nicolas Dufresne
<nicolas.dufresne@collabora.com> wrote:
>
> The frmsize structure was left initialize to 0, as side effect, the driver was
> reporting an invalid frmsize.
>
>   Size: Stepwise 0x0 - 0x0 with step 0/0
>
> Fix this by replicating the constraints in the raw formats too. This fixes
> taking picture in Gnome Cheese Software, or any software using GSteamer
> encodebin feature.
>
> Fixes: 775fec69008d30 ("media: add Rockchip VPU JPEG encoder driver")

The frmsize is only for bitstream formats (see comment in struct hantro_fmt).
If I can read code correctly, this was broken by this commit:

commit 79c987de8b35421a2a975982929f150dd415f8f7
Author: Benjamin Gaignard <benjamin.gaignard@collabora.com>
Date:   Mon Apr 4 18:06:40 2022 +0200

    media: hantro: Use post processor scaling capacities

Before that commit we used to return EINVAL for enum_framesizes
in RAW formats. I guess we missed that :-)

To be completely honest, I'm not sure if we used to support encodebin,
and I'm not too sure how to approach this issue, but I would really
love to start with something super simple like:

diff --git a/drivers/media/platform/verisilicon/hantro_v4l2.c
b/drivers/media/platform/verisilicon/hantro_v4l2.c
index 2c7a805289e7..0b28f86b7463 100644
--- a/drivers/media/platform/verisilicon/hantro_v4l2.c
+++ b/drivers/media/platform/verisilicon/hantro_v4l2.c
@@ -161,8 +161,11 @@ static int vidioc_enum_framesizes(struct file
*file, void *priv,
        }

        /* For non-coded formats check if postprocessing scaling is possible */
-       if (fmt->codec_mode == HANTRO_MODE_NONE &&
hantro_needs_postproc(ctx, fmt)) {
-               return hanto_postproc_enum_framesizes(ctx, fsize);
+       if (fmt->codec_mode == HANTRO_MODE_NONE)
+        if (hantro_needs_postproc(ctx, fmt))
+            return hanto_postproc_enum_framesizes(ctx, fsize);
+        else
+            return -ENOTTY;
        } else if (fsize->index != 0) {
                vpu_debug(0, "invalid frame size index (expected 0, got %d)\n",
                          fsize->index);

(ENOTTY was suggested by Nicolas on IRC)

Nicolas also pointed out that our current handling of frmsize is not correct,
as we cannot express different constraints on combinations of RAW
and bitstream formats.

This seems to call for a rework of enum_framesizes, so frmsize
is not static but somehow obtained per-codec.

Thanks,
Ezequiel

> Reported-by: Robert Mader <robert.mader@collabora.com>
> Signed-off-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>

And thanks a lot for the report and the patch!
