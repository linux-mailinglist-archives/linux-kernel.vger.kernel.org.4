Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF10D6D7B15
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 13:20:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237845AbjDELUV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 07:20:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237835AbjDELUT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 07:20:19 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD57C527F;
        Wed,  5 Apr 2023 04:19:59 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-54601d90118so514767947b3.12;
        Wed, 05 Apr 2023 04:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680693599;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OVTqfRf2jpWEeoD6UNL26R0hpOD3j9XRAva3jj9aVBk=;
        b=UMTYBNcPhbAF0ABt8KophwzX/Ny6OPNn+L6EnmU5IkTiR+fwtjtTvvmlWyMYj3Pkd/
         c/AorgHXggjcy/x5fLftLDXcSRee6X3AtQ1pW2rCBk6CYlNeeb39l9Sc0PgP3d01I3hi
         qodJYbUqCHZ235SHXXOkTEXGGEHXyT2WxYP95YphXmCso64A4JEn5pUvLQzjn8+qM2mo
         ffZ5LUVWgPBrcIjs91pPf+lKHjgH0EcvEuCyvhchd69BLf5uIsTKD4aB1cF0OsfHG7q9
         zt9q5kpD8Hxo6x9MnvBm6HE/Ec1pZ6n+yeI3K4SLL9P/DBFTyptpplVjTZnPhcQNN5G2
         eRLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680693599;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OVTqfRf2jpWEeoD6UNL26R0hpOD3j9XRAva3jj9aVBk=;
        b=gnGsyHt0/baNqTyypBgsi4Nih6MEvvXIh2FBDoRoLxGkshOE67aoIv01kk/AAOIdRR
         Qn8FlkRX/zD9AmJp3+r0GQhweb1y36HFE/HhcW+9UuJKC8cypaAEYBIaZ33eD7ymmiMG
         TTLB+is/WT63/LPnTrppQaZcYzKYqRR+RtBVJG5+Du2nEAf89ZFeAFPBMvWAB4BfoZvR
         T8au+r5GJw8PaBYVf53iFB5OWV7dQ9cm2b6oR4E2y+eXAxTdD11iwy9RuaWVjV6fdCNo
         pYBRItOhRcAwIzfhKFEPzAnYjDbZVH8CuJYi7Z4Vu6ULsHx8idV6rA0pjdtDECwPz0Ws
         ogjA==
X-Gm-Message-State: AAQBX9daecNUAAaCSOw0oTUHKKQ/Erg+Ya9I3nThUxJ4SCvD9Je5gm37
        N9/pNS67O/jdZ6Z+/KdEKExq0dKOoi+W+xRJmJg=
X-Google-Smtp-Source: AKy350bbnQi/kk0Ucraeyifb8HGzxmDoYIzCbR5PfgN3LBUwsGHhS/jbvYqgxE1Tugt8wPoVLCb1KVJOEW5vVrBJUTs=
X-Received: by 2002:a81:c509:0:b0:52e:e095:d840 with SMTP id
 k9-20020a81c509000000b0052ee095d840mr3519608ywi.0.1680693598783; Wed, 05 Apr
 2023 04:19:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230307-rust-drm-v1-0-917ff5bc80a8@asahilina.net>
 <20230307-rust-drm-v1-4-917ff5bc80a8@asahilina.net> <ZC1WwJDr1iqSQnYs@phenom.ffwll.local>
In-Reply-To: <ZC1WwJDr1iqSQnYs@phenom.ffwll.local>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Wed, 5 Apr 2023 13:19:47 +0200
Message-ID: <CANiq72=h9qKrpkY2K962__rs-JLsmWxPXocx040ZeDSKGf_Brw@mail.gmail.com>
Subject: Re: [PATCH RFC 04/18] rust: drm: gem: Add GEM object abstraction
To:     Asahi Lina <lina@asahilina.net>,
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

On Wed, Apr 5, 2023 at 1:08=E2=80=AFPM Daniel Vetter <daniel@ffwll.ch> wrot=
e:
>
> Uh all the rust helper wrappers for all the kernel in a single file does
> not sound good. Can we not split these up into each subsystem, and then
> maybe instead of sprinkling #ifdef all over a .c file Make the compilatio=
n
> of that file conditional on rust support (plus whatever other Kconfig gat=
e
> the other c files has already)?

Indeed, the plan is splitting the `kernel` crate and giving each
subsystem its own crate, bindings, helpers, etc.

Cheers,
Miguel
