Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14D446D7CA8
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 14:32:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238020AbjDEMc1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 08:32:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237375AbjDEMcZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 08:32:25 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D6E31BC5;
        Wed,  5 Apr 2023 05:32:24 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id m16so21954373ybk.0;
        Wed, 05 Apr 2023 05:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680697943;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SQcMbra2CgBD1rOvxGpRVnkzaGjn0KHujzI1BY777uY=;
        b=MkV5dExLiNqHfiYmWMuvch56083VrvbatouYUkL58SSm+WrMUvsdZSE3XxB3d8jeJf
         EK33MHkqG3MELcpSeqXzpH2whK3o8Lmx0GixFiv1YWYv+7tRaeIgngnfWuJ/dlYntL3q
         5EMAWmxeenJFRgI1bH3bR+6XbKuOpqI4Hockj/fOTVKrWkTCss31mmnSsukYKg1k+IqN
         OkLaehmee/JjhR7r8W8jnPHDsXhFzcqjzFr6Z2qWPssKR8xHf9IYTgj2dDtB5ES4viLg
         7lFMhaiKVbLFTNAbOFF+3ByTplR68WQgItjc+07KNEyaqeeqNZwZ4frv2WtLxz60hAz8
         3V2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680697943;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SQcMbra2CgBD1rOvxGpRVnkzaGjn0KHujzI1BY777uY=;
        b=ol7j5E8ufFI1Fuv8+OTBBCVmw9aX0iEOHuaTeD3Yyadn8VBuFAPFJW6uFuUwRIuFzq
         JdHQpbmF9dM2IQ8jzRcVyybSOufJXB/SNgdRco2Nz6mmx9lv8M/m/gnGZAzm2be0ORcf
         WPEKIDTswlVriJmekt9QoXZe82LrzWmBvRKnuCsdfSfse3KJDdddXRnz/dPRiLRDWXRE
         AHvdmiwXR12aSfvWKFm3qo98yUETJ4JLgxb3HyWCpGcBin9KcGlAQsI5S9PjQj327+VL
         2hD894W/Gu1/KJ1WjElCN3ultkverTw03WOuFtLyh7Nkf2HPB3XM6IZ44B+h6ygfRITE
         sLKQ==
X-Gm-Message-State: AAQBX9eFfm3AXwv1xhLFo2LZBTGyin9XRVilBtmJeSAJLl99m64txkDu
        lkxFooG9nLclzwLEyKQQI8kvixiH0mkOEQYL8yU=
X-Google-Smtp-Source: AKy350aMnNZlfVQMcWZwmVtFWd+CgIw1TUjVeCFV7ElU/MTu09D8SpK7RVipDHvOLoDOmHM2e3Wga5qC1FlXouLi1XY=
X-Received: by 2002:a25:774d:0:b0:b80:2bf9:2f78 with SMTP id
 s74-20020a25774d000000b00b802bf92f78mr4111595ybc.11.1680697943516; Wed, 05
 Apr 2023 05:32:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230307-rust-drm-v1-0-917ff5bc80a8@asahilina.net>
 <20230307-rust-drm-v1-4-917ff5bc80a8@asahilina.net> <ZC1WwJDr1iqSQnYs@phenom.ffwll.local>
 <CANiq72=h9qKrpkY2K962__rs-JLsmWxPXocx040ZeDSKGf_Brw@mail.gmail.com> <ZC1aEZpgZLkq8xTv@phenom.ffwll.local>
In-Reply-To: <ZC1aEZpgZLkq8xTv@phenom.ffwll.local>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Wed, 5 Apr 2023 14:32:12 +0200
Message-ID: <CANiq72=hoVw566orbDYcJyw2+SFfxpR1rdJVbbR3kkrjJUASww@mail.gmail.com>
Subject: Re: [PATCH RFC 04/18] rust: drm: gem: Add GEM object abstraction
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Asahi Lina <lina@asahilina.net>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Luben Tuikov <luben.tuikov@amd.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Karol Herbst <kherbst@redhat.com>,
        Ella Stanforth <ella@iglunix.org>,
        Faith Ekstrand <faith.ekstrand@collabora.com>,
        Mary <mary@mary.zone>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org,
        linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
        linux-sgx@vger.kernel.org, asahi@lists.linux.dev
Cc:     Daniel Vetter <daniel@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 5, 2023 at 1:23=E2=80=AFPM Daniel Vetter <daniel@ffwll.ch> wrot=
e:
>
> Ok if this is just interim I think it's fine. Would still be good to have
> the MAINTAINERS entry though even just to cover the interim state. Least
> because I'm assuming that when things are split up you'd still want to
> keep the rust list on cc for the rust parts, even when they move into
> subsystems?

Sorry, I missed to reply the second part of your email -- replying here.

Currently, the subsystem's code is under `rust/` (though modules can
go already into other folders). One of the reasons was technical
simplicity, and a nice side effect is that we could bootstrap things
while getting C maintainers involved over time.

To accomplish that, the guidelines for contributing Rust code are that
the respective maintainers need to be at least Cc'd, even if the files
do not hit the `F:` fields for the time being -- see [1]. But, for us,
ideally, the maintainers will take the changes through their tree,
instead of going through the Rust one, since that is the end goal.

And, of course, if you already want to have `F:` fields for the Rust
code, that is even better! (Whether those should be in the same entry
or in a new one, it is up to you, of course, and whether it is a
different set of people / level of support / etc.)

Then, when the `kernel` crate split happens, we can move the code
directly under whatever folders it should be naturally, when their
maintainers are ready. For some subsystems, that may mean they do not
need any `F:` fields since they are already covered (e.g. if they did
not create a new entry for Rust code only). And for cases like yours,
where you already had `F:` fields, it means the move of the files can
be done right away as soon as the split happens.

In short, we would definitely welcome if you add `F:` fields already
(whether in existing or new entries) -- it would mean you are ahead of
the curve! :)

As for the mailing list, yes, for the time being, I ask that all
changes to please be sent to the Rust list, so that everybody that
wants to follow the Rust progress has everything in a single place, so
that we try to remain consistent in the beginning on e.g. coding
guidelines, so that Rust reviewers can help spot mistakes, and so on
and so forth.

But, as Rust grows in the kernel, as systems become non-experimental,
and as maintainers take ownership of the code, that should eventually
go away and let things be as usual with C code. Then the Rust
subsystem (and its list) will become smaller, and it will be the
subsystem (and the discussion place) for anything not covered by other
subsystems, such as core Rust abstractions and types, Rust
infrastructure and so on.

How does that sound?

[1] https://rust-for-linux.com/contributing#the-rust-subsystem (I may
reorganize this to be Rust's `P:` field, by the way)

Cheers,
Miguel
