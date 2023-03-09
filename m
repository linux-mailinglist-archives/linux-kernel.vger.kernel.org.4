Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DAB16B2ED1
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 21:40:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229580AbjCIUks (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 15:40:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbjCIUko (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 15:40:44 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 989E1E841C
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 12:39:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678394398;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zeMyLQ59ICXaR3k0fXJSK8w4EuWIRJHEotPWxBc3jeE=;
        b=f5sKTEgT79tXTnbDv8cU6vAaQC8NLMnPsxT50EpBTu85qtzezMrSXvZECMRpCcZ69LQOdG
        eqiHbBEQw+0xAQNzyl8oUTxC4Ewe3J6lg0HBsfWGkjplIZ5ayhTkYrTU6wr/xiWpYwG5v+
        t0bMvWYGzcpqGyAdV8mLEs9VF5idwpo=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-638-qr3W7Z7iNO2j_fLpMfg2OA-1; Thu, 09 Mar 2023 15:39:57 -0500
X-MC-Unique: qr3W7Z7iNO2j_fLpMfg2OA-1
Received: by mail-lj1-f200.google.com with SMTP id z12-20020a05651c11cc00b002935008af2aso992370ljo.19
        for <linux-kernel@vger.kernel.org>; Thu, 09 Mar 2023 12:39:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678394396;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zeMyLQ59ICXaR3k0fXJSK8w4EuWIRJHEotPWxBc3jeE=;
        b=NVgwPWqPaa0Kiy+flUHCVNr6ezcJsEo6KI8I/Do5GMShQ0YNiGFh9Ofamp1KcrubAf
         ekc0kqS+XHj5Usrsv04lZSiQwUFTQ9/jyjfulZbFgSbVQXsbjePiCQ/9WzpXzOBf9PKW
         odqLxY7LU7v8332Gn98gtnfqsq8fDevP0YgqgRYedWsMv2HE/8FFy898s56lOBv9W/ZP
         J6ZeL3XRuwH7IsILbuyfRx2D2SYWlPpW4tZCDB20wZ1rzpXU1VDHArL3O/xQdbWtNBG+
         9uC5WODuMla4+ju56SRHZDQ5xp/t3Ke9a2PpuPZJiLuIhKZZ3hayXPO/c5bNMldJ/sVA
         V8nw==
X-Gm-Message-State: AO0yUKXHmDuvRiQ7lAF1yiI9wyxImoLsugwCMOqIYiCUHsciDMICiUG5
        yyfP2ggZj2QDGDA3l/uZJReH5qd0MhPC0Xlf6BOtR+KgFgSiBMYEfuySdzDbwbXgxnqoerDidYp
        usQVASuePQQgezczSsl9BHHF4l9AfcvvZ1z9INor8
X-Received: by 2002:a05:6512:24f:b0:4dd:fd4e:5a21 with SMTP id b15-20020a056512024f00b004ddfd4e5a21mr7221189lfo.11.1678394396018;
        Thu, 09 Mar 2023 12:39:56 -0800 (PST)
X-Google-Smtp-Source: AK7set8Ggw77nlrwunPRgDCpaIaB7tQGweTebDCE7OESc24dT5ASfvD1foGPomTGYfbg4tMplkm2UwvTs8/qSogzdS0=
X-Received: by 2002:a05:6512:24f:b0:4dd:fd4e:5a21 with SMTP id
 b15-20020a056512024f00b004ddfd4e5a21mr7221181lfo.11.1678394395659; Thu, 09
 Mar 2023 12:39:55 -0800 (PST)
MIME-Version: 1.0
References: <20230307-rust-drm-v1-0-917ff5bc80a8@asahilina.net>
 <20230307-rust-drm-v1-1-917ff5bc80a8@asahilina.net> <D9Cyx-9kbjaeb8QVBFqapDyctoDdVyu5uXEJDR41sdXUDXM1VgdRicV5huJDwfC3-T2J-R_DYHH8JZ1_aRdgbeYZFT78J9QveeeYbiTq4yU=@protonmail.com>
 <11ce9291-c17f-e73d-fb5d-13d5386fe6be@asahilina.net> <c9e0c6fdcd642192a59a2fea95941a773ea7b3e3.camel@collabora.com>
In-Reply-To: <c9e0c6fdcd642192a59a2fea95941a773ea7b3e3.camel@collabora.com>
From:   Karol Herbst <kherbst@redhat.com>
Date:   Thu, 9 Mar 2023 21:39:43 +0100
Message-ID: <CACO55tukF-+HWUHve0YUPbq4jPFgU3szuedKLjAw55h_3uX5gg@mail.gmail.com>
Subject: Re: [PATCH RFC 01/18] rust: drm: ioctl: Add DRM ioctl abstraction
To:     Faith Ekstrand <faith.ekstrand@collabora.com>
Cc:     Asahi Lina <lina@asahilina.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Luben Tuikov <luben.tuikov@amd.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Ella Stanforth <ella@iglunix.org>, Mary <mary@mary.zone>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        rust-for-linux@vger.kernel.org, linux-media@vger.kernel.org,
        linaro-mm-sig@lists.linaro.org, linux-sgx@vger.kernel.org,
        asahi@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 9, 2023 at 9:24=E2=80=AFPM Faith Ekstrand
<faith.ekstrand@collabora.com> wrote:
>
> On Thu, 2023-03-09 at 15:04 +0900, Asahi Lina wrote:
> > On 08/03/2023 02.34, Bj=C3=B6rn Roy Baron wrote:
> > > > +                            // SAFETY: This is just the ioctl
> > > > argument, which hopefully has the right type
> > > > +                            // (we've done our best checking the
> > > > size).
> > >
> > > In the rust tree there is the ReadableFromBytes [1] trait which
> > > indicates that it is safe to read arbitrary bytes into the type.
> > > Maybe you could add it as bound on the argument type when it lands
> > > in rust-next? This way you can't end up with for example a struct
> > > containing a bool with the byte value 2, which is UB.
> >
> > There's actually a much bigger story here, because that trait isn't
> > really very useful without a way to auto-derive it. I need the same
> > kind
> > of guarantee for all the GPU firmware structs...
> >
> > There's one using only declarative macros [1] and one using proc
> > macros
> > [2]. And then, since ioctl arguments are declared in C UAPI header
> > files, we need a way to be able to derive those traits for them...
> > which
> > I guess means bindgen changes?
>
> It'd be cool to be able to auto-verify that uAPI structs are all
> tightly packed and use the right subset of types.  Maybe not possible
> this iteration but it'd be cool to see in future.  I'd like to see it
> for C as well, ideally.
>
> ~Faith
>

I'm sure that with a macro you could verify that a struct definition
doesn't contain any gaps, just not sure on how one would enforce that.
Could add a trait which can only be implemented through a proc_macro?
Maybe we can have a proc_macro ensuring no gaps? Would be cool tech to
have indeed.

