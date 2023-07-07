Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B55C74B6F4
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 21:14:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233004AbjGGTO2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 15:14:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232233AbjGGTO1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 15:14:27 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9305112A
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 12:14:25 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id af79cd13be357-7658752ce2fso182750885a.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jul 2023 12:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20221208.gappssmtp.com; s=20221208; t=1688757264; x=1691349264;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KLuQdDStQpi/jaL94N6bqspsvqYo+nXtEDwo4gIugYA=;
        b=si6KcGNrQRxUUZg5lQUXvez9C60lcH1H+FqVMu9R4ytqchdEmXgEYpf3pb0/IaPPQr
         ol1s49kC7v16l7OH/DVc4QQtNS6JQRFRNYr5gDIbnLOtmtN/87DY8xxqrtIDH0WaikXj
         tT2wua73pPmOxlyCiahNbMXG4pAS6sWYHo0apovtz6J0ICGyrLIrRUHxddh+YQMsNCYe
         AyLNO41nmEzHoAR9QlfDmCvtuOpHG7fDTTl7ui+jetd4YIgTXAvXdOmNp3tijZpa+Fl/
         2QQcP2aEjYL3CV2Pv9cWUub2Ty60YvbkDS89WscC2gb+FdUzVbvG5OB5OwmMjBe9iyj4
         8/yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688757264; x=1691349264;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KLuQdDStQpi/jaL94N6bqspsvqYo+nXtEDwo4gIugYA=;
        b=GUcutHTzVIvS8E4zEwo+8NxPZARuABvp544utLVBvUB3ZZ0fzqYY+8Ywppz+RR15Zm
         hSDwK3ksxdA0nAlOO1wCnr8UvrMy1RVoMBQY6JYe4FOwWx7G+/IBZ1s+qvf/kD/NC2+I
         24aYg8f0Qzj3sl+5lGbJoLeBNCTiMSLTpDek7aneI0pY3XXsHxOBJNI8WUGJrapVRZzM
         qJCYXJ0/sZIWxSbFtBeF9nh1NOEEpQBywT2uIqsI8MPFlD60YHJSyHkA7jJz8pTMRsH+
         v+E2Oyv7XnbR82asflgMScVRPfEOCisNuIKkztqBIp0yIcK270iWTGlUjWIsuGm0+IsR
         7lJw==
X-Gm-Message-State: ABy/qLZbGbUbVl4pyI8or3o9+ygrEEAB5WMSbihBR9OrG9cVzg1nQuAB
        zf4H3wFJdta75RkJlQJnS14RSA==
X-Google-Smtp-Source: APBJJlFxHqmv01ImshKbphUreQDri1BcYEX2ZNnz3g4itQDFDObkICG1TQgCV0kAcIvs9IOSKh+6sw==
X-Received: by 2002:a05:620a:48a:b0:766:fd15:4c3d with SMTP id 10-20020a05620a048a00b00766fd154c3dmr4832058qkr.63.1688757264598;
        Fri, 07 Jul 2023 12:14:24 -0700 (PDT)
Received: from nicolas-tpx395.localdomain (mtl.collabora.ca. [66.171.169.34])
        by smtp.gmail.com with ESMTPSA id j28-20020a05620a147c00b00767410d18c3sm2111924qkl.36.2023.07.07.12.14.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jul 2023 12:14:24 -0700 (PDT)
Message-ID: <20452e233a9a4b39b58139081d818d3b1454105a.camel@ndufresne.ca>
Subject: Re: [PATCH 1/2] [RESEND] media: v4l2-mem2mem: allow device run
 without buf
From:   Nicolas Dufresne <nicolas@ndufresne.ca>
To:     Hsia-Jun Li <randy.li@synaptics.com>, linux-media@vger.kernel.org
Cc:     ayaka@soulik.info, hans.verkuil@cisco.com, tfiga@chromium.org,
        mchehab@kernel.org, laurent.pinchart@ideasonboard.com,
        hiroh@chromium.org, hverkuil@xs4all.nl,
        linux-kernel@vger.kernel.org,
        Sebastian Fricke <sebastian.fricke@collabora.com>
Date:   Fri, 07 Jul 2023 15:14:23 -0400
In-Reply-To: <20230704040044.681850-2-randy.li@synaptics.com>
References: <20230704040044.681850-1-randy.li@synaptics.com>
         <20230704040044.681850-2-randy.li@synaptics.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.3 (3.48.3-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Randy,

Le mardi 04 juillet 2023 =C3=A0 12:00 +0800, Hsia-Jun Li a =C3=A9crit=C2=A0=
:
> From: Randy Li <ayaka@soulik.info>
>=20
> For the decoder supports Dynamic Resolution Change,
> we don't need to allocate any CAPTURE or graphics buffer
> for them at inital CAPTURE setup step.
>=20
> We need to make the device run or we can't get those
> metadata.
>=20
> Signed-off-by: Randy Li <ayaka@soulik.info>
> ---
>  drivers/media/v4l2-core/v4l2-mem2mem.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/media/v4l2-core/v4l2-mem2mem.c b/drivers/media/v4l2-=
core/v4l2-mem2mem.c
> index 0cc30397fbad..c771aba42015 100644
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

I have a two atches with similar goals in my wave5 tree. It will be easier =
to
upstream with an actual user, though, I'm probably a month or two away from
submitting this driver again.

https://gitlab.collabora.com/chipsnmedia/kernel/-/commit/ac59eafd5076c4deb3=
bfe1fb85b3b776586ef3eb
https://gitlab.collabora.com/chipsnmedia/kernel/-/commit/5de4fbe0abb20b8e8d=
862b654f93e3efeb1ef251

Sebastien and I authored this without giving it much thought, but we believ=
e
this massively simplify our handling of DRC (dynamic resolution change).

The main difference, is that we added ignore_streaming to the ctx, so that
drivers can opt-in the mode of operation. Thinking it would avoid any poten=
tial
side effects in drivers that aren't prepared to that. We didn't want to tie=
d it
up to buffered, this is open to discussion of course, we do use buffered on=
 both
queues and use a slightly more advance job_ready function, that take into
account our driver state.

In short, Sebastien and I agree this small change is the right direction, w=
e
simply have a different implementation. I can send it as RFC if one believe=
 its
would be useful now (even without a user).

>  		dprintk("Streaming needs to be on for both queues\n");
>  		return;
>  	}

