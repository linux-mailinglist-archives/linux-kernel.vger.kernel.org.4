Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20E986DCE3D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 01:42:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230089AbjDJXmC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 19:42:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbjDJXmA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 19:42:00 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A00E01BC7;
        Mon, 10 Apr 2023 16:41:58 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id z9so6304319ybs.9;
        Mon, 10 Apr 2023 16:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681170118; x=1683762118;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2wHFed80X0tDB7uZIMKZwq8AtXe8sVS2+RdD7BlqWJ0=;
        b=NCUGnMiSZ6pkOvrhy1awB8Mp0kC037Dn24U2kKhyGY5arhtIoF9JOwTtLLjDJ29ghK
         HYRyjAGHdHWiXtmvajuzgBLBiqilfiW793sO/A6iZ/X180NQHkynsurfdnKu05S3eDHm
         vr8oPf7qw2lSgtsiIyisxUEKfwMJTtOafdBFp8TpFUTqmjJvlPPnaGEaqSu9ntn+GgLk
         nsHbVPZbnZRciTdWSU5W3dObfxn5xnThdw3HGLL0iL0BynQ23ZltxCTxyOVRGcXLq5Nj
         aqIaU/8jC9dAl5X/0f99buX8CfzRYIFT9qUEIgYmUADWs4e8BILhiDprhpdZiCogWxyw
         BvFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681170118; x=1683762118;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2wHFed80X0tDB7uZIMKZwq8AtXe8sVS2+RdD7BlqWJ0=;
        b=79nF2l4ufsgDeuPOgJ5H+pCPIzPP5XEI8oOq9xPFqk3cwEfE8Uoz5rraMiLPWIShfp
         xzxs8pgLtPO6LPmSuNbWSw4PMq2OSW9AE9z65/C8z5zo18fhctyryR8jynJD1vP6sZfq
         yIbQYuH0AzQrRiz7KU+0isQWtv3E07bXKDKMULF/4ppWd6LLWB5BNL1vTMX2dFcZsHpV
         r6hua0PxRQUh9uk0T2kTKRF8uAugLYGsWKu8+kpgh8YLGgWVhqzhkGhjsymS5MKkeCNr
         DeJ+ts96iSEKQqZDbxd2PlXHW6J/K10X4WjDXYNdsFZX24josOpVsRtZSkvBFlIyXEyq
         fiLg==
X-Gm-Message-State: AAQBX9cZ/xMK6hxM36uLf7S1Ef1UMYxWUOwIS8tPfUIt7ACshJQEEgGu
        fKUgdM1ouvhO2LXzW8ReuqRHAv3/Zj8zISOTOEQ=
X-Google-Smtp-Source: AKy350ZMKc++209kJg1zVkgj3yQq/NKejP9VbGC6SebYPA8wazTUNWYAIGuf1hZCg27F8xbh7+svzQIL1y+oht0gyoI=
X-Received: by 2002:a25:e0d5:0:b0:b31:34ab:5ca0 with SMTP id
 x204-20020a25e0d5000000b00b3134ab5ca0mr4048180ybg.11.1681170117817; Mon, 10
 Apr 2023 16:41:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230406215615.122099-1-daniel.almeida@collabora.com>
 <441a96cb-7dd1-0885-df64-933ebdb55e9e@selasky.org> <0ec4becd05c49e8f0bf214fbd62208ea67c2b4c3.camel@collabora.com>
 <6fc0a0c6-a7c9-5350-9b9e-1ea9dab568d0@selasky.org>
In-Reply-To: <6fc0a0c6-a7c9-5350-9b9e-1ea9dab568d0@selasky.org>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Tue, 11 Apr 2023 01:41:46 +0200
Message-ID: <CANiq72m812+L6dc4Qs2wUXW85eBQwgrjWYYKc1MSsqN5AG_sFw@mail.gmail.com>
Subject: Re: [PATCH 0/6] Initial Rust V4L2 support
To:     Hans Petter Selasky <hps@selasky.org>
Cc:     Daniel Almeida <daniel.almeida@collabora.com>, wedsonaf@gmail.com,
        ojeda@kernel.org, mchehab@kernel.org, hverkuil@xs4all.nl,
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

On Mon, Apr 10, 2023 at 8:59=E2=80=AFPM Hans Petter Selasky <hps@selasky.or=
g> wrote:
>
> Adding a dependency to build the Rust compiler even to build one or two
> V4L2 device drivers, would mean a lot to my small hselasky/webcamd
> project. It already has to fetch a copy of the Linux kernel, and now has
> to bootstrap Rust from stage0 to stageN. I personally say no. It's like

Do you mean you need to compile `rustc`? Could you please explain why?
Could you use your distribution's, or fetch the standalone installers
or cache your own toolchain?

> XCode unfortunately. I download 100's of GBytes of upgrades to XCode,
> and barely upload one millionth worth of code back to Apple. It's not
> good. Software developers shouldn't have to download more stuff than
> they upload?

The Rust standalone installers are 2+ orders of magnitude lighter.

> The definition of "bugs" may vary of course. I was thinking more like
> stack exploits, missing validation of arrays and so on.

The kernel definitely needs to avoid those. What do you mean?

> I must admit I'm not a Rust guy and don't see the advantages of Rust
> like you do.

The advantages are fairly clear. The question has always been whether
the cost is worth those benefits.

> Why not move Linux-V4L2 drivers to user-space? In my opinion Rust is
> much more easy to get going there than at the kernel level.

That sounds like an orthogonal discussion.

In any case, please note that you would need to install the same Rust
toolchain to compile them in userspace. So, if you are concerned about
the size of the toolchain (as you mention above), it would not really
make a difference.

> Rust is slow based on my observations building Firefox from sources. The
> Rust compiler spends a significant amount of time per source file.

It is slower than compiling C, but it also provides more features, so
it seems fair for what we are getting in exchange.

Cheers,
Miguel
