Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D023B74967D
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 09:37:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233808AbjGFHhh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 03:37:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233488AbjGFHhg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 03:37:36 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02D5C1990
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 00:37:35 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mtr@pengutronix.de>)
        id 1qHJYM-0006DP-4Z; Thu, 06 Jul 2023 09:37:26 +0200
Received: from mtr by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <mtr@pengutronix.de>)
        id 1qHJYK-0007Ou-CB; Thu, 06 Jul 2023 09:37:24 +0200
Date:   Thu, 6 Jul 2023 09:37:24 +0200
From:   Michael Tretter <m.tretter@pengutronix.de>
To:     Benjamin Gaignard <benjamin.gaignard@collabora.com>
Cc:     ezequiel@vanguardiasur.com.ar, p.zabel@pengutronix.de,
        mchehab@kernel.org, m.szyprowski@samsung.com,
        linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        kernel@pengutronix.de, nicolas.dufresne@collabora.com,
        didi.debian@cknow.org, hverkuil-cisco@xs4all.nl
Subject: Re: [PATCH v2] media: verisilicon: Fix crash when probing encoder
Message-ID: <20230706073724.GG13288@pengutronix.de>
Mail-Followup-To: Michael Tretter <m.tretter@pengutronix.de>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        ezequiel@vanguardiasur.com.ar, p.zabel@pengutronix.de,
        mchehab@kernel.org, m.szyprowski@samsung.com,
        linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        kernel@pengutronix.de, nicolas.dufresne@collabora.com,
        didi.debian@cknow.org, hverkuil-cisco@xs4all.nl
References: <20230413104756.356695-1-benjamin.gaignard@collabora.com>
 <20230601132749.GA31313@pengutronix.de>
 <2a892e71-f1be-41eb-5397-87484db7d592@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2a892e71-f1be-41eb-5397-87484db7d592@collabora.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: mtr@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 01 Jun 2023 16:08:13 +0200, Benjamin Gaignard wrote:
> Le 01/06/2023 à 15:27, Michael Tretter a écrit :
> > On Thu, 13 Apr 2023 12:47:56 +0200, Benjamin Gaignard wrote:
> > > ctx->vpu_dst_fmt is no more initialized before calling hantro_try_fmt()
> > > so assigne it to vpu_fmt led to crash the kernel.
> > > Like for decoder case use 'fmt' as format for encoder and clean up
> > > the code.
> > > 
> > > Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
> > > Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> > > Fixes: db6f68b51e5c ("media: verisilicon: Do not set context src/dst formats in reset functions")
> > > ---
> > > version 2:
> > > - Remove useless vpu_fmt.
> > > 
> > >   drivers/media/platform/verisilicon/hantro_v4l2.c | 10 +++-------
> > >   1 file changed, 3 insertions(+), 7 deletions(-)
> > > 
> > > diff --git a/drivers/media/platform/verisilicon/hantro_v4l2.c b/drivers/media/platform/verisilicon/hantro_v4l2.c
> > > index 8f1414085f47..d71f79471396 100644
> > > --- a/drivers/media/platform/verisilicon/hantro_v4l2.c
> > > +++ b/drivers/media/platform/verisilicon/hantro_v4l2.c
> > > @@ -275,7 +275,7 @@ static int hantro_try_fmt(const struct hantro_ctx *ctx,
> > >   			  struct v4l2_pix_format_mplane *pix_mp,
> > >   			  enum v4l2_buf_type type)
> > >   {
> > > -	const struct hantro_fmt *fmt, *vpu_fmt;
> > > +	const struct hantro_fmt *fmt;
> > >   	bool capture = V4L2_TYPE_IS_CAPTURE(type);
> > >   	bool coded;
> > > @@ -295,11 +295,7 @@ static int hantro_try_fmt(const struct hantro_ctx *ctx,
> > >   	if (coded) {
> > >   		pix_mp->num_planes = 1;
> > > -		vpu_fmt = fmt;
> > > -	} else if (ctx->is_encoder) {
> > > -		vpu_fmt = ctx->vpu_dst_fmt;
> > > -	} else {
> > > -		vpu_fmt = fmt;
> > > +	} else if (!ctx->is_encoder) {
> > >   		/*
> > >   		 * Width/height on the CAPTURE end of a decoder are ignored and
> > >   		 * replaced by the OUTPUT ones.
> > > @@ -311,7 +307,7 @@ static int hantro_try_fmt(const struct hantro_ctx *ctx,
> > >   	pix_mp->field = V4L2_FIELD_NONE;
> > >   	v4l2_apply_frmsize_constraints(&pix_mp->width, &pix_mp->height,
> > > -				       &vpu_fmt->frmsize);
> > > +				       &fmt->frmsize);
> > This causes a regression on the OUTPUT device of the encoder. fmt->frmsize is
> > only valid for coded ("bitstream") formats, but fmt on the OUTPUT of an
> > encoder will be a raw format. This results in width and height to be clamped
> > to 0.
> > 
> > I think the correct fix would be to apply the frmsize constraints of the
> > currently configured coded format, but as ctx->vpu_dst_fmt is not initialized
> > before calling this code, I don't know how to get the coded format.
> 
> if ctx->dst_fmt is correctly set (and it should be) then doing:
> 
> pix_mp->width = ctx->dst_fmt.width;
> pix_mp->height = ctx->dst_fmt.height;
> 
> should solve the issue.

Using the width and height of dst_fmt for OUTPUT is not correct, since the
v4l2 stateless encoder spec dictates that the size is set on the OUTPUT device
and will be ignored on the CAPTURE device.

I sent a patch [0] to apply the frame constraints using dst_fmt.

Michael

[0] https://lore.kernel.org/linux-media/20230706071510.1717684-1-m.tretter@pengutronix.de/

> > >   	if (!coded) {
> > >   		/* Fill remaining fields */
> > > -- 
> > > 2.34.1
> > > 
> 
