Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 197ED6DE4E8
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 21:23:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbjDKTXe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 15:23:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjDKTXc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 15:23:32 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7074C65AB;
        Tue, 11 Apr 2023 12:22:56 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id y69so16261879ybe.2;
        Tue, 11 Apr 2023 12:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681240971; x=1683832971;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ukcprm4MtRUZ8SSk6iEMFicwVrkbDf1R8WwFeEURnh8=;
        b=hipGDRtfsSZLaiJPNi+pA9Ar1HO6B8FDUNQ66RZ/D0MJwP4R6DeUdH80mip6LiPXUM
         e7F1ltJL7D1bWOpQs1l1LI/dWu3+O0tyiFlB+iQpfx5QSUS54WRuuTXwL2XbE9EG3I6C
         O8hN6r2gVJjMaMcOQW832veY1oLMVF3O9FlDfu+SEZ539Q5oIeYyoMs3C9EWjD6lem86
         h8pqKA+I4oFYzFBqhNmGUxMiQPffphr3tiN+/eQmKvswrpoouohiFHX5qHgkclEIdrH7
         iSybXat1kWa5+bc0b4PmqZ9hiLDipD1mCutsRtBK/nagWRf/HDSwbl8Bny5xLZABTBFn
         0wlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681240971; x=1683832971;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ukcprm4MtRUZ8SSk6iEMFicwVrkbDf1R8WwFeEURnh8=;
        b=KzUqN0FSJs3LO5ABEjcYpZ+8+DgGdQ61BEa2QKBEgA6SPivp0b/se0mcxpdd4dfIIf
         lZqx+bk567erkFTiqBqHLB1FUgEw58r8WniAmdarRqCBm3VbUNYYFpC2Uq7u7cMZIC0U
         O3NGer56huebXeze5SsZZ3OiEp/66AUORf8fHDNHovQqc2mNSLK3EpSQQaZbVqhMNMpK
         YStrYuvInb0FMeQI/hMm7o9Ib+8s7OYpIc2SKv76L/3F9xrxqYA7hOWJDRPVQDHRmmF3
         G6JnltsI1vO88HBtH5P3M73+IOJ70ooA7e9Rsgv5jufZZ5+NP8S7MFxEqW8rO27bBP8w
         QyxA==
X-Gm-Message-State: AAQBX9ci2XgS81OGfWD2xEBhQReG+BO+bFzvloN005STz7sg5krlFrIY
        jH7LNKaRNU5ZVmnSfyopzJ5assHNXPrdmrJA94M=
X-Google-Smtp-Source: AKy350a8Fb4jXbSRnyKjTHLpgFd/b2sdAHA+d+9PTx67HoSAK/6KfCZs3WVdagU0OtBgB7lNyhTAq8Bzx7Bb8pLuxQg=
X-Received: by 2002:a25:df88:0:b0:b8f:3647:d757 with SMTP id
 w130-20020a25df88000000b00b8f3647d757mr158847ybg.11.1681240971586; Tue, 11
 Apr 2023 12:22:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230406215615.122099-1-daniel.almeida@collabora.com>
 <441a96cb-7dd1-0885-df64-933ebdb55e9e@selasky.org> <0ec4becd05c49e8f0bf214fbd62208ea67c2b4c3.camel@collabora.com>
 <6fc0a0c6-a7c9-5350-9b9e-1ea9dab568d0@selasky.org> <CANiq72m812+L6dc4Qs2wUXW85eBQwgrjWYYKc1MSsqN5AG_sFw@mail.gmail.com>
 <9f896097-8410-4d09-b614-6e792b2160f4@selasky.org> <CANiq72mv2uYe1x6cy4zUq8XHhAZcYYpt6hVXMG4yQZeqw1kY7Q@mail.gmail.com>
 <1d50d25c-e64b-01f4-029f-8b40b46848fd@selasky.org> <CANiq72mbM+WBcvj1TwU2u9kLz=EucLhLR-a5nzZEDa7VJ0s2_A@mail.gmail.com>
 <ca17f815-5779-d37c-e3f8-2a6c2983fe45@selasky.org>
In-Reply-To: <ca17f815-5779-d37c-e3f8-2a6c2983fe45@selasky.org>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Tue, 11 Apr 2023 21:22:40 +0200
Message-ID: <CANiq72mn1nD38DGHpFQzerC=_ifR39Vpbb_PzLv5Q75SdzTxQg@mail.gmail.com>
Subject: Re: [PATCH 0/6] Initial Rust V4L2 support
To:     Hans Petter Selasky <hps@selasky.org>
Cc:     Daniel Almeida <daniel.almeida@collabora.com>, wedsonaf@gmail.com,
        ojeda@kernel.org, mchehab@kernel.org, hverkuil@xs4all.nl,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 11, 2023 at 5:33=E2=80=AFPM Hans Petter Selasky <hps@selasky.or=
g> wrote:
>
> Similarly rustc may depend on an incorrectly specified ioctl()
> definition, also via other libraries and static linking, that just have
> to stay incorrectly defined, because it was initially incorrectly defined=
.

Why would a compiler depend on random ioctls? Even if it did, how is
that related to the previous discussion? A compiler is just one more
userspace application. Whether the kernel uses C or Rust internally
has nothing to do with that.

Also, I don't follow your logic. You said you cannot upgrade your
toolchain (for some reason), and your argument is that the kernel
keeps interfaces stable? Well, yes, that is the point and what allows
you to upgrade.

Moreover, what is special about `rustc` here? What about your C toolchain?

> I'm trying to explain something difficult. And I'm OK that you neither
> understand nor agree about my viewpoint. See my replies above.

No, it is not a matter of being difficult. It is just that you have
not shown how you would be prevented from upgrading a toolchain.

Cheers,
Miguel
