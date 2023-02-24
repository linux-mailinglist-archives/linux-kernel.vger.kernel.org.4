Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C03E6A1A2E
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 11:25:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230238AbjBXKZa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 05:25:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230208AbjBXKZE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 05:25:04 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ABD0658DB;
        Fri, 24 Feb 2023 02:24:18 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id z5so13685195ljc.8;
        Fri, 24 Feb 2023 02:24:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=wDkYu+Ebh7Mfld/mHVRq/UWL9vsWMTRce+Iu+ExRXcQ=;
        b=evq5P0zcDn8kbjSm2ItbVTOdU2UtNz3mnkM99UeQkXXtxqRQmt+OQ0NrXAU90yj7Kx
         GHlMEYLVJpR6RELzRwhSlzRgBwfta+m4jSqNhxwYtl4nYOyk9qzlSgdb2AelLpFsatPR
         SijU3e+3No3PgbPPU/YkqA4zByGnnA+WG/3VSylZuG4yubcjVlENCquRWHS+fQs+hDoM
         6xM0C+sSSTdw6QoI0cFhAu8Fc8E1OeJbe9w9lAmIcdjLDKuMpTTR5fBa+USyW+DM7ksy
         PlSMM39ZHyioQYwgnBLccw7JKX5n0E9xoG3ZSYObw2RahUmYti3GZ+4Zdbn9EXbiVcIT
         IPbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:references:in-reply-to:message-id:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wDkYu+Ebh7Mfld/mHVRq/UWL9vsWMTRce+Iu+ExRXcQ=;
        b=g3N0j0uc59W7c5s8UXIg55I7cACUu6uBZBeSK47xhYgz0qfAo1uqt40zJNB3ezBjgO
         VI1eANRZnvpPrSGlvs1YOOHcihPwb5VqUXQjXoEBlA3v38JXCfDEI6RSgBnW/ft6U3nn
         p4yJtCJ7C5dyCiBmDvAzWMl993hg2XA8KfOKkvYX7rfSoGfc8iwXKx+u8AEaq2TH4wAU
         FUiLZbIZXVm7FJE3SfURgK2Ez/pUdeGB7Wiem5JGlZ4uqNlyjTPsPcIxfVsqYDXpk6eA
         3ajHwOLqMNufPjDyfyw/anQda8zIPtYgK69x44FsHxraU28enCcWg3oaCTiWvHiHz290
         MqmQ==
X-Gm-Message-State: AO0yUKU+p3BSkqLpzOOubY0QOSGOE/tPWzI6Mcdk+7btZ+OlDMFBNkT0
        I3u3hVnki94MHmW8C0eB/GQ=
X-Google-Smtp-Source: AK7set+FtLn9Ue95zN2gWLFtDbqtjyIcYeEYUTUMXf4JDBznsvWiI7nTaSB0nhADsvF1lrrBmrClxQ==
X-Received: by 2002:a2e:a263:0:b0:28d:cca5:2193 with SMTP id k3-20020a2ea263000000b0028dcca52193mr5573592ljm.53.1677234247154;
        Fri, 24 Feb 2023 02:24:07 -0800 (PST)
Received: from eldfell ([194.136.85.206])
        by smtp.gmail.com with ESMTPSA id s18-20020a2e9c12000000b002945b04e1ebsm1312619lji.94.2023.02.24.02.24.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Feb 2023 02:24:06 -0800 (PST)
Date:   Fri, 24 Feb 2023 12:24:03 +0200
From:   Pekka Paalanen <ppaalanen@gmail.com>
To:     Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Cc:     Rob Clark <robdclark@gmail.com>,
        Rob Clark <robdclark@chromium.org>,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        Gustavo Padovan <gustavo@padovan.org>,
        Michel =?UTF-8?B?RMOkbnplcg==?= <michel@daenzer.net>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        open list <linux-kernel@vger.kernel.org>,
        dri-devel@lists.freedesktop.org,
        Sumit Semwal <sumit.semwal@linaro.org>,
        "moderated list:DMA BUFFER SHARING FRAMEWORK" 
        <linaro-mm-sig@lists.linaro.org>,
        Luben Tuikov <luben.tuikov@amd.com>,
        Christian =?UTF-8?B?S8O2bmln?= <ckoenig.leichtzumerken@gmail.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        freedreno@lists.freedesktop.org,
        Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        "open list:SYNC FILE FRAMEWORK" <linux-media@vger.kernel.org>
Subject: Re: [PATCH v4 06/14] dma-buf/sync_file: Support (E)POLLPRI
Message-ID: <20230224122403.6a088da1@eldfell>
In-Reply-To: <a47e2686-1e35-39a3-0f0c-6c3b9522f8ff@linux.intel.com>
References: <20230218211608.1630586-1-robdclark@gmail.com>
        <20230218211608.1630586-7-robdclark@gmail.com>
        <20230220105345.70e46fa5@eldfell>
        <CAF6AEGv9fLQCD65ytRTGp=EkNB1QoZYH5ArphgGQALV9J08Cmw@mail.gmail.com>
        <cdd5f892-49b9-1e22-4dc1-95a8a733c453@amd.com>
        <CAF6AEGuMn3FywPkEtfJ7oZ16A0Bk2aiaRvj4si4od1d3wzXkPw@mail.gmail.com>
        <20230222114900.1b6baf95@eldfell>
        <CAF6AEGs1_75gg+LCBj6=PH8Jn60PXiE+Kx_2636nP-+pajN8Hg@mail.gmail.com>
        <20230223113814.3010cedc@eldfell>
        <CAF6AEGuE89kuKTjjzwW1xMppcVw-M4-hcrtifed-mvsCA=cshQ@mail.gmail.com>
        <20230224112630.313d7b76@eldfell>
        <a47e2686-1e35-39a3-0f0c-6c3b9522f8ff@linux.intel.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Wv+B5cSZoeZxnThf_RuXZKn";
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

--Sig_/Wv+B5cSZoeZxnThf_RuXZKn
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Fri, 24 Feb 2023 09:41:46 +0000
Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com> wrote:

> On 24/02/2023 09:26, Pekka Paalanen wrote:
> > On Thu, 23 Feb 2023 10:51:48 -0800
> > Rob Clark <robdclark@gmail.com> wrote:
> >  =20
> >> On Thu, Feb 23, 2023 at 1:38 AM Pekka Paalanen <ppaalanen@gmail.com> w=
rote: =20
> >>>
> >>> On Wed, 22 Feb 2023 07:37:26 -0800
> >>> Rob Clark <robdclark@gmail.com> wrote:
> >>>    =20
> >>>> On Wed, Feb 22, 2023 at 1:49 AM Pekka Paalanen <ppaalanen@gmail.com>=
 wrote: =20
> >=20
> > ...
> >  =20
> >>>>> On another matter, if the application uses SET_DEADLINE with one
> >>>>> timestamp, and the compositor uses SET_DEADLINE on the same thing w=
ith
> >>>>> another timestamp, what should happen? =20
> >>>>
> >>>> The expectation is that many deadline hints can be set on a fence.
> >>>> The fence signaller should track the soonest deadline. =20
> >>>
> >>> You need to document that as UAPI, since it is observable to userspac=
e.
> >>> It would be bad if drivers or subsystems would differ in behaviour.
> >>>    =20
> >>
> >> It is in the end a hint.  It is about giving the driver more
> >> information so that it can make better choices.  But the driver is
> >> even free to ignore it.  So maybe "expectation" is too strong of a
> >> word.  Rather, any other behavior doesn't really make sense.  But it
> >> could end up being dictated by how the hw and/or fw works. =20
> >=20
> > It will stop being a hint once it has been implemented and used in the
> > wild long enough. The kernel userspace regression rules make sure of
> > that. =20
>=20
> Yeah, tricky and maybe a gray area in this case. I think we eluded=20
> elsewhere in the thread that renaming the thing might be an option.
>=20
> So maybe instead of deadline, which is a very strong word, use something=
=20
> along the lines of "present time hint", or "signalled time hint"? Maybe=20
> reads clumsy. Just throwing some ideas for a start.

You can try, but I fear that if it ever changes behaviour and
someone notices that, it's labelled as a kernel regression. I don't
think documentation has ever been the authoritative definition of UABI
in Linux, it just guides drivers and userspace towards a common
understanding and common usage patterns.

So even if the UABI contract is not documented (ugh), you need to be
prepared to set the UABI contract through kernel implementation.

If you do not document the UABI contract, then different drivers are
likely to implement it differently, leading to differing behaviour.
Also userspace will invent wild ways to abuse the UABI if there is no
documentation guiding it on proper use. If userspace or end users
observe different behaviour, that's bad even if it's not a regression.

I don't like the situation either, but it is what it is. UABI stability
trumps everything regardless of whether it was documented or not.

I bet userspace is going to use this as a "make it faster, make it
hotter" button. I would not be surprised if someone wrote a LD_PRELOAD
library that stamps any and all fences with an expired deadline to
just squeeze out a little more through some weird side-effect.

Well, that's hopefully overboard in scaring, but in the end, I would
like to see UABI documented so I can have a feeling of what it is for
and how it was intended to be used. That's all.


Thanks,
pq

--Sig_/Wv+B5cSZoeZxnThf_RuXZKn
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJQjwWQChkWOYOIONI1/ltBGqqqcFAmP4kEMACgkQI1/ltBGq
qqeCRxAAqanpfK5IEJqK3dr5TjSHmce5djy70aOvi5VrtvhiCjlrTYeNzWGWLe6V
zWvnrJHvvzM9h2YacC0aciEN5vJj5Xd6yVqWsigomejxIHFLkECtf8y4rAf7wtZ5
Vhg8NfSDlZkvA3hhFJ3fyQeS5pFAgTcUh0Xdpp5QPRwUmn5xf9CpCnXe48VUcBkN
hPp9m08eAhl3WkGVOhUexQ87MhEhwRKIyP8/bE5oKPLJJ3DuiaqSZnRPp9Wr6dt/
cMdI4tUfiyis7VPfoHX20LHgyoa74pg+5RWwcym5rYQ8SgC7jlzK7qQymHP6Y0O9
X3K/WrLozhfwbE8oWzX3DmSvnvGV08xdQDkcJn3ji2yr+clkE45NgUsGuIxcUx+v
2qbRV0CFh9m8Kgcj7pRgEghEsmn68dQKbe4iqvEKu3NoSiYf4JOEH9dvy4LQgKrO
Lwc3V4N0byVDCEzLQIZrDI/o7uBGPGDptrS0uxS2PGPAXyuNYUM10IV00yRa4UWv
eR/rild4lOkBE7PWWSoR9L2vvz8bFoMRkmTh2EAO/vEAL4iHY/fPpA30yVGYWTnA
PND65L7M/nZK9zsaihacyeI/qcWwvU4HCIbuvKBHaCA3ALw7XEEW+D/E9T7PQc5D
iwAmZ+Aelf0zTiBwWs42itu6XMQiUXY+XPubhNNtZIymjFVC/FE=
=rINc
-----END PGP SIGNATURE-----

--Sig_/Wv+B5cSZoeZxnThf_RuXZKn--
