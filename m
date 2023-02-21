Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E40269DC38
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 09:39:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233777AbjBUIjF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 03:39:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233499AbjBUIi5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 03:38:57 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84D384499;
        Tue, 21 Feb 2023 00:38:47 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id j17so3663212ljq.11;
        Tue, 21 Feb 2023 00:38:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1W8pZijqLGcNat/8G5OTCx6Y7aJUY3oODAmVHl137tw=;
        b=oYDbVFfFxhPkNyBf3v0ZYWsr1JhfHZRJkrawAzncV8YLAcKF9mC7dIpjDLlPfPDpEY
         z32ja1Z48yPU8skaeXw/SOoNy3iqNg2w9PaiFwsIKu1f1A0QSxPjU2Q9pX0mUBo/igyZ
         SgCqHcKO5yCaAXvPv1S/4aC87m87Nn9OUvXE4mMMIaXEFJdfCCqykVwEGNznzcA84ErV
         W8m4IBZR/I/5tfiAFLEA7YJpZ89xvxobL71KKVFacS7n18fMoSG/2wpRoqgbi8H3Po3r
         obLYMrJoBcH8DqoDCZsUV9DO7gKgOYJ68lfbXOisjkwpBjzcPoPxgUGhDxy4SXQlirXW
         U1zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:references:in-reply-to:message-id:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1W8pZijqLGcNat/8G5OTCx6Y7aJUY3oODAmVHl137tw=;
        b=W44209guJDaP++UmatErG7+x6brG5ZsXUpOdV+8zti9rdDET/3uGYTIFz2MiMC9Hv+
         koH/G0I/iQ4sJe/U8jbMqUsK8k9wqTkIg7gFiDeMGryVruFE+X8iyLw2ZIlsshIXlAXf
         kw/3OJe6PFFg80alS7NiZatnMpR7KmFbeRpbTM/YzZBUXhZzrvKUdDes5QWpVDk0jd+u
         Q/LfbwnCSHqIbhtFd6kbKpDmZvbKrUkTVz1ICLRwda4axAiV0HqVoZcZAyO/81c/wLn1
         dEz/ZZ9IZxGOecmcefLkU6Q8lx/qUWDsPExdDYyRPKRJT5s655O6lw9w1GHAASzyo0wH
         UkHA==
X-Gm-Message-State: AO0yUKWlpifAnBd4Pwk5crt3YXkce/X/OE6EqJjqti5aPzsRSxKefrdT
        GdUS3N5QySTYaq5R10l9DEA=
X-Google-Smtp-Source: AK7set92xE2QliPenlOzZe7t3tGVIknuNqqFpK1dHTQNre8Li8krArc7FA0WGNeY8l24sfghKtkwPw==
X-Received: by 2002:a2e:8346:0:b0:28d:2cf8:9341 with SMTP id l6-20020a2e8346000000b0028d2cf89341mr1578505ljh.23.1676968725545;
        Tue, 21 Feb 2023 00:38:45 -0800 (PST)
Received: from eldfell ([194.136.85.206])
        by smtp.gmail.com with ESMTPSA id y1-20020a2e3201000000b00294a1275192sm296299ljy.110.2023.02.21.00.38.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Feb 2023 00:38:45 -0800 (PST)
Date:   Tue, 21 Feb 2023 10:38:41 +0200
From:   Pekka Paalanen <ppaalanen@gmail.com>
To:     Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>
Cc:     Rob Clark <robdclark@gmail.com>, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
        Christian =?UTF-8?B?S8O2bmln?= <ckoenig.leichtzumerken@gmail.com>,
        Michel =?UTF-8?B?RMOkbnplcg==?= <michel@daenzer.net>,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Simon Ser <contact@emersion.fr>,
        Rob Clark <robdclark@chromium.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Gustavo Padovan <gustavo@padovan.org>,
        "open list:SYNC FILE FRAMEWORK" <linux-media@vger.kernel.org>,
        "moderated list:DMA BUFFER SHARING FRAMEWORK" 
        <linaro-mm-sig@lists.linaro.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 06/14] dma-buf/sync_file: Support (E)POLLPRI
Message-ID: <20230221103841.0d501f01@eldfell>
In-Reply-To: <2e6e9581-6de8-6aca-3e73-946fbc6ad2a3@amd.com>
References: <20230218211608.1630586-1-robdclark@gmail.com>
        <20230218211608.1630586-7-robdclark@gmail.com>
        <2e6e9581-6de8-6aca-3e73-946fbc6ad2a3@amd.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/PboreIUuM6gO6KQswv5Gd=N";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/PboreIUuM6gO6KQswv5Gd=N
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 20 Feb 2023 09:31:41 +0100
Christian K=C3=B6nig <christian.koenig@amd.com> wrote:

> Am 18.02.23 um 22:15 schrieb Rob Clark:
> > From: Rob Clark <robdclark@chromium.org>
> >
> > Allow userspace to use the EPOLLPRI/POLLPRI flag to indicate an urgent
> > wait (as opposed to a "housekeeping" wait to know when to cleanup after
> > some work has completed).  Usermode components of GPU driver stacks
> > often poll() on fence fd's to know when it is safe to do things like
> > free or reuse a buffer, but they can also poll() on a fence fd when
> > waiting to read back results from the GPU.  The EPOLLPRI/POLLPRI flag
> > lets the kernel differentiate these two cases.
> >
> > Signed-off-by: Rob Clark <robdclark@chromium.org> =20
>=20
> The code looks clean, but the different poll flags and their meaning are=
=20
> certainly not my field of expertise.


A good question. epoll_ctl manual refers to poll(2) which says:

       POLLPRI
              There is some exceptional condition on the file descriptor.  =
Possibilities include:

              =E2=80=A2 There is out-of-band data on a TCP socket (see tcp(=
7)).

              =E2=80=A2 A pseudoterminal master in packet mode has seen a s=
tate change on the slave (see ioctl_tty(2)).

              =E2=80=A2 A cgroup.events file has been modified (see cgroups=
(7)).

It seems to be about selecting what events will trigger the poll,
more than how (fast) to poll. At least it is not documented to be
ignored in 'events', so I guess it should work.


Thanks,
pq

> Feel free to add Acked-by: Christian K=C3=B6nig <christian.koenig@amd.com=
>,=20
> somebody with more background in this should probably take a look as well.
>=20
> Regards,
> Christian.
>=20
> > ---
> >   drivers/dma-buf/sync_file.c | 8 ++++++++
> >   1 file changed, 8 insertions(+)
> >
> > diff --git a/drivers/dma-buf/sync_file.c b/drivers/dma-buf/sync_file.c
> > index fb6ca1032885..c30b2085ee0a 100644
> > --- a/drivers/dma-buf/sync_file.c
> > +++ b/drivers/dma-buf/sync_file.c
> > @@ -192,6 +192,14 @@ static __poll_t sync_file_poll(struct file *file, =
poll_table *wait)
> >   {
> >   	struct sync_file *sync_file =3D file->private_data;
> >  =20
> > +	/*
> > +	 * The POLLPRI/EPOLLPRI flag can be used to signal that
> > +	 * userspace wants the fence to signal ASAP, express this
> > +	 * as an immediate deadline.
> > +	 */
> > +	if (poll_requested_events(wait) & EPOLLPRI)
> > +		dma_fence_set_deadline(sync_file->fence, ktime_get());
> > +
> >   	poll_wait(file, &sync_file->wq, wait);
> >  =20
> >   	if (list_empty(&sync_file->cb.node) && =20
>=20


--Sig_/PboreIUuM6gO6KQswv5Gd=N
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJQjwWQChkWOYOIONI1/ltBGqqqcFAmP0gxEACgkQI1/ltBGq
qqcMzA//UBA8OmgaplusdV3EYDrlm1XXYsndvhAJV/IPY3tPzwkjjE7dpf1TGYc+
Wh1kvzNelRPlU0RESGQSvNyKwwp+eipZ+ug3HzO6axTf5Rh9ptuUZaSok5mrX7do
U1fsZhDed9gsN/OqxOUoXgFnim0nOhFoyCRalgV6qQPmeiv18aExgbtV40bP8Qfw
h79kSBGfsW2tQOjY4qr4tVPWyL31lIABLdYY3dlxib/OAe1cjIR7Dc51yNMC2TUg
6jZetg0uDjv43YXnIqx/9kpv4RRt0kxUIukX5AiWQq7VIk0rXRKRORLXR1ri5u6m
VZglgER6KZnEZBN9Fy6GMgV6QlnUWcQ/kFY1Hz+nd2EQEYzwBX4Eclf2q5GtArYP
+ShkIkfXWNisIJ7q6f2xYITQ5cbYK7D1baTyHXKgsUBZnltomwaMqmkKOimhQTFB
5tXTTGqLjkwh2R1Sq9a+RklAMVn8IWgLn+dJw1CL69opfja5yLzpCplKgYgKCX6N
9fqPC0IH56Om+a+wD+QgzWMFvguhbAk57IWVeEMgu4Qv2urtMNVCN2Jz2qpKafYq
HKvfh7l900bwrndWtayCN+937hPhgtH/8lWB+0UmlG1EYwa4PK8lH2YNywnYi8ss
rkXY5kqLS3izynKUaRLfjysAVzC2LZYJBO3Hik6g/fjdh62JH0U=
=eI1y
-----END PGP SIGNATURE-----

--Sig_/PboreIUuM6gO6KQswv5Gd=N--
