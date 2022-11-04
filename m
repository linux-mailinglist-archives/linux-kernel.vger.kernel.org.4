Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 960B6619F79
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 19:11:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231634AbiKDSK7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 14:10:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbiKDSK4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 14:10:56 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90C613137F;
        Fri,  4 Nov 2022 11:10:55 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id y14so15318456ejd.9;
        Fri, 04 Nov 2022 11:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zI5Rfzsxc8rNV7iJcfSyH9aK8iAlVJHWFV6jyxPEIok=;
        b=hso72QBPITUbbmDTleVSZzhKAzH1N/pTXymcIBO8s2I23+psuEJGPHJfZwz4jtvXhV
         iwYCaHDYdJe7kYiqgKRRga4szZW9IfpF9avjaBsJzHIyASoMf7l+zl3FpjWtpf9Flr+Y
         0gMNBn/Jp4thIlhAt3qoSsgv0o0a5fUJSgUUwXMDaLih8ESneA6S784vbCEGsa4hcU1V
         FsXmcwZnXQVymAWTHDNppgdrNGcZQtfKjy3C0jn5wnLb7MIU2qDC8zIkh4bDkSP4E4IJ
         wIbR0PqzUGD+iEC6CvUKfuJ0Uvun6UAYkcUQ/bjE0BVbgIOZzsOlKRG/B1JT0Xplpfkn
         g+Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zI5Rfzsxc8rNV7iJcfSyH9aK8iAlVJHWFV6jyxPEIok=;
        b=WyZqnqEEYEO+RdpoE5DDpU5F4JEcUqYlZ7dmbl72NShATNKvmouijAbhRD0KTWojbq
         6yUg9iSbR1x+XQ1cpEwN3Tr1DEHWZ2K7cTegwskRB1gpcziyYQsXSCMtDFx5dpw79+F7
         LcGlic55kqHR4BT90r1/PYwwGfQFXsMHIIgDMnF6tUhOT/tNNPGcPyz0sHJihndvkUoU
         Njkb6sdSc5kdbCLwh+ovBz1SeSB0jgfgodlFPpn5fXJRf0hCHkBHgk7cyl87Kf93nS0h
         kqK047XlG9u/JmGSLMX1mGdpEvrRU+pUjUJZ4mlbQqASbsFM45R1hGgBkEDEjOY2IJlU
         54Ww==
X-Gm-Message-State: ACrzQf0OTwInZbG/yZc+A6M6YuLM9Ujrmte1dzb6rBOnRcNHCptVD2Yp
        dcsVaDKUEyCjU3u7tRGR91o=
X-Google-Smtp-Source: AMsMyM7thWyBYHE/ivRxLw9DZwILGgEJyeA4LgCqmhP078HXispIbQGy34uZRIqCeIXpq/OAQAQxrA==
X-Received: by 2002:a17:906:fe44:b0:77c:e313:a8e8 with SMTP id wz4-20020a170906fe4400b0077ce313a8e8mr36352481ejb.700.1667585454095;
        Fri, 04 Nov 2022 11:10:54 -0700 (PDT)
Received: from jernej-laptop.localnet (89-212-118-115.static.t-2.net. [89.212.118.115])
        by smtp.gmail.com with ESMTPSA id gh30-20020a1709073c1e00b007919ba4295esm2086563ejc.216.2022.11.04.11.10.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 11:10:53 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     mripard@kernel.org, paul.kocialkowski@bootlin.com,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     mchehab@kernel.org, gregkh@linuxfoundation.org, wens@csie.org,
        samuel@sholland.org, linux-media@vger.kernel.org,
        linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 10/11] media: cedrus: Adjust buffer size based on control values
Date:   Fri, 04 Nov 2022 19:10:52 +0100
Message-ID: <1908973.PYKUYFuaPT@jernej-laptop>
In-Reply-To: <76c3fc1b-e90f-748c-39ee-74be93fd6811@xs4all.nl>
References: <20221102180810.267252-1-jernej.skrabec@gmail.com> <20221102180810.267252-11-jernej.skrabec@gmail.com> <76c3fc1b-e90f-748c-39ee-74be93fd6811@xs4all.nl>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne petek, 04. november 2022 ob 16:27:29 CET je Hans Verkuil napisal(a):
> Hi Jernej,
> 
> On 02/11/2022 19:08, Jernej Skrabec wrote:
> > In some cases decoding engine needs extra space in capture buffers. This
> > is the case for decoding 10-bit HEVC frames into 8-bit capture format.
> > This commit only adds infrastructure for such cases.
> > 
> > Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
> > ---
> > 
> >  drivers/staging/media/sunxi/cedrus/cedrus.c       | 14 ++++++++++++++
> >  drivers/staging/media/sunxi/cedrus/cedrus.h       |  2 ++
> >  drivers/staging/media/sunxi/cedrus/cedrus_video.c |  4 ++++
> >  3 files changed, 20 insertions(+)
> > 
> > diff --git a/drivers/staging/media/sunxi/cedrus/cedrus.c
> > b/drivers/staging/media/sunxi/cedrus/cedrus.c index
> > 6a2c08928613..c36999e47591 100644
> > --- a/drivers/staging/media/sunxi/cedrus/cedrus.c
> > +++ b/drivers/staging/media/sunxi/cedrus/cedrus.c
> > @@ -68,8 +68,22 @@ static int cedrus_try_ctrl(struct v4l2_ctrl *ctrl)
> > 
> >  	return 0;
> >  
> >  }
> > 
> > +static int cedrus_s_ctrl(struct v4l2_ctrl *ctrl)
> > +{
> > +	struct cedrus_ctx *ctx = container_of(ctrl->handler,
> > +					      struct 
cedrus_ctx, hdl);
> > +	struct vb2_queue *vq = v4l2_m2m_get_vq(ctx->fh.m2m_ctx,
> > +					       
V4L2_BUF_TYPE_VIDEO_CAPTURE);
> > +
> > +	if (!vb2_is_busy(vq) && !vb2_is_streaming(vq))
> 
> You can drop the !vb2_is_streaming part. If you are streaming, then
> it will also be 'busy'.
> 
> > +		cedrus_reset_cap_format(ctx);
> 
> This is weird. I would expect that this is only called for specific
> controls, since presumably not all will change the sizeimage value. It
> looks like it applies only to V4L2_CID_STATELESS_HEVC_SPS, so I see no
> reason why you would call cedrus_reset_cap_format() for other controls as
> well.

It's more general approach. It's harmless for other cases, still within specs. 
Anyway, I can make it more specific.

> 
> And what happens if someone makes such a change *while streaming*?
> Shouldn't cedrus_try_ctrl detect that and fail with -EBUSY in that case?

SPS can also be changed during streaming, so we can't outright deny setting it 
during streaming. Also, if it changes from 10 to 8, that also works, since 
capture buffers are still big enough. Only change from 8 to 10 during streaming 
won't work and that check can be added.

> 
> Regardless, this is unexpected behavior, so some explanatory comments
> would be useful.
> 
> I'm also not sure whether it isn't better to add cedrus_s_ctrl in the next
> patch, I think it would be more understandable when seen with an actual
> control.

I guess I can move logic to cedrus_try_ctrl(), where some of this logic 
already exists and it would be just a little bit expanded and more selective.

Best regards,
Jernej

> 
> Regards,
> 
> 	Hans
> 
> > +
> > +	return 0;
> > +}
> > +
> > 
> >  static const struct v4l2_ctrl_ops cedrus_ctrl_ops = {
> >  
> >  	.try_ctrl = cedrus_try_ctrl,
> > 
> > +	.s_ctrl = cedrus_s_ctrl,
> > 
> >  };
> >  
> >  static const struct cedrus_control cedrus_controls[] = {
> > 
> > diff --git a/drivers/staging/media/sunxi/cedrus/cedrus.h
> > b/drivers/staging/media/sunxi/cedrus/cedrus.h index
> > 5904294f3108..774fe8048ce3 100644
> > --- a/drivers/staging/media/sunxi/cedrus/cedrus.h
> > +++ b/drivers/staging/media/sunxi/cedrus/cedrus.h
> > @@ -162,6 +162,8 @@ struct cedrus_dec_ops {
> > 
> >  	int (*start)(struct cedrus_ctx *ctx);
> >  	void (*stop)(struct cedrus_ctx *ctx);
> >  	void (*trigger)(struct cedrus_ctx *ctx);
> > 
> > +	unsigned int (*extra_cap_size)(struct cedrus_ctx *ctx,
> > +				       struct v4l2_pix_format 
*pix_fmt);
> > 
> >  };
> >  
> >  struct cedrus_variant {
> > 
> > diff --git a/drivers/staging/media/sunxi/cedrus/cedrus_video.c
> > b/drivers/staging/media/sunxi/cedrus/cedrus_video.c index
> > dec5d3ae4871..dc67940f1ade 100644
> > --- a/drivers/staging/media/sunxi/cedrus/cedrus_video.c
> > +++ b/drivers/staging/media/sunxi/cedrus/cedrus_video.c
> > @@ -250,6 +250,10 @@ static int cedrus_try_fmt_vid_cap_p(struct cedrus_ctx
> > *ctx,> 
> >  	pix_fmt->height = ctx->src_fmt.height;
> >  	cedrus_prepare_format(pix_fmt);
> > 
> > +	if (ctx->current_codec->extra_cap_size)
> > +		pix_fmt->sizeimage +=
> > +			ctx->current_codec->extra_cap_size(ctx, 
pix_fmt);
> > +
> > 
> >  	return 0;
> >  
> >  }




