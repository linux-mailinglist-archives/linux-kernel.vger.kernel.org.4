Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53E67655ACB
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Dec 2022 18:03:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231317AbiLXRDl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Dec 2022 12:03:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbiLXRDh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Dec 2022 12:03:37 -0500
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5C3919F
        for <linux-kernel@vger.kernel.org>; Sat, 24 Dec 2022 09:03:33 -0800 (PST)
Received: by mail-ot1-x32e.google.com with SMTP id q18-20020a056830441200b006704633f258so4521877otv.0
        for <linux-kernel@vger.kernel.org>; Sat, 24 Dec 2022 09:03:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vanguardiasur-com-ar.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xDlIxtzFcin724wRP1TAXrvd23TGKko3POM23PcIaBI=;
        b=z1KWdGBZC89gZpYSCRr1oZkEt8jV+HfKDyk8FypwZ5NTFMIln9Yl9nv4DhkuxSIJZx
         sMclWkPGni/eoSbKlLt/uUPM/MQDF1t6ahZs91Xi8vSA+q2dTjUHOTDvt5Fm25gGzwt1
         sA2vjgwIUYYrgMLa7d6b8BAN5iHM8CEvv3D4Ss5Tr0LVr9ZUSeFL/CPV9ssg3B7f3B5J
         5Jxqw4gyk08cyx84CBEaLgfUjY9UuPOnSgpiVyQnRU0jPPxGvkYhcgnHoIAu06fOB05R
         7xeXCSH8ja56+FbkBVJF/wDI/lIs8pkttD2Hy5UM6/0CxYpL6YhTyzgueJevhEvhEcZ8
         aFLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xDlIxtzFcin724wRP1TAXrvd23TGKko3POM23PcIaBI=;
        b=GhxwHl5oCWUm2ttCgVg3iy2pG7907npoUiP9YeaKvsLicPSDOuiq20E4HvwwEwy6ag
         ve/n03ZGyCQ6Zn1xF6zp6SL4uH0KvAuRuiuEfj18SdiQ4m2QPr5LPTDvmjY5hBG13NuT
         PaxVnIs7IOiD/Y+2a8/4fKF4f0MGyDWc7AUpUpE0u53SYymkdUbmC+Mpvwe7ZzHFve2p
         eaprDVMqba3L85N1PAm5BWnIfzfPnvr0ZUGUB3m3ejobIb7XleMgs7TJiGZnbLngqLIr
         oe6B+xtV/UuzceHST9HshCfjV70PcE3/7tMGmibk1GSW+znFoCBVxI4ikUB5BTuUWOJL
         yUbw==
X-Gm-Message-State: AFqh2koSyK5D1CndYYCFZWg7klj4Kr/lIrQQbas6SvzQW46WiX9njxD6
        irwc/HB2vx3TzJYXzNw/hRFqNg==
X-Google-Smtp-Source: AMrXdXvR9oTlcOMyZG0PSyHKf68zvuLkUYdRRGXmxCKna6gl2HjlGFAb/VNsEKBf/P6+4dUZANgRnw==
X-Received: by 2002:a9d:6004:0:b0:66e:ab28:cced with SMTP id h4-20020a9d6004000000b0066eab28ccedmr11631750otj.13.1671901413027;
        Sat, 24 Dec 2022 09:03:33 -0800 (PST)
Received: from eze-laptop ([190.11.62.130])
        by smtp.gmail.com with ESMTPSA id w2-20020a9d6382000000b00670679748f9sm3221172otk.49.2022.12.24.09.03.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Dec 2022 09:03:31 -0800 (PST)
Date:   Sat, 24 Dec 2022 14:03:25 -0300
From:   Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
To:     Benjamin Gaignard <benjamin.gaignard@collabora.com>
Cc:     Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>, kernel@collabora.com,
        Robert Mader <robert.mader@collabora.com>,
        linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] hantro: Fix JPEG encoder ENUM_FRMSIZE on RK3399
Message-ID: <Y6cw3dU8Ku2+aL9y@eze-laptop>
References: <20221223181647.720918-1-nicolas.dufresne@collabora.com>
 <8d13ffb9-74cb-00f9-072a-0614e341e1ef@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8d13ffb9-74cb-00f9-072a-0614e341e1ef@collabora.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 24, 2022 at 09:03:59AM +0100, Benjamin Gaignard wrote:
> 
> Le 23/12/2022 à 19:16, Nicolas Dufresne a écrit :
> > Since 79c987de8b354, enumerating framesize on format set with "MODE_NONE"
> > (any raw formats) is reporting an invalid frmsize.
> > 
> >    Size: Stepwise 0x0 - 0x0 with step 0/0
> > 
> > Before this change, the driver would return EINVAL, which is also invalid but
> > worked in GStreamer. The original intent was not to implement it, hence the
> > -ENOTTY return in this change. While drivers should implement ENUM_FRMSIZE for
> > all formats and queues, this change is limited in scope to fix the regression.
> > 
> > This fixes taking picture in Gnome Cheese software, or any software using
> > GSteamer to encode JPEG with hardware acceleration.
> > 
> > Fixes: 79c987de8b354 ("media: hantro: Use post processor scaling capacities")
> > Reported-by: Robert Mader <robert.mader@collabora.com>
> > Signed-off-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
> 
> Reviewed-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
> 

Reviewed-by: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>

Thanks,
Ezequiel

> > ---
> >   drivers/media/platform/verisilicon/hantro_v4l2.c | 7 +++++--
> >   1 file changed, 5 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/media/platform/verisilicon/hantro_v4l2.c b/drivers/media/platform/verisilicon/hantro_v4l2.c
> > index 2c7a805289e7b..30e650edaea8a 100644
> > --- a/drivers/media/platform/verisilicon/hantro_v4l2.c
> > +++ b/drivers/media/platform/verisilicon/hantro_v4l2.c
> > @@ -161,8 +161,11 @@ static int vidioc_enum_framesizes(struct file *file, void *priv,
> >   	}
> >   	/* For non-coded formats check if postprocessing scaling is possible */
> > -	if (fmt->codec_mode == HANTRO_MODE_NONE && hantro_needs_postproc(ctx, fmt)) {
> > -		return hanto_postproc_enum_framesizes(ctx, fsize);
> > +	if (fmt->codec_mode == HANTRO_MODE_NONE) {
> > +		if (hantro_needs_postproc(ctx, fmt))
> > +			return hanto_postproc_enum_framesizes(ctx, fsize);
> > +		else
> > +			return -ENOTTY;
> >   	} else if (fsize->index != 0) {
> >   		vpu_debug(0, "invalid frame size index (expected 0, got %d)\n",
> >   			  fsize->index);
