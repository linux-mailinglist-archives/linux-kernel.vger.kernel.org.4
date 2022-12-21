Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 340996533D7
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 17:16:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbiLUQQ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 11:16:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbiLUQQU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 11:16:20 -0500
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com [IPv6:2607:f8b0:4864:20::e2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6620220DD
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 08:16:18 -0800 (PST)
Received: by mail-vs1-xe2e.google.com with SMTP id i188so9214113vsi.8
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 08:16:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20210112.gappssmtp.com; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=V0Jr0ncaFatQ1llU1BzfDYX0DgcfVDK5RFBuq4i0i/I=;
        b=cIEeX/c30k4UKyOj4eR0nz6PRiwIs1u/WY+Y/KZnMgS1n898SM4jfwvbYDeHBD6CP+
         1yh7dxh7J44S9bInD6Wc7znYCP8AFqjsuXW6wbpBgPoBcCDCP+D5aPDlchtW1tskqth0
         JDrPXLgkL3+R8WYxhpjRlwLNeCbjex7oY7GkjIXJY7ss6zRbrgM150WYsaIGhIfM/fZM
         d3K7kg+xL4COP5+w3lgfACkztRVqpnbGcP1373A/lt5EIkP6g95+l/KvupNu/ParlyLD
         d2alslZ88NZsl9wMWzzdqMG0pOFIyz6iLPU5nBOCkS5GxORX8oFmIeCr4CMEAMT84oSA
         8CVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V0Jr0ncaFatQ1llU1BzfDYX0DgcfVDK5RFBuq4i0i/I=;
        b=Kv+dbPOoqOQyuR7pfmjRqeizkMdrQoqd5Tnj1MuytrxsUxt4+ZfPSxcTB4fu8aCkG3
         oakzE8pm4RwQ6tN37zURPLgpUPsf8M0YJr/ZRmUUlNihhjLuQI7SX7aMmrGC6WkwcRpP
         6WAe95ijvSR4qK/Hk8vIrg6IezsTgNlD/VbncwW5Ju4qweBIOkTYtRdqrEVh879QnvbO
         mArATJgXpEXT19E5BTycnji1xNUgWo9nBNY2KHOZJ9YVLx9GRmDJuQ/wAax3qJDhNqmp
         jub6FwHL10rpAegOzWjQLfn9JgonZe9AvSqY68TX1wWrjjhUU+1tR8Vey5fnA5G3c6bl
         WW9g==
X-Gm-Message-State: AFqh2kqzSzrYnhUZ23eaOYcY09AJrg4gmndx0GVqZzjOzvYUEdSfbGlx
        3vgydRaNys3Kf0Iv3nz6nQp/9Q==
X-Google-Smtp-Source: AMrXdXus2f0EloCt7a3u9bTW2ujIpOXjtqLhrlnsSr1Wm1BTZtnm2QKIoG59T4IHC7fJp76J6j25yA==
X-Received: by 2002:a05:6102:356c:b0:3b1:3719:f2cf with SMTP id bh12-20020a056102356c00b003b13719f2cfmr972540vsb.24.1671639376650;
        Wed, 21 Dec 2022 08:16:16 -0800 (PST)
Received: from nicolas-tpx395.localdomain ([192.222.136.102])
        by smtp.gmail.com with ESMTPSA id dt20-20020a05620a479400b006fbf88667bcsm10926041qkb.77.2022.12.21.08.16.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Dec 2022 08:16:15 -0800 (PST)
Message-ID: <0417e11649150202f717646809e7db5c55f7ac83.camel@ndufresne.ca>
Subject: Re: [PATCH v1 4/9] media: verisilicon: Check AV1 bitstreams bit
 depth
From:   Nicolas Dufresne <nicolas@ndufresne.ca>
To:     Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        ezequiel@vanguardiasur.com.ar, p.zabel@pengutronix.de,
        mchehab@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, heiko@sntech.de,
        daniel.almeida@collabora.com, nicolas.dufresne@collabora.co.uk
Cc:     linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com
Date:   Wed, 21 Dec 2022 11:16:12 -0500
In-Reply-To: <4aae8684-5ab4-c5a6-cc73-5dc61309b745@collabora.com>
References: <20221219155616.848690-1-benjamin.gaignard@collabora.com>
         <20221219155616.848690-5-benjamin.gaignard@collabora.com>
         <e3663c85c75d09259a3135cb6ccfe7d6231bd752.camel@ndufresne.ca>
         <4aae8684-5ab4-c5a6-cc73-5dc61309b745@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.2 (3.46.2-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le mardi 20 d=C3=A9cembre 2022 =C3=A0 14:02 +0100, Benjamin Gaignard a =C3=
=A9crit=C2=A0:
> Le 19/12/2022 =C3=A0 21:38, Nicolas Dufresne a =C3=A9crit=C2=A0:
> > Le lundi 19 d=C3=A9cembre 2022 =C3=A0 16:56 +0100, Benjamin Gaignard a =
=C3=A9crit=C2=A0:
> > > The driver supports 8 and 10 bits bitstreams, make sure to discard
> > > other cases.
> > >=20
> > > Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
> > > ---
> > >   drivers/media/platform/verisilicon/hantro_drv.c | 6 ++++++
> > >   1 file changed, 6 insertions(+)
> > >=20
> > > diff --git a/drivers/media/platform/verisilicon/hantro_drv.c b/driver=
s/media/platform/verisilicon/hantro_drv.c
> > > index 8e93710dcfed..e10fc59634dd 100644
> > > --- a/drivers/media/platform/verisilicon/hantro_drv.c
> > > +++ b/drivers/media/platform/verisilicon/hantro_drv.c
> > > @@ -282,7 +282,13 @@ static int hantro_try_ctrl(struct v4l2_ctrl *ctr=
l)
> > >   		/* We only support profile 0 */
> > >   		if (dec_params->profile !=3D 0)
> > >   			return -EINVAL;
> > > +	} else if (ctrl->id =3D=3D V4L2_CID_STATELESS_AV1_SEQUENCE) {
> > > +		const struct v4l2_ctrl_av1_sequence *sequence =3D ctrl->p_new.p_av=
1_sequence;
> > > +
> > > +		if (sequence->bit_depth !=3D 8 && sequence->bit_depth !=3D 10)
> > > +			return -EINVAL;
> > As you state in the cover letter, should this just be this for now ?
>=20
> The driver can decode 8 or 10 bits bitstreams but will on produce 8bits (=
NV12_4L4 or NV12)
> frames. The hardware is able to truncate 10bits bitstreams to 8 bits outp=
ut.

I tested that, and NV12 works, picking NV12_4L4 though leads to corrupted
buffers. I think the PP is not being activated. G2/VC8000 and likely VC9000=
 can
only produce tile reference in the original depth chosen (hence why it goes=
 not
have a format register like G1 does).

As you are aware, the driver didn't pick NV12_10LE40_4L4 automatically, and
that's what broke fluster 10bit test in tiled mode for 10bit. I suspect in =
v2,
we'll have all this fixed and 10bit will be activated, so this comment will=
 be
ignored.

>=20
> >=20
> >=20
> > > +		if (sequence->bit_depth !=3D 8)
> > > +			return -EINVAL;
> >=20
> > >   	}
> > > +
> > >   	return 0;
> > >   }
> > >  =20

