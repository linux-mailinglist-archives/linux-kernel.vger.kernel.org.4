Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EA75638B76
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 14:43:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbiKYNnd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 08:43:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiKYNnb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 08:43:31 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49EE113DD9;
        Fri, 25 Nov 2022 05:43:30 -0800 (PST)
Received: from nicolas-tpx395.localdomain (192-222-136-102.qc.cable.ebox.net [192.222.136.102])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nicolas)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 6C7166602ABA;
        Fri, 25 Nov 2022 13:43:26 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1669383808;
        bh=xEb1rlJIjFZW7KhM7mESk0Xnz/dKZIUe677gaK3Xi04=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=WW5zArpIqjKBivKVLpbjP3l38kifVceCTmVyJ2uyNeTJtNHWLRjssV+Pf4Hh4PRLL
         t46sfpvI66wbCatCiUJLW4pVlLiBnbEiE/oi0TAFxXF/iagK+bur90HFndvz2NOUcy
         uRncosPBFo4TT0SGbUoo2W5cHADIugPcqmYWoCKU+alx5DxdBUaDPkIlCxOUdXb3nn
         jgjl6lh+87kSz7n8fSECy+8qn6FYsZ98jryefzr37M9O/4izBiqXpGcdQp+xh7oCCh
         qlydSG/w2y/LXFhk0MHunBDMfvJ2z714+6S1z0p3AHqsQDsrznbRDywrKb513A28AN
         yKlcHmPWsRR/A==
Message-ID: <edd368ea3cc9bb31700600a7f1fe7c837501458c.camel@collabora.com>
Subject: Re: [PATCH] media: v4l2-mem2mem: allow device run without buf
From:   Nicolas Dufresne <nicolas.dufresne@collabora.com>
To:     Hsia-Jun Li <randy.li@synaptics.com>, linux-media@vger.kernel.org
Cc:     mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        sebastian.fricke@collabora.com,
        kieran.bingham+renesas@ideasonboard.com,
        laurent.pinchart@ideasonboard.com, ming.qian@nxp.com,
        wenst@chromium.org, linux-kernel@vger.kernel.org,
        Randy Li <ayaka@soulik.info>
Date:   Fri, 25 Nov 2022 08:43:15 -0500
In-Reply-To: <20221123092427.76055-1-randy.li@synaptics.com>
References: <20221123092427.76055-1-randy.li@synaptics.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le mercredi 23 novembre 2022 =C3=A0 17:24 +0800, Hsia-Jun Li a =C3=A9crit=
=C2=A0:
> From: Randy Li <ayaka@soulik.info>
>=20
> For the decoder supports Dynamic Resolution Change,
> we don't need to allocate any CAPTURE or graphics buffer
> for them at inital CAPTURE setup step.
>=20
> We need to make the device run or we can't get those
> metadata.

Nack: This is not how it works. I know the m2m framework make it difficult,=
 but
it is expected that the driver have a special state for OUTPUT streamon (be=
fore
capture streamon). Please have a look at other drivers.

Nicolas

>=20
> Signed-off-by: Randy Li <ayaka@soulik.info>
> ---
>  drivers/media/v4l2-core/v4l2-mem2mem.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/media/v4l2-core/v4l2-mem2mem.c b/drivers/media/v4l2-=
core/v4l2-mem2mem.c
> index be7fde1ed3ea..cd56d60fad9d 100644
> --- a/drivers/media/v4l2-core/v4l2-mem2mem.c
> +++ b/drivers/media/v4l2-core/v4l2-mem2mem.c
> @@ -301,8 +301,9 @@ static void __v4l2_m2m_try_queue(struct v4l2_m2m_dev =
*m2m_dev,
> =20
>  	dprintk("Trying to schedule a job for m2m_ctx: %p\n", m2m_ctx);
> =20
> -	if (!m2m_ctx->out_q_ctx.q.streaming
> -	    || !m2m_ctx->cap_q_ctx.q.streaming) {
> +	if (!(m2m_ctx->out_q_ctx.q.streaming || m2m_ctx->out_q_ctx.buffered)
> +	    || !(m2m_ctx->cap_q_ctx.q.streaming
> +		 || m2m_ctx->cap_q_ctx.buffered)) {
>  		dprintk("Streaming needs to be on for both queues\n");
>  		return;
>  	}

