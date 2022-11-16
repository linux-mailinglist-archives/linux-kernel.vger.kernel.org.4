Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A244462B55C
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 09:36:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238606AbiKPIgd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 03:36:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238779AbiKPIgZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 03:36:25 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D10D063A9;
        Wed, 16 Nov 2022 00:36:24 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id h193so15996610pgc.10;
        Wed, 16 Nov 2022 00:36:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vwLoi1Ok3PtF/ie+UOseiAZ/lHqLfRlgXaoL3yNNmwk=;
        b=HF5b3NXW6A2JETiEFQ3FaGUS1cNSxVJKcCziy8RK+QMEp9yWOWV+7UwjC9MNWfVlB4
         +DxC1/VuLbEJB9i9bFaGckqT/wVP5f9V/wiCj78vJyUHnkOed6hlmdF3p/5SkTrALGw3
         GjSjgAdFOK37wRHBsOU1WtIlE74y8qkg0xmrJP77RavUxkUeNvULWzIQURzGJ7wLR2uw
         8KXUjYODhb91Ba5Gj4XwaxD+5j4Rl5kbKeLaR/uTcCyE9DN2Hwi2qQHKVcxbA9WiEo9T
         fjOzrPSvxcRlDEu9RrkaNwugNIdSLNuUD8jZzbKkyUBL5e3380o9RkrGuIHyrN4pgBY4
         oIQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vwLoi1Ok3PtF/ie+UOseiAZ/lHqLfRlgXaoL3yNNmwk=;
        b=NLbBEOU96EId/FJvrZI2pCvjvMUldG4Q6dYLFU4h8BpSvkpt2hbcay+6dzilbpXnZd
         JSLvfWtPeSEoavTI9C8QEmzJ5gdTa7S24rJRqvljs/Ph4i51omiNduGnXbY5UYU2op/c
         LIKqo0qvXma+N2nIfrsVUZ63cJGHls0M2jU88s+SsApzZEiYepUtvfXmAxBTuGIRyXgx
         0f60dqDlyyKQjWENT9nyac9ba4LWrjPeSfbSAeSVaPP0Va71OJK5Nc64gjuJaamXA1xl
         PXrNhoambvGIHAUqJxnDNrbXPhKcP1bb4eH8icgsGMRLn2Aqtxba+6TbbWJdM6bZuZbS
         v2ug==
X-Gm-Message-State: ANoB5pn1UOtpzPNlUbW3Q0yZoLbN43iaqcw4/0mCnuYV3PuYQg7SF6g5
        LC9HQEiFr5pazA/mWQN5Cq8=
X-Google-Smtp-Source: AA0mqf70ENAI2GXTQESEBn98H9BphkY+lxz1HVk+iUpruXANF2kjaxXeIU/FQfYaGla6vXQvox3NkQ==
X-Received: by 2002:a65:6107:0:b0:43c:758:5190 with SMTP id z7-20020a656107000000b0043c07585190mr19699472pgu.339.1668587784291;
        Wed, 16 Nov 2022 00:36:24 -0800 (PST)
Received: from debian.me (subs02-180-214-232-81.three.co.id. [180.214.232.81])
        by smtp.gmail.com with ESMTPSA id t7-20020a635347000000b0046fe244ed6esm9042017pgl.23.2022.11.16.00.36.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 00:36:23 -0800 (PST)
Received: by debian.me (Postfix, from userid 1000)
        id 7A448103FF6; Wed, 16 Nov 2022 15:36:20 +0700 (WIB)
Date:   Wed, 16 Nov 2022 15:36:19 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Qais Yousef <qyousef@layalina.io>
Cc:     kernel test robot <lkp@intel.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Lukasz Luba <lukasz.luba@arm.com>,
        Xuewen Yan <xuewen.yan94@gmail.com>, Wei Wang <wvw@google.com>,
        Jonathan JMChen <Jonathan.JMChen@mediatek.com>,
        Hank <han.lin@mediatek.com>, Paul Bone <pbone@mozilla.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: Re: [PATCH] Documentation: sched: Add a new sched-util-clamp.rst
Message-ID: <Y3ShA8SGM4PTYPLJ@debian.me>
References: <20221113152629.3wbyeejsj5v33rvu@airbuntu>
 <Y3ICaCPX61EOn/KN@debian.me>
 <20221115205547.3f4kzig5r44ipv3b@airbuntu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="HFCAWN1oLQKieb8/"
Content-Disposition: inline
In-Reply-To: <20221115205547.3f4kzig5r44ipv3b@airbuntu>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--HFCAWN1oLQKieb8/
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 15, 2022 at 08:55:47PM +0000, Qais Yousef wrote:
> > >  2.1  BUCKETS:
> > >  -------------
> > > =20
> > > +.. code-block:: c
> > > +
> > >                             [struct rq]
> > > =20
> > > -(bottom)                                                    (top)
> > > +  (bottom)                                                    (top)
> > > =20
> > > -  0                                                          1024
> > > -  |                                                           |
> > > -  +-----------+-----------+-----------+----   ----+-----------+
> > > -  |  Bucket 0 |  Bucket 1 |  Bucket 2 |    ...    |  Bucket N |
> > > -  +-----------+-----------+-----------+----   ----+-----------+
> > > -     :           :                                   :
> > > -     +- p0       +- p3                               +- p4
> > > -     :                                               :
> > > -     +- p1                                           +- p5
> > > -     :
> > > -     +- p2
> > > +    0                                                          1024
> > > +    |                                                           |
> > > +    +-----------+-----------+-----------+----   ----+-----------+
> > > +    |  Bucket 0 |  Bucket 1 |  Bucket 2 |    ...    |  Bucket N |
> > > +    +-----------+-----------+-----------+----   ----+-----------+
> > > +       :           :                                   :
> > > +       +- p0       +- p3                               +- p4
> > > +       :                                               :
> > > +       +- p1                                           +- p5
> > > +       :
> > > +       +- p2
> >=20
> > The code block above is diagram, isn't it? Thus specifying language for
> > syntax highlighting (in this case ``c``) isn't appropriate.
>=20
> I could do with a helping hand here actually. I am a text only person but
> trying to follow the new rst docs; but I don't have a clue to be honest.
>=20
> I did try to find the right directive, but I couldn't find it. What shoul=
d be
> specified for this diagram?

Just leave ..code-block:: directive alone or use simpler double colon
(::). The highlighting will not be applied to the code snippet.

> > > @@ -200,6 +203,8 @@ The rq has a bucket for each uclamp_id: [UCLAMP_M=
IN, UCLAMP_MAX].
> > >  The range of each bucket is 1024/N. For example for the default valu=
e of 5 we
> > >  will have 5 buckets, each of which will cover the following range:
> > > =20
> > > +.. code-block:: c
> > > +
> >=20
> > Again, why ``c`` syntax highlighting?
>=20
> This is a C code snippet. What would be better to use? I think I was gett=
ing
> errors if I don't specify something. But again; I was touching my way aro=
und in
> the dark here trying to figure it out.
>=20

Yup, that's the correct language for highlighting.

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--HFCAWN1oLQKieb8/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCY3ShAwAKCRD2uYlJVVFO
owYHAQDa8a84KtchgyJpx4axzQ+iluhGd5lM2NDhW2nye7ml+wEA1hgSmjfRoTC7
Zem7z+npTY/PWdm1wxsK7MjCCi30aQ0=
=imkl
-----END PGP SIGNATURE-----

--HFCAWN1oLQKieb8/--
