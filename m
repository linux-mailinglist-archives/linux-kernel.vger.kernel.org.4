Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 477DE6630DE
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 21:00:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237532AbjAIUAF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 15:00:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236497AbjAIT76 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 14:59:58 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 311F013E2B;
        Mon,  9 Jan 2023 11:59:57 -0800 (PST)
Received: from nicolas-tpx395.localdomain (192-222-136-102.qc.cable.ebox.net [192.222.136.102])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nicolas)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 8F74A6602D6A;
        Mon,  9 Jan 2023 19:59:54 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1673294395;
        bh=H174vEDV+J2zA47hFKfyVx3mBxvDGBXXMB4xDaIl3jc=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=NMyv/Y0pm2WyOn7Fmeh4Zj4ilq/MCz8Fspuaq2lXBA2KeUFn/Jh9rVb0nMT7EPdLv
         0NmQVDpZlRv1aaCFV+IL3+JmsIf9S+38xEMBD2Jz9t1fkMZsCnu5JVQscghsmGHG4W
         cx4yr6WkIQ//0nIAFF5JLuLrlGyS2tZ27YlCQqDepMdUjND3FV5J9q1lw3Te2AXvrb
         HA3SNTaa1v9TLE8cLjQ+oT2HuB/dpqCxFksXtqaZMLPPmvyzhbjnbS34DDCS6TT4IX
         z8sV67orCNfBhj13An7SoSv/g/n+oNNrfRkA8K66ASXeNecMvQgK923WO10VNGHCMd
         Qyq4IXJPg9rrw==
Message-ID: <8124d8751180393f8490fa3f754b1b674d7c06db.camel@collabora.com>
Subject: Re: [PATCH v2 3/4] media: rkvdec: Re-enable H.264 error detection
From:   Nicolas Dufresne <nicolas.dufresne@collabora.com>
To:     Chen-Yu Tsai <wenst@chromium.org>
Cc:     Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kernel@collabora.com, linux-media@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Date:   Mon, 09 Jan 2023 14:59:46 -0500
In-Reply-To: <CAGXv+5GBhZ4U4y_KGrBdvgmy7odcVvH=ZJEMtsfjPvw4tQUV1A@mail.gmail.com>
References: <20221223193807.914935-1-nicolas.dufresne@collabora.com>
         <20221223193807.914935-4-nicolas.dufresne@collabora.com>
         <CAGXv+5GBhZ4U4y_KGrBdvgmy7odcVvH=ZJEMtsfjPvw4tQUV1A@mail.gmail.com>
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

Le lundi 26 d=C3=A9cembre 2022 =C3=A0 12:17 +0800, Chen-Yu Tsai a =C3=A9cri=
t=C2=A0:
> On Sat, Dec 24, 2022 at 3:39 AM Nicolas Dufresne
> <nicolas.dufresne@collabora.com> wrote:
> >=20
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
> >=20
> >         schedule_delayed_work(&rkvdec->watchdog_work, msecs_to_jiffies(=
2000));
> >=20
> > -       writel(0, rkvdec->regs + RKVDEC_REG_STRMD_ERR_EN);
> > -       writel(0, rkvdec->regs + RKVDEC_REG_H264_ERR_E);
> > +       writel(0xffffffff, rkvdec->regs + RKVDEC_REG_STRMD_ERR_EN);
> > +       writel(0xffffffff, rkvdec->regs + RKVDEC_REG_H264_ERR_E);
>=20
> Use RKVDEC_H264_ERR_EN_HIGHBITS() here? Only lower 30 bits are valid.

I was simply reverting back to the value it was before, I can try that too,=
 you
are likely right.

>=20
> >         writel(1, rkvdec->regs + RKVDEC_REG_PREF_LUMA_CACHE_COMMAND);
> >         writel(1, rkvdec->regs + RKVDEC_REG_PREF_CHR_CACHE_COMMAND);
> >=20
> >         /* Start decoding! */
> >         writel(RKVDEC_INTERRUPT_DEC_E | RKVDEC_CONFIG_DEC_CLK_GATE_E |
> > -              RKVDEC_TIMEOUT_E | RKVDEC_BUF_EMPTY_E,
> > +              RKVDEC_TIMEOUT_E | RKVDEC_BUF_EMPTY_E |
> > +              RKVDEC_H264ORVP9_ERR_MODE,
> >                rkvdec->regs + RKVDEC_REG_INTERRUPT);
> >=20
> >         return 0;
> > @@ -1183,10 +1184,26 @@ static int rkvdec_h264_try_ctrl(struct rkvdec_c=
tx *ctx, struct v4l2_ctrl *ctrl)
> >         return 0;
> >  }
> >=20
> > +static int rkvdec_h264_check_error_info(struct rkvdec_ctx *ctx)
> > +{
> > +       struct rkvdec_dev *rkvdec =3D ctx->dev;
> > +       int err;
>=20
> u32?

Will do.

>=20
> Otherwise,
>=20
> Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
>=20
> > +
> > +       err =3D readl(rkvdec->regs + RKVDEC_REG_H264_ERRINFO_NUM);
> > +       if (err & RKVDEC_STRMD_DECT_ERR_FLAG) {
> > +               pr_debug("Decoded picture have %i/%i slices with errors=
.\n",
> > +                        RKVDEC_ERR_PKT_NUM(err), RKVDEC_SLICEDEC_NUM(e=
rr));
> > +               return VB2_BUF_STATE_ERROR;
> > +       }
> > +
> > +       return VB2_BUF_STATE_DONE;
> > +}
> > +
> >  const struct rkvdec_coded_fmt_ops rkvdec_h264_fmt_ops =3D {
> >         .adjust_fmt =3D rkvdec_h264_adjust_fmt,
> >         .start =3D rkvdec_h264_start,
> >         .stop =3D rkvdec_h264_stop,
> >         .run =3D rkvdec_h264_run,
> >         .try_ctrl =3D rkvdec_h264_try_ctrl,
> > +       .check_error_info =3D rkvdec_h264_check_error_info,
> >  };
> > --
> > 2.38.1
> >=20

