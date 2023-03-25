Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFC416C8C22
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 08:14:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231501AbjCYHOw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Mar 2023 03:14:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232109AbjCYHOn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Mar 2023 03:14:43 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E50D84ED8;
        Sat, 25 Mar 2023 00:14:42 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id ek18so16106844edb.6;
        Sat, 25 Mar 2023 00:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679728481;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tKSigRHH+PS1fXr6YtfPL0lgeDwBUnudMTVAS6GkLQA=;
        b=iad1hEloIeNWTkeC7J3lNjpD3n3CrQROpyL59K1nwy53c3XvO2utqbKhsiRxIbfygw
         q89h6R8+TUn6imm2/erN2rRB4rc/7Efp/eMygldgyfD4X+hrMINbDaWkBXf/bieshJ+Y
         UzLkakckWt5RvcDAeAPAuUVFFq23Ka5Y0LTsZRhnbCIuFN18x03lDPkbOQ7B4jqeeso+
         gGabt4Ob/AFF5+/D4lEyHiu94xPeioaevJNcCdVViD9Le+3RDprA4FarEtnkIBg1SPem
         LJEHRf/lOX2LPThvu78vCRDwQWIctyJjtspCeTUbNzj8aM09X6u53u1pmc4gBn+i0PQ/
         gQTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679728481;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tKSigRHH+PS1fXr6YtfPL0lgeDwBUnudMTVAS6GkLQA=;
        b=Lhi9JLUQRxtZ6w9kN7xehIXMwN4uYkKBu9Ipjjh53e0LLMOhLzQBn6YVWDE75IzBnB
         mofOW3aOAfWd0sIA5ajjgDvMsFihbwMEnsle21T3gspvM7gBazwrVwD1CQH8m46xAQsx
         O+LtGJWBXbkYFttIykUYX+btQ990RG+4InAfPim4tZjMjbVBYX2ANhGLZ36vnDihGsn4
         bUqeji6Xc6FSv9dRQbiUL702WwgrFcmO3hhOmmBy6ASmLVWPK48v/XLiTFrrbM1dn1/j
         PEZ8Xqon8D3UNWZXuJvPPqG12hGnQoFCn7ZYibDbLElT6houswUBAn4NsXTNyhBZ6Wgn
         ofvg==
X-Gm-Message-State: AO0yUKX1oO8GlWuOghZbse3UjDV8O0EsOfcSwUO4FbBH9we5jwj/FIwR
        HEWOJalCxyzWlFbDIZ991nOiILNzR94=
X-Google-Smtp-Source: AK7set8uTpTaUFXnqv8P2EaUXEm89ZCDBdhR1oDYkEehQSByi6yexPuTTUhvxT/8GXRy4pfLDtjB9Q==
X-Received: by 2002:a05:6402:b8c:b0:4b6:821e:1859 with SMTP id cf12-20020a0564020b8c00b004b6821e1859mr11650958edb.7.1679728481194;
        Sat, 25 Mar 2023 00:14:41 -0700 (PDT)
Received: from kista.localnet (82-149-1-233.dynamic.telemach.net. [82.149.1.233])
        by smtp.gmail.com with ESMTPSA id s12-20020a50d48c000000b005023aaf52desm58357edi.95.2023.03.25.00.14.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Mar 2023 00:14:40 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Adam Pigg <adam@piggz.co.uk>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 8/9] media: sun6i-isp: capture: Implement MC I/O with extended
 enum_fmt
Date:   Sat, 25 Mar 2023 08:14:39 +0100
Message-ID: <1923234.PYKUYFuaPT@kista>
In-Reply-To: <20230324151228.2778112-9-paul.kocialkowski@bootlin.com>
References: <20230324151228.2778112-1-paul.kocialkowski@bootlin.com>
 <20230324151228.2778112-9-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne petek, 24. marec 2023 ob 16:12:27 CET je Paul Kocialkowski napisal(a):
> This driver needs the media-controller API to operate and should not be
> considered as a video-device-centric implementation.
> 
> Properly report the IO_MC device cap and extend the enum_fmt
> implementation to support enumeration with an explicit mbus_code.
> 
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> ---
>  .../staging/media/sunxi/sun6i-isp/sun6i_isp_capture.c    | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/media/sunxi/sun6i-isp/sun6i_isp_capture.c b/drivers/staging/media/sunxi/sun6i-isp/sun6i_isp_capture.c
> index 1595a9607775..5160b93b69ff 100644
> --- a/drivers/staging/media/sunxi/sun6i-isp/sun6i_isp_capture.c
> +++ b/drivers/staging/media/sunxi/sun6i-isp/sun6i_isp_capture.c
> @@ -439,6 +439,12 @@ static int sun6i_isp_capture_enum_fmt(struct file *file, void *private,
>  				      struct v4l2_fmtdesc *fmtdesc)
>  {
>  	u32 index = fmtdesc->index;
> +	u32 mbus_code = fmtdesc->mbus_code;

Nit: reverse christmas tree

Other than that:
Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej

> +
> +	if (mbus_code && !sun6i_isp_proc_format_find(mbus_code))
> +		return -EINVAL;
> +
> +	/* Capture format is independent from proc format. */
>  
>  	if (index >= ARRAY_SIZE(sun6i_isp_capture_formats))
>  		return -EINVAL;
> @@ -685,7 +691,8 @@ int sun6i_isp_capture_setup(struct sun6i_isp_device *isp_dev)
>  
>  	strscpy(video_dev->name, SUN6I_ISP_CAPTURE_NAME,
>  		sizeof(video_dev->name));
> -	video_dev->device_caps = V4L2_CAP_VIDEO_CAPTURE | V4L2_CAP_STREAMING;
> +	video_dev->device_caps = V4L2_CAP_VIDEO_CAPTURE | V4L2_CAP_STREAMING |
> +				 V4L2_CAP_IO_MC;
>  	video_dev->vfl_dir = VFL_DIR_RX;
>  	video_dev->release = video_device_release_empty;
>  	video_dev->fops = &sun6i_isp_capture_fops;
> -- 
> 2.39.2
> 
> 


