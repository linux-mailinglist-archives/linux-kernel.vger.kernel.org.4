Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED0916630E0
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 21:01:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237361AbjAIUBF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 15:01:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237735AbjAIUA7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 15:00:59 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35831B24;
        Mon,  9 Jan 2023 12:00:50 -0800 (PST)
Received: from nicolas-tpx395.localdomain (192-222-136-102.qc.cable.ebox.net [192.222.136.102])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: nicolas)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 8946E6602D6A;
        Mon,  9 Jan 2023 20:00:48 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1673294449;
        bh=aNxF/+Hoq4Gd7aJCmM96Gfm8Aq+Jh67MSR5O2NNGsso=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=fyxUTj54ttkr13MsVew38u+JDz8+6sBegp8lpkc/xfZ69fO2htKaEC2LmSu4+74UI
         5pJLjGpNH+/ZKoBV/QcrEvprWgJmcFffWXeutpyZurQrs7vqf/kWVJW9r8uxgA/8Ba
         hPHF6EmCrW24JwlfMuiQPTLkagVAbGDn9an6tJuIRb3SkuuD9Y+Q+hsPBWmh58vsZv
         4wJ3Eqh1gHGI3ZhCnWXDNH7flGRHMGYUzwQzDLsKdfaXRhf9pUaDtBfPCuD/8I9M9k
         ss4/TJBPq8VTdPN1ZAf2qPUNJQiGK9VGcDacGt8tFImiADi2BeO9vS8f426wCTERAT
         p1FLQNr5Du0Sg==
Message-ID: <f3bf3ba7cc27f4d8eddeec730fe588a7a32c0465.camel@collabora.com>
Subject: Re: [PATCH v2 3/4] media: rkvdec: Re-enable H.264 error detection
From:   Nicolas Dufresne <nicolas.dufresne@collabora.com>
To:     Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kernel@collabora.com, linux-media@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Date:   Mon, 09 Jan 2023 15:00:39 -0500
In-Reply-To: <Y6oTEkEwuGISwr+z@eze-laptop>
References: <20221223193807.914935-1-nicolas.dufresne@collabora.com>
         <20221223193807.914935-4-nicolas.dufresne@collabora.com>
         <Y6oTEkEwuGISwr+z@eze-laptop>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.2 (3.46.2-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le lundi 26 d=C3=A9cembre 2022 =C3=A0 18:33 -0300, Ezequiel Garcia a =C3=A9=
crit=C2=A0:
> Hi Nicolas,
>=20
> I'm still unsure about this patchset.
> It sounds like a good approach and a nice
> improvement, but I want to make sure I think through it.
>=20
> Meanwhile, a small comment...
>=20
> On Fri, Dec 23, 2022 at 02:38:05PM -0500, Nicolas Dufresne wrote:
> > This re-enable H.264 error detection, but using the other error mode.
> > In that mode, the decoder will skip over the error macro-block or
> > slices and complete the decoding. As a side effect, the error status
> > is not set in the interrupt status register, and instead errors are
> > detected per format. Using this mode workaround the issue that the
> > HW get stuck in error state, and allow reporting that some corruption
> > may be present in the buffer to userland.
> >=20
> > Signed-off-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
> > ---
> >  drivers/staging/media/rkvdec/rkvdec-h264.c | 23 +++++++++++++++++++---
> >  1 file changed, 20 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/drivers/staging/media/rkvdec/rkvdec-h264.c b/drivers/stagi=
ng/media/rkvdec/rkvdec-h264.c
> > index 4fc167b42cf0c..dfe3e235f099a 100644
> > --- a/drivers/staging/media/rkvdec/rkvdec-h264.c
> > +++ b/drivers/staging/media/rkvdec/rkvdec-h264.c
> > @@ -1162,14 +1162,15 @@ static int rkvdec_h264_run(struct rkvdec_ctx *c=
tx)
> > =20
> >  	schedule_delayed_work(&rkvdec->watchdog_work, msecs_to_jiffies(2000))=
;
> > =20
> > -	writel(0, rkvdec->regs + RKVDEC_REG_STRMD_ERR_EN);
> > -	writel(0, rkvdec->regs + RKVDEC_REG_H264_ERR_E);
> > +	writel(0xffffffff, rkvdec->regs + RKVDEC_REG_STRMD_ERR_EN);
> > +	writel(0xffffffff, rkvdec->regs + RKVDEC_REG_H264_ERR_E);
> >  	writel(1, rkvdec->regs + RKVDEC_REG_PREF_LUMA_CACHE_COMMAND);
> >  	writel(1, rkvdec->regs + RKVDEC_REG_PREF_CHR_CACHE_COMMAND);
> > =20
> >  	/* Start decoding! */
> >  	writel(RKVDEC_INTERRUPT_DEC_E | RKVDEC_CONFIG_DEC_CLK_GATE_E |
> > -	       RKVDEC_TIMEOUT_E | RKVDEC_BUF_EMPTY_E,
> > +	       RKVDEC_TIMEOUT_E | RKVDEC_BUF_EMPTY_E |
> > +	       RKVDEC_H264ORVP9_ERR_MODE,
> >  	       rkvdec->regs + RKVDEC_REG_INTERRUPT);
> > =20
> >  	return 0;
> > @@ -1183,10 +1184,26 @@ static int rkvdec_h264_try_ctrl(struct rkvdec_c=
tx *ctx, struct v4l2_ctrl *ctrl)
> >  	return 0;
> >  }
> > =20
> > +static int rkvdec_h264_check_error_info(struct rkvdec_ctx *ctx)
> > +{
> > +	struct rkvdec_dev *rkvdec =3D ctx->dev;
> > +	int err;
> > +
> > +	err =3D readl(rkvdec->regs + RKVDEC_REG_H264_ERRINFO_NUM);
> > +	if (err & RKVDEC_STRMD_DECT_ERR_FLAG) {
> > +		pr_debug("Decoded picture have %i/%i slices with errors.\n",
>=20
> ... still uses pr_debug. I would change it so it uses v4l2_dbg,
> and can be controlled using the same debug parameter
> as you use in patch 4/4.

Good catch, I missed that one, will fix.

>=20
> > +			 RKVDEC_ERR_PKT_NUM(err), RKVDEC_SLICEDEC_NUM(err));
> > +		return VB2_BUF_STATE_ERROR;
> > +	}
> > +
> > +	return VB2_BUF_STATE_DONE;
> > +}
> > +
> >  const struct rkvdec_coded_fmt_ops rkvdec_h264_fmt_ops =3D {
> >  	.adjust_fmt =3D rkvdec_h264_adjust_fmt,
> >  	.start =3D rkvdec_h264_start,
> >  	.stop =3D rkvdec_h264_stop,
> >  	.run =3D rkvdec_h264_run,
> >  	.try_ctrl =3D rkvdec_h264_try_ctrl,
> > +	.check_error_info =3D rkvdec_h264_check_error_info,
> >  };
> > --=20
> > 2.38.1
> >=20

