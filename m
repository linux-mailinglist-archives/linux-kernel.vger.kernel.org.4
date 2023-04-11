Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87E4E6DDA35
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 14:02:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbjDKMCe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 08:02:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjDKMCb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 08:02:31 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 626AF2D48;
        Tue, 11 Apr 2023 05:02:29 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-54c12009c30so260600497b3.9;
        Tue, 11 Apr 2023 05:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681214548; x=1683806548;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ed7arILbQ+stDRGb56PqaQ+j9TQJHYphyg1/PYzOzmk=;
        b=Rwzq71gbowUoM1rvXcOluWBU+VCGjiqx7m3L1o5hn8j/rSPX63A5ROU62NLYNp8f3t
         ZMn4wS9oGTB+Aq+cHjzNqbpzdGhHfimD9LFSr7wP79I5AzQzrUvHz+fm6SRkZwFdrO4Y
         29w2UtSlrUWIk8HTzjWVqvOsGsqFl8V4PNsZ06tMAEHyd0p+ZywHif+XCKkiRvmcvHTb
         LGM269EiBhnrGjCnPefeix7Aeqy99y0isbvsLzff/tXL8rBrfemZCjLc2LO4URwa9ygz
         ZJimYqA1ZtgSvruHRkaRARcX856JhE/E9BilkCC9pDdjMzT4PzeQX9jrsAXihK1OljAt
         l3+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681214548; x=1683806548;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ed7arILbQ+stDRGb56PqaQ+j9TQJHYphyg1/PYzOzmk=;
        b=xUvaXyH3bNVFsvvnHgGW77ZzXi0k5JED7kIEtlmOURh68LumBx6Liv1nhddlYEyOEq
         wn6ExwtVUiY42f0ixHpJnZA1xo93+VASQoLMgXJfplM9mf3LJP2n6jgKSfd1QjXePzFi
         +DqW5M2riCNAEkIl5RcddXeG08I0Yc6sSCfUFePdhi8+YRsC0D1WjailZvyCqJg7yrDA
         ss5HPbPPkjXGUHB6LCTWzSTwoEyq1mtp9Mbse4+GJl/ykL0M1BNUF81WJVbT4szhF1o1
         Z9lkEuYB2tCNG27j0khqUQlGdKLY0H3hU94KJUI+bbGjTD6s7Yqw0XHw8l90gtLC7Gbc
         8GGQ==
X-Gm-Message-State: AAQBX9d5mPqo3ByXsgU9XRcticY+VClmOlHYOYNR7ABsfx8weJs9gaI/
        zILKt6FxHhUloZXuA7qod2Z6Z8vkGAgkokPOQbDVR6FaTQc=
X-Google-Smtp-Source: AKy350bTta5wlLDVlBVYshj5v4fpgjnfKMPomn04Qb5vKkFkokQQY8rUGHNvQAkn5ODnufUsqE9RZ2CCKKgwhLJfb0g=
X-Received: by 2002:a81:a887:0:b0:546:63a:6e23 with SMTP id
 f129-20020a81a887000000b00546063a6e23mr1594858ywh.0.1681214548487; Tue, 11
 Apr 2023 05:02:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230406215615.122099-1-daniel.almeida@collabora.com> <136035a4-26df-1c14-e51e-406b4ee5fe33@xs4all.nl>
In-Reply-To: <136035a4-26df-1c14-e51e-406b4ee5fe33@xs4all.nl>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Tue, 11 Apr 2023 14:02:17 +0200
Message-ID: <CANiq72kzgopREcNcAnjCBk2u9b9cJ4f_jPix6LWYSkcOV5kubw@mail.gmail.com>
Subject: Re: [PATCH 0/6] Initial Rust V4L2 support
To:     Hans Verkuil <hverkuil@xs4all.nl>
Cc:     Daniel Almeida <daniel.almeida@collabora.com>, wedsonaf@gmail.com,
        ojeda@kernel.org, mchehab@kernel.org,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, kernel@collabora.com
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

On Tue, Apr 11, 2023 at 9:51=E2=80=AFAM Hans Verkuil <hverkuil@xs4all.nl> w=
rote:
>
> One of my main concerns here is time: as subsystem maintainers we can bar=
ely
> keep up with all the incoming patches. Introducing support for a new lang=
uage
> would add only more pressure. Even though these are mainly bindings (as I
> understand it), this would still require that every change to a C kAPI is
> duplicated in rust, requiring someone to do that work, and have maintaine=
rs
> with enough rust knowledge to verify it.

Indeed, that is one of the main costs.

One potential solution is to have somebody step up as the maintainer
of the Rust side (e.g. the author of the abstractions).

Of course, that will not make the work go to zero, since there still
needs to be some degree of communication even if the new maintainer
does all the Rust side work, but it may make it feasible, especially
if the abstracted parts of the C API do not change too frequently.

It is also an opportunity for existing maintainers to see how the Rust
side would work meanwhile the work gets done, and potentially a chance
to get a new maintainer involved with the whole subsystem in the
future.

Some subsystems may want to give that maintainer a different
`MAINTAINERS` entry, e.g. as a child subsystem that sends PRs to the
main one and may be marked as "experimental". This is also a way to
see how the new abstractions work or not, giving maintainers more time
to decide whether to commit to a Rust side or not.

I don't mean to say it would be doable for the media subsystem, but
please consider it.

Cheers,
Miguel
