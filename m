Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67C2074B6FF
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 21:20:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233016AbjGGTU2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 15:20:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232723AbjGGTUZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 15:20:25 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0056F18B
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 12:20:23 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id af79cd13be357-766b22593faso182319585a.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jul 2023 12:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20221208.gappssmtp.com; s=20221208; t=1688757623; x=1691349623;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tI3ZmzlJ8v1yyhdsh409Oan9mJwrZdLHSmF+6lcsYDo=;
        b=o6gsgUpVHX876p9nKUzMhUuL65DtNUr6D3gts1qCNw+BCcKfdoPowDa56n2Aw9cMWX
         DQBS5WXsO5GqzKKgQMV0f3A99cUIL78bamPuqTDCAEVOE6P99Y6cw/0Cr8uMDg5ZRXaX
         9GydJ/5hromEATQK1QXoaPiCSyHeu+D/xXL+r7UHnlLvy/PcKOK3adD1OKeg3A1vRvtP
         6WoOsDNfyvX/qE3K8vrqEy0RiQ1dhwQer1tFKIyEQAnK4a755igvWykytipr6pmA7Yk3
         znV2e2Lw7tSiud1OieO9cRl8UbcWVmXYst+8MSRGPzTTrMenVGuedzYCf4oCcGZGkW5H
         a11g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688757623; x=1691349623;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tI3ZmzlJ8v1yyhdsh409Oan9mJwrZdLHSmF+6lcsYDo=;
        b=DOiU5Bmr7xU75jNqwBymqP1IayPhPbHBoUYs7cD/93+UmbfUtf3mCZmQfIETZb0WpJ
         a9sRgK+pUMxWITORqgBCLYHzXGoX5BdnR4m73RiVVZ1dkcXDMDjlkj9Lli7Ldc19txTQ
         zAg3Z1qrzYVtxPIN2IKZ0Xz8BaFIxQcbefpd0XB1xl2JmoCvIkfpHYR3U5J+JNhc99js
         FEnVdF/2VR2zADgiKbpx3Io+2OPYNRv7yTse+vI69AjYgmKRHbpYq3OOr1AdyG+auCTB
         vGzIwMRLQf4s6uGp1k3TMZ4mMc25YR88tKp0u9W9iP/nZq7HDdJgr51IdNyoStc0CIX2
         2PDw==
X-Gm-Message-State: ABy/qLYaup1yOPSmnmOjNomI98CAsWs/Urbfi0WLjVr/4vLKk+t3lGTW
        nBNiBbQDEfNaP227O9dgiVe7kQ==
X-Google-Smtp-Source: APBJJlG27mC1OWJZZUJrFwnyL6NsblWizZzqY8Es3mmhufpkYjVVzxSpthf8EHPs/Bw2jDKTlPK48g==
X-Received: by 2002:a37:b441:0:b0:765:6782:cafd with SMTP id d62-20020a37b441000000b007656782cafdmr4172788qkf.69.1688757622996;
        Fri, 07 Jul 2023 12:20:22 -0700 (PDT)
Received: from nicolas-tpx395.localdomain (mtl.collabora.ca. [66.171.169.34])
        by smtp.gmail.com with ESMTPSA id w27-20020a05620a129b00b00767c4a1e9d3sm102644qki.76.2023.07.07.12.20.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jul 2023 12:20:22 -0700 (PDT)
Message-ID: <575b5a7bd48b3fab7a33c7c25962b36b2ccf6b14.camel@ndufresne.ca>
Subject: Re: [PATCH 2/2] media: v4l2-mem2mem: add a list for buf used by hw
From:   Nicolas Dufresne <nicolas@ndufresne.ca>
To:     Hsia-Jun Li <randy.li@synaptics.com>, linux-media@vger.kernel.org
Cc:     ayaka@soulik.info, hans.verkuil@cisco.com, tfiga@chromium.org,
        mchehab@kernel.org, laurent.pinchart@ideasonboard.com,
        hiroh@chromium.org, hverkuil@xs4all.nl,
        linux-kernel@vger.kernel.org
Date:   Fri, 07 Jul 2023 15:20:21 -0400
In-Reply-To: <20230704040044.681850-3-randy.li@synaptics.com>
References: <20230704040044.681850-1-randy.li@synaptics.com>
         <20230704040044.681850-3-randy.li@synaptics.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.3 (3.48.3-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le mardi 04 juillet 2023 =C3=A0 12:00 +0800, Hsia-Jun Li a =C3=A9crit=C2=A0=
:
> From: "Hsia-Jun(Randy) Li" <randy.li@synaptics.com>
>=20
> Many drivers have to create its own buf_struct for a
> vb2_queue to track such a state. Also driver has to
> iterate over rdy_queue every times to find out a buffer
> which is not sent to hardware(or firmware), this new
> list just offers the driver a place to store the buffer
> that hardware(firmware) has acknowledged.
>=20
> One important advance about this list, it doesn't like
> rdy_queue which both bottom half of the user calling
> could operate it, while the v4l2 worker would as well.
> The v4l2 core could only operate this queue when its
> v4l2_context is not running, the driver would only
> access this new hw_queue in its own worker.

That's an interesting proposal. I didn't like leaving decoded frames into t=
he
rdy_queue, but removing them required me to have my own list, so that I can
clean it up if some buffers are never displayed.

We'll see if we can use this into wave5.

>=20
> Signed-off-by: Hsia-Jun(Randy) Li <randy.li@synaptics.com>
> ---
>  drivers/media/v4l2-core/v4l2-mem2mem.c | 25 +++++++++++++++++--------
>  include/media/v4l2-mem2mem.h           | 10 +++++++++-
>  2 files changed, 26 insertions(+), 9 deletions(-)
>=20
> diff --git a/drivers/media/v4l2-core/v4l2-mem2mem.c b/drivers/media/v4l2-=
core/v4l2-mem2mem.c
> index c771aba42015..b4151147d5bd 100644
> --- a/drivers/media/v4l2-core/v4l2-mem2mem.c
> +++ b/drivers/media/v4l2-core/v4l2-mem2mem.c
> @@ -321,15 +321,21 @@ static void __v4l2_m2m_try_queue(struct v4l2_m2m_de=
v *m2m_dev,
>  		goto job_unlock;
>  	}
> =20
> -	src =3D v4l2_m2m_next_src_buf(m2m_ctx);
> -	dst =3D v4l2_m2m_next_dst_buf(m2m_ctx);
> -	if (!src && !m2m_ctx->out_q_ctx.buffered) {
> -		dprintk("No input buffers available\n");
> -		goto job_unlock;
> +	if (list_empty(&m2m_ctx->out_q_ctx.hw_queue)) {
> +		src =3D v4l2_m2m_next_src_buf(m2m_ctx);
> +
> +		if (!src && !m2m_ctx->out_q_ctx.buffered) {
> +			dprintk("No input buffers available\n");
> +			goto job_unlock;
> +		}
>  	}
> -	if (!dst && !m2m_ctx->cap_q_ctx.buffered) {
> -		dprintk("No output buffers available\n");
> -		goto job_unlock;
> +
> +	if (list_empty(&m2m_ctx->cap_q_ctx.hw_queue)) {
> +		dst =3D v4l2_m2m_next_dst_buf(m2m_ctx);
> +		if (!dst && !m2m_ctx->cap_q_ctx.buffered) {
> +			dprintk("No output buffers available\n");
> +			goto job_unlock;
> +		}
>  	}
> =20
>  	m2m_ctx->new_frame =3D true;
> @@ -896,6 +902,7 @@ int v4l2_m2m_streamoff(struct file *file, struct v4l2=
_m2m_ctx *m2m_ctx,
>  	INIT_LIST_HEAD(&q_ctx->rdy_queue);
>  	q_ctx->num_rdy =3D 0;
>  	spin_unlock_irqrestore(&q_ctx->rdy_spinlock, flags);
> +	INIT_LIST_HEAD(&q_ctx->hw_queue);
> =20
>  	if (m2m_dev->curr_ctx =3D=3D m2m_ctx) {
>  		m2m_dev->curr_ctx =3D NULL;
> @@ -1234,6 +1241,8 @@ struct v4l2_m2m_ctx *v4l2_m2m_ctx_init(struct v4l2_=
m2m_dev *m2m_dev,
> =20
>  	INIT_LIST_HEAD(&out_q_ctx->rdy_queue);
>  	INIT_LIST_HEAD(&cap_q_ctx->rdy_queue);
> +	INIT_LIST_HEAD(&out_q_ctx->hw_queue);
> +	INIT_LIST_HEAD(&cap_q_ctx->hw_queue);
>  	spin_lock_init(&out_q_ctx->rdy_spinlock);
>  	spin_lock_init(&cap_q_ctx->rdy_spinlock);
> =20
> diff --git a/include/media/v4l2-mem2mem.h b/include/media/v4l2-mem2mem.h
> index d6c8eb2b5201..2342656e582d 100644
> --- a/include/media/v4l2-mem2mem.h
> +++ b/include/media/v4l2-mem2mem.h
> @@ -53,9 +53,16 @@ struct v4l2_m2m_dev;
>   *	processed
>   *
>   * @q:		pointer to struct &vb2_queue
> - * @rdy_queue:	List of V4L2 mem-to-mem queues
> + * @rdy_queue:	List of V4L2 mem-to-mem queues. If v4l2_m2m_buf_queue() i=
s
> + *		called in struct vb2_ops->buf_queue(), the buffer enqueued
> + *		by user would be added to this list.
>   * @rdy_spinlock: spin lock to protect the struct usage
>   * @num_rdy:	number of buffers ready to be processed
> + * @hw_queue:	A list for tracking the buffer is occupied by the hardware
> + * 		(or device's firmware). A buffer could only be in either
> + * 		this list or @rdy_queue.
> + * 		Driver may choose not to use this list while uses its own
> + * 		private data to do this work.

What's the threading protection around this one ? Also, would it be possibl=
e to
opt-in that the driver cleanup that list automatically after streamoff has =
been
executed ?

One thing the doc is missing, is that HW buffer are actually flagged as ACT=
IVE
buffer vb2, there is a strong link between the two concept, and the doc sho=
uld
take care.

>   * @buffered:	is the queue buffered?
>   *
>   * Queue for buffers ready to be processed as soon as this
> @@ -68,6 +75,7 @@ struct v4l2_m2m_queue_ctx {
>  	struct list_head	rdy_queue;
>  	spinlock_t		rdy_spinlock;
>  	u8			num_rdy;
> +	struct list_head	hw_queue;
>  	bool			buffered;
>  };
> =20

